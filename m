Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 672277A6BFF
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 22:05:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qigxq-00062k-4d; Tue, 19 Sep 2023 16:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3HeEJZQwKCjYfSTaZWklWXSfYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--nabihestefan.bounces.google.com>)
 id 1qiezG-0005Ag-KH
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:58:14 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3HeEJZQwKCjYfSTaZWklWXSfYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--nabihestefan.bounces.google.com>)
 id 1qieyu-00011m-5d
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 13:58:13 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-d818fb959f4so6233228276.1
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 10:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1695146269; x=1695751069; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=h/ep8eKQq045OJM9t70Pry3bsvbMg2yT0Bc0p3xCpNU=;
 b=wSIwRk+zBleVZM6k63vqLaI0Y412bJYksKtLzMWnRmhrmQBzSFQGQerLVC/0VAgxNe
 0Pi8rdFSiO20QAzw6Oi9g+ej0GlpNJfV4IsFslmcbQK9pdsW+Ifo8DQb0v/NMRbM1EUP
 9ImRUJ8RET+xtuCUmHJKI/oRg26Cmj1iG2tw5N+fBlQ9hXUAdZKNrPRojMeF8ka3D7cm
 PscHxMVpJ95fEE9UQdGwl67PEuSYkFJJjuoe80/IKCLWy5sZbS8EQ8ZRW+WcF33J2/KD
 8B/z6/Y0AQEL3dFvMp53qzhsifDD9t5wPBaAHVfsIS+WYDlaQKekhmve25qkjD/WenX9
 iZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146269; x=1695751069;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h/ep8eKQq045OJM9t70Pry3bsvbMg2yT0Bc0p3xCpNU=;
 b=pP+9CpxJaubB9gahZpXX0jklGiYeSyIL0uBeLxFT1Z0IUJN462X0/GN4O1RCCogzR3
 SKycnV7bh+VNSXr7QsiiKdk+cO7sGH9I8zDsLJ0psjAWA3fKOohpkneNSBlONDrmcCxx
 OZDPSNI9QQonM9F+eoANZrVnzmF7tk3e1p0vVQYei9Kp4pagwZQaTL4NRK4buOSRzS23
 vamnada/CaR2+RnHmBjk3HCOolHs0kggPiF1kfOY4uMBasOs1hdzsZFeKXZ00pH6wHZl
 kux8ezjbwqyyworUTTERUrqx64Tdtw1g5aEHuwp+nxdMNV9uyyc1HMVt3BafXPs0+LCb
 dnCg==
X-Gm-Message-State: AOJu0YxJumdD4Sc2MfC9aiL+kSK+M3kYnVV+xsG3Nxk+IJxZFa/p7C7u
 YQH6VF3DcEcF+clNk9VkCd7TsUQUazHXy3Hvenc=
X-Google-Smtp-Source: AGHT+IFLwfBrVD9Jg78+o4gajBSWx7FgL+lNXoFFnfdBzbjYKV38O5MD5z29LiTyuG9aTyhZBGPuogujR75x1JJbXrc=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a5b:dc5:0:b0:d81:6927:d806 with SMTP
 id t5-20020a5b0dc5000000b00d816927d806mr8909ybr.0.1695146269035; Tue, 19 Sep
 2023 10:57:49 -0700 (PDT)
Date: Tue, 19 Sep 2023 17:57:16 +0000
In-Reply-To: <20230919175725.3413108-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20230919175725.3413108-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230919175725.3413108-6-nabihestefan@google.com>
Subject: [PATCH 05/14] hw/net: Add NPCMXXX GMAC device
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, Avi.Fishman@nuvoton.com, 
 Nabih Estefan Diaz <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3HeEJZQwKCjYfSTaZWklWXSfYggYdW.UgeiWem-VWnWdfgfYfm.gjY@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 19 Sep 2023 16:04:51 -0400
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

From: Hao Wu <wuhaotsh@google.com>

This patch implements the basic registers of GMAC device. Actual network
communications are not supported yet.

Signed-off-by: Hao Wu <wuhaotsh@google.com>

include/hw: Fix type problem in NPCMGMACState

- Fix type problem in NPCMGMACState
- Fix Register Initalization which was breaking boot-up in driver
- Added trace for NPCM_GMAC reset
- Added nd_table to npcm8xx.c for GMAC bootup

Signed-off-by: Nabih Estefan Diaz <nabihestefan@google.com>

hw/net: Add BCM54612E PHY regs for GMAC

This patch adds default values for PHYs to make the driver happy.
The device is derived from an actual Izumi machine.

Signed-off-by: Hao Wu <wuhaotsh@google.com>

hw/net: change GMAC PHY regs to indicate link is up

This change makes NPCM GMAC module to use BCM54612E unconditionally
and make some fake PHY registers such that the kernel driver thinks
the link partner is up.

Tested:
The following message shows up with the change:
Broadcom BCM54612E stmmac-0:00: attached PHY driver [Broadcom BCM54612E] (mii_bus:phy_addr=stmmac-0:00, irq=POLL)
stmmaceth f0802000.eth eth0: Link is Up - 1Gbps/Full - flow control rx/tx

Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 hw/arm/npcm8xx.c           | 905 +++++++++++++++++++++++++++++++++++++
 hw/net/meson.build         |   3 +-
 hw/net/npcm_gmac.c         | 395 ++++++++++++++++
 hw/net/trace-events        |  11 +
 include/hw/net/npcm_gmac.h | 172 +++++++
 5 files changed, 1485 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/npcm8xx.c
 create mode 100644 hw/net/npcm_gmac.c
 create mode 100644 include/hw/net/npcm_gmac.h

