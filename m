Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3484C82CE45
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 20:18:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOjVL-0006Bx-RJ; Sat, 13 Jan 2024 14:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rOjV6-00068d-MZ; Sat, 13 Jan 2024 14:17:02 -0500
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rOjV4-00086h-5g; Sat, 13 Jan 2024 14:17:00 -0500
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7bf0f3bf331so91831939f.3; 
 Sat, 13 Jan 2024 11:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705173416; x=1705778216; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vdzb8H19NYsHfeLKkJiuknY8eZ0SHTlmQUvH+K6Kous=;
 b=jbX/NVL6yWm5zugL8kxIrNf9mem2q490UJtoP3RVBkl5AH7pp4mzLwIDTlaHWE5NhJ
 pvG3m+mOGVwIiEZFa0sI5s/KrP5KedwLpSb/UKUXhdZVEQgC1lcpqvP5ktShPcmMbWxB
 U4o5EfayZqLPElRAJ8pEpOeQEYKcgdL3P8c2Cy4mCwnhhlyuwp3MKqKH9NJw3VQsrutO
 VTSRsHjDWwCRKpAQr5z+Ktq2nSKvoDBggIFGSO4acRaPWwri/ni5dMwI9Ovyo/sR4n2k
 VB/kiPAwlskbGyZP/jSM90W2ujW9MItU4AH6jHJMZmW33u4z7I7+hZCNY8Ny3+jDP9AM
 2ToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705173416; x=1705778216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vdzb8H19NYsHfeLKkJiuknY8eZ0SHTlmQUvH+K6Kous=;
 b=SOGhgNg5zlLtjQ2q8/k2vwioXJ9aIAs2DBqGo/oks4U64zWtW8lBak58i1lK3s9fpI
 2KjryevivjgAxJ9Ir3S2lYnriUwcdekZV6kEI0wJbmQsc9wGO+/cpBVEHc1k0uW8EzA+
 Btj6R/ezPKRl6H/BHnaolOsEsrQpBHeoXm7QIAmtabuD2etibupPro4rI/eywTmVPmv9
 p4ljcjEZiwBWQ/nRASi8MC8/VHLb5UVGYU/Tlb4wIQ5WR3cbGrGKC8IGeuxau8TB55bW
 WpNf1pwnBRxZI/kIdIdvPiMp3/8OeaYHJFu/HkdKtGxiHpMwvW+QikUiSskfx6NLU+fc
 qnmw==
X-Gm-Message-State: AOJu0YxUfaHvIhqVpfn3mnXbM6vOhvHQr9CBPsiVW3F9CJxBnhhOmaIY
 X2B3V+1U+52TLf40cfJBNO8=
X-Google-Smtp-Source: AGHT+IH+UpxRRrtrjAyl8onUHDhcw+iq0rcOs8TMdfaHzmMQVV6xpQPhfCdAblimQ2DwfbTody37oQ==
X-Received: by 2002:a92:c26a:0:b0:35f:c678:9513 with SMTP id
 h10-20020a92c26a000000b0035fc6789513mr4681090ild.27.1705173416049; 
 Sat, 13 Jan 2024 11:16:56 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 lb16-20020a170902fa5000b001d5a74dfdf4sm3220916plb.235.2024.01.13.11.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jan 2024 11:16:55 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/3] hw/arm: Add EHCI/OHCI controllers to Allwinner R40 and
 Bananapi board
Date: Sat, 13 Jan 2024 11:16:49 -0800
Message-Id: <20240113191651.1313226-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240113191651.1313226-1-linux@roeck-us.net>
References: <20240113191651.1313226-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d35;
 envelope-from=groeck7@gmail.com; helo=mail-io1-xd35.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.248, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=no autolearn_force=no
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

Allwinner R40 supports two USB host ports shared between a USB 2.0 EHCI
host controller and a USB 1.1 OHCI host controller. Add support for both
of them.

If machine USB support is not enabled, create unimplemented devices
for the USB memory ranges to avoid crashes when booting Linux.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 docs/system/arm/bananapi_m2u.rst |  2 +-
 hw/arm/Kconfig                   |  2 +
 hw/arm/allwinner-r40.c           | 70 +++++++++++++++++++++++++++++++-
 include/hw/arm/allwinner-r40.h   |  9 ++++
 4 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/docs/system/arm/bananapi_m2u.rst b/docs/system/arm/bananapi_m2u.rst
