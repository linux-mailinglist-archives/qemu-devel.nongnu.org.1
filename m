Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 657287D582D
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:26:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKDF-00010F-4U; Tue, 24 Oct 2023 12:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKD7-0000wp-Mk
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:24:53 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKD5-0000yE-KQ
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:24:53 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32d9effe314so3216161f8f.3
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698164690; x=1698769490; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9aFJIXmtwqbnYUKsYDz9DP7wEF8yMmFziWczk8iH/9c=;
 b=w5Qw1vIDtAHX4zp1K+QEJUd7YDqzfCNuIfbT31rYoFYK1LcWECGUmuscQhGBL/Wbxl
 DNVgwhyedztgPdTH6IekszUUX+btS1tb46/hY/bkwmuW4qkkQnN31xB/uUnadE28ARkA
 IZ2J+AQ4/XCJt3wiBJeTuw6LmKaBAl6RVhT/sA2B5cwDSHu1VD+VjHjd7sVmW1k71YPV
 K03KChgBzmAsA1OyyBXKeAb0P6o9GIgFEI/bNL3PkWUQEVmpUyBDSg70qf28LPfVJvmX
 6pokTG/BUaVupkrA5C4pq71N/jsAWHxspT0huDJ8zSvkeAgtqBeO2X7InqYVyfuMrUYm
 qOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698164690; x=1698769490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9aFJIXmtwqbnYUKsYDz9DP7wEF8yMmFziWczk8iH/9c=;
 b=lWTtOMLXQl4pYZsFBOvBz6mOr/GZSH55XiXSdUQ6YV6ydRyi4vaD9VehfI3B9XNjXd
 Yt6KPMO+hhynAG+IQfgNGDw5uJ/fPTjqtuLvjmx+aC7uBOz3y1kcEFP5tccKiY9HIeRe
 pc5YLLvoUvzYYR3kG4kw9EIxrYMAnmTSevEfC85KWQBYkC+B3YamuY8pwighFBaBat/s
 MK9/ffhObDvGI2PwqQpRgx9CO+31updipqUJ/vfpNtXb7TkayedjOLPUwy6E4r9/H04k
 3XuQmgUgrLSKyrEFOlVMJVrP/1p+9I7MehqTBxdGeiBiWvYRvO1K2UAnYILwgOyjUec9
 r4mw==
X-Gm-Message-State: AOJu0YwXsV23CBSdvJO4SY8olnyCaDQq4PBNKD0mfX5bE9WLIfLZDePp
 /lUAExZAareN9BAuisOd2DSxQBayY/GHsRNPcLk=
X-Google-Smtp-Source: AGHT+IHsXfc3KqAd8/FQXxW/+Aeob0eQ8Nw2HtyT2/zdqkda8lqUWDB+qprugv/xpde7Zgaqx0cUCw==
X-Received: by 2002:adf:e5c4:0:b0:32d:8cd8:a2b6 with SMTP id
 a4-20020adfe5c4000000b0032d8cd8a2b6mr9407962wrn.2.1698164690017; 
 Tue, 24 Oct 2023 09:24:50 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 y10-20020a5d470a000000b0032d9efeccd8sm10243122wrq.51.2023.10.24.09.24.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 09:24:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 04/11] hw/arm/aspeed: Dynamically allocate
 AspeedMachineState::soc field
