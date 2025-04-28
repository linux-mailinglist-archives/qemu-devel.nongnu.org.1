Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A434FA9E6F0
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Apr 2025 06:09:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9FmL-0004jn-DB; Mon, 28 Apr 2025 00:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1u9FiJ-0004Cf-BV
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 00:03:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1u9FiG-0003ef-Ac
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 00:03:27 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxLGsI_g5oGf3HAA--.3600S3;
 Mon, 28 Apr 2025 12:03:20 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDxvhsC_g5o63OaAA--.7484S4;
 Mon, 28 Apr 2025 12:03:19 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Subject: [PULL 2/8] hw/intc/loongarch_extioi: Add reset support
Date: Mon, 28 Apr 2025 12:03:07 +0800
Message-Id: <20250428040313.413822-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250428040313.413822-1-maobibo@loongson.cn>
References: <20250428040313.413822-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxvhsC_g5o63OaAA--.7484S4
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

Add reset support with extioi irqchip, and register reset callback
support with new API resettable_class_set_parent_phases(). Clear
internal HW registers and SW state when virt machine resets.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_extioi_common.c         | 41 +++++++++++++++++++++++
 include/hw/intc/loongarch_extioi_common.h |  1 +
 2 files changed, 42 insertions(+)

diff --git a/hw/intc/loongarch_extioi_common.c b/hw/intc/loongarch_extioi_common.c
index ff3974f2a1..3a9d8c8657 100644
--- a/hw/intc/loongarch_extioi_common.c
+++ b/hw/intc/loongarch_extioi_common.c
@@ -108,6 +108,43 @@ static void loongarch_extioi_common_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static void loongarch_extioi_common_reset_hold(Object *obj, ResetType type)
+{
+    LoongArchExtIOICommonClass *lecc = LOONGARCH_EXTIOI_COMMON_GET_CLASS(obj);
+    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(obj);
+    ExtIOICore *core;
+    int i;
+
+    if (lecc->parent_phases.hold) {
+        lecc->parent_phases.hold(obj, type);
+    }
+
+    /* Clear HW registers for the board */
+    memset(s->nodetype, 0, sizeof(s->nodetype));
+    memset(s->bounce, 0, sizeof(s->bounce));
+    memset(s->isr, 0, sizeof(s->isr));
+    memset(s->enable, 0, sizeof(s->enable));
+    memset(s->ipmap, 0, sizeof(s->ipmap));
+    memset(s->coremap, 0, sizeof(s->coremap));
+    memset(s->sw_pending, 0, sizeof(s->sw_pending));
+    memset(s->sw_ipmap, 0, sizeof(s->sw_ipmap));
+    memset(s->sw_coremap, 0, sizeof(s->sw_coremap));
+
+    for (i = 0; i < s->num_cpu; i++) {
+        core = s->cpu + i;
+        /* EXTIOI with targeted CPU available however not present */
+        if (!core->cpu) {
+            continue;
+        }
+
+        /* Clear HW registers for CPUs */
+        memset(core->coreisr, 0, sizeof(core->coreisr));
+        memset(core->sw_isr, 0, sizeof(core->sw_isr));
+    }
+
+    s->status = 0;
+}
+
 static int loongarch_extioi_common_pre_save(void *opaque)
 {
     LoongArchExtIOICommonState *s = (LoongArchExtIOICommonState *)opaque;
@@ -179,9 +216,13 @@ static void loongarch_extioi_common_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     LoongArchExtIOICommonClass *lecc = LOONGARCH_EXTIOI_COMMON_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     device_class_set_parent_realize(dc, loongarch_extioi_common_realize,
                                     &lecc->parent_realize);
+    resettable_class_set_parent_phases(rc, NULL,
+                                       loongarch_extioi_common_reset_hold,
+                                       NULL, &lecc->parent_phases);
     device_class_set_props(dc, extioi_properties);
     dc->vmsd = &vmstate_loongarch_extioi;
     hc->plug = loongarch_extioi_cpu_plug;
diff --git a/include/hw/intc/loongarch_extioi_common.h b/include/hw/intc/loongarch_extioi_common.h
index 22d7880977..735bfee80a 100644
--- a/include/hw/intc/loongarch_extioi_common.h
+++ b/include/hw/intc/loongarch_extioi_common.h
@@ -94,6 +94,7 @@ struct LoongArchExtIOICommonClass {
     SysBusDeviceClass parent_class;
 
     DeviceRealize parent_realize;
+    ResettablePhases parent_phases;
     int (*pre_save)(void *s);
     int (*post_load)(void *s, int version_id);
 };
-- 
2.43.5


