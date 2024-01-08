Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4144C82709F
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 15:04:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMqEG-0006RP-Vi; Mon, 08 Jan 2024 09:03:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1rMqEC-0006R8-9B; Mon, 08 Jan 2024 09:03:45 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1rMqE9-0008Pc-Rn; Mon, 08 Jan 2024 09:03:43 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2cd56dac1adso9654151fa.2; 
 Mon, 08 Jan 2024 06:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704722619; x=1705327419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tn9CedzcoYGfrgw8qUPmHYgPUJ1WmgHTMwvo6Lc8xOk=;
 b=JHxvvM3qmHgD2p2Or31nO8mfaL3wBXeWcV2NKecfxoNAT4/7M//yUUq/DRA0lyoc35
 Rqavr7kLnUELFLSgGNwportwrK5UgNaYhwVIMDTvLs8CKIsLoLOoCRhP/ZIytQMetbW/
 WPXDaUiACHXluO+IS1Gxkj/HIGJyHbgPuNGuT/Tk8hhIR2+ZUX79iUtgS6vESs1eh0I4
 uzNclS3oeL+zhtxys3XLZtvPaYp/T3MeL1AtV57jTMlt67xO1BV4M42Ej9DVpujhTmsw
 sznCKLHNFz1T/p3fJLw6HYrej+otSr9Ur4Mvd094HZTV42KS+a8isheTf50ONloWmIR8
 QSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704722619; x=1705327419;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tn9CedzcoYGfrgw8qUPmHYgPUJ1WmgHTMwvo6Lc8xOk=;
 b=DchbxUDqoWNBWemb5x2YJhagmSfjBVF5cVSLDsvPG4sUFprIO6ePlUEbKTEhWyR5rq
 d2e7J2GeW03SrY/9YGjTyn9uNRfmNI/F6iVZ7vwv83kYB07XxBzuIig4q+r9qatx75bp
 Uetz+AXYeOP5/9axZDz7/0o33ye25PlZixZACKZHMRqQOClqMl3QgGGFHi/aMl/hfoey
 s/3DJvzaIUpESQrF/nAVv588gK3HtEBHkYatH7pk3q6XcNrqm0goPjODhHtorVdzjmXI
 sNwxics9k946ZGTgKjzbLnCJZWQZbqy6iVoxF60g+nX9akTm3jA3La0CHM5vHf0ZK9db
 dMnw==
X-Gm-Message-State: AOJu0Yw4Ai0NbIG/LeD8r8PMNwfnTby20XS/MsUw3VT9hROi+OpB+tfK
 HTBRivb1P6KVKxFrwNB7P4yrm1Fp01iA9met
X-Google-Smtp-Source: AGHT+IEmtigbhQ8M+G6jJLdlck6UmouYEV9thor3EWO7h5Q+qLslA2ZQqaNUj2AfnkoqL9g2WudeQA==
X-Received: by 2002:a2e:b5c4:0:b0:2cc:7b19:1b05 with SMTP id
 g4-20020a2eb5c4000000b002cc7b191b05mr1410532ljn.48.1704722618977; 
 Mon, 08 Jan 2024 06:03:38 -0800 (PST)
Received: from localhost.localdomain ([176.120.189.69])
 by smtp.gmail.com with ESMTPSA id
 d19-20020a05651c089300b002cd4f3c1106sm762165ljq.114.2024.01.08.06.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 06:03:38 -0800 (PST)
From: Nikita Ostrenkov <n.ostrenkov@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>
Subject: [PATCH v2] hw/arm: add PCIe to Freescale i.MX6
Date: Mon,  8 Jan 2024 14:03:25 +0000
Message-Id: <20240108140325.1291-1-n.ostrenkov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=n.ostrenkov@gmail.com; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
---
 hw/arm/Kconfig            |  2 ++
 hw/arm/fsl-imx6.c         | 25 ++++++++++++++++++++++
 include/hw/arm/fsl-imx6.h | 44 ++++++++++++++++++++-------------------
 3 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 660f49db49..2559d1317b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -530,6 +530,7 @@ config FSL_IMX31
 
 config FSL_IMX6
     bool
+    imply PCIE_DEVICES
     imply I2C_DEVICES
     select A9MPCORE
     select IMX
@@ -537,6 +538,7 @@ config FSL_IMX6
     select IMX_I2C
     select IMX_USBPHY
     select WDT_IMX2
+    select PCI_EXPRESS_DESIGNWARE
     select SDHCI
 
 config ASPEED_SOC
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index b2153022c0..27702b6d6d 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6.h"
+#include "hw/misc/unimp.h"
 #include "hw/usb/imx-usb-phy.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
@@ -102,6 +103,8 @@ static void fsl_imx6_init(Object *obj)
 
 
     object_initialize_child(obj, "eth", &s->eth, TYPE_IMX_ENET);
