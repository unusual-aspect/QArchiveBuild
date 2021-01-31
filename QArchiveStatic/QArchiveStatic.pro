# Build static library
QT       += core
TARGET   =  QArchiveStatic
TEMPLATE =  lib
CONFIG   += static
DEFINES  += QT_DEPRECATED_WARNINGS

# Run once - bootstrap vcpkg and build libarchive as static
!build_pass: {
   !contains(QMAKE_TARGET.arch, x86_64) {
      win32: system(start /wait cmd /c $$PWD/../bootstrap.bat x86)
   } else {
      win32: system(start /wait cmd /c $$PWD/../bootstrap.bat x64)
   }
}
# Inlude libarchive stuff
include($$PWD/../libarchive.pri)

# Add QArchive include paths
INCLUDEPATH += $$PWD/../QArchive/include/

#
SOURCES  += \
   $$PWD/../QArchive/src/qarchivediskextractor_p.cc \
   $$PWD/../QArchive/src/qarchivediskextractor.cc \
   $$PWD/../QArchive/src/qarchivediskcompressor_p.cc \
   $$PWD/../QArchive/src/qarchivediskcompressor.cc \
   $$PWD/../QArchive/src/qarchiveutils_p.cc \
   $$PWD/../QArchive/src/qarchiveioreader_p.cc \
   $$PWD/../QArchive/src/qarchive_enums.cc

#
HEADERS  += \
   $$PWD/../QArchive/include/qarchivediskextractor_p.hpp \
   $$PWD/../QArchive/include/qarchivediskcompressor_p.hpp \
   $$PWD/../QArchive/include/qarchiveutils_p.hpp \
   $$PWD/../QArchive/include/qarchiveioreader_p.hpp \
   $$PWD/../QArchive/include/qarchive_enums.hpp \
   $$PWD/../QArchive/include/qarchivediskextractor.hpp \
   $$PWD/../QArchive/include/qarchivediskcompressor.hpp

include($$PWD/../shared.pri)
