cmjavaopts=-Djava.awt.headless=true -XX:+UseCompressedOops -XX:-OmitStackTraceInFastThrow -DLog4jContextSelector=org.apache.logging.log4j.core.async.AsyncLoggerContextSelector -Djava.security.egd=file:/dev/./urandom -Duser.timezone=GMT+3 -Dspring.profiles.active=oracle,scm,admin -Xms128m -Xmx2g
docker run --name silCM -v cmconf:/tomcat/conf \
  -e RUN_USER_ID=`id -u $USER` \
  -e RUN_USER=$USER \
  -e JAVA_OPTS=$cmjavaopts \
  --add-host='logserver:10.101.228.234' \
  --add-host='redis-master:10.108.0.98' \
  --add-host='redis-slave:10.111.55.221' \
  --add-host='elasticsearch:10.110.36.86' \
  --add-host='cm-db:10.111.23.18' \
  --add-host='ocr:10.111.77.223' \
  -p 8000:8000 \
  10.151.17.110/edbys/hvlcm:3.4.740
#   10.151.17.110/edbys/hvlcm-serkan:3.4.740