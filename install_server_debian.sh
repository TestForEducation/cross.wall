echo ;
echo ;
echo 正在安装服务器，请稍候.......... ;
echo ;

cd / ;
apt-get update > /dev/null ;
# apt-get install default-jdk squid pwgen git -y -q > /dev/null ;
apt-get install default-jdk   -y -q > /dev/null ;
apt-get install   squid3   -y -q > /dev/null ;
apt-get install   pwgen   -y -q > /dev/null ;
apt-get install   git -y -q > /dev/null ;
if [ -e "/etc/squid3/squid.conf" ] ; then
sed -i "s/shutdown_lifetime 3 seconds//g" /etc/squid3/squid.conf ;
sed -i "s/access_log none//g" /etc/squid3/squid.conf ;
sed -i "s/cache_log \/dev\/null//g" /etc/squid3/squid.conf ;
sed -i "s/logfile_rotate 0//g" /etc/squid3/squid.conf ;
sed -i "s/cache deny all//g" /etc/squid3/squid.conf ;
echo "shutdown_lifetime 3 seconds" >> /etc/squid3/squid.conf ;
echo "access_log none" >> /etc/squid3/squid.conf ;
echo "cache_log /dev/null" >> /etc/squid3/squid.conf ;
echo "logfile_rotate 0" >> /etc/squid3/squid.conf ;
echo "cache deny all" >> /etc/squid3/squid.conf ;
fi;
update-rc.d squid3 defaults > /dev/null ;
service squid3 restart > /dev/null ;

if [ -e "/cross.wall" ] ; then

echo "目录 /cross.wall 已经存在，安装退出" ;
echo ;
echo "如需重新安装，请先把目录 /cross.wall 改名或删除" ;

else

git clone https://github.com/TestForEducation/cross.wall.git ;

chmod a+x /cross.wall/server.sh ;
chmod a+x /cross.wall/stop.sh ;
for i in $( seq 20001 20003 )
do pwgen -n -s -B -c 10 | sed "s/^/$i /";
done > /cross.wall/user.tx_ ;
rm -f /cross.wall/user.txt ;
cp /cross.wall/user.tx_ /cross.wall/user.txt ;

sed -i "s/-Xms512M/-Xms256M/g" /cross.wall/server.sh ;
sed -i "s/-Xmx512M/-Xmx256M/g" /cross.wall/server.sh ;

# iptables -F ;

# iptables -A INPUT -p tcp --dport 26461 -j ACCEPT ;
# iptables -A INPUT -p tcp --dport 80 -j ACCEPT ;

# iptables -A INPUT -p tcp --dport 5128 -j ACCEPT ;
# iptables -A INPUT -p udp --dport 5128 -j ACCEPT ;

# iptables -A INPUT -p tcp --dport 443 -j ACCEPT ;
# iptables -A INPUT -p tcp --dport 25 -j ACCEPT ;

# iptables -A INPUT -p tcp --dport 20000:20003 -j ACCEPT ;
# iptables -A INPUT -p tcp --dport 28040:28050 -j ACCEPT ;
# iptables -P INPUT DROP ;
# iptables -P FORWARD DROP ;
# iptables -P OUTPUT ACCEPT ;
# iptables -A INPUT -i lo -j ACCEPT ;
# iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT ;
# iptables -A INPUT -p icmp -j ACCEPT ;
# iptables-save > /dev/null ;

echo ;
echo "已完成服务器安装" ;
echo ;
echo "端口和密码在文件 /cross.wall/user.txt" ;
echo ;
echo "启动服务器请执行 /cross.wall/server.sh " ;

fi;

echo ;
echo ;
