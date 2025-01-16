Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 190C6A1312D
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Jan 2025 03:19:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYFS6-0004cx-8D; Wed, 15 Jan 2025 21:17:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tYFS0-0004bo-N1
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 21:17:42 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tYFRx-0006CN-HL
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 21:17:40 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxrnM8bIhnaTJkAA--.10971S3;
 Thu, 16 Jan 2025 10:17:32 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAx+8QnbIhnhWokAA--.14648S4;
 Thu, 16 Jan 2025 10:17:32 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PULL 2/8] hw/intc/loongarch_ipi: Implement realize interface
Date: Thu, 16 Jan 2025 10:17:04 +0800
Message-Id: <20250116021710.251648-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250116021710.251648-1-maobibo@loongson.cn>
References: <20250116021710.251648-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAx+8QnbIhnhWokAA--.14648S4
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

Add realize interface for loongarch ipi device.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_ipi.c         | 19 +++++++++++++++++++
 include/hw/intc/loongarch_ipi.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
index 2ae1a42c46..4e2f9acddf 100644
--- a/hw/intc/loongarch_ipi.c
+++ b/hw/intc/loongarch_ipi.c
@@ -7,6 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/boards.h"
+#include "qapi/error.h"
 #include "hw/intc/loongarch_ipi.h"
 #include "target/loongarch/cpu.h"
 
@@ -49,10 +50,26 @@ static CPUState *loongarch_cpu_by_arch_id(int64_t arch_id)
     return NULL;
 }
 
+static void loongarch_ipi_realize(DeviceState *dev, Error **errp)
+{
+    LoongarchIPIClass *lic = LOONGARCH_IPI_GET_CLASS(dev);
+    Error *local_err = NULL;
+
+    lic->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+}
+
 static void loongarch_ipi_class_init(ObjectClass *klass, void *data)
 {
     LoongsonIPICommonClass *licc = LOONGSON_IPI_COMMON_CLASS(klass);
+    LoongarchIPIClass *lic = LOONGARCH_IPI_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
 
+    device_class_set_parent_realize(dc, loongarch_ipi_realize,
+                                    &lic->parent_realize);
     licc->get_iocsr_as = get_iocsr_as;
     licc->cpu_by_arch_id = loongarch_cpu_by_arch_id;
 }
@@ -61,6 +78,8 @@ static const TypeInfo loongarch_ipi_types[] = {
     {
         .name               = TYPE_LOONGARCH_IPI,
         .parent             = TYPE_LOONGSON_IPI_COMMON,
+        .instance_size      = sizeof(LoongarchIPIState),
+        .class_size         = sizeof(LoongarchIPIClass),
         .class_init         = loongarch_ipi_class_init,
     }
 };
diff --git a/include/hw/intc/loongarch_ipi.h b/include/hw/intc/loongarch_ipi.h
index 276b3040a3..923bf21ecb 100644
--- a/include/hw/intc/loongarch_ipi.h
+++ b/include/hw/intc/loongarch_ipi.h
@@ -20,6 +20,7 @@ struct LoongarchIPIState {
 
 struct LoongarchIPIClass {
     LoongsonIPICommonClass parent_class;
+    DeviceRealize parent_realize;
 };
 
 #endif
-- 
2.43.5


