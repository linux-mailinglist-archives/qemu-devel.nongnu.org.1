Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1768D96A3E3
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Sep 2024 18:13:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slW5G-0007u7-Ub; Tue, 03 Sep 2024 12:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW5D-0007cD-GN
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:43 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1slW55-0002pF-Gu
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 12:08:43 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-374ba78f192so2628979f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 09:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725379714; x=1725984514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=57aFd8XX1nqTJPmkCx2AJSk6zUfAqiRHyA7/gQXji/o=;
 b=VIgwFXUUdiqi7fW5TrHgC49xhdrHauMzi5FlJWG1G2bgo96+JJiEJxMR+RcKdbjzVA
 wOhF56r8rOe6PCfCIgclvZE10eM3irGxqv7yTZ2kjNn9j8xryc4knTRKcfwhfLu8x/AE
 erof3v7sXsGF+3cDa69FHdVC4aOZUcfuIK354tkEzzSkCpVz4PWs1dzH1B/xuDyBPIi4
 SHkMLKEkSVit0Vol5j+tJN/I6gHF1o1RY7o937blJnFcF4o5LuZDyoWruU01i9V1y0Uq
 dqDdDLqkyKCgwmOWtSENbJDThVn/kuCV20nzxIevtVSl2kyij/kY5I/mfQu+oNynjuKX
 FaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725379714; x=1725984514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=57aFd8XX1nqTJPmkCx2AJSk6zUfAqiRHyA7/gQXji/o=;
 b=iZ1ciZ2JNCLUDLEExHzUO41G+qRvyIG+EJA4UoAHVmCbptEEOVTE7PfH+m1kQUv5ig
 QijUbN+SofabFJJcnopu0ULSy0lR5eUfNwfE/Sc0WBqBu2i0cm2qKmN2W5lL//ZdzhAH
 S4pSWL2X2jxdp4MjDwVUtU60bypaE236XRDGc5nMcaRv4KRdU4PD22Lf6hHJzfwMwO/g
 G4P0Lb9ScVZTQtpQTY4Y6azcZxMstA/TBnD/M2zA24Q+JxTTLYAtXti2DN3fRQh+Tsmf
 zb0y0ZgwOG6s0GKrbuqrx0+VD4iTtM7MPA5AJ/xV4UCbdCUDlk9SiIxiNfXfAfXyfxA8
 z/Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRBZk179eCPq3439uL9LibxSf76zxTGO3w9p1ivUCAL1ImN98rGHhexNib95m97Ta7A3bAb8OQbLGV@nongnu.org
X-Gm-Message-State: AOJu0Yxxkwcp+kkxOye2Tyh5RnsRwlChos9l2soXq8e0ZAYBYi75ix//
 PRJV7KPRCx4JxZ0jxSAk3PwD4qA3DO3p4V1qDRe2fAkz87xJ3zWmX3783uZECvX1xOUrVYb9Xyy
 s
X-Google-Smtp-Source: AGHT+IFsDdYNeZr/Y5lwytZT0zDMLzX7MGDPFpl/FWQkesdU7+dZdWb9RW1RE4qSFnrTW2Bqk6YWlw==
X-Received: by 2002:adf:ee8d:0:b0:374:c943:4c0f with SMTP id
 ffacd0b85a97d-376d9e982b9mr993797f8f.0.1725379713400; 
 Tue, 03 Sep 2024 09:08:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm175123065e9.18.2024.09.03.09.08.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:08:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-9.2 25/53] hw/arm: Remove 'n800' and 'n810' machines
Date: Tue,  3 Sep 2024 17:07:23 +0100
Message-Id: <20240903160751.4100218-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903160751.4100218-1-peter.maydell@linaro.org>
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Remove the 'n800' and 'n810' machine types, which modelled
Nokia internet tablets. These were deprecated in 9.0 and
so we can remove them for 9.2.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                             |    3 -
 docs/system/arm/nseries.rst             |   33 -
 docs/system/target-arm.rst              |    1 -
 configs/devices/arm-softmmu/default.mak |    1 -
 hw/arm/nseries.c                        | 1473 -----------------------
 hw/arm/meson.build                      |    1 -
 tests/avocado/machine_arm_n8x0.py       |   49 -
 7 files changed, 1561 deletions(-)
 delete mode 100644 docs/system/arm/nseries.rst
 delete mode 100644 hw/arm/nseries.c
 delete mode 100644 tests/avocado/machine_arm_n8x0.py

diff --git a/MAINTAINERS b/MAINTAINERS
index df208c539ac..0c1fad7afda 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -867,7 +867,6 @@ nSeries
 M: Peter Maydell <peter.maydell@linaro.org>
 L: qemu-arm@nongnu.org
 S: Odd Fixes
-F: hw/arm/nseries.c
 F: hw/display/blizzard.c
 F: hw/input/lm832x.c
 F: hw/input/tsc2005.c
@@ -878,8 +877,6 @@ F: include/hw/display/blizzard.h
 F: include/hw/input/lm832x.h
 F: include/hw/input/tsc2xxx.h
 F: include/hw/misc/cbus.h
-F: tests/avocado/machine_arm_n8x0.py
-F: docs/system/arm/nseries.rst
 
 Raspberry Pi
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/docs/system/arm/nseries.rst b/docs/system/arm/nseries.rst
deleted file mode 100644
index cd9edf5d88b..00000000000
--- a/docs/system/arm/nseries.rst
+++ /dev/null
@@ -1,33 +0,0 @@
-Nokia N800 and N810 tablets (``n800``, ``n810``)
-================================================
-
-Nokia N800 and N810 internet tablets (known also as RX-34 and RX-44 /
-48) emulation supports the following elements:
-
--  Texas Instruments OMAP2420 System-on-chip (ARM1136 core)
-
--  RAM and non-volatile OneNAND Flash memories
-
--  Display connected to EPSON remote framebuffer chip and OMAP on-chip
-   display controller and a LS041y3 MIPI DBI-C controller
-
--  TI TSC2301 (in N800) and TI TSC2005 (in N810) touchscreen
-   controllers driven through SPI bus
-
--  National Semiconductor LM8323-controlled qwerty keyboard driven
-   through |I2C| bus
-
--  Secure Digital card connected to OMAP MMC/SD host
-
--  Three OMAP on-chip UARTs and on-chip STI debugging console
-
--  Mentor Graphics \"Inventra\" dual-role USB controller embedded in a
-   TI TUSB6010 chip - only USB host mode is supported
-
--  TI TMP105 temperature sensor driven through |I2C| bus
-
--  TI TWL92230C power management companion with an RTC on
-   |I2C| bus
-
--  Nokia RETU and TAHVO multi-purpose chips with an RTC, connected
-   through CBUS
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 28af58135e4..3c0a5848453 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -92,7 +92,6 @@ undocumented; you can get a complete list by running
    arm/emcraft-sf2
    arm/musicpal
    arm/kzm
-   arm/nseries
    arm/nrf
    arm/nuvoton
    arm/imx25-pdk
diff --git a/configs/devices/arm-softmmu/default.mak b/configs/devices/arm-softmmu/default.mak
index 260b0cf9772..57ef1b8a702 100644
--- a/configs/devices/arm-softmmu/default.mak
+++ b/configs/devices/arm-softmmu/default.mak
@@ -19,7 +19,6 @@
 # CONFIG_MPS3R=n
 # CONFIG_MUSCA=n
 # CONFIG_SX1=n
