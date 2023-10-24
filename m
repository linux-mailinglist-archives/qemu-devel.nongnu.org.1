Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5A37D5835
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:26:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKDo-0002PI-D3; Tue, 24 Oct 2023 12:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKDh-0001wa-4X
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:25:29 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKDe-0001I1-I9
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:25:28 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4083f61312eso37989925e9.3
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698164724; x=1698769524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1V1EtthXoUpnw1bY75gEX7F7PVToQjBtbS0VXrW5O/0=;
 b=DFD6v86gvSpxov4Lqbc6SWTH73JyCKfrjDsCrL/FauiNDn0MODwjOMO7xeDMDZYhsN
 XG8kcaATkwA+VkpsySJECfsc5BPg7y8XW8T9FgAUx33paRGLyAdkkI7Lj7A6Mmip9kFH
 k4Lzxi8QvPUkLAj9PpiVfA1c2QMTojJYaWg/vLM9Km/zScXHxQAOeC0bomYb2XhDYh8p
 058j+51tzw6UIRanS1M6jnm241m2VLb98Km4jwfhC89rMmZUTWsjPC7AreAGCsmpD0L2
 pUfzpPQLZ0zsTifTkCgsa6UhVtkds5NmLEtpQLEQ4gqf+uOO9h0EVji3mX9M8Mb+EltM
 bXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698164724; x=1698769524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1V1EtthXoUpnw1bY75gEX7F7PVToQjBtbS0VXrW5O/0=;
 b=aabFHB0Nd4WvW4iQeJYYzJAOL8LT9XarHb3ap+sA1Hd6kCd4pXJusVXo97OEzZNwj4
 2RORYoxT//AIcLTANSPVNNCA/TRx0UBrh0lO7W9YZrW2wcJycrY3B8+vv7jjh0jM9frA
 T+x9YiAw8gwEuUnRaOX0UfIRJoBJ+MpU1Y/24VUdjLdBVN1InGsIyOZqu2rNwvzC8aKm
 SGIHvBtzvA/fbtxC0U2BtU2BTPT6ENoFRyUd53HVNA2PUgKUYWk9jnBkOPTDVOoygSds
 JE96YfGfcXMmkEsYSJqt3iXTE3yUdRUCGG8gi2zcr0BpefCkmWiwfYjtbFF37UzjT2W/
 p84A==
X-Gm-Message-State: AOJu0YzDKhnEr+TIlLAx+FAdVy2bUjCvzbmZ47bjS9Cw9Ik6bUy+uVFf
 K/r80qK7RJYbXXG378HCdDBk6qUPkVcBT9Xtr8Y=
X-Google-Smtp-Source: AGHT+IESC5jhpMryYb72kP3KyuMNiPU092y34cRgxV0WgZJAcEek2iI5ogTzjJnemTLkXl1TsokDrg==
X-Received: by 2002:a05:600c:3147:b0:405:4a78:a892 with SMTP id
 h7-20020a05600c314700b004054a78a892mr9679650wmo.9.1698164724501; 
 Tue, 24 Oct 2023 09:25:24 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 n15-20020a05600c4f8f00b0040472ad9a3dsm12296385wmq.14.2023.10.24.09.25.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 09:25:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/11] hw/arm/aspeed: Move AspeedSoCState::a7mpcore to
 Aspeed2600SoCState
Date: Tue, 24 Oct 2023 18:24:21 +0200
Message-ID: <20231024162423.40206-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024162423.40206-1-philmd@linaro.org>
References: <20231024162423.40206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

The v7-A cluster is specific to the Aspeed 2600 series,
remove it from the common AspeedSoCState.

