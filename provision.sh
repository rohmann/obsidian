#!/usr/bin/env bash
obsidian_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

setup_projects() {
	local app=$obsidian_path"/web/app/"
  local s='[[:space:]]*' w='[a-zA-Z0-9_\-]*' fs=$(echo @|tr @ '\034')
  # yaml parsing based on: https://gist.github.com/pkuczynski/8665367
  for i in $(sed -ne "s|^\($s\)\($w\)$s:$s\"\(.*\)\"$s\$|\1$fs\2$fs\3|p" \
    -e "s|^\($s\)\($w\)$s:$s\(.*\)$s\$|\1$fs\2$fs\3|p"  $1 |
  awk -F$fs '{
    indent = length($1)/2;
    vname[indent] = $2;
    if (length($3) > 0) {
      vn=""; for (i=0; i<indent; i++) {vn=(vn)(vname[i])}
      printf("%s,%s%s/%s\n",$3,"'"$app"'",vn, $2);
    }
 	}'| cat)
	do
		IFS=, read target destination <<< $i
		ln -sfn $target $destination
		echo "Linking ${target} to ${destination}";
	done
}
setup_projects projects.yml

if [ ! -d "$obsidian_path/web/wp" ]; then
	echo "Cloning WordPress..."
	cd $obsidian_path"/web"
	git clone https://github.com/WordPress/WordPress.git wp
fi

cd $obsidian_path"/web/wp"
echo "Fetching tags..."
git fetch
git fetch --tags
git checkout master
git pull origin master

cd $obsidian_path
composer install