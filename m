Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB087D6615
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:02:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvZkH-0008AV-Oy; Wed, 25 Oct 2023 05:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=4l40=GH=kaod.org=clg@ozlabs.org>)
 id 1qvZjz-00088P-KW; Wed, 25 Oct 2023 04:59:51 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=4l40=GH=kaod.org=clg@ozlabs.org>)
 id 1qvZjx-0004WJ-8D; Wed, 25 Oct 2023 04:59:51 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SFjYD26z0z4wwG;
 Wed, 25 Oct 2023 19:59:44 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SFjYB5SXvz4wnw;
 Wed, 25 Oct 2023 19:59:42 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 08/12] hw/arm/aspeed: Introduce TYPE_ASPEED2400_SOC
Date: Wed, 25 Oct 2023 10:59:17 +0200
Message-ID: <20231025085921.733686-9-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025085921.733686-1-clg@kaod.org>
References: <20231025085921.733686-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=4l40=GH=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

TYPE_ASPEED2400_SOC inherits from TYPE_ASPEED_SOC.
In few commits we'll add more fields, but to keep
review process simple, don't add any yet.

TYPE_ASPEED_SOC is common to various Aspeed SoCs,
define it in aspeed_soc_common.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/arm/aspeed_soc.h |  7 +++++
 hw/arm/aspeed_soc.c         | 61 +++++++++++--------------------------
 hw/arm/aspeed_soc_common.c  | 29 ++++++++++++++++++
 3 files changed, 53 insertions(+), 44 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 103b1598f64a..ee7926b81cc6 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -101,6 +101,13 @@ struct AspeedSoCState {
 #define TYPE_ASPEED_SOC "aspeed-soc"
 OBJECT_DECLARE_TYPE(AspeedSoCState, AspeedSoCClass, ASPEED_SOC)
 
+struct Aspeed2400SoCState {
+    AspeedSoCState parent;
+};
+
+#define TYPE_ASPEED2400_SOC "aspeed2400-soc"
+OBJECT_DECLARE_SIMPLE_TYPE(Aspeed2400SoCState, ASPEED2400_SOC)
+
 struct Aspeed2600SoCState {
     AspeedSoCState parent;
 };
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 191276a3203d..dfb97f6dbd78 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -497,29 +497,6 @@ static void aspeed_ast2400_soc_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
                        aspeed_soc_get_irq(s, ASPEED_DEV_HACE));
 }
-static Property aspeed_soc_properties[] = {
-    DEFINE_PROP_LINK("memory", AspeedSoCState, memory, TYPE_MEMORY_REGION,
-                     MemoryRegion *),
-    DEFINE_PROP_LINK("dram", AspeedSoCState, dram_mr, TYPE_MEMORY_REGION,
-                     MemoryRegion *),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void aspeed_soc_class_init(ObjectClass *oc, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(oc);
-
-    device_class_set_props(dc, aspeed_soc_properties);
-}
-
-static const TypeInfo aspeed_soc_type_info = {
-    .name           = TYPE_ASPEED_SOC,
-    .parent         = TYPE_DEVICE,
-    .instance_size  = sizeof(AspeedSoCState),
-    .class_size     = sizeof(AspeedSoCClass),
-    .class_init     = aspeed_soc_class_init,
-    .abstract       = true,
-};
 
 static void aspeed_soc_ast2400_class_init(ObjectClass *oc, void *data)
 {
@@ -545,14 +522,6 @@ static void aspeed_soc_ast2400_class_init(ObjectClass *oc, void *data)
     sc->get_irq      = aspeed_soc_ast2400_get_irq;
 }
 
-static const TypeInfo aspeed_soc_ast2400_type_info = {
-    .name           = "ast2400-a1",
-    .parent         = TYPE_ASPEED_SOC,
-    .instance_init  = aspeed_ast2400_soc_init,
-    .instance_size  = sizeof(AspeedSoCState),
-    .class_init     = aspeed_soc_ast2400_class_init,
-};
-
 static void aspeed_soc_ast2500_class_init(ObjectClass *oc, void *data)
 {
     AspeedSoCClass *sc = ASPEED_SOC_CLASS(oc);
@@ -577,18 +546,22 @@ static void aspeed_soc_ast2500_class_init(ObjectClass *oc, void *data)
     sc->get_irq      = aspeed_soc_ast2400_get_irq;
 }
 
-static const TypeInfo aspeed_soc_ast2500_type_info = {
-    .name           = "ast2500-a1",
-    .parent         = TYPE_ASPEED_SOC,
-    .instance_init  = aspeed_ast2400_soc_init,
-    .instance_size  = sizeof(AspeedSoCState),
-    .class_init     = aspeed_soc_ast2500_class_init,
-};
-static void aspeed_soc_register_types(void)
-{
-    type_register_static(&aspeed_soc_type_info);
-    type_register_static(&aspeed_soc_ast2400_type_info);
-    type_register_static(&aspeed_soc_ast2500_type_info);
+static const TypeInfo aspeed_soc_ast2400_types[] = {
+    {
+        .name           = TYPE_ASPEED2400_SOC,
+        .parent         = TYPE_ASPEED_SOC,
+        .instance_init  = aspeed_ast2400_soc_init,
+        .instance_size  = sizeof(Aspeed2400SoCState),
+        .abstract       = true,
+    }, {
+        .name           = "ast2400-a1",
+        .parent         = TYPE_ASPEED2400_SOC,
+        .class_init     = aspeed_soc_ast2400_class_init,
+    }, {
+        .name           = "ast2500-a1",
+        .parent         = TYPE_ASPEED2400_SOC,
+        .class_init     = aspeed_soc_ast2500_class_init,
+    },
 };
 
-type_init(aspeed_soc_register_types);
+DEFINE_TYPES(aspeed_soc_ast2400_types)
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index a43f5d2a6f21..b66f769d1807 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "hw/qdev-properties.h"
 #include "hw/misc/unimp.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/char/serial.h"
@@ -112,3 +113,31 @@ void aspeed_mmio_map_unimplemented(AspeedSoCState *s, SysBusDevice *dev,
     memory_region_add_subregion_overlap(s->memory, addr,
                                         sysbus_mmio_get_region(dev, 0), -1000);
 }
+
+static Property aspeed_soc_properties[] = {
+    DEFINE_PROP_LINK("dram", AspeedSoCState, dram_mr, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+    DEFINE_PROP_LINK("memory", AspeedSoCState, memory, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void aspeed_soc_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    device_class_set_props(dc, aspeed_soc_properties);
+}
+
+static const TypeInfo aspeed_soc_types[] = {
+    {
+        .name           = TYPE_ASPEED_SOC,
+        .parent         = TYPE_DEVICE,
+        .instance_size  = sizeof(AspeedSoCState),
+        .class_size     = sizeof(AspeedSoCClass),
+        .class_init     = aspeed_soc_class_init,
+        .abstract       = true,
+    },
+};
+
+DEFINE_TYPES(aspeed_soc_types)
-- 
2.41.0


