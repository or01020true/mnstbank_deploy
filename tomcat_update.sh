#!/bin/bash

# 최신 커밋 확인
CATALINA_HOME=/usr/local/tomcat
pushd ${CATALINA_HOME}/vasite1
git remote update
git fetch origin master
LOCAL_COMMIT=$(git rev-parse HEAD)
REMOTE_COMMIT=$(git rev-parse origin/main)

# 변경이 있는지 확인
if [ "$LOCAL_COMMIT" != "$REMOTE_COMMIT" ]; then
    echo "새로운 커밋이 있습니다. 업데이트를 진행합니다."

    ${CATALINA_HOME}/bin/shutdown.sh

    # Git에서 최신 소스 클론
    git pull origin main

    # ROOT.war 파일을 Tomcat webapps 디렉터리로 복사
    cp -f ./ROOT.war /usr/local/tomcat/webapps/ROOT.war

    ${CATALINA_HOME}/bin/startup.sh

    echo "업데이트가 완료되었습니다."
else
    echo "최신 커밋이 이미 적용되어 있습니다. 업데이트가 필요하지 않습니다."
fi

popd

