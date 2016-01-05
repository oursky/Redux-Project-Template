#!/usr/bin/env bash

git clone git@github.com:oursky/Redux-Project-Template.git
cd Redux-Project-template
git checkout file-templates
rm install-template.sh
cd ..

if [[ $1 -eq 0 ]]
then
  XCODE_PATH="/Applications/Xcode.app"
else
  XCODE_PATH=$1
fi

echo "Xcode app path: $XCODE_PATH"

sudo mv Redux-Project-template $XCODE_PATH/Contents/Developer/Library/Xcode/Templates/File\ Templates/Redux

echo "Done!"
