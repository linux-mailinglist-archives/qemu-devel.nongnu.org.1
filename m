Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 514D9718074
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 14:55:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LM3-0007ik-Je; Wed, 31 May 2023 08:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LM1-0007cm-3V
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:55:05 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLy-0006qx-Ed
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hl3oRz4jOGxqtDBJuOZ6blAeMIxuYIp5Cmgn3DOuE8M=; b=zv7YoKVXu2rFqQJBXfHSyn+xDH
 Xp/FhO6NVmdyB0Wep+aiX5UyT9a1vo/VEthtoWeql6wSSQRQkPilwEnXaWJVSvkxmlt83p4Mmh6xA
 QRI/Qo098/l6zk7QCudA7GR98PYPvrUMbkfcUj9gP3KOKbxzTXH4DAQTmkSnr1nEnTghFmZchihkL
 gBUGbsaV7AZqUgPHmR2LsM7sfAhWw31YXhbE2Q50R/vB7kCQSKlyMnlKR7TXopPAtcmsvlG+Fctqm
 bWHe0VCcR6djuh3z+E1Nw7d06RlrpKiq5CykQPFy1GHzNJcO5WUmQzcNyVWHBiDSFawySToT4SUDc
 NhQk6WXSxIxDj3y5KLaLt4A4he+w4vbbIzhhgLMZrA72Sns8MhsYebNFskKari5Z+BKsFRHZLbfFl
 h2BheL+WkgfUP7IRT0wGt/h2/Htm5iWKkyHDFRSxnUR4e1nrmzgdJNxYaeew1z8H7sisRNi/GswLZ
 XOnp7nNFRk30AkD8YDeLSBAorW9UYGiz2RUX7xxUL2Jpd8qQRrh/JHUgyiHT1qQHPSD8xJc9MeDwn
 CepbkAue8pVzKoPjoF2yS+4BzU0fW45+HKm+bqN9VmhQAYallwyMOb91SJ7Re5tDTnXCLuf4qFrsU
 xNQMpcN89U2sbwwiM3rRYspxO02IHCeyxGuU110JY=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLr-0008vd-Ef; Wed, 31 May 2023 13:54:55 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 31 May 2023 13:53:49 +0100
Message-Id: <20230531125400.288917-13-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 12/23] q800: move VIA2 device to Q800MachineState
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Also change the instantiation of the VIA2 device to use object_initialize_child().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800.c         | 27 ++++++++++++++++-----------
 include/hw/m68k/q800.h |  1 +
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 65947ba580..53d6308a7a 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -212,7 +212,6 @@ static void q800_machine_init(MachineState *machine)
     hwaddr parameters_base;
     CPUState *cs;
     DeviceState *dev;
-    DeviceState *via2_dev;
     DeviceState *escc_orgate;
     SysBusESPState *sysbus_esp;
     ESPState *esp;
@@ -286,9 +285,10 @@ static void q800_machine_init(MachineState *machine)
     qdev_realize_and_unref(dev, adb_bus, &error_fatal);
 
     /* VIA 2 */
-    via2_dev = qdev_new(TYPE_MOS6522_Q800_VIA2);
-    sysbus = SYS_BUS_DEVICE(via2_dev);
-    sysbus_realize_and_unref(sysbus, &error_fatal);
+    object_initialize_child(OBJECT(machine), "via2", &m->via2,
+                            TYPE_MOS6522_Q800_VIA2);
+    sysbus = SYS_BUS_DEVICE(&m->via2);
+    sysbus_realize(sysbus, &error_fatal);
     memory_region_add_subregion(&m->macio, VIA_BASE - IO_BASE + VIA_SIZE,
                                 sysbus_mmio_get_region(sysbus, 1));
     sysbus_connect_irq(sysbus, 0,
@@ -383,10 +383,14 @@ static void q800_machine_init(MachineState *machine)
     sysbus = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(sysbus, &error_fatal);
     /* SCSI and SCSI data IRQs are negative edge triggered */
-    sysbus_connect_irq(sysbus, 0, qemu_irq_invert(qdev_get_gpio_in(via2_dev,
-                                                  VIA2_IRQ_SCSI_BIT)));
-    sysbus_connect_irq(sysbus, 1, qemu_irq_invert(qdev_get_gpio_in(via2_dev,
-                                                  VIA2_IRQ_SCSI_DATA_BIT)));
+    sysbus_connect_irq(sysbus, 0,
+                       qemu_irq_invert(
+                           qdev_get_gpio_in(DEVICE(&m->via2),
+                                                   VIA2_IRQ_SCSI_BIT)));
+    sysbus_connect_irq(sysbus, 1,
+                       qemu_irq_invert(
+                           qdev_get_gpio_in(DEVICE(&m->via2),
+                                                   VIA2_IRQ_SCSI_DATA_BIT)));
     memory_region_add_subregion(&m->macio, ESP_BASE - IO_BASE,
                                 sysbus_mmio_get_region(sysbus, 0));
     memory_region_add_subregion(&m->macio, ESP_PDMA - IO_BASE,
@@ -412,11 +416,12 @@ static void q800_machine_init(MachineState *machine)
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, NUBUS_SLOT_BASE +
                     MAC_NUBUS_FIRST_SLOT * NUBUS_SLOT_SIZE);
     qdev_connect_gpio_out(dev, 9,
-                          qdev_get_gpio_in_named(via2_dev, "nubus-irq",
+                          qdev_get_gpio_in_named(DEVICE(&m->via2), "nubus-irq",
                           VIA2_NUBUS_IRQ_INTVIDEO));
     for (i = 1; i < VIA2_NUBUS_IRQ_NB; i++) {
         qdev_connect_gpio_out(dev, 9 + i,
-                              qdev_get_gpio_in_named(via2_dev, "nubus-irq",
+                              qdev_get_gpio_in_named(DEVICE(&m->via2),
+                                                     "nubus-irq",
                                                      VIA2_NUBUS_IRQ_9 + i));
     }
 
@@ -425,7 +430,7 @@ static void q800_machine_init(MachineState *machine)
      * IRQ via GLUE for use by SONIC Ethernet in classic mode
      */
     qdev_connect_gpio_out(DEVICE(&m->glue), GLUE_IRQ_NUBUS_9,
-                          qdev_get_gpio_in_named(via2_dev, "nubus-irq",
+                          qdev_get_gpio_in_named(DEVICE(&m->via2), "nubus-irq",
                                                  VIA2_NUBUS_IRQ_9));
 
     nubus = &NUBUS_BRIDGE(dev)->bus;
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index a7e03b3d28..ba3aa45513 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -37,6 +37,7 @@ struct Q800MachineState {
     MemoryRegion rom;
     GLUEState glue;
     MOS6522Q800VIA1State via1;
+    MOS6522Q800VIA2State via2;
     MemoryRegion macio;
     MemoryRegion macio_alias;
 };
-- 
2.30.2


