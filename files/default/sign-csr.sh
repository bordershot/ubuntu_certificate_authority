#!/bin/bash

cd /root/ca
if [ -z "$1" ]
then
  echo "Usage: `basename $0` [csr file name]"
  exit $E_NOARGS
fi

if [ ! -e $1 ]
then
  echo "$1 not found"
  exit 1
fi

basefilename=${1%.csr}

echo "Sign cert"
openssl ca -config intermediate/openssl.cnf -extensions server_cert -days 375 -notext -md sha256 -in $1 -out intermediate/certs/$basefilename.cert.pem

chmod 444 intermediate/certs/$basefilename.cert.pem

echo "Verify Certificate"
grep $1 intermediate/index.txt

openssl x509 -noout -text -in intermediate/certs/$basefilename.cert.pem

openssl verify -CAfile intermediate/certs/ca-chain.cert.pem intermediate/certs/$basefilename.cert.pem

cd -
