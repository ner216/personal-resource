# Platform firmware options exposed to Linux kernel

### Legacy Dell notes:
- libsmbios was used between 2016-2019
- The move toward sysman was gradual, an application manager would need to check both directories.

### Management controls location for modern(2020+) Dell systems:
- Around 2020-2021, Dell moved their controls for enterprise systems here.
- `/sys/class/firmware-attributes/`

### Dell specific sysfs entries:
- `/sys/devices/platform/`


