Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D34F5ACD828
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Jun 2025 08:56:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMi1w-0002MW-MZ; Wed, 04 Jun 2025 02:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uMi1s-0002Ji-BD
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 02:55:16 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uMi1q-0004uY-EQ
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 02:55:16 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8DxbKzJ7T9oXyMLAQ--.34875S3;
 Wed, 04 Jun 2025 14:55:05 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxzMTG7T9oi6wIAQ--.29739S4;
 Wed, 04 Jun 2025 14:55:05 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>
Subject: [PATCH 2/2] hw/intc/loongarch_pch: Convert to little endian with ID
 register
Date: Wed,  4 Jun 2025 14:55:02 +0800
Message-Id: <20250604065502.1114098-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250604065502.1114098-1-maobibo@loongson.cn>
References: <20250604065502.1114098-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxzMTG7T9oi6wIAQ--.29739S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
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
2.39.3


