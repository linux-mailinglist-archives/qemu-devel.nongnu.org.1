Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1D973989C
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:56:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFBH-0004hh-W9; Thu, 22 Jun 2023 03:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAb-0003yj-Ob
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:00 -0400
Received: from mout.kundenserver.de ([212.227.126.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAY-0002sY-8D
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:55:57 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MBll6-1qOIOo3NSW-00C8ba; Thu, 22
 Jun 2023 09:55:51 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/24] q800: move GLUE device to Q800MachineState
Date: Thu, 22 Jun 2023 09:55:29 +0200
Message-Id: <20230622075544.210899-10-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622075544.210899-1-laurent@vivier.eu>
References: <20230622075544.210899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PxyR+IbYaaxEwPRvzBYr3E6Q3w3QPQ7b9JR820xt4EzEGmscYy6
 V8W6qLbJEcrGMPL911yo6GbkOA+HCylqv9n0xaY8by4EKGJ6R1rtwV6qGWlUoNY8t1gIeH0
 CpG+vxgsEiuXLzqEl8LaKSxrmGdkxuYDfwYN7LjJQ0kQ6vwgopKPO5YgbKZ3PWVvGo3wT2M
 R87XqIIpm47v5uF1ZWM2g==
UI-OutboundReport: notjunk:1;M01:P0:nQw+0VAXMQo=;TUm5NISQPGaGlENMLHFx5kxA/wW
 GmWXltdo4FHMC4A6O+pIfrxj5vJqk+outQDxgi+mg7L+bV9WIbXBwDXwIKx1hOvnp/+1tCf0f
 eJM/XkZNP1qqxny0z5n3X1g05Ud7OxQf1e0EIWSuydQsbxlF2PbeqyP3249p29YJdTsF2mMvY
 pLw/jZDCm6anFhrurWhHT3Me+xgWrNfsB6PIYYAFt9qEXJkuc4BJh3ojQrzfXifWFHapIPFJM
 rPQwIVR0ZAwTysUg8crcWnye2/Ha6q80o4I55GMEk/NbgtxsqLgN8Y+D8I0Skx/eYhFfJZx5R
 zy0Tfn2k4E3Ra5fHpO08xYF/EcZMY4AJuF1l168zylIN8jO8V1NOGJGM9BJPKjRZvOFIdCds6
 qDVfZ08q3d83/0Opxdi+8RzsycjiRU1/Xpqd7aEQTU9aYRs41E6zBewLkqIzvgcz9TPYYB4CG
 hAHJNpWFApfaw5K08mwFB8oOUQikZHYw10V4FlR6tz/Guv/n+PWSlX+dARVyHsbJfNn3BaqJg
 bVg/l4C9FDPIzWpAZ1zE9fdy4HvL6Txwv4kScKfrl8EVKGeQoMOEfH3pzCA5kgHVGmMWrNDyx
 higkoQxXa7ApUNNgBCFHp94Wc27mbZzP+6oGbmvJ6CeHhqpHvZFWHiFzHLqRs95EZtlREwYdI
 hxds2xkC33YFVOuOucSuQGCSkynJIfXScVRRh9HJSw==
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

Also change the instantiation of the GLUE device to use object_initialize_child().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20230621085353.113233-10-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/m68k/q800.h |  2 ++
 hw/m68k/q800.c         | 24 ++++++++++++++----------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index d1f1ae4b8864..fda42e0a1c30 100644
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
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 9f9de2ebafb7..505e50d4af2e 100644
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
     qdev_connect_gpio_out(escc_orgate, 0,
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
 
-- 
2.40.1


