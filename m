Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D5EAB0FF0
	for <lists+qemu-devel@lfdr.de>; Fri,  9 May 2025 12:09:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDKeC-0006EN-Aj; Fri, 09 May 2025 06:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uDKe8-0006Ap-SY
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:08:00 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uDKe5-00018W-5k
 for qemu-devel@nongnu.org; Fri, 09 May 2025 06:08:00 -0400
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8CxvnL10x1o8GLbAA--.32542S3;
 Fri, 09 May 2025 18:07:49 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMDxPcX00x1oMCfAAA--.29037S3;
 Fri, 09 May 2025 18:07:48 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH 01/15] hw/intc/loongarch_extioi: Add irqchip-in-kernel property
Date: Fri,  9 May 2025 18:07:33 +0800
Message-Id: <20250509100747.1070094-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250509100747.1070094-1-maobibo@loongson.cn>
References: <20250509100747.1070094-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMDxPcX00x1oMCfAAA--.29037S3
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

With ExtIOI irqchip, property irqchip-in-kernel is added to indicate
whether feature irqchip_in_kernel is supported or not. This property
can be enabled only if it works in KVM mode.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongarch_extioi.c         | 14 ++++++++++++++
 include/hw/intc/loongarch_extioi.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index 7c38c4c9b7..a737d49b12 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -11,7 +11,9 @@
 #include "qapi/error.h"
 #include "hw/irq.h"
 #include "hw/loongarch/virt.h"
+#include "hw/qdev-properties.h"
 #include "system/address-spaces.h"
+#include "system/kvm.h"
 #include "hw/intc/loongarch_extioi.h"
 #include "trace.h"
 
@@ -341,6 +343,7 @@ static void loongarch_extioi_realize(DeviceState *dev, Error **errp)
 {
     LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(dev);
     LoongArchExtIOIClass *lec = LOONGARCH_EXTIOI_GET_CLASS(dev);
+    LoongArchExtIOIState *les = LOONGARCH_EXTIOI(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     Error *local_err = NULL;
     int i;
@@ -351,6 +354,11 @@ static void loongarch_extioi_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (les->irqchip_in_kernel && !kvm_enabled()) {
+        error_setg(errp, "ExtIOI irqchip_in_kernel works only in kvm mode");
+        return;
+    }
+
     for (i = 0; i < EXTIOI_IRQS; i++) {
         sysbus_init_irq(sbd, &s->irq[i]);
     }
@@ -403,6 +411,11 @@ static int vmstate_extioi_post_load(void *opaque, int version_id)
     return 0;
 }
 
+static const Property loongarch_extioi_properties[] = {
+    DEFINE_PROP_BOOL("irqchip-in-kernel", LoongArchExtIOIState,
+                     irqchip_in_kernel, false),
+};
+
 static void loongarch_extioi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -416,6 +429,7 @@ static void loongarch_extioi_class_init(ObjectClass *klass, const void *data)
                                       &lec->parent_unrealize);
     resettable_class_set_parent_phases(rc, NULL, loongarch_extioi_reset_hold,
                                        NULL, &lec->parent_phases);
+    device_class_set_props(dc, loongarch_extioi_properties);
     lecc->post_load = vmstate_extioi_post_load;
 }
 
diff --git a/include/hw/intc/loongarch_extioi.h b/include/hw/intc/loongarch_extioi.h
index 4a6ae903e9..c1d79d0a40 100644
--- a/include/hw/intc/loongarch_extioi.h
+++ b/include/hw/intc/loongarch_extioi.h
@@ -15,6 +15,7 @@ OBJECT_DECLARE_TYPE(LoongArchExtIOIState, LoongArchExtIOIClass, LOONGARCH_EXTIOI
 
 struct LoongArchExtIOIState {
     LoongArchExtIOICommonState parent_obj;
+    bool irqchip_in_kernel;
 };
 
 struct LoongArchExtIOIClass {
-- 
2.39.3


