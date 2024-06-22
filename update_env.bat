@echo off
setlocal

REM Get API endpoint from Terraform output
for /f "tokens=*" %%i in ('terraform output -raw api_endpoint') do set API_ENDPOINT=%%i

REM Update .env
echo VITE_API_ENDPOINT=%API_ENDPOINT% > .env

endlocal
