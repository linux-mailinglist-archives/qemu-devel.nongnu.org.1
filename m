Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5332D749D98
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:27:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHOzA-0004mE-Fl; Thu, 06 Jul 2023 09:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHOz7-0004lk-FB
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:25:25 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHOz0-0000qk-Ur
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:25:22 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbac8b01b3so16590335e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 06:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688649915; x=1691241915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xgCaPGnXl46UU9A6jcwSSpnZq6M2JkIzMN4VboZNQHE=;
 b=Jfs4Q7ueOgzHMHxFvv61dJi4FzmQY3FW+IWCeM5qD/EMEd4s3DTllYNounuZmSKkuO
 A6BqG7kKAZm8huOToNBnLs+xEfjN3we8u3mviCVqDwyq/Y3aj4F6HtPLuBDAiX6IOAUw
 ffKRYFKdIoQ4EWx+OHeOvOgzXaq1CKcLbaCVobTY64UyMERynLWTkIWzirbsW/QcD/+s
 5WiKIzepxSNCqFVh802P6xp31fgk2Qropb411ZP0Z22CO/yXpqsaqR0WFzwXdqPfzCSp
 gZstJh1m9SGCtVg59tYTtoDs2Ny6l4FmyWwMEmXvoLiSJBm08efCpjx1KB/4CTUgO/xu
 G0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688649915; x=1691241915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xgCaPGnXl46UU9A6jcwSSpnZq6M2JkIzMN4VboZNQHE=;
 b=C3O+mKD74NLQsoz8GsSLSiGn0FrCd5Ty5WZ50VH9t1MByDQkRXPVeOsx0jz905HATh
 6FJGy9dZ7RuoAZAQfJIzGa1d8p4HZmGtMeeslw7yC6minu205sn3TM/wK6P+G1t2ih2x
 tihuZscfb4FmAFznDhvqMAfuxLDVYyE6yYfSxD844CPpd2nEgpdbnl5DB1XAyrZiYuJB
 7DWfXXPzkLOlHxDm6RJ1h4xnhCVPketS5RmKHworUYtd++DKzk4/Y1CT/4aL1ztEZnEX
 vTlz98/T+mzMYvIPeRWkhEOOlNUFoW415WFssnHuM1kaJADBIVUkLIRn5RlP1BIRDbPH
 AfZA==
X-Gm-Message-State: ABy/qLYdv0uuPmPI38AoFUBzxnqZVoZnvmxV2H/kHzMVSMPcm3QlYkZX
 vvdgtQrDbYRqPt8Oj8A/s9y4ta+owPz9yrdv3KI=
X-Google-Smtp-Source: APBJJlEvykn3FgyDncYFBsQ66BpAv56kdTwi17pa0s5br8Ye/PBL6NBvNckbAQg8rSFnS/e8zyJXlg==
X-Received: by 2002:adf:f589:0:b0:314:3a9a:d70e with SMTP id
 f9-20020adff589000000b003143a9ad70emr5032056wro.11.1688649915175; 
 Thu, 06 Jul 2023 06:25:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a5d510f000000b00304adbeeabbsm1856170wrt.99.2023.07.06.06.25.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 06:25:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/14] hw/arm/sbsa-ref: use XHCI to replace EHCI
Date: Thu,  6 Jul 2023 14:25:00 +0100
Message-Id: <20230706132512.3534397-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706132512.3534397-1-peter.maydell@linaro.org>
References: <20230706132512.3534397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Yuquan Wang <wangyuquan1236@phytium.com.cn>

The current sbsa-ref cannot use EHCI controller which is only
able to do 32-bit DMA, since sbsa-ref doesn't have RAM below 4GB.
Hence, this uses XHCI to provide a usb controller with 64-bit
DMA capablity instead of EHCI.

We bump the platform version to 0.3 with this change.  Although the
hardware at the USB controller address changes, the firmware and
Linux can both cope with this -- on an older non-XHCI-aware
firmware/kernel setup the probe routine simply fails and the guest
proceeds without any USB.  (This isn't a loss of functionality,
because the old USB controller never worked in the first place.) So
we can call this a backwards-compatible change and only bump the
minor version.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Message-id: 20230621103847.447508-2-wangyuquan1236@phytium.com.cn
[PMM: tweaked commit message; add line to docs about what
 changes in platform version 0.3]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/sbsa.rst |  5 ++++-
 hw/arm/sbsa-ref.c        | 23 +++++++++++++----------
 hw/arm/Kconfig           |  2 +-
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/docs/system/arm/sbsa.rst b/docs/system/arm/sbsa.rst
index a8e0b530a24..bca61608ff8 100644
--- a/docs/system/arm/sbsa.rst
+++ b/docs/system/arm/sbsa.rst
@@ -19,7 +19,7 @@ The ``sbsa-ref`` board supports:
   - A configurable number of AArch64 CPUs
   - GIC version 3
   - System bus AHCI controller
