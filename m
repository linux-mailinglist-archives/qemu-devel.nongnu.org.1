Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 693DB74734D
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:50:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGgPT-0002wM-EW; Tue, 04 Jul 2023 09:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=18er=CW=kaod.org=clg@ozlabs.org>)
 id 1qGgPQ-0002v4-TT; Tue, 04 Jul 2023 09:49:36 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=18er=CW=kaod.org=clg@ozlabs.org>)
 id 1qGgPO-0006Vm-Ma; Tue, 04 Jul 2023 09:49:36 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QwPKj4dCQz4wxn;
 Tue,  4 Jul 2023 23:49:29 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QwPKg5FWsz4wZw;
 Tue,  4 Jul 2023 23:49:27 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [RFC PATCH 1/4] ppc/xive: introduce a new XiveRouter end_notify()
 handler
Date: Tue,  4 Jul 2023 15:49:18 +0200
Message-ID: <20230704134921.2626692-2-clg@kaod.org>
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

It will help us model the END triggers on the PowerNV machine, which
can be rerouted from another interrupt controller.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h |  2 ++
 hw/intc/xive.c        | 28 ++++++++++++++++++----------
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 9f580a2699e9..f120874e0ff1 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -401,6 +401,7 @@ struct XiveRouterClass {
     int (*write_nvt)(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_idx,
                      XiveNVT *nvt, uint8_t word_number);
     uint8_t (*get_block_id)(XiveRouter *xrtr);
+    void (*end_notify)(XiveRouter *xrtr, XiveEAS *eas);
 };
 
 int xive_router_get_eas(XiveRouter *xrtr, uint8_t eas_blk, uint32_t eas_idx,
@@ -414,6 +415,7 @@ int xive_router_get_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_idx,
 int xive_router_write_nvt(XiveRouter *xrtr, uint8_t nvt_blk, uint32_t nvt_idx,
                           XiveNVT *nvt, uint8_t word_number);
 void xive_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked);
+void xive_router_end_notify(XiveRouter *xrtr, XiveEAS *eas);
 
 /*
  * XIVE Presenter
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index f60c8783455f..e36e695a691b 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1518,6 +1518,13 @@ static void xive_router_realize(DeviceState *dev, Error **errp)
     assert(xrtr->xfb);
 }
 
+static void xive_router_end_notify_handler(XiveRouter *xrtr, XiveEAS *eas)
+{
+    XiveRouterClass *xrc = XIVE_ROUTER_GET_CLASS(xrtr);
+
+    return xrc->end_notify(xrtr, eas);
+}
+
 /*
  * Encode the HW CAM line in the block group mode format :
  *
@@ -1664,8 +1671,7 @@ static bool xive_router_end_es_notify(XiveRouter *xrtr, uint8_t end_blk,
  * another chip. We don't model the PowerBus but the END trigger
  * message has the same parameters than in the function below.
  */
-static void xive_router_end_notify(XiveRouter *xrtr, uint8_t end_blk,
-                                   uint32_t end_idx, uint32_t end_data)
+void xive_router_end_notify(XiveRouter *xrtr, XiveEAS *eas)
 {
     XiveEND end;
     uint8_t priority;
@@ -1675,6 +1681,10 @@ static void xive_router_end_notify(XiveRouter *xrtr, uint8_t end_blk,
     XiveNVT nvt;
     bool found;
 
+    uint8_t end_blk = xive_get_field64(EAS_END_BLOCK, eas->w);
+    uint32_t end_idx = xive_get_field64(EAS_END_INDEX, eas->w);
+    uint32_t end_data = xive_get_field64(EAS_END_DATA,  eas->w);
+
     /* END cache lookup */
     if (xive_router_get_end(xrtr, end_blk, end_idx, &end)) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No END %x/%x\n", end_blk,
@@ -1817,10 +1827,7 @@ do_escalation:
     /*
      * The END trigger becomes an Escalation trigger
      */
-    xive_router_end_notify(xrtr,
-                           xive_get_field32(END_W4_ESC_END_BLOCK, end.w4),
-                           xive_get_field32(END_W4_ESC_END_INDEX, end.w4),
-                           xive_get_field32(END_W5_ESC_END_DATA,  end.w5));
+    xive_router_end_notify_handler(xrtr, (XiveEAS *) &end.w4);
 }
 
 void xive_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
@@ -1871,10 +1878,7 @@ void xive_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked)
     /*
      * The event trigger becomes an END trigger
      */
-    xive_router_end_notify(xrtr,
-                           xive_get_field64(EAS_END_BLOCK, eas.w),
-                           xive_get_field64(EAS_END_INDEX, eas.w),
-                           xive_get_field64(EAS_END_DATA,  eas.w));
+    xive_router_end_notify_handler(xrtr, &eas);
 }
 
 static Property xive_router_properties[] = {
@@ -1887,12 +1891,16 @@ static void xive_router_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     XiveNotifierClass *xnc = XIVE_NOTIFIER_CLASS(klass);
+    XiveRouterClass *xrc = XIVE_ROUTER_CLASS(klass);
 
     dc->desc    = "XIVE Router Engine";
     device_class_set_props(dc, xive_router_properties);
     /* Parent is SysBusDeviceClass. No need to call its realize hook */
     dc->realize = xive_router_realize;
     xnc->notify = xive_router_notify;
+
+    /* By default, the router handles END triggers locally */
+    xrc->end_notify = xive_router_end_notify;
 }
 
 static const TypeInfo xive_router_info = {
-- 
2.41.0


