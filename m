Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C47FA584C3
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Mar 2025 14:56:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trH5g-0001mW-Pg; Sun, 09 Mar 2025 09:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH5R-0001Kk-R9
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:53:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH5P-0003gq-P0
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741528379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o3pM6y0mmoYB+krbKwiwV4STa1UotSeq0YcJABHT1wA=;
 b=X5Y4oLfF0dW/LS5DVdM4BaKoWDpm5I3fdG8wb6DwhkLvFXns0C4zyj4XAiNg+iX4yLnrV1
 5gXUOrwoMPTPRtHaUAgfocfr/tyah0hJeVHm0SzpYwCMLiY6R5/N/KEuChT47wGfPf+6SY
 /wawHaeH7GgII7WsqNmziBUIc/jvbLM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-oDvCFGIvPrmsAw4EpdrNaA-1; Sun,
 09 Mar 2025 09:52:56 -0400
X-MC-Unique: oDvCFGIvPrmsAw4EpdrNaA-1
X-Mimecast-MFC-AGG-ID: oDvCFGIvPrmsAw4EpdrNaA_1741528375
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6ED12180AF4C; Sun,  9 Mar 2025 13:52:55 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.17])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AADDE1956094; Sun,  9 Mar 2025 13:52:53 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 31/46] hw/intc/aspeed: Introduce AspeedINTCIRQ structure to
 save the irq index and register address
Date: Sun,  9 Mar 2025 14:51:15 +0100
Message-ID: <20250309135130.545764-32-clg@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The INTC controller supports GICINT128 to GICINT136, mapping 1:1 to input and
output IRQs 0 to 8. Previously, the formula "address & 0x0f00" was used to
derive the IRQ index numbers.

However, the INTC controller also supports GICINT192_201, mapping 1 input IRQ
pin to 10 output IRQ pins. The pin numbers for input and output are different.
It is difficult to use a formula to determine the index number of INTC model
supported input and output IRQs.

To simplify and improve readability, introduces the AspeedINTCIRQ structure to
save the input/output IRQ index and its enable/status register address.

Introduce the "aspeed_2700_intc_irqs" table to store IRQ information for INTC.
Introduce the "aspeed_intc_get_irq" function to retrieve the input/output IRQ
pin index from the provided status/enable register address.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250307035945.3698802-15-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/intc/aspeed_intc.h | 10 ++++
 hw/intc/aspeed_intc.c         | 87 +++++++++++++++++++----------------
 2 files changed, 58 insertions(+), 39 deletions(-)

diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
index 2a22e3084615..e6c3a27264b3 100644
--- a/include/hw/intc/aspeed_intc.h
+++ b/include/hw/intc/aspeed_intc.h
@@ -19,6 +19,14 @@ OBJECT_DECLARE_TYPE(AspeedINTCState, AspeedINTCClass, ASPEED_INTC)
 #define ASPEED_INTC_MAX_INPINS 9
 #define ASPEED_INTC_MAX_OUTPINS 9
 
