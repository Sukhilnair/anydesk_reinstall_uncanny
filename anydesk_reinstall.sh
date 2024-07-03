#!/bin/bash
sudo apt-get purge anydesk -y
sudo apt-get autoremove -y
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -
echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list
apt-get update -y
apt-get install anydesk -y
echo admin@123 | sudo anydesk --set-password
anydesk_id=`sudo anydesk --get-id`
sleep 10
aikaan_id=`cat /opt/aikaan/etc/aiagent_config.json | jq -r '.DeviceId'`
token=`curl -k 'https://monitor.uncannysurveillance.com/api/_external/auth/v1/signin' --data-raw '{"email":"uncannyvision@aikaan.io","password":"uncannyvision@123456"}' | jq -r ".data.token"`
curl -k "https://monitor.uncannysurveillance.com/dm/api/dm/v1/device/$aikaan_id" \
  -X PUT \
  -H "Cookie: aicon-jwt=$token" \
  --data-raw "{\"name\":\"$aikaan_name\",\"desc\":\"Anydesk: $anydesk_id\"}" \
  --compressed
  
sudo wget http://security.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5.13_amd64.deb
sudo ln -s /usr/lib/x86_64-linux-gnu/libjsoncpp.so.25 /usr/lib/x86_64-linux-gnu/libjsoncpp.so.1
sudo dpkg -i lib*
sudo apt-get install libjsoncpp-dev -y

