if [ ! -f ${STAGE_WORK_DIR}/go1.21.13.linux-amd64.tar.gz ] ; then
    curl -s -o ${STAGE_WORK_DIR}/go1.21.13.linux-amd64.tar.gz https://dl.google.com/go/go1.21.13.linux-amd64.tar.gz
fi
rm -rf ${STAGE_WORK_DIR}/go && tar -C ${STAGE_WORK_DIR}/ -xzf ${STAGE_WORK_DIR}/go1.21.13.linux-amd64.tar.gz
