Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CE97D5831
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:26:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKCv-0000ib-DD; Tue, 24 Oct 2023 12:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKCp-0000h0-I9
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:24:35 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKCn-0000ua-Fy
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:24:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4084095722aso37998915e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698164672; x=1698769472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b6Om8F0lyqfbMRyo8SSc+ekAJt2kZ8Qy47WwEpaiPmE=;
 b=HpuCPYPFv+cfUvzofFhPM9Rh4W0RnLEkpW5frz6SuHbZdJ7RScd/esJXg3UdSghbaA
 JbItxRHTMfHuBTgNk0jlYoZmilYmnfz5LOk+97CqTy0mECR5GRyHDioz+/WsdKXg3peh
 +nNriHz7WWyO7zu3Nibqe5ibrj2qbIi5n4t1QuGg3Oxwk8RKjGQl+ybv6hVw0qJaujgN
 X4V7YarG5hOzRImF7LoPEd2cz4N9wO3+Kg9FzeWsWI14dEJSoS4079xOx4ei3O1fu6Ye
 5aI/sONzmLbipVENnG1ynH/Ym1tHJNNLNMe2pa6xT4wiLwow50mUCPfC7DWDX/Nb1Aqm
 ZzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698164672; x=1698769472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b6Om8F0lyqfbMRyo8SSc+ekAJt2kZ8Qy47WwEpaiPmE=;
 b=cGxf7rm24z5+NGhRRDrhgplLw5qdllx1P//luGDtTiwSmKGDY6X4FdjmbeGZhReE+D
 rYSuvrL1pNGydKUyBR2wwSwQ6ILQgsQ+4m+rnzYjk2NXVUUiq8cVBibACQYVhUtZtQ4Y
 HBWUUTBgmr9Dd7nfB2mQqR3mBbLgoJp/llVyDJlOTqdMfQJ6uiVbBkIAm7cB/xcvzPQZ
 t+WRRh4yvd86752tCTIFb3fyqVQ7DekTRYDftKxOgNl3maFSb0NzvA5eW8IWi8ppUSDL
 b+xdn6hqJe9HTMKC74Xmmq5cbQJHW/al51zLYE0Xor8J9WM0kk0XnAxCtIospfflh0bK
 62JA==
X-Gm-Message-State: AOJu0YxtVc39tJZNecD0Y52F02fCG0kixsghngN/wMKozpLP77ZQualZ
 /XdOSaGxSXhRWqL4HZUkeb6SFT6UwCKNZ7vxMaY=
X-Google-Smtp-Source: AGHT+IH913w/1mMe9MwVCUoF++WXR3kYPFoEBnUarAp7BvyNvN1Up549FkUcTEpD7p4wGuXmoxvgyA==
X-Received: by 2002:a05:600c:4f8e:b0:408:fc62:f825 with SMTP id
 n14-20020a05600c4f8e00b00408fc62f825mr5893239wmq.21.1698164671813; 
 Tue, 24 Oct 2023 09:24:31 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 j6-20020a05600c488600b004080f0376a0sm12297516wmp.42.2023.10.24.09.24.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 09:24:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/11] hw/arm/aspeed: Extract code common to all boards to a
 common file
Date: Tue, 24 Oct 2023 18:24:12 +0200
Message-ID: <20231024162423.40206-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024162423.40206-1-philmd@linaro.org>
References: <20231024162423.40206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

aspeed_soc.c contains definitions specific to the AST2400
and AST2500 SoCs, but also some definitions for other AST
SoCs: move them to a common file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/aspeed_soc.c        |  96 -------------------------------
 hw/arm/aspeed_soc_common.c | 114 +++++++++++++++++++++++++++++++++++++
 hw/arm/meson.build         |   1 +
 3 files changed, 115 insertions(+), 96 deletions(-)
 create mode 100644 hw/arm/aspeed_soc_common.c

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index bf22258de9..f6c2ead4ac 100644
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
index 0000000000..a43f5d2a6f
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
index a6feaf1af9..42e7aa36f3 100644
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


