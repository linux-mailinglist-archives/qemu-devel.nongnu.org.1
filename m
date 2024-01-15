Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3CF82DFE4
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 19:29:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPRhA-0007NK-29; Mon, 15 Jan 2024 13:28:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rPRh0-0007L4-H3; Mon, 15 Jan 2024 13:28:14 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rPRgt-0007UN-Ea; Mon, 15 Jan 2024 13:28:14 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1d3eb299e2eso53659595ad.2; 
 Mon, 15 Jan 2024 10:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705343283; x=1705948083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7K8Qcn/Qj0R6M+e5Wa7E2QBGxvAlYyOUgw4YrtEp4Oo=;
 b=KZhwq/ZUKYey61bftqag+4YHdFVVmzP7kt9t8Xbt5o1JKhDXbNV8AbRpWRM/jqsJfM
 8ERc4YpDVmdtTCrbVReKdKTmGK5d5G4DnZWzJRW9y7HUn/9MSXaMDai4C2y/eHANvjxC
 8c9HlmjYHvw25b8o6LRATTlo6Jx+VCP84sxJYGUJl7QrL1bEgJ8uDE776MCecEdk5z3M
 /dw+ugkJ9xfK+g1+/GbwFDwKwSC8xJOPighHsFjlupdYkwfEOho5gpOQQRdIWG5UgxDt
 N13ZiPQMnkCVr5CxoC3VeafE+pjrLFynC1713uUrI876fls0Z3rkEVhAvq4vlV/s7ufG
 UvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705343283; x=1705948083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7K8Qcn/Qj0R6M+e5Wa7E2QBGxvAlYyOUgw4YrtEp4Oo=;
 b=G7uGEmR2maIMsN2coouZGh0xZ7jIpVeAj8ryPUA5GkfaWRny6Lu9RQtgExC7/6hf7r
 WIM+W94vU58oa1lRteVHmCynIcJ/v7HC34HYevJvvAhDqEyJADlX11xc08zcEuBIE92r
 Of80CBt0eNVAzcsFgxQhzhsu/nAYCq++3IR1El9wXka9+XCnQ+LJffWzanD6VLQuF2Ba
 LpCb//R73dg5W7BbKHi4gwUo73i0noz3y8IK5k23DVJCcTdEeaD0nqHMaKniPeBwgtdS
 7J2RVCA+L8lTKgw56YL97vZuUNzefjYrpMSBidKlsi78JCzVOVtKAKYiXv3fhbIlI8nf
 /BvA==
X-Gm-Message-State: AOJu0Yz9IaHil+E17Ce2agKlI0yeOmlamYVJg0wvUBP/GQEcEaF44agX
 btTnMUdbIldmffqh+A9H6pc=
X-Google-Smtp-Source: AGHT+IG1i0FdrOrzPWtHgcQ/h8WpvyXmUO24WiI3Cz3ZcWcpGWMg/Y0OpL27MeIa8q4I0mFE1mct0w==
X-Received: by 2002:a17:902:c711:b0:1d3:77b0:39ab with SMTP id
 p17-20020a170902c71100b001d377b039abmr2539559plp.4.1705343283084; 
 Mon, 15 Jan 2024 10:28:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a1709029f8e00b001d5e03543dcsm58412plq.38.2024.01.15.10.28.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 10:28:02 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/3] hw/arm: Add AHCI/SATA controller to Allwinner R40 and
 Bananapi board
Date: Mon, 15 Jan 2024 10:27:56 -0800
Message-Id: <20240115182757.1095012-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240115182757.1095012-1-linux@roeck-us.net>
References: <20240115182757.1095012-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=groeck7@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Allwinner R40 supports an AHCI compliant SATA controller.
Add support for it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 docs/system/arm/bananapi_m2u.rst |  1 +
 hw/arm/Kconfig                   |  1 +
 hw/arm/allwinner-r40.c           | 12 +++++++++++-
 include/hw/arm/allwinner-r40.h   |  3 +++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/docs/system/arm/bananapi_m2u.rst b/docs/system/arm/bananapi_m2u.rst
index e77c425e2c..542310591d 100644
--- a/docs/system/arm/bananapi_m2u.rst
+++ b/docs/system/arm/bananapi_m2u.rst
@@ -22,6 +22,7 @@ The Banana Pi M2U machine supports the following devices:
  * EMAC ethernet
  * GMAC ethernet
  * Clock Control Unit
+ * SATA
  * TWI (I2C)
  * USB 2.0
 
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 6b508780d3..98ca5ebc7d 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -408,6 +408,7 @@ config ALLWINNER_H3
 config ALLWINNER_R40
     bool
     default y if TCG && ARM
