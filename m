Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 358C471817F
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:24:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Lmu-0001WU-Uo; Wed, 31 May 2023 09:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1q4Fs3-0007zZ-On; Wed, 31 May 2023 03:03:47 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1q4Fs1-0000Qb-CL; Wed, 31 May 2023 03:03:47 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDHQthH8nZkr7ogAQ--.42979S2;
 Wed, 31 May 2023 15:07:51 +0800 (CST)
Received: from phytium.com.cn (unknown [123.150.8.50])
 by mail (Coremail) with SMTP id AQAAfwBXpi9F8XZkQlEAAA--.1437S4;
 Wed, 31 May 2023 15:03:41 +0800 (CST)
From: wangyuquan1236@phytium.com.cn
To: peter.maydell@linaro.org,
	quic_llindhol@quicinc.com
Cc: chenbaozi@phytium.com.cn, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [PATCH 1/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
Date: Wed, 31 May 2023 15:02:29 +0800
Message-Id: <20230531070229.334124-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531070229.334124-1-wangyuquan1236@phytium.com.cn>
References: <20230531070229.334124-1-wangyuquan1236@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBXpi9F8XZkQlEAAA--.1437S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAQAWR2SqoCMwAAsT
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7uryfArWDAw1kAFyrtFykAFb_yoW8uFy3pF
 4UWr4Yka18tF4rJan3uw1UWF45C393AayUZ3y3KFs7AF1DAr42grWDG3Wjk3sxXr4rZrWj
 9Fn8ur109r1Iy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 31 May 2023 09:22:49 -0400
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
able to do 32-bit DMA, since sbsa-ref doesn't have RAM above 4GB.
Hence, this uses XHCI to provide a usb controller with 64-bit
DMA capablity instead of EHCI.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Change-Id: I1376f8bbc0e25dcd9d8a22b6e061cb56b3486394
---
 hw/arm/sbsa-ref.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 792371fdce..f9c0647353 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -81,7 +81,7 @@ enum {
     SBSA_SECURE_UART_MM,
     SBSA_SECURE_MEM,
     SBSA_AHCI,
-    SBSA_EHCI,
+    SBSA_XHCI,
 };
 
 struct SBSAMachineState {
@@ -118,7 +118,7 @@ static const MemMapEntry sbsa_ref_memmap[] = {
     [SBSA_SMMU] =               { 0x60050000, 0x00020000 },
     /* Space here reserved for more SMMUs */
     [SBSA_AHCI] =               { 0x60100000, 0x00010000 },
-    [SBSA_EHCI] =               { 0x60110000, 0x00010000 },
+    [SBSA_XHCI] =               { 0x60110000, 0x00010000 },
     /* Space here reserved for other devices */
     [SBSA_PCIE_PIO] =           { 0x7fff0000, 0x00010000 },
     /* 32-bit address PCIE MMIO space */
@@ -138,7 +138,7 @@ static const int sbsa_ref_irqmap[] = {
     [SBSA_SECURE_UART] = 8,
     [SBSA_SECURE_UART_MM] = 9,
     [SBSA_AHCI] = 10,
-    [SBSA_EHCI] = 11,
+    [SBSA_XHCI] = 11,
     [SBSA_SMMU] = 12, /* ... to 15 */
     [SBSA_GWDT_WS0] = 16,
 };
@@ -558,12 +558,12 @@ static void create_ahci(const SBSAMachineState *sms)
     }
 }
 
-static void create_ehci(const SBSAMachineState *sms)
+static void create_xhci(const SBSAMachineState *sms)
 {
-    hwaddr base = sbsa_ref_memmap[SBSA_EHCI].base;
-    int irq = sbsa_ref_irqmap[SBSA_EHCI];
+    hwaddr base = sbsa_ref_memmap[SBSA_XHCI].base;
+    int irq = sbsa_ref_irqmap[SBSA_XHCI];
 
-    sysbus_create_simple("platform-ehci-usb", base,
+    sysbus_create_simple("sysbus-xhci", base,
                          qdev_get_gpio_in(sms->gic, irq));
 }
 
@@ -785,7 +785,7 @@ static void sbsa_ref_init(MachineState *machine)
 
     create_ahci(sms);
 
-    create_ehci(sms);
+    create_xhci(sms);
 
     create_pcie(sms);
 
-- 
2.34.1


