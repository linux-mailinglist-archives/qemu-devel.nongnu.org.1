Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F51725220
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 04:35:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6j04-00069c-4h; Tue, 06 Jun 2023 22:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1q6izz-00068j-Vc; Tue, 06 Jun 2023 22:34:11 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1q6izv-0007VG-PN; Tue, 06 Jun 2023 22:34:11 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBHLZgv7H9kfKaEAg--.41412S2;
 Wed, 07 Jun 2023 10:32:15 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
 by mail (Coremail) with SMTP id AQAAfwBXhEyF7H9k9zkAAA--.329S4;
 Wed, 07 Jun 2023 10:33:44 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: rad@semihalf.com,
	peter.maydell@linaro.org,
	pbonzini@redhat.com
Cc: marcin.juszkiewicz@linaro.org, quic_llindhol@quicinc.com,
 chenbaozi@phytium.com.cn, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH v4 1/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
Date: Wed,  7 Jun 2023 10:33:14 +0800
Message-Id: <20230607023314.192439-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607023314.192439-1-wangyuquan1236@phytium.com.cn>
References: <20230607023314.192439-1-wangyuquan1236@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBXhEyF7H9k9zkAAA--.329S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQADAWR-hSkBAAAAs1
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxXrW5Kw15uw4DAw18uFy3Arb_yoW5tryUpF
 48urs0gr40yF1rJa9xu3Z7WF45u3ykA3WUArW7Can7ZFyDAr42grWkGay2k3s8JrZ8urWj
 9Fn7WFy8Xr13Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

The current sbsa-ref cannot use EHCI controller which is only
able to do 32-bit DMA, since sbsa-ref doesn't have RAM below 4GB.
Hence, this uses system bus XHCI to provide a usb controller with
64-bit DMA capablity instead of EHCI.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 docs/system/arm/sbsa.rst |  2 +-
 hw/arm/Kconfig           |  2 +-
 hw/arm/sbsa-ref.c        | 21 ++++++++++++---------
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/docs/system/arm/sbsa.rst b/docs/system/arm/sbsa.rst
index 016776aed8..1751ba0d21 100644
--- a/docs/system/arm/sbsa.rst
+++ b/docs/system/arm/sbsa.rst
@@ -24,7 +24,7 @@ The sbsa-ref board supports:
   - A configurable number of AArch64 CPUs
   - GIC version 3
   - System bus AHCI controller
-  - System bus EHCI controller
+  - System bus XHCI controller
   - CDROM and hard disc on AHCI bus
   - E1000E ethernet card on PCIe bus
   - Bochs display adapter on PCIe bus
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index acc4371a4a..ab884ad319 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -266,7 +266,7 @@ config SBSA_REF
     select PL011 # UART
     select PL031 # RTC
     select PL061 # GPIO
-    select USB_EHCI_SYSBUS
+    select USB_XHCI_SYSBUS
     select WDT_SBSA
 
 config SABRELITE
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index de21200ff9..4fb65704d4 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -40,6 +40,7 @@
 #include "hw/pci-host/gpex.h"
 #include "hw/qdev-properties.h"
 #include "hw/usb.h"
+#include "hw/usb/xhci.h"
 #include "hw/char/pl011.h"
 #include "hw/watchdog/sbsa_gwdt.h"
 #include "net/net.h"
@@ -82,7 +83,7 @@ enum {
     SBSA_SECURE_UART_MM,
     SBSA_SECURE_MEM,
     SBSA_AHCI,
-    SBSA_EHCI,
+    SBSA_XHCI,
 };
 
 struct SBSAMachineState {
@@ -119,7 +120,7 @@ static const MemMapEntry sbsa_ref_memmap[] = {
     [SBSA_SMMU] =               { 0x60050000, 0x00020000 },
     /* Space here reserved for more SMMUs */
     [SBSA_AHCI] =               { 0x60100000, 0x00010000 },
-    [SBSA_EHCI] =               { 0x60110000, 0x00010000 },
+    [SBSA_XHCI] =               { 0x60110000, 0x00010000 },
     /* Space here reserved for other devices */
     [SBSA_PCIE_PIO] =           { 0x7fff0000, 0x00010000 },
     /* 32-bit address PCIE MMIO space */
@@ -139,7 +140,7 @@ static const int sbsa_ref_irqmap[] = {
     [SBSA_SECURE_UART] = 8,
     [SBSA_SECURE_UART_MM] = 9,
     [SBSA_AHCI] = 10,
-    [SBSA_EHCI] = 11,
+    [SBSA_XHCI] = 11,
     [SBSA_SMMU] = 12, /* ... to 15 */
     [SBSA_GWDT_WS0] = 16,
 };
@@ -575,13 +576,15 @@ static void create_ahci(const SBSAMachineState *sms)
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
@@ -803,7 +806,7 @@ static void sbsa_ref_init(MachineState *machine)
 
     create_ahci(sms);
 
-    create_ehci(sms);
+    create_xhci(sms);
 
     create_pcie(sms);
 
-- 
2.34.1


