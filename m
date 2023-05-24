Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6943870FFC5
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:13:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1vlr-0001MH-GR; Wed, 24 May 2023 17:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vlm-0001Jg-GO
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:11:46 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vlk-00020L-So
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KXym8r0zdjDqyJagv36tD73OWSTKwv/2Jq9YH/crFwk=; b=Mj8ufHCkixK4gFJPXACtRhDXpW
 MWNDaNyHcABaeGTiexPyKTr/2U4Fkze85GY2LDfqDJAvPmLvWv336ZlHoMBq7nG2XwNm2yRqbY+0C
 z75m7BdekvTskUseaaLuTMh9aUGzEgP6h2Xbn+N1CRQvHFcvZwNYbOcGbfM1cFqP3LCDR9u8eBkhy
 PKG8K5PK1t+rqYSOowe2JitaTW+EhU0awrnf48UC4uVNIY9vs6Gb59Mdr0KOxZZCsV9te7pNO5GZL
 LeFffvwnV9+A9IH0PnX3HYts+yWrJI3Xbrp9abAE4GRc/xQxM/HJdoCaWSuQk6EHpPeXI/ywE7o0b
 zxXAsJyityUOw2bla5deDhZJV7fn6OTx3o4KVZEl0Dp/X3fxT6C+xCXKbUZuwu98+66NShKxfoeok
 dXtr/Vu4KqFynGs9R6f0YgRp8PxuNjW8mBmdjjlPSthyGrS3sRdUFEkuzWRlbKTktsGTHH2lXY9RP
 vvBx6CSM39ywlOE0IjgX1ZIb/tIMFsGUjko0OKOgSBwMEepKVk7EjQZNJ68phcZmXILmo7er8XhzM
 jRopYJWP3dqTVHfLvKdIvISCbTh5NJWqEkqJVohs2giBki9pJWyjY8F6PaxBkVt0o/ENQewrt3hNh
 bEtQyf1TZkuvmRiEqQB4orpMvp7KlSvMC81+tuEso=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vlb-0005XR-Ln; Wed, 24 May 2023 22:11:35 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 24 May 2023 22:10:40 +0100
Message-Id: <20230524211104.686087-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 06/30] q800: move GLUE device to Q800MachineState
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

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800.c         | 20 ++++++++++----------
 include/hw/m68k/q800.h |  1 +
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 6a000ceb75..c22a98d616 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -392,7 +392,6 @@ static void q800_machine_init(MachineState *machine)
     SysBusDevice *sysbus;
     BusState *adb_bus;
     NubusBus *nubus;
-    DeviceState *glue;
     DriveInfo *dinfo;
     uint8_t rng_seed[32];
 
@@ -427,9 +426,10 @@ static void q800_machine_init(MachineState *machine)
     }
 
     /* IRQ Glue */
-    glue = qdev_new(TYPE_GLUE);
-    object_property_set_link(OBJECT(glue), "cpu", OBJECT(m->cpu), &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(glue), &error_fatal);
+    m->glue = qdev_new(TYPE_GLUE);
+    object_property_set_link(OBJECT(m->glue), "cpu", OBJECT(m->cpu),
+                             &error_abort);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(m->glue), &error_fatal);
 
     /* VIA 1 */
     via1_dev = qdev_new(TYPE_MOS6522_Q800_VIA1);
@@ -440,10 +440,10 @@ static void q800_machine_init(MachineState *machine)
     sysbus = SYS_BUS_DEVICE(via1_dev);
     sysbus_realize_and_unref(sysbus, &error_fatal);
     sysbus_mmio_map(sysbus, 1, VIA_BASE);
-    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(glue, GLUE_IRQ_IN_VIA1));
+    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(m->glue, GLUE_IRQ_IN_VIA1));
     /* A/UX mode */
     qdev_connect_gpio_out(via1_dev, 0,
-                          qdev_get_gpio_in_named(glue, "auxmode", 0));
+                          qdev_get_gpio_in_named(m->glue, "auxmode", 0));
 
     adb_bus = qdev_get_child_bus(via1_dev, "adb.0");
     dev = qdev_new(TYPE_ADB_KEYBOARD);
@@ -456,7 +456,7 @@ static void q800_machine_init(MachineState *machine)
     sysbus = SYS_BUS_DEVICE(via2_dev);
     sysbus_realize_and_unref(sysbus, &error_fatal);
     sysbus_mmio_map(sysbus, 1, VIA_BASE + VIA_SIZE);
-    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(glue, GLUE_IRQ_IN_VIA2));
+    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(m->glue, GLUE_IRQ_IN_VIA2));
 
     /* MACSONIC */
 
@@ -489,7 +489,7 @@ static void q800_machine_init(MachineState *machine)
     sysbus = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(sysbus, &error_fatal);
     sysbus_mmio_map(sysbus, 0, SONIC_BASE);
-    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(glue, GLUE_IRQ_IN_SONIC));
+    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(m->glue, GLUE_IRQ_IN_SONIC));
 
     memory_region_init_rom(dp8393x_prom, NULL, "dp8393x-q800.prom",
                            SONIC_PROM_SIZE, &error_fatal);
@@ -526,7 +526,7 @@ static void q800_machine_init(MachineState *machine)
     sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(escc_orgate, 0));
     sysbus_connect_irq(sysbus, 1, qdev_get_gpio_in(escc_orgate, 1));
     qdev_connect_gpio_out(DEVICE(escc_orgate), 0,
-                          qdev_get_gpio_in(glue, GLUE_IRQ_IN_ESCC));
+                          qdev_get_gpio_in(m->glue, GLUE_IRQ_IN_ESCC));
     sysbus_mmio_map(sysbus, 0, SCC_BASE);
 
     /* SCSI */
@@ -581,7 +581,7 @@ static void q800_machine_init(MachineState *machine)
      * Since the framebuffer in slot 0x9 uses a separate IRQ, wire the unused
      * IRQ via GLUE for use by SONIC Ethernet in classic mode
      */
-    qdev_connect_gpio_out(glue, GLUE_IRQ_NUBUS_9,
+    qdev_connect_gpio_out(m->glue, GLUE_IRQ_NUBUS_9,
                           qdev_get_gpio_in_named(via2_dev, "nubus-irq",
                                                  VIA2_NUBUS_IRQ_9));
 
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 2f3c720b8d..de02af53be 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -32,6 +32,7 @@ struct Q800MachineState {
 
     M68kCPU *cpu;
     MemoryRegion rom;
+    DeviceState *glue;
 };
 
 #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
-- 
2.30.2


