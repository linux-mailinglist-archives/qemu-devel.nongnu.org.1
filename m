Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F35BE721C7A
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 05:20:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q60kK-0006EX-Pc; Sun, 04 Jun 2023 23:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1q60kH-0006EH-NN
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 23:19:01 -0400
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1q60kF-0006Jx-Er
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 23:19:01 -0400
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx5OEZVH1k+xwAAA--.559S3; 
 Mon, 05 Jun 2023 11:18:51 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 1/1] hw/intc/loongarch_ipi: Bring back all 4 IPI mailboxes
Date: Mon,  5 Jun 2023 11:18:48 +0800
Message-Id: <20230605031848.1428047-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230605031848.1428047-1-gaosong@loongson.cn>
References: <20230605031848.1428047-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx5OEZVH1k+xwAAA--.559S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW3CrWxWFyrKF4kXF4fZrb_yoW8KFyUpr
 9ruay5Xr48WF47AFWkWa4DWFW5CFZ3Wr129F4YkFy8WF4UXr1Fv34vyrn2qa48A34fXr9I
 vr4fWa4UX3W7ZwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

As per "Loongson 3A5000/3B5000 Processor Reference Manual",
Loongson 3A5000's IPI implementation have 4 mailboxes per
core.

However, in 78464f023b54 ("hw/loongarch/virt: Modify ipi as
percpu device"), the number of IPI mailboxes was reduced to
one, which mismatches actual hardware.

It won't affect LoongArch based system as LoongArch boot code
only uses the first mailbox, however MIPS based Loongson boot
code uses all 4 mailboxes.

Fixes Coverity CID: 1512452, 1512453
Fixes: 78464f023b54 ("hw/loongarch/virt: Modify ipi as percpu device")
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20230521102307.87081-2-jiaxun.yang@flygoat.com>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_ipi.c         | 6 +++---
 include/hw/intc/loongarch_ipi.h | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index d6ab91721e..3e45381652 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -238,14 +238,14 @@ static void loongarch_ipi_init(Object *obj)
 
 static const VMStateDescription vmstate_ipi_core = {
     .name = "ipi-single",
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(status, IPICore),
         VMSTATE_UINT32(en, IPICore),
         VMSTATE_UINT32(set, IPICore),
         VMSTATE_UINT32(clear, IPICore),
-        VMSTATE_UINT32_ARRAY(buf, IPICore, 2),
+        VMSTATE_UINT32_ARRAY(buf, IPICore, IPI_MBX_NUM * 2),
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/include/hw/intc/loongarch_ipi.h b/include/hw/intc/loongarch_ipi.h
index 664e050b92..6c6194786e 100644
--- a/include/hw/intc/loongarch_ipi.h
+++ b/include/hw/intc/loongarch_ipi.h
@@ -28,6 +28,8 @@
 #define MAIL_SEND_OFFSET      0
 #define ANY_SEND_OFFSET       (IOCSR_ANY_SEND - IOCSR_MAIL_SEND)
 
+#define IPI_MBX_NUM           4
+
 #define TYPE_LOONGARCH_IPI "loongarch_ipi"
 OBJECT_DECLARE_SIMPLE_TYPE(LoongArchIPI, LOONGARCH_IPI)
 
@@ -37,7 +39,7 @@ typedef struct IPICore {
     uint32_t set;
     uint32_t clear;
     /* 64bit buf divide into 2 32bit buf */
-    uint32_t buf[2];
+    uint32_t buf[IPI_MBX_NUM * 2];
     qemu_irq irq;
 } IPICore;
 
-- 
2.39.1


