Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD65E74ABA1
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 09:14:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHfe6-0001gb-AI; Fri, 07 Jul 2023 03:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qHfe2-0001ft-IL; Fri, 07 Jul 2023 03:12:46 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qHfdz-0008HV-R2; Fri, 07 Jul 2023 03:12:46 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1b8b32c1dd1so8561385ad.0; 
 Fri, 07 Jul 2023 00:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688713962; x=1691305962;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=RErZJdEPzu/LQR39ezzrgh3HXY/9rgI1OlAhIY1XR+Y=;
 b=WX9mSho0cSvU98N5e2IoZYbHOE3Am9PuRbaDdl51wK5m89ZKdmY6uEGeRrxDsjFdyM
 8i1bnxXZRkjqfD64mo4rmtIzQIQ5bO22b7UkqxxKiasMTjuZX+RlagyN7+a+w8MUuKQB
 G8nqObMukhzFh5RD2uzKul/dWeKRFaib06DNtEdJhaFyekKnn1b7tv+DsPadA+VukrpQ
 H87ncEYmHxJGSaXrSraWnjdciB1ZN0z0igWJsC8eX4Me6kswHTZplHaPRxQbQjIjnCoZ
 3aNqmxcvf5xS2x59hnc8go/cZmi+31aouUl/s/QpkvJzDXDH5ld3C4Ztg+RkXzVClTqJ
 0q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688713962; x=1691305962;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RErZJdEPzu/LQR39ezzrgh3HXY/9rgI1OlAhIY1XR+Y=;
 b=RXX5zABMUUwweZJY1VjEKJi9U8Ff9U9xVj8hkUqWzR+gHE1TaWEPnIRn58Iu+aVk+s
 FWYk+wFqwUe55HUiG7tETvNXU2LLDQ4iziUG2ByYIwvxXJTO28xyDZ05ypXOcispgDp7
 /nT84cMxwyd/hyPRpLSaOk2mDI9BsXsHx6cc3DMo73KuAFG4lmp9g9rPCIQcVT3LAgZb
 TpX7K1twV+iG33Vy9oYjvfub9AcGLlPrUutfn5HeS7aX4KVQcqZib2djPw39iNoNoxTP
 IV4zDk241J0hRzY9FOIHhmpziXhj+Mgteau1rClJivMMt1ITfznUL/sXz1j/fW4G8Z1m
 y3rA==
X-Gm-Message-State: ABy/qLYyDDzXmC7r/dgkpYx5bFQ1l2YaTPPt8yAs0U+IUdYCSxUMGv+6
 87Ghn+GoAUZRQDzAu1/HQ5k=
X-Google-Smtp-Source: APBJJlGa8RogaHzhLfCwLBRiy2EjA+eQ331AGwHeAy8YRSTsAh7T8LXYbM2aApJM/wKySW11Pci39Q==
X-Received: by 2002:a17:903:124a:b0:1b3:d11c:23ca with SMTP id
 u10-20020a170903124a00b001b3d11c23camr3765795plh.8.1688713961553; 
 Fri, 07 Jul 2023 00:12:41 -0700 (PDT)
Received: from voyager.thelocal
 (2403-5808-8af8-0-7926-51ea-3ff2-71dd.ip6.aussiebb.net.
 [2403:5808:8af8:0:7926:51ea:3ff2:71dd])
 by smtp.gmail.com with ESMTPSA id
 a12-20020a170902eccc00b001b8b73da7b1sm2495221plh.227.2023.07.07.00.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 00:12:40 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2] ppc/pnv: Add QME region for P10
Date: Fri,  7 Jul 2023 16:42:13 +0930
Message-Id: <20230707071213.9924-1-joel@jms.id.au>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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

The Quad Management Engine (QME) manages power related settings for its
quad. The xscom region is separate from the quad xscoms, therefore a new
region is added. The xscoms in a QME select a given core by selecting
the forth nibble.

Implement dummy reads for the stop state history (SSH) and special
wakeup (SPWU) registers. This quietens some sxcom errors when skiboot
boots on p10.

Power9 does not have a QME.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2:
 Clean up extra whitespace
 Make realize quad specific so power9 doesn't end up with the qme region
---
 include/hw/ppc/pnv_core.h  |  4 ++
 include/hw/ppc/pnv_xscom.h | 11 ++++++
 hw/ppc/pnv.c               |  3 ++
 hw/ppc/pnv_core.c          | 78 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 77ef00f47a72..c829a18aa9c6 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -65,6 +65,9 @@ struct PnvQuadClass {
 
     const MemoryRegionOps *xscom_ops;
     uint64_t xscom_size;
+
+    const MemoryRegionOps *xscom_qme_ops;
+    uint64_t xscom_qme_size;
 };
 
 #define TYPE_PNV_QUAD "powernv-cpu-quad"
@@ -79,5 +82,6 @@ struct PnvQuad {
 
     uint32_t quad_id;
     MemoryRegion xscom_regs;
+    MemoryRegion xscom_qme_regs;
 };
 #endif /* PPC_PNV_CORE_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index a4c9d95dc5d3..9bc64635471e 100644
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
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 23740f9d0733..eb54f93986df 100644
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
index 1f244ed181d0..09eb2bf94b9e 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -493,7 +493,67 @@ static const MemoryRegionOps pnv_quad_power10_xscom_ops = {
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
@@ -504,6 +564,12 @@ static void pnv_quad_realize(DeviceState *dev, Error **errp)
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
@@ -514,6 +580,9 @@ static Property pnv_quad_properties[] = {
 static void pnv_quad_power9_class_init(ObjectClass *oc, void *data)
 {
     PnvQuadClass *pqc = PNV_QUAD_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = pnv_quad_power9_realize;
 
     pqc->xscom_ops = &pnv_quad_power9_xscom_ops;
     pqc->xscom_size = PNV9_XSCOM_EQ_SIZE;
@@ -522,16 +591,21 @@ static void pnv_quad_power9_class_init(ObjectClass *oc, void *data)
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
-- 
2.40.1


