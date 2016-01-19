@echo off

::Arquivo usdo para compilar os arquivos jsx/js
::para js nativo e ser usado no index.html ou qualquer outro
::deve ser executado em outra janela do terminal junto com
::o servidor.

set output="public/build"
set input="src"
::set date="%Y-%m-%d-%H:%M";
set log="build.log.txt"

for /F "usebackq tokens=1,2 delims==" %%i in (`wmic os get LocalDateTime /VALUE 2^>NUL`) do if '.%%i.'=='.LocalDateTime.' set ldt=%%j
set ldt=%ldt:~0,4%-%ldt:~4,2%-%ldt:~6,2%-%ldt:~8,2%:%ldt:~10,2%

set now=%ltd%;
::set logsize="$(du -hsb $log)"
set outputFile="bundle.js"
set success="$(tput setaf 2)"
set error="$(tput setaf 1)"
set info="$(tput setaf 4)"
set reset=`tput sgr0`
set cont=0;

FOR /F "usebackq" %%A IN ('%log%') DO set logsize=%%~zA

while  read file ; do
   let cont=$cont+1;
done < %log%;

if %cont% > 200 (
  
    dialog --title "Clear File" \
    --backtitle "Build - React" \
    --yesno "The %log% have more than 200 line.Are you want clear this log ? [ESC to cancel]" 7 60
    response=$?
    case $response in
       0) echo "file is clear";echo"">%log%;;
       1) echo "not clear";;
       255) echo "[operation was canceled]"; exit;;
    esac
)

::Verifica se o diretorio  de entrada é válido
if not exist %input% (
  echo "+-----------------------------------------+"
  echo "+%error% Directory %input% not found in current dir!%{reset}% +"
  echo "+%info% See %log% for more details %{reset}%    +"
  echo "+-----------------------------------------+"
  echo "[%now%] - %logsize%
  It is necessary that the directory <%input%> is set up so that
  the watchify compile the code to <%output%>" >> %log%
  exit
)

::Verifica se o diretorio de saida está criado, se não ele é criado automaticamente
if not exist %output% (
  md %output%
)

::Caso o diretório de entrada e saída estiverem OK ele builda os arquivos
::de entrada para a pasta de saída em um único arquivo,.
if exist %input% (
  echo "+--------------------------------------------+"
  echo "+%success% Build project from <%input%> to <%output%>%{reset}% +"
  echo "+--------------------------------------------+"
  watchify -t [ babelify --presets [ react ] ] %input%/*.jsx -o %output%/%outputFile% -d -w |

  echo "[%now%]
  File %output%/%outputFile% was built in %output%" >> %log%
)
