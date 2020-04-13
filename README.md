# ASUS A456U for macOS Hackintosh
给自己旧笔记本安装了黑果尝鲜，体验还是可以的，分享一下EFI，造福相同型号的本本。  
![system_info](./Other/system_info.png)

## 配置
| 规格     | 详细信息                                       | 备注                             |
|----------|------------------------------------------------|----------------------------------|
| BIOS     | X456UV.302                                     |                                  |
| 操作系统 | MacOS ~~Mojave 10.14.5 (18E226)~~              | 已升级至  `Catalina  10.15.4`    |
| CPU      | Intel Core i5-6200U, 2700 MHz  双核            |                                  |
| 显卡     | `Intel HD Graphics 520` / NVIDIA GeForce 920MX |                                  |
| 声卡     | Conexant SmartAudio HD (Conexant Unknown）     | 实际型号为 `CX8050` layout：`13` |
| 触控板   | I2C HID 设备(ELAN 1000)                        |                                  |
| 无线网卡 | Intel&reg; Wireless-AC 9260                    | 已更换                           |
| 有线网卡 | Realtek RTL8111 PCI-E Gigabit Ethernet         |                                  |

## 说明

1. 完成度：大概、应该、也许、Maybe 90%。
2. 若安装 `Mojave 10.14.5` 请务必保证磁盘至少有 `25GB` 的空间。建议容量：尝鲜(40GB),长期使用(60GB+)。
3. 镜像来自 [黑果小兵](https://blog.daliansky.net/)，感谢大佬提供的镜像和十分硬核的教程。
4. 请安装完成 **后** 再进行EFI替换。
5. 部分可能用得到的工具已上传 [百度云](https://pan.baidu.com/s/10DGeGL3vFaZgCVVZD2OZRA) 
提取码：0kiv。
6. 当遇到无法引导时请尝试使用 `config_init.plist` 进行引导。
7. 请务必使用USB2.0口进行操作系统安装(包括Windows和Linux)
> 10.14**请勿直接升级**10.15。

功能快速预览
| 功能/设备      | 能用 | 不能用 | 备注         |
|----------------|:----:|:------:|--------------|
| CX8050音频     | [x]  |        |              |
| 核显HD520      | [x]  |        |              |
| 独显920MX      |      |  [x]   |              |
| HDMI           |      |  [x]   | 10.15.3 可用 |
| 有线网卡       | [x]  |        |              |
| 蓝牙           | [x]  |        | 10.15+ 可用  |
| WiFi           |      |  [x]   |              |
| CPU变频        | [x]  |        |              |
| 触控板&手势    | [x]  |        |              |
| Fn键           | [x]  |        |              |
| 摄像头         | [x]  |        |              |
| 电池           | [x]  |        |              |
| USB3.0 & TypeC | [x]  |        |              |


## 哪些不能用？
>当你能忍受某个事物所有缺点，那么她一定适合你。

### 1.独显显卡 `GeForce 920MX`
笔记本N系1060以下的独显无法驱动，且BIOS无法屏蔽核显。    
>`920MX` 输出单元被屏蔽，也不支持`CUDA`，好像真的没用……

### ~~2.触控板(请务必外接USB/蓝牙鼠标！)~~
已修复，感谢[望海之洲](https://www.penghubingzhou.cn)提供的[教程](https://www.penghubingzhou.cn/2019/07/24/VoodooI2C%20DSDT%20Edit%20FAQ/)

>clover和win下提取原版DSDT备份在`Other/origin`    

### 3. WIFI !
1. 为了160MHz换掉了原配的网卡，持有原卡的朋友试验过 `IO80211FamilyV2.kext` 可以驱动，有需要的充分利用百度下载安装。  
2. 和我一样换了Intel无线网卡的同学那我只能恭喜你了，你找到了一个了一(shi)战(ji)成(nan)名(ti)的机会。  
~~目前已知 `AppleIntelWifiAdapt` 能支持无线，GitHub下载编译即可，但该项目基于`10.15` API 开发……~~  
实践证明 `AppleIntelWifiAdapt` 目前版本无法驱动 `Intel 9260`

附： `AppleIntelWiFiMVM` 支持列表(该项目2016年停止维护)
* Intel&reg; Wireless 3160
* Intel&reg; Wireless 3165
* Intel&reg; Wireless 4165
* Intel&reg; Wireless 7260
* Intel&reg; Wireless 7265
* Intel&reg; Wireless 8260
* NUC on-board wireless for NUC 5i\*RY\*
* NUC on-board wireless for NUC 6i\*SY\*

### 4.隔空投送
没有苹果设备，而且网卡貌似也不支持

## Intel蓝牙问题
`10.15` 以前的版本,若蓝牙无法连接/搜索 请从 Windows **热重启** 进入MacOS。  
`10.15` 之后的版本注入zxystd大佬的 [IntelBluetoothFirmware](https://github.com/zxystd/IntelBluetoothFirmware/releases) 解决
>尽量使用 `1.0.3` 版本,两个驱动一起注入。

## Fn按键
1. Fn按键目前`亮度调节`和`禁用触控板`暂时无法使用,可以自己修改DSDT调整  
2. 另外 `Fn + F1` 休眠建议不要使用。按下之后会立即给`USB`和`键盘`断电，只有`电源键`才能唤醒并且有概率无法唤醒。
3. Fn休眠无法唤醒后第一次启动到clover的时候无法正常加载键盘  
   临时解决方案：
   1. 设置默认引导项目
   2. 手动从BIOS引导至Windows

## HDMI问题
升级到10.15.4之后HDMI出现了无法使用的情况，且不是个例。  
有投影需求的建议使用10.15.3，搭配旧版本的EFI使用。  
>如果投影设备支持你可以使用 `隔空投屏` 暂时替代一下

## 开启HiDPI支持
源自 [one-key-hidpi](https://github.com/xzhih/one-key-hidpi) 项目  

> 该脚本还可修复关机花屏的问题  
> 若需要修复花屏请务必注入EDID

## NTFS 问题
**请不要尝试使用任何方法让MacOS对NTFS进行读写！**  
**请不要尝试使用任何方法让MacOS对NTFS进行读写！**  
**请不要尝试使用任何方法让MacOS对NTFS进行读写！**  
我知道有很多方法可以让MacOS读取NTSF卷，但是无论是所谓的 `原生` 还是 `NTFS for Mac` 都有可能造成NTFS卷损坏  

### 修复方案
1.回到Windows 或者winPE尝试使用以下命令修复(数据无损)
``` shell
chkdsk D: /f
```
>注意以管理员身份执行  
`D:` 是损坏的卷标(盘符)  

2.若仍然无效请尝试使用DG修复分区(数据无损)  

3.准备数据救援或者直接格盘吧

>友情提示：我的非气会传染，我身边的朋友包括我自己都翻车了。而且是移动硬盘附赠的正版 `NTFS for Mac` ！

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
>请务必使用 `iasl` 进行编译和反编译，`MaciASL` 不支持`iASL 6.1` !

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

>1. 若MaciASL补丁长时间无法加载可到[GitHub](https://github.com/RehabMan/Laptop-DSDT-Patch)下载
>2. 无视 `MaciASL` 所有报错，一切以 `iasl` 输出为准!

## 升级后无法启动解决方案
1. 升级`lilu.kext` 和 `WhateverGreen.kext`
2. 临时注入显卡ID`0x12345678`, 进入系统重新注入正确ID
3. 进入Recovery模式重建缓存或删除`/System/Library/Caches` 目录下所有内容

## 升级后触控板丢失解决方案
1. Clover禁止加载 `AppleIntelLpssI2C.kext` 和 `AppleIntelLpssI2CController.kext` 两个驱动
2. 从SLE中删除上述文件。
 
# update for 10.15.3

## 相比10.14的变化
>基本没有变动，主要是修复驱动
1. ~~HDMI有声音了，虽然声音是笔记本声卡发出的……~~ 升级到 `10.15.4` 时候HDMI炸了，现在只能使用隔空播放……(**有投影需求的慎重请升级**)
2. 注入了白果三码,**在修改三码之前请勿登录IMessage！**(该码来自互联网可能有大量人使用，封号别来找我)
3. 蓝牙再也不用从win重启了
4. Fn按键可以使用了

## 使用建议
1. 不要在有重要资料的硬盘安装MacOS
2. 放下对NTFS的执念，真想试验那么请不要对NTFS执行**写**操作和**密集的读取**操作
3. 双系统建议建立独立 `exFAT` 分区，作为文件交换使用(本非酋 `NTFS for mac` 也翻车了，硬盘有价数据无价)


## 如有其他问题和建议可以在Issue告知我

国内的童鞋我同步了 [Coding](https://e.coding.net/zewenchenkmfoxm/ASUS_X456UV_Hackintosh_EFI.git)