-  - System bus EHCI controller
+  - System bus XHCI controller
   - CDROM and hard disc on AHCI bus
   - E1000E ethernet card on PCIe bus
   - Bochs display adapter on PCIe bus
@@ -68,3 +68,6 @@ Platform version changes:
 
 0.2
   GIC ITS information is present in devicetree.
+
+0.3
+  The USB controller is an XHCI device, not EHCI
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 82a28b2e0be..1a8519b868f 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -42,6 +42,7 @@
 #include "hw/pci-host/gpex.h"
 #include "hw/qdev-properties.h"
 #include "hw/usb.h"
+#include "hw/usb/xhci.h"
 #include "hw/char/pl011.h"
 #include "hw/watchdog/sbsa_gwdt.h"
 #include "net/net.h"
@@ -85,7 +86,7 @@ enum {
     SBSA_SECURE_UART_MM,
     SBSA_SECURE_MEM,
     SBSA_AHCI,
-    SBSA_EHCI,
+    SBSA_XHCI,
 };
 
 struct SBSAMachineState {
@@ -123,7 +124,7 @@ static const MemMapEntry sbsa_ref_memmap[] = {
     [SBSA_SMMU] =               { 0x60050000, 0x00020000 },
     /* Space here reserved for more SMMUs */
     [SBSA_AHCI] =               { 0x60100000, 0x00010000 },
-    [SBSA_EHCI] =               { 0x60110000, 0x00010000 },
+    [SBSA_XHCI] =               { 0x60110000, 0x00010000 },
     /* Space here reserved for other devices */
     [SBSA_PCIE_PIO] =           { 0x7fff0000, 0x00010000 },
     /* 32-bit address PCIE MMIO space */
@@ -143,7 +144,7 @@ static const int sbsa_ref_irqmap[] = {
     [SBSA_SECURE_UART] = 8,
     [SBSA_SECURE_UART_MM] = 9,
     [SBSA_AHCI] = 10,
-    [SBSA_EHCI] = 11,
+    [SBSA_XHCI] = 11,
     [SBSA_SMMU] = 12, /* ... to 15 */
     [SBSA_GWDT_WS0] = 16,
 };
@@ -230,7 +231,7 @@ static void create_fdt(SBSAMachineState *sms)
      *                        fw compatibility.
      */
     qemu_fdt_setprop_cell(fdt, "/", "machine-version-major", 0);
-    qemu_fdt_setprop_cell(fdt, "/", "machine-version-minor", 2);
+    qemu_fdt_setprop_cell(fdt, "/", "machine-version-minor", 3);
 
     if (ms->numa_state->have_numa_distance) {
         int size = nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32_t);
@@ -604,13 +605,15 @@ static void create_ahci(const SBSAMachineState *sms)
     }
 }
 
-static void create_ehci(const SBSAMachineState *sms)
+static void create_xhci(const SBSAMachineState *sms)
 {
-    hwaddr base = sbsa_ref_memmap[SBSA_EHCI].base;
-    int irq = sbsa_ref_irqmap[SBSA_EHCI];
+    hwaddr base = sbsa_ref_memmap[SBSA_XHCI].base;
+    int irq = sbsa_ref_irqmap[SBSA_XHCI];
+    DeviceState *dev = qdev_new(TYPE_XHCI_SYSBUS);
 
-    sysbus_create_simple("platform-ehci-usb", base,
-                         qdev_get_gpio_in(sms->gic, irq));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, qdev_get_gpio_in(sms->gic, irq));
 }
 
 static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
@@ -832,7 +835,7 @@ static void sbsa_ref_init(MachineState *machine)
 
     create_ahci(sms);
 
-    create_ehci(sms);
+    create_xhci(sms);
 
     create_pcie(sms);
 
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7de17d1e8c3..7e683484405 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -266,7 +266,7 @@ config SBSA_REF
     select PL011 # UART
     select PL031 # RTC
     select PL061 # GPIO
-    select USB_EHCI_SYSBUS
+    select USB_XHCI_SYSBUS
     select WDT_SBSA
     select BOCHS_DISPLAY
 
-- 
2.34.1


