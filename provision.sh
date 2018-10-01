#!/usr/bin/env bash
obsidian_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

clean_symlinks() {
	local dir=$obsidian_path"/web/app/$1"	
	for i in $( ls -laT $dir | sed -ne "s|^l.*[[:space:]]\([a-zA-Z0-9_\-]*\)[[:space:]]->.*|\1|p" )
	do
		rm "$dir/$i"
	done
}
clean_symlinks 'plugins'
clean_symlinks 'themes'

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
		IFS=, read link <<< $i
		ln -sfn $link
		echo "Linking ${link}";
	done
}

if [ ! -d "$obsidian_path/web/wp" ]; then
	echo "Cloning WordPress..."
	cd $obsidian_path"/web"
	git clone https://github.com/WordPress/WordPress.git wp
fi

cd $obsidian_path"/web/wp"
echo "Fetching tags..."
git fetch
git fetch --tags
echo "Pulling latest commits..."
git checkout master
git pull origin master
echo "Checking out latest tag..."
latest_tag="$(git tag -l --sort=version:refname | tail -1)"
git checkout tags/$latest_tag

cd $obsidian_path
composer install

setup_projects projects.yml
