Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32890718078
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 14:56:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LLu-0007Nk-Be; Wed, 31 May 2023 08:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLp-0007Fw-D8
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:54:53 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLn-0006oO-RO
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+EoYpk79DRnwCqz7NTD90XLsiCWepCWMd4Vqjezfi0U=; b=stlCki5i0KeU90EK/P6t/ihOzi
 WW6wZyxMCAvdTnPe7qSEy+mR1AVtXLwWXJzdwhsQB9Wkm5txZ5hSb3en7RxxX4CmZkiY2wzzp/5Nr
 EZ2uA5fdC0hyHqinJFtjMKuQx0fKomCsHcFR/+8t6lrKfr0kbgI4Ss73kHCByOx7kKcsVKUiRfPys
 Vlq0UKqnql/8q0dIMBQ2Z63PO/BkSJ0YCnEnRfZfgmTij0dvXZFqmLz6BoU8gK/Z4tFTzZBT+DxWP
 k69+2CSj7HL7S0c1sBYniYZcxuxhdxf8iT+/mOFDTmqKnhMitXxE3Ah033+tIHkej6JaBzBFmMRam
 6F1MmEKGoZ/Yzm7L2Hg7afSSMjDC6c1Sr4rf30Pv8mqLtVb41vV0YV0i7xQMAXaiPIHQcRdZeCJhO
 hM+RLpNKC/l/zj9Rcsijb4gu5hyZZ9rXBeuthU1FUpxR/NdOiup2zMk/Tq9P4k+Zepw9vRvwqB3np
 BlCsdZSyCAolpUL1p4fhYUSEKKvMUdJbMVEI3W6YgClXFji/y410zRWoBHJBw5YE0c3brpJsl06nF
 hzlMASDfPr0UPWI6yk6auk0804/ihDB5HFRtsMyRu77VhvnwRk1yxixh4dQyF1rxzS/qfuC2VUnGo
 XG+aQiPflVVJDp6w8WAeVWQlaANFCsHpwJMyKKwQQ=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLg-0008vd-FY; Wed, 31 May 2023 13:54:46 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 31 May 2023 13:53:45 +0100
Message-Id: <20230531125400.288917-9-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 08/23] q800: move GLUE device to Q800MachineState
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

Also change the instantiation of the GLUE device to use object_initialize_child().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800.c         | 24 ++++++++++++++----------
 include/hw/m68k/q800.h |  3 +++
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 1d9dad60b3..7bd8e795d2 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -158,7 +158,6 @@ static void q800_machine_init(MachineState *machine)
     SysBusDevice *sysbus;
     BusState *adb_bus;
     NubusBus *nubus;
-    DeviceState *glue;
     DriveInfo *dinfo;
     uint8_t rng_seed[32];
 
@@ -195,10 +194,10 @@ static void q800_machine_init(MachineState *machine)
     }
 
     /* IRQ Glue */
-    glue = qdev_new(TYPE_GLUE);
-    object_property_set_link(OBJECT(glue), "cpu", OBJECT(&m->cpu),
+    object_initialize_child(OBJECT(machine), "glue", &m->glue, TYPE_GLUE);
+    object_property_set_link(OBJECT(&m->glue), "cpu", OBJECT(&m->cpu),
                              &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(glue), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&m->glue), &error_fatal);
 
     /* VIA 1 */
     via1_dev = qdev_new(TYPE_MOS6522_Q800_VIA1);
@@ -209,10 +208,12 @@ static void q800_machine_init(MachineState *machine)
     sysbus = SYS_BUS_DEVICE(via1_dev);
     sysbus_realize_and_unref(sysbus, &error_fatal);
     sysbus_mmio_map(sysbus, 1, VIA_BASE);
-    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(glue, GLUE_IRQ_IN_VIA1));
+    sysbus_connect_irq(sysbus, 0,
+                       qdev_get_gpio_in(DEVICE(&m->glue), GLUE_IRQ_IN_VIA1));
     /* A/UX mode */
     qdev_connect_gpio_out(via1_dev, 0,
-                          qdev_get_gpio_in_named(glue, "auxmode", 0));
+                          qdev_get_gpio_in_named(DEVICE(&m->glue),
+                                                 "auxmode", 0));
 
     adb_bus = qdev_get_child_bus(via1_dev, "adb.0");
     dev = qdev_new(TYPE_ADB_KEYBOARD);
@@ -225,7 +226,8 @@ static void q800_machine_init(MachineState *machine)
     sysbus = SYS_BUS_DEVICE(via2_dev);
     sysbus_realize_and_unref(sysbus, &error_fatal);
     sysbus_mmio_map(sysbus, 1, VIA_BASE + VIA_SIZE);
-    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(glue, GLUE_IRQ_IN_VIA2));
+    sysbus_connect_irq(sysbus, 0,
+                       qdev_get_gpio_in(DEVICE(&m->glue), GLUE_IRQ_IN_VIA2));
 
     /* MACSONIC */
 
@@ -258,7 +260,8 @@ static void q800_machine_init(MachineState *machine)
     sysbus = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(sysbus, &error_fatal);
     sysbus_mmio_map(sysbus, 0, SONIC_BASE);
-    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(glue, GLUE_IRQ_IN_SONIC));
+    sysbus_connect_irq(sysbus, 0,
+                       qdev_get_gpio_in(DEVICE(&m->glue), GLUE_IRQ_IN_SONIC));
 
     memory_region_init_rom(dp8393x_prom, NULL, "dp8393x-q800.prom",
                            SONIC_PROM_SIZE, &error_fatal);
@@ -295,7 +298,8 @@ static void q800_machine_init(MachineState *machine)
     sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(escc_orgate, 0));
     sysbus_connect_irq(sysbus, 1, qdev_get_gpio_in(escc_orgate, 1));
     qdev_connect_gpio_out(DEVICE(escc_orgate), 0,
-                          qdev_get_gpio_in(glue, GLUE_IRQ_IN_ESCC));
+                          qdev_get_gpio_in(DEVICE(&m->glue),
+                                           GLUE_IRQ_IN_ESCC));
     sysbus_mmio_map(sysbus, 0, SCC_BASE);
 
     /* SCSI */
@@ -350,7 +354,7 @@ static void q800_machine_init(MachineState *machine)
      * Since the framebuffer in slot 0x9 uses a separate IRQ, wire the unused
      * IRQ via GLUE for use by SONIC Ethernet in classic mode
      */
-    qdev_connect_gpio_out(glue, GLUE_IRQ_NUBUS_9,
+    qdev_connect_gpio_out(DEVICE(&m->glue), GLUE_IRQ_NUBUS_9,
                           qdev_get_gpio_in_named(via2_dev, "nubus-irq",
                                                  VIA2_NUBUS_IRQ_9));
 
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 3e41f0e297..8e1bb0735d 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -23,6 +23,8 @@
 #ifndef HW_Q800_H
 #define HW_Q800_H
 
+#include "hw/m68k/q800-glue.h"
+
 /*
  * The main Q800 machine
  */
@@ -32,6 +34,7 @@ struct Q800MachineState {
 
     M68kCPU cpu;
     MemoryRegion rom;
+    GLUEState glue;
 };
 
 #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
-- 
2.30.2


