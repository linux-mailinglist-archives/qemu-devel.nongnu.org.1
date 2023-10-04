Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F737B7A5C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:42:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxPA-00041l-O1; Wed, 04 Oct 2023 04:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxP9-00041K-EA
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:38:51 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxP7-0007eX-Pl
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5eqP4+bjn5EBbpgBK2NdpBicOTGK9gRZVvWgDw65dOU=; b=jd0SMb09ZTLTAA3kEhNUZ0P4H4
 ZsnK27KKl8hne+o57cxyrLN2IyHj1u1vmNAVpOBr9JyvPbKEN2/G9QAFU6S+EVI6RpjXTpyCMyu30
 2CSlfSE9j0NlQPKTYgpd9YtsmVbxn3VFCRwS+unpbmO5A/0YiIAztotfKSQAMLooSAH71ZeO+gEBK
 sBfiWkjGTqZadOt50Qmiy0OT5UCOxgsoX52kNI3XcVLCD5nYViubLwFF8vT+2XvGQm51V9JDultZP
 78ZWiL5VH/Ib1Y9VVqcocfld0J+pDG4q6k+D5PMKB1or++FbC/PFSodTTjQkJv5VIA4HF0GlCANvZ
 i2aiK1rORqJyZ3k+rKNBp+RigHHIeq9k+U43ZK6tJcGGNoWqztS56SW9ZMsyo11hwnL6aXVc7q8Xg
 i69hEwF8Tm4bke6N99qClDjmMtyYooAb3252CSmFzjwQAVgMcyuW13mdjGdt/ewhAKdGPOTnA7rtW
 WGwpnPA7v3xMO1eV6MfQ5ZhrsF7HcevXwBMyGaJVJGbjUedFGL9aM6Ijp4l5ejIRAlBl+VxZcfHJH
 sRGI4uZu1l3JyM68HrSkJMV9daxh5ljAuufAikcknSgUNbts0E+g3ve2obghpuH28XzRVI/ppZgTJ
 MUItYZvJOeR0BF31lHUjbz8FCOyJ3lCgdlqfH2e3s=;
Received: from host86-159-123-68.range86-159.btcentralplus.com
 ([86.159.123.68] helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxOs-0006za-HR; Wed, 04 Oct 2023 09:38:38 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed,  4 Oct 2023 09:37:55 +0100
Message-Id: <20231004083806.757242-10-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004083806.757242-1-mark.cave-ayland@ilande.co.uk>
References: <20231004083806.757242-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.159.123.68
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 09/20] q800: add Apple Sound Chip (ASC) audio to machine
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The Quadra 800 has the enhanced ASC (EASC) audio chip which supports both the
legacy IRQ routing through VIA2 and also "A/UX" mode routing direct to the
CPU.

Co-developed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800-glue.c         | 11 ++++++++++-
 hw/m68k/q800.c              | 21 +++++++++++++++++++++
 include/hw/m68k/q800-glue.h |  4 +++-
 include/hw/m68k/q800.h      |  2 ++
 4 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index 710a5c331e..f413b1599a 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -97,6 +97,11 @@ static void GLUE_set_irq(void *opaque, int irq, int level)
             irq = 6;
             break;
 
+        case GLUE_IRQ_IN_ASC:
+            /* Route to VIA2 instead, negative edge-triggered */
+            qemu_set_irq(s->irqs[GLUE_IRQ_ASC], !level);
+            return;
+
         default:
             g_assert_not_reached();
         }
@@ -123,6 +128,10 @@ static void GLUE_set_irq(void *opaque, int irq, int level)
             irq = 6;
             break;
 
+        case GLUE_IRQ_IN_ASC:
+            irq = 4;
+            break;
+
         default:
             g_assert_not_reached();
         }
@@ -214,7 +223,7 @@ static void glue_init(Object *obj)
     qdev_init_gpio_in(dev, GLUE_set_irq, 8);
     qdev_init_gpio_in_named(dev, glue_auxmode_set_irq, "auxmode", 1);
 