diff --git a/hw/arm/npcm8xx.c b/hw/arm/npcm8xx.c
new file mode 100644
index 0000000000..a05dcfed5c
--- /dev/null
+++ b/hw/arm/npcm8xx.c
@@ -0,0 +1,905 @@
+/*
+ * Nuvoton NPCM8xx SoC family.
+ *
+ * Copyright 2022 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/arm/boot.h"
+#include "hw/arm/npcm8xx.h"
+#include "hw/char/serial.h"
+#include "hw/intc/arm_gic.h"
+#include "hw/loader.h"
+#include "hw/misc/unimp.h"
+#include "hw/qdev-clock.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "qemu/units.h"
+#include "sysemu/sysemu.h"
+
+#define ARM_PHYS_TIMER_PPI  30
+#define ARM_VIRT_TIMER_PPI  27
+#define ARM_HYP_TIMER_PPI   26
+#define ARM_SEC_TIMER_PPI   29
+
+/*
+ * This covers the whole MMIO space. We'll use this to catch any MMIO accesses
+ * that aren't handled by a device.
+ */
+#define NPCM8XX_MMIO_BA         (0x80000000)
+#define NPCM8XX_MMIO_SZ         (0x7ffd0000)
+
+/* OTP fuse array */
+#define NPCM8XX_OTP_BA          (0xf0189000)
+
+/* GIC Distributor */
+#define NPCM8XX_GICD_BA         (0xdfff9000)
+#define NPCM8XX_GICC_BA         (0xdfffa000)
+
+/* Core system modules. */
+#define NPCM8XX_CPUP_BA         (0xf03fe000)
+#define NPCM8XX_GCR_BA          (0xf0800000)
+#define NPCM8XX_CLK_BA          (0xf0801000)
+#define NPCM8XX_MC_BA           (0xf0824000)
+#define NPCM8XX_RNG_BA          (0xf000b000)
+#define NPCM8XX_KCS_BA          (0xf0007000)
+#define NPCM8XX_PECI_BA         (0xf0100000)
+#define NPCM8XX_PCIERC_BA       (0xe1000000)
+#define NPCM8XX_PCIE_ROOT_BA    (0xe8000000)
+
+/* ADC Module */
+#define NPCM8XX_ADC_BA          (0xf000c000)
+
+/* Internal AHB SRAM */
+#define NPCM8XX_RAM3_BA         (0xc0008000)
+#define NPCM8XX_RAM3_SZ         (4 * KiB)
+
+/* Memory blocks at the end of the address space */
+#define NPCM8XX_RAM2_BA         (0xfffb0000)
+#define NPCM8XX_RAM2_SZ         (256 * KiB)
+#define NPCM8XX_ROM_BA          (0xffff0100)
+#define NPCM8XX_ROM_SZ          (64 * KiB)
+
+/* SDHCI Modules */
+#define NPCM8XX_MMC_BA          (0xf0842000)
+
+/* PCS Module */
+#define NPCM8XX_PCS_BA          (0xf0780000)
+
+/* Run PLL1 at 1600 MHz */
+#define NPCM8XX_PLLCON1_FIXUP_VAL   (0x00402101)
+/* Run the CPU from PLL1 and UART from PLL2 */
+#define NPCM8XX_CLKSEL_FIXUP_VAL    (0x004aaba9)
+
+/* Clock configuration values to be fixed up when bypassing bootloader */
+
+/*
+ * Interrupt lines going into the GIC. This does not include internal Cortex-A9
+ * interrupts.
+ */
+enum NPCM8xxInterrupt {
+    NPCM8XX_ADC_IRQ             = 0,
+    NPCM8XX_PECI_IRQ            = 6,
+    NPCM8XX_KCS_HIB_IRQ         = 9,
+    NPCM8XX_GMAC1_IRQ           = 14,
+    NPCM8XX_GMAC2_IRQ,
+    NPCM8XX_GMAC3_IRQ,
+    NPCM8XX_GMAC4_IRQ,
+    NPCM8XX_MMC_IRQ             = 26,
+    NPCM8XX_TIMER0_IRQ          = 32,   /* Timer Module 0 */
+    NPCM8XX_TIMER1_IRQ,
+    NPCM8XX_TIMER2_IRQ,
+    NPCM8XX_TIMER3_IRQ,
+    NPCM8XX_TIMER4_IRQ,
+    NPCM8XX_TIMER5_IRQ,                 /* Timer Module 1 */
+    NPCM8XX_TIMER6_IRQ,
+    NPCM8XX_TIMER7_IRQ,
+    NPCM8XX_TIMER8_IRQ,
+    NPCM8XX_TIMER9_IRQ,
+    NPCM8XX_TIMER10_IRQ,                /* Timer Module 2 */
+    NPCM8XX_TIMER11_IRQ,
+    NPCM8XX_TIMER12_IRQ,
+    NPCM8XX_TIMER13_IRQ,
+    NPCM8XX_TIMER14_IRQ,
+    NPCM8XX_WDG0_IRQ            = 47,   /* Timer Module 0 Watchdog */
+    NPCM8XX_WDG1_IRQ,                   /* Timer Module 1 Watchdog */
+    NPCM8XX_WDG2_IRQ,                   /* Timer Module 2 Watchdog */
+    NPCM8XX_EHCI1_IRQ           = 61,
+    NPCM8XX_OHCI1_IRQ,
+    NPCM8XX_EHCI2_IRQ,
+    NPCM8XX_OHCI2_IRQ,
+    NPCM8XX_PWM0_IRQ            = 93,   /* PWM module 0 */
+    NPCM8XX_PWM1_IRQ,                   /* PWM module 1 */
+    NPCM8XX_MFT0_IRQ            = 96,   /* MFT module 0 */
+    NPCM8XX_MFT1_IRQ,                   /* MFT module 1 */
+    NPCM8XX_MFT2_IRQ,                   /* MFT module 2 */
+    NPCM8XX_MFT3_IRQ,                   /* MFT module 3 */
+    NPCM8XX_MFT4_IRQ,                   /* MFT module 4 */
+    NPCM8XX_MFT5_IRQ,                   /* MFT module 5 */
+    NPCM8XX_MFT6_IRQ,                   /* MFT module 6 */
+    NPCM8XX_MFT7_IRQ,                   /* MFT module 7 */
+    NPCM8XX_PCI_MBOX1_IRQ       = 105,
+    NPCM8XX_PCI_MBOX2_IRQ,
+    NPCM8XX_GPIO0_IRQ           = 116,
+    NPCM8XX_GPIO1_IRQ,
+    NPCM8XX_GPIO2_IRQ,
+    NPCM8XX_GPIO3_IRQ,
+    NPCM8XX_GPIO4_IRQ,
+    NPCM8XX_GPIO5_IRQ,
+    NPCM8XX_GPIO6_IRQ,
+    NPCM8XX_GPIO7_IRQ,
+    NPCM8XX_PCIE_RC_IRQ         = 127,
+    NPCM8XX_SMBUS0_IRQ          = 128,
+    NPCM8XX_SMBUS1_IRQ,
+    NPCM8XX_SMBUS2_IRQ,
+    NPCM8XX_SMBUS3_IRQ,
+    NPCM8XX_SMBUS4_IRQ,
+    NPCM8XX_SMBUS5_IRQ,
+    NPCM8XX_SMBUS6_IRQ,
+    NPCM8XX_SMBUS7_IRQ,
+    NPCM8XX_SMBUS8_IRQ,
+    NPCM8XX_SMBUS9_IRQ,
+    NPCM8XX_SMBUS10_IRQ,
+    NPCM8XX_SMBUS11_IRQ,
+    NPCM8XX_SMBUS12_IRQ,
+    NPCM8XX_SMBUS13_IRQ,
+    NPCM8XX_SMBUS14_IRQ,
+    NPCM8XX_SMBUS15_IRQ,
+    NPCM8XX_SMBUS16_IRQ,
+    NPCM8XX_SMBUS17_IRQ,
+    NPCM8XX_SMBUS18_IRQ,
+    NPCM8XX_SMBUS19_IRQ,
+    NPCM8XX_SMBUS20_IRQ,
+    NPCM8XX_SMBUS21_IRQ,
+    NPCM8XX_SMBUS22_IRQ,
+    NPCM8XX_SMBUS23_IRQ,
+    NPCM8XX_SMBUS24_IRQ,
+    NPCM8XX_SMBUS25_IRQ,
+    NPCM8XX_SMBUS26_IRQ,
+    NPCM8XX_UART0_IRQ           = 192,
+    NPCM8XX_UART1_IRQ,
+    NPCM8XX_UART2_IRQ,
+    NPCM8XX_UART3_IRQ,
+    NPCM8XX_UART4_IRQ,
+    NPCM8XX_UART5_IRQ,
+    NPCM8XX_UART6_IRQ,
+};
+
+/* Total number of GIC interrupts, including internal Cortex-A35 interrupts. */
+#define NPCM8XX_NUM_IRQ         (288)
+#define NPCM8XX_PPI_BASE(cpu)   ((NPCM8XX_NUM_IRQ - 32) + (cpu) * 32)
+
+/* Register base address for each Timer Module */
+static const hwaddr npcm8xx_tim_addr[] = {
+    0xf0008000,
+    0xf0009000,
+    0xf000a000,
+};
+
+/* Register base address for each 16550 UART */
+static const hwaddr npcm8xx_uart_addr[] = {
+    0xf0000000,
+    0xf0001000,
+    0xf0002000,
+    0xf0003000,
+    0xf0004000,
+    0xf0005000,
+    0xf0006000,
+};
+
+/* Direct memory-mapped access to SPI0 CS0-1. */
+static const hwaddr npcm8xx_fiu0_flash_addr[] = {
+    0x80000000, /* CS0 */
+    0x88000000, /* CS1 */
+};
+
+/* Direct memory-mapped access to SPI1 CS0-3. */
+static const hwaddr npcm8xx_fiu1_flash_addr[] = {
+    0x90000000, /* CS0 */
+    0x91000000, /* CS1 */
+    0x92000000, /* CS2 */
+    0x93000000, /* CS3 */
+};
+
+/* Direct memory-mapped access to SPI3 CS0-3. */
+static const hwaddr npcm8xx_fiu3_flash_addr[] = {
+    0xa0000000, /* CS0 */
+    0xa8000000, /* CS1 */
+    0xb0000000, /* CS2 */
+    0xb8000000, /* CS3 */
+};
+
+/* Register base address for each PWM Module */
+static const hwaddr npcm8xx_pwm_addr[] = {
+    0xf0103000,
+    0xf0104000,
+    0xf0105000,
+};
+
+/* Register base address for each MFT Module */
+static const hwaddr npcm8xx_mft_addr[] = {
+    0xf0180000,
+    0xf0181000,
+    0xf0182000,
+    0xf0183000,
+    0xf0184000,
+    0xf0185000,
+    0xf0186000,
+    0xf0187000,
+};
+
+/* Direct memory-mapped access to each SMBus Module. */
+static const hwaddr npcm8xx_smbus_addr[] = {
+    0xf0080000,
+    0xf0081000,
+    0xf0082000,
+    0xf0083000,
+    0xf0084000,
+    0xf0085000,
+    0xf0086000,
+    0xf0087000,
+    0xf0088000,
+    0xf0089000,
+    0xf008a000,
+    0xf008b000,
+    0xf008c000,
+    0xf008d000,
+    0xf008e000,
+    0xf008f000,
+    0xfff00000,
+    0xfff01000,
+    0xfff02000,
+    0xfff03000,
+    0xfff04000,
+    0xfff05000,
+    0xfff06000,
+    0xfff07000,
+    0xfff08000,
+    0xfff09000,
+    0xfff0a000,
+};
+
+/* Register base address for each GMAC Module */
+static const hwaddr npcm8xx_gmac_addr[] = {
+    0xf0802000,
+    0xf0804000,
+    0xf0806000,
+    0xf0808000,
+};
+
+/* Register base address for each USB host EHCI registers */
+static const hwaddr npcm8xx_ehci_addr[] = {
+    0xf0828100,
+    0xf082a100,
+};
+
+/* Register base address for each USB host OHCI registers */
+static const hwaddr npcm8xx_ohci_addr[] = {
+    0xf0829000,
+    0xf082b000,
+};
+
+/* Register base address for each PCI mailbox module */
+static const hwaddr npcm8xx_pci_mbox_addr[] = {
+    0xf0848000,
+    0xf0868000,
+};
+
+static const struct {
+    hwaddr regs_addr;
+    uint32_t reset_pu;
+    uint32_t reset_pd;
+    uint32_t reset_osrc;
+    uint32_t reset_odsc;
+} npcm8xx_gpio[] = {
+    {
+        .regs_addr = 0xf0010000,
+        .reset_pu = 0x00000300,
+        .reset_pd = 0x000f0000,
+    }, {
+        .regs_addr = 0xf0011000,
+        .reset_pu = 0xe0fefe01,
+        .reset_pd = 0x07000000,
+    }, {
+        .regs_addr = 0xf0012000,
+        .reset_pu = 0xc00fffff,
+        .reset_pd = 0x3ff00000,
+    }, {
+        .regs_addr = 0xf0013000,
+        .reset_pd = 0x00003000,
+    }, {
+        .regs_addr = 0xf0014000,
+        .reset_pu = 0xffff0000,
+    }, {
+        .regs_addr = 0xf0015000,
+        .reset_pu = 0xff8387fe,
+        .reset_pd = 0x007c0001,
+        .reset_osrc = 0x08000000,
+    }, {
+        .regs_addr = 0xf0016000,
+        .reset_pu = 0x00000801,
+        .reset_pd = 0x00000302,
+    }, {
+        .regs_addr = 0xf0017000,
+        .reset_pu = 0x000002ff,
+        .reset_pd = 0x00000c00,
+    },
+};
+
+static const struct {
+    const char *name;
+    hwaddr regs_addr;
+    int cs_count;
+    const hwaddr *flash_addr;
+    size_t flash_size;
+} npcm8xx_fiu[] = {
+    {
+        .name = "fiu0",
+        .regs_addr = 0xfb000000,
+        .cs_count = ARRAY_SIZE(npcm8xx_fiu0_flash_addr),
+        .flash_addr = npcm8xx_fiu0_flash_addr,
+        .flash_size = 128 * MiB,
+    },
+    {
+        .name = "fiu1",
+        .regs_addr = 0xfb002000,
+        .cs_count = ARRAY_SIZE(npcm8xx_fiu1_flash_addr),
+        .flash_addr = npcm8xx_fiu1_flash_addr,
+        .flash_size = 16 * MiB,
+    }, {
+        .name = "fiu3",
+        .regs_addr = 0xc0000000,
+        .cs_count = ARRAY_SIZE(npcm8xx_fiu3_flash_addr),
+        .flash_addr = npcm8xx_fiu3_flash_addr,
+        .flash_size = 128 * MiB,
+    },
+};
+
+static struct arm_boot_info npcm8xx_binfo = {
+    .loader_start           = NPCM8XX_LOADER_START,
+    .smp_loader_start       = NPCM8XX_SMP_LOADER_START,
+    .smp_bootreg_addr       = NPCM8XX_SMP_BOOTREG_ADDR,
+    .gic_cpu_if_addr        = NPCM8XX_GICC_BA,
+    .secure_boot            = false,
+    .board_id               = -1,
+    .board_setup_addr       = NPCM8XX_BOARD_SETUP_ADDR,
+};
+
+void npcm8xx_load_kernel(MachineState *machine, NPCM8xxState *soc)
+{
+    npcm8xx_binfo.ram_size = machine->ram_size;
+
+    arm_load_kernel(&soc->cpu[0], machine, &npcm8xx_binfo);
+}
+
+static void npcm8xx_init_fuses(NPCM8xxState *s)
+{
+    NPCM8xxClass *nc = NPCM8XX_GET_CLASS(s);
+    uint32_t value;
+
+    /*
+     * The initial mask of disabled modules indicates the chip derivative (e.g.
+     * NPCM750 or NPCM730).
+     */
+    value = tswap32(nc->disabled_modules);
+    npcm7xx_otp_array_write(&s->fuse_array, &value, NPCM7XX_FUSE_DERIVATIVE,
+                            sizeof(value));
+}
+
+static void npcm8xx_write_adc_calibration(NPCM8xxState *s)
+{
+    /* Both ADC and the fuse array must have realized. */
+    QEMU_BUILD_BUG_ON(sizeof(s->adc.calibration_r_values) != 4);
+    npcm7xx_otp_array_write(&s->fuse_array, s->adc.calibration_r_values,
+            NPCM7XX_FUSE_ADC_CALIB, sizeof(s->adc.calibration_r_values));
+}
+
+static qemu_irq npcm8xx_irq(NPCM8xxState *s, int n)
+{
+    return qdev_get_gpio_in(DEVICE(&s->gic), n);
+}
+
+static void npcm8xx_init(Object *obj)
+{
+    NPCM8xxState *s = NPCM8XX(obj);
+    int i;
+
+    object_initialize_child(obj, "cpu-cluster", &s->cpu_cluster,
+                            TYPE_CPU_CLUSTER);
+    for (i = 0; i < NPCM8XX_MAX_NUM_CPUS; i++) {
+        object_initialize_child(OBJECT(&s->cpu_cluster), "cpu[*]", &s->cpu[i],
+                                ARM_CPU_TYPE_NAME("cortex-a53"));
+    }
+    object_initialize_child(obj, "gic", &s->gic, TYPE_ARM_GIC);
+    object_initialize_child(obj, "gcr", &s->gcr, TYPE_NPCM8XX_GCR);
+    object_property_add_alias(obj, "power-on-straps", OBJECT(&s->gcr),
+                              "power-on-straps");
+    object_initialize_child(obj, "clk", &s->clk, TYPE_NPCM8XX_CLK);
+    object_initialize_child(obj, "otp", &s->fuse_array,
+                            TYPE_NPCM7XX_FUSE_ARRAY);
+    object_initialize_child(obj, "mc", &s->mc, TYPE_NPCM7XX_MC);
+    object_initialize_child(obj, "rng", &s->rng, TYPE_NPCM7XX_RNG);
+    object_initialize_child(obj, "adc", &s->adc, TYPE_NPCM7XX_ADC);
+
+    for (i = 0; i < ARRAY_SIZE(s->tim); i++) {
+        object_initialize_child(obj, "tim[*]", &s->tim[i], TYPE_NPCM7XX_TIMER);
+    }
+
+    for (i = 0; i < ARRAY_SIZE(s->gpio); i++) {
+        object_initialize_child(obj, "gpio[*]", &s->gpio[i], TYPE_NPCM7XX_GPIO);
+    }
+
+    object_initialize_child(obj, "gpiotx", &s->gpiotx,
+                            TYPE_GOOGLE_GPIO_TRANSMITTER);
+
+    for (i = 0; i < ARRAY_SIZE(s->smbus); i++) {
+        object_initialize_child(obj, "smbus[*]", &s->smbus[i],
+                                TYPE_NPCM8XX_SMBUS);
+        DEVICE(&s->smbus[i])->id = g_strdup_printf("smbus[%d]", i);
+    }
+
+    object_initialize_child(obj, "kcs", &s->kcs, TYPE_NPCM7XX_KCS);
+
+    for (i = 0; i < ARRAY_SIZE(s->ehci); i++) {
+        object_initialize_child(obj, "ehci[*]", &s->ehci[i], TYPE_NPCM7XX_EHCI);
+    }
+    for (i = 0; i < ARRAY_SIZE(s->ohci); i++) {
+        object_initialize_child(obj, "ohci[*]", &s->ohci[i], TYPE_SYSBUS_OHCI);
+    }
+
+    QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm8xx_fiu) != ARRAY_SIZE(s->fiu));
+    for (i = 0; i < ARRAY_SIZE(s->fiu); i++) {
+        object_initialize_child(obj, npcm8xx_fiu[i].name, &s->fiu[i],
+                                TYPE_NPCM7XX_FIU);
+    }
+
+    for (i = 0; i < ARRAY_SIZE(s->pwm); i++) {
+        object_initialize_child(obj, "pwm[*]", &s->pwm[i], TYPE_NPCM7XX_PWM);
+    }
+
+    for (i = 0; i < ARRAY_SIZE(s->mft); i++) {
+        object_initialize_child(obj, "mft[*]", &s->mft[i], TYPE_NPCM7XX_MFT);
+    }
+
+    for (i = 0; i < ARRAY_SIZE(s->gmac); i++) {
+        object_initialize_child(obj, "gmac[*]", &s->gmac[i], TYPE_NPCM_GMAC);
+    }
+    object_initialize_child(obj, "pcs", &s->pcs, TYPE_NPCM_PCS);
+
+    for (i = 0; i < ARRAY_SIZE(s->pci_mbox); i++) {
+        object_initialize_child(obj, "pci-mbox[*]", &s->pci_mbox[i],
+                                TYPE_NPCM7XX_PCI_MBOX);
+    }
+    object_initialize_child(obj, "mmc", &s->mmc, TYPE_NPCM7XX_SDHCI);
+    object_initialize_child(obj, "peci", &s->peci, TYPE_NPCM7XX_PECI);
+    object_initialize_child(obj, "pcierc", &s->pcierc, TYPE_NPCM_PCIERC);
+}
+
+static void npcm8xx_realize(DeviceState *dev, Error **errp)
+{
+    NPCM8xxState *s = NPCM8XX(dev);
+    NPCM8xxClass *nc = NPCM8XX_GET_CLASS(s);
+    int i;
+
+    if (memory_region_size(s->dram) > NPCM8XX_DRAM_SZ) {
+        error_setg(errp, "%s: NPCM8xx cannot address more than %" PRIu64
+                   " MiB of DRAM", __func__, NPCM8XX_DRAM_SZ / MiB);
+        return;
+    }
+
+    /* CPUs */
+    for (i = 0; i < nc->num_cpus; i++) {
+        object_property_set_int(OBJECT(&s->cpu[i]), "mp-affinity",
+                                arm_cpu_mp_affinity(i, NPCM8XX_MAX_NUM_CPUS),
+                                &error_abort);
+        object_property_set_bool(OBJECT(&s->cpu[i]), "reset-hivecs", true,
+                                 &error_abort);
+        object_property_set_int(OBJECT(&s->cpu[i]), "core-count",
+                                nc->num_cpus, &error_abort);
+
+        /* Disable security extensions. */
+        object_property_set_bool(OBJECT(&s->cpu[i]), "has_el3", false,
+                                 &error_abort);
+
+        if (!qdev_realize(DEVICE(&s->cpu[i]), NULL, errp)) {
+            return;
+        }
+    }
+
+    /* ARM GIC for Cortex A35. Can only fail if we pass bad parameters here. */
+    object_property_set_uint(OBJECT(&s->gic), "num-cpu", nc->num_cpus, errp);
+    object_property_set_uint(OBJECT(&s->gic), "num-irq", NPCM8XX_NUM_IRQ, errp);
+    object_property_set_uint(OBJECT(&s->gic), "revision", 2, errp);
+    object_property_set_bool(OBJECT(&s->gic), "has-security-extensions", true,
+                             errp);
+    object_property_set_bool(OBJECT(&s->gic), "irq-reset-nonsecure", true,
+                             errp);
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
+        return;
+    }
+    for (i = 0; i < nc->num_cpus; i++) {
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i,
+                           qdev_get_gpio_in(DEVICE(&s->cpu[i]), ARM_CPU_IRQ));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i + nc->num_cpus,
+                           qdev_get_gpio_in(DEVICE(&s->cpu[i]), ARM_CPU_FIQ));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i + nc->num_cpus * 2,
+                           qdev_get_gpio_in(DEVICE(&s->cpu[i]), ARM_CPU_VIRQ));
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gic), i + nc->num_cpus * 3,
+                           qdev_get_gpio_in(DEVICE(&s->cpu[i]), ARM_CPU_VFIQ));
+
+        qdev_connect_gpio_out(DEVICE(&s->cpu[i]), GTIMER_PHYS,
+            qdev_get_gpio_in(DEVICE(&s->gic),
+                NPCM8XX_PPI_BASE(i) + ARM_PHYS_TIMER_PPI));
+        qdev_connect_gpio_out(DEVICE(&s->cpu[i]), GTIMER_VIRT,
+            qdev_get_gpio_in(DEVICE(&s->gic),
+                NPCM8XX_PPI_BASE(i) + ARM_VIRT_TIMER_PPI));
+        qdev_connect_gpio_out(DEVICE(&s->cpu[i]), GTIMER_HYP,
+            qdev_get_gpio_in(DEVICE(&s->gic),
+                NPCM8XX_PPI_BASE(i) + ARM_HYP_TIMER_PPI));
+        qdev_connect_gpio_out(DEVICE(&s->cpu[i]), GTIMER_SEC,
+            qdev_get_gpio_in(DEVICE(&s->gic),
+                NPCM8XX_PPI_BASE(i) + ARM_SEC_TIMER_PPI));
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 0, NPCM8XX_GICD_BA);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gic), 1, NPCM8XX_GICC_BA);
+
+    /* CPU cluster */
+    qdev_prop_set_uint32(DEVICE(&s->cpu_cluster), "cluster-id", 0);
+    qdev_realize(DEVICE(&s->cpu_cluster), NULL, &error_fatal);
+
+    /* System Global Control Registers (GCR). Can fail due to user input. */
+    object_property_set_int(OBJECT(&s->gcr), "disabled-modules",
+                            nc->disabled_modules, &error_abort);
+    object_property_add_const_link(OBJECT(&s->gcr), "dram-mr", OBJECT(s->dram));
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->gcr), errp)) {
+        return;
+    }
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gcr), 0, NPCM8XX_GCR_BA);
+
+    /* Clock Control Registers (CLK). Cannot fail. */
+    sysbus_realize(SYS_BUS_DEVICE(&s->clk), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->clk), 0, NPCM8XX_CLK_BA);
+
+    /* OTP fuse strap array. Cannot fail. */
+    sysbus_realize(SYS_BUS_DEVICE(&s->fuse_array), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->fuse_array), 0, NPCM8XX_OTP_BA);
+    npcm8xx_init_fuses(s);
+
+    /* Fake Memory Controller (MC). Cannot fail. */
+    sysbus_realize(SYS_BUS_DEVICE(&s->mc), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->mc), 0, NPCM8XX_MC_BA);
+
+    /* ADC Modules. Cannot fail. */
+    qdev_connect_clock_in(DEVICE(&s->adc), "clock", qdev_get_clock_out(
+                          DEVICE(&s->clk), "adc-clock"));
+    sysbus_realize(SYS_BUS_DEVICE(&s->adc), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->adc), 0, NPCM8XX_ADC_BA);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->adc), 0,
+                       npcm8xx_irq(s, NPCM8XX_ADC_IRQ));
+    npcm8xx_write_adc_calibration(s);
+
+    /* Timer Modules (TIM). Cannot fail. */
+    QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm8xx_tim_addr) != ARRAY_SIZE(s->tim));
+    for (i = 0; i < ARRAY_SIZE(s->tim); i++) {
+        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->tim[i]);
+        int first_irq;
+        int j;
+
+        /* Connect the timer clock. */
+        qdev_connect_clock_in(DEVICE(&s->tim[i]), "clock", qdev_get_clock_out(
+                    DEVICE(&s->clk), "timer-clock"));
+
+        sysbus_realize(sbd, &error_abort);
+        sysbus_mmio_map(sbd, 0, npcm8xx_tim_addr[i]);
+
+        first_irq = NPCM8XX_TIMER0_IRQ + i * NPCM7XX_TIMERS_PER_CTRL;
+        for (j = 0; j < NPCM7XX_TIMERS_PER_CTRL; j++) {
+            qemu_irq irq = npcm8xx_irq(s, first_irq + j);
+            sysbus_connect_irq(sbd, j, irq);
+        }
+
+        /* IRQ for watchdogs */
+        sysbus_connect_irq(sbd, NPCM7XX_TIMERS_PER_CTRL,
+                npcm8xx_irq(s, NPCM8XX_WDG0_IRQ + i));
+        /* GPIO that connects clk module with watchdog */
+        /* TODO: Check this.*/
+        qdev_connect_gpio_out_named(DEVICE(&s->tim[i]),
+                NPCM7XX_WATCHDOG_RESET_GPIO_OUT, 0,
+                qdev_get_gpio_in_named(DEVICE(&s->clk),
+                        NPCM7XX_WATCHDOG_RESET_GPIO_IN, i));
+    }
+
+    /* UART0..6 (16550 compatible) */
+    for (i = 0; i < ARRAY_SIZE(npcm8xx_uart_addr); i++) {
+        serial_mm_init(get_system_memory(), npcm8xx_uart_addr[i], 2,
+                       npcm8xx_irq(s, NPCM8XX_UART0_IRQ + i), 115200,
+                       serial_hd(i), DEVICE_LITTLE_ENDIAN);
+    }
+
+    /* Random Number Generator. Cannot fail. */
+    sysbus_realize(SYS_BUS_DEVICE(&s->rng), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->rng), 0, NPCM8XX_RNG_BA);
+
+    /* GPIO modules. Cannot fail. */
+    QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm8xx_gpio) != ARRAY_SIZE(s->gpio));
+    sysbus_realize(SYS_BUS_DEVICE(&s->gpiotx), &error_abort);
+    for (i = 0; i < ARRAY_SIZE(s->gpio); i++) {
+        Object *obj = OBJECT(&s->gpio[i]);
+
+        object_property_set_link(obj, "gpio-tx", OBJECT(&s->gpiotx),
+                                 &error_abort);
+        object_property_set_uint(obj, "reset-pullup",
+                                 npcm8xx_gpio[i].reset_pu, &error_abort);
+        object_property_set_uint(obj, "reset-pulldown",
+                                 npcm8xx_gpio[i].reset_pd, &error_abort);
+        object_property_set_uint(obj, "reset-osrc",
+                                 npcm8xx_gpio[i].reset_osrc, &error_abort);
+        object_property_set_uint(obj, "reset-odsc",
+                                 npcm8xx_gpio[i].reset_odsc, &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(obj), &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(obj), 0, npcm8xx_gpio[i].regs_addr);
+        sysbus_connect_irq(SYS_BUS_DEVICE(obj), 0,
+                           npcm8xx_irq(s, NPCM8XX_GPIO0_IRQ + i));
+    }
+
+    /* SMBus modules. Cannot fail. */
+    QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm8xx_smbus_addr) != ARRAY_SIZE(s->smbus));
+    for (i = 0; i < ARRAY_SIZE(s->smbus); i++) {
+        Object *obj = OBJECT(&s->smbus[i]);
+
+        sysbus_realize(SYS_BUS_DEVICE(obj), &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(obj), 0, npcm8xx_smbus_addr[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(obj), 0,
+                           npcm8xx_irq(s, NPCM8XX_SMBUS0_IRQ + i));
+    }
+
+    /* KCS modules*/
+    sysbus_realize(SYS_BUS_DEVICE(&s->kcs), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->kcs), 0, NPCM8XX_KCS_BA);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->kcs), 0,
+                       npcm8xx_irq(s, NPCM8XX_KCS_HIB_IRQ));
+
+    /* USB Host */
+    QEMU_BUILD_BUG_ON(ARRAY_SIZE(s->ohci) != ARRAY_SIZE(s->ehci));
+    for (i = 0; i < ARRAY_SIZE(s->ehci); i++) {
+        object_property_set_bool(OBJECT(&s->ehci[i]), "companion-enable", true,
+                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ehci[i]), 0, npcm8xx_ehci_addr[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ehci[i]), 0,
+                           npcm8xx_irq(s, NPCM8XX_EHCI1_IRQ + 2 * i));
+    }
+    for (i = 0; i < ARRAY_SIZE(s->ohci); i++) {
+        object_property_set_str(OBJECT(&s->ohci[i]), "masterbus", "usb-bus.0",
+                                &error_abort);
+        object_property_set_uint(OBJECT(&s->ohci[i]), "num-ports", 1,
+                                 &error_abort);
+        object_property_set_uint(OBJECT(&s->ohci[i]), "firstport", i,
+                                 &error_abort);
+        sysbus_realize(SYS_BUS_DEVICE(&s->ohci[i]), &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->ohci[i]), 0, npcm8xx_ohci_addr[i]);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->ohci[i]), 0,
+                           npcm8xx_irq(s, NPCM8XX_OHCI1_IRQ + 2 * i));
+    }
+
+    /* PWM Modules. Cannot fail. */
+    QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm8xx_pwm_addr) != ARRAY_SIZE(s->pwm));
+    for (i = 0; i < ARRAY_SIZE(s->pwm); i++) {
+        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->pwm[i]);
+
+        qdev_connect_clock_in(DEVICE(&s->pwm[i]), "clock", qdev_get_clock_out(
+                    DEVICE(&s->clk), "apb3-clock"));
+        sysbus_realize(sbd, &error_abort);
+        sysbus_mmio_map(sbd, 0, npcm8xx_pwm_addr[i]);
+        sysbus_connect_irq(sbd, i, npcm8xx_irq(s, NPCM8XX_PWM0_IRQ + i));
+    }
+
+    /* MFT Modules. Cannot fail. */
+    QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm8xx_mft_addr) != ARRAY_SIZE(s->mft));
+    for (i = 0; i < ARRAY_SIZE(s->mft); i++) {
+        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->mft[i]);
+
+        qdev_connect_clock_in(DEVICE(&s->mft[i]), "clock-in",
+                              qdev_get_clock_out(DEVICE(&s->clk),
+                                                 "apb4-clock"));
+        sysbus_realize(sbd, &error_abort);
+        sysbus_mmio_map(sbd, 0, npcm8xx_mft_addr[i]);
+        sysbus_connect_irq(sbd, 0, npcm8xx_irq(s, NPCM8XX_MFT0_IRQ + i));
+    }
+
+    /*
+     * GMAC Modules. Cannot fail.
+     */
+    QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm8xx_gmac_addr) != ARRAY_SIZE(s->gmac));
+    for (i = 0; i < ARRAY_SIZE(s->gmac); i++) {
+        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->gmac[i]);
+
+        /* This is used to make sure that the NIC can create the device */
+        if (nd_table[i].used) {
+            qemu_check_nic_model(&nd_table[i], TYPE_NPCM_GMAC);
+            qdev_set_nic_properties(DEVICE(sbd), &nd_table[i]);
+        }
+
+        /*
+         * The device exists regardless of whether it's connected to a QEMU
+         * netdev backend. So always instantiate it even if there is no
+         * backend.
+         */
+        sysbus_realize(sbd, &error_abort);
+        sysbus_mmio_map(sbd, 0, npcm8xx_gmac_addr[i]);
+        /*
+         * N.B. The values for the second argument sysbus_connect_irq are
+         * chosen to match the registration order in npcm7xx_emc_realize.
+         */
+        sysbus_connect_irq(sbd, 0, npcm8xx_irq(s, NPCM8XX_GMAC1_IRQ + i));
+    }
+    /*
+     * GMAC Physical Coding Sublayer(PCS) Module. Cannot fail.
+     */
+    sysbus_realize(SYS_BUS_DEVICE(&s->pcs), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcs), 0, NPCM8XX_PCS_BA);
+    s->gmac[0].pcs = &s->pcs;
+
+    /*
+     * Flash Interface Unit (FIU). Can fail if incorrect number of chip selects
+     * specified, but this is a programming error.
+     */
+    QEMU_BUILD_BUG_ON(ARRAY_SIZE(npcm8xx_fiu) != ARRAY_SIZE(s->fiu));
+    for (i = 0; i < ARRAY_SIZE(s->fiu); i++) {
+        SysBusDevice *sbd = SYS_BUS_DEVICE(&s->fiu[i]);
+        int j;
+
+        object_property_set_int(OBJECT(sbd), "cs-count",
+                                npcm8xx_fiu[i].cs_count, &error_abort);
+        object_property_set_int(OBJECT(sbd), "flash-size",
+                                npcm8xx_fiu[i].flash_size, &error_abort);
+        sysbus_realize(sbd, &error_abort);
+
+        sysbus_mmio_map(sbd, 0, npcm8xx_fiu[i].regs_addr);
+        for (j = 0; j < npcm8xx_fiu[i].cs_count; j++) {
+            sysbus_mmio_map(sbd, j + 1, npcm8xx_fiu[i].flash_addr[j]);
+        }
+    }
+
+    /* PCI Mailbox. Cannot fail */
+    for (i = 0; i < ARRAY_SIZE(s->pci_mbox); i++) {
+        sysbus_realize(SYS_BUS_DEVICE(&s->pci_mbox[i]), &error_abort);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->pci_mbox[i]), 0,
+                                       npcm8xx_pci_mbox_addr[i]);
+        sysbus_mmio_map(SYS_BUS_DEVICE(&s->pci_mbox[i]), 1,
+                        npcm8xx_pci_mbox_addr[i] + NPCM7XX_PCI_MBOX_RAM_SIZE);
+        sysbus_connect_irq(SYS_BUS_DEVICE(&s->pci_mbox), 0,
+                           npcm8xx_irq(s, NPCM8XX_PCI_MBOX1_IRQ + i));
+    }
+
+    /* RAM2 (SRAM) */
+    memory_region_init_ram(&s->sram, OBJECT(dev), "ram2",
+                           NPCM8XX_RAM2_SZ, &error_abort);
+    memory_region_add_subregion(get_system_memory(), NPCM8XX_RAM2_BA, &s->sram);
+
+    /* RAM3 (SRAM) */
+    memory_region_init_ram(&s->ram3, OBJECT(dev), "ram3",
+                           NPCM8XX_RAM3_SZ, &error_abort);
+    memory_region_add_subregion(get_system_memory(), NPCM8XX_RAM3_BA, &s->ram3);
+
+    /* Internal ROM */
+    memory_region_init_rom(&s->irom, OBJECT(dev), "irom", NPCM8XX_ROM_SZ,
+                           &error_abort);
+    memory_region_add_subregion(get_system_memory(), NPCM8XX_ROM_BA, &s->irom);
+
+    /* SDHCI */
+    sysbus_realize(SYS_BUS_DEVICE(&s->mmc), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->mmc), 0, NPCM8XX_MMC_BA);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->mmc), 0,
+            npcm8xx_irq(s, NPCM8XX_MMC_IRQ));
+
+    /* PECI */
+    sysbus_realize(SYS_BUS_DEVICE(&s->peci), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->peci), 0, NPCM8XX_PECI_BA);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peci), 0,
+                       npcm8xx_irq(s, NPCM8XX_PECI_IRQ));
+    /* PCIe RC */
+    sysbus_realize(SYS_BUS_DEVICE(&s->pcierc), &error_abort);
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->pcierc), 0, NPCM8XX_PCIERC_BA);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->pcierc), 0,
+                       npcm8xx_irq(s, NPCM8XX_PCIE_RC_IRQ));
+
+    create_unimplemented_device("npcm8xx.shm",          0xc0001000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.gicextra",     0xdfffa000,  24 * KiB);
+    create_unimplemented_device("npcm8xx.vdmx",         0xe0800000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.gfxi",         0xf000e000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.fsw",          0xf000f000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.bt",           0xf0030000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.espi",         0xf009f000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.peci",         0xf0100000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.siox[1]",      0xf0101000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.siox[2]",      0xf0102000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.tmps",         0xf0188000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.pspi",         0xf0201000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.viru1",        0xf0204000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.viru2",        0xf0205000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.jtm1",         0xf0208000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.jtm2",         0xf0209000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.flm0",         0xf0210000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.flm1",         0xf0211000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.flm2",         0xf0212000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.flm3",         0xf0213000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.ahbpci",       0xf0400000,   1 * MiB);
+    create_unimplemented_device("npcm8xx.dap",          0xf0500000, 960 * KiB);
+    create_unimplemented_device("npcm8xx.mcphy",        0xf05f0000,  64 * KiB);
+    create_unimplemented_device("npcm8xx.tsgen",        0xf07fc000,   8 * KiB);
+    create_unimplemented_device("npcm8xx.copctl",       0xf080c000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.tipctl",       0xf080d000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.rst",          0xf080e000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.vcd",          0xf0810000,  64 * KiB);
+    create_unimplemented_device("npcm8xx.ece",          0xf0820000,   8 * KiB);
+    create_unimplemented_device("npcm8xx.vdma",         0xf0822000,   8 * KiB);
+    create_unimplemented_device("npcm8xx.usbd[0]",      0xf0830000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.usbd[1]",      0xf0831000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.usbd[2]",      0xf0832000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.usbd[3]",      0xf0833000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.usbd[4]",      0xf0834000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.usbd[5]",      0xf0835000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.usbd[6]",      0xf0836000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.usbd[7]",      0xf0837000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.usbd[8]",      0xf0838000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.usbd[9]",      0xf0839000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.gdma0",        0xf0850000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.gdma1",        0xf0851000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.gdma2",        0xf0852000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.aes",          0xf0858000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.des",          0xf0859000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.sha",          0xf085a000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.i3c0",         0xfff10000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.i3c1",         0xfff11000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.i3c2",         0xfff12000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.i3c3",         0xfff13000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.i3c4",         0xfff14000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.i3c5",         0xfff15000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.spixcs0",      0xf8000000,  16 * MiB);
+    create_unimplemented_device("npcm8xx.spixcs1",      0xf9000000,  16 * MiB);
+    create_unimplemented_device("npcm8xx.spix",         0xfb001000,   4 * KiB);
+    create_unimplemented_device("npcm8xx.vect",         0xffff0000,   256);
+}
+
+static Property npcm8xx_properties[] = {
+    DEFINE_PROP_LINK("dram-mr", NPCM8xxState, dram, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void npcm8xx_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    NPCM8xxClass *nc = NPCM8XX_CLASS(oc);
+
+    dc->realize = npcm8xx_realize;
+    dc->user_creatable = false;
+    nc->disabled_modules = 0x00000000;
+    nc->num_cpus = NPCM8XX_MAX_NUM_CPUS;
+    device_class_set_props(dc, npcm8xx_properties);
+}
+
+static const TypeInfo npcm8xx_soc_types[] = {
+    {
+        .name           = TYPE_NPCM8XX,
+        .parent         = TYPE_DEVICE,
+        .instance_size  = sizeof(NPCM8xxState),
+        .instance_init  = npcm8xx_init,
+        .class_size     = sizeof(NPCM8xxClass),
+        .class_init     = npcm8xx_class_init,
+    },
+};
+
+DEFINE_TYPES(npcm8xx_soc_types);
diff --git a/hw/net/meson.build b/hw/net/meson.build
index 2632634df3..a60f05b6c4 100644
--- a/hw/net/meson.build
+++ b/hw/net/meson.build
@@ -38,7 +38,8 @@ system_ss.add(when: 'CONFIG_I82596_COMMON', if_true: files('i82596.c'))
 system_ss.add(when: 'CONFIG_SUNHME', if_true: files('sunhme.c'))
 system_ss.add(when: 'CONFIG_FTGMAC100', if_true: files('ftgmac100.c'))
 system_ss.add(when: 'CONFIG_SUNGEM', if_true: files('sungem.c'))
-system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_emc.c'))
+system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_emc.c', 'npcm_gmac.c'))
+system_ss.add(when: 'CONFIG_NPCM8XX', if_true: files('npcm_pcs.c'))
 
 system_ss.add(when: 'CONFIG_ETRAXFS', if_true: files('etraxfs_eth.c'))
 system_ss.add(when: 'CONFIG_COLDFIRE', if_true: files('mcf_fec.c'))
diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
new file mode 100644
index 0000000000..5ce632858d
--- /dev/null
+++ b/hw/net/npcm_gmac.c
@@ -0,0 +1,395 @@
+/*
+ * Nuvoton NPCM7xx/8xx GMAC Module
+ *
+ * Copyright 2022 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ *
+ * Unsupported/unimplemented features:
+ * - MII is not implemented, MII_ADDR.BUSY and MII_DATA always return zero
+ * - Precision timestamp (PTP) is not implemented.
+ */
+
+#include "qemu/osdep.h"
+
+#include "hw/registerfields.h"
+#include "hw/net/mii.h"
+#include "hw/net/npcm_gmac.h"
+#include "migration/vmstate.h"
+#include "qemu/log.h"
+#include "qemu/units.h"
+#include "sysemu/dma.h"
+#include "trace.h"
+
+REG32(NPCM_DMA_BUS_MODE, 0x1000)
+REG32(NPCM_DMA_XMT_POLL_DEMAND, 0x1004)
+REG32(NPCM_DMA_RCV_POLL_DEMAND, 0x1008)
+REG32(NPCM_DMA_RCV_BASE_ADDR, 0x100c)
+REG32(NPCM_DMA_TX_BASE_ADDR, 0x1010)
+REG32(NPCM_DMA_STATUS, 0x1014)
+REG32(NPCM_DMA_CONTROL, 0x1018)
+REG32(NPCM_DMA_INTR_ENA, 0x101c)
+REG32(NPCM_DMA_MISSED_FRAME_CTR, 0x1020)
+REG32(NPCM_DMA_HOST_TX_DESC, 0x1048)
+REG32(NPCM_DMA_HOST_RX_DESC, 0x104c)
+REG32(NPCM_DMA_CUR_TX_BUF_ADDR, 0x1050)
+REG32(NPCM_DMA_CUR_RX_BUF_ADDR, 0x1054)
+REG32(NPCM_DMA_HW_FEATURE, 0x1058)
+
+REG32(NPCM_GMAC_MAC_CONFIG, 0x0)
+REG32(NPCM_GMAC_FRAME_FILTER, 0x4)
+REG32(NPCM_GMAC_HASH_HIGH, 0x8)
+REG32(NPCM_GMAC_HASH_LOW, 0xc)
+REG32(NPCM_GMAC_MII_ADDR, 0x10)
+REG32(NPCM_GMAC_MII_DATA, 0x14)
+REG32(NPCM_GMAC_FLOW_CTRL, 0x18)
+REG32(NPCM_GMAC_VLAN_FLAG, 0x1c)
+REG32(NPCM_GMAC_VERSION, 0x20)
+REG32(NPCM_GMAC_WAKEUP_FILTER, 0x28)
+REG32(NPCM_GMAC_PMT, 0x2c)
+REG32(NPCM_GMAC_LPI_CTRL, 0x30)
+REG32(NPCM_GMAC_TIMER_CTRL, 0x34)
+REG32(NPCM_GMAC_INT_STATUS, 0x38)
+REG32(NPCM_GMAC_INT_MASK, 0x3c)
+REG32(NPCM_GMAC_MAC0_ADDR_HI, 0x40)
+REG32(NPCM_GMAC_MAC0_ADDR_LO, 0x44)
+REG32(NPCM_GMAC_MAC1_ADDR_HI, 0x48)
+REG32(NPCM_GMAC_MAC1_ADDR_LO, 0x4c)
+REG32(NPCM_GMAC_MAC2_ADDR_HI, 0x50)
+REG32(NPCM_GMAC_MAC2_ADDR_LO, 0x54)
+REG32(NPCM_GMAC_MAC3_ADDR_HI, 0x58)
+REG32(NPCM_GMAC_MAC3_ADDR_LO, 0x5c)
+REG32(NPCM_GMAC_RGMII_STATUS, 0xd8)
+REG32(NPCM_GMAC_WATCHDOG, 0xdc)
+REG32(NPCM_GMAC_PTP_TCR, 0x700)
+REG32(NPCM_GMAC_PTP_SSIR, 0x704)
+REG32(NPCM_GMAC_PTP_STSR, 0x708)
+REG32(NPCM_GMAC_PTP_STNSR, 0x70c)
+REG32(NPCM_GMAC_PTP_STSUR, 0x710)
+REG32(NPCM_GMAC_PTP_STNSUR, 0x714)
+REG32(NPCM_GMAC_PTP_TAR, 0x718)
+REG32(NPCM_GMAC_PTP_TTSR, 0x71c)
+
+/* Register Fields */
+#define NPCM_GMAC_MII_ADDR_BUSY             BIT(0)
+#define NPCM_GMAC_MII_ADDR_WRITE            BIT(1)
+#define NPCM_GMAC_MII_ADDR_GR(rv)           extract16((rv), 6, 5)
+#define NPCM_GMAC_MII_ADDR_PA(rv)           extract16((rv), 11, 5)
+
+#define NPCM_GMAC_INT_MASK_LPIIM            BIT(10)
+#define NPCM_GMAC_INT_MASK_PMTM             BIT(3)
+#define NPCM_GMAC_INT_MASK_RGIM             BIT(0)
+
+#define NPCM_DMA_BUS_MODE_SWR               BIT(0)
+
+static const uint32_t npcm_gmac_cold_reset_values[NPCM_GMAC_NR_REGS] = {
+    [R_NPCM_GMAC_VERSION]         = 0x00001037,
+    [R_NPCM_GMAC_TIMER_CTRL]      = 0x03e80000,
+    [R_NPCM_GMAC_MAC0_ADDR_HI]    = 0x8000ffff,
+    [R_NPCM_GMAC_MAC0_ADDR_LO]    = 0xffffffff,
+    [R_NPCM_GMAC_MAC1_ADDR_HI]    = 0x0000ffff,
+    [R_NPCM_GMAC_MAC1_ADDR_LO]    = 0xffffffff,
+    [R_NPCM_GMAC_MAC2_ADDR_HI]    = 0x0000ffff,
+    [R_NPCM_GMAC_MAC2_ADDR_LO]    = 0xffffffff,
+    [R_NPCM_GMAC_MAC3_ADDR_HI]    = 0x0000ffff,
+    [R_NPCM_GMAC_MAC3_ADDR_LO]    = 0xffffffff,
+    [R_NPCM_GMAC_PTP_TCR]         = 0x00002000,
+    [R_NPCM_DMA_BUS_MODE]         = 0x00020101,
+    [R_NPCM_DMA_HW_FEATURE]       = 0x100d4f37,
+};
+
+static const uint16_t phy_reg_init[] = {
+    [MII_BMCR]      = MII_BMCR_AUTOEN | MII_BMCR_FD | MII_BMCR_SPEED1000,
+    [MII_BMSR]      = MII_BMSR_100TX_FD | MII_BMSR_100TX_HD | MII_BMSR_10T_FD |
+                      MII_BMSR_10T_HD | MII_BMSR_EXTSTAT | MII_BMSR_AUTONEG |
+                      MII_BMSR_LINK_ST | MII_BMSR_EXTCAP,
+    [MII_PHYID1]    = 0x0362,
+    [MII_PHYID2]    = 0x5e6a,
+    [MII_ANAR]      = MII_ANAR_TXFD | MII_ANAR_TX | MII_ANAR_10FD |
+                      MII_ANAR_10 | MII_ANAR_CSMACD,
+    [MII_ANLPAR]    = MII_ANLPAR_ACK | MII_ANLPAR_PAUSE |
+                      MII_ANLPAR_TXFD | MII_ANLPAR_TX | MII_ANLPAR_10FD |
+                      MII_ANLPAR_10 | MII_ANLPAR_CSMACD,
+    [MII_ANER]      = 0x64 | MII_ANER_NWAY,
+    [MII_ANNP]      = 0x2001,
+    [MII_CTRL1000]  = MII_CTRL1000_FULL,
+    [MII_STAT1000]  = MII_STAT1000_FULL,
+    [MII_EXTSTAT]   = 0x3000, /* 1000BASTE_T full-duplex capable */
+};
+
+static void npcm_gmac_soft_reset(NPCMGMACState *s)
+{
+    memcpy(s->regs, npcm_gmac_cold_reset_values,
+           NPCM_GMAC_NR_REGS * sizeof(uint32_t));
+    /* Clear reset bits */
+    s->regs[R_NPCM_DMA_BUS_MODE] &= ~NPCM_DMA_BUS_MODE_SWR;
+}
+
+static void gmac_phy_set_link(NPCMGMACState *s, bool active)
+{
+    /* Autonegotiation status mirrors link status.  */
+    if (active) {
+        s->phy_regs[0][MII_BMSR] |= (MII_BMSR_LINK_ST | MII_BMSR_AN_COMP);
+    } else {
+        s->phy_regs[0][MII_BMSR] &= ~(MII_BMSR_LINK_ST | MII_BMSR_AN_COMP);
+    }
+}
+
+static bool gmac_can_receive(NetClientState *nc)
+{
+    return true;
+}
+
+static ssize_t gmac_receive(NetClientState *nc, const uint8_t *buf, size_t len1)
+{
+    return 0;
+}
+
+static void gmac_cleanup(NetClientState *nc)
+{
+    /* Nothing to do yet. */
+}
+
+static void gmac_set_link(NetClientState *nc)
+{
+    NPCMGMACState *s = qemu_get_nic_opaque(nc);
+
+    trace_npcm_gmac_set_link(!nc->link_down);
+    gmac_phy_set_link(s, !nc->link_down);
+}
+
+static void npcm_gmac_mdio_access(NPCMGMACState *s, uint16_t v)
+{
+    bool busy = v & NPCM_GMAC_MII_ADDR_BUSY;
+    uint8_t is_write;
+    uint8_t pa, gr;
+    uint16_t data;
+
+    if (busy) {
+        is_write = v & NPCM_GMAC_MII_ADDR_WRITE;
+        pa = NPCM_GMAC_MII_ADDR_PA(v);
+        gr = NPCM_GMAC_MII_ADDR_GR(v);
+        /* Both pa and gr are 5 bits, so they are less than 32. */
+        g_assert(pa < NPCM_GMAC_MAX_PHYS);
+        g_assert(gr < NPCM_GMAC_MAX_PHY_REGS);
+
+
+        if (v & NPCM_GMAC_MII_ADDR_WRITE) {
+            data = s->regs[R_NPCM_GMAC_MII_DATA];
+            /* Clear reset bit for BMCR register */
+            switch (gr) {
+            case MII_BMCR:
+                data &= ~MII_BMCR_RESET;
+                /* Complete auto-negotiation immediately and set as complete */
+                if (data & MII_BMCR_AUTOEN) {
+                    /* Tells autonegotiation to not restart again */
+                    data &= ~MII_BMCR_ANRESTART;
+                    /* sets autonegotiation as complete */
+                    s->phy_regs[pa][MII_BMSR] |= MII_BMSR_AN_COMP;
+                }
+            }
+            s->phy_regs[pa][gr] = data;
+        } else {
+            data = s->phy_regs[pa][gr];
+            s->regs[R_NPCM_GMAC_MII_DATA] = data;
+        }
+        trace_npcm_gmac_mdio_access(DEVICE(s)->canonical_path, is_write, pa,
+                                    gr, data);
+    }
+    s->regs[R_NPCM_GMAC_MII_ADDR] = v & ~NPCM_GMAC_MII_ADDR_BUSY;
+}
+
+static uint64_t npcm_gmac_read(void *opaque, hwaddr offset, unsigned size)
+{
+    NPCMGMACState *s = opaque;
+    uint32_t v = 0;
+
+    switch (offset) {
+    /* Write only registers */
+    case A_NPCM_DMA_XMT_POLL_DEMAND:
+    case A_NPCM_DMA_RCV_POLL_DEMAND:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Read of write-only reg: offset: 0x%04" HWADDR_PRIx
+                      "\n", DEVICE(s)->canonical_path, offset);
+        break;
+
+    default:
+        v = s->regs[offset / sizeof(uint32_t)];
+    }
+    trace_npcm_gmac_reg_read(DEVICE(s)->canonical_path, offset, v);
+    return v;
+}
+
+static void npcm_gmac_write(void *opaque, hwaddr offset,
+                              uint64_t v, unsigned size)
+{
+    NPCMGMACState *s = opaque;
+
+    trace_npcm_gmac_reg_write(DEVICE(s)->canonical_path, offset, v);
+    switch (offset) {
+    /* Read only registers */
+    case A_NPCM_GMAC_VERSION:
+    case A_NPCM_GMAC_INT_STATUS:
+    case A_NPCM_GMAC_RGMII_STATUS:
+    case A_NPCM_GMAC_PTP_STSR:
+    case A_NPCM_GMAC_PTP_STNSR:
+    case A_NPCM_DMA_MISSED_FRAME_CTR:
+    case A_NPCM_DMA_HOST_TX_DESC:
+    case A_NPCM_DMA_HOST_RX_DESC:
+    case A_NPCM_DMA_CUR_TX_BUF_ADDR:
+    case A_NPCM_DMA_CUR_RX_BUF_ADDR:
+    case A_NPCM_DMA_HW_FEATURE:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Write of read-only reg: offset: 0x%04" HWADDR_PRIx
+                      ", value: 0x%04" PRIx64 "\n",
+                      DEVICE(s)->canonical_path, offset, v);
+        break;
+
+    case A_NPCM_GMAC_MII_ADDR:
+        npcm_gmac_mdio_access(s, v);
+        break;
+
+    case A_NPCM_GMAC_MAC0_ADDR_HI:
+        s->regs[offset / sizeof(uint32_t)] = v;
+        s->conf.macaddr.a[0] = v >> 8;
+        s->conf.macaddr.a[1] = v >> 0;
+        break;
+
+    case A_NPCM_GMAC_MAC0_ADDR_LO:
+        s->regs[offset / sizeof(uint32_t)] = v;
+        s->conf.macaddr.a[2] = v >> 24;
+        s->conf.macaddr.a[3] = v >> 16;
+        s->conf.macaddr.a[4] = v >> 8;
+        s->conf.macaddr.a[5] = v >> 0;
+        break;
+
+    case A_NPCM_GMAC_MAC1_ADDR_HI:
+    case A_NPCM_GMAC_MAC1_ADDR_LO:
+    case A_NPCM_GMAC_MAC2_ADDR_HI:
+    case A_NPCM_GMAC_MAC2_ADDR_LO:
+    case A_NPCM_GMAC_MAC3_ADDR_HI:
+    case A_NPCM_GMAC_MAC3_ADDR_LO:
+        s->regs[offset / sizeof(uint32_t)] = v;
+        qemu_log_mask(LOG_UNIMP,
+                      "%s: Only MAC Address 0 is supported. This request "
+                      "is ignored.\n", DEVICE(s)->canonical_path);
+        break;
+
+    case A_NPCM_DMA_BUS_MODE:
+        s->regs[offset / sizeof(uint32_t)] = v;
+        if (v & NPCM_DMA_BUS_MODE_SWR) {
+            npcm_gmac_soft_reset(s);
+        }
+        break;
+
+    default:
+        s->regs[offset / sizeof(uint32_t)] = v;
+        break;
+    }
+}
+
+static void npcm_gmac_reset(DeviceState *dev)
+{
+    NPCMGMACState *s = NPCM_GMAC(dev);
+
+    npcm_gmac_soft_reset(s);
+    memcpy(s->phy_regs[0], phy_reg_init, sizeof(phy_reg_init));
+
+    trace_npcm_gmac_reset(DEVICE(s)->canonical_path, s->phy_regs[0][MII_BMSR]);
+}
+
+static NetClientInfo net_npcm_gmac_info = {
+    .type = NET_CLIENT_DRIVER_NIC,
+    .size = sizeof(NICState),
+    .can_receive = gmac_can_receive,
+    .receive = gmac_receive,
+    .cleanup = gmac_cleanup,
+    .link_status_changed = gmac_set_link,
+};
+
+static const struct MemoryRegionOps npcm_gmac_ops = {
+    .read = npcm_gmac_read,
+    .write = npcm_gmac_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+        .unaligned = false,
+    },
+};
+
+static void npcm_gmac_realize(DeviceState *dev, Error **errp)
+{
+    NPCMGMACState *gmac = NPCM_GMAC(dev);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+
+    memory_region_init_io(&gmac->iomem, OBJECT(gmac), &npcm_gmac_ops, gmac,
+                          TYPE_NPCM_GMAC, 8 * KiB);
+    sysbus_init_mmio(sbd, &gmac->iomem);
+    sysbus_init_irq(sbd, &gmac->irq);
+
+    qemu_macaddr_default_if_unset(&gmac->conf.macaddr);
+
+    gmac->nic = qemu_new_nic(&net_npcm_gmac_info, &gmac->conf, TYPE_NPCM_GMAC,
+                             dev->id, gmac);
+    qemu_format_nic_info_str(qemu_get_queue(gmac->nic), gmac->conf.macaddr.a);
+    gmac->regs[R_NPCM_GMAC_MAC0_ADDR_HI] = (gmac->conf.macaddr.a[0] << 8) + \
+                                            gmac->conf.macaddr.a[1];
+    gmac->regs[R_NPCM_GMAC_MAC0_ADDR_LO] = (gmac->conf.macaddr.a[2] << 24) + \
+                                           (gmac->conf.macaddr.a[3] << 16) + \
+                                           (gmac->conf.macaddr.a[4] << 8) + \
+                                            gmac->conf.macaddr.a[5];
+}
+
+static void npcm_gmac_unrealize(DeviceState *dev)
+{
+    NPCMGMACState *gmac = NPCM_GMAC(dev);
+
+    qemu_del_nic(gmac->nic);
+}
+
+static const VMStateDescription vmstate_npcm_gmac = {
+    .name = TYPE_NPCM_GMAC,
+    .version_id = 0,
+    .minimum_version_id = 0,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, NPCMGMACState, NPCM_GMAC_NR_REGS),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static Property npcm_gmac_properties[] = {
+    DEFINE_NIC_PROPERTIES(NPCMGMACState, conf),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void npcm_gmac_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+    dc->desc = "NPCM GMAC Controller";
+    dc->realize = npcm_gmac_realize;
+    dc->unrealize = npcm_gmac_unrealize;
+    dc->reset = npcm_gmac_reset;
+    dc->vmsd = &vmstate_npcm_gmac;
+    device_class_set_props(dc, npcm_gmac_properties);
+}
+
+static const TypeInfo npcm_gmac_types[] = {
+    {
+        .name = TYPE_NPCM_GMAC,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(NPCMGMACState),
+        .class_init = npcm_gmac_class_init,
+    },
+};
+DEFINE_TYPES(npcm_gmac_types)
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 6b5ba669a2..27b006f40a 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -464,6 +464,17 @@ npcm7xx_emc_rx_done(uint32_t crxdsa) "RX done, CRXDSA=0x%x"
 npcm7xx_emc_reg_read(int emc_num, uint32_t result, const char *name, int regno) "emc%d: 0x%x = reg[%s/%d]"
 npcm7xx_emc_reg_write(int emc_num, const char *name, int regno, uint32_t value) "emc%d: reg[%s/%d] = 0x%x"
 
