Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91190AD2FB4
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Jun 2025 10:18:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOu9v-0004oy-R9; Tue, 10 Jun 2025 04:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uOu9q-0004mr-2T
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 04:16:35 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uOu9m-0000Sq-9x
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 04:16:33 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx63Ha6UdobH0SAQ--.46118S3;
 Tue, 10 Jun 2025 16:16:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxb8fT6UdojgwUAQ--.58593S4;
 Tue, 10 Jun 2025 16:16:25 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
	Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 2/7] hw/intc/loongarch_pch: Convert to little endian with ID
 register
Date: Tue, 10 Jun 2025 15:53:45 +0800
Message-Id: <20250610075350.865626-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250610075350.865626-1-gaosong@loongson.cn>
References: <20250610075350.865626-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxb8fT6UdojgwUAQ--.58593S4
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Bibo Mao <maobibo@loongson.cn>

With PCH ID register, it is defined as union type as follows:
union LoongArchPIC_ID {
    struct {
        uint8_t _reserved_0[3];
        uint8_t id;
        uint8_t version;
        uint8_t _reserved_1;
        uint8_t irq_num;
        uint8_t _reserved_2;
    } QEMU_PACKED desc;
    uint64_t data;
}

And with pch driver in virt machine irq_number is parsed with little
endian method:
  vec_count = ((readq(priv->base) >> 48) & 0xff) + 1

So the value of ID register should be converted to little endian.
With this patch, linux kernel passes to run on S390 big endian host
machine with TCG method.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20250604065502.1114098-3-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index cbba2fc284..ebb33ed0b0 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -82,7 +82,7 @@ static uint64_t pch_pic_read(void *opaque, hwaddr addr, uint64_t field_mask)
     addr -= offset;
     switch (addr) {
     case PCH_PIC_INT_ID:
-        val = s->id.data;
+        val = cpu_to_le64(s->id.data);
         break;
     case PCH_PIC_INT_MASK:
         val = s->int_mask;
-- 
2.34.1


