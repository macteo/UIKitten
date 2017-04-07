cd ..
cd UIKitten.playground/Sources
rm -Rf *
cp `find ../../UIKitten/Core/ -name "*.swift"` .
cp `find ../../UIKitten/Charts/ -name "*.swift"` .
cp `find ../../UIKitten/Icons/ -name "*.swift"` .
cp `find ../../Pods/Charts/Source/Charts/ -name "*.swift"` .
cp `find ../../Pods/FontAwesome.swift/FontAwesome/ -name "*.swift"` .
cd ../
cd Resources
cp ../../Pods/FontAwesome.swift/FontAwesome/FontAwesome.otf .
cd ../../
rm -Rf UIKitten.playgroundbook
playgroundbook render UIKitten.yaml
# cp -Rp UIKitten.playgroundbook ~/Library/Mobile\ Documents/com\~apple\~CloudDocs