Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7479D737DE4
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:56:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBtc8-0002ih-39; Wed, 21 Jun 2023 04:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtc6-0002XB-2H
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:54:54 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtc4-0004zK-An
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=97WVBbwGfzQuIWAFxaogL9KiX4lqQnmxG3FLJB91MDw=; b=fsl3MxI0cc3POGOMIrFRmxgZwP
 Ayyh82uTF65jroo+6PQfRyrUepkBIDwxnKbVBYEHQq0l/6a9YzFj04r5b6b5y5dEROlZBhV5S2NCB
 asCLS2FsAwetOLaasPreQLCXgiKdOMxnyKH4ocbV08P1pXZv729UtZ8HL6OW9nvScZ5xfQqUHaNLv
 u6CMipy+Cf+MmATYEa8fYdvbGArbpX68sGiZfuR2sovVQzbe7pUbNyDdoMGl4/TsXNAazZ74xxdyB
 bL5TF7SbEPzC1EIxbmvSAxeM9PiROZm+e4hBc0qoav07IyouDY4mOdt7ebHVYDczxKCUpH3yRun7B
 UPxn72X+c/Z/qWIp3+sW8H+smu5DdFGgCwlOrRohCcXsCEXUZIYmpkl66tD/ol5/5TInPOWQwA45B
 D0JSSRxhHjG1uZGbDrFbTA5AOA3CydIo5PrbBfB9pmGUqHgABFP/hG3/VcLlDsbxATDU7yGrkIq9D
 6hiI5yQGLbQO0XSsLczpvTm+c9Ur5r7OhorgCmoDyb+NGC+Ubs3n6YIbtALxO712l3O7bwAduUjYE
 mycZxtBE+pWhhastSuzbc2c51nFzdZfAakkyYJ+ZgAD3W09XxYT3KfG4mwL9gDH5VPOVUX3bm/yaq
 MuGbSvVQb7CLt8DWSmPTNFGgMyO8LCK1aaRAf1bdY=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtbs-0001ZB-Qi; Wed, 21 Jun 2023 09:54:44 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 21 Jun 2023 09:53:42 +0100
Message-Id: <20230621085353.113233-14-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 13/24] q800: move VIA2 device to Q800MachineState
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800.c         | 27 ++++++++++++++++-----------
 include/hw/m68k/q800.h |  1 +
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index fccdad5f3c..988b4981b8 100644
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
@@ -285,9 +284,10 @@ static void q800_machine_init(MachineState *machine)
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
@@ -382,10 +382,14 @@ static void q800_machine_init(MachineState *machine)
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
@@ -411,11 +415,12 @@ static void q800_machine_init(MachineState *machine)
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
 
@@ -424,7 +429,7 @@ static void q800_machine_init(MachineState *machine)
      * IRQ via GLUE for use by SONIC Ethernet in classic mode
      */
     qdev_connect_gpio_out(DEVICE(&m->glue), GLUE_IRQ_NUBUS_9,
-                          qdev_get_gpio_in_named(via2_dev, "nubus-irq",
+                          qdev_get_gpio_in_named(DEVICE(&m->via2), "nubus-irq",
                                                  VIA2_NUBUS_IRQ_9));
 
     nubus = &NUBUS_BRIDGE(dev)->bus;
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 5cf66d08a0..06c771635b 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -41,6 +41,7 @@ struct Q800MachineState {
     MemoryRegion rom;
     GLUEState glue;
     MOS6522Q800VIA1State via1;
+    MOS6522Q800VIA2State via2;
     MemoryRegion macio;
     MemoryRegion macio_alias;
 };
-- 
2.30.2


