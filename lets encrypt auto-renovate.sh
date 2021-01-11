#!/bin/bash

DOMINIO=EJEMPLO.DE.DOMINIO
FILE="/etc/letsencrypt/live/$DOMINIO/certificate.pem"
FILE2=/etc/haproxy/certificate.pem
DATE=$(date +%d-%m-%Y)
service haproxy stop
certbot certonly --standalone -d $DOMINIO
service haproxy start
if [-f "$FILE"]; then
    mv $FILE $FILE.$DATE
fi
cat /etc/letsencrypt/live/$DOMINIO/privkey.pem > /etc/letsencrypt/live/$DOMINIO/certificate.pem
cat /etc/letsencrypt/live/$DOMINIO/fullchain.pem >> /etc/letsencrypt/live/$DOMINIO/certificate.pem

if [-f "$FILE2"]; then
mv $FILE2 $FILE2.$DATE
cp  $FILE /etc/haproxy
service haproxy restart
