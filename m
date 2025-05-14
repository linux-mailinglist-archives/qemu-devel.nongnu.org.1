Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD37AB6522
	for <lists+qemu-devel@lfdr.de>; Wed, 14 May 2025 10:03:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF74C-0002ar-MO; Wed, 14 May 2025 04:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uF74A-0002aD-0J
 for qemu-devel@nongnu.org; Wed, 14 May 2025 04:02:14 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uF748-0002CG-0W
 for qemu-devel@nongnu.org; Wed, 14 May 2025 04:02:13 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxjmsCTiRoyFbmAA--.46430S3;
 Wed, 14 May 2025 16:02:10 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMBxn8XkTSRofwHRAA--.9319S10;
 Wed, 14 May 2025 16:02:06 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
	maobibo@loongson.cn
Subject: [PULL 08/17] hw/intc/loongarch_pch: Use generic read callback for
 iomem32_high region
Date: Wed, 14 May 2025 15:39:18 +0800
Message-Id: <20250514073927.2424543-9-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250514073927.2424543-1-gaosong@loongson.cn>
References: <20250514073927.2424543-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxn8XkTSRofwHRAA--.9319S10
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

Add register read operation emulation in generic read function
loongarch_pch_pic_read(), and use this function for iomem32_high region.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20250507023148.1877287-9-maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index 599a27197f..e477a6033b 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -97,6 +97,12 @@ static uint64_t pch_pic_read(void *opaque, hwaddr addr, uint64_t field_mask)
     case PCH_PIC_AUTO_CTRL1:
         /* PCH PIC connect to EXTIOI always, discard auto_ctrl access */
         break;
+    case PCH_PIC_INT_STATUS:
+        val = s->intisr & (~s->int_mask);
+        break;
+    case PCH_PIC_INT_POL:
+        val = s->int_polarity;
+        break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "pch_pic_read: Bad address 0x%"PRIx64"\n", addr);
@@ -226,27 +232,10 @@ static void loongarch_pch_pic_low_writew(void *opaque, hwaddr addr,
 static uint64_t loongarch_pch_pic_high_readw(void *opaque, hwaddr addr,
                                         unsigned size)
 {
-    LoongArchPICCommonState *s = LOONGARCH_PIC_COMMON(opaque);
-    uint64_t val = 0;
+    uint64_t val;
 
     addr += PCH_PIC_INT_STATUS;
-    switch (addr) {
-    case PCH_PIC_INT_STATUS:
-        val = (uint32_t)(s->intisr & (~s->int_mask));
-        break;
-    case PCH_PIC_INT_STATUS + 4:
-        val = (s->intisr & (~s->int_mask)) >> 32;
-        break;
-    case PCH_PIC_INT_POL:
-        val = (uint32_t)s->int_polarity;
-        break;
-    case PCH_PIC_INT_POL + 4:
-        val = s->int_polarity >> 32;
-        break;
-    default:
-        break;
-    }
-
+    val = loongarch_pch_pic_read(opaque, addr, size);
     trace_loongarch_pch_pic_high_readw(size, addr, val);
     return val;
 }
-- 
2.34.1


