#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "You need to be root to execute this script."
  exit
fi
echo "Creating pycert user"
adduser -K PASS_MAX_DAYS=-1 -m -r pycert
if [ $? -ne 0 ]
  then echo "Error while creating the user, exiting"
  exit
fi
echo "User created."
if [[ ! -d "/home/pycert" ]]
  then mkdir /home/pycert
  exit
echo "Creating configuration file"
mkdir /etc/ocsp_py
if [ $? -ne 0 ]
  then echo "Error adding etc folder, exiting"
  exit
fi
echo "Creating binaries"
cp ocsp.py /bin/ocsp.py
chown pycert: /bin/ocsp.py
chmod 700 /bin/ocsp.py
cp config.ini /etc/ocsp_py/
chmod u=rwX,g=,o= /etc/ocsp_py
if [ $? -ne 0 ]
  then echo "Error setting binaries, exiting"
  exit
fi
echo "Creating logs"
touch /var/log/ocsp_py.log
chown pycert:adm /var/log/ocsp_py.log
chmod 640 /var/log/ocsp_py.log
if [ $? -ne 0 ]
  then echo "Error setting logs, exiting"
  exit
fi
