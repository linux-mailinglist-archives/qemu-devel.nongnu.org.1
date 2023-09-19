Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD887A6C0E
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 22:08:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qigxo-000621-RB; Tue, 19 Sep 2023 16:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3HuEJZQwKCjcgTUbaXlmXYTgZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--nabihestefan.bounces.google.com>)
 id 1qiezK-0005BJ-1W
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:58:18 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3HuEJZQwKCjcgTUbaXlmXYTgZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--nabihestefan.bounces.google.com>)
 id 1qieyx-000120-0C
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:58:17 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-59b5a586da6so1307497b3.1
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 10:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695146271; x=1695751071; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=YtHeJ8pwu3qZ1rqcoHAZtiyuJFrN7VdkWiPP8YRi7VE=;
 b=jTYWiZmaXm1FuvP8ueIoVnD4dRdteXxdAkJmvXgVDXzjus17Aqk8lGM7EII1BDf6BH
 6I3thYIkporQ3AkDMWn9DlLuU9gsH2pj2VmvuNJu9H+AcrG84oqrA9c2dyPwM/wO42xz
 77aUYHbTLjm/IvrML/n/CR7Pyna2a68mvd+DP1bDTyJ+AI0FGm7l8ihCNRn/dDX32uqP
 mCoU9EUaelSGa2+ks6K58lwlN0mXLDcEh0tJkujDCuETEgTAbrP6ETvzEV2GIIC6s8RX
 GpZJN3fWS8b3XmtACALwEanaUA0RUNMUT++wkBlVPjl18QdU3+YJAmf8XW7zssig/NVS
 1NYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146271; x=1695751071;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YtHeJ8pwu3qZ1rqcoHAZtiyuJFrN7VdkWiPP8YRi7VE=;
 b=JHmhLZwR3c42PdSFpJlzvyssK6rwBQkZL5E8PQNKdqDxmkx1fZsSlHqAIr4T1j2wdI
 oqSBcOx4n0aIS3O0E63dxobxNaQP9YzvHM7OyxRVrQ75/dP8//Zbn7sBYaneshdI9oyA
 3IVqYlM1WZJPteoW56Z+L2SlD1ofbFBWEA3Ayh74oFJaDIGAPpoi29Xi7MCN8W/zPoS8
 dicFOBWVJslerulVoPCXvogY3kuyv6SYa0orNi0PTmYKZuNubCwjxgTIc2NUyAMH/MKT
 7THKgbygVHhMuuJAL33DigmURfZsGaGtU7FHIG3v24EFeQXCV+7OIr89L1ClLvh4uCw+
 oSqQ==
X-Gm-Message-State: AOJu0Yw+7HGfr6i44TsXgICvltSRMc9IcAhUSkTXw9M+ud/KaxdEpGB+
 eocSxFdh0cAfYui4vlHND3luHEB4WzeEVjJ5yE8=
X-Google-Smtp-Source: AGHT+IGCxlvJi/TgAE8tYwFqfjfhzCKZDxB1pggLlk0uVKeqxP42e8qPYSIpbMROAgBWFJ+JT3LqwIexRe8Fr5kRk1k=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a81:8d06:0:b0:59b:e663:23b0 with SMTP
 id d6-20020a818d06000000b0059be66323b0mr10616ywg.4.1695146270897; Tue, 19 Sep
 2023 10:57:50 -0700 (PDT)
Date: Tue, 19 Sep 2023 17:57:17 +0000
In-Reply-To: <20230919175725.3413108-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20230919175725.3413108-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230919175725.3413108-7-nabihestefan@google.com>
Subject: [PATCH 06/14] hw/arm: Add GMAC devices to NPCM8XX SoC
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, Avi.Fishman@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3HuEJZQwKCjcgTUbaXlmXYTgZhhZeX.VhfjXfn-WXoXeghgZgn.hkZ@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 19 Sep 2023 16:04:51 -0400
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

