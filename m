Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5218C7D6612
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:01:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvZjn-00082f-OF; Wed, 25 Oct 2023 04:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=4l40=GH=kaod.org=clg@ozlabs.org>)
 id 1qvZjm-00081z-3C; Wed, 25 Oct 2023 04:59:38 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=4l40=GH=kaod.org=clg@ozlabs.org>)
 id 1qvZjj-0004OR-Mk; Wed, 25 Oct 2023 04:59:37 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SFjY00553z4wx7;
 Wed, 25 Oct 2023 19:59:32 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SFjXy3Qcxz4wnw;
 Wed, 25 Oct 2023 19:59:30 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 02/12] hw/arm/aspeed: Extract code common to all boards to a
 common file
Date: Wed, 25 Oct 2023 10:59:11 +0200
Message-ID: <20231025085921.733686-3-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025085921.733686-1-clg@kaod.org>
References: <20231025085921.733686-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=4l40=GH=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

aspeed_soc.c contains definitions specific to the AST2400
and AST2500 SoCs, but also some definitions for other AST
SoCs: move them to a common file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/arm/aspeed_soc.c        |  96 -------------------------------
 hw/arm/aspeed_soc_common.c | 114 +++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build         |   1 +
 3 files changed, 115 insertions(+), 96 deletions(-)
 create mode 100644 hw/arm/aspeed_soc_common.c

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index bf22258de958..f6c2ead4ace0 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -585,99 +585,3 @@ static void aspeed_soc_register_types(void)
 };
 
 type_init(aspeed_soc_register_types);
