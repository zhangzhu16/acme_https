#!/bin/bash

if [ $# -lt 1 ]; then
    echo "请输入省的英文简称!"
    exit 0
fi

pvc=$1
cd "/root/.acme.sh/${pvc}.csk.rhel.cc"

scp "${pvc}.csk.rhel.cc.cer" "${pvc}.csk.rhel.cc.key" "${pvc}:/tmp"
scp /root/.acme.sh/tmp_operat.sh "${pvc}:/tmp"

ssh ${pvc}
