Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1713274335B
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 05:57:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF5F2-0008Ho-6g; Thu, 29 Jun 2023 23:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qF5Ez-0008HH-5a; Thu, 29 Jun 2023 23:56:13 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qF5Ex-00027Z-EH; Thu, 29 Jun 2023 23:56:12 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-570114e1feaso14854347b3.3; 
 Thu, 29 Jun 2023 20:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688097370; x=1690689370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=McF8r99G2T52ZQtYpAWwoSCSyn2I1ouw/2+k2YoSa/c=;
 b=JSfZ7i8B8LfwX26o+a60amF5VM4Ek4jcBajOp57hH3mg65bTmBY8jPS5WZ3tn86/QL
 i5JpjU0WyZzPMqq+l0EqsM+fWvQV91acG93qj4AJiQUugWpNd4HOd5gr4BmeWIa91ZYN
 Nn0uicSGZg1qCzxOo/iTkTFaW6OUAC06cLnXyQJbsFFesxKvTQ05DGyoQL2A6f+6icbO
 j1y1n8XyyOX4NqfbEW+P230POGkWzqreWMu+4ifduC+uI8LcrI3uyC3E9STUsIcP/aDg
 ay9vLrO/u1Xz1r2y0TaTjgyxjM52GW/O0DxGNHQnwr+qemk5nSBGbEFUIsk0Je4Mm+Zd
 I00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688097370; x=1690689370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=McF8r99G2T52ZQtYpAWwoSCSyn2I1ouw/2+k2YoSa/c=;
 b=PpgmQeizzRaSBpswHmdXI2jhuLMcYsW7AhnoRIFF0cO/CO4NHM5dFmPOEMuk43wC7d
 KLetZV635ONPmhwqgMOBzhe9o+cOX2OFA6+DdmyzJhrWfZf5CFsst8WqSXfkhw7OCznb
 r1OxODBiDSEf5AXJqGzsqyzgdeFdjxdg/VsiausUsxvjQbrmDjcHzXgJnt1nxKmnfWS4
 lx1iV2HaL8M0qB/qIfauDc5IJachYvQ9jvMaDKUNhJqUcGscpebsxcgXY08sAO6NJep4
 htyjic9HIs26Jt3yuYVoxUnzCy9gSF/nkBQA/LtbWiiMYEeupIdaaN/c5hqL+Pnd6S1P
 q+LA==
X-Gm-Message-State: ABy/qLbPp26AkPwLQfX7yiHUR8jJ/XtjMervDJZXG3Q2zeAgCb5dguea
 hRHtgSIuRn7TxSC4805sDZs=
X-Google-Smtp-Source: APBJJlFVicUPPJyLZpRqVtkNbGjrOVC1INFCw3jSimErMzWxo0xQrzDnyL6exkRv9ztBe9Wbnol4oQ==
X-Received: by 2002:a81:6982:0:b0:56d:c97:39f4 with SMTP id
 e124-20020a816982000000b0056d0c9739f4mr1441742ywc.8.1688097369823; 
 Thu, 29 Jun 2023 20:56:09 -0700 (PDT)
Received: from voyager.lan ([45.124.203.15]) by smtp.gmail.com with ESMTPSA id
 29-20020a17090a195d00b0025ef39c0f87sm10639290pjh.0.2023.06.29.20.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 20:56:09 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Subject: [PATCH 3/4] ppc/pnv: Add P10 quad ops
Date: Fri, 30 Jun 2023 13:25:46 +0930
Message-Id: <20230630035547.80329-4-joel@jms.id.au>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230630035547.80329-1-joel@jms.id.au>
References: <20230630035547.80329-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=joel.stan@gmail.com; helo=mail-yw1-x112a.google.com
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

Add a PnvQuad class for the P10 powernv machine. No xscoms are
implemented yet, but this allows them to be added.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/ppc/pnv.c      |  2 +-
 hw/ppc/pnv_core.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

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
index b9a57463aec4..7fff2fd9e298 100644
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
+        qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,
+                      offset);
+    }
+
+    return val;
+}
+
+static void pnv_quad_power10_xscom_write(void *opaque, hwaddr addr, uint64_t val,
+                                         unsigned int width)
+{
+    uint32_t offset = addr >> 3;
+
+    switch (offset) {
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,
+                  offset);
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
@@ -428,6 +469,13 @@ static void pnv_quad_power9_class_init(ObjectClass *oc, void *data)
     pqc->xscom_ops = &pnv_quad_power9_xscom_ops;
 }
 
+static void pnv_quad_power10_class_init(ObjectClass *oc, void *data)
+{
+    PnvQuadClass *pqc = PNV_QUAD_CLASS(oc);
+
+    pqc->xscom_ops = &pnv_quad_power10_xscom_ops;
+}
+
 static void pnv_quad_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -451,6 +499,11 @@ static const TypeInfo pnv_quad_infos[] = {
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


