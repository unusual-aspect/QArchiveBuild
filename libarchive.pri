# Windows
win32 {
   # Add libarchive libs
   !contains(QMAKE_TARGET.arch, x86_64) {
      INCLUDEPATH += $$PWD/vcpkg/installed/x86-windows-static/include
      DEPENDPATH  += $$PWD/vcpkg/installed/x86-windows-static/include
      LIBS        += -L$$PWD/vcpkg/installed/x86-windows-static/lib/
   } else {
      INCLUDEPATH += $$PWD/vcpkg/installed/x64-windows-static/include
      DEPENDPATH  += $$PWD/vcpkg/installed/x64-windows-static/include
      LIBS        += -L$$PWD/vcpkg/installed/x64-windows-static/lib/
   }

   # Add extra windows libs
   LIBS += -lAdvapi32 -lUser32 -lCrypt32 -lWs2_32
}
# MacOS
macx: {
   CONFIG += sdk_no_version_check
}
#Linux
unix:!macx {
}

# Shared
LIBS += \
   -larchive \
   -lbz2 \
   -lcharset \
   -liconv \
   -llibcrypto \
   -llibssl \
   -llibxml2 \
   -llz4 \
   -llzma \
   -llzo2 \
   -lxxhash \
   -lzlib \
   -lzstd_static