Date: Tue, 24 Oct 2023 18:24:15 +0200
Message-ID: <20231024162423.40206-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024162423.40206-1-philmd@linaro.org>
References: <20231024162423.40206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We want to derivate the big AspeedSoCState object in some more
SoC-specific ones. Since the object size will vary, allocate it
dynamically.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/aspeed.c | 101 +++++++++++++++++++++++++-----------------------
 1 file changed, 52 insertions(+), 49 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index f8ba67531a..cc59176563 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -40,7 +40,7 @@ struct AspeedMachineState {
     MachineState parent_obj;
     /* Public */
 
-    AspeedSoCState soc;
+    AspeedSoCState *soc;
     MemoryRegion boot_rom;
     bool mmio_exec;
     uint32_t uart_chosen;
@@ -288,7 +288,7 @@ static void write_boot_rom(BlockBackend *blk, hwaddr addr, size_t rom_size,
 static void aspeed_install_boot_rom(AspeedMachineState *bmc, BlockBackend *blk,
                                     uint64_t rom_size)
 {
-    AspeedSoCState *soc = &bmc->soc;
+    AspeedSoCState *soc = bmc->soc;
 
     memory_region_init_rom(&bmc->boot_rom, NULL, "aspeed.boot_rom", rom_size,
                            &error_abort);
@@ -337,7 +337,7 @@ static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo)
 static void connect_serial_hds_to_uarts(AspeedMachineState *bmc)
 {
     AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(bmc);
-    AspeedSoCState *s = &bmc->soc;
+    AspeedSoCState *s = bmc->soc;
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
     int uart_chosen = bmc->uart_chosen ? bmc->uart_chosen : amc->uart_default;
 
@@ -358,32 +358,33 @@ static void aspeed_machine_init(MachineState *machine)
     int i;
     NICInfo *nd = &nd_table[0];
 
-    object_initialize_child(OBJECT(machine), "soc", &bmc->soc, amc->soc_name);
-
-    sc = ASPEED_SOC_GET_CLASS(&bmc->soc);
+    bmc->soc = ASPEED_SOC(object_new(amc->soc_name));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(bmc->soc));
+    object_unref(OBJECT(bmc->soc));
+    sc = ASPEED_SOC_GET_CLASS(bmc->soc);
 
     /*
      * This will error out if the RAM size is not supported by the
      * memory controller of the SoC.
      */
-    object_property_set_uint(OBJECT(&bmc->soc), "ram-size", machine->ram_size,
+    object_property_set_uint(OBJECT(bmc->soc), "ram-size", machine->ram_size,
                              &error_fatal);
 
     for (i = 0; i < sc->macs_num; i++) {
         if ((amc->macs_mask & (1 << i)) && nd->used) {
             qemu_check_nic_model(nd, TYPE_FTGMAC100);
-            qdev_set_nic_properties(DEVICE(&bmc->soc.ftgmac100[i]), nd);
+            qdev_set_nic_properties(DEVICE(&bmc->soc->ftgmac100[i]), nd);
             nd++;
         }
     }
 
-    object_property_set_int(OBJECT(&bmc->soc), "hw-strap1", amc->hw_strap1,
+    object_property_set_int(OBJECT(bmc->soc), "hw-strap1", amc->hw_strap1,
                             &error_abort);
-    object_property_set_int(OBJECT(&bmc->soc), "hw-strap2", amc->hw_strap2,
+    object_property_set_int(OBJECT(bmc->soc), "hw-strap2", amc->hw_strap2,
                             &error_abort);
-    object_property_set_link(OBJECT(&bmc->soc), "memory",
+    object_property_set_link(OBJECT(bmc->soc), "memory",
                              OBJECT(get_system_memory()), &error_abort);
-    object_property_set_link(OBJECT(&bmc->soc), "dram",
+    object_property_set_link(OBJECT(bmc->soc), "dram",
                              OBJECT(machine->ram), &error_abort);
     if (machine->kernel_filename) {
         /*
@@ -391,17 +392,17 @@ static void aspeed_machine_init(MachineState *machine)
          * that runs to unlock the SCU. In this case set the default to
          * be unlocked as the kernel expects
          */
-        object_property_set_int(OBJECT(&bmc->soc), "hw-prot-key",
+        object_property_set_int(OBJECT(bmc->soc), "hw-prot-key",
                                 ASPEED_SCU_PROT_KEY, &error_abort);
     }
     connect_serial_hds_to_uarts(bmc);
-    qdev_realize(DEVICE(&bmc->soc), NULL, &error_abort);
+    qdev_realize(DEVICE(bmc->soc), NULL, &error_abort);
 
     if (defaults_enabled()) {
-        aspeed_board_init_flashes(&bmc->soc.fmc,
+        aspeed_board_init_flashes(&bmc->soc->fmc,
                               bmc->fmc_model ? bmc->fmc_model : amc->fmc_model,
                               amc->num_cs, 0);
-        aspeed_board_init_flashes(&bmc->soc.spi[0],
+        aspeed_board_init_flashes(&bmc->soc->spi[0],
                               bmc->spi_model ? bmc->spi_model : amc->spi_model,
                               1, amc->num_cs);
     }
@@ -426,22 +427,22 @@ static void aspeed_machine_init(MachineState *machine)
         amc->i2c_init(bmc);
     }
 
-    for (i = 0; i < bmc->soc.sdhci.num_slots; i++) {
-        sdhci_attach_drive(&bmc->soc.sdhci.slots[i],
+    for (i = 0; i < bmc->soc->sdhci.num_slots; i++) {
+        sdhci_attach_drive(&bmc->soc->sdhci.slots[i],
                            drive_get(IF_SD, 0, i));
     }
 
-    if (bmc->soc.emmc.num_slots) {
-        sdhci_attach_drive(&bmc->soc.emmc.slots[0],
-                           drive_get(IF_SD, 0, bmc->soc.sdhci.num_slots));
+    if (bmc->soc->emmc.num_slots) {
+        sdhci_attach_drive(&bmc->soc->emmc.slots[0],
+                           drive_get(IF_SD, 0, bmc->soc->sdhci.num_slots));
     }
 
     if (!bmc->mmio_exec) {
-        DeviceState *dev = ssi_get_cs(bmc->soc.fmc.spi, 0);
+        DeviceState *dev = ssi_get_cs(bmc->soc->fmc.spi, 0);
         BlockBackend *fmc0 = dev ? m25p80_get_blk(dev) : NULL;
 
         if (fmc0) {
-            uint64_t rom_size = memory_region_size(&bmc->soc.spi_boot);
+            uint64_t rom_size = memory_region_size(&bmc->soc->spi_boot);
             aspeed_install_boot_rom(bmc, fmc0, rom_size);
         }
     }
@@ -451,7 +452,7 @@ static void aspeed_machine_init(MachineState *machine)
 
 static void palmetto_bmc_i2c_init(AspeedMachineState *bmc)
 {
-    AspeedSoCState *soc = &bmc->soc;
+    AspeedSoCState *soc = bmc->soc;
     DeviceState *dev;
     uint8_t *eeprom_buf = g_malloc0(32 * 1024);
 
@@ -473,7 +474,7 @@ static void palmetto_bmc_i2c_init(AspeedMachineState *bmc)
 
 static void quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
 {
-    AspeedSoCState *soc = &bmc->soc;
+    AspeedSoCState *soc = bmc->soc;
 
     /*
      * The quanta-q71l platform expects tmp75s which are compatible with
@@ -505,7 +506,7 @@ static void quanta_q71l_bmc_i2c_init(AspeedMachineState *bmc)
 
 static void ast2500_evb_i2c_init(AspeedMachineState *bmc)
 {
-    AspeedSoCState *soc = &bmc->soc;
+    AspeedSoCState *soc = bmc->soc;
     uint8_t *eeprom_buf = g_malloc0(8 * 1024);
 
     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 3), 0x50,
@@ -518,7 +519,7 @@ static void ast2500_evb_i2c_init(AspeedMachineState *bmc)
 
 static void ast2600_evb_i2c_init(AspeedMachineState *bmc)
 {
-    AspeedSoCState *soc = &bmc->soc;
+    AspeedSoCState *soc = bmc->soc;
     uint8_t *eeprom_buf = g_malloc0(8 * 1024);
 
     smbus_eeprom_init_one(aspeed_i2c_get_bus(&soc->i2c, 7), 0x50,
@@ -531,7 +532,7 @@ static void ast2600_evb_i2c_init(AspeedMachineState *bmc)
 
 static void yosemitev2_bmc_i2c_init(AspeedMachineState *bmc)
 {
-    AspeedSoCState *soc = &bmc->soc;
+    AspeedSoCState *soc = bmc->soc;
 
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 4), 0x51, 128 * KiB);
     at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 8), 0x51, 128 * KiB,
@@ -545,7 +546,7 @@ static void yosemitev2_bmc_i2c_init(AspeedMachineState *bmc)
 
 static void romulus_bmc_i2c_init(AspeedMachineState *bmc)
 {
-    AspeedSoCState *soc = &bmc->soc;
+    AspeedSoCState *soc = bmc->soc;
 
     /* The romulus board expects Epson RX8900 I2C RTC but a ds1338 is
      * good enough */
@@ -554,7 +555,7 @@ static void romulus_bmc_i2c_init(AspeedMachineState *bmc)
 
 static void tiogapass_bmc_i2c_init(AspeedMachineState *bmc)
 {
-    AspeedSoCState *soc = &bmc->soc;
+    AspeedSoCState *soc = bmc->soc;
 
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 4), 0x54, 128 * KiB);
     at24c_eeprom_init_rom(aspeed_i2c_get_bus(&soc->i2c, 6), 0x54, 128 * KiB,
@@ -573,7 +574,7 @@ static void create_pca9552(AspeedSoCState *soc, int bus_id, int addr)
 
 static void sonorapass_bmc_i2c_init(AspeedMachineState *bmc)
 {
-    AspeedSoCState *soc = &bmc->soc;
+    AspeedSoCState *soc = bmc->soc;
 
     /* bus 2 : */
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 2), "tmp105", 0x48);
@@ -627,7 +628,7 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
         {14, LED_COLOR_GREEN, "front-power-3",  GPIO_POLARITY_ACTIVE_LOW},
         {15, LED_COLOR_GREEN, "front-id-5",     GPIO_POLARITY_ACTIVE_LOW},
     };
-    AspeedSoCState *soc = &bmc->soc;
+    AspeedSoCState *soc = bmc->soc;
     uint8_t *eeprom_buf = g_malloc0(8 * 1024);
     DeviceState *dev;
     LEDState *led;
@@ -672,7 +673,7 @@ static void witherspoon_bmc_i2c_init(AspeedMachineState *bmc)
 
 static void g220a_bmc_i2c_init(AspeedMachineState *bmc)
 {
-    AspeedSoCState *soc = &bmc->soc;
+    AspeedSoCState *soc = bmc->soc;
     DeviceState *dev;
 
     dev = DEVICE(i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 3),
@@ -708,7 +709,7 @@ static void g220a_bmc_i2c_init(AspeedMachineState *bmc)
 
 static void fp5280g2_bmc_i2c_init(AspeedMachineState *bmc)
 {
-    AspeedSoCState *soc = &bmc->soc;
+    AspeedSoCState *soc = bmc->soc;
     I2CSlave *i2c_mux;
 
     /* The at24c256 */
@@ -735,7 +736,7 @@ static void fp5280g2_bmc_i2c_init(AspeedMachineState *bmc)
 
 static void rainier_bmc_i2c_init(AspeedMachineState *bmc)
 {
-    AspeedSoCState *soc = &bmc->soc;
+    AspeedSoCState *soc = bmc->soc;
     I2CSlave *i2c_mux;
 
     at24c_eeprom_init(aspeed_i2c_get_bus(&soc->i2c, 0), 0x51, 32 * KiB);
@@ -852,7 +853,7 @@ static void get_pca9548_channels(I2CBus *bus, uint8_t mux_addr,
 
 static void fuji_bmc_i2c_init(AspeedMachineState *bmc)
 {
-    AspeedSoCState *soc = &bmc->soc;
+    AspeedSoCState *soc = bmc->soc;
     I2CBus *i2c[144] = {};
 
     for (int i = 0; i < 16; i++) {
@@ -930,7 +931,7 @@ static void fuji_bmc_i2c_init(AspeedMachineState *bmc)
 
 static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)
 {
-    AspeedSoCState *soc = &bmc->soc;
+    AspeedSoCState *soc = bmc->soc;
     I2CBus *i2c[13] = {};
     for (int i = 0; i < 13; i++) {
         if ((i == 8) || (i == 11)) {
@@ -976,7 +977,7 @@ static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)
 
 static void fby35_i2c_init(AspeedMachineState *bmc)
 {
-    AspeedSoCState *soc = &bmc->soc;
+    AspeedSoCState *soc = bmc->soc;
     I2CBus *i2c[16];
 
     for (int i = 0; i < 16; i++) {
@@ -1008,14 +1009,14 @@ static void fby35_i2c_init(AspeedMachineState *bmc)
 
 static void qcom_dc_scm_bmc_i2c_init(AspeedMachineState *bmc)
 {
-    AspeedSoCState *soc = &bmc->soc;
+    AspeedSoCState *soc = bmc->soc;
 
     i2c_slave_create_simple(aspeed_i2c_get_bus(&soc->i2c, 15), "tmp105", 0x4d);
 }
 
 static void qcom_dc_scm_firework_i2c_init(AspeedMachineState *bmc)
 {
-    AspeedSoCState *soc = &bmc->soc;
+    AspeedSoCState *soc = bmc->soc;
     I2CSlave *therm_mux, *cpuvr_mux;
 
     /* Create the generic DC-SCM hardware */
@@ -1477,7 +1478,7 @@ static void aspeed_machine_bletchley_class_init(ObjectClass *oc, void *data)
 static void fby35_reset(MachineState *state, ShutdownCause reason)
 {
     AspeedMachineState *bmc = ASPEED_MACHINE(state);
-    AspeedGPIOState *gpio = &bmc->soc.gpio;
+    AspeedGPIOState *gpio = &bmc->soc->gpio;
 
     qemu_devices_reset(reason);
 
@@ -1528,24 +1529,26 @@ static void aspeed_minibmc_machine_init(MachineState *machine)
     sysclk = clock_new(OBJECT(machine), "SYSCLK");
     clock_set_hz(sysclk, SYSCLK_FRQ);
 
-    object_initialize_child(OBJECT(machine), "soc", &bmc->soc, amc->soc_name);
-    qdev_connect_clock_in(DEVICE(&bmc->soc), "sysclk", sysclk);
+    bmc->soc = ASPEED_SOC(object_new(amc->soc_name));
+    object_property_add_child(OBJECT(machine), "soc", OBJECT(bmc->soc));
+    object_unref(OBJECT(bmc->soc));
+    qdev_connect_clock_in(DEVICE(bmc->soc), "sysclk", sysclk);
 
-    object_property_set_link(OBJECT(&bmc->soc), "memory",
+    object_property_set_link(OBJECT(bmc->soc), "memory",
                              OBJECT(get_system_memory()), &error_abort);
     connect_serial_hds_to_uarts(bmc);
-    qdev_realize(DEVICE(&bmc->soc), NULL, &error_abort);
+    qdev_realize(DEVICE(bmc->soc), NULL, &error_abort);
 
-    aspeed_board_init_flashes(&bmc->soc.fmc,
+    aspeed_board_init_flashes(&bmc->soc->fmc,
                               bmc->fmc_model ? bmc->fmc_model : amc->fmc_model,
                               amc->num_cs,
                               0);
 
-    aspeed_board_init_flashes(&bmc->soc.spi[0],
+    aspeed_board_init_flashes(&bmc->soc->spi[0],
                               bmc->spi_model ? bmc->spi_model : amc->spi_model,
                               amc->num_cs, amc->num_cs);
 
-    aspeed_board_init_flashes(&bmc->soc.spi[1],
+    aspeed_board_init_flashes(&bmc->soc->spi[1],
                               bmc->spi_model ? bmc->spi_model : amc->spi_model,
                               amc->num_cs, (amc->num_cs * 2));
 
@@ -1561,7 +1564,7 @@ static void aspeed_minibmc_machine_init(MachineState *machine)
 
 static void ast1030_evb_i2c_init(AspeedMachineState *bmc)
 {
-    AspeedSoCState *soc = &bmc->soc;
+    AspeedSoCState *soc = bmc->soc;
 
     /* U10 24C08 connects to SDA/SCL Group 1 by default */
     uint8_t *eeprom_buf = g_malloc0(32 * 1024);
-- 
2.41.0


