Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F27933BC0
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jul 2024 13:06:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2SG-0008RE-VG; Wed, 17 Jul 2024 07:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@intel-mbp.local>)
 id 1sU2SE-0008JS-EE
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:14 -0400
Received: from 89-104-8-17.customer.bnet.at ([89.104.8.17]
 helo=intel-mbp.local) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <phil@intel-mbp.local>) id 1sU2SC-0006zP-Qr
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:14 -0400
Received: by intel-mbp.local (Postfix, from userid 501)
 id DB34937960D; Mon, 15 Jul 2024 23:07:37 +0200 (CEST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, agraf@csgraf.de,
 graf@amazon.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, peter.maydell@linaro.org,
 akihiko.odaki@daynix.com, phil@philjordan.eu, lists@philjordan.eu
Subject: [PATCH 04/26] hw/display/apple-gfx: uses DEFINE_TYPES macro
Date: Mon, 15 Jul 2024 23:06:43 +0200
Message-Id: <20240715210705.32365-5-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240715210705.32365-1-phil@philjordan.eu>
References: <20240715210705.32365-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=89.104.8.17; envelope-from=phil@intel-mbp.local;
 helo=intel-mbp.local
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, KHOP_HELO_FCRDNS=0.261,
 NO_DNS_FOR_FROM=0.001, RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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

Switches the device definition to the more modern macro variants.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/display/apple-gfx.m | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 3b437e2519..87bcdcd98e 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -86,10 +86,8 @@ -(void)mmioWriteAtOffset:(size_t) offset value:(uint32_t)value;
 typedef QTAILQ_HEAD(, AppleGFXTask) AppleGFXTaskList;
 
 typedef struct AppleGFXState {
-    /* Private */
     SysBusDevice parent_obj;
 
-    /* Public */
     qemu_irq irq_gfx;
     qemu_irq irq_iosfc;
     MemoryRegion iomem_gfx;
@@ -562,17 +560,14 @@ static void apple_gfx_class_init(ObjectClass *klass, void *data)
     dc->realize = apple_gfx_realize;
 }
 
-static TypeInfo apple_gfx_info = {
-    .name          = TYPE_APPLE_GFX,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(AppleGFXState),
-    .class_init    = apple_gfx_class_init,
-    .instance_init = apple_gfx_init,
+static TypeInfo apple_gfx_types[] = {
+    {
+        .name          = TYPE_APPLE_GFX,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(AppleGFXState),
+        .class_init    = apple_gfx_class_init,
+        .instance_init = apple_gfx_init,
+    }
 };
 
-static void apple_gfx_register_types(void)
-{
-    type_register_static(&apple_gfx_info);
-}
-
-type_init(apple_gfx_register_types)
+DEFINE_TYPES(apple_gfx_types)
-- 
2.39.3 (Apple Git-146)


