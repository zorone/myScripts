# git clone --recurse-submodules --tags https://github.com/dotnet/core.git

mkdir -p json/
find core -type f -name "*.json" -exec sh -c 'new=$(echo "{}" | tr "/" "-" | tr " " "_"); cp -a "{}" "./json/$new"' \;
find core -type f -name "*.json" -exec sh -c 'jq ".releases[]?.sdk?.version?" < {} >> result.json' \;
