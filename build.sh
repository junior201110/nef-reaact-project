 #Arquivo usdo para compilar os arquivos jsx/js
 #para js nativo e ser usado no index.html ou qualquer outro
 #chamado em server.php | server.js
dir=public/build
date='%Y-%m-%d-%H:%M';
if [[ ! -e $dir ]]; then
    mkdir $dir
fi
now="$(date)"
echo "+------------------------------------------+"
echo "+Build project from <src> to <$dir>+"
echo "+------------------------------------------+"

#babel --presets [react,es2015] src --watch --out-file public/build/bundle.js
watchify -t [ babelify --presets [ react ] ] src/*.jsx -o public/build/bundle.js  -w |
echo "arquivo $dir/bundle.js modificado em %s\n" "$now" > build-log.txt
