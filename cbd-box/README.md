Centos 7.1
==========

Standard Centos 7.1 box with:
* Docker (latest)

## Setting up the environment
```
vagrant up
vagrant ssh
```

## Install cbd
```
curl https://raw.githubusercontent.com/sequenceiq/cloudbreak-deployer/master/install-latest | sudo sh && cbd --version
cd cloudbreak-deployer
cbd init
echo export PUBLIC_IP=192.168.44.10 > Profile
# use the cbd co
```


## Access to UI:
After you have started the Cloudbreak with cbd start the UI is available on:
```
http://192.168.44.10:3000

user: admin@example.com
pass: cloudbreak
```
