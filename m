Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE4270FFD4
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:14:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1vn4-0004rT-7G; Wed, 24 May 2023 17:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vma-0002xu-NL
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:12:43 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmZ-00029c-5g
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yvZ1GAxwjmjw2T6FTdcBJ1u00zsXrh8YestBqWC4eNg=; b=HYRV9yv8ZZtLbDJt91uHx4aUZK
 KArVo0RzrR/y/FhLvGCe9VaZGuuib0fYwAlFGKeNpeJMtBA0Fecu37nVxakdDyeXo2fIEZiHM7VcY
 BqCkpGlUKMeqeEBQxfvTeK8d0AmwjOuXNwHwWFf9GHxeGaaAE/LdBoBNoFL/1XNasXQGk60HCpouk
 P3oqXPw0LzO6tJg0lXqrvjnwUoEi3Am/V1HT+Qrl74fEQ4JbQWDhNYNyiBei0XwNV/LUqle/v8Mne
 rOsuIyRjzHvSmHIcyOrJq1SszxiojWDWWrYdojdnIoTlo/MTGX8wlOAXMczJpRb3dTdDi4aUFfbK/
 h/ucT+VDCJnLLzY9NRe+GrMhFt+cf5zkjBSc1qWOCYtUa98QVCf3V4z4A34CPWvBqrhtFrn4/Mag+
 ca8Ja6JV05EVdGrPqAcojxbxSxMVt5DMLehRGIch/BW36nLPkj2ErFfQ+F7u2OezL9m4xclkffDSU
 +lspbkrsi2msq9Y83MgvSowB/pRBYH/Lf9Tg5JQac5+L1e+99EqmSHxMRl3GTPF3oSscL595HboTu
 Fk8zHytCZZ2yslKoAhWdVhTJdip2MnVJsnaietHdNbh+PQB9OpjZX1nCthE73rzA+Yj1rEWfMqMvg
 JRXGlUgO1X3BNXiVi9VZXIkMdodPD5HG3ZVTcHJII=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmH-0005XR-3C; Wed, 24 May 2023 22:12:16 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 24 May 2023 22:10:50 +0100
Message-Id: <20230524211104.686087-17-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 16/30] q800: add Apple Sound Chip (ASC) audio to machine
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

The Quadra 800 has the enhanced ASC (EASC) audio chip which supports both the
legacy IRQ routing through VIA2 and also "A/UX" mode routing direct to the
CPU.

Co-developed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index d12aeaa20e..ed862f9e9d 100644
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
@@ -115,7 +116,7 @@ struct GLUEState {
     M68kCPU *cpu;
     uint8_t ipr;
     uint8_t auxmode;
-    qemu_irq irqs[1];
+    qemu_irq irqs[2];
     QEMUTimer *nmi_release;
 };
 
@@ -124,8 +125,10 @@ struct GLUEState {
 #define GLUE_IRQ_IN_SONIC      2
 #define GLUE_IRQ_IN_ESCC       3
 #define GLUE_IRQ_IN_NMI        4
+#define GLUE_IRQ_IN_ASC        5
 
 #define GLUE_IRQ_NUBUS_9       0
+#define GLUE_IRQ_ASC           1
 
 /*
  * The GLUE logic on the Quadra 800 supports 2 different IRQ routing modes
@@ -187,6 +190,11 @@ static void GLUE_set_irq(void *opaque, int irq, int level)
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
@@ -213,6 +221,10 @@ static void GLUE_set_irq(void *opaque, int irq, int level)
             irq = 6;
             break;
 
+        case GLUE_IRQ_IN_ASC:
+            irq = 4;
+            break;
+
         default:
             g_assert_not_reached();
         }
@@ -304,7 +316,7 @@ static void glue_init(Object *obj)
     qdev_init_gpio_in(dev, GLUE_set_irq, 8);
     qdev_init_gpio_in_named(dev, glue_auxmode_set_irq, "auxmode", 1);
 
-    qdev_init_gpio_out(dev, s->irqs, 1);
+    qdev_init_gpio_out(dev, s->irqs, 2);
 
     /* NMI release timer */
     s->nmi_release = timer_new_ms(QEMU_CLOCK_VIRTUAL, glue_nmi_release, s);
@@ -695,6 +707,20 @@ static void q800_machine_init(MachineState *machine)
 
     scsi_bus_legacy_handle_cmdline(&esp->bus);
 
+    /* Apple Sound Chip */
+
+    dev = qdev_new(TYPE_ASC);
+    qdev_prop_set_uint8(dev, "asctype", ASC_TYPE_EASC);
+    sysbus = SYS_BUS_DEVICE(dev);
+    sysbus_realize_and_unref(sysbus, &error_fatal);
+    memory_region_add_subregion(&m->macio, ASC_BASE - IO_BASE,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
+    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(m->glue, GLUE_IRQ_IN_ASC));
+
+    /* Wire ASC IRQ via GLUE for use in classic mode */
+    qdev_connect_gpio_out(m->glue, GLUE_IRQ_ASC,
+                          qdev_get_gpio_in(via2_dev, VIA2_IRQ_ASC_BIT));
+
     /* SWIM floppy controller */
 
     dev = qdev_new(TYPE_SWIM);
-- 
2.30.2


