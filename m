Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E10A7D5833
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:26:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKDj-0001wZ-0Q; Tue, 24 Oct 2023 12:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKDR-0001dA-Sl
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:25:15 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKDO-0001DY-5W
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:25:12 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32daeed7771so3112178f8f.3
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698164708; x=1698769508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oV8EByZJ6zY6tc19MQpCL4NeUAnkzkRb6SNsNIPoL3M=;
 b=tGMsVtWRF76DbEJs/QYjWVll9n8+OOzpJaoux070fij6weh/C6dX8RuwgGIRJ3R3kE
 JGDQtNuOsSqSLqalFt8wRw2x1QUWecm4RkH6UG+BPPBugDMRffGSr7cTawU7QHmMvkVO
 CdHtqF0KmqpgrXnpt7o7bzGwsYUXjII+1w8SLiOFLVktPEL3iSpta6Ph2Cy08vAmt+I5
 ggN2NEG5PsxFQDezm93HSEsRN/wCoOgmNxd37TJqu9jV7pVvjRQT21gLSa/N/JyyPwZ3
 W/w8IhCVgmEWMTx7ts/5IBbSJtrhknJT8IQywq0PCG+3kNOhpH+wVkPjYe1MJPgLR1rJ
 nPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698164708; x=1698769508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oV8EByZJ6zY6tc19MQpCL4NeUAnkzkRb6SNsNIPoL3M=;
 b=CZYXYkau+w0hq/Xl+PefOfFEnhKXCW6tUmGkzvbQLABGPPnfqJMkf7jJV0fiDas0OS
 jP+kGs8hzvtAUvh6f2HUb7R5LKVXEGZe74i4NkxOg2DvQjqa/zLrUepEcPPFv/Wwtogc
 1typcBgvguiIcgVOp/AGpgfsuoe7Et0il5Ch2SdJ5zqjtItGjvIiVNMKyx4V3C/o39AK
 Ulr57fxJNBLRgCmuBN+sVEiXnCcZd7awcYxe2eICZjzQSb+84kw1AzagWLR+I/+OPII3
 sfgtHm/oh/RGSIMIlZqIK2F9Ym7Wjg41JUvVKgh5R5LXE8utb2swJmrOxw3edE9u6MjS
 4vdA==
X-Gm-Message-State: AOJu0Ywm1TR2I8xkUatBdsWQpMd+sgtPY8S1iE1Tk43rupwC0yDCBvnk
 6N0wQ/sjLwwMeWh57n5ufS5IQDUd7pc5f+HfZSY=
X-Google-Smtp-Source: AGHT+IFfwnh227xxr0DGa3lI3KaiI+QHpCRQx/ckLRrBhRrwek7bKV1Us+hTStRXxxweZjrGYw032w==
X-Received: by 2002:adf:f750:0:b0:32d:bb4a:525c with SMTP id
 z16-20020adff750000000b0032dbb4a525cmr10012667wrp.14.1698164707899; 
 Tue, 24 Oct 2023 09:25:07 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 k12-20020adff5cc000000b00326f5d0ce0asm10238066wrp.21.2023.10.24.09.25.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 09:25:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/11] hw/arm/aspeed: Introduce TYPE_ASPEED2400_SOC
Date: Tue, 24 Oct 2023 18:24:18 +0200
Message-ID: <20231024162423.40206-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024162423.40206-1-philmd@linaro.org>
References: <20231024162423.40206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

TYPE_ASPEED2400_SOC inherits from TYPE_ASPEED_SOC.
In few commits we'll add more fields, but to keep
review process simple, don't add any yet.

TYPE_ASPEED_SOC is common to various Aspeed SoCs,
define it in aspeed_soc_common.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/aspeed_soc.h |  7 +++++
 hw/arm/aspeed_soc.c         | 61 +++++++++++--------------------------
 hw/arm/aspeed_soc_common.c  | 29 ++++++++++++++++++
 3 files changed, 53 insertions(+), 44 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 103b1598f6..ee7926b81c 100644
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
index 191276a320..dfb97f6dbd 100644
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
index a43f5d2a6f..b66f769d18 100644
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


