#!/bin/zsh

SCRIPT_PATH=$(dirname $0)

DevApp="Developer ID Application: Emily Carr University of Art and Design (7TF6CSP83S)"

rm -rf $SCRIPT_PATH/payload/Library/installapplications/Python.framework/Versions/3.9/_CodeSignature

find $SCRIPT_PATH/payload/Library/installapplications/Python.framework/Versions/3.9/lib/ -type f -perm -u=x -exec codesign --force --deep --verbose -s "$DevApp" {} \;
find $SCRIPT_PATH/payload/Library/installapplications/Python.framework/Versions/3.9/bin/ -type f -perm -u=x -exec codesign --force --deep --verbose -s "$DevApp" {} \;
find $SCRIPT_PATH/payload/Library/installapplications/Python.framework/Versions/3.9/lib/ -type f -name "*dylib" -exec codesign --force --deep --verbose -s "$DevApp" {} \;
find $SCRIPT_PATH/payload/Library/installapplications/Python.framework/Versions/3.9/lib/ -type f -name "*so" -exec codesign --force --deep --verbose -s "$DevApp" {} \;
find $SCRIPT_PATH/payload/Library/installapplications/Python.framework/Versions/3.9/lib/ -type f -name "*libitclstub*" -exec codesign --force --deep --verbose -s "$DevApp" {} \;
find $SCRIPT_PATH/payload/Library/installapplications/Python.framework/Versions/3.9/lib/ -type f -name "*libtdbcstub*" -exec codesign --force --deep --verbose -s "$DevApp" {} \;
find $SCRIPT_PATH/payload/Library/installapplications/Python.framework/Versions/3.9/lib/ -type f -name "*.o" -exec codesign --force --deep --verbose -s "$DevApp" {} \;

/usr/libexec/PlistBuddy -c "Add :com.apple.security.cs.allow-unsigned-executable-memory bool true" $SCRIPT_PATH/payload/Library/installapplications/entitlements.plist

codesign --force --options runtime --entitlements $SCRIPT_PATH/payload/Library/installapplications/entitlements.plist --deep --verbose -s "$DevApp" $SCRIPT_PATH/payload/Library/installapplications/Python.framework/Versions/3.9/Resources/Python.app/

codesign --force --options runtime --entitlements $SCRIPT_PATH/payload/Library/installapplications/entitlements.plist --deep --verbose -s "$DevApp" $SCRIPT_PATH/payload/Library/installapplications/Python.framework/Versions/3.9/bin/python3.9
codesign -dvv $SCRIPT_PATH/payload/Library/installapplications/Python.framework/Versions/3.9/bin/python3.9
codesign -dv --verbose=4 $SCRIPT_PATH/payload/Library/installapplications/Python.framework/Versions/3.9/bin/python3.9
codesign -vvv --deep --strict $SCRIPT_PATH/payload/Library/installapplications/Python.framework/Versions/3.9/bin/python3.9

codesign --force --options runtime --deep --verbose -s "$DevApp" $SCRIPT_PATH/payload/Library/installapplications/Python.framework/Versions/3.9/Python
codesign -dvv $SCRIPT_PATH/payload/Library/installapplications/Python.framework/Versions/3.9/Python
codesign -dv --verbose=4 $SCRIPT_PATH/payload/Library/installapplications/Python.framework/Versions/3.9/Python
codesign -vvv --deep --strict $SCRIPT_PATH/payload/Library/installapplications/Python.framework/Versions/3.9/Python

codesign -dvv $SCRIPT_PATH/payload/Library/installapplications/Python.framework
codesign --force --deep --verbose -s  "$DevApp" $SCRIPT_PATH/payload/Library/installapplications/Python.framework