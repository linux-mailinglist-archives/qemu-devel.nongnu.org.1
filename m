Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD8AA9E6EA
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Apr 2025 06:08:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9FmF-0004aM-Lb; Mon, 28 Apr 2025 00:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u9FiJ-0004Cd-6U
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 00:03:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u9FiG-0003ek-9k
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 00:03:26 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxJHAI_g5oG_3HAA--.3430S3;
 Mon, 28 Apr 2025 12:03:20 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDxvhsC_g5o63OaAA--.7484S5;
 Mon, 28 Apr 2025 12:03:20 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PULL 3/8] hw/intc/loongarch_extioi: Replace legacy reset callback
 with new api
Date: Mon, 28 Apr 2025 12:03:08 +0800
Message-Id: <20250428040313.413822-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250428040313.413822-1-maobibo@loongson.cn>
References: <20250428040313.413822-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxvhsC_g5o63OaAA--.7484S5
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

Replace legacy reset callback register device_class_set_legacy_reset()
with new function resettable_class_set_parent_phases(). With new API,
it will call reset callback of parent object and then itself.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_extioi.c         | 12 ++++++++----
 include/hw/intc/loongarch_extioi.h |  1 +
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index a558c50185..ea9752b1dc 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -377,11 +377,13 @@ static void loongarch_extioi_unrealize(DeviceState *dev)
     g_free(s->cpu);
 }
 
-static void loongarch_extioi_reset(DeviceState *d)
+static void loongarch_extioi_reset_hold(Object *obj, ResetType type)
 {
-    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(d);
+    LoongArchExtIOIClass *lec = LOONGARCH_EXTIOI_GET_CLASS(obj);
 
-    s->status = 0;
+    if (lec->parent_phases.hold) {
+        lec->parent_phases.hold(obj, type);
+    }
 }
 
 static int vmstate_extioi_post_load(void *opaque, int version_id)
@@ -406,12 +408,14 @@ static void loongarch_extioi_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     LoongArchExtIOIClass *lec = LOONGARCH_EXTIOI_CLASS(klass);
     LoongArchExtIOICommonClass *lecc = LOONGARCH_EXTIOI_COMMON_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     device_class_set_parent_realize(dc, loongarch_extioi_realize,
                                     &lec->parent_realize);
     device_class_set_parent_unrealize(dc, loongarch_extioi_unrealize,
                                       &lec->parent_unrealize);
-    device_class_set_legacy_reset(dc, loongarch_extioi_reset);
+    resettable_class_set_parent_phases(rc, NULL, loongarch_extioi_reset_hold,
+                                       NULL, &lec->parent_phases);
     lecc->post_load = vmstate_extioi_post_load;
 }
 
diff --git a/include/hw/intc/loongarch_extioi.h b/include/hw/intc/loongarch_extioi.h
index 351f18afcf..4a6ae903e9 100644
--- a/include/hw/intc/loongarch_extioi.h
+++ b/include/hw/intc/loongarch_extioi.h
@@ -22,6 +22,7 @@ struct LoongArchExtIOIClass {
 
     DeviceRealize parent_realize;
     DeviceUnrealize parent_unrealize;
+    ResettablePhases parent_phases;
 };
 
 #endif /* LOONGARCH_EXTIOI_H */
-- 
2.43.5


