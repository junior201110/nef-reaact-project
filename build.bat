@echo off

::Arquivo usdo para compilar os arquivos jsx/js
::para js nativo e ser usado no index.html ou qualquer outro
::deve ser executado em outra janela do terminal junto com
::o servidor.

::(status: ainda não testado)

::resultado da compilacao
set output="public/build"

::pasta onde os scripts serao lidos e compilados
set input="src"

::arquivo de log
set log="build.log.txt"

::pega a data e o horário atual atual
for /F "usebackq tokens=1,2 delims==" %%i in (`wmic os get LocalDateTime /VALUE 2^>NUL`) do if '.%%i.'=='.LocalDateTime.' set ldt=%%j
set ldt=%ldt:~0,4%-%ldt:~4,2%-%ldt:~6,2%-%ldt:~8,2%:%ldt:~10,2%

set now=%ltd%;

::arquivo de saida compilado
set outputFile="bundle.js"

::cores
set success="0a"
set error="0c"
set info="01"


::conta o tamanho do arquivo de log em bytes
FOR /F "usebackq" %%A IN ('%log%') DO set logsize=%%~zA

::conta a quantidade de linhas do arquivo de log
for /f %%a in ('type "%log%"^|find "" /v /c') do set /a cont=%%a

if %cont% > 200 (

  Call :YesNoBox "The %log% have more than 200 line.Are you want clear this log ?" "Clear File"
  if "%YesNo%"=="7" (
    echo file is clear
    echo. 2> %log%
  )

  if "%YesNo%"=="6" (
    echo not clear
  )  

)  

::Verifica se o diretorio  de entrada é válido
if not exist %input% (
  echo +-----------------------------------------+
  
  call :ColorText %error% "+ Directory %input% not found in current dir! +"
  echo(  

  call :ColorText %info% "+ See %log% for more details    +"
  echo(

  echo +-----------------------------------------+
  echo [%now%] - %logsize%
  echo It is necessary that the directory ^<%input%^> is set up so that
  echo the watchify compile the code to ^<%output%^> >> %log%
  exit
)

::Verifica se o diretorio de saida está criado, se não ele é criado automaticamente
if not exist %output% (
  md %output%
)

::Caso o diretório de entrada e saída estiverem OK ele builda os arquivos
::de entrada para a pasta de saída em um único arquivo,.
if exist %input% (
  echo +--------------------------------------------+
 
  call :ColorText %success% "+Build project from ^<%input%^> to ^<%output%^>+"
  echo(

  echo +--------------------------------------------+
  watchify -t [ babelify --presets [ react ] ] %input%/*.jsx -o %output%/%outputFile% -d -w |

  echo [%now%]
  echo File %output%/%outputFile% was built in %output% >> %log%
)

goto :eof


::subrotina que cria um simples dialog yes/no
:YesNoBox
REM returns 6 = Yes, 7 = No. Type=4 = Yes/No
set YesNo=
set MsgType=4
set heading=%~2
set message=%~1
echo wscript.echo msgbox(WScript.Arguments(0),%MsgType%,WScript.Arguments(1)) >"%temp%\input.vbs"
for /f "tokens=* delims=" %%a in ('cscript //nologo "%temp%\input.vbs" "%message%" "%heading%"') do set YesNo=%%a
exit /b


::subrotina que muda a cor do texto
:ColorText
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto :eof
