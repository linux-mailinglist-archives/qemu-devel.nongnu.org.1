Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA04746917
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 07:43:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGYo9-0003T8-29; Tue, 04 Jul 2023 01:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qGYo0-0003Q3-8Q; Tue, 04 Jul 2023 01:42:28 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qGYnw-00046Y-Cy; Tue, 04 Jul 2023 01:42:27 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1b82bf265b2so23517485ad.0; 
 Mon, 03 Jul 2023 22:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688449342; x=1691041342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f01K8TPirXj02TiUU43o+gRSEIiFUJd37Q1MfjPfulk=;
 b=OpA1U/+yo7sCPiBxV7f0adQ++Be7/HNTEkikz0wQELdBET0DCgN0QlnEyKtL9y8Bei
 ktBrPIMsKC53GYyJ5wHRgpR67Fz+shKlU51+GoLB/6VdqT1/lfuAnYx4G/DA08fFjDiW
 rEbPFSogRNU1Y++l8DK90beDCvDSt1WwaGjZ5A9ygInO5y+387K0FVGov9gi22goPvAO
 jDz4Fr6y2Mgz+QCn1gBLbBan6pfPUiNTBI5bxN31D2hrwWm8K3mIpEUbBcNw7tvfsRE5
 TZmuKwbkwuYQmTWl/YuL8skfI4qE3foxRc/ZKfh5Qa/owXa1nob2f6stYu4dAISaH459
 yqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688449342; x=1691041342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f01K8TPirXj02TiUU43o+gRSEIiFUJd37Q1MfjPfulk=;
 b=SBhT7QtSC//UnKbsXxk+z6QENoiKDLDY/NClZ4vZgaTeYsVRhHlHIBSV90satfX4S9
 5ehomqyfBQyF1atoLJXMpd7XLnJHLfHWNzahCw5aEMNCKfD1u6YAYX9dr4iwUOj7o9Wk
 R6I6Np+Tm+UE4HHt41huJz1GgMtsNqLujmIDO6MvVxHD3b9oDIVotTMy2b6E6qP59GXm
 03k799R4pxHx5aFbaUSE6QBD+ueCaGAU1DNTSsU0NBiWxB+lvuLrsq/sWv62bU+HPvke
 KoJNKr9Lx4TFQ+r2yBUCYrxoOMKX/7s83/VYCqp35kg7RTO6rg1WDBirGcwtJwaiR359
 sAwQ==
X-Gm-Message-State: ABy/qLY4GfukxhpgS3IqvcmWK+bR/5AyNQ9Vmp3YjMynswh9rnlhoJB3
 f5zh8OhuQEqsGNHKEbz/c3s=
X-Google-Smtp-Source: APBJJlEHlVCTmTF+bgtWdnnTCrc8fYjUXGcbzb/xiok/GQtEtaqH+GSyN1eejPzjg1OqNtHi5jiKEg==
X-Received: by 2002:a17:902:7245:b0:1b5:253f:d05f with SMTP id
 c5-20020a170902724500b001b5253fd05fmr8341763pll.29.1688449341912; 
 Mon, 03 Jul 2023 22:42:21 -0700 (PDT)
Received: from localhost.localdomain
 (2403-5808-8af8-0-7926-51ea-3ff2-71dd.ip6.aussiebb.net.
 [2403:5808:8af8:0:7926:51ea:3ff2:71dd])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a17090311c900b001ae59169f05sm16261879plh.182.2023.07.03.22.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 22:42:21 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 2/5] ppc/pnv: Subclass quad xscom callbacks
Date: Tue,  4 Jul 2023 15:12:01 +0930
Message-Id: <20230704054204.168547-3-joel@jms.id.au>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230704054204.168547-1-joel@jms.id.au>
References: <20230704054204.168547-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Make the existing pnv_quad_xscom_read/write be P9 specific, in
preparation for a different P10 callback.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2: Add scom region size to class
---
 include/hw/ppc/pnv_core.h | 13 ++++++++++++-
 hw/ppc/pnv.c              | 11 +++++++----
 hw/ppc/pnv_core.c         | 40 ++++++++++++++++++++++++++-------------
 3 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 3d75706e95da..77ef00f47a72 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -60,8 +60,19 @@ static inline PnvCPUState *pnv_cpu_state(PowerPCCPU *cpu)
     return (PnvCPUState *)cpu->machine_data;
 }
 
+struct PnvQuadClass {
+    DeviceClass parent_class;
+
+    const MemoryRegionOps *xscom_ops;
+    uint64_t xscom_size;
+};
+
 #define TYPE_PNV_QUAD "powernv-cpu-quad"
