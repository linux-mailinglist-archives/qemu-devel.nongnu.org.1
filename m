Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C6A7180B8
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 14:58:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LM2-0007gY-NH; Wed, 31 May 2023 08:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLz-0007cP-KG
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:55:03 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLy-0006qt-3q
 for qemu-devel@nongnu.org; Wed, 31 May 2023 08:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vhWDw+UQZ4AbrI8DVPAna5SWs4NpK9BCXoZpLqfchI4=; b=ndHJJxc8SfrNP+TmweJ5jrXVde
 PAqkii3CVGUn54A7I8NjtHaaN5ZU0h1ylnrUNMB/k6pKM9j+GkBZca+Qoxrp5UwPPiVbeXIPF2Y2W
 klqJhTz88B+Sj1wjSyZveiik7lED5vfheEhUYF6ZmMmLw6fm6c6KoXziSkMbaLy3/qrMe3rcihPoH
 AqqERElUDfGuF1ohMCGg1Jr38evNyprKbByr4HKATM6CPCRxxztHJXV4PJP3HFQ1OmK4eNwNbTazs
 Hd9DRfjl8GhjIOR7zkDh805OUaFRW9frci4WnBkJNCid4gupNQK75hQyIv8Uax0RdZaBCRWKifW/b
 Ai+6KVuS0Db4JOsMTx0IAkPLpFt48Z9SPjmjs+EUABYr/SUSNeQEj5DlG7MxY8A+rasP1Sg2KyqXu
 U3cNvUjUzS8BmJJyfCi+uV/Hk0rrwZayBbrJ9AsBpLmWxyQAvv2bIb7OyHAdY4DijhmQLL5SZjW/T
 GbgbKgz8upbEvDooHMnYZ+ynmVKu+q5CuBQwnNqZC1JQXJALrhUpnFu0egm84yumsmlSG0aYXQorX
 0og4qUWf25dLD3Mq5+geyy/gFgfo+siTFRAhidYGkjCTQSd/W5HkNpXONByzGyVq1gnzrKYZEJWpj
 Z88Hn/eVlO80VNMOVZyWVpjow/D2EoaSMzZU9IQN8=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q4LLm-0008vd-Vt; Wed, 31 May 2023 13:54:55 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 31 May 2023 13:53:48 +0100
Message-Id: <20230531125400.288917-12-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 11/23] q800: move VIA1 device to Q800MachineState
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
---
 hw/m68k/q800.c         | 16 +++++++++-------
 include/hw/m68k/q800.h |  2 ++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 785a67b0a9..65947ba580 100644
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
@@ -261,23 +261,25 @@ static void q800_machine_init(MachineState *machine)
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
index 81598af627..a7e03b3d28 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -24,6 +24,7 @@
 #define HW_Q800_H
 
 #include "hw/m68k/q800-glue.h"
+#include "hw/misc/mac_via.h"
 
 /*
  * The main Q800 machine
@@ -35,6 +36,7 @@ struct Q800MachineState {
     M68kCPU cpu;
     MemoryRegion rom;
     GLUEState glue;
+    MOS6522Q800VIA1State via1;
     MemoryRegion macio;
     MemoryRegion macio_alias;
 };
-- 
2.30.2


