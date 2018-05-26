# DNS Service Bind9

#### Intro
This repo contains scripts that allows:
- Setup bind9 
- Configuring Logging
- Configuration Zones and Reverse Lookups

#### Installation
```bash

# After copying the bind9 folder to your server

chmod +x install.sh

# for Master
sudo install.sh 

# for Slave
sudo install.sh -m slave

# Checking Bind version
named -v

```


#### Bind9 References 

- [Access Control List](https://ftp.isc.org/isc/bind9/cur/9.9/doc/arm/Bv9ARM.ch07.html)
- [Configuration Reference](https://ftp.isc.org/isc/bind9/cur/9.9/doc/arm/Bv9ARM.ch06.html#zone_file)
- 