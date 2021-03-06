# ASUS A456U for MacOS Hackintosh
给自己旧笔记本安装了黑果尝鲜，体验还是可以的，分享一下EFI，造福相同型号的本本。  
![system_info](./Other/system_info.png)

## 配置
| 规格     | 详细信息                                       | 备注                             |
|----------|------------------------------------------------|----------------------------------|
| BIOS     | X456UV.302                                     |                                  |
| 操作系统 | MacOS ~~Mojave 10.14.5 (18E226)~~              | 已升级至  `Catalina  10.15.7`    |
| CPU      | Intel Core i5-6200U, 2700 MHz  双核            |                                  |
| 显卡     | `Intel HD Graphics 520` / NVIDIA GeForce 920MX |                                  |
| 声卡     | Conexant SmartAudio HD (Conexant Unknown）     | 实际型号为 `CX8050` layout：`13` |
| 触控板   | I2C HID 设备(ELAN 1000)                        |                                  |
| 无线网卡 | Intel&reg; Wireless-AC 9260                    | 已更换                           |
| 有线网卡 | Realtek RTL8111 PCI-E Gigabit Ethernet         |                                  |

## 说明

1. 完成度：基本完美。
2. 请务必保证磁盘至少有 `25GB` 的空间。建议容量：尝鲜(40GB),长期使用(60GB+)。
3. 镜像来自 [黑果小兵](https://blog.daliansky.net/) ，感谢大佬提供的镜像和十分硬核的教程。
4. 安装无法引导时请尝试使用 `config_init.plist` 进行引导。
5. 请务必使用右侧的**USB2.0**口进行操作系统安装。

> ⚠️10.14**请勿直接升级**10.15。  
> ⚠️**修改三码之前请勿登陆IMessage等应用**! <font size='1'>封号别来找我/doge</font>

功能快速预览
✅ 完美
⭕️ 能用但是有问题
❌ 不可用

| 功能/设备      | 能用 | 不能用 | 备注              |
|----------------|:----:|:------:|-------------------|
| CX8050音频     |  ✅   |        |                   |
| 核显HD520      |  ✅   |        |                   |
| 独显920MX      |      |   ❌    |                   |
| HDMI           |  ✅   |        |                   |
| 有线网卡       |  ✅   |        |                   |
| 蓝牙           |  ✅   |        |                   |
| WiFi           |  ✅   |        |                   |
| CPU变频        |  ✅   |        |                   |
| 触控板&手势    |  ✅   |        |                   |
| Fn键           |  ⭕️   |        | [Fn问题](#Fn按键) |
| 摄像头         |  ✅   |        |                   |
| 电池           |  ✅   |        |                   |
| USB3.0 & TypeC |  ✅   |        |                   |

## 独显 `GeForce 920MX`
笔记本N系1060以下的独显无法驱动，且BIOS无法屏蔽核显。    

## 触控板~~(请务必外接USB/蓝牙鼠标！)~~
已修复，感谢 [望海之洲](https://www.penghubingzhou.cn) 提供的 [教程](https://www.penghubingzhou.cn/2019/07/24/VoodooI2C%20DSDT%20Edit%20FAQ/)

## WIFI
1. 为了160MHz换掉了原配的网卡，持有原卡的朋友试验过 `IO80211FamilyV2.kext` 可以驱动，有需要的充分利用百度下载安装。  
2. 和我一样换了Intel无线网卡的，可以尝试 [itlwm](https://github.com/zxystd/itlwm) 配合 [HeliPort](https://github.com/OpenIntelWireless/HeliPort) 食用味道更佳。
3. Airport 功能未测试，需要的到 `itlwm` 下载对应版本驱动。
 
## Fn按键
1. Fn按键目前 `亮度调节` 和 `禁用触控板` 暂时无法使用,可以自己修改DSDT调整  
2. 另外 `Fn + F1` 休眠建议**不使用**! 按下之后会立即给`USB`和`键盘`断电，只有`电源键`才能唤醒并且**无法唤醒**!
3. Fn休眠无法唤醒后第一次启动到clover的时候无法正常加载键盘  
   临时解决方案：
   1. 设置默认引导项目
   2. 手动从BIOS引导至Windows

## HDMI
HDMI 目前声音仍然从内建声卡输出  

## 开启HiDPI支持
源自 [one-key-hidpi](https://github.com/xzhih/one-key-hidpi) 项目  
> 请务必注入EDID

## NTFS 问题
**请不要尝试使用任何方法让MacOS对NTFS进行读写！**  
**请不要尝试使用任何方法让MacOS对NTFS进行读写！**  
**请不要尝试使用任何方法让MacOS对NTFS进行读写！**  
我知道有很多方法可以让MacOS读取NTSF卷，但是无论是所谓的 `原生` 还是 `NTFS for Mac` 都有可能造成NTFS卷损坏  
>友情提示：我希捷移动硬盘附赠的正版 `NTFS for Mac` 翻车了！

### 修复方案
1.回到Windows 或者winPE尝试使用以下命令修复(数据无损)
``` shell
chkdsk D: /f
```
>注意以管理员身份执行  
`D:` 是损坏的卷标(盘符)  

2.若仍然无效请尝试使用DG修复分区(数据无损)  

3.准备数据救援或者直接格盘吧

## DSDT修改
### 工具
1. dsl编辑工具 `MaciASL`
2. 编译/反编译工具：`iasl`
3. RehabMan补丁库地址: http://raw.github.com/RehabMan/Laptop-DSDT-Patch/master
    
### iasl使用方法：

下载解压iasl,复制到/usr/bin
打开终端，联合编译dsdt ssdt
``` shell
iasl -da -dl DSDT.aml SSDT*.aml
iasl -da -dl dsdt ssdt*
```

单独把DSDT.aml转成DSDT.dsl(与联合编译二选一)
``` shell
iasl -da -dl DSDT.aml
```

编译DSDT.dsl 提示错误,如果没错误就生成DSDT.aml
```shell
iasl -ve DSDT.dsl
```
>建议使用联合编译，减少报错。

### 原版DSTD除错
>仅仅适用于当前机型，其余机型请在有DSDT基础上操作。

#### unexpected PARSEOP_ZERO 错误
- 方法1  
  删除一排排的ZREO
- 方法2  
  使用 `fix_PARSEOP_ZERO` 补丁
   
### unexpected PARSEOP_ARG0 错误
- 第一处：  
使用 `fix_ADBG` 补丁  
或者 删除错误处方法体

- 第二处  
   报错处修改为`Return (SDSM( Arg0, Arg1, Arg2, Arg3))`  
   然后把 `External (SDSM, IntObj)` 改成 `External (SDSM, MethodObj)`

>1. 请务必使用 `iasl` 进行编译和反编译，`MaciASL` 不支持`iASL 6.1` !
>2. 若MaciASL补丁长时间无法加载可到 [GitHub](https://github.com/RehabMan/Laptop-DSDT-Patch) 下载
>3. 无视 `MaciASL` 所有报错，一切以 `iasl` 输出为准!


## 升级后无法启动解决方案
1. 升级`Clover`、`lilu.kext` 和 `WhateverGreen.kext`
2. 临时注入显卡ID`0x12345678`, 进入系统重新注入正确ID
3. 进入Recovery模式重建缓存或删除`/System/Library/Caches` 目录下所有内容

## 升级后触控板丢失解决方案
1. Clover禁止加载 `AppleIntelLpssI2C.kext` 和 `AppleIntelLpssI2CController.kext` 两个驱动
2. 从SLE中删除上述文件。
 
## 使用建议
1. 不要在有重要资料的硬盘安装MacOS
2. 放下对NTFS的执念，真想试验那么请不要对NTFS执行**写**操作和**密集的读取**操作
3. 双系统建议建立独立 `exFAT` 分区，作为文件交换使用(本非酋 `NTFS for mac` 也翻车了，硬盘有价数据无价)

> 附：大佬收集的 [常用驱动列表](https://blog.tlhub.cn/hackintosh-tools.html)  
> 挖坑：后期有时间折腾一下OC(大佬们逐渐放弃clover的兼容测试...)