Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAEE746918
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 07:43:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGYoE-0003UT-2r; Tue, 04 Jul 2023 01:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qGYo1-0003Qn-Id; Tue, 04 Jul 2023 01:42:31 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qGYnz-00048O-EQ; Tue, 04 Jul 2023 01:42:29 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1b89b75dc1cso9593095ad.1; 
 Mon, 03 Jul 2023 22:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688449345; x=1691041345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plmvhQj1QqkwSrWn7DQhxC+OBfDhnt1XZ5qJc7WBdCY=;
 b=odWPm+OmSfWkh/d7HxWopTzApyJQUVzbTrU6G8kbqpJI45iXvRy+Uq2BtWlBWvaTWH
 +q1GeUlOU/g0Su8WsamKR6UUquVJ4OaPxExRt96+3yOxEPGu4nDPxhjX7E59Uw6uQ7tL
 XcSVN120Fs4Y8oHzbde795L9ATMMIgdflmRNrKwqdgzFFeLx9TYjL4F9vmuyhOQUVxkm
 RI38PrJrArerBxEjbLcADWzwHboQ4/Iw9/PbrldvK7NVd8Z73fKCLzYbQ7o1B9cM+uuN
 s8y0hFZ/jgloXMu/pDYJG+0wvrgsINJHsNV8TWnm0aa+6w4yjMXcVRoppubusDTlHyvz
 QBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688449345; x=1691041345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=plmvhQj1QqkwSrWn7DQhxC+OBfDhnt1XZ5qJc7WBdCY=;
 b=PRqPhsTc6hKikylsa3/QrqbeUz5KFxJpRs9ZR5BuBgRGKx8eX2nqZ2H694A/yd/wjE
 N4ILd/RgI9ZFOFY863YFt7qq9RZ8agsqst5WFJMdwi24e/EbE4NgxbkY45pQTuPkdleO
 fc2FcwSGQUwWPTX7xpY+pCz9h2fF4luBCyvjygO8j2zePQx4CX1YLE89zikERwMOKHhU
 lx3ruXMgKB0RK+6x+eqhpR1WHd/WqFSIgriM4wLIvgN1vmKIq12FLGr9tBxPsNE+OmGQ
 BgkK2VUG5mXaSDXDFYc4BdPme7BgYHs/kQ4NXR1ST4tpBI6ORmvT9tKwdPdhHQbc4Fe1
 y6SQ==
X-Gm-Message-State: ABy/qLZSee2huIESGqEjzHukaLN/8Si2iEhXjSlYr6H/TYgRNhpn7Lm+
 Pj9CBl6CJJFo8Kkp7NJzJjc=
X-Google-Smtp-Source: APBJJlHzep0uRCyKfu876FewRRy13Gutpah1vQKmhar1q5DzNXfXWjwMT45oUe1SEjKgh00p1zmlKA==
X-Received: by 2002:a17:902:e548:b0:1b8:69d7:4362 with SMTP id
 n8-20020a170902e54800b001b869d74362mr19449644plf.10.1688449345267; 
 Mon, 03 Jul 2023 22:42:25 -0700 (PDT)
Received: from localhost.localdomain
 (2403-5808-8af8-0-7926-51ea-3ff2-71dd.ip6.aussiebb.net.
 [2403:5808:8af8:0:7926:51ea:3ff2:71dd])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a17090311c900b001ae59169f05sm16261879plh.182.2023.07.03.22.42.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 22:42:24 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v2 3/5] ppc/pnv: Add P10 quad xscom model
Date: Tue,  4 Jul 2023 15:12:02 +0930
Message-Id: <20230704054204.168547-4-joel@jms.id.au>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230704054204.168547-1-joel@jms.id.au>
References: <20230704054204.168547-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x635.google.com
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

Add a PnvQuad class for the P10 powernv machine. No xscoms are
implemented yet, but this allows them to be added.