+typedef struct AspeedINTCIRQ {
+    int inpin_idx;
+    int outpin_idx;
+    int num_outpins;
+    uint32_t enable_reg;
+    uint32_t status_reg;
+} AspeedINTCIRQ;
+
 struct AspeedINTCState {
     /*< private >*/
     SysBusDevice parent_obj;
@@ -46,6 +54,8 @@ struct AspeedINTCClass {
     uint64_t nr_regs;
     uint64_t reg_offset;
     const MemoryRegionOps *reg_ops;
+    const AspeedINTCIRQ *irq_table;
+    int irq_table_count;
 };
 
 #endif /* ASPEED_INTC_H */
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 1cbee0e17a5f..be24516ec970 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -40,7 +40,23 @@ REG32(GICINT135_STATUS,     0x704)
 REG32(GICINT136_EN,         0x800)
 REG32(GICINT136_STATUS,     0x804)
 
-#define GICINT_STATUS_BASE     R_GICINT128_STATUS
+static const AspeedINTCIRQ *aspeed_intc_get_irq(AspeedINTCClass *aic,
+                                                uint32_t reg)
+{
+    int i;
+
+    for (i = 0; i < aic->irq_table_count; i++) {
+        if (aic->irq_table[i].enable_reg == reg ||
+            aic->irq_table[i].status_reg == reg) {
+            return &aic->irq_table[i];
+        }
+    }
+
+    /*
+     * Invalid reg.
+     */
+    g_assert_not_reached();
+}
 
 /*
  * Update the state of an interrupt controller pin by setting
@@ -54,17 +70,7 @@ static void aspeed_intc_update(AspeedINTCState *s, int inpin_idx,
     AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
     const char *name = object_get_typename(OBJECT(s));
 
-    if (inpin_idx >= aic->num_inpins) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid input pin index: %d\n",
-                      __func__, inpin_idx);
-        return;
-    }
-
-    if (outpin_idx >= aic->num_outpins) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid output pin index: %d\n",
-                      __func__, outpin_idx);
-        return;
-    }
+    assert((outpin_idx < aic->num_outpins) && (inpin_idx < aic->num_inpins));
 
     trace_aspeed_intc_update_irq(name, inpin_idx, outpin_idx, level);
     qemu_set_irq(s->output_pins[outpin_idx], level);
@@ -81,21 +87,20 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
     AspeedINTCState *s = (AspeedINTCState *)opaque;
     AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
     const char *name = object_get_typename(OBJECT(s));
-    uint32_t status_reg = GICINT_STATUS_BASE + ((0x100 * irq) >> 2);
+    const AspeedINTCIRQ *intc_irq;
+    uint32_t status_reg;
     uint32_t select = 0;
     uint32_t enable;
     int outpin_idx;
     int inpin_idx;
     int i;
 
-    outpin_idx = irq;
-    inpin_idx = irq;
+    assert(irq < aic->num_inpins);
 
-    if (irq >= aic->num_inpins) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid input pin index: %d\n",
-                      __func__, irq);
-        return;
-    }
+    intc_irq = &aic->irq_table[irq];
+    status_reg = intc_irq->status_reg;
+    outpin_idx = intc_irq->outpin_idx;
+    inpin_idx = intc_irq->inpin_idx;
 
     trace_aspeed_intc_set_irq(name, inpin_idx, level);
     enable = s->enable[inpin_idx];
@@ -146,21 +151,16 @@ static void aspeed_intc_enable_handler(AspeedINTCState *s, hwaddr offset,
 {
     AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
     const char *name = object_get_typename(OBJECT(s));
+    const AspeedINTCIRQ *intc_irq;
     uint32_t reg = offset >> 2;
     uint32_t old_enable;
     uint32_t change;
     int inpin_idx;
-    uint32_t irq;
 
-    irq = (offset & 0x0f00) >> 8;
-    inpin_idx = irq;
+    intc_irq = aspeed_intc_get_irq(aic, reg);
+    inpin_idx = intc_irq->inpin_idx;
 
-    if (inpin_idx >= aic->num_inpins) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: Invalid input pin index: %d\n",
-                      __func__, inpin_idx);
-        return;
-    }
+    assert(inpin_idx < aic->num_inpins);
 
     /*
      * The enable registers are used to enable source interrupts.
@@ -202,26 +202,21 @@ static void aspeed_intc_status_handler(AspeedINTCState *s, hwaddr offset,
 {
     AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
     const char *name = object_get_typename(OBJECT(s));
+    const AspeedINTCIRQ *intc_irq;
     uint32_t reg = offset >> 2;
     int outpin_idx;
     int inpin_idx;
-    uint32_t irq;
 
     if (!data) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid data 0\n", __func__);
         return;
     }
 
-    irq = (offset & 0x0f00) >> 8;
-    outpin_idx = irq;
-    inpin_idx = irq;
+    intc_irq = aspeed_intc_get_irq(aic, reg);
+    outpin_idx = intc_irq->outpin_idx;
+    inpin_idx = intc_irq->inpin_idx;
 
-    if (inpin_idx >= aic->num_inpins) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "%s: Invalid input pin index: %d\n",
-                      __func__, inpin_idx);
-        return;
-    }
+    assert(inpin_idx < aic->num_inpins);
 
     /* clear status */
     s->regs[reg] &= ~data;
@@ -411,6 +406,18 @@ static const TypeInfo aspeed_intc_info = {
     .abstract = true,
 };
 
+static AspeedINTCIRQ aspeed_2700_intc_irqs[ASPEED_INTC_MAX_INPINS] = {
+    {0, 0, 1, R_GICINT128_EN, R_GICINT128_STATUS},
+    {1, 1, 1, R_GICINT129_EN, R_GICINT129_STATUS},
+    {2, 2, 1, R_GICINT130_EN, R_GICINT130_STATUS},
+    {3, 3, 1, R_GICINT131_EN, R_GICINT131_STATUS},
+    {4, 4, 1, R_GICINT132_EN, R_GICINT132_STATUS},
+    {5, 5, 1, R_GICINT133_EN, R_GICINT133_STATUS},
+    {6, 6, 1, R_GICINT134_EN, R_GICINT134_STATUS},
+    {7, 7, 1, R_GICINT135_EN, R_GICINT135_STATUS},
+    {8, 8, 1, R_GICINT136_EN, R_GICINT136_STATUS},
+};
+
 static void aspeed_2700_intc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -423,6 +430,8 @@ static void aspeed_2700_intc_class_init(ObjectClass *klass, void *data)
     aic->mem_size = 0x4000;
     aic->nr_regs = 0x808 >> 2;
     aic->reg_offset = 0x1000;
+    aic->irq_table = aspeed_2700_intc_irqs;
+    aic->irq_table_count = ARRAY_SIZE(aspeed_2700_intc_irqs);
 }
 
 static const TypeInfo aspeed_2700_intc_info = {
-- 
2.48.1


