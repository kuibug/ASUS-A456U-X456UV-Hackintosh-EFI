#!/bin/bash
echo "======Script Start========"

echo "请先把驱动和脚本放在相同目录中!"

echo -e "1.安装驱动\n2.打印日志";
read -p "请输入数字:" item;

case $item in 
    1) cp -R itlwm.kext /tmp;
    sudo chown -R root:wheel /tmp/itlwm.kext;
    sudo kextutil /tmp/itlwm.kext;
    if [ $? == 0 ];
        then echo "OK......安装成功。";
        else echo "Failed......安装失败！";
    fi;;

    2) log show --last boot | grep 'itlwm' >> ~/Desktop/itlwm.log;
    if [ $? == 0 ];
        then echo "OK......日志已保存到桌面。";
        else echo "Failed......日志抓取失败！";
    fi;;
esac;

echo "======Script End========"

