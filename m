Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B38D9B0142D
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Jul 2025 09:16:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua7xC-0002qf-9a; Fri, 11 Jul 2025 03:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1ua7wc-0002VU-Rq
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 03:13:18 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1ua7wZ-00044K-RD
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 03:13:18 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8Bx63GDuXBo8gUnAQ--.17188S3;
 Fri, 11 Jul 2025 15:13:07 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowJCxM+R_uXBoo28SAA--.39054S3;
 Fri, 11 Jul 2025 15:13:07 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PULL v2 1/4] hw/intc/loongarch_extioi: Move unrealize function to
 common code
Date: Fri, 11 Jul 2025 15:12:59 +0800
Message-Id: <20250711071302.742014-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250711071302.742014-1-maobibo@loongson.cn>
References: <20250711071302.742014-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxM+R_uXBoo28SAA--.39054S3
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

Memory about LoongArchExtIOICommonState::cpu is allocated in common
code, it had better be freed in common code also.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_extioi.c                | 9 ---------
 hw/intc/loongarch_extioi_common.c         | 9 +++++++++
 include/hw/intc/loongarch_extioi.h        | 1 -
 include/hw/intc/loongarch_extioi_common.h | 1 +
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index 8b8ac6b187..3e9c88d1d9 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -377,13 +377,6 @@ static void loongarch_extioi_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void loongarch_extioi_unrealize(DeviceState *dev)
-{
-    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(dev);
-
-    g_free(s->cpu);
-}
-
 static void loongarch_extioi_reset_hold(Object *obj, ResetType type)
 {
     LoongArchExtIOIClass *lec = LOONGARCH_EXTIOI_GET_CLASS(obj);
@@ -436,8 +429,6 @@ static void loongarch_extioi_class_init(ObjectClass *klass, const void *data)
 
     device_class_set_parent_realize(dc, loongarch_extioi_realize,
                                     &lec->parent_realize);
-    device_class_set_parent_unrealize(dc, loongarch_extioi_unrealize,
-                                      &lec->parent_unrealize);
     resettable_class_set_parent_phases(rc, NULL, loongarch_extioi_reset_hold,
                                        NULL, &lec->parent_phases);
     lecc->pre_save  = vmstate_extioi_pre_save;
diff --git a/hw/intc/loongarch_extioi_common.c b/hw/intc/loongarch_extioi_common.c
index 4a904b3bc1..ba03383ed1 100644
--- a/hw/intc/loongarch_extioi_common.c
+++ b/hw/intc/loongarch_extioi_common.c
@@ -108,6 +108,13 @@ static void loongarch_extioi_common_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static void loongarch_extioi_common_unrealize(DeviceState *dev)
+{
+    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(dev);
+
+    g_free(s->cpu);
+}
+
 static void loongarch_extioi_common_reset_hold(Object *obj, ResetType type)
 {
     LoongArchExtIOICommonClass *lecc = LOONGARCH_EXTIOI_COMMON_GET_CLASS(obj);
@@ -221,6 +228,8 @@ static void loongarch_extioi_common_class_init(ObjectClass *klass,
 
     device_class_set_parent_realize(dc, loongarch_extioi_common_realize,
                                     &lecc->parent_realize);
+    device_class_set_parent_unrealize(dc, loongarch_extioi_common_unrealize,
+                                      &lecc->parent_unrealize);
     resettable_class_set_parent_phases(rc, NULL,
                                        loongarch_extioi_common_reset_hold,
                                        NULL, &lecc->parent_phases);
diff --git a/include/hw/intc/loongarch_extioi.h b/include/hw/intc/loongarch_extioi.h
index 9be1d736ea..4795bdc15f 100644
--- a/include/hw/intc/loongarch_extioi.h
+++ b/include/hw/intc/loongarch_extioi.h
@@ -22,7 +22,6 @@ struct LoongArchExtIOIClass {
     LoongArchExtIOICommonClass parent_class;
 
     DeviceRealize parent_realize;
-    DeviceUnrealize parent_unrealize;
     ResettablePhases parent_phases;
 };
 
diff --git a/include/hw/intc/loongarch_extioi_common.h b/include/hw/intc/loongarch_extioi_common.h
index dca25ff893..c021ccee0f 100644
--- a/include/hw/intc/loongarch_extioi_common.h
+++ b/include/hw/intc/loongarch_extioi_common.h
@@ -94,6 +94,7 @@ struct LoongArchExtIOICommonClass {
     SysBusDeviceClass parent_class;
 
     DeviceRealize parent_realize;
+    DeviceUnrealize parent_unrealize;
     ResettablePhases parent_phases;
     int (*pre_save)(void *s);
     int (*post_load)(void *s, int version_id);
-- 
2.43.5


