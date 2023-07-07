Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FF174B012
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:42:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjio-0007y3-0P; Fri, 07 Jul 2023 07:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjik-0007qO-BR; Fri, 07 Jul 2023 07:33:54 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjii-00076U-G3; Fri, 07 Jul 2023 07:33:54 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6b5d57d7db9so1621041a34.3; 
 Fri, 07 Jul 2023 04:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729631; x=1691321631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iJhHiL+RKwf7JtrP7pqVhpinS8XH9PYLJ6UN9H6R5S0=;
 b=qFcX7ZzjZIfn3+kX/qQCZGgq4tDBKqGKeeEsyc63aZsoQAWyMb2pls/KOwKr/p2qz9
 Am2YwE+xD0W3WUkJdoVnUzDYNhKQBOiZ2EQs7WAmVGt3PxxwhnxvYEbAxsApt0GAtyyw
 2+6SiMZR/cXFUvIhEA5h/z7OQIFfNIPjo/pzhH8xsPkuHzTmqKRBgXJbhdTLSISr3t8a
 FHT9V2KYeyWFW+KK9Pvd3wuA4yPHAvNMCYuUH9IMocvtRhs2ep8XAZRC0HleZIw5hCt0
 UTQ9hdBYf2OniCW6FFOdMYwzbOtNaEcwCyBf1Ygjnr9V0r26nQbPZHHge1e3yAJsxFks
 DM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729631; x=1691321631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iJhHiL+RKwf7JtrP7pqVhpinS8XH9PYLJ6UN9H6R5S0=;
 b=amnhzmJ/YWPFz1uvLbOAp+TC/i+Ft3hkcEsXvvrBa+Hn29UqICCItsRMQz44GuGCd/
 DAxtEBSnsfEOTBGSnpho61sN6tRHaHUobXX4FdXUgzKg+S77o6aw5lebuvlUN3d9Ml9o
 na1efXziW0foXyc8mqM1PNd1b2yD8XjPzamdKw6Dy/JIr0qQD9g2KUQ9l2C957f1rvZ3
 E3l54CNs7fkWYd1fNcgoq3MuvkXUwwIZ+biYNAMAjOVR8vmw+p6R5TAIKEt8km8rwohU
 YrcNGZ9tRevHYBZcVeylF7FZR4o1i4QNBqzvL54uj6Ky5Erk170mS42UonJQvWjrdu9T
 od0w==
X-Gm-Message-State: ABy/qLYwm8okGa+qMiUPUZeIkRTCo+jcK6wS6UaF8RErXxT65f8Pm2wI
 EUhKhrS7H2ZbkEDj1ErxzV9aihuBab4=
X-Google-Smtp-Source: APBJJlEdGZL2zSRMLF8R/dfqGlFHTxkLtANCojBxrL8ivaCAA3qD7QPRJAQiTVD0cj60rzmkMwNajw==
X-Received: by 2002:a05:6830:1683:b0:6b9:107b:5978 with SMTP id
 k3-20020a056830168300b006b9107b5978mr2017452otr.27.1688729630997; 
 Fri, 07 Jul 2023 04:33:50 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:33:50 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 59/60] ppc/pnv: Add QME region for P10
Date: Fri,  7 Jul 2023 08:31:07 -0300
Message-ID: <20230707113108.7145-60-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32b.google.com
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

The Quad Management Engine (QME) manages power related settings for its
quad. The xscom region is separate from the quad xscoms, therefore a new
region is added. The xscoms in a QME select a given core by selecting
the forth nibble.

Implement dummy reads for the stop state history (SSH) and special
wakeup (SPWU) registers. This quietens some sxcom errors when skiboot
boots on p10.

Power9 does not have a QME.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20230707071213.9924-1-joel@jms.id.au>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/pnv.c               |  3 ++
 hw/ppc/pnv_core.c          | 78 +++++++++++++++++++++++++++++++++++++-
 include/hw/ppc/pnv_core.h  |  4 ++
 include/hw/ppc/pnv_xscom.h | 11 ++++++
 4 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 23740f9d07..eb54f93986 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1685,6 +1685,9 @@ static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
 
         pnv_xscom_add_subregion(chip, PNV10_XSCOM_EQ_BASE(eq->quad_id),
                                 &eq->xscom_regs);
