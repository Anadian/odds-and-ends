#!/bin/bash
zypper refresh
zypper --non-interactive --ignore-unknowns install man man-pages man-pages-posix openssl openssl-1_1 openssl-1_1-doc openssh openssh-helpers gcc clang binutils llvm make vim neovim less curl wget git git-doc perl perl-doc pcre-devel pcre-devel-doc tar tar-doc xz go go-doc nodejs-common nodejs10 nodejs10-docs cron gpg2 password-store
