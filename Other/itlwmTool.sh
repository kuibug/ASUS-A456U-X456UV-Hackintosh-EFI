#!/bin/bash

# 变量配置
export install_path="/tmp"  #驱动安装目录
export itlwm_path="./Desktop/itlwm"     #itlwm.kext存放目录
export itlwmx_path="./Desktop/itlwm"    #itlwmx.kext存放目录
export AppleIntelWifiAdapterV2_path="./git/adapter/build/Build/Products/Debug"  #AppleIntelWifiAdapterV2存放目录

function installKext(){
#   echo $@
    local file=$2/$1    #kext文件完整路径
    local kext=${install_path}/$1   #安装后的完整路径

    sudo cp -R ${file} ${install_path};
    sudo chown -R root:wheel ${kext};
    sudo kextutil ${kext}

    if [ $? == 0 ];
        then echo '✅OK......安装成功。';
        else echo '❌Failed......安装失败！';
    fi;
}

# 检查驱动是否存在
function checkFile(){
    if [ -d "$2/$1" ];
        then echo -e "✅ 发现驱动文件$1"
        else echo -e "⚠️ 未找到驱动文件$2/$1"
    fi
}

function End(){
    echo '======Script End========'
}

echo '======itlwm Script========'
#脚本开始前先检查驱动
checkFile itlwm.kext ${itlwm_path}
checkFile itlwmx.kext ${itlwmx_path}
checkFile AppleIntelWifiAdapterV2.kext ${AppleIntelWifiAdapterV2_path}
# start
echo ""
echo  '1.安装ltlwm.kext(支持型号：3, 7, 8, 9 系)';
echo  '2.打印日志';
echo  '3.状态检测';
echo  '4.卸载驱动 (请勿使用！)'; 
echo  '5.安装itlwmx驱动(项目并未表示支持，但是资源中有AX200系列的ucode文件)';
echo  '6.安装AppleIntelWifiAdpte(无法连接到Wi-Fi)';

echo -e '\n***0.退出脚本***\n'
read -p '请输入数字:' item; 

case $item in 
    0) End;;

    1) installKext itlwm.kext ${itlwm_path}
    End;;

    2) log show --last boot | grep 'itlwm' >> ~/Desktop/itlwm.log;
    echo '✅OK......日志已保存到~/Desktop/itlwm.log。';
    log show --last boot | grep 'AppleIntelWifiAdapterV2' >> ~/Desktop/AppleIntelWifiAdapterV2.log;
    echo '✅OK......日志已保存到~/Desktop/AppleIntelWifiAdapterV2.log。';
    End;;

    3) echo '已加载Intel Wi-Fi驱动：' 
    kextstat | grep -e zxystd -e AppleIntelWifiAdapterV2
    End;;

#    4) sudo kextunload -b com.zxystd.itlwm;;  # 卸载驱动重启？？？WTF？
    4) echo '大哥，不是让你别用嘛！'
    End;;

    # 服务和 itlwm 同名？看了一下应是从Linux移植的AX200系列驱动`iwlwifi-cc-a0-46.ucode` 不保证能用
    5)installKext itlwmx.kext ${itlwmx_path} 
    End;;

    6)installKext AppleIntelWifiAdapterV2.kext ${AppleIntelWifiAdapterV2_path}
    End;;

    *)echo '大哥看准了再输入！'
    End;;

esac
