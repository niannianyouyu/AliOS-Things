NAME := board_esp32devkitc

$(NAME)_MBINS_TYPE := kernel
$(NAME)_VERSION    := 1.0.0
$(NAME)_SUMMARY    := configuration for board esp32devkitc
MODULE             := 1062
HOST_ARCH          := xtensa
HOST_MCU_FAMILY    := mcu_esp32
SUPPORT_MBINS      := no

# todo: remove these after rhino/lwip ready
osal ?= rhino

$(NAME)_COMPONENTS += $(HOST_MCU_FAMILY) osal init

CONFIG_SYSINFO_PRODUCT_MODEL := ALI_AOS_ESP32
CONFIG_SYSINFO_DEVICE_NAME   := ESP32

GLOBAL_CFLAGS += -DSYSINFO_PRODUCT_MODEL=\"$(CONFIG_SYSINFO_PRODUCT_MODEL)\"
GLOBAL_CFLAGS += -DSYSINFO_DEVICE_NAME=\"$(CONFIG_SYSINFO_DEVICE_NAME)\"  -DCONFIG_AOS_FATFS_SUPPORT_RAW_FLASH
GLOBAL_DEFINES += LOG_LOCAL_LEVEL=4

ifeq ($(dual), 1)
GLOBAL_DEFINES += RHINO_CONFIG_CPU_NUM=2
GLOBAL_ASMFLAGS += -DRHINO_CONFIG_CPU_NUM=2
OS_MUTICORE_NUM ?= 2
else
GLOBAL_DEFINES += RHINO_CONFIG_CPU_NUM=1
GLOBAL_ASMFLAGS += -DRHINO_CONFIG_CPU_NUM=1
endif

GLOBAL_INCLUDES += .
$(NAME)_SOURCES := board.c

EXTRA_TARGET_MAKEFILES +=  $($(HOST_MCU_FAMILY)_LOCATION)/gen_crc_bin.mk

ifeq ($(hci_h4),1)
GLOBAL_CFLAGS += -DCONFIG_BLE_HCI_H4_UART_PORT=1
endif
