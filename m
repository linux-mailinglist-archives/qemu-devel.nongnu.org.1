Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C308174734F
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:50:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGgPY-00032E-2s; Tue, 04 Jul 2023 09:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=18er=CW=kaod.org=clg@ozlabs.org>)
 id 1qGgPV-0002yn-TS; Tue, 04 Jul 2023 09:49:41 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=18er=CW=kaod.org=clg@ozlabs.org>)
 id 1qGgPT-0006XV-Kl; Tue, 04 Jul 2023 09:49:41 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QwPKs0B3Sz4wZp;
 Tue,  4 Jul 2023 23:49:37 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QwPKq0p4sz4wZw;
 Tue,  4 Jul 2023 23:49:34 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [RFC PATCH 4/4] ppc/pnv: Add support for degenerative interrupts
 (POWER LSI)
Date: Tue,  4 Jul 2023 15:49:21 +0200
Message-ID: <20230704134921.2626692-5-clg@kaod.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230704134921.2626692-1-clg@kaod.org>
References: <20230704134921.2626692-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=18er=CW=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

POWER systems have a degenerative interrupt path used during system
bring up. It doesn't rely on the XIVE routing logic and all thread 0
of each core are notified.

TODO: Need a new OS driver to check modeling.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv_xive.h |  15 ++++++
 include/hw/ppc/xive.h     |   1 +
 hw/intc/pnv_xive.c        | 109 +++++++++++++++++++++++++-------------
 hw/intc/xive.c            |  22 ++++++++
 4 files changed, 111 insertions(+), 36 deletions(-)

diff --git a/include/hw/ppc/pnv_xive.h b/include/hw/ppc/pnv_xive.h
index 9c48430ee418..0ab3a8651ec1 100644
--- a/include/hw/ppc/pnv_xive.h
+++ b/include/hw/ppc/pnv_xive.h
@@ -15,6 +15,17 @@
 #include "qom/object.h"
 #include "hw/ppc/xive2.h"
 
+struct PnvXive;
+
+#define TYPE_PNV_XIVE_LSI "pnv-xive-lsi"
+#define PNV_XIVE_LSI(obj) OBJECT_CHECK(PnvXiveLsi, (obj), TYPE_PNV_XIVE_LSI)
+
+typedef struct PnvXiveLsi {
+    DeviceState  parent_obj;
+
+    struct PnvXive   *xive;
+} PnvXiveLsi;
+
 #define TYPE_PNV_XIVE "pnv-xive"
 OBJECT_DECLARE_TYPE(PnvXive, PnvXiveClass,
                     PNV_XIVE)
@@ -71,6 +82,10 @@ struct PnvXive {
     XiveSource    ipi_source;
     XiveENDSource end_source;
 
+    /* Lsi handlers */
+    PnvXiveLsi    lsi_xive;
+    XiveSource    lsi_source;
+
     /* Interrupt controller registers */
     uint64_t      regs[0x300];
 
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index f120874e0ff1..983a475dd77c 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -534,6 +534,7 @@ void xive_tctx_reset(XiveTCTX *tctx);
 void xive_tctx_destroy(XiveTCTX *tctx);
 void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb);
 void xive_tctx_reset_os_signal(XiveTCTX *tctx);
