#!/bin/sh
mkdir -p /app

apk add --no-cache git libtool automake autoconf gcc make g++ libzip-dev patch file bash

apk add --no-cache libplist-dev curl-dev

git -C /app clone --depth=1 --recursive https://github.com/tihmstar/libgeneral
cd /app/libgeneral
./autogen.sh
make install

git -C /app clone --depth=1 --recursive https://github.com/tihmstar/libfragmentzip
cd /app/libfragmentzip
./autogen.sh
make install

git -C /app clone --depth=1 --recursive https://github.com/1Conan/tsschecker
cd /app/tsschecker

cat <<EOF | patch
--- configure.ac
+++ configure.ac
@@ -44,7 +44,7 @@
 
 PKG_CHECK_MODULES(libplist, libplist >= 2.0.0)
 PKG_CHECK_MODULES(libcurl, libcurl >= 1.0)
-PKG_CHECK_MODULES(libfragmentzip, libfragmentzip >= 48)
+PKG_CHECK_MODULES(libfragmentzip, libfragmentzip >= 1)
 AS_IF([test "x\$with_libcrypto" != xno],
     [PKG_CHECK_MODULES(libcrypto, libcrypto >= 1.0)]
 )
EOF

./autogen.sh
bash ./configure
make install

apk del git libtool automake autoconf gcc make g++ libzip-dev patch file bash

rm -rf /app/tsschecker /app/libgeneral /app/libfragmentzip
