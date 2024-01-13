Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D02D82CE44
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 20:18:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOjVM-0006CS-Ff; Sat, 13 Jan 2024 14:17:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rOjV8-000694-Jv; Sat, 13 Jan 2024 14:17:02 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rOjV6-00087F-Gt; Sat, 13 Jan 2024 14:17:01 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d427518d52so55185345ad.0; 
 Sat, 13 Jan 2024 11:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705173419; x=1705778219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4UCDHGFBDJB1Ot7Qx0E2+kK/f2W9pzsH3RVjHm4uLUw=;
 b=Pg8h/wqB61Eqv+q6X0x3s0OWweRtXj2eBNuSiS9/Gf3EwPVPAxeMLj6TNtCSLAFqxO
 o4k8Ix08WyL0zpq9cMT3wvIDyaHn+gtABv9Z5Au7IKtpPGrCeTWUCt02EvvoVhGyklV3
 fvm0/SRXJTmF9nCYcxtEoe5Rb5H6IM4JRcLPSFmaORlSC5w1k0ppP3ctg7+fbpp96EyH
 MY0LQYF/9BGDJWAV3vrAETO1juRO4YKdS0rTqOp9fYQejE+BWji83ay19B5Tk4W4adAz
 0LJ6oENrX+yTlbBx9MaQxYuM/4MDunT0EyNRWAAWWVxbgNeq4oL9r3o/qghpwtcYx/GE
 +yOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705173419; x=1705778219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4UCDHGFBDJB1Ot7Qx0E2+kK/f2W9pzsH3RVjHm4uLUw=;
 b=ONBD/ebJKpv9LTjeot9IOPHVAQTdkNoct8uI6bAeqF442ttqQNULPOBowuAYgc1Cdp
 DtuzyJsT3O36ldB1UxrSd/XoaowTm1VyXWZbLuhHLOAViWBzhz0gp8Jih/YM3idLMJeW
 odAWZFr7TFVfOsR5I/6onICxHAIpcSzli4+Psi4ZC26UFnI4gpHmfrqNavT5MFjKvNrR
 vii7oJXs0YVbnBXUvhuiOMrMwogrWEVfvTysWDOOseePAmMi/7wGvYQFW9VCtkXVxuQy
 v+ndZsG+efUunnvofoom76kwiUDDi6q6x+X+eUtKlA9Exu1bImUjx3FOXEHK5SIrTLSn
 X5bA==
X-Gm-Message-State: AOJu0YyvR3NwWLZWyQndPth8Y7167QoGTdLCGeg5zy35z/XdDPJCWKoC
 MM8rbGwP8G+eTMOKXot6Ey6EgDz64t8=
X-Google-Smtp-Source: AGHT+IEsseU786gJdZ57jhuZXWRQt1FoAsFC3HpJ73e/o3yE6K0ISDFQQD4WGDWbUBirj6cv9gW08Q==
X-Received: by 2002:a17:902:6b48:b0:1d5:8cbc:863c with SMTP id
 g8-20020a1709026b4800b001d58cbc863cmr3628676plt.27.1705173418874; 
 Sat, 13 Jan 2024 11:16:58 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 jg20-20020a17090326d400b001d060c61da5sm5097593plb.134.2024.01.13.11.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jan 2024 11:16:58 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3/3] hw/arm: Add watchdog timer to Allwinner H40 and Bananapi
 board
Date: Sat, 13 Jan 2024 11:16:51 -0800
Message-Id: <20240113191651.1313226-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240113191651.1313226-1-linux@roeck-us.net>
References: <20240113191651.1313226-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x630.google.com
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
index f90d59fb5e..334692ef97 100644
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
@@ -553,6 +556,11 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
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


