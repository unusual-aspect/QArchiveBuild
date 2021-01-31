#
TEMPLATE =  subdirs

#
SUBDIRS  += \
   QArchiveDynamic \
   TestAppDynamic

#
SUBDIRS  += \
   QArchiveStatic \
   TestAppStatic

#
TestAppStatic.depends   = QArchiveStatic
TestAppDynamic.depends  = QArchiveDynamic
