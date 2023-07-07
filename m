Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A807F74B00B
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:40:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjhO-0002f5-6b; Fri, 07 Jul 2023 07:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhL-0002aQ-V0; Fri, 07 Jul 2023 07:32:27 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjhK-0006hh-3R; Fri, 07 Jul 2023 07:32:27 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6b73a2d622dso1096459a34.0; 
 Fri, 07 Jul 2023 04:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729544; x=1691321544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z3EdM87I8jrg+Sm3nBqPNIxyF85v1gyhGlSobHhRHFw=;
 b=WCYdWtmD3TFJCw1d4HFT/IZcLjX1LPAq8KVhgav1YjHCVzat2WERoI5IHNFC2LXR4g
 wxmCDXrBUKScGXMZvTI0TomItVUU6rvIvrL+0o+1zXp1jL5X9pnvzOwEPEbZNyNOkGDX
 Mi9eyiTUDVv2sUIim0eLbFZOseQVzxPOUw3LpwMXxyVxvU3TBZTs7GyJijNdQeFQFSgN
 OqKTIsmVHXoVOrSZrYm4zXlgi1o/Rtfl595h38fqiGjcG7KfAYw2QP7NC/d5cyA1PFbu
 q86bs3d4FeNKPzkrkmSagcRWBLJHhfnBh65Vyvn7IMC/EzdmF3sB1+V+YMCwhENzM0sk
 4OCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729544; x=1691321544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z3EdM87I8jrg+Sm3nBqPNIxyF85v1gyhGlSobHhRHFw=;
 b=Og5t4vmQFecQxoFSZ5uRvyDRmB3KYNhNTMA82x0sRICmj1ixkQ3rR9jrLS2rncYyfR
 Gc2eSjwG9IhlEzMPsJhH/Ihrc2LQ9ZaXCO0rMLJflAcdwcqMjxX6mjUclaPvPsKk+5/d
 N7FeGd7A4ZLNuqfYHHo0v7iedGzruxDGFtvwfdKF8xoAxTV13wcXq+jmPSvP7VkZVCIL
 r5ncSgSLbG0/etT3UNxd8tO/Lld1nbvQw3AygpT+rjYXFOpzaE1LctD1z4oqyeGjMCCC
 v8I8EghMwdU6NaeNu6VvSf6GP+zu+gPrO16qscz6Z6yG7Bv9k1YUNanrmadtrCNu4n8T
 1EDw==
X-Gm-Message-State: ABy/qLbjzZqYESdv5qP3KCZxZ51F8SM4Q3dbIwCimZApSjydw+VQKlfn
 YYWcBmo6S8HB2KazTrHqWrkUkWAbSzw=
X-Google-Smtp-Source: APBJJlHacJMJbaXDP1sYyzNwGvxgeK8bkYljtVS7hnglCvUABzLez9oAfP57Ej+s2HSQRcU+pX4O5Q==
X-Received: by 2002:a05:6830:20cc:b0:6b8:b2d9:1a9d with SMTP id
 z12-20020a05683020cc00b006b8b2d91a9dmr2818251otq.2.1688729544561; 
 Fri, 07 Jul 2023 04:32:24 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:32:24 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Frederic Barrat <fbarrat@linux.ibm.com>
Subject: [PULL 24/60] ppc/pnv: Add P10 quad xscom model
Date: Fri,  7 Jul 2023 08:30:32 -0300
Message-ID: <20230707113108.7145-25-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32d.google.com
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
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
Message-ID: <20230704054204.168547-4-joel@jms.id.au>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/pnv.c               |  2 +-
 hw/ppc/pnv_core.c          | 54 ++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_xscom.h |  2 +-
 3 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index c77fdb6747..5f25fe985a 100644
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
index 73d25409c9..e4df435b15 100644
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
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index cbe848d27b..f7da9a1dc6 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -129,7 +129,7 @@ struct PnvXScomInterfaceClass {
 
 #define PNV10_XSCOM_EQ_BASE(core)     \
     ((uint64_t) PNV10_XSCOM_EQ(PNV10_XSCOM_EQ_CHIPLET(core)))
-#define PNV10_XSCOM_EQ_SIZE        0x100000
+#define PNV10_XSCOM_EQ_SIZE        0x20000
 
 #define PNV10_XSCOM_EC_BASE(core) \
     ((uint64_t) PNV10_XSCOM_EQ_BASE(core) | PNV10_XSCOM_EC(core & 0x3))
-- 
2.41.0


