#!/usr/bin/env bash
#Arquivo usado para compilar os arquivos jsx/js
#para js nativo e ser usado no index.html ou qualquer outro
#deve ser executado em outra janela do terminal junto com
#o servidor.

output=public/build;
input=src;
date='%Y-%m-%d-%H:%M';
log=build.log.txt;
now="$(date)";
logsize="$(du -hsb $log)";
outputFile=bundle.js;
success="$(tput setaf 2)";
error="$(tput setaf 1)";
info="$(tput setaf 4)";
reset=`tput sgr0`
cont=0;
watch='';
while  read file ; do
   let cont=$cont+1;
done < $log;

if [ "$cont" -gt 200 ]
  then
    dialog --title "Clear File" \
    --backtitle "Build - React" \
    --yesno "The $log have more than 200 line.Are you want clear this log ? [ESC to cancel]" 7 60
    response=$?
    case $response in
       0) echo "file is clear";echo"">$log;;
       1) echo "not clear";;
       255) echo "[operation was canceled]"; exit;;
    esac
fi
#Verifica se o diretorio  de entrada é válido
if [[ ! -d $input ]]; then
  echo "+-----------------------------------------+"
  echo "+$error Directory $input not found in current dir!${reset} +"
  echo "+$info See $log for more details ${reset}     +"
  echo "+-----------------------------------------+"
  echo "[$now] - $logsize
  It is necessary that the directory <$input> is set up so that
  the watchify compile the code to <$output>" >> $log
  exit
fi
#Verifica se o diretorio de saida está criado, se não ele é criado automaticamente
if [[ ! -e $output ]]; then
  mkdir $output
fi
#Caso o diretório de entrada e saída estiverem OK ele builda os arquivos
#de entrada para a pasta de saída em um único arquivo,.
if [ -d "$input" ]; then
  echo "+--------------------------------------------+"
  echo "+$success Build project from <$input> to <$output>${reset} +"
  echo "+--------------------------------------------+"
  watchify -t [ babelify --presets [ react ] ] $input/*.jsx -o $output/$outputFile -d -w |
echo $args
  echo "[$now]
  File $output/$outputFile was built in $output" >> $log
fi
