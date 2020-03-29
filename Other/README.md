# 文件说明
该文件夹是折腾失败的备份区，不要放入EFI中。

| 文件(夹)                      | 作用             | 备注                       |
|-------------------------------|------------------|----------------------------|
| kext                          | 驱动             |                            |
| AppleIntelWifiAdapterV2.kext  | Intel无线驱动    | 适用于10.15+               |
| HoRNDIS.kext                  | USB热点拓展      | 10.14睡眠后偶尔假死        |
| VoodooI2C.kext                | I2C总线核心驱动  |                            |
| VoodooI2CHID.kext             | HID设备驱动      | 依赖于VoodooI2C.kext       |
|                               |                  |                            |
| origin                        | clover提取的DSDT |                            |
| acpi_dsdt.aml win下提取的DSDT |                  | 理论上和origin内的DSDT一样 |

## 触控板参数
| 项目     | 值                  | 备注                 |
|----------|---------------------|----------------------|
| BIOS名称 | \_SB.PCI0.I2C1.ETPD | I2C0下还有一个TPD0…… |
| 设备ID   | ELAN1000            |                      |
| Pin(IRQ) | 0x6D                |                      |
| CID      | PNP0C50             | ACPI中TPD0也指向它   |