+
+    object_initialize_child(obj, "pcie", &s->pcie, TYPE_DESIGNWARE_PCIE_HOST);
 }
 
 static void fsl_imx6_realize(DeviceState *dev, Error **errp)
@@ -109,6 +112,7 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     FslIMX6State *s = FSL_IMX6(dev);
     uint16_t i;
+    qemu_irq irq;
     unsigned int smp_cpus = ms->smp.cpus;
 
     if (smp_cpus > FSL_IMX6_NUM_CPUS) {
@@ -421,6 +425,27 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
                                             FSL_IMX6_WDOGn_IRQ[i]));
     }
 
+    /*
+     * PCIe
+     */
+    sysbus_realize(SYS_BUS_DEVICE(&s->pcie), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcie), 0, FSL_IMX6_PCIe_REG_ADDR);
+
+    irq = qdev_get_gpio_in(DEVICE(&s->a9mpcore), FSL_IMX6_PCIE1_IRQ);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 0, irq);
+    irq = qdev_get_gpio_in(DEVICE(&s->a9mpcore), FSL_IMX6_PCIE2_IRQ);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 1, irq);
+    irq = qdev_get_gpio_in(DEVICE(&s->a9mpcore), FSL_IMX6_PCIE3_IRQ);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 2, irq);
+    irq = qdev_get_gpio_in(DEVICE(&s->a9mpcore), FSL_IMX6_PCIE4_IRQ);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcie), 3, irq);
+
+    /*
+     * PCIe PHY
+     */
+    create_unimplemented_device("pcie-phy", FSL_IMX6_PCIe_ADDR,
+                                FSL_IMX6_PCIe_SIZE);
+
     /* ROM memory */
     if (!memory_region_init_rom(&s->rom, OBJECT(dev), "imx6.rom",
                                 FSL_IMX6_ROM_SIZE, errp)) {
diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 519b871014..61c593ffd2 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -32,6 +32,7 @@
 #include "hw/net/imx_fec.h"
 #include "hw/usb/chipidea.h"
 #include "hw/usb/imx-usb-phy.h"
+#include "hw/pci-host/designware.h"
 #include "exec/memory.h"
 #include "cpu.h"
 #include "qom/object.h"
@@ -55,27 +56,28 @@ struct FslIMX6State {
     DeviceState parent_obj;
 
     /*< public >*/
-    ARMCPU         cpu[FSL_IMX6_NUM_CPUS];
-    A9MPPrivState  a9mpcore;
-    IMX6CCMState   ccm;
-    IMX6SRCState   src;
-    IMX7SNVSState  snvs;
-    IMXSerialState uart[FSL_IMX6_NUM_UARTS];
-    IMXGPTState    gpt;
-    IMXEPITState   epit[FSL_IMX6_NUM_EPITS];
-    IMXI2CState    i2c[FSL_IMX6_NUM_I2CS];
-    IMXGPIOState   gpio[FSL_IMX6_NUM_GPIOS];
-    SDHCIState     esdhc[FSL_IMX6_NUM_ESDHCS];
-    IMXSPIState    spi[FSL_IMX6_NUM_ECSPIS];
-    IMX2WdtState   wdt[FSL_IMX6_NUM_WDTS];
-    IMXUSBPHYState usbphy[FSL_IMX6_NUM_USB_PHYS];
-    ChipideaState  usb[FSL_IMX6_NUM_USBS];
-    IMXFECState    eth;
-    MemoryRegion   rom;
-    MemoryRegion   caam;
-    MemoryRegion   ocram;
-    MemoryRegion   ocram_alias;
-    uint32_t       phy_num;
+    ARMCPU             cpu[FSL_IMX6_NUM_CPUS];
+    A9MPPrivState      a9mpcore;
+    IMX6CCMState       ccm;
+    IMX6SRCState       src;
+    IMX7SNVSState      snvs;
+    IMXSerialState     uart[FSL_IMX6_NUM_UARTS];
+    IMXGPTState        gpt;
+    IMXEPITState       epit[FSL_IMX6_NUM_EPITS];
+    IMXI2CState        i2c[FSL_IMX6_NUM_I2CS];
+    IMXGPIOState       gpio[FSL_IMX6_NUM_GPIOS];
+    SDHCIState         esdhc[FSL_IMX6_NUM_ESDHCS];
+    IMXSPIState        spi[FSL_IMX6_NUM_ECSPIS];
+    IMX2WdtState       wdt[FSL_IMX6_NUM_WDTS];
+    IMXUSBPHYState     usbphy[FSL_IMX6_NUM_USB_PHYS];
+    ChipideaState      usb[FSL_IMX6_NUM_USBS];
+    IMXFECState        eth;
+    DesignwarePCIEHost pcie;
+    MemoryRegion       rom;
+    MemoryRegion       caam;
+    MemoryRegion       ocram;
+    MemoryRegion       ocram_alias;
+    uint32_t           phy_num;
 };
 
 
-- 
2.34.1


