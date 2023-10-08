Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D38B47BCCAB
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 08:27:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpNCu-00086g-4y; Sun, 08 Oct 2023 02:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCr-00085L-QS
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:24:01 -0400
Received: from mout.kundenserver.de ([217.72.192.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qpNCp-0007lo-0m
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 02:24:01 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MPGiR-1rEtKi1he9-00Pb2j; Sun, 08
 Oct 2023 08:23:57 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 09/20] q800: add Apple Sound Chip (ASC) audio to machine
Date: Sun,  8 Oct 2023 08:23:38 +0200
Message-ID: <20231008062349.2733552-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231008062349.2733552-1-laurent@vivier.eu>
References: <20231008062349.2733552-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bYI5H8B71WSDbpoEsuAKT+QU7HuSVRpnQHWQSaHYKJWts+19K6J
 3XBheQ8wWmqlTvxWsjYB/bMyoNa4wxLQt2l+Zf3wDSekabnvG9koYHh2AV325m6sEfbbbt0
 V3F0yEOs4wfVv+6vf5EqZ8SK+pP5s7ZvQKR2dBlhzpMfDyYS4qu70m625hYAzSzeDxWpSLk
 z16Q1Jd3045STTOSP2pvA==
UI-OutboundReport: notjunk:1;M01:P0:+VbLwkkkRA8=;tb99CyreTsR1idfA92+MSnI/y7p
 O7CL6pX+gRpoM+PePsRR7+X5x2uh4flC/v/oi+XWeI+ka9EZ+XziicHhoA9IWDITWmsXANGjp
 +UDbpokatOEsqJ6kKTzNUwHc45wBaIGvh02quktNIA/dyp2SdvgZSovRyIej8o6XPzWanY7vR
 DVBWECv10hIE/TxqVebBarn6QqcFaDYoT0ZAqtkAoE63Yoq9Rey6rfGcgHXSPjkPzQ63CKn5H
 BqTA3DZIj5h09T6CaSscMasXneXDZ6OkvvRjI2kqjo9vlM4br6lT90rwnH4z6/JGZWpt7n6rL
 A/zvopmsTKUor0tnhDMQqjLH575gWRUI3Q6llnmTscNpXztdrMvLZgi+ANUecwYKx9xTmlaqq
 3yvT9m+yw45oDQxQMUCrBG1UE1ifgX1ANjDtgKbw5AW/DqtPv8hK30mQS+Pjvs8+YowObeqAW
 jqnQNkKlUuhEyAtXfsLpSCoqsFWH/597hUtSYzrY7Tqt06txghKwF52/ryMJ+6O8VaBQejN4F
 Lf+v2+XrxQ1QzmPUmWmRX3b6iSRAllyl7emOzVcOPpbaHJg/1iLAL/WbGC23Kepmeo0K36Mn8
 sEtg0N8Rgs/+yATwLh2fWnilPmH83IegvCgS2NDCd4O3VaeMPd5/H260DH2ImaH4zKQ+oLM/t
 Vrsqfjff0Ls19ECqw34si3gcvSNSz1oh0MVbXVTd+ydX5H7LpQ5DR3rxg331Pe1KxxpWln+y5
 CPIDzDLl0KAyW2TtK6KeANizmyjgqNLwk98qULMMR8Ot0mcETrgjazoueJvCdRJmpdLq/trcz
 r38V7S6i/pyDAJSewlYYF555q34Ap2MHREmid8AwygM2uMEZ/L/4sOGmeR85k+9a7FrgMxTYX
 PmALGIJk2VfYKkw==
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The Quadra 800 has the enhanced ASC (EASC) audio chip which supports both the
legacy IRQ routing through VIA2 and also "A/UX" mode routing direct to the
CPU.

Co-developed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20231004083806.757242-10-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/m68k/q800-glue.h |  4 +++-
 include/hw/m68k/q800.h      |  2 ++
 hw/m68k/q800-glue.c         | 11 ++++++++++-
 hw/m68k/q800.c              | 21 +++++++++++++++++++++
 4 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/include/hw/m68k/q800-glue.h b/include/hw/m68k/q800-glue.h
index a35efc1c534d..ceb916d16c14 100644
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
index 04e4e0bce35a..790cf433f38d 100644
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
diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index 710a5c331ec9..f413b1599a2c 100644
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
index 3209309173f3..249fedde7a92 100644
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
 
-- 
2.41.0


