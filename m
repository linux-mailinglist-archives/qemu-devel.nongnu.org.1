Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3077FA81B1A
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Apr 2025 04:38:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2LJh-0006Tu-RC; Tue, 08 Apr 2025 22:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u2LJe-0006TM-Nk
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 22:37:26 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u2LJc-0007nC-3H
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 22:37:26 -0400
Received: from loongson.cn (unknown [10.2.10.34])
 by gateway (Coremail) with SMTP id _____8Ax3eJb3fVnFa+1AA--.1076S3;
 Wed, 09 Apr 2025 10:37:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.10.34])
 by front1 (Coremail) with SMTP id qMiowMBxLsdY3fVnnsR1AA--.28294S6;
 Wed, 09 Apr 2025 10:37:14 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 04/16] hw/intc/loongarch_pch: Set version information at
 initial stage
Date: Wed,  9 Apr 2025 10:36:59 +0800
Message-Id: <20250409023711.2960618-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250409023711.2960618-1-maobibo@loongson.cn>
References: <20250409023711.2960618-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxLsdY3fVnnsR1AA--.28294S6
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCrW3Gr45Kw13XF4xtrW7ZFc_yoW5CF4rpF
 W3CF9xtrWktrWxXrn3Zw15ZrnxJFnakryY9anIkF95AFs3Jry8XryktayDXa4Yg3yrJryq
 qrsIkayF9a1UZFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
 xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
 Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7
 IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k2
 6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxV
 AFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8sXo7UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Register PCH_PIC_INT_ID constains version and supported irq number
information, and it is read only register. The detailed value can
be set at initial stage, rather than read callback.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c            | 22 +++++++++++++++-------
 include/hw/intc/loongarch_pic_common.h | 17 +++++++++++++++--
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index a2d9930ac9..ae2dbdfafe 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -80,15 +80,10 @@ static uint64_t loongarch_pch_pic_low_readw(void *opaque, hwaddr addr,
 
     switch (offset) {
     case PCH_PIC_INT_ID:
-        val = PCH_PIC_INT_ID_VAL;
+        val = s->id.data & UINT_MAX;
         break;
     case PCH_PIC_INT_ID + 4:
-        /*
-         * With 7A1000 manual
-         *   bit  0-15 pch irqchip version
-         *   bit 16-31 irq number supported with pch irqchip
-         */
-        val = deposit32(PCH_PIC_INT_ID_VER, 16, 16, s->irq_num - 1);
+        val = s->id.data >> 32;
         break;
     case PCH_PIC_INT_MASK:
         val = (uint32_t)s->int_mask;
@@ -361,6 +356,19 @@ static void loongarch_pch_pic_reset(DeviceState *d)
     LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(d);
     int i;
 
+    /*
+     * With Loongson 7A1000 user manual
+     * Chapter 5.2 "Description of Interrupt-related Registers"
+     *
+     * Interrupt controller identification register 1
+     *   Bit 24-31 Interrupt Controller ID
+     * Interrupt controller identification register 2
+     *   Bit  0-7  Interrupt Controller version number
+     *   Bit 16-23 The number of interrupt sources supported
+     */
+    s->id.desc.id = PCH_PIC_INT_ID_VAL;
+    s->id.desc.version = PCH_PIC_INT_ID_VER;
+    s->id.desc.irq_num = s->irq_num - 1;
     s->int_mask = -1;
     s->htmsi_en = 0x0;
     s->intedge  = 0x0;
diff --git a/include/hw/intc/loongarch_pic_common.h b/include/hw/intc/loongarch_pic_common.h
index ef6edc15bf..fb848da4b8 100644
--- a/include/hw/intc/loongarch_pic_common.h
+++ b/include/hw/intc/loongarch_pic_common.h
@@ -10,9 +10,9 @@
 #include "hw/pci-host/ls7a.h"
 #include "hw/sysbus.h"
 
-#define PCH_PIC_INT_ID_VAL              0x7000000UL
-#define PCH_PIC_INT_ID_VER              0x1UL
 #define PCH_PIC_INT_ID                  0x00
+#define  PCH_PIC_INT_ID_VAL             0x7
+#define  PCH_PIC_INT_ID_VER             0x1
 #define PCH_PIC_INT_MASK                0x20
 #define PCH_PIC_HTMSI_EN                0x40
 #define PCH_PIC_INT_EDGE                0x60
@@ -30,10 +30,23 @@
 OBJECT_DECLARE_TYPE(LoongArchPICCommonState,
                     LoongArchPICCommonClass, LOONGARCH_PIC_COMMON)
 
+union LoongArchPIC_ID {
+    struct {
+        uint64_t _reserved_0:24;
+        uint64_t id:8;
+        uint64_t version:8;
+        uint64_t _reserved_1:8;
+        uint64_t irq_num:8;
+        uint64_t _reserved_2:8;
+    } QEMU_PACKED desc;
+    uint64_t data;
+};
+
 struct LoongArchPICCommonState {
     SysBusDevice parent_obj;
 
     qemu_irq parent_irq[64];
+    union LoongArchPIC_ID id; /* 0x00  interrupt ID register */
     uint64_t int_mask;        /* 0x020 interrupt mask register */
     uint64_t htmsi_en;        /* 0x040 1=msi */
     uint64_t intedge;         /* 0x060 edge=1 level=0 */
-- 
2.39.3