The ARM cores belong to the MP cluster, but the array
is currently used by TYPE_ASPEED2600_SOC. We'll clean
that soon, but for now keep it in Aspeed2600SoCState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/aspeed_soc.h |  4 ++-
 hw/arm/aspeed_ast2600.c     | 49 ++++++++++++++++++++-----------------
 hw/arm/fby35.c              | 14 ++++++-----
 3 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 2118a441f7..6f783138e1 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -50,7 +50,6 @@ struct AspeedSoCState {
     DeviceState parent;
 
     ARMCPU cpu[ASPEED_CPUS_NUM];
-    A15MPPrivState     a7mpcore;
     MemoryRegion *memory;
     MemoryRegion *dram_mr;
     MemoryRegion dram_container;
@@ -107,6 +106,9 @@ OBJECT_DECLARE_SIMPLE_TYPE(Aspeed2400SoCState, ASPEED2400_SOC)
 
 struct Aspeed2600SoCState {
     AspeedSoCState parent;
+
+    A15MPPrivState a7mpcore;
+    ARMCPU cpu[ASPEED_CPUS_NUM]; /* XXX belong to a7mpcore */
 };
 
 #define TYPE_ASPEED2600_SOC "aspeed2600-soc"
diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 1ee460e56c..b965fbab5e 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -137,13 +137,15 @@ static const int aspeed_soc_ast2600_irqmap[] = {
 
 static qemu_irq aspeed_soc_ast2600_get_irq(AspeedSoCState *s, int dev)
 {
+    Aspeed2600SoCState *a = ASPEED2600_SOC(s);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
 
-    return qdev_get_gpio_in(DEVICE(&s->a7mpcore), sc->irqmap[dev]);
+    return qdev_get_gpio_in(DEVICE(&a->a7mpcore), sc->irqmap[dev]);
 }
 
 static void aspeed_soc_ast2600_init(Object *obj)
 {
+    Aspeed2600SoCState *a = ASPEED2600_SOC(obj);
     AspeedSoCState *s = ASPEED_SOC(obj);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     int i;
@@ -155,7 +157,7 @@ static void aspeed_soc_ast2600_init(Object *obj)
     }
 
     for (i = 0; i < sc->num_cpus; i++) {
-        object_initialize_child(obj, "cpu[*]", &s->cpu[i], sc->cpu_type);
+        object_initialize_child(obj, "cpu[*]", &a->cpu[i], sc->cpu_type);
     }
 
     snprintf(typename, sizeof(typename), "aspeed.scu-%s", socname);
@@ -169,7 +171,7 @@ static void aspeed_soc_ast2600_init(Object *obj)
     object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
                               "hw-prot-key");
 
-    object_initialize_child(obj, "a7mpcore", &s->a7mpcore,
+    object_initialize_child(obj, "a7mpcore", &a->a7mpcore,
                             TYPE_A15MPCORE_PRIV);
 
     object_initialize_child(obj, "rtc", &s->rtc, TYPE_ASPEED_RTC);
@@ -277,6 +279,7 @@ static uint64_t aspeed_calc_affinity(int cpu)
 static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
 {
     int i;
+    Aspeed2600SoCState *a = ASPEED2600_SOC(dev);
     AspeedSoCState *s = ASPEED_SOC(dev);
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     Error *err = NULL;
@@ -306,39 +309,39 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     /* CPU */
     for (i = 0; i < sc->num_cpus; i++) {
         if (sc->num_cpus > 1) {
-            object_property_set_int(OBJECT(&s->cpu[i]), "reset-cbar",
+            object_property_set_int(OBJECT(&a->cpu[i]), "reset-cbar",
                                     ASPEED_A7MPCORE_ADDR, &error_abort);
         }
-        object_property_set_int(OBJECT(&s->cpu[i]), "mp-affinity",
+        object_property_set_int(OBJECT(&a->cpu[i]), "mp-affinity",
                                 aspeed_calc_affinity(i), &error_abort);
 
-        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 1125000000,
+        object_property_set_int(OBJECT(&a->cpu[i]), "cntfrq", 1125000000,
                                 &error_abort);
-        object_property_set_bool(OBJECT(&s->cpu[i]), "neon", false,
+        object_property_set_bool(OBJECT(&a->cpu[i]), "neon", false,
                                 &error_abort);
-        object_property_set_bool(OBJECT(&s->cpu[i]), "vfp-d32", false,
+        object_property_set_bool(OBJECT(&a->cpu[i]), "vfp-d32", false,
                                 &error_abort);
-        object_property_set_link(OBJECT(&s->cpu[i]), "memory",
+        object_property_set_link(OBJECT(&a->cpu[i]), "memory",
                                  OBJECT(s->memory), &error_abort);
 
-        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
+        if (!qdev_realize(DEVICE(&a->cpu[i]), NULL, errp)) {
             return;
         }
     }
 
     /* A7MPCORE */
-    object_property_set_int(OBJECT(&s->a7mpcore), "num-cpu", sc->num_cpus,
+    object_property_set_int(OBJECT(&a->a7mpcore), "num-cpu", sc->num_cpus,
                             &error_abort);
-    object_property_set_int(OBJECT(&s->a7mpcore), "num-irq",
+    object_property_set_int(OBJECT(&a->a7mpcore), "num-irq",
                             ROUND_UP(AST2600_MAX_IRQ + GIC_INTERNAL, 32),
                             &error_abort);
 
-    sysbus_realize(SYS_BUS_DEVICE(&s->a7mpcore), &error_abort);
-    aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->a7mpcore), 0, ASPEED_A7MPCORE_ADDR);
+    sysbus_realize(SYS_BUS_DEVICE(&a->a7mpcore), &error_abort);
+    aspeed_mmio_map(s, SYS_BUS_DEVICE(&a->a7mpcore), 0, ASPEED_A7MPCORE_ADDR);
 
     for (i = 0; i < sc->num_cpus; i++) {
-        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->a7mpcore);
-        DeviceState  *d   = DEVICE(&s->cpu[i]);
+        SysBusDevice *sbd = SYS_BUS_DEVICE(&a->a7mpcore);
+        DeviceState  *d   = DEVICE(&a->cpu[i]);
 
         irq = qdev_get_gpio_in(d, ARM_CPU_IRQ);
         sysbus_connect_irq(sbd, i, irq);
@@ -351,7 +354,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
 
     /* SRAM */
-    sram_name = g_strdup_printf("aspeed.sram.%d", CPU(&s->cpu[0])->cpu_index);
+    sram_name = g_strdup_printf("aspeed.sram.%d", CPU(&a->cpu[0])->cpu_index);
     memory_region_init_ram(&s->sram, OBJECT(s), sram_name, sc->sram_size, &err);
     if (err) {
         error_propagate(errp, err);
@@ -413,7 +416,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
     aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->i2c), 0, sc->memmap[ASPEED_DEV_I2C]);
     for (i = 0; i < ASPEED_I2C_GET_CLASS(&s->i2c)->num_busses; i++) {
-        irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore),
+        irq = qdev_get_gpio_in(DEVICE(&a->a7mpcore),
                                sc->irqmap[ASPEED_DEV_I2C] + i);
         /* The AST2600 I2C controller has one IRQ per bus. */
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c.busses[i]), 0, irq);
@@ -579,19 +582,19 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
      * offset 0.
      */
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 1 + aspeed_lpc_kcs_1,
-                       qdev_get_gpio_in(DEVICE(&s->a7mpcore),
+                       qdev_get_gpio_in(DEVICE(&a->a7mpcore),
                                 sc->irqmap[ASPEED_DEV_KCS] + aspeed_lpc_kcs_1));
 
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 1 + aspeed_lpc_kcs_2,
-                       qdev_get_gpio_in(DEVICE(&s->a7mpcore),
+                       qdev_get_gpio_in(DEVICE(&a->a7mpcore),
                                 sc->irqmap[ASPEED_DEV_KCS] + aspeed_lpc_kcs_2));
 
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 1 + aspeed_lpc_kcs_3,
-                       qdev_get_gpio_in(DEVICE(&s->a7mpcore),
+                       qdev_get_gpio_in(DEVICE(&a->a7mpcore),
                                 sc->irqmap[ASPEED_DEV_KCS] + aspeed_lpc_kcs_3));
 
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->lpc), 1 + aspeed_lpc_kcs_4,
-                       qdev_get_gpio_in(DEVICE(&s->a7mpcore),
+                       qdev_get_gpio_in(DEVICE(&a->a7mpcore),
                                 sc->irqmap[ASPEED_DEV_KCS] + aspeed_lpc_kcs_4));
 
     /* HACE */
@@ -611,7 +614,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
     }
     aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->i3c), 0, sc->memmap[ASPEED_DEV_I3C]);
     for (i = 0; i < ASPEED_I3C_NR_DEVICES; i++) {
-        irq = qdev_get_gpio_in(DEVICE(&s->a7mpcore),
+        irq = qdev_get_gpio_in(DEVICE(&a->a7mpcore),
                                sc->irqmap[ASPEED_DEV_I3C] + i);
         /* The AST2600 I3C controller has one IRQ per bus. */
         sysbus_connect_irq(SYS_BUS_DEVICE(&s->i3c.devices[i]), 0, irq);
diff --git a/hw/arm/fby35.c b/hw/arm/fby35.c
index c8bc75d870..c9964bd283 100644
--- a/hw/arm/fby35.c
+++ b/hw/arm/fby35.c
@@ -27,7 +27,7 @@ struct Fby35State {
     MemoryRegion bic_memory;
     Clock *bic_sysclk;
 
-    AspeedSoCState bmc;
+    Aspeed2600SoCState bmc;
     Aspeed10x0SoCState bic;
 
     bool mmio_exec;
@@ -70,7 +70,10 @@ static void fby35_bmc_write_boot_rom(DriveInfo *dinfo, MemoryRegion *mr,
 
 static void fby35_bmc_init(Fby35State *s)
 {
+    AspeedSoCState *soc;
+
     object_initialize_child(OBJECT(s), "bmc", &s->bmc, "ast2600-a3");
+    soc = ASPEED_SOC(&s->bmc);
 
     memory_region_init(&s->bmc_memory, OBJECT(&s->bmc), "bmc-memory",
                        UINT64_MAX);
@@ -87,22 +90,21 @@ static void fby35_bmc_init(Fby35State *s)
                             &error_abort);
     object_property_set_int(OBJECT(&s->bmc), "hw-strap2", 0x00000003,
                             &error_abort);
-    aspeed_soc_uart_set_chr(&s->bmc, ASPEED_DEV_UART5, serial_hd(0));
+    aspeed_soc_uart_set_chr(soc, ASPEED_DEV_UART5, serial_hd(0));
     qdev_realize(DEVICE(&s->bmc), NULL, &error_abort);
 
-    aspeed_board_init_flashes(&s->bmc.fmc, "n25q00", 2, 0);
+    aspeed_board_init_flashes(&soc->fmc, "n25q00", 2, 0);
 
     /* Install first FMC flash content as a boot rom. */
     if (!s->mmio_exec) {
         DriveInfo *mtd0 = drive_get(IF_MTD, 0, 0);
 
         if (mtd0) {
-            AspeedSoCState *bmc = &s->bmc;
-            uint64_t rom_size = memory_region_size(&bmc->spi_boot);
+            uint64_t rom_size = memory_region_size(&soc->spi_boot);
 
             memory_region_init_rom(&s->bmc_boot_rom, NULL, "aspeed.boot_rom",
                                    rom_size, &error_abort);
-            memory_region_add_subregion_overlap(&bmc->spi_boot_container, 0,
+            memory_region_add_subregion_overlap(&soc->spi_boot_container, 0,
                                                 &s->bmc_boot_rom, 1);
 
             fby35_bmc_write_boot_rom(mtd0, &s->bmc_boot_rom,
-- 
2.41.0


