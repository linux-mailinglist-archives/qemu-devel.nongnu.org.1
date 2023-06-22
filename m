Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF537398A2
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:57:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFAn-0004FN-Jv; Thu, 22 Jun 2023 03:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAf-00040w-8m
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:01 -0400
Received: from mout.kundenserver.de ([212.227.126.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAY-0002sr-BX
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:00 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N17pC-1q4qIs137q-012aVA; Thu, 22
 Jun 2023 09:55:52 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/24] q800: move VIA1 device to Q800MachineState
Date: Thu, 22 Jun 2023 09:55:32 +0200
Message-Id: <20230622075544.210899-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622075544.210899-1-laurent@vivier.eu>
References: <20230622075544.210899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3LBjkbtbInuNCQeWr5jpD6/eqXfQM+BoaFGZwyTZ2mplDhcWcWu
 fsLZJ71fN6RWJxPMAN7XEkcCE0QO2GqAPIl5UV56nQLCxMxTYS95tQKFhKrdGX7JG0rAK0N
 hZMJy1N57ZOdoHs0Mi5rjpkYODtPFrWJVvlcheqm+bjXxElyabJW743bS/rWhXw5WkiXgeC
 J6EPR8LoerT5Aff2TCsfg==
UI-OutboundReport: notjunk:1;M01:P0:mafUbfmhNKE=;47sevGksBI+dGOTiJCKgk4jARtQ
 rC7kOLgU5n1hDdwYzdad3GgUFWOUEEelIKxSJBNiHmy0uIROxH4s+HPYKVagqsqdLy2F/hy7M
 6GwqkWtcTd+p+m/Z60Ut88sh39wBDoZORMiWd42ts0ZFKASUFx/fcYrr4V4nqJZy3/REAOAU6
 Pg6aEPS6EAYbbE/TqlMlx/UM3Yh5GyfT1yYImseJwc5OOBKgh/3xrRROOutPnHMcPafRB0PyY
 JnUdfjQNoCjq1LShdi1+VNAsaf/B7WaLyyL5DwbZnzwFAaoWXq9FH6+Z559GbJgUFvLtQBxOF
 lyw3W4Gyr9F57PDpplqT2yIBVgUN9ix0WXeaq5CpfcwEANjbocGbq7e4ZOMDZe+z6qPBB65QK
 pARjKYiPF39s1U//W4eU5ti4wuMS2Gfp0RCog8644RhjPYm9LPLvwkNGTeUZDlG9C391iamar
 o+GssGapduYjr6kjahs87hk3VKuyPN1qjs5S3T7KzBOiqWR/S9rHeLmV1PDc5DkU/LDzRBXfB
 pA45dAK7auYpiwhh9Y2S1REGG1n5XQrFENge7CizbdGNJ6muI2N8WKXjw4YoWRVx3IXIGvvkk
 wjf3RxeOgPg7BUUg+ZwFc2r4jkNVO3U6hrdFvJzY5HogZsjpGw99DsKp5GeCFoLnwT82cLTvM
 sBPltwt9e1iYxpcegqJ0RqmKql19pnXCscBeLkgzZQ==
Received-SPF: none client-ip=212.227.126.130; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Also change the instantiation of the VIA1 device to use object_initialize_child().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20230621085353.113233-13-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/m68k/q800.h |  2 ++
 hw/m68k/q800.c         | 16 +++++++++-------
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 1ed38bf0b180..5cf66d08a094 100644
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
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 51b8d8ec3c14..fccdad5f3c90 100644
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
-- 
2.40.1


