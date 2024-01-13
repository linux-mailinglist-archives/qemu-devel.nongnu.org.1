Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4A082CE43
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 20:18:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOjVJ-0006AP-Nq; Sat, 13 Jan 2024 14:17:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rOjV8-00068q-B0; Sat, 13 Jan 2024 14:17:02 -0500
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rOjV5-000871-6b; Sat, 13 Jan 2024 14:17:01 -0500
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3606f3f2f37so41982805ab.0; 
 Sat, 13 Jan 2024 11:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705173417; x=1705778217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kmTXIKSduchiafZzPeyicjbn5dx+0HWApKPhZvkJLxc=;
 b=Cw0NqdsUpxXZX96aVXXHjUktK4if2cEL82PZnqzcxXy5HZu3XslmXOZUoiRgKEdYQv
 Wgl4dk+xOjxLycdGZvwFR4tJFdoXoAt3imeQLlmWhiljqGCkrkBhuRV9OFHKwosR3Svk
 9ZnWJ+BIkinxJec59U2Jc0JAG0Jt6euoQLfaa4FTJQ9Nk3gwRX3dzBl39E/neEjd/Ws0
 vGkNflLlBK9j367yH2I2E32WUCAr5cSKM/ViRompQG/lmJHRULJsy8AYbZ/YHdT4M/aV
 kOs+khL7rXJb2ZmgT/1234QPAsC7nePB8NbHuBgWLZOJ3oV/wuOfNvVJQhImC11qAZ55
 HhiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705173417; x=1705778217;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kmTXIKSduchiafZzPeyicjbn5dx+0HWApKPhZvkJLxc=;
 b=bBUtwQHagQnBR3nYUa7Udn/TyyqJMykaAxF5+11HwP3fADdQWIsTLtcGmLWzNxZLJy
 opfW42a7Fr0HtRkbx0jGuCK/HD1P5t2L6/nNuDq7JPzpltRFmu70MDDN6WbJhzdnbD5I
 blAKMYFWv6meIqkHTlw3Bm7Mgf1O2amaT+OTuf1EjoM9CS0iwqtByOGmfL2HyCXCqaer
 QOr4VoCC+/IUXq2hGRLRQk49DSVPjY6FeRMKX3Di3m8PlIPLC6hn4qsznOVOAQk4Ea9T
 TwFaqXSzaPR76Ow/yQK3ZMBK+sfX/wAYrKhiMn+OYpldUBDQIQn4T6nCv8+qYAusQkg/
 DHPw==
X-Gm-Message-State: AOJu0YwpjXAXjHFttOrduf84vzn1VaYFJH2nmHvCzNb+vmKsanJ0RaIN
 7k5VDXS9VMPBTJNIUzgLJ6Y=
X-Google-Smtp-Source: AGHT+IH0nE/NLXjtvgmN44ufeuwsaI5zn4jXppVTzrYP7rzovnxgw0FA3MEaEuFvqGbqvrCI6A6fRQ==
X-Received: by 2002:a92:d410:0:b0:360:97d9:309f with SMTP id
 q16-20020a92d410000000b0036097d9309fmr2951699ilm.5.1705173417495; 
 Sat, 13 Jan 2024 11:16:57 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 bs192-20020a6328c9000000b005c6e8fa9f24sm5322212pgb.49.2024.01.13.11.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jan 2024 11:16:57 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 2/3] hw/arm: Add AHCI/SATA controller to Allwinner R40 and
 Bananapi board
Date: Sat, 13 Jan 2024 11:16:50 -0800
Message-Id: <20240113191651.1313226-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240113191651.1313226-1-linux@roeck-us.net>
References: <20240113191651.1313226-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=groeck7@gmail.com; helo=mail-il1-x131.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.248, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Allwinner R40 supports an AHCI compliant SATA controller.
Add support for it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 docs/system/arm/bananapi_m2u.rst |  1 +
 hw/arm/Kconfig                   |  1 +
 hw/arm/allwinner-r40.c           | 12 +++++++++++-
 include/hw/arm/allwinner-r40.h   |  3 +++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/bananapi_m2u.rst b/docs/system/arm/bananapi_m2u.rst
index e77c425e2c..542310591d 100644
--- a/docs/system/arm/bananapi_m2u.rst
+++ b/docs/system/arm/bananapi_m2u.rst
@@ -22,6 +22,7 @@ The Banana Pi M2U machine supports the following devices:
  * EMAC ethernet
  * GMAC ethernet
  * Clock Control Unit