-    qdev_init_gpio_out(dev, s->irqs, 1);
+    qdev_init_gpio_out(dev, s->irqs, 2);
 
     /* NMI release timer */
     s->nmi_release = timer_new_ms(QEMU_CLOCK_VIRTUAL, glue_nmi_release, s);
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 3209309173..249fedde7a 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -43,6 +43,7 @@
 #include "hw/misc/djmemc.h"
 #include "hw/misc/iosb.h"
 #include "hw/input/adb.h"
+#include "hw/audio/asc.h"
 #include "hw/nubus/mac-nubus-bridge.h"
 #include "hw/display/macfb.h"
 #include "hw/block/swim.h"
@@ -480,6 +481,25 @@ static void q800_machine_init(MachineState *machine)
 
     scsi_bus_legacy_handle_cmdline(&esp->bus);
 
+    /* Apple Sound Chip */
+
+    object_initialize_child(OBJECT(machine), "asc", &m->asc, TYPE_ASC);
+    qdev_prop_set_uint8(DEVICE(&m->asc), "asctype", ASC_TYPE_EASC);
+    if (machine->audiodev) {
+        qdev_prop_set_string(DEVICE(&m->asc), "audiodev", machine->audiodev);
+    }
+    sysbus = SYS_BUS_DEVICE(&m->asc);
+    sysbus_realize_and_unref(sysbus, &error_fatal);
+    memory_region_add_subregion(&m->macio, ASC_BASE - IO_BASE,
+                                sysbus_mmio_get_region(sysbus, 0));
+    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(DEVICE(&m->glue),
+                                                   GLUE_IRQ_IN_ASC));
+
+    /* Wire ASC IRQ via GLUE for use in classic mode */
+    qdev_connect_gpio_out(DEVICE(&m->glue), GLUE_IRQ_ASC,
+                          qdev_get_gpio_in(DEVICE(&m->via2),
+                                           VIA2_IRQ_ASC_BIT));
+
     /* SWIM floppy controller */
 
     object_initialize_child(OBJECT(machine), "swim", &m->swim,
@@ -688,6 +708,7 @@ static void q800_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 1;
     mc->block_default_type = IF_SCSI;
     mc->default_ram_id = "m68k_mac.ram";
+    machine_add_audiodev_property(mc);
     compat_props_add(mc->compat_props, hw_compat_q800, hw_compat_q800_len);
 }
 
diff --git a/include/hw/m68k/q800-glue.h b/include/hw/m68k/q800-glue.h
index a35efc1c53..ceb916d16c 100644
--- a/include/hw/m68k/q800-glue.h
+++ b/include/hw/m68k/q800-glue.h
@@ -35,7 +35,7 @@ struct GLUEState {
     M68kCPU *cpu;
     uint8_t ipr;
     uint8_t auxmode;
-    qemu_irq irqs[1];
+    qemu_irq irqs[2];
     QEMUTimer *nmi_release;
 };
 
@@ -44,7 +44,9 @@ struct GLUEState {
 #define GLUE_IRQ_IN_SONIC      2
 #define GLUE_IRQ_IN_ESCC       3
 #define GLUE_IRQ_IN_NMI        4
+#define GLUE_IRQ_IN_ASC        5
 
 #define GLUE_IRQ_NUBUS_9       0
+#define GLUE_IRQ_ASC           1
 
 #endif
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index 04e4e0bce3..790cf433f3 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -38,6 +38,7 @@
 #include "hw/display/macfb.h"
 #include "hw/misc/djmemc.h"
 #include "hw/misc/iosb.h"
+#include "hw/audio/asc.h"
 
 /*
  * The main Q800 machine
@@ -60,6 +61,7 @@ struct Q800MachineState {
     MacfbNubusState macfb;
     DJMEMCState djmemc;
     IOSBState iosb;
+    ASCState asc;
     MemoryRegion ramio;
     MemoryRegion macio;
     MemoryRegion macio_alias;
-- 
2.39.2