-# CONFIG_NSERIES=n
 # CONFIG_STELLARIS=n
 # CONFIG_STM32VLDISCOVERY=n
 # CONFIG_B_L475E_IOT01A=n
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
deleted file mode 100644
index 35364312c73..00000000000
--- a/hw/arm/nseries.c
+++ /dev/null
@@ -1,1473 +0,0 @@
-/*
- * Nokia N-series internet tablets.
- *
- * Copyright (C) 2007 Nokia Corporation
- * Written by Andrzej Zaborowski <andrew@openedhand.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation; either version 2 or
- * (at your option) version 3 of the License.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-#include "qapi/error.h"
-#include "cpu.h"
-#include "chardev/char.h"
-#include "qemu/cutils.h"
-#include "qemu/bswap.h"
-#include "qemu/hw-version.h"
-#include "sysemu/reset.h"
-#include "sysemu/runstate.h"
-#include "sysemu/sysemu.h"
-#include "hw/arm/omap.h"
-#include "hw/arm/boot.h"
-#include "hw/irq.h"
-#include "ui/console.h"
-#include "hw/boards.h"
-#include "hw/i2c/i2c.h"
-#include "hw/display/blizzard.h"
-#include "hw/input/lm832x.h"
-#include "hw/input/tsc2xxx.h"
-#include "hw/misc/cbus.h"
-#include "hw/sensor/tmp105.h"
-#include "hw/qdev-properties.h"
-#include "hw/block/flash.h"
-#include "hw/hw.h"
-#include "hw/loader.h"
-#include "hw/sysbus.h"
-#include "qemu/log.h"
-#include "qemu/error-report.h"
-
-
-/* Nokia N8x0 support */
-struct n800_s {
-    struct omap_mpu_state_s *mpu;
-
-    struct rfbi_chip_s blizzard;
-    struct {
-        void *opaque;
-        uint32_t (*txrx)(void *opaque, uint32_t value, int len);
-        uWireSlave *chip;
-    } ts;
-
-    int keymap[0x80];
-    DeviceState *kbd;
-
-    DeviceState *usb;
-    void *retu;
-    void *tahvo;
-    DeviceState *nand;
-};
-
-/* GPIO pins */
-#define N8X0_TUSB_ENABLE_GPIO		0
-#define N800_MMC2_WP_GPIO		8
-#define N800_UNKNOWN_GPIO0		9	/* out */
-#define N810_MMC2_VIOSD_GPIO		9
-#define N810_HEADSET_AMP_GPIO		10
-#define N800_CAM_TURN_GPIO		12
-#define N810_GPS_RESET_GPIO		12
-#define N800_BLIZZARD_POWERDOWN_GPIO	15
-#define N800_MMC1_WP_GPIO		23
-#define N810_MMC2_VSD_GPIO		23
-#define N8X0_ONENAND_GPIO		26
-#define N810_BLIZZARD_RESET_GPIO	30
-#define N800_UNKNOWN_GPIO2		53	/* out */
-#define N8X0_TUSB_INT_GPIO		58
-#define N8X0_BT_WKUP_GPIO		61
-#define N8X0_STI_GPIO			62
-#define N8X0_CBUS_SEL_GPIO		64
-#define N8X0_CBUS_DAT_GPIO		65
-#define N8X0_CBUS_CLK_GPIO		66
-#define N8X0_WLAN_IRQ_GPIO		87
-#define N8X0_BT_RESET_GPIO		92
-#define N8X0_TEA5761_CS_GPIO		93
-#define N800_UNKNOWN_GPIO		94
-#define N810_TSC_RESET_GPIO		94
-#define N800_CAM_ACT_GPIO		95
-#define N810_GPS_WAKEUP_GPIO		95
-#define N8X0_MMC_CS_GPIO		96
-#define N8X0_WLAN_PWR_GPIO		97
-#define N8X0_BT_HOST_WKUP_GPIO		98
-#define N810_SPEAKER_AMP_GPIO		101
-#define N810_KB_LOCK_GPIO		102
-#define N800_TSC_TS_GPIO		103
-#define N810_TSC_TS_GPIO		106
-#define N8X0_HEADPHONE_GPIO		107
-#define N8X0_RETU_GPIO			108
-#define N800_TSC_KP_IRQ_GPIO		109
-#define N810_KEYBOARD_GPIO		109
-#define N800_BAT_COVER_GPIO		110
-#define N810_SLIDE_GPIO			110
-#define N8X0_TAHVO_GPIO			111
-#define N800_UNKNOWN_GPIO4		112	/* out */
-#define N810_SLEEPX_LED_GPIO		112
-#define N800_TSC_RESET_GPIO		118	/* ? */
-#define N810_AIC33_RESET_GPIO		118
-#define N800_TSC_UNKNOWN_GPIO		119	/* out */
-#define N8X0_TMP105_GPIO		125
-
-/* Config */
-#define BT_UART				0
-#define XLDR_LL_UART			1
-
-/* Addresses on the I2C bus 0 */
-#define N810_TLV320AIC33_ADDR		0x18	/* Audio CODEC */
-#define N8X0_TCM825x_ADDR		0x29	/* Camera */
-#define N810_LP5521_ADDR		0x32	/* LEDs */
-#define N810_TSL2563_ADDR		0x3d	/* Light sensor */
-#define N810_LM8323_ADDR		0x45	/* Keyboard */
-/* Addresses on the I2C bus 1 */
-#define N8X0_TMP105_ADDR		0x48	/* Temperature sensor */
-#define N8X0_MENELAUS_ADDR		0x72	/* Power management */
-
-/* Chipselects on GPMC NOR interface */
-#define N8X0_ONENAND_CS			0
-#define N8X0_USB_ASYNC_CS		1
-#define N8X0_USB_SYNC_CS		4
-
-#define N8X0_BD_ADDR			0x00, 0x1a, 0x89, 0x9e, 0x3e, 0x81
-
-static void n800_mmc_cs_cb(void *opaque, int line, int level)
-{
-    /* TODO: this seems to actually be connected to the menelaus, to
-     * which also both MMC slots connect.  */
-    omap_mmc_enable((struct omap_mmc_s *) opaque, !level);
-}
-
-static void n8x0_gpio_setup(struct n800_s *s)
-{
-    qdev_connect_gpio_out(s->mpu->gpio, N8X0_MMC_CS_GPIO,
-                          qemu_allocate_irq(n800_mmc_cs_cb, s->mpu->mmc, 0));
-    qemu_irq_lower(qdev_get_gpio_in(s->mpu->gpio, N800_BAT_COVER_GPIO));
-}
-
-#define MAEMO_CAL_HEADER(...)				\
-    'C',  'o',  'n',  'F',  0x02, 0x00, 0x04, 0x00,	\
-    __VA_ARGS__,					\
-    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-
-static const uint8_t n8x0_cal_wlan_mac[] = {
-    MAEMO_CAL_HEADER('w', 'l', 'a', 'n', '-', 'm', 'a', 'c')
-    0x1c, 0x00, 0x00, 0x00, 0x47, 0xd6, 0x69, 0xb3,
-    0x30, 0x08, 0xa0, 0x83, 0x00, 0x00, 0x00, 0x00,
-    0x00, 0x00, 0x00, 0x00, 0x1a, 0x00, 0x00, 0x00,
-    0x89, 0x00, 0x00, 0x00, 0x9e, 0x00, 0x00, 0x00,
-    0x5d, 0x00, 0x00, 0x00, 0xc1, 0x00, 0x00, 0x00,
-};
-
-static const uint8_t n8x0_cal_bt_id[] = {
-    MAEMO_CAL_HEADER('b', 't', '-', 'i', 'd', 0, 0, 0)
-    0x0a, 0x00, 0x00, 0x00, 0xa3, 0x4b, 0xf6, 0x96,
-    0xa8, 0xeb, 0xb2, 0x41, 0x00, 0x00, 0x00, 0x00,
-    N8X0_BD_ADDR,
-};
-
-static void n8x0_nand_setup(struct n800_s *s)
-{
-    char *otp_region;
-    DriveInfo *dinfo;
-
-    s->nand = qdev_new("onenand");
-    qdev_prop_set_uint16(s->nand, "manufacturer_id", NAND_MFR_SAMSUNG);
-    /* Either 0x40 or 0x48 are OK for the device ID */
-    qdev_prop_set_uint16(s->nand, "device_id", 0x48);
-    qdev_prop_set_uint16(s->nand, "version_id", 0);
-    qdev_prop_set_int32(s->nand, "shift", 1);
-    dinfo = drive_get(IF_MTD, 0, 0);
-    if (dinfo) {
-        qdev_prop_set_drive_err(s->nand, "drive", blk_by_legacy_dinfo(dinfo),
-                                &error_fatal);
-    }
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(s->nand), &error_fatal);
-    sysbus_connect_irq(SYS_BUS_DEVICE(s->nand), 0,
-                       qdev_get_gpio_in(s->mpu->gpio, N8X0_ONENAND_GPIO));
-    omap_gpmc_attach(s->mpu->gpmc, N8X0_ONENAND_CS,
-                     sysbus_mmio_get_region(SYS_BUS_DEVICE(s->nand), 0));
-    otp_region = onenand_raw_otp(s->nand);
-
-    memcpy(otp_region + 0x000, n8x0_cal_wlan_mac, sizeof(n8x0_cal_wlan_mac));
-    memcpy(otp_region + 0x800, n8x0_cal_bt_id, sizeof(n8x0_cal_bt_id));
-    /* XXX: in theory should also update the OOB for both pages */
-}
-
-static qemu_irq n8x0_system_powerdown;
-
-static void n8x0_powerdown_req(Notifier *n, void *opaque)
-{
-    qemu_irq_raise(n8x0_system_powerdown);
-}
-
-static Notifier n8x0_system_powerdown_notifier = {
-    .notify = n8x0_powerdown_req
-};
-
-static void n8x0_i2c_setup(struct n800_s *s)
-{
-    DeviceState *dev;
-    qemu_irq tmp_irq = qdev_get_gpio_in(s->mpu->gpio, N8X0_TMP105_GPIO);
-    I2CBus *i2c = omap_i2c_bus(s->mpu->i2c[0]);
-
-    /* Attach a menelaus PM chip */
-    dev = DEVICE(i2c_slave_create_simple(i2c, "twl92230", N8X0_MENELAUS_ADDR));
-    qdev_connect_gpio_out(dev, 3,
-                          qdev_get_gpio_in(s->mpu->ih[0],
-                                           OMAP_INT_24XX_SYS_NIRQ));
-
-    n8x0_system_powerdown = qdev_get_gpio_in(dev, 3);
-    qemu_register_powerdown_notifier(&n8x0_system_powerdown_notifier);
-
-    /* Attach a TMP105 PM chip (A0 wired to ground) */
-    dev = DEVICE(i2c_slave_create_simple(i2c, TYPE_TMP105, N8X0_TMP105_ADDR));
-    qdev_connect_gpio_out(dev, 0, tmp_irq);
-}
-
-/* Touchscreen and keypad controller */
-static const MouseTransformInfo n800_pointercal = {
-    .x = 800,
-    .y = 480,
-    .a = { 14560, -68, -3455208, -39, -9621, 35152972, 65536 },
-};
-
-static const MouseTransformInfo n810_pointercal = {
-    .x = 800,
-    .y = 480,
-    .a = { 15041, 148, -4731056, 171, -10238, 35933380, 65536 },
-};
-
-#define RETU_KEYCODE	61	/* F3 */
-
-static void n800_key_event(void *opaque, int keycode)
-{
-    struct n800_s *s = (struct n800_s *) opaque;
-    int code = s->keymap[keycode & 0x7f];
-
-    if (code == -1) {
-        if ((keycode & 0x7f) == RETU_KEYCODE) {
-            retu_key_event(s->retu, !(keycode & 0x80));
-        }
-        return;
-    }
-
-    tsc210x_key_event(s->ts.chip, code, !(keycode & 0x80));
-}
-
-static const int n800_keys[16] = {
-    -1,
-    72,	/* Up */
-    63,	/* Home (F5) */
-    -1,
-    75,	/* Left */
-    28,	/* Enter */
-    77,	/* Right */
-    -1,
-     1,	/* Cycle (ESC) */
-    80,	/* Down */
-    62,	/* Menu (F4) */
-    -1,
-    66,	/* Zoom- (F8) */
-    64,	/* FullScreen (F6) */
-    65,	/* Zoom+ (F7) */
-    -1,
-};
-
-static void n800_tsc_kbd_setup(struct n800_s *s)
-{
-    int i;
-
-    /* XXX: are the three pins inverted inside the chip between the
-     * tsc and the cpu (N4111)?  */
-    qemu_irq penirq = NULL;	/* NC */
-    qemu_irq kbirq = qdev_get_gpio_in(s->mpu->gpio, N800_TSC_KP_IRQ_GPIO);
-    qemu_irq dav = qdev_get_gpio_in(s->mpu->gpio, N800_TSC_TS_GPIO);
-
-    s->ts.chip = tsc2301_init(penirq, kbirq, dav);
-    s->ts.opaque = s->ts.chip->opaque;
-    s->ts.txrx = tsc210x_txrx;
-
-    for (i = 0; i < 0x80; i++) {
-        s->keymap[i] = -1;
-    }
-    for (i = 0; i < 0x10; i++) {
-        if (n800_keys[i] >= 0) {
-            s->keymap[n800_keys[i]] = i;
-        }
-    }
-
-    qemu_add_kbd_event_handler(n800_key_event, s);
-
-    tsc210x_set_transform(s->ts.chip, &n800_pointercal);
-}
-
-static void n810_tsc_setup(struct n800_s *s)
-{
-    qemu_irq pintdav = qdev_get_gpio_in(s->mpu->gpio, N810_TSC_TS_GPIO);
-
-    s->ts.opaque = tsc2005_init(pintdav);
-    s->ts.txrx = tsc2005_txrx;
-
-    tsc2005_set_transform(s->ts.opaque, &n810_pointercal);
-}
-
-/* N810 Keyboard controller */
-static void n810_key_event(void *opaque, int keycode)
-{
-    struct n800_s *s = (struct n800_s *) opaque;
-    int code = s->keymap[keycode & 0x7f];
-
-    if (code == -1) {
-        if ((keycode & 0x7f) == RETU_KEYCODE) {
-            retu_key_event(s->retu, !(keycode & 0x80));
-        }
-        return;
-    }
-
-    lm832x_key_event(s->kbd, code, !(keycode & 0x80));
-}
-
-#define M	0
-
-static const int n810_keys[0x80] = {
-    [0x01] = 16,	/* Q */
-    [0x02] = 37,	/* K */
-    [0x03] = 24,	/* O */
-    [0x04] = 25,	/* P */
-    [0x05] = 14,	/* Backspace */
-    [0x06] = 30,	/* A */
-    [0x07] = 31,	/* S */
-    [0x08] = 32,	/* D */
-    [0x09] = 33,	/* F */
-    [0x0a] = 34,	/* G */
-    [0x0b] = 35,	/* H */
-    [0x0c] = 36,	/* J */
-
-    [0x11] = 17,	/* W */
-    [0x12] = 62,	/* Menu (F4) */
-    [0x13] = 38,	/* L */
-    [0x14] = 40,	/* ' (Apostrophe) */
-    [0x16] = 44,	/* Z */
-    [0x17] = 45,	/* X */
-    [0x18] = 46,	/* C */
-    [0x19] = 47,	/* V */
-    [0x1a] = 48,	/* B */
-    [0x1b] = 49,	/* N */
-    [0x1c] = 42,	/* Shift (Left shift) */
-    [0x1f] = 65,	/* Zoom+ (F7) */
-
-    [0x21] = 18,	/* E */
-    [0x22] = 39,	/* ; (Semicolon) */
-    [0x23] = 12,	/* - (Minus) */
-    [0x24] = 13,	/* = (Equal) */
-    [0x2b] = 56,	/* Fn (Left Alt) */
-    [0x2c] = 50,	/* M */
-    [0x2f] = 66,	/* Zoom- (F8) */
-
-    [0x31] = 19,	/* R */
-    [0x32] = 29 | M,	/* Right Ctrl */
-    [0x34] = 57,	/* Space */
-    [0x35] = 51,	/* , (Comma) */
-    [0x37] = 72 | M,	/* Up */
-    [0x3c] = 82 | M,	/* Compose (Insert) */
-    [0x3f] = 64,	/* FullScreen (F6) */
-
-    [0x41] = 20,	/* T */
-    [0x44] = 52,	/* . (Dot) */
-    [0x46] = 77 | M,	/* Right */
-    [0x4f] = 63,	/* Home (F5) */
-    [0x51] = 21,	/* Y */
-    [0x53] = 80 | M,	/* Down */
-    [0x55] = 28,	/* Enter */
-    [0x5f] =  1,	/* Cycle (ESC) */
-
-    [0x61] = 22,	/* U */
-    [0x64] = 75 | M,	/* Left */
-
-    [0x71] = 23,	/* I */
-#if 0
-    [0x75] = 28 | M,	/* KP Enter (KP Enter) */
-#else
-    [0x75] = 15,	/* KP Enter (Tab) */
-#endif
-};
-
-#undef M
-
-static void n810_kbd_setup(struct n800_s *s)
-{
-    qemu_irq kbd_irq = qdev_get_gpio_in(s->mpu->gpio, N810_KEYBOARD_GPIO);
-    int i;
-
-    for (i = 0; i < 0x80; i++) {
-        s->keymap[i] = -1;
-    }
-    for (i = 0; i < 0x80; i++) {
-        if (n810_keys[i] > 0) {
-            s->keymap[n810_keys[i]] = i;
-        }
-    }
-
-    qemu_add_kbd_event_handler(n810_key_event, s);
-
-    /* Attach the LM8322 keyboard to the I2C bus,
-     * should happen in n8x0_i2c_setup and s->kbd be initialised here.  */
-    s->kbd = DEVICE(i2c_slave_create_simple(omap_i2c_bus(s->mpu->i2c[0]),
-                                            TYPE_LM8323, N810_LM8323_ADDR));
-    qdev_connect_gpio_out(s->kbd, 0, kbd_irq);
-}
-
-/* LCD MIPI DBI-C controller (URAL) */
-struct mipid_s {
-    int resp[4];
-    int param[4];
-    int p;
-    int pm;
-    int cmd;
-
-    int sleep;
-    int booster;
-    int te;
-    int selfcheck;
-    int partial;
-    int normal;
-    int vscr;
-    int invert;
-    int onoff;
-    int gamma;
-    uint32_t id;
-};
-
-static void mipid_reset(struct mipid_s *s)
-{
-    s->pm = 0;
-    s->cmd = 0;
-
-    s->sleep = 1;
-    s->booster = 0;
-    s->selfcheck =
-            (1 << 7) |	/* Register loading OK.  */
-            (1 << 5) |	/* The chip is attached.  */
-            (1 << 4);	/* Display glass still in one piece.  */
-    s->te = 0;
-    s->partial = 0;
-    s->normal = 1;
-    s->vscr = 0;
-    s->invert = 0;
-    s->onoff = 1;
-    s->gamma = 0;
-}
-
-static uint32_t mipid_txrx(void *opaque, uint32_t cmd, int len)
-{
-    struct mipid_s *s = (struct mipid_s *) opaque;
-    uint8_t ret;
-
-    if (len > 9) {
-        hw_error("%s: FIXME: bad SPI word width %i\n", __func__, len);
-    }
-
-    if (s->p >= ARRAY_SIZE(s->resp)) {
-        ret = 0;
-    } else {
-        ret = s->resp[s->p++];
-    }
-    if (s->pm-- > 0) {
-        s->param[s->pm] = cmd;
-    } else {
-        s->cmd = cmd;
-    }
-
-    switch (s->cmd) {
-    case 0x00:	/* NOP */
-        break;
-
-    case 0x01:	/* SWRESET */
-        mipid_reset(s);
-        break;
-
-    case 0x02:	/* BSTROFF */
-        s->booster = 0;
-        break;
-    case 0x03:	/* BSTRON */
-        s->booster = 1;
-        break;
-
-    case 0x04:	/* RDDID */
-        s->p = 0;
-        s->resp[0] = (s->id >> 16) & 0xff;
-        s->resp[1] = (s->id >>  8) & 0xff;
-        s->resp[2] = (s->id >>  0) & 0xff;
-        break;
-
-    case 0x06:	/* RD_RED */
-    case 0x07:	/* RD_GREEN */
-        /* XXX the bootloader sometimes issues RD_BLUE meaning RDDID so
-         * for the bootloader one needs to change this.  */
-    case 0x08:	/* RD_BLUE */
-        s->p = 0;
-        /* TODO: return first pixel components */
-        s->resp[0] = 0x01;
-        break;
-
-    case 0x09:	/* RDDST */
-        s->p = 0;
-        s->resp[0] = s->booster << 7;
-        s->resp[1] = (5 << 4) | (s->partial << 2) |
-                (s->sleep << 1) | s->normal;
-        s->resp[2] = (s->vscr << 7) | (s->invert << 5) |
-                (s->onoff << 2) | (s->te << 1) | (s->gamma >> 2);
-        s->resp[3] = s->gamma << 6;
-        break;
-
-    case 0x0a:	/* RDDPM */
-        s->p = 0;
-        s->resp[0] = (s->onoff << 2) | (s->normal << 3) | (s->sleep << 4) |
-                (s->partial << 5) | (s->sleep << 6) | (s->booster << 7);
-        break;
-    case 0x0b:	/* RDDMADCTR */
-        s->p = 0;
-        s->resp[0] = 0;
-        break;
-    case 0x0c:	/* RDDCOLMOD */
-        s->p = 0;
-        s->resp[0] = 5;	/* 65K colours */
-        break;
-    case 0x0d:	/* RDDIM */
-        s->p = 0;
-        s->resp[0] = (s->invert << 5) | (s->vscr << 7) | s->gamma;
-        break;
-    case 0x0e:	/* RDDSM */
-        s->p = 0;
-        s->resp[0] = s->te << 7;
-        break;
-    case 0x0f:	/* RDDSDR */
-        s->p = 0;
-        s->resp[0] = s->selfcheck;
-        break;
-
-    case 0x10:	/* SLPIN */
-        s->sleep = 1;
-        break;
-    case 0x11:	/* SLPOUT */
-        s->sleep = 0;
-        s->selfcheck ^= 1 << 6;	/* POFF self-diagnosis Ok */
-        break;
-
-    case 0x12:	/* PTLON */
-        s->partial = 1;
-        s->normal = 0;
-        s->vscr = 0;
-        break;
-    case 0x13:	/* NORON */
-        s->partial = 0;
-        s->normal = 1;
-        s->vscr = 0;
-        break;
-
-    case 0x20:	/* INVOFF */
-        s->invert = 0;
-        break;
-    case 0x21:	/* INVON */
-        s->invert = 1;
-        break;
-
-    case 0x22:	/* APOFF */
-    case 0x23:	/* APON */
-        goto bad_cmd;
-
-    case 0x25:	/* WRCNTR */
-        if (s->pm < 0) {
-            s->pm = 1;
-        }
-        goto bad_cmd;
-
-    case 0x26:	/* GAMSET */
-        if (!s->pm) {
-            s->gamma = ctz32(s->param[0] & 0xf);
-            if (s->gamma == 32) {
-                s->gamma = -1; /* XXX: should this be 0? */
-            }
-        } else if (s->pm < 0) {
-            s->pm = 1;
-        }
-        break;
-
-    case 0x28:	/* DISPOFF */
-        s->onoff = 0;
-        break;
-    case 0x29:	/* DISPON */
-        s->onoff = 1;
-        break;
-
-    case 0x2a:	/* CASET */
-    case 0x2b:	/* RASET */
-    case 0x2c:	/* RAMWR */
-    case 0x2d:	/* RGBSET */
-    case 0x2e:	/* RAMRD */
-    case 0x30:	/* PTLAR */
-    case 0x33:	/* SCRLAR */
-        goto bad_cmd;
-
-    case 0x34:	/* TEOFF */
-        s->te = 0;
-        break;
-    case 0x35:	/* TEON */
-        if (!s->pm) {
-            s->te = 1;
-        } else if (s->pm < 0) {
-            s->pm = 1;
-        }
-        break;
-
-    case 0x36:	/* MADCTR */
-        goto bad_cmd;
-
-    case 0x37:	/* VSCSAD */
-        s->partial = 0;
-        s->normal = 0;
-        s->vscr = 1;
-        break;
-
-    case 0x38:	/* IDMOFF */
-    case 0x39:	/* IDMON */
-    case 0x3a:	/* COLMOD */
-        goto bad_cmd;
-
-    case 0xb0:	/* CLKINT / DISCTL */
-    case 0xb1:	/* CLKEXT */
-        if (s->pm < 0) {
-            s->pm = 2;
-        }
-        break;
-
-    case 0xb4:	/* FRMSEL */
-        break;
-
-    case 0xb5:	/* FRM8SEL */
-    case 0xb6:	/* TMPRNG / INIESC */
-    case 0xb7:	/* TMPHIS / NOP2 */
-    case 0xb8:	/* TMPREAD / MADCTL */
-    case 0xba:	/* DISTCTR */
-    case 0xbb:	/* EPVOL */
-        goto bad_cmd;
-
-    case 0xbd:	/* Unknown */
-        s->p = 0;
-        s->resp[0] = 0;
-        s->resp[1] = 1;
-        break;
-
-    case 0xc2:	/* IFMOD */
-        if (s->pm < 0) {
-            s->pm = 2;
-        }
-        break;
-
-    case 0xc6:	/* PWRCTL */
-    case 0xc7:	/* PPWRCTL */
-    case 0xd0:	/* EPWROUT */
-    case 0xd1:	/* EPWRIN */
-    case 0xd4:	/* RDEV */
-    case 0xd5:	/* RDRR */
-        goto bad_cmd;
-
-    case 0xda:	/* RDID1 */
-        s->p = 0;
-        s->resp[0] = (s->id >> 16) & 0xff;
-        break;
-    case 0xdb:	/* RDID2 */
-        s->p = 0;
-        s->resp[0] = (s->id >>  8) & 0xff;
-        break;
-    case 0xdc:	/* RDID3 */
-        s->p = 0;
-        s->resp[0] = (s->id >>  0) & 0xff;
-        break;
-
-    default:
-    bad_cmd:
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: unknown command 0x%02x\n", __func__, s->cmd);
-        break;
-    }
-
-    return ret;
-}
-
-static void *mipid_init(void)
-{
-    struct mipid_s *s = g_malloc0(sizeof(*s));
-
-    s->id = 0x838f03;
-    mipid_reset(s);
-
-    return s;
-}
-
-static void n8x0_spi_setup(struct n800_s *s)
-{
-    void *tsc = s->ts.opaque;
-    void *mipid = mipid_init();
-
-    omap_mcspi_attach(s->mpu->mcspi[0], s->ts.txrx, tsc, 0);
-    omap_mcspi_attach(s->mpu->mcspi[0], mipid_txrx, mipid, 1);
-}
-
-/* This task is normally performed by the bootloader.  If we're loading
- * a kernel directly, we need to enable the Blizzard ourselves.  */
-static void n800_dss_init(struct rfbi_chip_s *chip)
-{
-    uint8_t *fb_blank;
-
-    chip->write(chip->opaque, 0, 0x2a);		/* LCD Width register */
-    chip->write(chip->opaque, 1, 0x64);
-    chip->write(chip->opaque, 0, 0x2c);		/* LCD HNDP register */
-    chip->write(chip->opaque, 1, 0x1e);
-    chip->write(chip->opaque, 0, 0x2e);		/* LCD Height 0 register */
-    chip->write(chip->opaque, 1, 0xe0);
-    chip->write(chip->opaque, 0, 0x30);		/* LCD Height 1 register */
-    chip->write(chip->opaque, 1, 0x01);
-    chip->write(chip->opaque, 0, 0x32);		/* LCD VNDP register */
-    chip->write(chip->opaque, 1, 0x06);
-    chip->write(chip->opaque, 0, 0x68);		/* Display Mode register */
-    chip->write(chip->opaque, 1, 1);		/* Enable bit */
-
-    chip->write(chip->opaque, 0, 0x6c);	
-    chip->write(chip->opaque, 1, 0x00);		/* Input X Start Position */
-    chip->write(chip->opaque, 1, 0x00);		/* Input X Start Position */
-    chip->write(chip->opaque, 1, 0x00);		/* Input Y Start Position */
-    chip->write(chip->opaque, 1, 0x00);		/* Input Y Start Position */
-    chip->write(chip->opaque, 1, 0x1f);		/* Input X End Position */
-    chip->write(chip->opaque, 1, 0x03);		/* Input X End Position */
-    chip->write(chip->opaque, 1, 0xdf);		/* Input Y End Position */
-    chip->write(chip->opaque, 1, 0x01);		/* Input Y End Position */
-    chip->write(chip->opaque, 1, 0x00);		/* Output X Start Position */
-    chip->write(chip->opaque, 1, 0x00);		/* Output X Start Position */
-    chip->write(chip->opaque, 1, 0x00);		/* Output Y Start Position */
-    chip->write(chip->opaque, 1, 0x00);		/* Output Y Start Position */
-    chip->write(chip->opaque, 1, 0x1f);		/* Output X End Position */
-    chip->write(chip->opaque, 1, 0x03);		/* Output X End Position */
-    chip->write(chip->opaque, 1, 0xdf);		/* Output Y End Position */
-    chip->write(chip->opaque, 1, 0x01);		/* Output Y End Position */
-    chip->write(chip->opaque, 1, 0x01);		/* Input Data Format */
-    chip->write(chip->opaque, 1, 0x01);		/* Data Source Select */
-
-    fb_blank = memset(g_malloc(800 * 480 * 2), 0xff, 800 * 480 * 2);
-    /* Display Memory Data Port */
-    chip->block(chip->opaque, 1, fb_blank, 800 * 480 * 2, 800);
-    g_free(fb_blank);
-}
-
-static void n8x0_dss_setup(struct n800_s *s)
-{
-    s->blizzard.opaque = s1d13745_init(NULL);
-    s->blizzard.block = s1d13745_write_block;
-    s->blizzard.write = s1d13745_write;
-    s->blizzard.read = s1d13745_read;
-
-    omap_rfbi_attach(s->mpu->dss, 0, &s->blizzard);
-}
-
-static void n8x0_cbus_setup(struct n800_s *s)
-{
-    qemu_irq dat_out = qdev_get_gpio_in(s->mpu->gpio, N8X0_CBUS_DAT_GPIO);
-    qemu_irq retu_irq = qdev_get_gpio_in(s->mpu->gpio, N8X0_RETU_GPIO);
-    qemu_irq tahvo_irq = qdev_get_gpio_in(s->mpu->gpio, N8X0_TAHVO_GPIO);
-
-    CBus *cbus = cbus_init(dat_out);
-
-    qdev_connect_gpio_out(s->mpu->gpio, N8X0_CBUS_CLK_GPIO, cbus->clk);
-    qdev_connect_gpio_out(s->mpu->gpio, N8X0_CBUS_DAT_GPIO, cbus->dat);
-    qdev_connect_gpio_out(s->mpu->gpio, N8X0_CBUS_SEL_GPIO, cbus->sel);
-
-    cbus_attach(cbus, s->retu = retu_init(retu_irq, 1));
-    cbus_attach(cbus, s->tahvo = tahvo_init(tahvo_irq, 1));
-}
-
-static void n8x0_usb_setup(struct n800_s *s)
-{
-    SysBusDevice *dev;
-    s->usb = qdev_new("tusb6010");
-    dev = SYS_BUS_DEVICE(s->usb);
-    sysbus_realize_and_unref(dev, &error_fatal);
-    sysbus_connect_irq(dev, 0,
-                       qdev_get_gpio_in(s->mpu->gpio, N8X0_TUSB_INT_GPIO));
-    /* Using the NOR interface */
-    omap_gpmc_attach(s->mpu->gpmc, N8X0_USB_ASYNC_CS,
-                     sysbus_mmio_get_region(dev, 0));
-    omap_gpmc_attach(s->mpu->gpmc, N8X0_USB_SYNC_CS,
-                     sysbus_mmio_get_region(dev, 1));
-    qdev_connect_gpio_out(s->mpu->gpio, N8X0_TUSB_ENABLE_GPIO,
-                          qdev_get_gpio_in(s->usb, 0)); /* tusb_pwr */
-}
-
-/* Setup done before the main bootloader starts by some early setup code
- * - used when we want to run the main bootloader in emulation.  This
- * isn't documented.  */
-static const uint32_t n800_pinout[104] = {
-    0x080f00d8, 0x00d40808, 0x03080808, 0x080800d0,
-    0x00dc0808, 0x0b0f0f00, 0x080800b4, 0x00c00808,
-    0x08080808, 0x180800c4, 0x00b80000, 0x08080808,
-    0x080800bc, 0x00cc0808, 0x08081818, 0x18180128,
-    0x01241800, 0x18181818, 0x000000f0, 0x01300000,
-    0x00001b0b, 0x1b0f0138, 0x00e0181b, 0x1b031b0b,
-    0x180f0078, 0x00740018, 0x0f0f0f1a, 0x00000080,
-    0x007c0000, 0x00000000, 0x00000088, 0x00840000,
-    0x00000000, 0x00000094, 0x00980300, 0x0f180003,
-    0x0000008c, 0x00900f0f, 0x0f0f1b00, 0x0f00009c,
-    0x01140000, 0x1b1b0f18, 0x0818013c, 0x01400008,
-    0x00001818, 0x000b0110, 0x010c1800, 0x0b030b0f,
-    0x181800f4, 0x00f81818, 0x00000018, 0x000000fc,
-    0x00401808, 0x00000000, 0x0f1b0030, 0x003c0008,
-    0x00000000, 0x00000038, 0x00340000, 0x00000000,
-    0x1a080070, 0x00641a1a, 0x08080808, 0x08080060,
-    0x005c0808, 0x08080808, 0x08080058, 0x00540808,
-    0x08080808, 0x0808006c, 0x00680808, 0x08080808,
-    0x000000a8, 0x00b00000, 0x08080808, 0x000000a0,
-    0x00a40000, 0x00000000, 0x08ff0050, 0x004c0808,
-    0xffffffff, 0xffff0048, 0x0044ffff, 0xffffffff,
-    0x000000ac, 0x01040800, 0x08080b0f, 0x18180100,
-    0x01081818, 0x0b0b1808, 0x1a0300e4, 0x012c0b1a,
-    0x02020018, 0x0b000134, 0x011c0800, 0x0b1b1b00,
-    0x0f0000c8, 0x00ec181b, 0x000f0f02, 0x00180118,
-    0x01200000, 0x0f0b1b1b, 0x0f0200e8, 0x0000020b,
-};
-
-static void n800_setup_nolo_tags(void *sram_base)
-{
-    int i;
-    uint32_t *p = sram_base + 0x8000;
-    uint32_t *v = sram_base + 0xa000;
-
-    memset(p, 0, 0x3000);
-
-    strcpy((void *) (p + 0), "QEMU N800");
-
-    strcpy((void *) (p + 8), "F5");
-
-    stl_p(p + 10, 0x04f70000);
-    strcpy((void *) (p + 9), "RX-34");
-
-    /* RAM size in MB? */
-    stl_p(p + 12, 0x80);
-
-    /* Pointer to the list of tags */
-    stl_p(p + 13, OMAP2_SRAM_BASE + 0x9000);
-
-    /* The NOLO tags start here */
-    p = sram_base + 0x9000;
-#define ADD_TAG(tag, len)				\
-    stw_p((uint16_t *) p + 0, tag);			\
-    stw_p((uint16_t *) p + 1, len); p++;		\
-    stl_p(p++, OMAP2_SRAM_BASE | (((void *) v - sram_base) & 0xffff));
-
-    /* OMAP STI console? Pin out settings? */
-    ADD_TAG(0x6e01, 414);
-    for (i = 0; i < ARRAY_SIZE(n800_pinout); i++) {
-        stl_p(v++, n800_pinout[i]);
-    }
-
-    /* Kernel memsize? */
-    ADD_TAG(0x6e05, 1);
-    stl_p(v++, 2);
-
-    /* NOLO serial console */
-    ADD_TAG(0x6e02, 4);
-    stl_p(v++, XLDR_LL_UART);		/* UART number (1 - 3) */
-
-#if 0
-    /* CBUS settings (Retu/AVilma) */
-    ADD_TAG(0x6e03, 6);
-    stw_p((uint16_t *) v + 0, 65);	/* CBUS GPIO0 */
-    stw_p((uint16_t *) v + 1, 66);	/* CBUS GPIO1 */
-    stw_p((uint16_t *) v + 2, 64);	/* CBUS GPIO2 */
-    v += 2;
-#endif
-
-    /* Nokia ASIC BB5 (Retu/Tahvo) */
-    ADD_TAG(0x6e0a, 4);
-    stw_p((uint16_t *) v + 0, 111);	/* "Retu" interrupt GPIO */
-    stw_p((uint16_t *) v + 1, 108);	/* "Tahvo" interrupt GPIO */
-    v++;
-
-    /* LCD console? */
-    ADD_TAG(0x6e04, 4);
-    stw_p((uint16_t *) v + 0, 30);	/* ??? */
-    stw_p((uint16_t *) v + 1, 24);	/* ??? */
-    v++;
-
-#if 0
-    /* LCD settings */
-    ADD_TAG(0x6e06, 2);
-    stw_p((uint16_t *) (v++), 15);	/* ??? */
-#endif
-
-    /* I^2C (Menelaus) */
-    ADD_TAG(0x6e07, 4);
-    stl_p(v++, 0x00720000);		/* ??? */
-
-    /* Unknown */
-    ADD_TAG(0x6e0b, 6);
-    stw_p((uint16_t *) v + 0, 94);	/* ??? */
-    stw_p((uint16_t *) v + 1, 23);	/* ??? */
-    stw_p((uint16_t *) v + 2, 0);	/* ??? */
-    v += 2;
-
-    /* OMAP gpio switch info */
-    ADD_TAG(0x6e0c, 80);
-    strcpy((void *) v, "bat_cover");	v += 3;
-    stw_p((uint16_t *) v + 0, 110);	/* GPIO num ??? */
-    stw_p((uint16_t *) v + 1, 1);	/* GPIO num ??? */
-    v += 2;
-    strcpy((void *) v, "cam_act");	v += 3;
-    stw_p((uint16_t *) v + 0, 95);	/* GPIO num ??? */
-    stw_p((uint16_t *) v + 1, 32);	/* GPIO num ??? */
-    v += 2;
-    strcpy((void *) v, "cam_turn");	v += 3;
-    stw_p((uint16_t *) v + 0, 12);	/* GPIO num ??? */
-    stw_p((uint16_t *) v + 1, 33);	/* GPIO num ??? */
-    v += 2;
-    strcpy((void *) v, "headphone");	v += 3;
-    stw_p((uint16_t *) v + 0, 107);	/* GPIO num ??? */
-    stw_p((uint16_t *) v + 1, 17);	/* GPIO num ??? */
-    v += 2;
-
-    /* Bluetooth */
-    ADD_TAG(0x6e0e, 12);
-    stl_p(v++, 0x5c623d01);		/* ??? */
-    stl_p(v++, 0x00000201);		/* ??? */
-    stl_p(v++, 0x00000000);		/* ??? */
-
-    /* CX3110x WLAN settings */
-    ADD_TAG(0x6e0f, 8);
-    stl_p(v++, 0x00610025);		/* ??? */
-    stl_p(v++, 0xffff0057);		/* ??? */
-
-    /* MMC host settings */
-    ADD_TAG(0x6e10, 12);
-    stl_p(v++, 0xffff000f);		/* ??? */
-    stl_p(v++, 0xffffffff);		/* ??? */
-    stl_p(v++, 0x00000060);		/* ??? */
-
-    /* OneNAND chip select */
-    ADD_TAG(0x6e11, 10);
-    stl_p(v++, 0x00000401);		/* ??? */
-    stl_p(v++, 0x0002003a);		/* ??? */
-    stl_p(v++, 0x00000002);		/* ??? */
-
-    /* TEA5761 sensor settings */
-    ADD_TAG(0x6e12, 2);
-    stl_p(v++, 93);			/* GPIO num ??? */
-
-#if 0
-    /* Unknown tag */
-    ADD_TAG(6e09, 0);
-
-    /* Kernel UART / console */
-    ADD_TAG(6e12, 0);
-#endif
-
-    /* End of the list */
-    stl_p(p++, 0x00000000);
-    stl_p(p++, 0x00000000);
-}
-
-/* This task is normally performed by the bootloader.  If we're loading
- * a kernel directly, we need to set up GPMC mappings ourselves.  */
-static void n800_gpmc_init(struct n800_s *s)
-{
-    uint32_t config7 =
-            (0xf << 8) |	/* MASKADDRESS */
-            (1 << 6) |		/* CSVALID */
-            (4 << 0);		/* BASEADDRESS */
-
-    cpu_physical_memory_write(0x6800a078,		/* GPMC_CONFIG7_0 */
-                              &config7, sizeof(config7));
-}
-
-/* Setup sequence done by the bootloader */
-static void n8x0_boot_init(void *opaque)
-{
-    struct n800_s *s = (struct n800_s *) opaque;
-    uint32_t buf;
-
-    /* PRCM setup */
-#define omap_writel(addr, val)	\
-    buf = (val);			\
-    cpu_physical_memory_write(addr, &buf, sizeof(buf))
-
-    omap_writel(0x48008060, 0x41);		/* PRCM_CLKSRC_CTRL */
-    omap_writel(0x48008070, 1);			/* PRCM_CLKOUT_CTRL */
-    omap_writel(0x48008078, 0);			/* PRCM_CLKEMUL_CTRL */
-    omap_writel(0x48008090, 0);			/* PRCM_VOLTSETUP */
-    omap_writel(0x48008094, 0);			/* PRCM_CLKSSETUP */
-    omap_writel(0x48008098, 0);			/* PRCM_POLCTRL */
-    omap_writel(0x48008140, 2);			/* CM_CLKSEL_MPU */
-    omap_writel(0x48008148, 0);			/* CM_CLKSTCTRL_MPU */
-    omap_writel(0x48008158, 1);			/* RM_RSTST_MPU */
-    omap_writel(0x480081c8, 0x15);		/* PM_WKDEP_MPU */
-    omap_writel(0x480081d4, 0x1d4);		/* PM_EVGENCTRL_MPU */
-    omap_writel(0x480081d8, 0);			/* PM_EVEGENONTIM_MPU */
-    omap_writel(0x480081dc, 0);			/* PM_EVEGENOFFTIM_MPU */
-    omap_writel(0x480081e0, 0xc);		/* PM_PWSTCTRL_MPU */
-    omap_writel(0x48008200, 0x047e7ff7);	/* CM_FCLKEN1_CORE */
-    omap_writel(0x48008204, 0x00000004);	/* CM_FCLKEN2_CORE */
-    omap_writel(0x48008210, 0x047e7ff1);	/* CM_ICLKEN1_CORE */
-    omap_writel(0x48008214, 0x00000004);	/* CM_ICLKEN2_CORE */
-    omap_writel(0x4800821c, 0x00000000);	/* CM_ICLKEN4_CORE */
-    omap_writel(0x48008230, 0);			/* CM_AUTOIDLE1_CORE */
-    omap_writel(0x48008234, 0);			/* CM_AUTOIDLE2_CORE */
-    omap_writel(0x48008238, 7);			/* CM_AUTOIDLE3_CORE */
-    omap_writel(0x4800823c, 0);			/* CM_AUTOIDLE4_CORE */
-    omap_writel(0x48008240, 0x04360626);	/* CM_CLKSEL1_CORE */
-    omap_writel(0x48008244, 0x00000014);	/* CM_CLKSEL2_CORE */
-    omap_writel(0x48008248, 0);			/* CM_CLKSTCTRL_CORE */
-    omap_writel(0x48008300, 0x00000000);	/* CM_FCLKEN_GFX */
-    omap_writel(0x48008310, 0x00000000);	/* CM_ICLKEN_GFX */
-    omap_writel(0x48008340, 0x00000001);	/* CM_CLKSEL_GFX */
-    omap_writel(0x48008400, 0x00000004);	/* CM_FCLKEN_WKUP */
-    omap_writel(0x48008410, 0x00000004);	/* CM_ICLKEN_WKUP */
-    omap_writel(0x48008440, 0x00000000);	/* CM_CLKSEL_WKUP */
-    omap_writel(0x48008500, 0x000000cf);	/* CM_CLKEN_PLL */
-    omap_writel(0x48008530, 0x0000000c);	/* CM_AUTOIDLE_PLL */
-    omap_writel(0x48008540,			/* CM_CLKSEL1_PLL */
-                    (0x78 << 12) | (6 << 8));
-    omap_writel(0x48008544, 2);			/* CM_CLKSEL2_PLL */
-
-    /* GPMC setup */
-    n800_gpmc_init(s);
-
-    /* Video setup */
-    n800_dss_init(&s->blizzard);
-
-    /* CPU setup */
-    s->mpu->cpu->env.GE = 0x5;
-
-    /* If the machine has a slided keyboard, open it */
-    if (s->kbd) {
-        qemu_irq_raise(qdev_get_gpio_in(s->mpu->gpio, N810_SLIDE_GPIO));
-    }
-}
-
-#define OMAP_TAG_NOKIA_BT	0x4e01
-#define OMAP_TAG_WLAN_CX3110X	0x4e02
-#define OMAP_TAG_CBUS		0x4e03
-#define OMAP_TAG_EM_ASIC_BB5	0x4e04
-
-static const struct omap_gpiosw_info_s {
-    const char *name;
-    int line;
-    int type;
-} n800_gpiosw_info[] = {
-    {
-        "bat_cover", N800_BAT_COVER_GPIO,
-        OMAP_GPIOSW_TYPE_COVER | OMAP_GPIOSW_INVERTED,
-    }, {
-        "cam_act", N800_CAM_ACT_GPIO,
-        OMAP_GPIOSW_TYPE_ACTIVITY,
-    }, {
-        "cam_turn", N800_CAM_TURN_GPIO,
-        OMAP_GPIOSW_TYPE_ACTIVITY | OMAP_GPIOSW_INVERTED,
-    }, {
-        "headphone", N8X0_HEADPHONE_GPIO,
-        OMAP_GPIOSW_TYPE_CONNECTION | OMAP_GPIOSW_INVERTED,
-    },
-    { /* end of list */ }
-}, n810_gpiosw_info[] = {
-    {
-        "gps_reset", N810_GPS_RESET_GPIO,
-        OMAP_GPIOSW_TYPE_ACTIVITY | OMAP_GPIOSW_OUTPUT,
-    }, {
-        "gps_wakeup", N810_GPS_WAKEUP_GPIO,
-        OMAP_GPIOSW_TYPE_ACTIVITY | OMAP_GPIOSW_OUTPUT,
-    }, {
-        "headphone", N8X0_HEADPHONE_GPIO,
-        OMAP_GPIOSW_TYPE_CONNECTION | OMAP_GPIOSW_INVERTED,
-    }, {
-        "kb_lock", N810_KB_LOCK_GPIO,
-        OMAP_GPIOSW_TYPE_COVER | OMAP_GPIOSW_INVERTED,
-    }, {
-        "sleepx_led", N810_SLEEPX_LED_GPIO,
-        OMAP_GPIOSW_TYPE_ACTIVITY | OMAP_GPIOSW_INVERTED | OMAP_GPIOSW_OUTPUT,
-    }, {
-        "slide", N810_SLIDE_GPIO,
-        OMAP_GPIOSW_TYPE_COVER | OMAP_GPIOSW_INVERTED,
-    },
-    { /* end of list */ }
-};
-
-static const struct omap_partition_info_s {
-    uint32_t offset;
-    uint32_t size;
-    int mask;
-    const char *name;
-} n800_part_info[] = {
-    { 0x00000000, 0x00020000, 0x3, "bootloader" },
-    { 0x00020000, 0x00060000, 0x0, "config" },
-    { 0x00080000, 0x00200000, 0x0, "kernel" },
-    { 0x00280000, 0x00200000, 0x3, "initfs" },
-    { 0x00480000, 0x0fb80000, 0x3, "rootfs" },
-    { /* end of list */ }
-}, n810_part_info[] = {
-    { 0x00000000, 0x00020000, 0x3, "bootloader" },
-    { 0x00020000, 0x00060000, 0x0, "config" },
-    { 0x00080000, 0x00220000, 0x0, "kernel" },
-    { 0x002a0000, 0x00400000, 0x0, "initfs" },
-    { 0x006a0000, 0x0f960000, 0x0, "rootfs" },
-    { /* end of list */ }
-};
-
-static const uint8_t n8x0_bd_addr[6] = { N8X0_BD_ADDR };
-
-static int n8x0_atag_setup(void *p, int model)
-{
-    uint8_t *b;
-    uint16_t *w;
-    uint32_t *l;
-    const struct omap_gpiosw_info_s *gpiosw;
-    const struct omap_partition_info_s *partition;
-    const char *tag;
-
-    w = p;
-
-    stw_p(w++, OMAP_TAG_UART);			/* u16 tag */
-    stw_p(w++, 4);				/* u16 len */
-    stw_p(w++, (1 << 2) | (1 << 1) | (1 << 0)); /* uint enabled_uarts */
-    w++;
-
-#if 0
-    stw_p(w++, OMAP_TAG_SERIAL_CONSOLE);	/* u16 tag */
-    stw_p(w++, 4);				/* u16 len */
-    stw_p(w++, XLDR_LL_UART + 1);		/* u8 console_uart */
-    stw_p(w++, 115200);				/* u32 console_speed */
-#endif
-
-    stw_p(w++, OMAP_TAG_LCD);			/* u16 tag */
-    stw_p(w++, 36);				/* u16 len */
-    strcpy((void *) w, "QEMU LCD panel");	/* char panel_name[16] */
-    w += 8;
-    strcpy((void *) w, "blizzard");		/* char ctrl_name[16] */
-    w += 8;
-    stw_p(w++, N810_BLIZZARD_RESET_GPIO);	/* TODO: n800 s16 nreset_gpio */
-    stw_p(w++, 24);				/* u8 data_lines */
-
-    stw_p(w++, OMAP_TAG_CBUS);			/* u16 tag */
-    stw_p(w++, 8);				/* u16 len */
-    stw_p(w++, N8X0_CBUS_CLK_GPIO);		/* s16 clk_gpio */
-    stw_p(w++, N8X0_CBUS_DAT_GPIO);		/* s16 dat_gpio */
-    stw_p(w++, N8X0_CBUS_SEL_GPIO);		/* s16 sel_gpio */
-    w++;
-
-    stw_p(w++, OMAP_TAG_EM_ASIC_BB5);		/* u16 tag */
-    stw_p(w++, 4);				/* u16 len */
-    stw_p(w++, N8X0_RETU_GPIO);			/* s16 retu_irq_gpio */
-    stw_p(w++, N8X0_TAHVO_GPIO);		/* s16 tahvo_irq_gpio */
-
-    gpiosw = (model == 810) ? n810_gpiosw_info : n800_gpiosw_info;
-    for (; gpiosw->name; gpiosw++) {
-        stw_p(w++, OMAP_TAG_GPIO_SWITCH);	/* u16 tag */
-        stw_p(w++, 20);				/* u16 len */
-        strcpy((void *) w, gpiosw->name);	/* char name[12] */
-        w += 6;
-        stw_p(w++, gpiosw->line);		/* u16 gpio */
-        stw_p(w++, gpiosw->type);
-        stw_p(w++, 0);
-        stw_p(w++, 0);
-    }
-
-    stw_p(w++, OMAP_TAG_NOKIA_BT);		/* u16 tag */
-    stw_p(w++, 12);				/* u16 len */
-    b = (void *) w;
-    stb_p(b++, 0x01);				/* u8 chip_type	(CSR) */
-    stb_p(b++, N8X0_BT_WKUP_GPIO);		/* u8 bt_wakeup_gpio */
-    stb_p(b++, N8X0_BT_HOST_WKUP_GPIO);		/* u8 host_wakeup_gpio */
-    stb_p(b++, N8X0_BT_RESET_GPIO);		/* u8 reset_gpio */
-    stb_p(b++, BT_UART + 1);			/* u8 bt_uart */
-    memcpy(b, &n8x0_bd_addr, 6);		/* u8 bd_addr[6] */
-    b += 6;
-    stb_p(b++, 0x02);				/* u8 bt_sysclk (38.4) */
-    w = (void *) b;
-
-    stw_p(w++, OMAP_TAG_WLAN_CX3110X);		/* u16 tag */
-    stw_p(w++, 8);				/* u16 len */
-    stw_p(w++, 0x25);				/* u8 chip_type */
-    stw_p(w++, N8X0_WLAN_PWR_GPIO);		/* s16 power_gpio */
-    stw_p(w++, N8X0_WLAN_IRQ_GPIO);		/* s16 irq_gpio */
-    stw_p(w++, -1);				/* s16 spi_cs_gpio */
-
-    stw_p(w++, OMAP_TAG_MMC);			/* u16 tag */
-    stw_p(w++, 16);				/* u16 len */
-    if (model == 810) {
-        stw_p(w++, 0x23f);			/* unsigned flags */
-        stw_p(w++, -1);				/* s16 power_pin */
-        stw_p(w++, -1);				/* s16 switch_pin */
-        stw_p(w++, -1);				/* s16 wp_pin */
-        stw_p(w++, 0x240);			/* unsigned flags */
-        stw_p(w++, 0xc000);			/* s16 power_pin */
-        stw_p(w++, 0x0248);			/* s16 switch_pin */
-        stw_p(w++, 0xc000);			/* s16 wp_pin */
-    } else {
-        stw_p(w++, 0xf);			/* unsigned flags */
-        stw_p(w++, -1);				/* s16 power_pin */
-        stw_p(w++, -1);				/* s16 switch_pin */
-        stw_p(w++, -1);				/* s16 wp_pin */
-        stw_p(w++, 0);				/* unsigned flags */
-        stw_p(w++, 0);				/* s16 power_pin */
-        stw_p(w++, 0);				/* s16 switch_pin */
-        stw_p(w++, 0);				/* s16 wp_pin */
-    }
-
-    stw_p(w++, OMAP_TAG_TEA5761);		/* u16 tag */
-    stw_p(w++, 4);				/* u16 len */
-    stw_p(w++, N8X0_TEA5761_CS_GPIO);		/* u16 enable_gpio */
-    w++;
-
-    partition = (model == 810) ? n810_part_info : n800_part_info;
-    for (; partition->name; partition++) {
-        stw_p(w++, OMAP_TAG_PARTITION);		/* u16 tag */
-        stw_p(w++, 28);				/* u16 len */
-        strcpy((void *) w, partition->name);	/* char name[16] */
-        l = (void *) (w + 8);
-        stl_p(l++, partition->size);		/* unsigned int size */
-        stl_p(l++, partition->offset);		/* unsigned int offset */
-        stl_p(l++, partition->mask);		/* unsigned int mask_flags */
-        w = (void *) l;
-    }
-
-    stw_p(w++, OMAP_TAG_BOOT_REASON);		/* u16 tag */
-    stw_p(w++, 12);				/* u16 len */
-#if 0
-    strcpy((void *) w, "por");			/* char reason_str[12] */
-    strcpy((void *) w, "charger");		/* char reason_str[12] */
-    strcpy((void *) w, "32wd_to");		/* char reason_str[12] */
-    strcpy((void *) w, "sw_rst");		/* char reason_str[12] */
-    strcpy((void *) w, "mbus");			/* char reason_str[12] */
-    strcpy((void *) w, "unknown");		/* char reason_str[12] */
-    strcpy((void *) w, "swdg_to");		/* char reason_str[12] */
-    strcpy((void *) w, "sec_vio");		/* char reason_str[12] */
-    strcpy((void *) w, "pwr_key");		/* char reason_str[12] */
-    strcpy((void *) w, "rtc_alarm");		/* char reason_str[12] */
-#else
-    strcpy((void *) w, "pwr_key");		/* char reason_str[12] */
-#endif
-    w += 6;
-
-    tag = (model == 810) ? "RX-44" : "RX-34";
-    stw_p(w++, OMAP_TAG_VERSION_STR);		/* u16 tag */
-    stw_p(w++, 24);				/* u16 len */
-    strcpy((void *) w, "product");		/* char component[12] */
-    w += 6;
-    strcpy((void *) w, tag);			/* char version[12] */
-    w += 6;
-
-    stw_p(w++, OMAP_TAG_VERSION_STR);		/* u16 tag */
-    stw_p(w++, 24);				/* u16 len */
-    strcpy((void *) w, "hw-build");		/* char component[12] */
-    w += 6;
-    strcpy((void *) w, "QEMU ");
-    pstrcat((void *) w, 12, qemu_hw_version()); /* char version[12] */
-    w += 6;
-
-    tag = (model == 810) ? "1.1.10-qemu" : "1.1.6-qemu";
-    stw_p(w++, OMAP_TAG_VERSION_STR);		/* u16 tag */
-    stw_p(w++, 24);				/* u16 len */
-    strcpy((void *) w, "nolo");			/* char component[12] */
-    w += 6;
-    strcpy((void *) w, tag);			/* char version[12] */
-    w += 6;
-
-    return (void *) w - p;
-}
-
-static int n800_atag_setup(const struct arm_boot_info *info, void *p)
-{
-    return n8x0_atag_setup(p, 800);
-}
-
-static int n810_atag_setup(const struct arm_boot_info *info, void *p)
-{
-    return n8x0_atag_setup(p, 810);
-}
-
-static void n8x0_init(MachineState *machine,
-                      struct arm_boot_info *binfo, int model)
-{
-    struct n800_s *s = g_malloc0(sizeof(*s));
-    MachineClass *mc = MACHINE_GET_CLASS(machine);
-
-    if (machine->ram_size != mc->default_ram_size) {
-        char *sz = size_to_str(mc->default_ram_size);
-        error_report("Invalid RAM size, should be %s", sz);
-        g_free(sz);
-        exit(EXIT_FAILURE);
-    }
-    binfo->ram_size = machine->ram_size;
-
-    memory_region_add_subregion(get_system_memory(), OMAP2_Q2_BASE,
-                                machine->ram);
-
-    s->mpu = omap2420_mpu_init(machine->ram, machine->cpu_type);
-
-    /* Setup peripherals
-     *
-     * Believed external peripherals layout in the N810:
-     * (spi bus 1)
-     *   tsc2005
-     *   lcd_mipid
-     * (spi bus 2)
-     *   Conexant cx3110x (WLAN)
-     *   optional: pc2400m (WiMAX)
-     * (i2c bus 0)
-     *   TLV320AIC33 (audio codec)
-     *   TCM825x (camera by Toshiba)
-     *   lp5521 (clever LEDs)
-     *   tsl2563 (light sensor, hwmon, model 7, rev. 0)
-     *   lm8323 (keypad, manf 00, rev 04)
-     * (i2c bus 1)
-     *   tmp105 (temperature sensor, hwmon)
-     *   menelaus (pm)
-     * (somewhere on i2c - maybe N800-only)
-     *   tea5761 (FM tuner)
-     * (serial 0)
-     *   GPS
-     * (some serial port)
-     *   csr41814 (Bluetooth)
-     */
-    n8x0_gpio_setup(s);
-    n8x0_nand_setup(s);
-    n8x0_i2c_setup(s);
-    if (model == 800) {
-        n800_tsc_kbd_setup(s);
-    } else if (model == 810) {
-        n810_tsc_setup(s);
-        n810_kbd_setup(s);
-    }
-    n8x0_spi_setup(s);
-    n8x0_dss_setup(s);
-    n8x0_cbus_setup(s);
-    n8x0_usb_setup(s);
-
-    if (machine->kernel_filename) {
-        /* Or at the linux loader.  */
-        arm_load_kernel(s->mpu->cpu, machine, binfo);
-
-        qemu_register_reset(n8x0_boot_init, s);
-    }
-
-    if (option_rom[0].name &&
-        (machine->boot_config.order[0] == 'n' || !machine->kernel_filename)) {
-        uint8_t *nolo_tags = g_new(uint8_t, 0x10000);
-        /* No, wait, better start at the ROM.  */
-        s->mpu->cpu->env.regs[15] = OMAP2_Q2_BASE + 0x400000;
-
-        /*
-         * This is intended for loading the `secondary.bin' program from
-         * Nokia images (the NOLO bootloader).  The entry point seems
-         * to be at OMAP2_Q2_BASE + 0x400000.
-         *
-         * The `2nd.bin' files contain some kind of earlier boot code and
-         * for them the entry point needs to be set to OMAP2_SRAM_BASE.
-         *
-         * The code above is for loading the `zImage' file from Nokia
-         * images.
-         */
-        if (load_image_targphys(option_rom[0].name,
-                                OMAP2_Q2_BASE + 0x400000,
-                                machine->ram_size - 0x400000) < 0) {
-            error_report("Failed to load secondary bootloader %s",
-                         option_rom[0].name);
-            exit(EXIT_FAILURE);
-        }
-
-        n800_setup_nolo_tags(nolo_tags);
-        cpu_physical_memory_write(OMAP2_SRAM_BASE, nolo_tags, 0x10000);
-        g_free(nolo_tags);
-    }
-}
-
-static struct arm_boot_info n800_binfo = {
-    .loader_start = OMAP2_Q2_BASE,
-    .board_id = 0x4f7,
-    .atag_board = n800_atag_setup,
-};
-
-static struct arm_boot_info n810_binfo = {
-    .loader_start = OMAP2_Q2_BASE,
-    /* 0x60c and 0x6bf (WiMAX Edition) have been assigned but are not
-     * used by some older versions of the bootloader and 5555 is used
-     * instead (including versions that shipped with many devices).  */
-    .board_id = 0x60c,
-    .atag_board = n810_atag_setup,
-};
-
-static void n800_init(MachineState *machine)
-{
-    n8x0_init(machine, &n800_binfo, 800);
-}
-
-static void n810_init(MachineState *machine)
-{
-    n8x0_init(machine, &n810_binfo, 810);
-}
-
-static void n800_class_init(ObjectClass *oc, void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-
-    mc->desc = "Nokia N800 tablet aka. RX-34 (OMAP2420)";
-    mc->init = n800_init;
-    mc->default_boot_order = "";
-    mc->ignore_memory_transaction_failures = true;
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm1136-r2");
-    /* Actually two chips of 0x4000000 bytes each */
-    mc->default_ram_size = 0x08000000;
-    mc->default_ram_id = "omap2.dram";
-    mc->deprecation_reason = "machine is old and unmaintained";
-
-    machine_add_audiodev_property(mc);
-}
-
-static const TypeInfo n800_type = {
-    .name = MACHINE_TYPE_NAME("n800"),
-    .parent = TYPE_MACHINE,
-    .class_init = n800_class_init,
-};
-
-static void n810_class_init(ObjectClass *oc, void *data)
-{
-    MachineClass *mc = MACHINE_CLASS(oc);
-
-    mc->desc = "Nokia N810 tablet aka. RX-44 (OMAP2420)";
-    mc->init = n810_init;
-    mc->default_boot_order = "";
-    mc->ignore_memory_transaction_failures = true;
-    mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm1136-r2");
-    /* Actually two chips of 0x4000000 bytes each */
-    mc->default_ram_size = 0x08000000;
-    mc->default_ram_id = "omap2.dram";
-    mc->deprecation_reason = "machine is old and unmaintained";
-
-    machine_add_audiodev_property(mc);
-}
-
-static const TypeInfo n810_type = {
-    .name = MACHINE_TYPE_NAME("n810"),
-    .parent = TYPE_MACHINE,
-    .class_init = n810_class_init,
-};
-
-static void nseries_machine_init(void)
-{
-    type_register_static(&n800_type);
-    type_register_static(&n810_type);
-}
-
-type_init(nseries_machine_init)
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 379800c78fd..dc00d91d731 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -12,7 +12,6 @@ arm_ss.add(when: 'CONFIG_MUSICPAL', if_true: files('musicpal.c'))
 arm_ss.add(when: 'CONFIG_NETDUINOPLUS2', if_true: files('netduinoplus2.c'))
 arm_ss.add(when: 'CONFIG_OLIMEX_STM32_H405', if_true: files('olimex-stm32-h405.c'))
 arm_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx.c', 'npcm7xx_boards.c'))
