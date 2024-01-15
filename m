Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A309282DFE3
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 19:29:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPRh6-0007Lz-2e; Mon, 15 Jan 2024 13:28:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rPRh0-0007L5-Pv; Mon, 15 Jan 2024 13:28:14 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rPRgz-0007UW-40; Mon, 15 Jan 2024 13:28:14 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5ce6b5e3c4eso3907298a12.2; 
 Mon, 15 Jan 2024 10:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705343284; x=1705948084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yKviD+fTgsbkzKSvG2qQrwO1qDngIuE9nR0I7Pin3/w=;
 b=PmQfz5mMZ3KvLjFjaUrWbVwmYvHgBzivDc1jZdR6C/oRl5kjegCh8eXJcWzQroJrZk
 XloFj2qMMeVc91rrwDMVmMgmy9tlR/mOgxyeqP/6ySkOQdvPprKwL+2INHt6TB+KOePf
 5nf1V7mYB50JrKr2jeljk4T8cyOn81UK4Ex1qcc+LNtndQkI1S2Nt236vFeOi9J3I7Rw
 mXqtIaZqQjR5gpsXiOjmx7ezT0vYLUw03MHD4hJX165e8WCV4isYQeQqwudA6nWbkJlH
 Bl9f25I11KNjuuYFOZbmwHBk4UR1ANcJnmn0Uxw4ixDZJMdm55bjodW0kdZJ1We5jpD3
 Wg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705343284; x=1705948084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yKviD+fTgsbkzKSvG2qQrwO1qDngIuE9nR0I7Pin3/w=;
 b=tj+qZGzVSLOFPPvpg3v77Xj1jtZo0EOz4C75O72opWaAQOfGYevn2nggtLVkIBGxUy
 VLVU+s8h1Hn4nVEqXS5l759Ubur9p1VZqAvk9COMAxVyjYVhBDsD1eMAtX6tBDfOoDvU
 LJ/lkXyfWGDcvanNHeRZN8LpU3eG0BEbjP32odxv/+j4Rnz31GQuDnD7aKkgBinD6sqe
 weRkP9bZZs1X6GB+zJrZiEUah76PLwxzQeYKJeX0DWKWtjiKfasK+WQxECSwHA13FCjj
 39cq+66XF6/y7FCV+Zez3fS9foQZ7zQQ9B1qIDvfVRrv5fGAVVBdTRsT+Xgeng/xi985
 MaMg==
X-Gm-Message-State: AOJu0YyDi239tfqFJiQWjUdesgMELtgpOPWG5KruXQmBGajyD7AB79aR
 Ke7mcxh61HkzLk2mdvlLEEY=
X-Google-Smtp-Source: AGHT+IHcXmyVEDSCGUfm4jvyDUE++4Fji5yIHsaes7y9J145IQVomD8N6QrtJNmHIwrq3giaT26bBQ==
X-Received: by 2002:a05:6a21:604:b0:19a:2b2b:ef98 with SMTP id
 ll4-20020a056a21060400b0019a2b2bef98mr2991249pzb.27.1705343284604; 
 Mon, 15 Jan 2024 10:28:04 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a17090ac88c00b0028cbfdbd804sm12354486pjt.45.2024.01.15.10.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 10:28:04 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 3/3] hw/arm: Add watchdog timer to Allwinner H40 and
 Bananapi board
Date: Mon, 15 Jan 2024 10:27:57 -0800
Message-Id: <20240115182757.1095012-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240115182757.1095012-1-linux@roeck-us.net>
References: <20240115182757.1095012-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=groeck7@gmail.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
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

Add watchdog timer support to Allwinner-H40 and Bananapi.
The watchdog timer is added as an overlay to the Timer
module memory map.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 docs/system/arm/bananapi_m2u.rst | 2 +-
 hw/arm/Kconfig                   | 1 +
 hw/arm/allwinner-r40.c           | 8 ++++++++
 include/hw/arm/allwinner-r40.h   | 3 +++
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/bananapi_m2u.rst b/docs/system/arm/bananapi_m2u.rst
index 542310591d..587b488655 100644
--- a/docs/system/arm/bananapi_m2u.rst
+++ b/docs/system/arm/bananapi_m2u.rst
@@ -25,6 +25,7 @@ The Banana Pi M2U machine supports the following devices:
  * SATA
  * TWI (I2C)
  * USB 2.0
