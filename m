Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7699DA584C1
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Mar 2025 14:56:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trH5H-0000W6-Dk; Sun, 09 Mar 2025 09:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH55-0008UP-Jp
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:52:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH4z-0002tZ-PR
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741528352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aUaQKzsvhvvy0N0j9W7320QdEQpLL7U7lFSz1/+kwS4=;
 b=Ssjmz3Cd6IW5l37dQrmHrLXSTovRHPosFerTBGn8OhTP/u59KB9y5OK2LOFAup7wztYWJB
 3KCW8ORz2fl2qle2zKb0iZOadRWsyJOegcPydb/LWKvPZvVFpFXS9jjqz+k+vHugpo0ic/
 uVpEkfy5JG8Btl539Gp4LB3hgGUe5z0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-0MGdjmzFMpWoIey5A9bx3g-1; Sun,
 09 Mar 2025 09:52:29 -0400
X-MC-Unique: 0MGdjmzFMpWoIey5A9bx3g-1
X-Mimecast-MFC-AGG-ID: 0MGdjmzFMpWoIey5A9bx3g_1741528348
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1591619560B2; Sun,  9 Mar 2025 13:52:28 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.17])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7886A1956094; Sun,  9 Mar 2025 13:52:26 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 21/46] hw/intc/aspeed: Support setting different register size
Date: Sun,  9 Mar 2025 14:51:05 +0100
Message-ID: <20250309135130.545764-22-clg@redhat.com>
In-Reply-To: <20250309135130.545764-1-clg@redhat.com>
References: <20250309135130.545764-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Currently, the size of the regs array is 0x2000, which is too large. So far,
it only use GICINT128 - GICINT134, and the offsets from 0 to 0x1000 are unused.
To save code size, introduce a new class attribute "reg_size" to set the
different register sizes for the INTC models in AST2700 and add a regs
sub-region in the memory container.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250307035945.3698802-5-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/intc/aspeed_intc.h |  2 +-
 hw/intc/aspeed_intc.c         | 22 +++++-----------------
 2 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
index 47ea0520b5d8..ec4936b3f486 100644
--- a/include/hw/intc/aspeed_intc.h
+++ b/include/hw/intc/aspeed_intc.h
@@ -16,7 +16,6 @@
 #define TYPE_ASPEED_2700_INTC TYPE_ASPEED_INTC "-ast2700"
 OBJECT_DECLARE_TYPE(AspeedINTCState, AspeedINTCClass, ASPEED_INTC)
 
-#define ASPEED_INTC_NR_REGS (0x2000 >> 2)
 #define ASPEED_INTC_NR_INTS 9
 
 struct AspeedINTCState {
@@ -42,6 +41,7 @@ struct AspeedINTCClass {
     uint32_t num_lines;
     uint32_t num_ints;
     uint64_t mem_size;
+    uint64_t nr_regs;
 };
 
 #endif /* ASPEED_INTC_H */
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 558901570f82..134922e46fdc 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -120,13 +120,6 @@ static uint64_t aspeed_intc_read(void *opaque, hwaddr offset, unsigned int size)
     uint32_t reg = offset >> 2;
     uint32_t value = 0;
 
-    if (reg >= ASPEED_INTC_NR_REGS) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: Out-of-bounds read at offset 0x%" HWADDR_PRIx "\n",
-                      __func__, offset);
-        return 0;
-    }
-
     value = s->regs[reg];
     trace_aspeed_intc_read(offset, size, value);
 
@@ -143,13 +136,6 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
     uint32_t change;
     uint32_t irq;
 
-    if (reg >= ASPEED_INTC_NR_REGS) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
-                      __func__, offset);
-        return;
-    }
-
     trace_aspeed_intc_write(offset, size, data);
 
     switch (reg) {
@@ -288,8 +274,9 @@ static void aspeed_intc_instance_init(Object *obj)
 static void aspeed_intc_reset(DeviceState *dev)
 {
     AspeedINTCState *s = ASPEED_INTC(dev);
+    AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
 
-    memset(s->regs, 0, ASPEED_INTC_NR_REGS << 2);
+    memset(s->regs, 0, aic->nr_regs << 2);
     memset(s->enable, 0, sizeof(s->enable));
     memset(s->mask, 0, sizeof(s->mask));
     memset(s->pending, 0, sizeof(s->pending));
@@ -307,9 +294,9 @@ static void aspeed_intc_realize(DeviceState *dev, Error **errp)
 
     sysbus_init_mmio(sbd, &s->iomem_container);
 
-    s->regs = g_new(uint32_t, ASPEED_INTC_NR_REGS);
+    s->regs = g_new(uint32_t, aic->nr_regs);
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_intc_ops, s,
-                          TYPE_ASPEED_INTC ".regs", ASPEED_INTC_NR_REGS << 2);
+                          TYPE_ASPEED_INTC ".regs", aic->nr_regs << 2);
 
     memory_region_add_subregion(&s->iomem_container, 0x0, &s->iomem);
 
@@ -361,6 +348,7 @@ static void aspeed_2700_intc_class_init(ObjectClass *klass, void *data)
     aic->num_lines = 32;
     aic->num_ints = 9;
     aic->mem_size = 0x4000;
+    aic->nr_regs = 0x2000 >> 2;
 }
 
 static const TypeInfo aspeed_2700_intc_info = {
-- 
2.48.1


