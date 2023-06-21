Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCCD737DEC
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:57:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBtcz-00049v-NP; Wed, 21 Jun 2023 04:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtcf-00046U-WC
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:55:30 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtcd-0005FY-74
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NkGsfKnqZKVHgn7j3dDfmqDAr6NLQVzR90yX1G8XW3U=; b=kPaqnmVqSVzfOvT2rNCty/PhZU
 tvuNibay/ZUtE+yYMVq/Z9cmnYhj2dya/ToFn+WBIWylIHjg7qCM9N02qXiQUxy70whteSUKeHFG7
 AqW8dIz2LD+eluwlrzIYAcmUvNBw4fOW4HG6aTVN0v+oDqvyF+ZS2uCo/rRszxbZWnmjWq+rmhtmp
 oXOjLeCchHaGHTllAau2A1GzGmy0Qk2lh82rPj8+CsXz3IDwim77RdQ6+NGGP1lfkin+Cxlp9TST1
 TyiiiAYUuLsW0xeTgqzlAcvd2z/lLMeEkzqjOcqOsUzECKYV8g9tYwtxgmB06W660FupBbEaM+3yo
 svEXnatgDQvzDI87Dcky4bT1aID1i/csK1zvouiKnQyBYQv0O8PMdlRpiMSJa3J5qDIL3+UHJY8+r
 o3MCWXMV99rplRMmw9Kcr+qG06ND+BuGKFD/goYbN0wQz1yQ+TnZ1l5AX4NyFADKNhji8SXe5AIF8
 VZybEsAZ1pr1e0BgOB3x2Va5AEM55cUpXJU2KE675+tRIYZzWjDXWhKT3ZREwkOEY9Q+H+EMoVdXe
 vNSGH5tovWUE8IKxYHSipYKtRDsUinbMBTkJK7g7p6HCt8OGwcukbDFpENnd2EhgfWEGL2DZfV50z
 dIQYgZQL6qCNvxNMrn5V+vROhfyUMULcqb/jUz2LA=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtcH-0001ZB-NE; Wed, 21 Jun 2023 09:55:09 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 21 Jun 2023 09:53:49 +0100
Message-Id: <20230621085353.113233-21-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 20/24] q800: move mac-nubus-bridge device to
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/m68k/q800.c         | 21 ++++++++++++++-------
 include/hw/m68k/q800.h |  2 ++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 50fc7de9a2..b22651931a 100644
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


