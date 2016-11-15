#!/bin/bash

cd /root/ca
if [ -z "$1" ]
then
  echo "Usage: `basename $0` [domain-name]"
  exit $E_NOARGS
fi

echo "Generate key"
openssl genrsa -out intermediate/private/$1.key.pem 2048
chmod 400 intermediate/private/$1.key.pem

echo "Generate csr"
openssl req -config intermediate/openssl.cnf -key intermediate/private/$1.key.pem -new -sha256 -out intermediate/csr/$1.csr.pem

echo "Sign cert"
openssl ca -config intermediate/openssl.cnf -extensions server_cert -days 375 -notext -md sha256 -in intermediate/csr/$1.csr.pem -out intermediate/certs/$1.cert.pem

chmod 444 intermediate/certs/$1.cert.pem

echo "Verify Certificate"
grep $1 intermediate/index.txt

openssl x509 -noout -text -in intermediate/certs/$1.cert.pem

openssl verify -CAfile intermediate/certs/ca-chain.cert.pem intermediate/certs/$1.cert.pem

cd -
