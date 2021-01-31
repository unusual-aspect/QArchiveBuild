# Windows
win32 {
   !contains(QMAKE_TARGET.arch, x86_64) {
      CONFIG(release, debug|release): DESTDIR =  $$PWD/Release_WIN_x86
      CONFIG(debug, debug|release):   DESTDIR =  $$PWD/Debug_WIN_x86
   } else {
      CONFIG(release, debug|release): DESTDIR =  $$PWD/Release_WIN_x64
      CONFIG(debug, debug|release):   DESTDIR =  $$PWD/Debug_WIN_x64
   }
}
# MacOS
macx: {
   CONFIG += sdk_no_version_check
}
#Linux
unix:!macx {
}
