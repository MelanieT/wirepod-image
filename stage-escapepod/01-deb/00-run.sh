CWD=$(pwd)

PATH=${STAGE_WORK_DIR}/go/bin:${PATH}

if [ ! -d ${STAGE_WORK_DIR}/WirePod ] ; then
    cd ${STAGE_WORK_DIR}
    git clone --recursive https://github.com/kercre123/WirePod.git
else
    cd ${STAGE_WORK_DIR}/WirePod
    git pull
    git submodule update --init
fi

cd ${STAGE_WORK_DIR}/WirePod/wire-pod
VERSION=$(git describe --exact-match --tags | sed -e "s/^chipper.v//")

cd ${STAGE_WORK_DIR}/WirePod/debian
./createdeb.sh ${VERSION}

mkdir -p ${ROOTFS_DIR}/opt/wirepod
cp ${STAGE_WORK_DIR}/WirePod/debian/final/wirepod_armhf-*.deb ${ROOTFS_DIR}/opt/wirepod/

cd ${CWD}

DEPS=$(dpkg -I ${STAGE_WORK_DIR}/WirePod/debian/final/wirepod_armhf-*.deb | grep "Depends" | sed -e "s/Depends://" -e "s/,//g" -e "s/ +/ /g" -e "s/^ *//")

rm -f ../02-install/00-packages

for dep in ${DEPS} ; do
    echo ${dep} >> ../02-install/00-packages
done