+# npcm_gmac.c
+npcm_gmac_reg_read(const char *name, uint64_t offset, uint32_t value) "%s: offset: 0x%04" PRIx64 " value: 0x%04" PRIx32
+npcm_gmac_reg_write(const char *name, uint64_t offset, uint32_t value) "%s: offset: 0x%04" PRIx64 " value: 0x%04" PRIx32
+npcm_gmac_mdio_access(const char *name, uint8_t is_write, uint8_t pa, uint8_t gr, uint16_t val) "%s: is_write: %" PRIu8 " pa: %" PRIu8 " gr: %" PRIu8 " val: 0x%04" PRIx16
+npcm_gmac_reset(const char *name, uint16_t value) "%s: phy_regs[0][1]: 0x%04" PRIx16
+npcm_gmac_set_link(bool active) "Set link: active=%u"
+
+# npcm_pcs.c
+npcm_pcs_reg_read(const char *name, uint16_t indirect_access_baes, uint64_t offset, uint16_t value) "%s: IND: 0x%02" PRIx16 " offset: 0x%04" PRIx64 " value: 0x%04" PRIx16
+npcm_pcs_reg_write(const char *name, uint16_t indirect_access_baes, uint64_t offset, uint16_t value) "%s: IND: 0x%02" PRIx16 " offset: 0x%04" PRIx64 " value: 0x%04" PRIx16
+
 # dp8398x.c
 dp8393x_raise_irq(int isr) "raise irq, isr is 0x%04x"
 dp8393x_lower_irq(void) "lower irq"
