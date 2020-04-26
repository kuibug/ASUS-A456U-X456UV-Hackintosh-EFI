   #!/bin/bash

# 驱动放置目录
path='/Desktop/itlwm';
pwd;
function result(){
    if [ $? == 0 ];
        then echo "OK......安装成功。";
        else echo "Failed......安装失败！";
    fi;
}

echo "======itlwm Script========"

echo "请先把驱动放在 ${HOME}${path} 目录中!\n";

# cd ${HOME}${path};    //WTF?
cd ~/Desktop/itlwm;

pwd;
echo -e "1.安装ltlwm.kext,支持型号：
    3 系：3160、3165、3168
    7 系：7260、7265 
    8 系：8260、8265 
    9 系：9260、9560、9462";
echo -e "2.打印日志";
echo -e "3.状态检测";
echo -e "4.卸载驱动 (请勿使用！)"; 
echo -e "5.安装itlwmx驱动(项目并未表示支持，但是资源中有AX200系列的ucode文件)";

echo -e "\n***0.退出脚本***\n"
read -p "请输入数字:" item; 

case $item in 
    0) echo "======Script End========";
    exit;;

    1) sudo cp -R itlwm.kext /tmp;
    sudo chown -R root:wheel /tmp/itlwm.kext;
    sudo kextutil /tmp/itlwm.kext;
    result;;

    2) log show --last boot | grep 'itl' >> ~/Desktop/itlwm.log;
    if [ $? == 0 ];
        then echo "OK......日志已保存到桌面。";
        else echo "Failed......日志抓取失败！";
    fi;;

    3) echo "已加载驱动：" 
    kextstat | grep zxystd;;

#    4) sudo kextunload -b com.zxystd.itlwm;;  # 卸载驱动重启？？？WTF？
    4) echo "大哥，不是让你别用嘛！";;  

    5) sudo cp -R itlwmx.kext /tmp; #服务和 itlwm 同名？看了一下应是从Linux移植的AX200系列驱动`iwlwifi-cc-a0-46.ucode` 不保证能用
    sudo chown -R root:wheel /tmp/itlwmx.kext;
    sudo kextutil /tmp/itlwmx.kext; 
    result;;

esac; 

echo "======Script End========"