+void xive_tctx_lsi_notify(XiveTCTX *tctx);
 
 /*
  * KVM XIVE device helpers
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index 844965cfe281..9bf138cdea2c 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -991,7 +991,7 @@ static void pnv_xive_ic_reg_write(void *opaque, hwaddr offset,
                 memory_region_del_subregion(&xive->ic_mmio,
                                             &xive->ic_notify_mmio);
                 memory_region_del_subregion(&xive->ic_mmio,
-                                            &xive->ic_lsi_mmio);
+                                            &xive->lsi_source.esb_mmio);
                 memory_region_del_subregion(&xive->ic_mmio,
                                             &xive->tm_indirect_mmio);
 
@@ -1010,7 +1010,7 @@ static void pnv_xive_ic_reg_write(void *opaque, hwaddr offset,
                                             &xive->ic_notify_mmio);
                 memory_region_add_subregion(&xive->ic_mmio,
                                             2ul << xive->ic_shift,
-                                            &xive->ic_lsi_mmio);
+                                            &xive->lsi_source.esb_mmio);
                 memory_region_add_subregion(&xive->ic_mmio,
                                             4ull << xive->ic_shift,
                                             &xive->tm_indirect_mmio);
@@ -1503,39 +1503,9 @@ static const MemoryRegionOps pnv_xive_ic_notify_ops = {
 };
 
 /*
- * IC - LSI MMIO handlers (not modeled)
+ * IC - LSI MMIO handlers
  */
 
-static void pnv_xive_ic_lsi_write(void *opaque, hwaddr addr,
-                              uint64_t val, unsigned size)
-{
-    PnvXive *xive = PNV_XIVE(opaque);
-
-    xive_error(xive, "IC: LSI invalid write @%"HWADDR_PRIx, addr);
-}
-
-static uint64_t pnv_xive_ic_lsi_read(void *opaque, hwaddr addr, unsigned size)
-{
-    PnvXive *xive = PNV_XIVE(opaque);
-
-    xive_error(xive, "IC: LSI invalid read @%"HWADDR_PRIx, addr);
-    return -1;
-}
-
-static const MemoryRegionOps pnv_xive_ic_lsi_ops = {
-    .read = pnv_xive_ic_lsi_read,
-    .write = pnv_xive_ic_lsi_write,
-    .endianness = DEVICE_BIG_ENDIAN,
-    .valid = {
-        .min_access_size = 8,
-        .max_access_size = 8,
-    },
-    .impl = {
-        .min_access_size = 8,
-        .max_access_size = 8,
-    },
-};
-
 /*
  * IC - Indirect TIMA MMIO handlers
  */
@@ -1975,6 +1945,10 @@ static void pnv_xive_init(Object *obj)
                             TYPE_XIVE_SOURCE);
     object_initialize_child(obj, "end_source", &xive->end_source,
                             TYPE_XIVE_END_SOURCE);
+    object_initialize_child(obj, "lsi_source", &xive->lsi_source,
+                            TYPE_XIVE_SOURCE);
+    object_initialize_child(obj, "xive_lsi", &xive->lsi_xive,
+                            TYPE_PNV_XIVE_LSI);
 }
 
 /*
@@ -1988,6 +1962,7 @@ static void pnv_xive_realize(DeviceState *dev, Error **errp)
     PnvXive *xive = PNV_XIVE(dev);
     PnvXiveClass *pxc = PNV_XIVE_GET_CLASS(dev);
     XiveSource *xsrc = &xive->ipi_source;
+    XiveSource *lsi_xsrc = &xive->lsi_source;
     XiveENDSource *end_xsrc = &xive->end_source;
     Error *local_err = NULL;
 
@@ -2037,9 +2012,20 @@ static void pnv_xive_realize(DeviceState *dev, Error **errp)
                           &pnv_xive_ic_notify_ops,
                           xive, "xive-ic-notify", 1 << xive->ic_shift);
 
-    /* The Pervasive LSI trigger and EOI pages (not modeled) */
-    memory_region_init_io(&xive->ic_lsi_mmio, OBJECT(dev), &pnv_xive_ic_lsi_ops,
-                          xive, "xive-ic-lsi", 2 << xive->ic_shift);
+    /* The Pervasive LSI trigger and EOI pages */
+
+    object_property_set_link(OBJECT(&xive->lsi_xive), "xive", OBJECT(xive),
+                             &error_abort);
+    if (!qdev_realize(DEVICE(&xive->lsi_xive), NULL, errp)) {
+        return;
+    }
+
+    object_property_set_int(OBJECT(lsi_xsrc), "nr-irqs", 1, &error_fatal);
+    object_property_set_link(OBJECT(lsi_xsrc), "xive", OBJECT(&xive->lsi_xive),
+                             &error_abort);
+    if (!qdev_realize(DEVICE(lsi_xsrc), NULL, &local_err)) {
+        return;
+    }
 
     /* Thread Interrupt Management Area (Indirect) */
     memory_region_init_io(&xive->tm_indirect_mmio, OBJECT(dev),
@@ -2156,9 +2142,60 @@ static const TypeInfo pnv_xive_info = {
     }
 };
 
