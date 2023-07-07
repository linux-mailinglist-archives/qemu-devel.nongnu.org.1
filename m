Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6480D74ADB1
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 11:17:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHhZX-0005GP-Mg; Fri, 07 Jul 2023 05:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1qHhZT-0005FV-UU
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:16:11 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1qHhZP-0007Du-Eu
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:16:11 -0400
Received: from loongson.cn (unknown [10.2.9.158])
 by gateway (Coremail) with SMTP id _____8CxNvHN16dk3GQBAA--.5317S3;
 Fri, 07 Jul 2023 17:15:58 +0800 (CST)
Received: from kvm-1-158.loongson.cn (unknown [10.2.9.158])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxF83N16dkiu8gAA--.28935S2; 
 Fri, 07 Jul 2023 17:15:57 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org,
	Tianrui Zhao <zhaotianrui@loongson.cn>
Subject: [PATCH] hw/intc/loongarch_pch: fix edge triggered irq handling
Date: Fri,  7 Jul 2023 17:15:57 +0800
Message-Id: <20230707091557.1474790-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxF83N16dkiu8gAA--.28935S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF17XFykXrW3WrWfAF45CFX_yoW8XrWrpF
 WDu3WYyrWkJr1fXFs5u345WryxZwsrurW3uFZakry2qas8JFyFqF1kJ3y7ZFy8K395GFW2
 vr4rGr4Yva4UGabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
 kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
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

For edge triggered irq, qemu_irq_pulse is used to inject irq. It will
set irq with high level and low level soon to simluate pulse irq.

For edge triggered irq, irq is injected and set as pending at rising
level, do not clear irq at lowering level. LoongArch pch interrupt will
clear irq for lowering level irq, there will be problem. ACPI ged deivce
is edge-triggered irq, it is used for cpu/memory hotplug.

This patch fixes memory hotplug issue on LoongArch virt machine.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
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
2.27.0


