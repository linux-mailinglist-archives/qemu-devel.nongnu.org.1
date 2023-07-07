Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AFB74AFFE
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:39:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjhO-0002f6-6g; Fri, 07 Jul 2023 07:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhL-0002ZC-PD; Fri, 07 Jul 2023 07:32:27 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhH-0006go-Jc; Fri, 07 Jul 2023 07:32:27 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6b73c2b6dcfso1401382a34.2; 
 Fri, 07 Jul 2023 04:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729542; x=1691321542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dQmTZJ2vyQo/L76rHv3mq/6N7BMabtJt2nMQNeaRMOU=;
 b=TAeZCzB5jY5V118cMjzZWeteF6pVG78h5j0EaH8oFB4/V0Hytyrzpy7G2yWay4SUms
 +y+199jaivc5TjArHiVrOz6Zv5gY85rYo9QmmqltBRphLsA3yEPjG2shqKabcT9mAd9c
 Qi4LRP9pDaRLSFPrAaJkpHbmC99OG+tZvyRyh2yq69ev+PPi2J70GHpYK8Y2JEA91irA
 ox3uGAuW12AK/dUy8zeUdYjmQpUWeO7VTnEBKvDwSu/g2IixJ63SgMzGlusx69fygguX
 t4scq6tZeyB6x/XNkpNdarBr1L7vPw6MATdXy3dDApq+iFYW5y2lwfRHMA2o2XeSGGog
 JTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729542; x=1691321542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dQmTZJ2vyQo/L76rHv3mq/6N7BMabtJt2nMQNeaRMOU=;
 b=GqhRWJvY/damDwD0koug1Buw26lyRH36omla8BTiWZlRADcyy/n9NTiHjOudA1ELky
 OY5jnACNwsUHicAhNsbtGItoQ7NH2rmfZJ0MhPz7VWwjN36Q1u7RTJP6tgu+FbSq70jO
 UIUVCS+jMvt6lrzpz2NgHz6BXCYuYuaFK/Fu3SUtpx4bEjEO55MuYkd+TDaHhGT9xenC
 lcNR2Sf5WaNnrAtqXlAT0pMSJl2u5DPU5ATn070l1foA1+xzO4MlcPAwRMnETFoaU50U
 TfogvzG3i0kcM2u+D5zwf4fiy9anAS8bKftWMThv9V0gZZi6NG65hFCVGYS0lBJyZ17H
 722g==
X-Gm-Message-State: ABy/qLbN5GNcHwJtkW+JbrZ5xsigX8N7OATU9Hd+1YzF9eUu20ewp7ns
 utLv2KkPVAHTmNbyOlW4hWBOyL2ZDuw=
X-Google-Smtp-Source: APBJJlFa+FNW/CiXgjJ5JgI0ekhgpQLLVYoEmCYddOEZsh+utkHID6tbkSr4+3x0DIsI3ghf5DpO4Q==
X-Received: by 2002:a05:6830:1d66:b0:6b7:57c7:f128 with SMTP id
 l6-20020a0568301d6600b006b757c7f128mr4181082oti.16.1688729541853; 
 Fri, 07 Jul 2023 04:32:21 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:32:21 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Frederic Barrat <fbarrat@linux.ibm.com>
Subject: [PULL 23/60] ppc/pnv: Subclass quad xscom callbacks
Date: Fri,  7 Jul 2023 08:30:31 -0300
Message-ID: <20230707113108.7145-24-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x335.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Joel Stanley <joel@jms.id.au>

Make the existing pnv_quad_xscom_read/write be P9 specific, in
preparation for a different P10 callback.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
Message-ID: <20230704054204.168547-3-joel@jms.id.au>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/pnv.c              | 11 +++++++----
 hw/ppc/pnv_core.c         | 40 ++++++++++++++++++++++++++-------------
 include/hw/ppc/pnv_core.h | 13 ++++++++++++-
 3 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index fc083173f3..c77fdb6747 100644
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
index 0f451b3b6e..73d25409c9 100644
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
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 3d75706e95..77ef00f47a 100644
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
-- 
2.41.0


