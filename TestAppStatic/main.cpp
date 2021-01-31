#include <QCoreApplication>
#include <QDir>
#include <QDebug>
#include <QLibrary>
#include <QArchive>
#include <QDirIterator>
using namespace QArchive;

int main(int argc, char **argv)
{
   QCoreApplication app(argc, argv);

   //
   QString  zipFile = QString("test.zip");
   QDir     tmpFolder("tmp");

   //
   QFileInfo appFile(qApp->applicationFilePath());

   //
   DiskExtractor Extractor;
   Extractor.setArchive(zipFile);
   Extractor.setOutputDirectory(tmpFolder.absolutePath());
   Extractor.setCalculateProgress(true);
   {
      bool isExtracting = false;
      //
      QObject::connect(&Extractor, &DiskExtractor::progress, [&](QString /*file*/, int /*entriesProcessed*/, int /*entriesTotal*/, qint64 /*bytesProcessed*/, qint64 /*bytesTotal*/)
      {
         if(!isExtracting)
         {
            qInfo() << "Extraction progress...";
            isExtracting = true;
         }
      });

      //
      QObject::connect(&Extractor, &DiskExtractor::finished, [&]()
      {
         qInfo() << "Extracted File(s) Successfully!";

         // Remove files
         QFile::remove(zipFile);
         // And folders
         tmpFolder.removeRecursively();
#ifdef Q_OS_WIN
         // Windows Bug:
         // https://stackoverflow.com/questions/49356240/cannot-delete-aux-file
         QDirIterator it(tmpFolder.path(), QDir::Files, QDirIterator::Subdirectories);
         while(it.hasNext())
         {
            QString dataFile = QDir::toNativeSeparators(it.next());
            dataFile.prepend("\\\\.\\");
            QFile::remove(dataFile);
         }
         // Remove 'existing folders'
         tmpFolder.removeRecursively();
#endif

         app.quit();
      });

      QObject::connect(&Extractor, &DiskExtractor::error, [&](short code)
      {
         qInfo() << "Extractor -> An error has occured ::" << QArchive::errorCodeToString(code);
         app.quit();
      });
   }

   //
   DiskCompressor Compressor;
   Compressor.setFileName(zipFile);
   Compressor.addFiles(appFile.absoluteFilePath());
   Compressor.setArchiveFormat(QArchive::ZipFormat);
   {
      bool isCompressing = false;
      //
      QObject::connect(&Compressor, &DiskCompressor::progress, [&](QString /*file*/, int /*entriesProcessed*/, int /*entriesTotal*/, qint64 /*bytesProcessed*/, qint64 /*bytesTotal*/)
      {
         if(!isCompressing)
         {
            qInfo() << "Compressing progress...";
            isCompressing = true;
         }
      });

      //
      QObject::connect(&Compressor , &DiskCompressor::finished, [&]()
      {
         qInfo() << "Compressed File(s) Successfully!";

         // Create directory if not exist
         if(!QDir(tmpFolder.absolutePath()).exists()) {
            QDir().mkdir(tmpFolder.absolutePath());
         }
         Extractor.start();
      });

      //
      QObject::connect(&Compressor, &DiskCompressor::error, [&](short code , QString file)
      {
         qInfo() << "Compressor Error:" << QArchive::errorCodeToString(code) << "::" << file;
         app.quit();
      });
   }
   Compressor.start();

   return app.exec();
}