-
-qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev)
-{
-    return ASPEED_SOC_GET_CLASS(s)->get_irq(s, dev);
-}
-
-bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp)
-{
-    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
-    SerialMM *smm;
-
-    for (int i = 0, uart = ASPEED_DEV_UART1; i < sc->uarts_num; i++, uart++) {
-        smm = &s->uart[i];
-
-        /* Chardev property is set by the machine. */
-        qdev_prop_set_uint8(DEVICE(smm), "regshift", 2);
-        qdev_prop_set_uint32(DEVICE(smm), "baudbase", 38400);
-        qdev_set_legacy_instance_id(DEVICE(smm), sc->memmap[uart], 2);
-        qdev_prop_set_uint8(DEVICE(smm), "endianness", DEVICE_LITTLE_ENDIAN);
-        if (!sysbus_realize(SYS_BUS_DEVICE(smm), errp)) {
-            return false;
-        }
-
-        sysbus_connect_irq(SYS_BUS_DEVICE(smm), 0, aspeed_soc_get_irq(s, uart));
-        aspeed_mmio_map(s, SYS_BUS_DEVICE(smm), 0, sc->memmap[uart]);
-    }
-
-    return true;
-}
-
-void aspeed_soc_uart_set_chr(AspeedSoCState *s, int dev, Chardev *chr)
-{
-    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
-    int i = dev - ASPEED_DEV_UART1;
-
-    g_assert(0 <= i && i < ARRAY_SIZE(s->uart) && i < sc->uarts_num);
-    qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", chr);
-}
-
-/*
- * SDMC should be realized first to get correct RAM size and max size
- * values
- */
-bool aspeed_soc_dram_init(AspeedSoCState *s, Error **errp)
-{
-    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
-    ram_addr_t ram_size, max_ram_size;
-
-    ram_size = object_property_get_uint(OBJECT(&s->sdmc), "ram-size",
-                                        &error_abort);
-    max_ram_size = object_property_get_uint(OBJECT(&s->sdmc), "max-ram-size",
-                                            &error_abort);
-
-    memory_region_init(&s->dram_container, OBJECT(s), "ram-container",
-                       max_ram_size);
-    memory_region_add_subregion(&s->dram_container, 0, s->dram_mr);
-
-    /*
-     * Add a memory region beyond the RAM region to let firmwares scan
-     * the address space with load/store and guess how much RAM the
-     * SoC has.
-     */
-    if (ram_size < max_ram_size) {
-        DeviceState *dev = qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
-
-        qdev_prop_set_string(dev, "name", "ram-empty");
-        qdev_prop_set_uint64(dev, "size", max_ram_size  - ram_size);
-        if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp)) {
-            return false;
-        }
-
-        memory_region_add_subregion_overlap(&s->dram_container, ram_size,
-                      sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0), -1000);
-    }
-
-    memory_region_add_subregion(s->memory,
-                      sc->memmap[ASPEED_DEV_SDRAM], &s->dram_container);
-    return true;
-}
-
-void aspeed_mmio_map(AspeedSoCState *s, SysBusDevice *dev, int n, hwaddr addr)
-{
-    memory_region_add_subregion(s->memory, addr,
-                                sysbus_mmio_get_region(dev, n));
-}
-
-void aspeed_mmio_map_unimplemented(AspeedSoCState *s, SysBusDevice *dev,
-                                   const char *name, hwaddr addr, uint64_t size)
-{
-    qdev_prop_set_string(DEVICE(dev), "name", name);
-    qdev_prop_set_uint64(DEVICE(dev), "size", size);
-    sysbus_realize(dev, &error_abort);
-
-    memory_region_add_subregion_overlap(s->memory, addr,
-                                        sysbus_mmio_get_region(dev, 0), -1000);
-}
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
new file mode 100644
index 000000000000..a43f5d2a6f21
--- /dev/null
+++ b/hw/arm/aspeed_soc_common.c
@@ -0,0 +1,114 @@
+/*
+ * ASPEED SoC family
+ *
+ * Andrew Jeffery <andrew@aj.id.au>
+ * Jeremy Kerr <jk@ozlabs.org>
+ *
+ * Copyright 2016 IBM Corp.
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/misc/unimp.h"
+#include "hw/arm/aspeed_soc.h"
+#include "hw/char/serial.h"
+
+
+qemu_irq aspeed_soc_get_irq(AspeedSoCState *s, int dev)
+{
+    return ASPEED_SOC_GET_CLASS(s)->get_irq(s, dev);
+}
+
+bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp)
+{
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    SerialMM *smm;
+
+    for (int i = 0, uart = ASPEED_DEV_UART1; i < sc->uarts_num; i++, uart++) {
+        smm = &s->uart[i];
+
+        /* Chardev property is set by the machine. */
+        qdev_prop_set_uint8(DEVICE(smm), "regshift", 2);
+        qdev_prop_set_uint32(DEVICE(smm), "baudbase", 38400);
+        qdev_set_legacy_instance_id(DEVICE(smm), sc->memmap[uart], 2);
+        qdev_prop_set_uint8(DEVICE(smm), "endianness", DEVICE_LITTLE_ENDIAN);
+        if (!sysbus_realize(SYS_BUS_DEVICE(smm), errp)) {
+            return false;
+        }
+
+        sysbus_connect_irq(SYS_BUS_DEVICE(smm), 0, aspeed_soc_get_irq(s, uart));
+        aspeed_mmio_map(s, SYS_BUS_DEVICE(smm), 0, sc->memmap[uart]);
+    }
+
+    return true;
+}
+
+void aspeed_soc_uart_set_chr(AspeedSoCState *s, int dev, Chardev *chr)
+{
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    int i = dev - ASPEED_DEV_UART1;
+
+    g_assert(0 <= i && i < ARRAY_SIZE(s->uart) && i < sc->uarts_num);
+    qdev_prop_set_chr(DEVICE(&s->uart[i]), "chardev", chr);
+}
+
+/*
+ * SDMC should be realized first to get correct RAM size and max size
+ * values
+ */
+bool aspeed_soc_dram_init(AspeedSoCState *s, Error **errp)
+{
+    AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
+    ram_addr_t ram_size, max_ram_size;
+
+    ram_size = object_property_get_uint(OBJECT(&s->sdmc), "ram-size",
+                                        &error_abort);
+    max_ram_size = object_property_get_uint(OBJECT(&s->sdmc), "max-ram-size",
+                                            &error_abort);
+
+    memory_region_init(&s->dram_container, OBJECT(s), "ram-container",
+                       max_ram_size);
+    memory_region_add_subregion(&s->dram_container, 0, s->dram_mr);
+
+    /*
+     * Add a memory region beyond the RAM region to let firmwares scan
+     * the address space with load/store and guess how much RAM the
+     * SoC has.
+     */
+    if (ram_size < max_ram_size) {
+        DeviceState *dev = qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
+
+        qdev_prop_set_string(dev, "name", "ram-empty");
+        qdev_prop_set_uint64(dev, "size", max_ram_size  - ram_size);
+        if (!sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp)) {
+            return false;
+        }
+
+        memory_region_add_subregion_overlap(&s->dram_container, ram_size,
+                      sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0), -1000);
+    }
+
+    memory_region_add_subregion(s->memory,
+                      sc->memmap[ASPEED_DEV_SDRAM], &s->dram_container);
+    return true;
+}
+
+void aspeed_mmio_map(AspeedSoCState *s, SysBusDevice *dev, int n, hwaddr addr)
+{
+    memory_region_add_subregion(s->memory, addr,
+                                sysbus_mmio_get_region(dev, n));
+}
+
+void aspeed_mmio_map_unimplemented(AspeedSoCState *s, SysBusDevice *dev,
+                                   const char *name, hwaddr addr, uint64_t size)
+{
+    qdev_prop_set_string(DEVICE(dev), "name", name);
+    qdev_prop_set_uint64(DEVICE(dev), "size", size);
+    sysbus_realize(dev, &error_abort);
+
+    memory_region_add_subregion_overlap(s->memory, addr,
+                                        sysbus_mmio_get_region(dev, 0), -1000);
+}
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index a6feaf1af957..42e7aa36f39a 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -50,6 +50,7 @@ arm_ss.add(when: 'CONFIG_FSL_IMX6', if_true: files('fsl-imx6.c'))
 arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files(
   'aspeed_soc.c',
   'aspeed.c',
+  'aspeed_soc_common.c',
   'aspeed_ast2600.c',
   'aspeed_ast10x0.c',
   'aspeed_eeprom.c',
-- 
2.41.0


