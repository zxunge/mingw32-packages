#!/usr/bin/bash

set -eux

BUILD_INFO=Python-3.8.9
HOME=$(cygpath -m /home)

cd /home
git clone https://github.com/zxunge/mingw32-packages.git
cd mingw32-packages/
git checkout 677a62d

# build Python 3.8
cd mingw-w64-python/
MINGW_ARCH=mingw32 makepkg-mingw -sLf

# build GDB
#cd ..
#rm -rf mingw32-packages
#git clone https://github.com/zxunge/mingw32-packages.git
#cd mingw32-packages/mingw-w64-gdb
#MINGW_ARCH=mingw32 makepkg-mingw -sLf

7zr a -mx9 -mqs=on -mmt=on /home/${BUILD_INFO}.7z *.pkg.tar.xz

if [[ -v GITHUB_WORKFLOW ]]; then
  echo "OUTPUT_BINARY=${HOME}/${BUILD_INFO}.7z" >> $GITHUB_OUTPUT
  echo "RELEASE_NAME=${BUILD_INFO}" >> $GITHUB_OUTPUT
  echo "BUILD_INFO=${BUILD_INFO}" >> $GITHUB_OUTPUT
  echo "OUTPUT_NAME=${BUILD_INFO}.7z" >> $GITHUB_OUTPUT
fi