index b09ba5c548..e77c425e2c 100644
--- a/docs/system/arm/bananapi_m2u.rst
+++ b/docs/system/arm/bananapi_m2u.rst
@@ -23,6 +23,7 @@ The Banana Pi M2U machine supports the following devices:
  * GMAC ethernet
  * Clock Control Unit
  * TWI (I2C)
+ * USB 2.0
 
 Limitations
 """""""""""
@@ -33,7 +34,6 @@ Currently, Banana Pi M2U does *not* support the following features:
 - Audio output
 - Hardware Watchdog
 - Real Time Clock
-- USB 2.0 interfaces
 
 Also see the 'unimplemented' array in the Allwinner R40 SoC module
 for a complete list of unimplemented I/O devices: ``./hw/arm/allwinner-r40.c``
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 39d255425b..6b508780d3 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -415,6 +415,8 @@ config ALLWINNER_R40
     select ARM_TIMER
     select ARM_GIC
     select UNIMP
+    select USB_OHCI
+    select USB_EHCI_SYSBUS
     select SD
 
 config RASPI
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index a0d367c60d..f42b0fa0ce 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -23,6 +23,7 @@
 #include "qemu/bswap.h"
 #include "qemu/module.h"
 #include "qemu/units.h"
+#include "hw/boards.h"
 #include "hw/qdev-core.h"
 #include "hw/sysbus.h"
 #include "hw/char/serial.h"
@@ -45,6 +46,10 @@ const hwaddr allwinner_r40_memmap[] = {
     [AW_R40_DEV_MMC1]       = 0x01c10000,
     [AW_R40_DEV_MMC2]       = 0x01c11000,
     [AW_R40_DEV_MMC3]       = 0x01c12000,
+    [AW_R40_DEV_EHCI1]      = 0x01c19000,
+    [AW_R40_DEV_OHCI1]      = 0x01c19400,
+    [AW_R40_DEV_EHCI2]      = 0x01c1c000,
+    [AW_R40_DEV_OHCI2]      = 0x01c1c400,
     [AW_R40_DEV_CCU]        = 0x01c20000,
     [AW_R40_DEV_PIT]        = 0x01c20c00,
     [AW_R40_DEV_UART0]      = 0x01c28000,
@@ -89,9 +94,9 @@ static struct AwR40Unimplemented r40_unimplemented[] = {
     { "crypto",     0x01c15000, 4 * KiB },
     { "spi2",       0x01c17000, 4 * KiB },
     { "sata",       0x01c18000, 4 * KiB },
-    { "usb1-host",  0x01c19000, 4 * KiB },
+    { "usb1-phy",   0x01c19800, 2 * KiB },
     { "sid",        0x01c1b000, 4 * KiB },
-    { "usb2-host",  0x01c1c000, 4 * KiB },
+    { "usb2-phy",   0x01c1c800, 2 * KiB },
     { "cs1",        0x01c1d000, 4 * KiB },
     { "spi3",       0x01c1f000, 4 * KiB },
     { "rtc",        0x01c20400, 1 * KiB },
@@ -181,6 +186,10 @@ enum {
     AW_R40_GIC_SPI_MMC2      = 34,
     AW_R40_GIC_SPI_MMC3      = 35,
     AW_R40_GIC_SPI_EMAC      = 55,
+    AW_R40_GIC_SPI_OHCI1     = 64,
+    AW_R40_GIC_SPI_OHCI2     = 65,
+    AW_R40_GIC_SPI_EHCI1     = 76,
+    AW_R40_GIC_SPI_EHCI2     = 78,
     AW_R40_GIC_SPI_GMAC      = 85,
 };
 
@@ -276,6 +285,17 @@ static void allwinner_r40_init(Object *obj)
                                 TYPE_AW_SDHOST_SUN50I_A64);
     }
 
+    if (machine_usb(current_machine)) {
+        int i;
+
+        for (i = 0; i < AW_R40_NUM_USB; i++) {
+            object_initialize_child(obj, "ehci[*]", &s->ehci[i],
+                                    TYPE_PLATFORM_EHCI);
+            object_initialize_child(obj, "ohci[*]", &s->ohci[i],
+                                    TYPE_SYSBUS_OHCI);
+        }
+    }
+
     object_initialize_child(obj, "twi0", &s->i2c0, TYPE_AW_I2C_SUN6I);
 
     object_initialize_child(obj, "emac", &s->emac, TYPE_AW_EMAC);
@@ -407,6 +427,37 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(&s->ccu), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, s->memmap[AW_R40_DEV_CCU]);
 
+    /* USB */
+    if (machine_usb(current_machine)) {
+        int i;
+
+        for (i = 0; i < AW_R40_NUM_USB; i++) {
+            g_autofree char *bus = g_strdup_printf("usb-bus.%d", i);
+
+            object_property_set_bool(OBJECT(&s->ehci[i]), "companion-enable",
+                                     true, &error_fatal);
+            sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), &error_fatal);
+            sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0,
+                            allwinner_r40_memmap[i ? AW_R40_DEV_EHCI2
+                                                   : AW_R40_DEV_EHCI1]);
+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
+                               qdev_get_gpio_in(DEVICE(&s->gic),
+                                                i ? AW_R40_GIC_SPI_EHCI2
+                                                  : AW_R40_GIC_SPI_EHCI1));
+
+            object_property_set_str(OBJECT(&s->ohci[i]), "masterbus", bus,
+                                    &error_fatal);
+            sysbus_realize(SYS_BUS_DEVICE(&s->ohci[i]), &error_fatal);
+            sysbus_mmio_map(SYS_BUS_DEVICE(&s->ohci[i]), 0,
+                            allwinner_r40_memmap[i ? AW_R40_DEV_OHCI2
+                                                   : AW_R40_DEV_OHCI1]);
+            sysbus_connect_irq(SYS_BUS_DEVICE(&s->ohci[i]), 0,
+                               qdev_get_gpio_in(DEVICE(&s->gic),
+                                                i ? AW_R40_GIC_SPI_OHCI2
+                                                  : AW_R40_GIC_SPI_OHCI1));
+        }
+    }
+
     /* SD/MMC */
     for (int i = 0; i < AW_R40_NUM_MMCS; i++) {
         qemu_irq irq = qdev_get_gpio_in(DEVICE(&s->gic),
@@ -498,6 +549,21 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
                                     r40_unimplemented[i].base,
                                     r40_unimplemented[i].size);
     }
+    if (!machine_usb(current_machine)) {
+        /* unimplemented if USB is not enabled */
+        create_unimplemented_device("usb-ehci1",
+                                    allwinner_r40_memmap[AW_R40_DEV_EHCI1],
+                                    0x800);
+        create_unimplemented_device("usb-ehci2",
+                                    allwinner_r40_memmap[AW_R40_DEV_EHCI2],
+                                    0x800);
+        create_unimplemented_device("usb-ohci1",
+                                    allwinner_r40_memmap[AW_R40_DEV_OHCI1],
+                                    0x800);
+        create_unimplemented_device("usb-ohci2",
+                                    allwinner_r40_memmap[AW_R40_DEV_OHCI2],
+                                    0x800);
+    }
 }
 
 static void allwinner_r40_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/arm/allwinner-r40.h b/include/hw/arm/allwinner-r40.h
index 6e1ac9d4c1..ae82822d42 100644
--- a/include/hw/arm/allwinner-r40.h
+++ b/include/hw/arm/allwinner-r40.h
@@ -30,6 +30,8 @@
 #include "hw/i2c/allwinner-i2c.h"
 #include "hw/net/allwinner_emac.h"
 #include "hw/net/allwinner-sun8i-emac.h"
+#include "hw/usb/hcd-ohci.h"
+#include "hw/usb/hcd-ehci.h"
 #include "target/arm/cpu.h"
 #include "sysemu/block-backend.h"
 
@@ -44,6 +46,10 @@ enum {
     AW_R40_DEV_MMC1,
     AW_R40_DEV_MMC2,
     AW_R40_DEV_MMC3,
+    AW_R40_DEV_EHCI1,
+    AW_R40_DEV_OHCI1,
+    AW_R40_DEV_EHCI2,
+    AW_R40_DEV_OHCI2,
     AW_R40_DEV_CCU,
     AW_R40_DEV_PIT,
     AW_R40_DEV_UART0,
@@ -88,6 +94,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AwR40State, AW_R40)
  * which are currently emulated by the R40 SoC code.
  */
 #define AW_R40_NUM_MMCS         4
+#define AW_R40_NUM_USB          2
 #define AW_R40_NUM_UARTS        8
 
 struct AwR40State {
@@ -106,6 +113,8 @@ struct AwR40State {
     AwSRAMCState sramc;
     AwA10PITState timer;
     AwSdHostState mmc[AW_R40_NUM_MMCS];
+    EHCISysBusState ehci[AW_R40_NUM_USB];
+    OHCISysBusState ohci[AW_R40_NUM_USB];
     AwR40ClockCtlState ccu;
     AwR40DramCtlState dramc;
     AWI2CState i2c0;
-- 
2.39.2