+ * Hardware Watchdog
 
 Limitations
 """""""""""
@@ -33,7 +34,6 @@ Currently, Banana Pi M2U does *not* support the following features:
 
 - Graphical output via HDMI, GPU and/or the Display Engine
 - Audio output
-- Hardware Watchdog
 - Real Time Clock
 
 Also see the 'unimplemented' array in the Allwinner R40 SoC module
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 98ca5ebc7d..386edbae15 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -411,6 +411,7 @@ config ALLWINNER_R40
     select AHCI
     select ALLWINNER_SRAMC
     select ALLWINNER_A10_PIT
+    select ALLWINNER_WDT
     select AXP2XX_PMU
     select SERIAL
     select ARM_TIMER
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index 534be4a735..a28e5b3886 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -53,6 +53,7 @@ const hwaddr allwinner_r40_memmap[] = {
     [AW_R40_DEV_OHCI2]      = 0x01c1c400,
     [AW_R40_DEV_CCU]        = 0x01c20000,
     [AW_R40_DEV_PIT]        = 0x01c20c00,
+    [AW_R40_DEV_WDT]        = 0x01c20c90,
     [AW_R40_DEV_UART0]      = 0x01c28000,
     [AW_R40_DEV_UART1]      = 0x01c28400,
     [AW_R40_DEV_UART2]      = 0x01c28800,
@@ -279,6 +280,8 @@ static void allwinner_r40_init(Object *obj)
     object_property_add_alias(obj, "clk1-freq", OBJECT(&s->timer),
                               "clk1-freq");
 
+    object_initialize_child(obj, "wdt", &s->wdt, TYPE_AW_WDT_SUN4I);
+
     object_initialize_child(obj, "ccu", &s->ccu, TYPE_AW_R40_CCU);
 
     for (int i = 0; i < AW_R40_NUM_MMCS; i++) {
@@ -545,6 +548,11 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->emac), 0,
                        qdev_get_gpio_in(DEVICE(&s->gic), AW_R40_GIC_SPI_EMAC));
 
+    /* WDT */
+    sysbus_realize(SYS_BUS_DEVICE(&s->wdt), &error_fatal);
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->wdt), 0,
+                            allwinner_r40_memmap[AW_R40_DEV_WDT], 1);
+
     /* Unimplemented devices */
     for (unsigned i = 0; i < ARRAY_SIZE(r40_unimplemented); i++) {
         create_unimplemented_device(r40_unimplemented[i].device_name,
diff --git a/include/hw/arm/allwinner-r40.h b/include/hw/arm/allwinner-r40.h
index c589fcc1c1..66c38e7d90 100644
--- a/include/hw/arm/allwinner-r40.h
+++ b/include/hw/arm/allwinner-r40.h
@@ -33,6 +33,7 @@
 #include "hw/net/allwinner-sun8i-emac.h"
 #include "hw/usb/hcd-ohci.h"
 #include "hw/usb/hcd-ehci.h"
+#include "hw/watchdog/allwinner-wdt.h"
 #include "target/arm/cpu.h"
 #include "sysemu/block-backend.h"
 
@@ -54,6 +55,7 @@ enum {
     AW_R40_DEV_OHCI2,
     AW_R40_DEV_CCU,
     AW_R40_DEV_PIT,
+    AW_R40_DEV_WDT,
     AW_R40_DEV_UART0,
     AW_R40_DEV_UART1,
     AW_R40_DEV_UART2,
@@ -114,6 +116,7 @@ struct AwR40State {
     const hwaddr *memmap;
     AwSRAMCState sramc;
     AwA10PITState timer;
+    AwWdtState wdt;
     AllwinnerAHCIState sata;
     AwSdHostState mmc[AW_R40_NUM_MMCS];
     EHCISysBusState ehci[AW_R40_NUM_USB];
-- 
2.39.2


