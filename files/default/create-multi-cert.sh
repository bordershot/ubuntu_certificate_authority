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

#create subjectAltName
#replace <placeholder for subjectAltName> in template-openssl.cnf --> openssl-$1.cnf
subjectAltName=""
DNS_counter=1
IP_counter=1

for i
do
  hostname=$(echo $i | cut -d. -f1)
  host $i > /dev/null
  if [ $? -eq 0 ]
  then
    ip_addr=$(dig $i +short)
  fi
  DNS_prev=$DNS_counter
  DNS_counter+=1
  subjectAltName+="DNS.$DNS_prev = $i\nDNS.$DNS_counter = $hostname\nIP.$IP_counter = $ip_addr\n"
  DNS_counter+=1
  IP_counter+=1
done
sed -e "s/<placeholder for subjectAltName>/$subjectAltName/" intermediate/template-openssl.cnf > intermediate/openssl-$1.cnf
#echo -e $subjectAltName

echo "Generate csr"
openssl req -config intermediate/openssl-$1.cnf -key intermediate/private/$1.key.pem -new -sha256 -out intermediate/csr/$1.csr.pem

echo "Sign cert"
openssl ca -config intermediate/openssl-$1.cnf -extensions server_cert -days 1826 -extensions v3_req -notext -md sha256 -in intermediate/csr/$1.csr.pem -out intermediate/certs/$1.cert.pem

chmod 444 intermediate/certs/$1.cert.pem

echo "Verify Certificate"
grep $1 intermediate/index.txt

openssl x509 -noout -text -in intermediate/certs/$1.cert.pem

openssl verify -CAfile intermediate/certs/ca-chain.cert.pem intermediate/certs/$1.cert.pem

cd -
