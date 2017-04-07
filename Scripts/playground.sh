cd ../UIKitten.playground/Sources
rm *.swift
rm -R Core
mkdir Core
cd Core
ln -s ../../../UIKitten/Core/*.swift .
cd ../
rm -Rf Charts
mkdir Charts
cd Charts
ln -s ../../../UIKitten/Charts/*.swift .
mkdir Pod
cd Pod
cp -Rp ../../../../Pods/Charts/Source/Charts/* .
# ln -s ../../../../Pods/Charts/Source/Charts/* .
cd ../../
rm -Rf Icons
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