+ * SATA
  * TWI (I2C)
  * USB 2.0
 
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 6b508780d3..98ca5ebc7d 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -408,6 +408,7 @@ config ALLWINNER_H3
 config ALLWINNER_R40
     bool
     default y if TCG && ARM
+    select AHCI
     select ALLWINNER_SRAMC
     select ALLWINNER_A10_PIT
     select AXP2XX_PMU
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index f42b0fa0ce..f90d59fb5e 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -46,6 +46,7 @@ const hwaddr allwinner_r40_memmap[] = {
     [AW_R40_DEV_MMC1]       = 0x01c10000,
     [AW_R40_DEV_MMC2]       = 0x01c11000,
     [AW_R40_DEV_MMC3]       = 0x01c12000,
+    [AW_R40_DEV_AHCI]       = 0x01c18000,
     [AW_R40_DEV_EHCI1]      = 0x01c19000,
     [AW_R40_DEV_OHCI1]      = 0x01c19400,
     [AW_R40_DEV_EHCI2]      = 0x01c1c000,
@@ -93,7 +94,6 @@ static struct AwR40Unimplemented r40_unimplemented[] = {
     { "usb0-host",  0x01c14000, 4 * KiB },
     { "crypto",     0x01c15000, 4 * KiB },
     { "spi2",       0x01c17000, 4 * KiB },
-    { "sata",       0x01c18000, 4 * KiB },
     { "usb1-phy",   0x01c19800, 2 * KiB },
     { "sid",        0x01c1b000, 4 * KiB },
     { "usb2-phy",   0x01c1c800, 2 * KiB },
@@ -186,6 +186,7 @@ enum {
     AW_R40_GIC_SPI_MMC2      = 34,
     AW_R40_GIC_SPI_MMC3      = 35,
     AW_R40_GIC_SPI_EMAC      = 55,
+    AW_R40_GIC_SPI_AHCI      = 56,
     AW_R40_GIC_SPI_OHCI1     = 64,
     AW_R40_GIC_SPI_OHCI2     = 65,
     AW_R40_GIC_SPI_EHCI1     = 76,
@@ -285,6 +286,8 @@ static void allwinner_r40_init(Object *obj)
                                 TYPE_AW_SDHOST_SUN50I_A64);
     }
 
+    object_initialize_child(obj, "sata", &s->sata, TYPE_ALLWINNER_AHCI);
+
     if (machine_usb(current_machine)) {
         int i;
 
@@ -427,6 +430,13 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(&s->ccu), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, s->memmap[AW_R40_DEV_CCU]);
 
+    /* SATA / AHCI */
+    sysbus_realize(SYS_BUS_DEVICE(&s->sata), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sata), 0,
+                    allwinner_r40_memmap[AW_R40_DEV_AHCI]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sata), 0,
+                       qdev_get_gpio_in(DEVICE(&s->gic), AW_R40_GIC_SPI_AHCI));
+
     /* USB */
     if (machine_usb(current_machine)) {
         int i;
diff --git a/include/hw/arm/allwinner-r40.h b/include/hw/arm/allwinner-r40.h
index ae82822d42..c589fcc1c1 100644
--- a/include/hw/arm/allwinner-r40.h
+++ b/include/hw/arm/allwinner-r40.h
@@ -22,6 +22,7 @@
 
 #include "qom/object.h"
 #include "hw/timer/allwinner-a10-pit.h"
+#include "hw/ide/ahci.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/sd/allwinner-sdhost.h"
 #include "hw/misc/allwinner-r40-ccu.h"
@@ -46,6 +47,7 @@ enum {
     AW_R40_DEV_MMC1,
     AW_R40_DEV_MMC2,
     AW_R40_DEV_MMC3,
+    AW_R40_DEV_AHCI,
     AW_R40_DEV_EHCI1,
     AW_R40_DEV_OHCI1,
     AW_R40_DEV_EHCI2,
@@ -112,6 +114,7 @@ struct AwR40State {
     const hwaddr *memmap;
     AwSRAMCState sramc;
     AwA10PITState timer;
+    AllwinnerAHCIState sata;
     AwSdHostState mmc[AW_R40_NUM_MMCS];
     EHCISysBusState ehci[AW_R40_NUM_USB];
     OHCISysBusState ohci[AW_R40_NUM_USB];
-- 
2.39.2