-OBJECT_DECLARE_SIMPLE_TYPE(PnvQuad, PNV_QUAD)
+
+#define PNV_QUAD_TYPE_SUFFIX "-" TYPE_PNV_QUAD
+#define PNV_QUAD_TYPE_NAME(cpu_model) cpu_model PNV_QUAD_TYPE_SUFFIX
+
+OBJECT_DECLARE_TYPE(PnvQuad, PnvQuadClass, PNV_QUAD)
 
 struct PnvQuad {
     DeviceState parent_obj;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index fc083173f346..c77fdb6747a4 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1429,14 +1429,15 @@ static void pnv_chip_power9_instance_init(Object *obj)
 }
 
 static void pnv_chip_quad_realize_one(PnvChip *chip, PnvQuad *eq,
-                                      PnvCore *pnv_core)
+                                      PnvCore *pnv_core,
+                                      const char *type)
 {
     char eq_name[32];
     int core_id = CPU_CORE(pnv_core)->core_id;
 
     snprintf(eq_name, sizeof(eq_name), "eq[%d]", core_id);
     object_initialize_child_with_props(OBJECT(chip), eq_name, eq,
-                                       sizeof(*eq), TYPE_PNV_QUAD,
+                                       sizeof(*eq), type,
                                        &error_fatal, NULL);
 
     object_property_set_int(OBJECT(eq), "quad-id", core_id, &error_fatal);
@@ -1454,7 +1455,8 @@ static void pnv_chip_quad_realize(Pnv9Chip *chip9, Error **errp)
     for (i = 0; i < chip9->nr_quads; i++) {
         PnvQuad *eq = &chip9->quads[i];
 
-        pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4]);
+        pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4],
+                                  PNV_QUAD_TYPE_NAME("power9"));
 
         pnv_xscom_add_subregion(chip, PNV9_XSCOM_EQ_BASE(eq->quad_id),
                                 &eq->xscom_regs);
@@ -1666,7 +1668,8 @@ static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
     for (i = 0; i < chip10->nr_quads; i++) {
         PnvQuad *eq = &chip10->quads[i];
 
-        pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4]);
+        pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4],
+                                  PNV_QUAD_TYPE_NAME("power9"));
 
         pnv_xscom_add_subregion(chip, PNV10_XSCOM_EQ_BASE(eq->quad_id),
                                 &eq->xscom_regs);
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 0f451b3b6e1f..73d25409c937 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -407,12 +407,14 @@ static const MemoryRegionOps pnv_quad_power9_xscom_ops = {
 static void pnv_quad_realize(DeviceState *dev, Error **errp)
 {
     PnvQuad *eq = PNV_QUAD(dev);
+    PnvQuadClass *pqc = PNV_QUAD_GET_CLASS(eq);
     char name[32];
 
     snprintf(name, sizeof(name), "xscom-quad.%d", eq->quad_id);
     pnv_xscom_region_init(&eq->xscom_regs, OBJECT(dev),
-                          &pnv_quad_power9_xscom_ops,
-                          eq, name, PNV9_XSCOM_EQ_SIZE);
+                          pqc->xscom_ops,
+                          eq, name,
+                          pqc->xscom_size);
 }
 
 static Property pnv_quad_properties[] = {
@@ -420,6 +422,14 @@ static Property pnv_quad_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void pnv_quad_power9_class_init(ObjectClass *oc, void *data)
+{
+    PnvQuadClass *pqc = PNV_QUAD_CLASS(oc);
+
+    pqc->xscom_ops = &pnv_quad_power9_xscom_ops;
+    pqc->xscom_size = PNV9_XSCOM_EQ_SIZE;
+}
+
 static void pnv_quad_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -429,16 +439,20 @@ static void pnv_quad_class_init(ObjectClass *oc, void *data)
     dc->user_creatable = false;
 }
 
-static const TypeInfo pnv_quad_info = {
-    .name          = TYPE_PNV_QUAD,
-    .parent        = TYPE_DEVICE,
-    .instance_size = sizeof(PnvQuad),
-    .class_init    = pnv_quad_class_init,
+static const TypeInfo pnv_quad_infos[] = {
+    {
+        .name          = TYPE_PNV_QUAD,
+        .parent        = TYPE_DEVICE,
+        .instance_size = sizeof(PnvQuad),
+        .class_size    = sizeof(PnvQuadClass),
+        .class_init    = pnv_quad_class_init,
+        .abstract      = true,
+    },
+    {
+        .parent = TYPE_PNV_QUAD,
+        .name = PNV_QUAD_TYPE_NAME("power9"),
+        .class_init = pnv_quad_power9_class_init,
+    },
 };
 
-static void pnv_core_register_types(void)
-{
-    type_register_static(&pnv_quad_info);
-}
-
-type_init(pnv_core_register_types)
+DEFINE_TYPES(pnv_quad_infos);
-- 
2.40.1


