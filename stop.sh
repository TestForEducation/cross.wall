cd `dirname $0`

_pack="wall.cross"

kill -9 `jps -l |grep $_pack.Server |awk '{print $1}'` > null 2>&1