+/*
+ * Notifier proxy for LSI sources
+ *
+ * Trigger all threads 0
+ */
+static void pnv_xive_lsi_notify(XiveNotifier *xn, uint32_t srcno,
+                                bool pq_checked)
+{
+    PnvXive *xive = PNV_XIVE_LSI(xn)->xive;
+    PnvChip *chip = xive->chip;
+    int i;
+
+    for (i = 0; i < chip->nr_cores; i++) {
+        PowerPCCPU *cpu = chip->cores[i]->threads[0];
+
+        if (!pnv_xive_is_cpu_enabled(xive, cpu)) {
+            continue;
+        }
+
+        xive_tctx_lsi_notify(XIVE_TCTX(pnv_cpu_state(cpu)->intc));
+    }
+}
+
+static Property pnv_xive_lsi_properties[] = {
+    DEFINE_PROP_LINK("xive", PnvXiveLsi, xive, TYPE_PNV_XIVE, PnvXive *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pnv_xive_lsi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    XiveNotifierClass *xnc = XIVE_NOTIFIER_CLASS(klass);
+
+    dc->desc = "PowerNV XIVE LSI proxy";
+    device_class_set_props(dc, pnv_xive_lsi_properties);
+
+    xnc->notify = pnv_xive_lsi_notify;
+};
+
+static const TypeInfo pnv_xive_lsi_info = {
+    .name          = TYPE_PNV_XIVE_LSI,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(PnvXiveLsi),
+    .class_init    = pnv_xive_lsi_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { TYPE_XIVE_NOTIFIER },
+        { }
+    }
+};
+
 static void pnv_xive_register_types(void)
 {
     type_register_static(&pnv_xive_info);
+    type_register_static(&pnv_xive_lsi_info);
 }
 
 type_init(pnv_xive_register_types)
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index e36e695a691b..d81b7d6ea6b4 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -90,6 +90,8 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
                                regs[TM_CPPR], regs[TM_NSR]);
     }
 
+    /* TODO: drop LP bit when LE is set */
+
     return (nsr << 8) | regs[TM_CPPR];
 }
 
@@ -153,6 +155,26 @@ void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb)
     xive_tctx_notify(tctx, ring);
 }
 
+void xive_tctx_lsi_notify(XiveTCTX *tctx)
+{
+    uint32_t qw3w2 = xive_tctx_word2(&tctx->regs[TM_QW3_HV_PHYS]);
+    uint8_t *regs = &tctx->regs[TM_QW3_HV_PHYS];
+
+    /*
+     * If the HW context (VT) is enabled and the LSI enabled (LE) bit
+     * is set, raise the LSI pending bit and notify the CPU on the HV
+     * line.
+     */
+    if ((be32_to_cpu(qw3w2) & (TM_QW3W2_VT | TM_QW3W2_LE)) ==
+        (TM_QW3W2_VT | TM_QW3W2_LE)) {
+        qw3w2 = xive_set_field32(TM_QW3W2_LP, qw3w2, 1);
+        memcpy(&tctx->regs[TM_QW3_HV_PHYS + TM_WORD2], &qw3w2, 4);
+
+        regs[TM_NSR] |= (TM_QW3_NSR_HE_LSI << 6);
+        qemu_irq_raise(xive_tctx_output(tctx, TM_QW3_HV_PHYS));
+    }
+}
+
 /*
  * XIVE Thread Interrupt Management Area (TIMA)
  */
-- 
2.41.0


