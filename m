Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DCB7398C5
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:59:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFBN-00052A-2D; Thu, 22 Jun 2023 03:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAi-00047Y-Cd
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:04 -0400
Received: from mout.kundenserver.de ([212.227.17.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAe-0002uQ-Pi
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:04 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MTikV-1qfYIa1zhN-00TyNy; Thu, 22
 Jun 2023 09:55:57 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 20/24] q800: move mac-nubus-bridge device to Q800MachineState
Date: Thu, 22 Jun 2023 09:55:40 +0200
Message-Id: <20230622075544.210899-21-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622075544.210899-1-laurent@vivier.eu>
References: <20230622075544.210899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tXjPYoArKM+0+KB9Q8Zhxdi3ZDAgM+WcQQfaUJolsy9J/a0LkZO
 cEEJ0RQwpQrMwSX/4UVJaJZtpNcebns6TCcvcAq+073jKxWRWZsNK7/Tj7SNRWPd4aY78RM
 LOGN8YkvpchLTaIlSTkyZimjBxUs/EJONp3Rl77XoktZCETH673+4AO+Vp8dr5KOu8f+35l
 vx/Dghiv2j51t0mdOM7TQ==
UI-OutboundReport: notjunk:1;M01:P0:pD8n9qSiDPE=;vryF3taETt5G/q2gQJp2FalCnvT
 Oc7rlqjeDfWWW2PXjfh7aCXlgz1H5WQQ2OzxWYGi5/M2r8Jwxnxwn3QUw2SYDeluNb/AB/nzE
 F4yfhHJIe0IhOGeWEt6NEmZtMTlN+1yOGCCLXwp7lOM/eqDoKmpk/96+5+/N8+ZOVk61ZNr6X
 UqMltzjZdQShQMs3bkmiHx8QLt3LdT/fgRMHkjtv3pa4j+a7lFDxm+3PlJjE23lcLvbCEVxSy
 rRD6e8iKpiI38PkCTXu1DXbK/LYxTteeSduKJVlTnwhMyP2IDhVH0MiBtu3NnTUfCgeNNY+cP
 Pkrfg3kOwW75lK7fXdzTJ0r+BIwVCPw/M7EDD8M1GVlRqdJwqTpziJzKKB1LsU18efaXWXOZr
 lMS+AkK2OuP9C5mMccu9vRNSOIiMbd7vBy6lbNs/fXue6J4Mg+BCBt45vHCVU1yFnBxgr/oJr
 ehdn1I+yeac0EZF4L2ga+piIm8+XtBE1RXhQkmPmTLLHthwXOsmkbsZuKmy+b18PGDNn738rs
 1tOXtEHR30/Ufqh87jVEwcHFess5hxhnN6YtgR1y7xNMl5Ie+B40MoOZEzM7puiOdkYaQuJ3O
 MUmFfszfUNmYZHfCm16z25Pcff1hbvQyqC94psX32YvND+hPSUazv8/I1Bx7WhoGMEUY4MLbC
 Hli+IuwXirgLA+pYZ5Uhb1W+QJnrvSaOl9Uu8OAdMw==
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Also change the instantiation of the mac-nubus-bridge device to use
object_initialize_child() and map the Nubus address space using
memory_region_add_subregion() instead of sysbus_mmio_map().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230621085353.113233-21-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/m68k/q800.h |  2 ++
 hw/m68k/q800.c         | 21 ++++++++++++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 06e095ae293f..8f2c572a81e0 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -34,6 +34,7 @@
 #include "hw/or-irq.h"
 #include "hw/scsi/esp.h"
 #include "hw/block/swim.h"
+#include "hw/nubus/mac-nubus-bridge.h"
 
 /*
  * The main Q800 machine
@@ -52,6 +53,7 @@ struct Q800MachineState {
     OrIRQState escc_orgate;
     SysBusESPState esp;
     Swim swim;
+    MacNubusBridge mac_nubus_bridge;
     MemoryRegion macio;
     MemoryRegion macio_alias;
 };
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 50fc7de9a20b..b22651931a22 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -415,14 +415,21 @@ static void q800_machine_init(MachineState *machine)
 
     /* NuBus */
 
-    dev = qdev_new(TYPE_MAC_NUBUS_BRIDGE);
-    qdev_prop_set_uint32(dev, "slot-available-mask",
+    object_initialize_child(OBJECT(machine), "mac-nubus-bridge",
+                            &m->mac_nubus_bridge,
+                            TYPE_MAC_NUBUS_BRIDGE);
+    sysbus = SYS_BUS_DEVICE(&m->mac_nubus_bridge);
+    dev = DEVICE(&m->mac_nubus_bridge);
+    qdev_prop_set_uint32(DEVICE(&m->mac_nubus_bridge), "slot-available-mask",
                          Q800_NUBUS_SLOTS_AVAILABLE);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0,
-                    MAC_NUBUS_FIRST_SLOT * NUBUS_SUPER_SLOT_SIZE);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, NUBUS_SLOT_BASE +
-                    MAC_NUBUS_FIRST_SLOT * NUBUS_SLOT_SIZE);
+    sysbus_realize(sysbus, &error_fatal);
+    memory_region_add_subregion(get_system_memory(),
+                                MAC_NUBUS_FIRST_SLOT * NUBUS_SUPER_SLOT_SIZE,
+                                sysbus_mmio_get_region(sysbus, 0));
+    memory_region_add_subregion(get_system_memory(),
+                                NUBUS_SLOT_BASE +
+                                MAC_NUBUS_FIRST_SLOT * NUBUS_SLOT_SIZE,
+                                sysbus_mmio_get_region(sysbus, 1));
     qdev_connect_gpio_out(dev, 9,
                           qdev_get_gpio_in_named(DEVICE(&m->via2), "nubus-irq",
                           VIA2_NUBUS_IRQ_INTVIDEO));
-- 
2.40.1


