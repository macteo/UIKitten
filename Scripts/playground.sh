cd ../UIKitten.playground/Sources
rm *.swift
rm -R Core
mkdir Core
cd Core
ln -s ../../../UIKitten/Core/*.swift .
cd ../
rm -R Icons
mkdir Icons
cd Icons
ln -s ../../../UIKitten/Icons/*.swift .
mkdir Pod
cd Pod
ln -s ../../../../Pods/FontAwesome.swift/FontAwesome/*.swift . 
cd ../../../
cd Resources
rm FontAwesome.otf
cp ../../Pods/FontAwesome.swift/FontAwesome/FontAwesome.otf .
cd ../../
playgroundbook render UIKitten.yaml
cp -Rp UIKitten.playgroundbook ~/Library/Mobile\ Documents/com\~apple\~CloudDocs