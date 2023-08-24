Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA65786BCE
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:29:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6at-0006HB-Aa; Thu, 24 Aug 2023 05:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qZ6aM-0004Fy-Hc
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:25:10 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qZ6aH-0003jn-C8
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:25:01 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxJvHIIedkn3kbAA--.56588S3;
 Thu, 24 Aug 2023 17:24:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxJ826IedkJjhiAA--.40637S31; 
 Thu, 24 Aug 2023 17:24:24 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, richard.henderson@linaro.org,
 Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 29/31] hw/intc/loongarch_pch: fix edge triggered irq handling
Date: Thu, 24 Aug 2023 17:24:07 +0800
Message-Id: <20230824092409.1492470-30-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230824092409.1492470-1-gaosong@loongson.cn>
References: <20230824092409.1492470-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxJ826IedkJjhiAA--.40637S31
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

From: Bibo Mao <maobibo@loongson.cn>

For edge triggered irq, qemu_irq_pulse is used to inject irq. It will
set irq with high level and low level soon to simluate pulse irq.

For edge triggered irq, irq is injected and set as pending at rising
level, do not clear irq at lowering level. LoongArch pch interrupt will
clear irq for lowering level irq, there will be problem. ACPI ged deivce
is edge-triggered irq, it is used for cpu/memory hotplug.

This patch fixes memory hotplug issue on LoongArch virt machine.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20230707091557.1474790-1-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 9208fc4460..6aa4cadfa4 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -30,7 +30,11 @@ static void pch_pic_update_irq(LoongArchPCHPIC *s, uint64_t mask, int level)
             qemu_set_irq(s->parent_irq[s->htmsi_vector[irq]], 1);
         }
     } else {
-        val = mask & s->intisr;
+        /*
+         * intirr means requested pending irq
+         * do not clear pending irq for edge-triggered on lowering edge
+         */
+        val = mask & s->intisr & ~s->intirr;
         if (val) {
             irq = ctz64(val);
             s->intisr &= ~MAKE_64BIT_MASK(irq, 1);
@@ -51,6 +55,7 @@ static void pch_pic_irq_handler(void *opaque, int irq, int level)
         /* Edge triggered */
         if (level) {
             if ((s->last_intirr & mask) == 0) {
+                /* marked pending on a rising edge */
                 s->intirr |= mask;
             }
             s->last_intirr |= mask;
-- 
2.39.1


