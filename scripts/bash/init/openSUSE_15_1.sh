#!/bin/bash
zypper refresh
zypper --non-interactive --ignore-unknown install -y man man-pages man-pages-posix openssl openssl-1_1 openssl-1_1-doc openssh openssh-helpers gcc clang binutils llvm make vim neovim less curl wget git git-doc perl perl-doc pcre-devel pcre-devel-doc tar tar-doc xz go go-doc nodejs-common nodejs16 nodejs16-docs cron gpg2
