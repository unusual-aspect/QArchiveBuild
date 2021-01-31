@echo off
echo "Check: %~dp0vcpkg\vcpkg.exe"
if not exist "%~dp0vcpkg\vcpkg.exe" (
   echo "Build/Install vcpkg binary"
   start /wait /b cmd /c "%~dp0vcpkg\bootstrap-vcpkg.bat" -disableMetrics
)
echo "Check: %~dp0vcpkg\installed\%1-windows-static"
if not exist "%~dp0vcpkg\installed\%1-windows-static" (
   echo "Build/Install libarchive:%1-windows-static"
   start /wait /b cmd /c "%~dp0vcpkg\vcpkg.exe" install libarchive:%1-windows-static
)
