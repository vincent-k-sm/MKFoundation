
# Root Dir
cd ..
ROOT_DIR="$( cd "$( dirname "$0" )" && pwd )"
#echo $ROOT_DIR
cd Sources

ASSETS_DIR="$(find $PWD -type d -name "Assets.xcassets")"
#echo $ASSETS_DIR

RESULT_PATH="$(find $PWD -name "AssetsColors.swift")"
#echo $RESULT_PATH

# Assets.xcassets 하위에 Colors 폴더로 이동
cd $ASSETS_DIR/Colors

touch tempColorSet.swift
echo "import Foundation" >> tempColorSet.swift
echo "" >> tempColorSet.swift
echo "public enum Colors: String {" >> tempColorSet.swift
echo "" >> tempColorSet.swift
for f in *; do

  variableName=$(echo $f)
  if [[ "$variableName" == *".colorset" ]] ; then
#    echo $variableName | sed -e "s/.colorset//g"
    expectCase=$(echo $variableName | sed -e "s/.colorset//g")
#    echo $expectCase
    if [ "$expectCase" == "default" ] ; then
        echo "    case \`$expectCase\`" >> tempColorSet.swift
    else
        echo "    case $expectCase" >> tempColorSet.swift
    fi
  fi

done
echo "}" >> tempColorSet.swift

# 임시작성된 항목을 enum set
cat "tempColorSet.swift" > $RESULT_PATH
rm tempColorSet.swift