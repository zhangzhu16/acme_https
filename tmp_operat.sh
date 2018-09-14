#!/bin/bash

if [ $# -lt 1 ]; then
    echo "请输入省的英文简称!"; exit 0
fi

pvc=$1

ssl_cert_path=/etc/ssl/cert

if [ -f "${ssl_cert_path}/${pvc}.csk.rhel.cc.cer" ]; then
    rm "${ssl_cert_path}/${pvc}.csk.rhel.cc.cer"
fi

if [ -f "${ssl_cert_path}/${pvc}.csk.rhel.cc.key" ]; then
    rm "${ssl_cert_path}/${pvc}.csk.rhel.cc.key"
fi

mv "${pvc}.csk.rhel.cc.cer" "${pvc}.csk.rhel.cc.key" /etc/ssl/certs/


if [ -f "/tmp/custom.ini" ]; then
    rm -f /tmp/custom.ini
fi

gra_conf_path=/opt/fonsview/3RD/grafana/conf
if [ -f "${gra_conf_path}/custom.ini" ]; then
    mv "${gra_conf_path}/custom.ini" /tmp
fi

cd "${gra_conf_path}"

sed -i "s/protocol = http/protocol = https/g" defaults.ini

sed -i "s/enforce_domain = false/enforce_domain = true/g" defaults.ini

sed -i "s/domain = localhost/domain = ${pvc}.csk.rhel.cc/g" defaults.ini

sed -i "s/cert_file =/cert_file = \/etc\/ssl\/certs\/${pvc}.csk.rhel.cc.cer/g" defaults.ini
sed -i "s/cert_key =/cert_key = \/etc\/ssl\/certs\/${pvc}.csk.rhel.cc.key/g" defaults.ini

sed -i "s/cookie_secure = false/cookie_secure = true/g" defaults.ini

#supervisorctl restart grafana
