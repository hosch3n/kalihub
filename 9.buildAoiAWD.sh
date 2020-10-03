#!/bin/bash

# 先自行解决NodeJS与MongoDB的环境变量
# https://github.com/DasSecurity-Labs/AoiAWD/blob/master/BUILD.md

declare -r RUNUSER='hoschen'
declare -r PHPCLIVER=7.4

# Configuration MongoDB
mkdir -p /var/lib/mongo
mkdir -p /var/log/mongodb
chown "${RUNUSER}" /var/lib/mongo
chown "${RUNUSER}" /var/log/mongodb
mongod --dbpath /var/lib/mongo --logpath /var/log/mongodb/mongod.log --fork
mongod --dbpath /var/lib/mongo --logpath /var/log/mongodb/mongod.log --shutdown

# Build FrontEnd
cd Frontend
npm install
npm run build

# Open Phar
sed -i 's/;phar.readonly = On/phar.readonly = Off/g' /etc/php/"${PHPCLIVER}"/cli/php.ini

# Build Core
cd ../AoiAWD
rm -rf src/public/*
cp -r ../Frontend/dist/* src/public/
php compile.php

# Build TapeWorm
cd ../TapeWorm/
php compile.php

# Build RoundWorm
cd ../RoundWorm/
make

# Install Dependency
apt install libinotifytools0-dev

# Build RoundWorm
make

# Build Guardian
cd ../Guardian/
php compile.php

# Move File
cd ../
mkdir LookHere
mv AoiAWD/aoiawd.phar ./LookHere/
mv Guardian/guardian.phar ./LookHere/
mv TapeWorm/tapeworm.phar ./LookHere/
mv RoundWorm/roundworm ./LookHere/