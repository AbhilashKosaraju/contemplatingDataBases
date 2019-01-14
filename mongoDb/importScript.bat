@echo off
rem This is a windows batch file to import the entire NYSE dataset
setlocal 
CD "C:\Users\user\NYSE_daily_prices"
for /r %%i in (*.csv) do ( 
  call :process_file %%i
  )
goto :eof

:process_file
  echo processing %1
  CD "C:\Program Files\MongoDB\Server\4.0\bin>"
  set list=NYSE_daily_prices
  for %%a in (%list%) do (
  echo Copying data in to the Mongodb collection %%a
  mongoimport --db NYSE_Stocks --collection %%a --type csv --file %1 --headerline
  )
) 
endlocal
start call "C:\Program Files\MongoDB\Server\4.0\bin\mongo.exe"
pause





