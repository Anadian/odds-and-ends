#!/bin/bash

pkg install man linux-man-pages openssl openssl-tool bash coreutils clang make tar xz-utils p7zip nodejs perl lua openssh golang golang-doc grep curl wget -y;
cp ./profilerc ~/.profilerc;
git config --global user.email 'willanad@yandex.com';
git config --global user.name 'Anadian';
echo 'source ~/.profilerc' >> ~/.bashrc;

