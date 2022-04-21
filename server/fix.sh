#!/bin/bash

echo "Creating passwd entries"

# Delete rstudio and $USERNAME entries
sed -i "s/^rstudio.*//g" /etc/passwd

if [ ! -z "$USERNAME" ];
then
  sed -i "s/^$USERNAME.*//g" /etc/passwd
fi

# Add rstudio-server and $USERNAME entries
echo "rstudio-server:x:$(id -u):$(id -g)::$HOME:/usr/sbin/nologin" >> /etc/passwd
echo "$USERNAME:x:$(id -u):$(id -g)::$HOME:/usr/sbin/nologin" >> /etc/passwd

echo "Creating group entries"

# Delete rstudio and $USERNAME entries
sed -i "s/^rstudio.*//g" /etc/group

if [ ! -z "$USERNAME" ];
then
  sed -i "s/^$USERNAME.*//g" /etc/group
fi

# Add rstudio-server and $USERNAME entries
echo "$USERNAME:x:$(id -g):" >> /etc/group

echo "Reading credentials"
RPassword=$(cat /tmp/shadow/shadow.crypt)

echo "Creating shadow entries"

sed -i "s/^rstudio.*//g" /etc/shadow
sed -i "s/^$USERNAME.*//g" /etc/shadow

echo "$USERNAME:${RPassword}:17866:0:99999:7:::" >> /etc/shadow
echo "rstudio-server:${RPassword}:17866:0:99999:7:::" >> /etc/shadow

