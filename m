Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14050721752
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 15:18:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5nar-0005Fa-5W; Sun, 04 Jun 2023 09:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5na7-00051M-6y
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:15:39 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5na4-0003Fk-Bq
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GoSrfdMa7FtxTsiUvQLcTnsKtHWPh+7AwYagX7qlsbA=; b=OI9xezd1+SF2dWNJsP3jARQ9sX
 OfwpVo0w75/KMBeo+tEAEPUBVeh/o5sytrL96f9G/AUMEmYbC2kjBTk42Qu/a9X10GVPeigjjcKNW
 hMPCBJqay4f2dhhY8ufxyAI/msLajFUhxcWxxJgx7DGvcnspPbJSM8Q/FnmfAHALBhkhbW4zXdeHY
 652KDF1J41jjbhJ9y7QH+Dl6nxO6fY//61l543DAsmpRIB290l0Xa0/MqcblOU/bISAw2glY+cK96
 md7+UbkcX6A2MrcK16ViiRZqHvSI1YeKIUu6GNrC60oZI1HO/sUSl46/J/j3JjczSGb4MmiO+2top
 dgezZSoleRJLhgVxk7hXvsCU7IX9tFI3u9RTzYBOmgRiyuLKNcuycZOqb+c6E0Rxjw1BafVpHHIN6
 Pri0vJlTcWIO9ZgDQ7X74uCoARXutVygEWYwp4r/Mg7GUdGabGHkBJY0SY6G/q1/1pXSRpvejaoiY
 7iQ63ltABMwCoI825Py1u+yazdCJudoop6GA+BXTXTlN78xFEPKbc2Y9IdVytnoY9GUkiPvNLFJ55
 DFj0cm1FgZ444wFcmK42rCgs3Q5/opxc7jpyYY0Bl8nuXFO84gN4SYvHBkPwuQ+7pk5HQhxaxvA0z
 4s3aKkvGsLER/FUFkujPhHgXr0u8LIh5Hi87VZ27s=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nZt-0005pb-Cn; Sun, 04 Jun 2023 14:15:28 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sun,  4 Jun 2023 14:14:38 +0100
Message-Id: <20230604131450.428797-12-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 11/23] q800: move VIA1 device to Q800MachineState
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

Also change the instantiation of the VIA1 device to use object_initialize_child().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800.c         | 16 +++++++++-------
 include/hw/m68k/q800.h |  2 ++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index cb4fcdcfb8..a0bc8bec9c 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -212,7 +212,7 @@ static void q800_machine_init(MachineState *machine)
     hwaddr parameters_base;
     CPUState *cs;
     DeviceState *dev;
-    DeviceState *via1_dev, *via2_dev;
+    DeviceState *via2_dev;
     DeviceState *escc_orgate;
     SysBusESPState *sysbus_esp;
     ESPState *esp;
@@ -260,23 +260,25 @@ static void q800_machine_init(MachineState *machine)
     sysbus_realize(SYS_BUS_DEVICE(&m->glue), &error_fatal);
 
     /* VIA 1 */
-    via1_dev = qdev_new(TYPE_MOS6522_Q800_VIA1);
+    object_initialize_child(OBJECT(machine), "via1", &m->via1,
+                            TYPE_MOS6522_Q800_VIA1);
     dinfo = drive_get(IF_MTD, 0, 0);
     if (dinfo) {
-        qdev_prop_set_drive(via1_dev, "drive", blk_by_legacy_dinfo(dinfo));
+        qdev_prop_set_drive(DEVICE(&m->via1), "drive",
+                            blk_by_legacy_dinfo(dinfo));
     }
-    sysbus = SYS_BUS_DEVICE(via1_dev);
-    sysbus_realize_and_unref(sysbus, &error_fatal);
+    sysbus = SYS_BUS_DEVICE(&m->via1);
+    sysbus_realize(sysbus, &error_fatal);
     memory_region_add_subregion(&m->macio, VIA_BASE - IO_BASE,
                                 sysbus_mmio_get_region(sysbus, 1));
     sysbus_connect_irq(sysbus, 0,
                        qdev_get_gpio_in(DEVICE(&m->glue), GLUE_IRQ_IN_VIA1));
     /* A/UX mode */
-    qdev_connect_gpio_out(via1_dev, 0,
+    qdev_connect_gpio_out(DEVICE(&m->via1), 0,
                           qdev_get_gpio_in_named(DEVICE(&m->glue),
                                                  "auxmode", 0));
 
-    adb_bus = qdev_get_child_bus(via1_dev, "adb.0");
+    adb_bus = qdev_get_child_bus(DEVICE(&m->via1), "adb.0");
     dev = qdev_new(TYPE_ADB_KEYBOARD);
     qdev_realize_and_unref(dev, adb_bus, &error_fatal);
     dev = qdev_new(TYPE_ADB_MOUSE);
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 1ed38bf0b1..5cf66d08a0 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -28,6 +28,7 @@
 #include "target/m68k/cpu-qom.h"
 #include "exec/memory.h"
 #include "hw/m68k/q800-glue.h"
+#include "hw/misc/mac_via.h"
 
 /*
  * The main Q800 machine
@@ -39,6 +40,7 @@ struct Q800MachineState {
     M68kCPU cpu;
     MemoryRegion rom;
     GLUEState glue;
+    MOS6522Q800VIA1State via1;
     MemoryRegion macio;
     MemoryRegion macio_alias;
 };
-- 
2.30.2


