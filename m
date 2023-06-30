Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 873BE743357
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 05:57:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF5F3-0008JT-VR; Thu, 29 Jun 2023 23:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qF5Ez-0008HG-2M; Thu, 29 Jun 2023 23:56:13 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qF5Ev-00024N-Sx; Thu, 29 Jun 2023 23:56:12 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6b71ee710edso1209033a34.2; 
 Thu, 29 Jun 2023 20:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688097366; x=1690689366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k0ISCD4jN+qg1UYh21OftQOS28Bu7pewVrYtzLQ0rsc=;
 b=NHasHeJSJ2hC+ykFU9yhLxtNyQwYW9kDAACl9c4igLPF9zM13NvjJY0yRvpGKli2bd
 sVKWockzPDDptu9HhnDuXa+0FRJCa4VmvdGcD9C9vOq/iJCuEaM9UC8BOkzZvMyIMh58
 uDilyKTGJiZy/Uq+JG3x5jxZ7Z4qh5JCNRQydsHgFtXlOr5uMAcT8Am4eNC65Y5mnvFL
 YboDGcCBP4iYjTyHRyND9w/vkFUL0xymzTvTWDnVaKJZUGN//ivQ/xpag3oadUQ1ZIj3
 JITzyv736AvR3LKPcpijLAAJ1f1T3knLek+FM9bxQdJ3yYtXbFVk6aqX2B7KmE0SvzRC
 AB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688097366; x=1690689366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k0ISCD4jN+qg1UYh21OftQOS28Bu7pewVrYtzLQ0rsc=;
 b=fLfX/pubScT8h1SXnkx/tRA7zvc5evz7OVTzk2DILfaBhc7WXE1TcA6aa1PhGNvbZW
 3E8R3z10DIugCdxpNj4d/9Uec3RgPVn9zf24B2q6V7ZEwagfZ/uQZbwviQyxhbETu64A
 7MXT05RUGW8DJHUDqZek5pdjwe/Jd7c3U7D63hqGmQ3CS50ayv0maGDxduDyGIyl1cwt
 KmU/B8ehdK6Mi1C8gDLmNPiWew4QvJPZyErCWuTzpBlC5+30SjWK3xOpugS9dPJnniXW
 gubwW1BjCJyLweuemzDusGsCWEHQEXhQPjBiri9kDuS7KoxmXmrAtqyGq6RpyGEd1uF/
 cIRA==
X-Gm-Message-State: AC+VfDzxVwz3dMwezkocauEHKobfCvZH3bUIthPceHHqqffJzt7sH3Kp
 t3ea9CYbqaryMSAqWxA7akY=
X-Google-Smtp-Source: ACHHUZ69e3qfJB/f57eHwpPnLld2aitV7uC6Zvr/TOEMNvSoZkmlkD9dulxaW8PcJEpP6FpQTEN3JA==
X-Received: by 2002:a05:6870:b604:b0:1b0:37a:97cf with SMTP id
 cm4-20020a056870b60400b001b0037a97cfmr2103746oab.43.1688097366502; 
 Thu, 29 Jun 2023 20:56:06 -0700 (PDT)
Received: from voyager.lan ([45.124.203.15]) by smtp.gmail.com with ESMTPSA id
 29-20020a17090a195d00b0025ef39c0f87sm10639290pjh.0.2023.06.29.20.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 20:56:05 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Subject: [PATCH 2/4] ppc/pnv: Subclass quad xscom callbacks
Date: Fri, 30 Jun 2023 13:25:45 +0930
Message-Id: <20230630035547.80329-3-joel@jms.id.au>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230630035547.80329-1-joel@jms.id.au>
References: <20230630035547.80329-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=joel.stan@gmail.com; helo=mail-ot1-x330.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
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

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/ppc/pnv_core.h | 12 +++++++++++-
 hw/ppc/pnv.c              | 11 +++++++----
 hw/ppc/pnv_core.c         | 36 ++++++++++++++++++++++++------------
 3 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 3d75706e95da..ab3f6d6c2843 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -60,8 +60,18 @@ static inline PnvCPUState *pnv_cpu_state(PowerPCCPU *cpu)
     return (PnvCPUState *)cpu->machine_data;
 }
 
+struct PnvQuadClass {
+    DeviceClass parent_class;
+
+    const MemoryRegionOps *xscom_ops;
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
index 0b1c3cccfebc..b9a57463aec4 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -407,11 +407,12 @@ static const MemoryRegionOps pnv_quad_power9_xscom_ops = {
 static void pnv_quad_realize(DeviceState *dev, Error **errp)
 {
     PnvQuad *eq = PNV_QUAD(dev);
+    PnvQuadClass *pqc = PNV_QUAD_GET_CLASS(eq);
     char name[32];
 
     snprintf(name, sizeof(name), "xscom-quad.%d", eq->quad_id);
     pnv_xscom_region_init(&eq->xscom_regs, OBJECT(dev),
-                          &pnv_quad_power9_xscom_ops,
+                          pqc->xscom_ops,
                           eq, name, PNV9_XSCOM_EQ_SIZE);
 }
 
@@ -420,6 +421,13 @@ static Property pnv_quad_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void pnv_quad_power9_class_init(ObjectClass *oc, void *data)
+{
+    PnvQuadClass *pqc = PNV_QUAD_CLASS(oc);
+
+    pqc->xscom_ops = &pnv_quad_power9_xscom_ops;
+}
+
 static void pnv_quad_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -429,16 +437,20 @@ static void pnv_quad_class_init(ObjectClass *oc, void *data)
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


