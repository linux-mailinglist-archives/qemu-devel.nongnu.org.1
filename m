Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8C9723E5F
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:52:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIv-0007nw-PH; Tue, 06 Jun 2023 05:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIj-0007e2-Vi
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:30 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIg-0004lQ-3E
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:28 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f6ffc2b314so50181245e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044904; x=1688636904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fLR9hUI8woa7efPg2ZYQ8fESGdaNwfiGqGU86pk99J8=;
 b=ZEweqSYRKMdzBX2cE5t6On8oxLBMbricfqINLN8dDSN6fvz1IeQEw76twoy+xQ4ZNy
 T7SrVA6Rk6IRCPBuumN8Bfz7qbsIvw6LWGtLD96oXJP4p/GR/H1o1n6HNjkU+tLn43hG
 sIHfqMdFfE0OBPciA48hxL+Xk3Ts4psjTPrUGkWXxUmf8w0YSyPRpFhBwXQBIl5Mrg75
 Kd9XBgy6varvhiKWPq1EaluzaZzpUbGFk0TqPG1H++glsV7l/nnsOSAnGY/XuptABtr7
 Bzqzj7i8Pcr2TRQkOk1UPZYSZOMxvFXUJn/Bg/RFl1X2aHEouBkkwJwAAOywvnL6vsB+
 03ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044904; x=1688636904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fLR9hUI8woa7efPg2ZYQ8fESGdaNwfiGqGU86pk99J8=;
 b=RaAQ453MadN5Q6PjM3jPvGZDBxdhXNGgJf5xVmMDo4BhbHKUFUuytYtT1SldsizsN1
 63W7bIWG+6F8IjFqCPk9N0VS+lgCXztHu8DtfUXjPgdzk5R9rTQQYVUiqeLJ4KtcASFv
 MkydGDCqoFN31CbSJK28Boj7sYGX4HvkP+XxNPT8uNMAfzPn4witWgAKU69GNgnHPfCY
 XjkBXz+WxusonnLGxqjKbe8yfmmzOe5Xq35c2e1C0XHjCxdx0CrqmWxirXcXcu4AT9Er
 olKUVuXF4N9O7eftxk7JXzLEss71AGbqwxGAyi17GmjZ2qdAAlR/onZNUKBAkM2CYM1B
 Ehow==
X-Gm-Message-State: AC+VfDyqJcahcRmNGYbYEKsU/kpI0M9cuispXdjODXKfCxq/J71L/YlL
 P2Lxc2AGDUvS0TEvaIPpntIFAnJo93fHrpYIUR8=
X-Google-Smtp-Source: ACHHUZ5SPHloJGZNPtgGHxO7mDTSSybZwB3gxwi5R/yr28I8eJI5OcEuS41qz3YrWCs97xZE04wyfQ==
X-Received: by 2002:a7b:cd0d:0:b0:3f6:1ac:5feb with SMTP id
 f13-20020a7bcd0d000000b003f601ac5febmr1384172wmj.16.1686044904082; 
 Tue, 06 Jun 2023 02:48:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/42] hw: arm: allwinner-r40: Add emac and gmac support
Date: Tue,  6 Jun 2023 10:47:48 +0100
Message-Id: <20230606094814.3581397-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: qianfan Zhao <qianfanguijin@163.com>

R40 has two ethernet controllers named as emac and gmac. The emac is
compatibled with A10, and the GMAC is compatibled with H3.

Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/allwinner-r40.h |  6 ++++
 hw/arm/allwinner-r40.c         | 50 ++++++++++++++++++++++++++++++++--
 hw/arm/bananapi_m2u.c          |  3 ++
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/allwinner-r40.h b/include/hw/arm/allwinner-r40.h
index 8243e8903b1..5f2d08489eb 100644
--- a/include/hw/arm/allwinner-r40.h
+++ b/include/hw/arm/allwinner-r40.h
@@ -28,6 +28,8 @@
 #include "hw/misc/allwinner-r40-ccu.h"
 #include "hw/misc/allwinner-r40-dramc.h"
 #include "hw/i2c/allwinner-i2c.h"
+#include "hw/net/allwinner_emac.h"
+#include "hw/net/allwinner-sun8i-emac.h"
 #include "target/arm/cpu.h"
 #include "sysemu/block-backend.h"
 
