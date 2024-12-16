Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D2A9F284B
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Dec 2024 02:58:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN0Li-0006MI-Uq; Sun, 15 Dec 2024 20:56:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tN0Lh-0006Lr-FU
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 20:56:41 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tN0Lf-0007oF-Es
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 20:56:41 -0500
Received: from loongson.cn (unknown [10.2.5.213])
 by gateway (Coremail) with SMTP id _____8AxaeDKiF9nlkBXAA--.18579S3;
 Mon, 16 Dec 2024 09:56:26 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
 by front1 (Coremail) with SMTP id qMiowMAxnsK3iF9nKNCEAA--.50112S16;
 Mon, 16 Dec 2024 09:56:26 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Subject: [PULL 14/18] hw/intc/loongarch_extioi: Add unrealize interface
Date: Mon, 16 Dec 2024 09:56:03 +0800
Message-Id: <20241216015607.1795880-15-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241216015607.1795880-1-maobibo@loongson.cn>
References: <20241216015607.1795880-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxnsK3iF9nKNCEAA--.50112S16
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

For loongarch extioi emulation driver, add unrealize interface and
remove instance_finalize interface and move the code to unrealize
interface.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongarch_extioi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index c88e99974a..cc932daaf2 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -372,9 +372,9 @@ static void loongarch_extioi_realize(DeviceState *dev, Error **errp)
     }
 }
 
-static void loongarch_extioi_finalize(Object *obj)
+static void loongarch_extioi_unrealize(DeviceState *dev)
 {
-    LoongArchExtIOI *s = LOONGARCH_EXTIOI(obj);
+    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI(dev);
 
     g_free(s->cpu);
 }
@@ -456,6 +456,7 @@ static void loongarch_extioi_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = loongarch_extioi_realize;
+    dc->unrealize = loongarch_extioi_unrealize;
     device_class_set_legacy_reset(dc, loongarch_extioi_reset);
     device_class_set_props(dc, extioi_properties);
     dc->vmsd = &vmstate_loongarch_extioi;
@@ -466,7 +467,6 @@ static const TypeInfo loongarch_extioi_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(struct LoongArchExtIOI),
     .class_init    = loongarch_extioi_class_init,
-    .instance_finalize = loongarch_extioi_finalize,
 };
 
 static void loongarch_extioi_register_types(void)
-- 
2.43.5