-arm_ss.add(when: 'CONFIG_NSERIES', if_true: files('nseries.c'))
 arm_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview.c'))
 arm_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa-ref.c'))
 arm_ss.add(when: 'CONFIG_STELLARIS', if_true: files('stellaris.c'))
diff --git a/tests/avocado/machine_arm_n8x0.py b/tests/avocado/machine_arm_n8x0.py
deleted file mode 100644
index 12e9a6803ba..00000000000
--- a/tests/avocado/machine_arm_n8x0.py
+++ /dev/null
@@ -1,49 +0,0 @@
-# Functional test that boots a Linux kernel and checks the console
-#
-# Copyright (c) 2020 Red Hat, Inc.
-#
-# Author:
-#  Thomas Huth <thuth@redhat.com>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later.  See the COPYING file in the top-level directory.
-
-import os
-
-from avocado import skipUnless
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
-
-class N8x0Machine(QemuSystemTest):
-    """Boots the Linux kernel and checks that the console is operational"""
-
-    timeout = 90
-
-    def __do_test_n8x0(self):
-        kernel_url = ('http://stskeeps.subnetmask.net/meego-n8x0/'
-                      'meego-arm-n8x0-1.0.80.20100712.1431-'
-                      'vmlinuz-2.6.35~rc4-129.1-n8x0')
-        kernel_hash = 'e9d5ab8d7548923a0061b6fbf601465e479ed269'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-
-        self.vm.set_console(console_index=1)
-        self.vm.add_args('-kernel', kernel_path,
-                         '-append', 'printk.time=0 console=ttyS1')
-        self.vm.launch()
-        wait_for_console_pattern(self, 'TSC2005 driver initializing')
-
-    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
-    def test_n800(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:n800
-        """
-        self.__do_test_n8x0()
-
-    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
-    def test_n810(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:n810
-        """
-        self.__do_test_n8x0()
-- 
2.34.1


