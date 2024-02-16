#!/bin/bash
git remote update
git pull origin main
if [ -e "ROOT.war" ]; then
    rm ROOT.war
fi
cp -f ../vas1/build/libs/vas1-0.0.1-SNAPSHOT-plain.war ROOT.war
echo "업데이트 완료!"
git add ROOT.war
git commit -m "."
git push origin main
