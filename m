Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B7374A9B5
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 06:08:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHckG-0008QR-K5; Fri, 07 Jul 2023 00:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qHck8-0008OZ-VY; Fri, 07 Jul 2023 00:06:55 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qHck6-0001ij-HK; Fri, 07 Jul 2023 00:06:52 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6b71ee710edso1316595a34.2; 
 Thu, 06 Jul 2023 21:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688702806; x=1691294806;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=GbZk4mDVOZSynFCZm3Lr9Nt2Z+sRdTvbU20CMu8DPnE=;
 b=YMs4JsMIXxLvw/EaP9uDCTAfrqONzV9CYfSB5Ys/YliHBnc9gDRLSDvOvLWXbXpHhp
 TODfc3k/ipsduGqNDY+ZOdiA3gYQsAAyVvlUjbBcCEhbrx+CWT66dwqJJqseKEsLepIb
 +7ztL2FcrLacT/uBZ9EIHqE3Vgl3CPaDBq8hgUsRD5aKRUDItaU/mmY1RzMkX/D7P0GA
 0A595u0vWhQC9GV0+c0zVkMwDmRPYWiNvGOLFGf+vqGRav/zYOXRHufyNGZPNdv7ZhZ0
 Sc5Gfn4PacvuvrtboLsiPMlyLFk5jtAmJCxn02f/HU6+qXjiueSNQlbwOrCiIh23feD8
 0DtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688702806; x=1691294806;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GbZk4mDVOZSynFCZm3Lr9Nt2Z+sRdTvbU20CMu8DPnE=;
 b=BnIhYM0uDC/haAramiU8U7U7TK7G5nN7svnj2+4QnLcWed5wFuuiLcfeXK6/wJbtQ5
 w/yuAKZA2rnQSwHE+lc8kIsCw4g8XZVjUx0+qDL7J3Zz3c/bHtLQEvbomdsFHoj0pNxS
 +oaCJ3sZabIbJ9NUvuG1tTWV0AUL9tkuImmY+SMnGuQhmoEP4P7nSgDV0QnVMWZ9R2as
 g336tK+jvklUzq8CX+0enBbhqT7fQaG/n9O2Agl3RxHinzaINGykFpvOKiaU/qOoX841
 0z6uJZxFaaZyktNBueOcwVWstBVsdk2pCGlra/BjD6fxyuBC9st9CDGgJDlYdZKE3X+z
 7uCA==
X-Gm-Message-State: ABy/qLZDfOs4QoU1+6cv7wa+LtuPdKT97Ay/hseTNTnod2gc7HCnPLh4
 rCKh2i2nn+aBCZHe3tImRj8=
X-Google-Smtp-Source: APBJJlHaVovYNMMjoA5DS0WiyVg9yfpL2kKTTMhCIx6sevNhxRjijUZd7twOf+OKw6fAeMZzu3DamA==
X-Received: by 2002:a05:6358:4408:b0:134:e422:c500 with SMTP id
 z8-20020a056358440800b00134e422c500mr3574031rwc.27.1688702806421; 
 Thu, 06 Jul 2023 21:06:46 -0700 (PDT)
Received: from localhost.localdomain
 (2403-5808-8af8-0-7926-51ea-3ff2-71dd.ip6.aussiebb.net.
 [2403:5808:8af8:0:7926:51ea:3ff2:71dd])
 by smtp.gmail.com with ESMTPSA id
 v12-20020a62a50c000000b00640f51801e6sm1944815pfm.159.2023.07.06.21.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 21:06:45 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] ppc/pnv: Add QME region for P10
Date: Fri,  7 Jul 2023 13:36:31 +0930
Message-Id: <20230707040631.66021-1-joel@jms.id.au>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=joel.stan@gmail.com; helo=mail-ot1-x32c.google.com
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

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 include/hw/ppc/pnv_core.h  |  4 +++
 include/hw/ppc/pnv_xscom.h | 11 ++++++++
 hw/ppc/pnv.c               |  5 ++++
 hw/ppc/pnv_core.c          | 56 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+)

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
index 5f25fe985ab2..6da25a676a0f 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1673,6 +1673,11 @@ static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **errp)
 
         pnv_xscom_add_subregion(chip, PNV10_XSCOM_EQ_BASE(eq->quad_id),
                                 &eq->xscom_regs);
+
+        pnv_xscom_add_subregion(chip, PNV10_XSCOM_QME_BASE(eq->quad_id),
+                                &eq->xscom_qme_regs);
+
+
     }
 }
 
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 3eb95670d6a3..35e219387918 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -496,6 +496,53 @@ static const MemoryRegionOps pnv_quad_power10_xscom_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
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
 static void pnv_quad_realize(DeviceState *dev, Error **errp)
 {
     PnvQuad *eq = PNV_QUAD(dev);
@@ -507,6 +554,12 @@ static void pnv_quad_realize(DeviceState *dev, Error **errp)
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
@@ -528,6 +581,9 @@ static void pnv_quad_power10_class_init(ObjectClass *oc, void *data)
 
     pqc->xscom_ops = &pnv_quad_power10_xscom_ops;
     pqc->xscom_size = PNV10_XSCOM_EQ_SIZE;
+
+    pqc->xscom_qme_ops = &pnv_qme_power10_xscom_ops;
+    pqc->xscom_qme_size = PNV10_XSCOM_QME_SIZE;
 }
 
 static void pnv_quad_class_init(ObjectClass *oc, void *data)
-- 
2.40.1


