cd ../UIKitten.playground/Sources
rm *.swift
rm -R Core
mkdir Core
cd Core
cp ../../../UIKitten/Core/*.swift .
cd ../
rm -Rf Charts
mkdir Charts
cd Charts
cp ../../../UIKitten/Charts/*.swift .
mkdir Pod
cd Pod
cp -Rp ../../../../Pods/Charts/Source/Charts/* .
# ln -s ../../../../Pods/Charts/Source/Charts/* .
cd ../../
rm -Rf Icons
mkdir Icons
cd Icons
cp ../../../UIKitten/Icons/*.swift .
mkdir Pod
cd Pod
cp ../../../../Pods/FontAwesome.swift/FontAwesome/*.swift . 
cd ../../../
cd Resources
rm FontAwesome.otf
cp ../../Pods/FontAwesome.swift/FontAwesome/FontAwesome.otf .
cd ../../
playgroundbook render UIKitten.yaml
# cp -Rp UIKitten.playgroundbook ~/Library/Mobile\ Documents/com\~apple\~CloudDocs