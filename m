Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8E0721760
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 15:20:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5nb1-0006D8-8p; Sun, 04 Jun 2023 09:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nam-0005dB-5m
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:16:25 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nak-0003RG-Gw
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4FTNGMNpfBmoYplOuv63uab/o22vwhYtwC3P/5ofNaQ=; b=ZHJqTxzbb2bnd5K9loFwxr2UBS
 A9CIHH85Bp/OekicjwZ5msSFMYxtgtl4+ZYNEVp57KLfs5nd+0H0df900fdcVzTwL2ynQ51ZDPcie
 Q8XdH1b0dbxSIdtgi86dJbqfF3XMMbRytHkxXIim2XiP0yDQf6+E/XGor5/Mi+5YI0i4VHffzA2df
 M4C+x9KQC4U34aNrV0ejs/iD9uZp9KixR43IWp20b9Ag/H+NMTgguqvNC76ts7jCNRQwzJx+DFRmj
 14kCzEkg0rRGkY6D7SlyJkkE+NWdf3uBcQ9R//ZwKk8FoiHtABEma3Wh7vzFft8FpxVMGIQF85PrC
 oH8fr28x7Bp8ZY4q/7m4RHW5vwBN8YfLo68RL5kouMBf9jRc/X3EuWqGed1otaXBv7yhHVxNvbUuD
 G0TLAqwB7jrC/9J1+t1TN5gxDPRbVYCKHcf/OFTCi2qFYnnStZT8Du6cgpoi5hbRtBMvYJkPZAOoJ
 eY/ZYuDb8difbtgMRSTSV3Aj1DiqBLGhdPPpkmNS4tHQ3+l/0DR1TaELexVNwLSN4tkIk7LGDq38E
 Lxd2vQ9e5Hrkfy4LPeD+OCuYmkAbiAr2AJqqEcCMGghFqA4ELuIN2JPU1NTBPDjwNgrZU3C48IcqX
 p3Nbgyd/y6ehwypTnoXzueg1Bsjo3swnHmQGDwX5c=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5naP-0005pb-Ar; Sun, 04 Jun 2023 14:16:01 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sun,  4 Jun 2023 14:14:46 +0100
Message-Id: <20230604131450.428797-20-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 19/23] q800: move mac-nubus-bridge device to
 Q800MachineState
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

Also change the instantiation of the mac-nubus-bridge device to use
object_initialize_child() and map the Nubus address space using
memory_region_add_subregion() instead of sysbus_mmio_map().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800.c         | 21 ++++++++++++++-------
 include/hw/m68k/q800.h |  2 ++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index d6e19ff18c..14879310ca 100644
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
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 06e095ae29..8f2c572a81 100644
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
-- 
2.30.2


