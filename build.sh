#!/usr/bin/env bash
URL="https://github.com/olvb/nodesoup/archive/refs/heads/master.zip"
ZIP="nodesoup-master.zip"
DIR="${ZIP%.zip}"
mkdir -p .build
cd .build

# Download the release
if [ ! -f "$ZIP" ]; then
  echo "Downloading $ZIP from $URL ..."
  curl -L "$URL" -o "$ZIP"
  echo ""
fi

# Unzip the release
if [ ! -d "$DIR" ]; then
  echo "Unzipping $ZIP to .build/$DIR ..."
  cp "$ZIP" "$ZIP.bak"
  unzip -q "$ZIP"
  rm "$ZIP"
  mv "$ZIP.bak" "$ZIP"
  echo ""
fi
cd ..

# Copy the libs to the package directory
echo "Copying libs to nodesoup/ ..."
rm -rf nodesoup/
mkdir -p nodesoup
cp -rf ".build/$DIR/src/"* nodesoup/
cp -f  ".build/$DIR/include/nodesoup.hpp" nodesoup/
rm -f nodesoup/CMakeLists.txt
echo ""
