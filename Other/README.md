# 文件说明
该文件夹是折腾失败的备份区  
**不要放入EFI中！**  
**不要放入EFI中！**  
**不要放入EFI中！**  

| 文件(夹)                      | 作用              | 备注                         |
|-------------------------------|-------------------|------------------------------|
| AppleIntelWifiAdapterV2.kext  | Intel无线驱动     | 能扫描但是无法连接到wifi     |
| HoRNDIS.kext                  | USB热点拓展       | 10.14睡眠后偶尔假死          |
| VoodooI2C.kext                | I2C总线核心驱动   |                              |
| VoodooI2CHID.kext             | HID设备驱动       | 依赖于VoodooI2C.kext         |
| itlwm.kext                    | intel wifi驱动    | SSID：China passwd：ChinaNB6 |
| itlwmx.kext                   | 疑似AX200系列驱动 | SSID：China passwd：ChinaNB6 |
| itl80211.kext                 | itlwm的库         |                              |
|                               |                   |                              |
| origin                        | clover提取的DSDT  |                              |
| acpi_dsdt.aml win下提取的DSDT |                   | 理论上和origin内的DSDT一样   |

## 触控板参数
| 项目     | 值                  | 备注                       |
|----------|---------------------|----------------------------|
| BIOS名称 | \_SB.PCI0.I2C1.ETPD | I2C0下还有一个TPD0不要改错 |
| 设备ID   | ELAN1000            |                            |
| Pin(IRQ) | 0x6D                |                            |
| CID      | PNP0C50             |                            |