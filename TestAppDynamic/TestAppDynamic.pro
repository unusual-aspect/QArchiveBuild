# Build app with dynamic lib
QT       += core
TARGET   =  TestAppDynamic
TEMPLATE =  app
SOURCES  =  $$PWD/main.cpp

# Files need by QArchive
INCLUDEPATH += \
   $$PWD/../QArchive/include/ \
   $$PWD/../QArchive/
# Inlude libarchive stuff
include($$PWD/../libarchive.pri)

# Files need by QArchive
INCLUDEPATH += \
   $$PWD/../QArchive/include/ \
   $$PWD/../QArchive/
# Inlude libarchive stuff
include($$PWD/../libarchive.pri)

# Set output
include($$PWD/../shared.pri)

# Add QArchive lib
win32 {
   !contains(QMAKE_TARGET.arch, x86_64) {
      CONFIG(release, debug|release): LIBS += -L$$PWD/../Release_WIN_x86/ -lQArchiveDynamic
      CONFIG(debug, debug|release):   LIBS += -L$$PWD/../Debug_WIN_x86/ -lQArchiveDynamic
   } else {
      CONFIG(release, debug|release): LIBS += -L$$PWD/../Release_WIN_x64/ -lQArchiveDynamic
      CONFIG(debug, debug|release):   LIBS += -L$$PWD/../Debug_WIN_x64/ -lQArchiveDynamic
   }
}