@@ -36,6 +38,7 @@ enum {
     AW_R40_DEV_SRAM_A2,
     AW_R40_DEV_SRAM_A3,
     AW_R40_DEV_SRAM_A4,
+    AW_R40_DEV_EMAC,
     AW_R40_DEV_MMC0,
     AW_R40_DEV_MMC1,
     AW_R40_DEV_MMC2,
@@ -51,6 +54,7 @@ enum {
     AW_R40_DEV_UART6,
     AW_R40_DEV_UART7,
     AW_R40_DEV_TWI0,
+    AW_R40_DEV_GMAC,
     AW_R40_DEV_GIC_DIST,
     AW_R40_DEV_GIC_CPU,
     AW_R40_DEV_GIC_HYP,
@@ -103,6 +107,8 @@ struct AwR40State {
     AwR40ClockCtlState ccu;
     AwR40DramCtlState dramc;
     AWI2CState i2c0;
+    AwEmacState emac;
+    AwSun8iEmacState gmac;
     GICState gic;
     MemoryRegion sram_a1;
     MemoryRegion sram_a2;
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index b148c564498..c018ad231ad 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -39,6 +39,7 @@ const hwaddr allwinner_r40_memmap[] = {
     [AW_R40_DEV_SRAM_A2]    = 0x00004000,
     [AW_R40_DEV_SRAM_A3]    = 0x00008000,
     [AW_R40_DEV_SRAM_A4]    = 0x0000b400,
+    [AW_R40_DEV_EMAC]       = 0x01c0b000,
     [AW_R40_DEV_MMC0]       = 0x01c0f000,
     [AW_R40_DEV_MMC1]       = 0x01c10000,
     [AW_R40_DEV_MMC2]       = 0x01c11000,
@@ -54,6 +55,7 @@ const hwaddr allwinner_r40_memmap[] = {
     [AW_R40_DEV_UART6]      = 0x01c29800,
     [AW_R40_DEV_UART7]      = 0x01c29c00,
     [AW_R40_DEV_TWI0]       = 0x01c2ac00,
+    [AW_R40_DEV_GMAC]       = 0x01c50000,
     [AW_R40_DEV_DRAMCOM]    = 0x01c62000,
     [AW_R40_DEV_DRAMCTL]    = 0x01c63000,
     [AW_R40_DEV_DRAMPHY]    = 0x01c65000,
@@ -82,7 +84,6 @@ static struct AwR40Unimplemented r40_unimplemented[] = {
     { "spi1",       0x01c06000, 4 * KiB },
     { "cs0",        0x01c09000, 4 * KiB },
     { "keymem",     0x01c0a000, 4 * KiB },
-    { "emac",       0x01c0b000, 4 * KiB },
     { "usb0-otg",   0x01c13000, 4 * KiB },
     { "usb0-host",  0x01c14000, 4 * KiB },
     { "crypto",     0x01c15000, 4 * KiB },
@@ -131,7 +132,6 @@ static struct AwR40Unimplemented r40_unimplemented[] = {
     { "tvd2",       0x01c33000, 4 * KiB },
     { "tvd3",       0x01c34000, 4 * KiB },
     { "gpu",        0x01c40000, 64 * KiB },
-    { "gmac",       0x01c50000, 64 * KiB },
     { "hstmr",      0x01c60000, 4 * KiB },
     { "tcon-top",   0x01c70000, 4 * KiB },
     { "lcd0",       0x01c71000, 4 * KiB },
@@ -180,6 +180,8 @@ enum {
     AW_R40_GIC_SPI_MMC1      = 33,
     AW_R40_GIC_SPI_MMC2      = 34,
     AW_R40_GIC_SPI_MMC3      = 35,
+    AW_R40_GIC_SPI_EMAC      = 55,
+    AW_R40_GIC_SPI_GMAC      = 85,
 };
 
 /* Allwinner R40 general constants */
@@ -276,6 +278,11 @@ static void allwinner_r40_init(Object *obj)
 
     object_initialize_child(obj, "twi0", &s->i2c0, TYPE_AW_I2C_SUN6I);
 
+    object_initialize_child(obj, "emac", &s->emac, TYPE_AW_EMAC);
+    object_initialize_child(obj, "gmac", &s->gmac, TYPE_AW_SUN8I_EMAC);
+    object_property_add_alias(obj, "gmac-phy-addr",
+                              OBJECT(&s->gmac), "phy-addr");
+
     object_initialize_child(obj, "dramc", &s->dramc, TYPE_AW_R40_DRAMC);
     object_property_add_alias(obj, "ram-addr", OBJECT(&s->dramc),
                              "ram-addr");
@@ -285,6 +292,7 @@ static void allwinner_r40_init(Object *obj)
 
 static void allwinner_r40_realize(DeviceState *dev, Error **errp)
 {
+    const char *r40_nic_models[] = { "gmac", "emac", NULL };
     AwR40State *s = AW_R40(dev);
     unsigned i;
 
@@ -442,6 +450,44 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 2,
                     s->memmap[AW_R40_DEV_DRAMPHY]);
 
+    /* nic support gmac and emac */
+    for (int i = 0; i < ARRAY_SIZE(r40_nic_models) - 1; i++) {
+        NICInfo *nic = &nd_table[i];
+
+        if (!nic->used) {
+            continue;
+        }
+        if (qemu_show_nic_models(nic->model, r40_nic_models)) {
+            exit(0);
+        }
+
+        switch (qemu_find_nic_model(nic, r40_nic_models, r40_nic_models[0])) {
+        case 0: /* gmac */
+            qdev_set_nic_properties(DEVICE(&s->gmac), nic);
+            break;
+        case 1: /* emac */
+            qdev_set_nic_properties(DEVICE(&s->emac), nic);
+            break;
+        default:
+            exit(1);
+            break;
+        }
+    }
+
+    /* GMAC */
+    object_property_set_link(OBJECT(&s->gmac), "dma-memory",
+                                     OBJECT(get_system_memory()), &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->gmac), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gmac), 0, s->memmap[AW_R40_DEV_GMAC]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gmac), 0,
+                       qdev_get_gpio_in(DEVICE(&s->gic), AW_R40_GIC_SPI_GMAC));
+
+    /* EMAC */
+    sysbus_realize(SYS_BUS_DEVICE(&s->emac), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->emac), 0, s->memmap[AW_R40_DEV_EMAC]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->emac), 0,
+                       qdev_get_gpio_in(DEVICE(&s->gic), AW_R40_GIC_SPI_EMAC));
+
     /* Unimplemented devices */
     for (i = 0; i < ARRAY_SIZE(r40_unimplemented); i++) {
         create_unimplemented_device(r40_unimplemented[i].device_name,
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 20a4550c688..74121d89660 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -92,6 +92,9 @@ static void bpim2u_init(MachineState *machine)
     object_property_set_int(OBJECT(r40), "ram-size",
                             r40->ram_size, &error_abort);
 
+    /* GMAC PHY */
+    object_property_set_uint(OBJECT(r40), "gmac-phy-addr", 1, &error_abort);
+
     /* Mark R40 object realized */
     qdev_realize(DEVICE(r40), NULL, &error_abort);
 
-- 
2.34.1


