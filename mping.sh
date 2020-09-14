#!/bin/bash
#####		一键Ping测试			#####
#####		Author:xiaoz.me			#####
#####		Update:2019-06-03		#####

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/bin:/sbin
export PATH

#获取服务器公网IP
osip='no need'

location=(
		'四川 电信'
		'天津 电信'
		'江苏 电信'
		'四川 联通'
		'河北 联通'
		'浙江 联通'
		'安徽 移动'
		'山东 移动'
		'四川 移动'
		'广东 移动'
	)
#各地区DNS，来源于http://dns.lisect.com/ and https://www.ip.cn/dns.html
dnsip=(
	'61.139.2.69'		#四川 电信
	'219.150.32.132'	#天津 电信
	'218.2.2.2'			#江苏 电信
	'119.6.6.6'			#四川 联通
	'202.99.160.68'		#河北 联通
	'221.12.1.227'		#浙江 联通
	'211.138.180.2'		#安徽 移动
	'218.201.96.130'	#山东 移动
	'223.87.238.22'		#四川 移动
	'211.139.129.222'	#广东 移动
)
echo '---------------------------------------------------------------------------'
echo "您的本机IP为：[$osip]"
function mping(){
	num=0
	#Ping次数
	pnum=$1

	#echo '---------------------------------------------------------------------------'
	echo "正在进行Ping测试，请稍后..."
	echo '---------------------------------------------------------------------------'

	while(( $num<10 ))
	do
		ping ${dnsip[$num]} -c $pnum > /tmp/${dnsip[$num]}.txt
		echo 【${location[$num]}】 - ${dnsip[$num]}
		echo ''
		tail -2 /tmp/${dnsip[$num]}.txt
		echo '---------------------------------------------------------------------------'
		let "num++"
	done
	echo "【参数说明】"
	echo "x% packet loss: 丢包率"
	echo "min: 最低延迟"
	echo "avg: 平均延迟"
	echo "max: 最高延迟"
	echo "mdev: 平均偏差"

	echo '---------------------------------------------------------------------------'
}

function moretrace(){
	#检查besttrace是否存在
	if [ ! -f "./besttrace" ]
	then
		#下载besttrace
		wget -q http://soft.xiaoz.org/linux/besttrace
		#添加执行权限
		chmod +x ./besttrace
	fi

	#进行路由跟踪
	echo '---------------------------------------------------------------------------'
	echo '正在进行路由跟踪，请稍后...'
	echo '---------------------------------------------------------------------------'
	echo '【四川电信】 - 61.139.2.69'
	echo ''
	./besttrace -q 1 61.139.2.69
	echo '---------------------------------------------------------------------------'

	echo '【河北 联通】- 202.99.160.68'
	echo ''
	./besttrace -q 1 202.99.160.68
	echo '---------------------------------------------------------------------------'

	echo '【安徽 移动】 - 211.138.180.2'
	echo ''
	./besttrace -q 1 211.138.180.2
	echo '---------------------------------------------------------------------------'
}

mping 10
echo ''
moretrace
echo ''
echo '此结果由mping生成:https://www.xiaoz.me/archives/13044'
echo ''
