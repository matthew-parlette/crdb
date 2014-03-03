#!/bin/bash
version="$1"
info_color="\e[96m"
reset_color="\e[0m"

info () {
  echo -e "$info_color$1$reset_color"
}

if [ -z "$version" ]; then
  echo "version must be provided, use $0 v1.0"
  exit 1
fi

info "bumping version to $version..."
eval "sed -i 's/v[0-9]\.[0-9]/$version/g' app/views/layouts/application.html.erb"

info "verify version is correct..."
eval "git diff HEAD"
info "to update git:"
info "\t\$ git commit -am \"bump to $version\""
info "\t\$ git tag -a $version -m \"$version\""
info "\t\$ git push --tags"
