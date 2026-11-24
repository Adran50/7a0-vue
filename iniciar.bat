@echo off
setlocal
cd /d "%~dp0"

echo ===================================================
echo             INICIANDO JUEGO: VERSUS
echo ===================================================
echo.

where node >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Node.js no esta instalado o no se encuentra en el PATH.
    echo Por favor instala Node.js desde https://nodejs.org/ para continuar.
    echo.
    pause
    exit /b 1
)

if not exist node_modules (
    echo [INFO] No se encontro la carpeta node_modules.
    echo Instalando dependencias necesarias...
    echo.
    call npm install
    if %errorlevel% neq 0 (
        echo [ERROR] Hubo un problema al instalar las dependencias.
        pause
        exit /b 1
    )
    echo [OK] Dependencias instaladas con exito.
    echo.
)

echo Iniciando servidor en http://localhost:5173/ y abriendo navegador...
echo Presiona Ctrl + C para detener el servidor.
echo.

call npx vite --open

if %errorlevel% neq 0 (
    echo.
    echo El servidor se ha detenido con codigo de error %errorlevel%.
    pause
)
