Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDECA6D7A7
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Mar 2025 10:39:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tweFq-0007Kw-Qg; Mon, 24 Mar 2025 05:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tweFp-0007Kg-9J
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 05:37:57 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tweFn-0001TK-AL
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 05:37:57 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bx367mJ+FnSvujAA--.60848S3;
 Mon, 24 Mar 2025 17:37:42 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMCxPsfaJ+FnGn1dAA--.15661S13;
 Mon, 24 Mar 2025 17:37:42 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 11/16] hw/intc/loongarch_pch: Use generic write callback
 for iomem32_high region
Date: Mon, 24 Mar 2025 17:37:25 +0800
Message-Id: <20250324093730.3683378-12-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250324093730.3683378-1-maobibo@loongson.cn>
References: <20250324093730.3683378-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxPsfaJ+FnGn1dAA--.15661S13
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

Add iomem32_high region register write operation emulation in generic
write function loongarch_pch_pic_write(), and use this function for
iomem32_high region.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index d5a8c8377d..83148a234b 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -158,6 +158,9 @@ static void pch_pic_write(void *opaque, hwaddr addr, uint64_t value,
     case PCH_PIC_AUTO_CTRL1 ... PCH_PIC_AUTO_CTRL1 + 7:
         /* Discard auto_ctrl access */
         break;
+    case PCH_PIC_INT_POL ... PCH_PIC_INT_POL + 7:
+        s->int_polarity = (s->int_polarity & ~mask) | data;
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "pch_pic_write: Bad address 0x%"PRIx64"\n", addr);
@@ -226,14 +229,6 @@ static uint64_t loongarch_pch_pic_low_readw(void *opaque, hwaddr addr,
     return val;
 }
 
-static uint64_t get_writew_val(uint64_t value, uint32_t target, bool hi)
-{
-    uint64_t mask = 0xffffffff00000000;
-    uint64_t data = target;
-
-    return hi ? (value & ~mask) | (data << 32) : (value & mask) | data;
-}
-
 static void loongarch_pch_pic_low_writew(void *opaque, hwaddr addr,
                                          uint64_t value, unsigned size)
 {
@@ -255,22 +250,9 @@ static uint64_t loongarch_pch_pic_high_readw(void *opaque, hwaddr addr,
 static void loongarch_pch_pic_high_writew(void *opaque, hwaddr addr,
                                      uint64_t value, unsigned size)
 {
-    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
-    uint32_t data = (uint32_t)value;
-
     addr += PCH_PIC_INT_STATUS;
-    trace_loongarch_pch_pic_high_writew(size, addr, data);
-
-    switch (addr) {
-    case PCH_PIC_INT_POL:
-        s->int_polarity = get_writew_val(s->int_polarity, data, 0);
-        break;
-    case PCH_PIC_INT_POL + 4:
-        s->int_polarity = get_writew_val(s->int_polarity, data, 1);
-        break;
-    default:
-        break;
-    }
+    trace_loongarch_pch_pic_high_writew(size, addr, value);
+    loongarch_pch_pic_write(opaque, addr, value, size);
 }
 
 static uint64_t loongarch_pch_pic_readb(void *opaque, hwaddr addr,
-- 
2.39.3