From: Hao Wu <wuhaotsh@google.com>

Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 hw/arm/npcm8xx.c         |  12 ----
 include/hw/arm/npcm8xx.h | 118 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+), 12 deletions(-)
 create mode 100644 include/hw/arm/npcm8xx.h

diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
index a05dcfed5c..a9eb2b894c 100644
--- a/hw/arm/npcm8xx.c
+++ b/hw/arm/npcm8xx.c
@@ -440,9 +440,6 @@ static void npcm8xx_init(Object *obj)
         object_initialize_child(obj, "gpio[*]", &s->gpio[i], TYPE_NPCM7XX_GPIO);
     }
 
-    object_initialize_child(obj, "gpiotx", &s->gpiotx,
-                            TYPE_GOOGLE_GPIO_TRANSMITTER);
-
     for (i = 0; i < ARRAY_SIZE(s->smbus); i++) {
         object_initialize_child(obj, "smbus[*]", &s->smbus[i],
                                 TYPE_NPCM8XX_SMBUS);
@@ -633,12 +630,9 @@ static void npcm8xx_realize(DeviceState *dev, Error **errp)
 
     /* GPIO modules. Cannot fail. */
     QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm8xx_gpio) != ARRAY_SIZE(s->gpio));
-    sysbus_realize(SYS_BUS_DEVICE(&s->gpiotx), &error_abort);
     for (i = 0; i < ARRAY_SIZE(s->gpio); i++) {
         Object *obj = OBJECT(&s->gpio[i]);
 
-        object_property_set_link(obj, "gpio-tx", OBJECT(&s->gpiotx),
-                                 &error_abort);
         object_property_set_uint(obj, "reset-pullup",
                                  npcm8xx_gpio[i].reset_pu, &error_abort);
         object_property_set_uint(obj, "reset-pulldown",
@@ -725,12 +719,6 @@ static void npcm8xx_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < ARRAY_SIZE(s->gmac); i++) {
         SysBusDevice *sbd = SYS_BUS_DEVICE(&s->gmac[i]);
 
-        /* This is used to make sure that the NIC can create the device */
-        if (nd_table[i].used) {
-            qemu_check_nic_model(&nd_table[i], TYPE_NPCM_GMAC);
-            qdev_set_nic_properties(DEVICE(sbd), &nd_table[i]);
-        }
-
         /*
          * The device exists regardless of whether it's connected to a QEMU
          * netdev backend. So always instantiate it even if there is no
diff --git a/include/hw/arm/npcm8xx.h b/include/hw/arm/npcm8xx.h
new file mode 100644
index 0000000000..0c0488b641
--- /dev/null
+++ b/include/hw/arm/npcm8xx.h
@@ -0,0 +1,118 @@
+/*
+ * Nuvoton NPCM8xx SoC family.
+ *
+ * Copyright 2022 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+#ifndef NPCM8XX_H
+#define NPCM8XX_H
+
+#include "hw/boards.h"
+#include "hw/adc/npcm7xx_adc.h"
+#include "hw/core/split-irq.h"
+#include "hw/cpu/cluster.h"
+#include "hw/gpio/npcm7xx_gpio.h"
+#include "hw/i2c/npcm_smbus.h"
+#include "hw/ipmi/npcm7xx_kcs.h"
+#include "hw/intc/arm_gic_common.h"
+#include "hw/mem/npcm7xx_mc.h"
+#include "hw/misc/npcm_clk.h"
+#include "hw/misc/npcm_gcr.h"
+#include "hw/misc/npcm7xx_mft.h"
+#include "hw/misc/npcm7xx_pci_mbox.h"
+#include "hw/misc/npcm7xx_pwm.h"
+#include "hw/misc/npcm7xx_rng.h"
+#include "hw/net/npcm_gmac.h"
+#include "hw/net/npcm_pcs.h"
+#include "hw/nvram/npcm7xx_otp.h"
+#include "hw/peci/npcm7xx_peci.h"
+#include "hw/pci-host/npcm_pcierc.h"
+#include "hw/sd/npcm7xx_sdhci.h"
+#include "hw/timer/npcm7xx_timer.h"
+#include "hw/ssi/npcm7xx_fiu.h"
+#include "hw/usb/hcd-ehci.h"
+#include "hw/usb/hcd-ohci.h"
+#include "target/arm/cpu.h"
+
+#define NPCM8XX_MAX_NUM_CPUS    (4)
+
+/* The first half of the address space is reserved for DDR4 DRAM. */
+#define NPCM8XX_DRAM_BA         (0x00000000)
+#define NPCM8XX_DRAM_SZ         (2 * GiB)
+
+/* Magic addresses for setting up direct kernel booting and SMP boot stubs. */
+#define NPCM8XX_LOADER_START            (0x00000000)  /* Start of SDRAM */
+#define NPCM8XX_SMP_LOADER_START        (0xffff0000)  /* Boot ROM */
+#define NPCM8XX_SMP_BOOTREG_ADDR        (0xf080013c)  /* GCR.SCRPAD */
+#define NPCM8XX_BOARD_SETUP_ADDR        (0xffff1000)  /* Boot ROM */
+
+#define NPCM8XX_NR_PWM_MODULES 3
+
+typedef struct NPCM8xxState {
+    DeviceState         parent;
+
+    ARMCPU              cpu[NPCM8XX_MAX_NUM_CPUS];
+    CPUClusterState     cpu_cluster;
+    GICState            gic;
+
+    MemoryRegion        sram;
+    MemoryRegion        irom;
+    MemoryRegion        ram3;
+    MemoryRegion        *dram;
+
+    NPCMGCRState        gcr;
+    NPCMCLKState        clk;
+    NPCM7xxTimerCtrlState tim[3];
+    NPCM7xxADCState     adc;
+    NPCM7xxPWMState     pwm[NPCM8XX_NR_PWM_MODULES];
+    NPCM7xxMFTState     mft[8];
+    NPCM7xxOTPState     fuse_array;
+    NPCM7xxMCState      mc;
+    NPCM7xxRNGState     rng;
+    NPCM7xxGPIOState    gpio[8];
+    NPCMSMBusState      smbus[27];
+    NPCM7xxKCSState     kcs;
+    EHCISysBusState     ehci[2];
+    OHCISysBusState     ohci[2];
+    NPCM7xxFIUState     fiu[3];
+    NPCMGMACState       gmac[4];
+    NPCMPCSState        pcs;
+    NPCM7xxPCIMBoxState pci_mbox[2];
+    NPCM7xxSDHCIState   mmc;
+    NPCM7xxPECIState    peci;
+    NPCMPCIERCState     pcierc;
+} NPCM8xxState;
+
+typedef struct NPCM8xxClass {
+    DeviceClass         parent;
+
+    /* Bitmask of modules that are permanently disabled on this chip. */
+    uint32_t            disabled_modules;
+    /* Number of CPU cores enabled in this SoC class. */
+    uint32_t            num_cpus;
+} NPCM8xxClass;
+
+#define TYPE_NPCM8XX    "npcm8xx"
+OBJECT_DECLARE_TYPE(NPCM8xxState, NPCM8xxClass, NPCM8XX)
+
+/**
+ * npcm8xx_load_kernel - Loads memory with everything needed to boot
+ * @machine - The machine containing the SoC to be booted.
+ * @soc - The SoC containing the CPU to be booted.
+ *
+ * This will set up the ARM boot info structure for the specific NPCM8xx
+ * derivative and call arm_load_kernel() to set up loading of the kernel, etc.
+ * into memory, if requested by the user.
+ */
+void npcm8xx_load_kernel(MachineState *machine, NPCM8xxState *soc);
+
+#endif /* NPCM8XX_H */
-- 
2.42.0.459.ge4e396fd5e-goog


