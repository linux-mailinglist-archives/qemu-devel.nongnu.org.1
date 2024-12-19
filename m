Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B449F7666
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Dec 2024 08:56:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOBNS-0003jK-7k; Thu, 19 Dec 2024 02:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tOBNP-0003gm-1l
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 02:55:19 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tOBNL-0004pJ-1F
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 02:55:18 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8BxuuFd0WNniXhYAA--.45606S3;
 Thu, 19 Dec 2024 15:55:09 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxQMZX0WNnSCkCAA--.12762S6;
 Thu, 19 Dec 2024 15:55:08 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 04/18] hw/intc/loongarch_pch: Rename LoongArchPCHPIC with
 LoongArchPICCommonState
Date: Thu, 19 Dec 2024 15:54:48 +0800
Message-Id: <20241219075502.3164644-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241219075502.3164644-1-maobibo@loongson.cn>
References: <20241219075502.3164644-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxQMZX0WNnSCkCAA--.12762S6
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

With pic vmstate, rename structure name vmstate_loongarch_pch_pic with
vmstate_loongarch_pic_common, and with pic property rename
loongarch_pch_pic_properties with loongarch_pic_common_properties.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_pch_pic.c | 52 +++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
index ea87851994..60a1e82253 100644
--- a/hw/intc/loongarch_pch_pic.c
+++ b/hw/intc/loongarch_pch_pic.c
@@ -379,13 +379,25 @@ static void loongarch_pch_pic_reset(DeviceState *d)
     s->int_polarity = 0x0;
 }
 
+static void loongarch_pic_common_realize(DeviceState *dev, Error **errp)
+{
+    LoongArchPICCommonState *s = LOONGARCH_PCH_PIC(dev);
+
+    if (!s->irq_num || s->irq_num  > VIRT_PCH_PIC_IRQ_NUM) {
+        error_setg(errp, "Invalid 'pic_irq_num'");
+        return;
+    }
+}
+
 static void loongarch_pch_pic_realize(DeviceState *dev, Error **errp)
 {
     LoongArchPCHPIC *s = LOONGARCH_PCH_PIC(dev);
     SysBusDevice *sbd  = SYS_BUS_DEVICE(dev);
+    Error *local_err = NULL;
 
-    if (!s->irq_num || s->irq_num  > VIRT_PCH_PIC_IRQ_NUM) {
-        error_setg(errp, "Invalid 'pic_irq_num'");
+    loongarch_pic_common_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
         return;
     }
 
@@ -405,28 +417,28 @@ static void loongarch_pch_pic_realize(DeviceState *dev, Error **errp)
 
 }
 
-static const Property loongarch_pch_pic_properties[] = {
-    DEFINE_PROP_UINT32("pch_pic_irq_num",  LoongArchPCHPIC, irq_num, 0),
+static const Property loongarch_pic_common_properties[] = {
+    DEFINE_PROP_UINT32("pch_pic_irq_num", LoongArchPICCommonState, irq_num, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static const VMStateDescription vmstate_loongarch_pch_pic = {
-    .name = TYPE_LOONGARCH_PCH_PIC,
+static const VMStateDescription vmstate_loongarch_pic_common = {
+    .name = "loongarch_pch_pic",
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT64(int_mask, LoongArchPCHPIC),
-        VMSTATE_UINT64(htmsi_en, LoongArchPCHPIC),
-        VMSTATE_UINT64(intedge, LoongArchPCHPIC),
-        VMSTATE_UINT64(intclr, LoongArchPCHPIC),
-        VMSTATE_UINT64(auto_crtl0, LoongArchPCHPIC),
-        VMSTATE_UINT64(auto_crtl1, LoongArchPCHPIC),
-        VMSTATE_UINT8_ARRAY(route_entry, LoongArchPCHPIC, 64),
-        VMSTATE_UINT8_ARRAY(htmsi_vector, LoongArchPCHPIC, 64),
-        VMSTATE_UINT64(last_intirr, LoongArchPCHPIC),
-        VMSTATE_UINT64(intirr, LoongArchPCHPIC),
-        VMSTATE_UINT64(intisr, LoongArchPCHPIC),
-        VMSTATE_UINT64(int_polarity, LoongArchPCHPIC),
+        VMSTATE_UINT64(int_mask, LoongArchPICCommonState),
+        VMSTATE_UINT64(htmsi_en, LoongArchPICCommonState),
+        VMSTATE_UINT64(intedge, LoongArchPICCommonState),
+        VMSTATE_UINT64(intclr, LoongArchPICCommonState),
+        VMSTATE_UINT64(auto_crtl0, LoongArchPICCommonState),
+        VMSTATE_UINT64(auto_crtl1, LoongArchPICCommonState),
+        VMSTATE_UINT8_ARRAY(route_entry, LoongArchPICCommonState, 64),
+        VMSTATE_UINT8_ARRAY(htmsi_vector, LoongArchPICCommonState, 64),
+        VMSTATE_UINT64(last_intirr, LoongArchPICCommonState),
+        VMSTATE_UINT64(intirr, LoongArchPICCommonState),
+        VMSTATE_UINT64(intisr, LoongArchPICCommonState),
+        VMSTATE_UINT64(int_polarity, LoongArchPICCommonState),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -437,8 +449,8 @@ static void loongarch_pch_pic_class_init(ObjectClass *klass, void *data)
 
     dc->realize = loongarch_pch_pic_realize;
     device_class_set_legacy_reset(dc, loongarch_pch_pic_reset);
-    dc->vmsd = &vmstate_loongarch_pch_pic;
-    device_class_set_props(dc, loongarch_pch_pic_properties);
+    dc->vmsd = &vmstate_loongarch_pic_common;
+    device_class_set_props(dc, loongarch_pic_common_properties);
 }
 
 static const TypeInfo loongarch_pch_pic_info = {
-- 
2.43.5