diff --git a/include/hw/net/npcm_gmac.h b/include/hw/net/npcm_gmac.h
new file mode 100644
index 0000000000..03529db1d6
--- /dev/null
+++ b/include/hw/net/npcm_gmac.h
@@ -0,0 +1,172 @@
+/*
+ * Nuvoton NPCM7xx/8xx GMAC Module
+ *
+ * Copyright 2022 Google LLC
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
+ * for more details.
+ */
+
+#ifndef NPCM_GMAC_H
+#define NPCM_GMAC_H
+
+#include "hw/irq.h"
+#include "hw/sysbus.h"
+#include "hw/net/npcm_pcs.h"
+#include "net/net.h"
+
+#define NPCM_GMAC_NR_REGS (0x1060 / sizeof(uint32_t))
+
+#define NPCM_GMAC_MAX_PHYS 32
+#define NPCM_GMAC_MAX_PHY_REGS 32
+
+struct NPCMGMACRxDesc {
+    uint32_t rdes0;
+    uint32_t rdes1;
+    uint32_t rdes2;
+    uint32_t rdes3;
+};
+
+/* NPCMGMACRxDesc.flags values */
+/* RDES2 and RDES3 are buffer address pointers */
+/* Owner: 0 = software, 1 = gmac */
+#define RX_DESC_RDES0_OWNER_MASK BIT(31)
+/* Owner*/
+#define RX_DESC_RDES0_OWNER_SHIFT 31
+/* Destination Address Filter Fail */
+#define RX_DESC_RDES0_DEST_ADDR_FILT_FAIL_MASK BIT(30)
+/* Frame length*/
+#define RX_DESC_RDES0_FRAME_LEN_MASK(word) extract32(word, 16, 29)
+/* Error Summary */
+#define RX_DESC_RDES0_ERR_SUMM_MASK BIT(15)
+/* Descriptor Error */
+#define RX_DESC_RDES0_DESC_ERR_MASK BIT(14)
+/* Source Address Filter Fail */
+#define RX_DESC_RDES0_SRC_ADDR_FILT_FAIL_MASK BIT(13)
+/* Length Error */
+#define RX_DESC_RDES0_LEN_ERR_MASK BIT(12)
+/* Overflow Error */
+#define RX_DESC_RDES0_OVRFLW_ERR_MASK BIT(11)
+/* VLAN Tag */
+#define RX_DESC_RDES0_VLAN_TAG_MASK BIT(10)
+/* First Descriptor */
+#define RX_DESC_RDES0_FIRST_DESC_MASK BIT(9)
+/* Last Descriptor */
+#define RX_DESC_RDES0_LAST_DESC_MASK BIT(8)
+/* IPC Checksum Error/Giant Frame */
+#define RX_DESC_RDES0_IPC_CHKSM_ERR_GNT_FRM_MASK BIT(7)
+/* Late Collision */
+#define RX_DESC_RDES0_LT_COLL_MASK BIT(6)
+/* Frame Type */
+#define RX_DESC_RDES0_FRM_TYPE_MASK BIT(5)
+/* Receive Watchdog Timeout */
+#define RX_DESC_RDES0_REC_WTCHDG_TMT_MASK BIT(4)
+/* Receive Error */
+#define RX_DESC_RDES0_RCV_ERR_MASK BIT(3)
+/* Dribble Bit Error */
+#define RX_DESC_RDES0_DRBL_BIT_ERR_MASK BIT(2)
+/* Cyclcic Redundancy Check Error */
+#define RX_DESC_RDES0_CRC_ERR_MASK BIT(1)
+/* Rx MAC Address/Payload Checksum Error */
+#define RC_DESC_RDES0_RCE_MASK BIT(0)
+
+/* Disable Interrupt on Completion */
+#define RX_DESC_RDES1_DIS_INTR_COMP_MASK BIT(31)
+/* Recieve end of ring */
+#define RX_DESC_RDES1_RC_END_RING_MASK BIT(25)
+/* Second Address Chained */
+#define RX_DESC_RDES1_SEC_ADDR_CHND_MASK BIT(24)
+/* Receive Buffer 2 Size */
+#define RX_DESC_RDES1_BFFR2_SZ_SHIFT 11
+#define RX_DESC_RDES1_BFFR2_SZ_MASK(word) extract32(word, \
+    RX_DESC_RDES1_BFFR2_SZ_SHIFT, 10 + RX_DESC_RDES1_BFFR2_SZ_SHIFT)
+/* Receive Buffer 1 Size */
+#define RX_DESC_RDES1_BFFR1_SZ_MASK(word) extract32(word, 0, 10)
+
+
+struct NPCMGMACTxDesc {
+    uint32_t tdes0;
+    uint32_t tdes1;
+    uint32_t tdes2;
+    uint32_t tdes3;
+};
+
+/* NPCMGMACTxDesc.flags values */
+/* TDES2 and TDES3 are buffer address pointers */
+/* Owner: 0 = software, 1 = gmac */
+#define TX_DESC_TDES0_OWNER_MASK BIT(31)
+/* Tx Time Stamp Status */
+#define TX_DESC_TDES0_TTSS_MASK BIT(17)
+/* IP Header Error */
+#define TX_DESC_TDES0_IP_HEAD_ERR_MASK BIT(16)
+/* Error Summary */
+#define TX_DESC_TDES0_ERR_SUMM_MASK BIT(15)
+/* Jabber Timeout */
+#define TX_DESC_TDES0_JBBR_TMT_MASK BIT(14)
+/* Frame Flushed */
+#define TX_DESC_TDES0_FRM_FLSHD_MASK BIT(13)
+/* Payload Checksum Error */
+#define TX_DESC_TDES0_PYLD_CHKSM_ERR_MASK BIT(12)
+/* Loss of Carrier */
+#define TX_DESC_TDES0_LSS_CARR_MASK BIT(11)
+/* No Carrier */
+#define TX_DESC_TDES0_NO_CARR_MASK BIT(10)
+/* Late Collision */
+#define TX_DESC_TDES0_LATE_COLL_MASK BIT(9)
+/* Excessive Collision */
+#define TX_DESC_TDES0_EXCS_COLL_MASK BIT(8)
+/* VLAN Frame */
+#define TX_DESC_TDES0_VLAN_FRM_MASK BIT(7)
+/* Collision Count */
+#define TX_DESC_TDES0_COLL_CNT_MASK(word) extract32(word, 3, 6)
+/* Excessive Deferral */
+#define TX_DESC_TDES0_EXCS_DEF_MASK BIT(2)
+/* Underflow Error */
+#define TX_DESC_TDES0_UNDRFLW_ERR_MASK BIT(1)
+/* Deferred Bit */
+#define TX_DESC_TDES0_DFRD_BIT_MASK BIT(0)
+
+/* Interrupt of Completion */
+#define TX_DESC_TDES1_INTERR_COMP_MASK BIT(31)
+/* Last Segment */
+#define TX_DESC_TDES1_LAST_SEG_MASK BIT(30)
+/* Last Segment */
+#define TX_DESC_TDES1_FIRST_SEG_MASK BIT(29)
+/* Checksum Insertion Control */
+#define TX_DESC_TDES1_CHKSM_INS_CTRL_MASK(word) extract32(word, 27, 28)
+/* Disable Cyclic Redundancy Check */
+#define TX_DESC_TDES1_DIS_CDC_MASK BIT(26)
+/* Transmit End of Ring */
+#define TX_DESC_TDES1_TX_END_RING_MASK BIT(25)
+/* Secondary Address Chained */
+#define TX_DESC_TDES1_SEC_ADDR_CHND_MASK BIT(24)
+/* Transmit Buffer 2 Size */
+#define TX_DESC_TDES1_BFFR2_SZ_MASK(word) extract32(word, 11, 21)
+/* Transmit Buffer 1 Size */
+#define TX_DESC_TDES1_BFFR1_SZ_MASK(word) extract32(word, 0, 10)
+
+typedef struct NPCMGMACState {
+    SysBusDevice parent;
+
+    MemoryRegion iomem;
+    qemu_irq irq;
+
+    NICState *nic;
+    NICConf conf;
+
+    NPCMPCSState *pcs;
+    uint32_t regs[NPCM_GMAC_NR_REGS];
+    uint16_t phy_regs[NPCM_GMAC_MAX_PHYS][NPCM_GMAC_MAX_PHY_REGS];
+} NPCMGMACState;
+
+#define TYPE_NPCM_GMAC "npcm-gmac"
+OBJECT_DECLARE_SIMPLE_TYPE(NPCMGMACState, NPCM_GMAC)
+
+#endif /* NPCM_GMAC_H */
-- 
2.42.0.459.ge4e396fd5e-goog


