#!/bin/sh

CHECK()
{
echo -e "\033[33m 正在为您校验jdk安装包... \033[0m"

if [ -f "${myway}/jdk-8u221-linux-x64.rpm" ];then

echo -e "\033[32m 校验成功！！ \033[0m"

INSTALL_ING

else
echo -e "\033[31m 校验失败！！请上传jdk安装包至'${myway}'文件夹下 \033[0m"
	exit
fi

}
PRESS_INSTALL()
{
    echo -e "\033[32m 即将安装JDK... \033[0m"
	echo -e "\033[32m Press any key to install...or Press Ctrl+c to cancel \033[0m"
    SAVE=`stty -g`
    stty -icanon -echo min 1 time 0
    dd count=1 2>/dev/null
    stty ${SAVE}
}

INSTALL_ING()
{

PRESS_INSTALL

echo -e "\033[32m 开始安装JDK... \033[0m"

rpm -ivh jdk-8u221-linux-x64.rpm

echo "#JAVA_HOME">>/etc/profile
echo "JAVA_HOME=/usr/java/jdk1.8.0_221-amd64">>/etc/profile
echo "JRE_HOME=/usr/java/jdk1.8.0_221-amd64/jre">>/etc/profile
echo "PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin">>/etc/profile
echo "CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib">>/etc/profile
echo "export JAVA_HOME JRE_HOME PATH CLASSPATH">>/etc/profile

source /etc/profile

java -version
if [ $? -eq 0 ]; then
	echo -e "\033[32m 安装成功！！！ \033[0m"

	else
	echo -e "\033[031m 安装失败！！！ \033[0m"
   exit
fi
}

#####################################################

#输入n
STOP_UNINSTALL()
{
    echo -e "\033[33m 已停止卸载!! \033[0m"
	exit
}

#####################################################

#输入错误
UNINSTALL_AGAIN()
{
  echo -e "\033[33m 请重新输入!!! \033[0m"
  UNINSTALL_CHOOSE
}

#输入y
UNINSTALL_ING()
{
 killall -9 java

 rpm -qa | grep jdk | xargs rpm -e --nodeps
 
 java -version
 
if [ $? -eq 0 ]; then

	echo -e "\033[031m 卸载失败，请手动用rm命令卸载!! \033[0m"
    exit	
else
	echo -e "\033[32m 卸载成功！！！ \033[0m"
	echo "即将开始JDK安装！！"

	INSTALL_ING
	
fi
}
#####################################################

#开始输入
UNINSTALL_CHOOSE()
{
 read -p "是否卸载JDK？yes/no: "  Select

 case "${Select}" in
    y|Y|yes)
        Select="y"
		UNINSTALL_ING
    ;;
    n|N|no)
	    Select="n"
		STOP_UNINSTALL
    ;;
	*)
        echo "输入错误"
		UNINSTALL_AGAIN
    esac
	

}

######################################################

#程序从这里开始
myway=`pwd`

JDK=`rpm -qa | grep jdk`

echo -e "\033[33m 开始检测本机是否安装JDK... \033[0m"

echo -e "\033[33m 开始检测本机是否安装JDK... \033[0m"
VS=`java -version`
if [ $? -eq 0 ]; then
    echo -e "\033[33m 检测到您已安装JDK,版本为"${VS}" \033[0m"
    
	UNINSTALL_CHOOSE
        else
		echo -e "\033[33m 检测到您尚未安装JDK，将为您自动安装!! \033[0m"
		
		CHECK		

fi


