#
# Cookbook Name:: ubuntu_certificate_authority
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

directory '/root/ca' do
  owner 'root'
  group 'root'
  mode '0700'
  action :create
end

directory '/root/ca/certs' do
  owner 'root'
  group 'root'
  mode '0700'
  action :create
end

directory '/root/ca/crl' do
  owner 'root'
  group 'root'
  mode '0700'
  action :create
end

directory '/root/ca/newcerts' do
  owner 'root'
  group 'root'
  mode '0700'
  action :create
end

directory '/root/ca/private' do
  owner 'root'
  group 'root'
  mode '0700'
  action :create
end

directory '/root/ca/intermediate' do
  owner 'root'
  group 'root'
  mode '0700'
  action :create
end

directory '/root/ca/intermediate/certs' do
  owner 'root'
  group 'root'
  mode '0700'
  action :create
end

directory '/root/ca/intermediate/crl' do
  owner 'root'
  group 'root'
  mode '0700'
  action :create
end

directory '/root/ca/intermediate/newcerts' do
  owner 'root'
  group 'root'
  mode '0700'
  action :create
end

directory '/root/ca/intermediate/private' do
  owner 'root'
  group 'root'
  mode '0700'
  action :create
end

directory '/root/ca/intermediate/csr' do
  owner 'root'
  group 'root'
  mode '0700'
  action :create
end

file '/root/ca/index.txt' do
  owner 'root'
  group 'root'
  mode '0600'
  action :create_if_missing
end

file '/root/ca/serial' do
  content '1000'
  owner 'root'
  group 'root'
  mode '0600'
  action :create_if_missing
end

file '/root/ca/intermediate/index.txt' do
  owner 'root'
  group 'root'
  mode '0600'
  action :create_if_missing
end

file '/root/ca/intermediate/serial' do
  content '1000'
  owner 'root'
  group 'root'
  mode '0600'
  action :create_if_missing
end

file '/root/ca/intermediate/crlnumber' do
  content '1000'
  owner 'root'
  group 'root'
  mode '0600'
  action :create_if_missing
end

cookbook_file '/root/ca/openssl.cnf' do
  source 'openssl.cnf'
  owner 'root'
  group 'root'
  mode '0600'
  action :create_if_missing
end

cookbook_file '/root/ca/intermediate/openssl.cnf' do
  source 'openssl-intermediate.cnf'
  owner 'root'
  group 'root'
  mode '0600'
  action :create_if_missing
end

cookbook_file '/root/ca/createCA.sh' do
  source 'createCA.sh'
  owner 'root'
  group 'root'
  mode '0700'
  action :create
end

cookbook_file '/root/ca/create-cert-pair.sh' do
  source 'create-cert-pair.sh'
  owner 'root'
  group 'root'
  mode '0700'
  action :create
end

cookbook_file '/root/ca/sign-csr.sh' do
  source 'sign-csr.sh'
  owner 'root'
  group 'root'
  mode '0700'
  action :create
end

cookbook_file '/root/ca/create-multi-cert.sh' do
  source 'create-multi-cert.sh'
  owner 'root'
  group 'root'
  mode '0700'
  action :create
end

file '/root/ca/intermediate/template-openssl.cnf' do
  source 'template-openssl.cnf'
  owner 'root'
  group 'root'
  mode '0600'
  action :create
end