The size is reduced to avoid the quad region from overlapping with the
core region.

  address-space: xscom-0
    0000000000000000-00000003ffffffff (prio 0, i/o): xscom-0
      0000000100000000-00000001000fffff (prio 0, i/o): xscom-quad.0
      0000000100108000-0000000100907fff (prio 0, i/o): xscom-core.3
      0000000100110000-000000010090ffff (prio 0, i/o): xscom-core.2
      0000000100120000-000000010091ffff (prio 0, i/o): xscom-core.1
      0000000100140000-000000010093ffff (prio 0, i/o): xscom-core.0

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2: Fix unimp read message
    Wrap lines at 80 col
    Set size
---
 include/hw/ppc/pnv_xscom.h |  2 +-
 hw/ppc/pnv.c               |  2 +-
 hw/ppc/pnv_core.c          | 54 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index cbe848d27ba0..f7da9a1dc617 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -129,7 +129,7 @@ struct PnvXScomInterfaceClass {
 
 #define PNV10_XSCOM_EQ_BASE(core)     \
     ((uint64_t) PNV10_XSCOM_EQ(PNV10_XSCOM_EQ_CHIPLET(core)))
-#define PNV10_XSCOM_EQ_SIZE        0x100000
+#define PNV10_XSCOM_EQ_SIZE        0x20000
 
 #define PNV10_XSCOM_EC_BASE(core) \
     ((uint64_t) PNV10_XSCOM_EQ_BASE(core) | PNV10_XSCOM_EC(core & 0x3))
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index c77fdb6747a4..5f25fe985ab2 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1669,7 +1669,7 @@ static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
         PnvQuad *eq = &chip10->quads[i];
 
         pnv_chip_quad_realize_one(chip, eq, chip->cores[i * 4],
-                                  PNV_QUAD_TYPE_NAME("power9"));
+                                  PNV_QUAD_TYPE_NAME("power10"));
 
         pnv_xscom_add_subregion(chip, PNV10_XSCOM_EQ_BASE(eq->quad_id),
                                 &eq->xscom_regs);
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 73d25409c937..e4df435b15e9 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -404,6 +404,47 @@ static const MemoryRegionOps pnv_quad_power9_xscom_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+/*
+ * POWER10 Quads
+ */
+
+static uint64_t pnv_quad_power10_xscom_read(void *opaque, hwaddr addr,
+                                            unsigned int width)
+{
+    uint32_t offset = addr >> 3;
+    uint64_t val = -1;
+
+    switch (offset) {
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: reading @0x%08x\n", __func__,
+                      offset);
+    }
+
+    return val;
+}
+
+static void pnv_quad_power10_xscom_write(void *opaque, hwaddr addr,
+                                         uint64_t val, unsigned int width)
+{
+    uint32_t offset = addr >> 3;
+
+    switch (offset) {
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,
+                      offset);
+    }
+}
+
+static const MemoryRegionOps pnv_quad_power10_xscom_ops = {
+    .read = pnv_quad_power10_xscom_read,
+    .write = pnv_quad_power10_xscom_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
 static void pnv_quad_realize(DeviceState *dev, Error **errp)
 {
     PnvQuad *eq = PNV_QUAD(dev);
@@ -430,6 +471,14 @@ static void pnv_quad_power9_class_init(ObjectClass *oc, void *data)
     pqc->xscom_size = PNV9_XSCOM_EQ_SIZE;
 }
 
+static void pnv_quad_power10_class_init(ObjectClass *oc, void *data)
+{
+    PnvQuadClass *pqc = PNV_QUAD_CLASS(oc);
+
+    pqc->xscom_ops = &pnv_quad_power10_xscom_ops;
+    pqc->xscom_size = PNV10_XSCOM_EQ_SIZE;
+}
+
 static void pnv_quad_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -453,6 +502,11 @@ static const TypeInfo pnv_quad_infos[] = {
         .name = PNV_QUAD_TYPE_NAME("power9"),
         .class_init = pnv_quad_power9_class_init,
     },
+    {
+        .parent = TYPE_PNV_QUAD,
+        .name = PNV_QUAD_TYPE_NAME("power10"),
+        .class_init = pnv_quad_power10_class_init,
+    },
 };
 
 DEFINE_TYPES(pnv_quad_infos);
-- 
2.40.1