+
+        pnv_xscom_add_subregion(chip, PNV10_XSCOM_QME_BASE(eq->quad_id),
+                                &eq->xscom_qme_regs);
     }
 }
 
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 9e7cf341dc..9b39d527de 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -496,7 +496,67 @@ static const MemoryRegionOps pnv_quad_power10_xscom_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static void pnv_quad_realize(DeviceState *dev, Error **errp)
+#define P10_QME_SPWU_HYP 0x83c
+#define P10_QME_SSH_HYP  0x82c
+
+static uint64_t pnv_qme_power10_xscom_read(void *opaque, hwaddr addr,
+                                            unsigned int width)
+{
+    uint32_t offset = addr >> 3;
+    uint64_t val = -1;
+
+    /*
+     * Forth nibble selects the core within a quad, mask it to process read
+     * for any core.
+     */
+    switch (offset & ~0xf000) {
+    case P10_QME_SPWU_HYP:
+    case P10_QME_SSH_HYP:
+        return 0;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unimp read 0x%08x\n", __func__,
+                      offset);
+    }
+
+    return val;
+}
+
+static void pnv_qme_power10_xscom_write(void *opaque, hwaddr addr,
+                                         uint64_t val, unsigned int width)
+{
+    uint32_t offset = addr >> 3;
+
+    switch (offset) {
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
+                      offset);
+    }
+}
+
+static const MemoryRegionOps pnv_qme_power10_xscom_ops = {
+    .read = pnv_qme_power10_xscom_read,
+    .write = pnv_qme_power10_xscom_write,
+    .valid.min_access_size = 8,
+    .valid.max_access_size = 8,
+    .impl.min_access_size = 8,
+    .impl.max_access_size = 8,
+    .endianness = DEVICE_BIG_ENDIAN,
+};
+
+static void pnv_quad_power9_realize(DeviceState *dev, Error **errp)
+{
+    PnvQuad *eq = PNV_QUAD(dev);
+    PnvQuadClass *pqc = PNV_QUAD_GET_CLASS(eq);
+    char name[32];
+
+    snprintf(name, sizeof(name), "xscom-quad.%d", eq->quad_id);
+    pnv_xscom_region_init(&eq->xscom_regs, OBJECT(dev),
+                          pqc->xscom_ops,
+                          eq, name,
+                          pqc->xscom_size);
+}
+
+static void pnv_quad_power10_realize(DeviceState *dev, Error **errp)
 {
     PnvQuad *eq = PNV_QUAD(dev);
     PnvQuadClass *pqc = PNV_QUAD_GET_CLASS(eq);
@@ -507,6 +567,12 @@ static void pnv_quad_realize(DeviceState *dev, Error **errp)
                           pqc->xscom_ops,
                           eq, name,
                           pqc->xscom_size);
+
+    snprintf(name, sizeof(name), "xscom-qme.%d", eq->quad_id);
+    pnv_xscom_region_init(&eq->xscom_qme_regs, OBJECT(dev),
+                          pqc->xscom_qme_ops,
+                          eq, name,
+                          pqc->xscom_qme_size);
 }
 
 static Property pnv_quad_properties[] = {
@@ -517,6 +583,9 @@ static Property pnv_quad_properties[] = {
 static void pnv_quad_power9_class_init(ObjectClass *oc, void *data)
 {
     PnvQuadClass *pqc = PNV_QUAD_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = pnv_quad_power9_realize;
 
     pqc->xscom_ops = &pnv_quad_power9_xscom_ops;
     pqc->xscom_size = PNV9_XSCOM_EQ_SIZE;
@@ -525,16 +594,21 @@ static void pnv_quad_power9_class_init(ObjectClass *oc, void *data)
 static void pnv_quad_power10_class_init(ObjectClass *oc, void *data)
 {
     PnvQuadClass *pqc = PNV_QUAD_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = pnv_quad_power10_realize;
 
     pqc->xscom_ops = &pnv_quad_power10_xscom_ops;
     pqc->xscom_size = PNV10_XSCOM_EQ_SIZE;
+
+    pqc->xscom_qme_ops = &pnv_qme_power10_xscom_ops;
+    pqc->xscom_qme_size = PNV10_XSCOM_QME_SIZE;
 }
 
 static void pnv_quad_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    dc->realize = pnv_quad_realize;
     device_class_set_props(dc, pnv_quad_properties);
     dc->user_creatable = false;
 }
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index aa5ca281fc..4db21229a6 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -66,6 +66,9 @@ struct PnvQuadClass {
 
     const MemoryRegionOps *xscom_ops;
     uint64_t xscom_size;
+
+    const MemoryRegionOps *xscom_qme_ops;
+    uint64_t xscom_qme_size;
 };
 
 #define TYPE_PNV_QUAD "powernv-cpu-quad"
@@ -80,5 +83,6 @@ struct PnvQuad {
 
     uint32_t quad_id;
     MemoryRegion xscom_regs;
+    MemoryRegion xscom_qme_regs;
 };
 #endif /* PPC_PNV_CORE_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index a4c9d95dc5..9bc6463547 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -127,6 +127,17 @@ struct PnvXScomInterfaceClass {
 #define PNV10_XSCOM_EC(proc)                    \
     ((0x2 << 16) | ((1 << (3 - (proc))) << 12))
 
+#define PNV10_XSCOM_QME(chiplet) \
+        (PNV10_XSCOM_EQ(chiplet) | (0xE << 16))
+
+/*
+ * Make the region larger by 0x1000 (instead of starting at an offset) so the
+ * modelled addresses start from 0
+ */
+#define PNV10_XSCOM_QME_BASE(core)     \
+    ((uint64_t) PNV10_XSCOM_QME(PNV10_XSCOM_EQ_CHIPLET(core)))
+#define PNV10_XSCOM_QME_SIZE        (0x8000 + 0x1000)
+
 #define PNV10_XSCOM_EQ_BASE(core)     \
     ((uint64_t) PNV10_XSCOM_EQ(PNV10_XSCOM_EQ_CHIPLET(core)))
 #define PNV10_XSCOM_EQ_SIZE        0x20000
-- 
2.41.0


