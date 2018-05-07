#!/bin/sh

# ref: https://datacenteroverlords.com/2012/03/01/creating-your-own-ssl-certificate-authority/

# CA
echo "Configuring rootca certs (shared with pusher nodes)..."
openssl genrsa -out rootCA.key 2048
openssl genrsa -des3 -out rootCA.key 2048
openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 1024 -out rootCA.pem

# device
echo "Configuring device (server) certs..."
openssl genrsa -out device.key 2048
openssl req -new -key device.key -out device.csr
openssl x509 -req -in device.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out device.crt -days 500 -sha256
