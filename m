Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF37E721745
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 15:16:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5na5-00050H-Ll; Sun, 04 Jun 2023 09:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nZz-0004ye-BG
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:15:33 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nZw-0003EA-9f
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ou0sCOxRxOKtd24TsmvfldbedfGZ3RJhT6/PU91IP6g=; b=oZ+INaKF3Egpte+YmTgdLPExM/
 T/zPvq/wscB5TJcxjZYuVCH5v3LGiyR+dxrl9999ZsE8cZENjtx7X5eRfyzWuCwB2mdR6+jSfXE8C
 CHvjta9m9y5u26IYFka545zlTT670BfCcErkDp67QDCHkfB6unCPB3scG/V5WHzhXZGS58bIHH/cN
 iBWaKQmvpmBgNCBYjyBf1uXU6pDyVzmxepgGfvuS/3PGPESs39HeXyDVQfnWc83y2Pwhjr56GHVjT
 P929Xvw9HPyWvgxsql+yGheSd3vIzV2yaxCRFrRxeHQQUrXCUMuwCE2lZ+YddG5B900/SELBYk9r8
 JwL3npV7b1JKxHg/DtI/wHsaJhFgSUZmUBrcFn+MEbRj9Y2yUBeZ2wiH5JPfh2+/nRDajvfbiWzxw
 V6tXtl5mIgV5kAy4NQFSKV6Cvo4tGYaL5ycsLsiTmRNXxpaisKG7w9mzgK04Ha97+hA3BlwWeFZTu
 TEphZakzM9jVEjI4LuXF0GncYjO/sfwKGfJqFQGi8/Rom5UBMAPwXnGliKqzay2EpBWiYGhjcoOt2
 jd2uOogPU6xFzQhCgA9VgDHLGmEiWN7i5eC1e8CvZREREjnBwqursvwDzZY/J8lWSh6Fq8YmE97YP
 /49BI5tsqqXOzBRjBeNwB9XNT184Xxm3sg8Y3L8lU=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nZl-0005pb-8k; Sun, 04 Jun 2023 14:15:21 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sun,  4 Jun 2023 14:14:35 +0100
Message-Id: <20230604131450.428797-9-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 08/23] q800: move GLUE device to Q800MachineState
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

Also change the instantiation of the GLUE device to use object_initialize_child().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800.c         | 24 ++++++++++++++----------
 include/hw/m68k/q800.h |  2 ++
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index fa63e2aacb..7aa391a322 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -158,7 +158,6 @@ static void q800_machine_init(MachineState *machine)
     SysBusDevice *sysbus;
     BusState *adb_bus;
     NubusBus *nubus;
-    DeviceState *glue;
     DriveInfo *dinfo;
     uint8_t rng_seed[32];
 
@@ -194,10 +193,10 @@ static void q800_machine_init(MachineState *machine)
     }
 
     /* IRQ Glue */
-    glue = qdev_new(TYPE_GLUE);
-    object_property_set_link(OBJECT(glue), "cpu", OBJECT(&m->cpu),
+    object_initialize_child(OBJECT(machine), "glue", &m->glue, TYPE_GLUE);
+    object_property_set_link(OBJECT(&m->glue), "cpu", OBJECT(&m->cpu),
                              &error_abort);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(glue), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&m->glue), &error_fatal);
 
     /* VIA 1 */
     via1_dev = qdev_new(TYPE_MOS6522_Q800_VIA1);
@@ -208,10 +207,12 @@ static void q800_machine_init(MachineState *machine)
     sysbus = SYS_BUS_DEVICE(via1_dev);
     sysbus_realize_and_unref(sysbus, &error_fatal);
     sysbus_mmio_map(sysbus, 1, VIA_BASE);
-    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(glue, GLUE_IRQ_IN_VIA1));
+    sysbus_connect_irq(sysbus, 0,
+                       qdev_get_gpio_in(DEVICE(&m->glue), GLUE_IRQ_IN_VIA1));
     /* A/UX mode */
     qdev_connect_gpio_out(via1_dev, 0,
-                          qdev_get_gpio_in_named(glue, "auxmode", 0));
+                          qdev_get_gpio_in_named(DEVICE(&m->glue),
+                                                 "auxmode", 0));
 
     adb_bus = qdev_get_child_bus(via1_dev, "adb.0");
     dev = qdev_new(TYPE_ADB_KEYBOARD);
@@ -224,7 +225,8 @@ static void q800_machine_init(MachineState *machine)
     sysbus = SYS_BUS_DEVICE(via2_dev);
     sysbus_realize_and_unref(sysbus, &error_fatal);
     sysbus_mmio_map(sysbus, 1, VIA_BASE + VIA_SIZE);
-    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(glue, GLUE_IRQ_IN_VIA2));
+    sysbus_connect_irq(sysbus, 0,
+                       qdev_get_gpio_in(DEVICE(&m->glue), GLUE_IRQ_IN_VIA2));
 
     /* MACSONIC */
 
@@ -257,7 +259,8 @@ static void q800_machine_init(MachineState *machine)
     sysbus = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(sysbus, &error_fatal);
     sysbus_mmio_map(sysbus, 0, SONIC_BASE);
-    sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(glue, GLUE_IRQ_IN_SONIC));
+    sysbus_connect_irq(sysbus, 0,
+                       qdev_get_gpio_in(DEVICE(&m->glue), GLUE_IRQ_IN_SONIC));
 
     memory_region_init_rom(dp8393x_prom, NULL, "dp8393x-q800.prom",
                            SONIC_PROM_SIZE, &error_fatal);
@@ -294,7 +297,8 @@ static void q800_machine_init(MachineState *machine)
     sysbus_connect_irq(sysbus, 0, qdev_get_gpio_in(escc_orgate, 0));
     sysbus_connect_irq(sysbus, 1, qdev_get_gpio_in(escc_orgate, 1));
     qdev_connect_gpio_out(DEVICE(escc_orgate), 0,
-                          qdev_get_gpio_in(glue, GLUE_IRQ_IN_ESCC));
+                          qdev_get_gpio_in(DEVICE(&m->glue),
+                                           GLUE_IRQ_IN_ESCC));
     sysbus_mmio_map(sysbus, 0, SCC_BASE);
 
     /* SCSI */
@@ -349,7 +353,7 @@ static void q800_machine_init(MachineState *machine)
      * Since the framebuffer in slot 0x9 uses a separate IRQ, wire the unused
      * IRQ via GLUE for use by SONIC Ethernet in classic mode
      */
-    qdev_connect_gpio_out(glue, GLUE_IRQ_NUBUS_9,
+    qdev_connect_gpio_out(DEVICE(&m->glue), GLUE_IRQ_NUBUS_9,
                           qdev_get_gpio_in_named(via2_dev, "nubus-irq",
                                                  VIA2_NUBUS_IRQ_9));
 
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index d1f1ae4b88..fda42e0a1c 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -27,6 +27,7 @@
 #include "qom/object.h"
 #include "target/m68k/cpu-qom.h"
 #include "exec/memory.h"
+#include "hw/m68k/q800-glue.h"
 
 /*
  * The main Q800 machine
@@ -37,6 +38,7 @@ struct Q800MachineState {
 
     M68kCPU cpu;
     MemoryRegion rom;
+    GLUEState glue;
 };
 
 #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
-- 
2.30.2


