cd `dirname $0`

_java="java -Dfile.encoding=utf-8 -Dsun.jnu.encoding=utf-8 -Duser.timezone=Asia/Shanghai  -Xms512M -Xmx512M -classpath `find ./lib/*.jar | xargs echo | sed 's/ /:/g'`:./bin"

_pack="wall.cross"

kill -9 `jps -l |grep $_pack.Server |awk '{print $1}'` > null 2>&1

nohup $_java $_pack.Server >> server.log 2>&1 &
