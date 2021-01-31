#include <QDebug>
#include <QTimer>
#include <QLibrary>
#include <QCoreApplication>

int main(int argc, char **argv)
{
   QCoreApplication app(argc, argv);

   //
   QLibrary library("QArchive.dll");

   //
   if(!library.load())
   {
      qInfo() << library.errorString();
      QTimer::singleShot(0, [&]() {
         app.quit();
      });
   }

   //
   if(library.load())
   {
      qInfo() << "Library loaded";
      QTimer::singleShot(0, [&]() {
         app.quit();
      });
   }

   return app.exec();
}
