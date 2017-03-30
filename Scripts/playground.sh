cd ../UIKitten.playground/Sources
rm *.swift
ln -s ../../UIKitten/Core/*.swift .
cd ../../
playgroundbook render UIKitten.yaml
cp -Rp UIKitten.playgroundbook ~/Library/Mobile\ Documents/com\~apple\~CloudDocs