+    select AHCI
     select ALLWINNER_SRAMC
     select ALLWINNER_A10_PIT
     select AXP2XX_PMU
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
index 2e8943eff7..534be4a735 100644
--- a/hw/arm/allwinner-r40.c
+++ b/hw/arm/allwinner-r40.c
@@ -46,6 +46,7 @@ const hwaddr allwinner_r40_memmap[] = {
     [AW_R40_DEV_MMC1]       = 0x01c10000,
     [AW_R40_DEV_MMC2]       = 0x01c11000,
     [AW_R40_DEV_MMC3]       = 0x01c12000,
+    [AW_R40_DEV_AHCI]       = 0x01c18000,
     [AW_R40_DEV_EHCI1]      = 0x01c19000,
     [AW_R40_DEV_OHCI1]      = 0x01c19400,
     [AW_R40_DEV_EHCI2]      = 0x01c1c000,
@@ -93,7 +94,6 @@ static struct AwR40Unimplemented r40_unimplemented[] = {
     { "usb0-host",  0x01c14000, 4 * KiB },
     { "crypto",     0x01c15000, 4 * KiB },
     { "spi2",       0x01c17000, 4 * KiB },
-    { "sata",       0x01c18000, 4 * KiB },
     { "usb1-phy",   0x01c19800, 2 * KiB },
     { "sid",        0x01c1b000, 4 * KiB },
     { "usb2-phy",   0x01c1c800, 2 * KiB },
@@ -186,6 +186,7 @@ enum {
     AW_R40_GIC_SPI_MMC2      = 34,
     AW_R40_GIC_SPI_MMC3      = 35,
     AW_R40_GIC_SPI_EMAC      = 55,
+    AW_R40_GIC_SPI_AHCI      = 56,
     AW_R40_GIC_SPI_OHCI1     = 64,
     AW_R40_GIC_SPI_OHCI2     = 65,
     AW_R40_GIC_SPI_EHCI1     = 76,
@@ -285,6 +286,8 @@ static void allwinner_r40_init(Object *obj)
                                 TYPE_AW_SDHOST_SUN50I_A64);
     }
 
+    object_initialize_child(obj, "sata", &s->sata, TYPE_ALLWINNER_AHCI);
+
     for (size_t i = 0; i < AW_R40_NUM_USB; i++) {
         object_initialize_child(obj, "ehci[*]", &s->ehci[i],
                                 TYPE_PLATFORM_EHCI);
@@ -423,6 +426,13 @@ static void allwinner_r40_realize(DeviceState *dev, Error **errp)
     sysbus_realize(SYS_BUS_DEVICE(&s->ccu), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(&s->ccu), 0, s->memmap[AW_R40_DEV_CCU]);
 
+    /* SATA / AHCI */
+    sysbus_realize(SYS_BUS_DEVICE(&s->sata), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->sata), 0,
+                    allwinner_r40_memmap[AW_R40_DEV_AHCI]);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sata), 0,
+                       qdev_get_gpio_in(DEVICE(&s->gic), AW_R40_GIC_SPI_AHCI));
+
     /* USB */
     for (size_t i = 0; i < AW_R40_NUM_USB; i++) {
         g_autofree char *bus = g_strdup_printf("usb-bus.%zu", i);
diff --git a/include/hw/arm/allwinner-r40.h b/include/hw/arm/allwinner-r40.h
index ae82822d42..c589fcc1c1 100644
--- a/include/hw/arm/allwinner-r40.h
+++ b/include/hw/arm/allwinner-r40.h
@@ -22,6 +22,7 @@
 
 #include "qom/object.h"
 #include "hw/timer/allwinner-a10-pit.h"
+#include "hw/ide/ahci.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/sd/allwinner-sdhost.h"
 #include "hw/misc/allwinner-r40-ccu.h"
@@ -46,6 +47,7 @@ enum {
     AW_R40_DEV_MMC1,
     AW_R40_DEV_MMC2,
     AW_R40_DEV_MMC3,
+    AW_R40_DEV_AHCI,
     AW_R40_DEV_EHCI1,
     AW_R40_DEV_OHCI1,
     AW_R40_DEV_EHCI2,
@@ -112,6 +114,7 @@ struct AwR40State {
     const hwaddr *memmap;
     AwSRAMCState sramc;
     AwA10PITState timer;
+    AllwinnerAHCIState sata;
     AwSdHostState mmc[AW_R40_NUM_MMCS];
     EHCISysBusState ehci[AW_R40_NUM_USB];
     OHCISysBusState ohci[AW_R40_NUM_USB];
-- 
2.39.2


