Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25812A584AB
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Mar 2025 14:53:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trH5C-0000Kq-PN; Sun, 09 Mar 2025 09:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH57-00005Y-MC
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:52:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH53-0002wj-T3
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741528356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8BPPjDEFLwcxqb2zTBVTXgRZJupv4Vna62MYttyY46k=;
 b=WyCkqRQDHeLqhFQVnfIZKmP9XkjjC9gB9fiilWiZRphMAVOmUgfmHx6jssUOR3UyPE0Y4L
 at4BBE0BZV9jQkX5H7FwXBojGclJaU/zRhJ9ejB9d5MdTDChpguWBRwcrf41oJaSX1IUBr
 kppDtNOYDxN07cgRp2iTwEyJqZjuzLw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-MjtY_tISMWeQ75fWydK6kg-1; Sun,
 09 Mar 2025 09:52:35 -0400
X-MC-Unique: MjtY_tISMWeQ75fWydK6kg-1
X-Mimecast-MFC-AGG-ID: MjtY_tISMWeQ75fWydK6kg_1741528354
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B3C118004A9; Sun,  9 Mar 2025 13:52:34 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.17])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE10B1956094; Sun,  9 Mar 2025 13:52:32 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 24/46] hw/intc/aspeed: Add object type name to trace events for
 better debugging
Date: Sun,  9 Mar 2025 14:51:08 +0100
Message-ID: <20250309135130.545764-25-clg@redhat.com>
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

Currently, these trace events only refer to INTC. To simplify the INTC model,
both INTC(CPU Die) and INTCIO(IO Die) will share the same helper functions.

However, it is difficult to recognize whether these trace events are comes from
INTC or INTCIO. To make these trace events more readable, adds object type name
to the INTC trace events.
Update trace events to include the "name" field for better identification.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250307035945.3698802-8-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/aspeed_intc.c | 32 +++++++++++++++++++-------------
 hw/intc/trace-events  | 24 ++++++++++++------------
 2 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index b58a7ee7126e..d06e697ecc2f 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -45,6 +45,7 @@ REG32(GICINT136_STATUS,     0x804)
 static void aspeed_intc_update(AspeedINTCState *s, int irq, int level)
 {
     AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
+    const char *name = object_get_typename(OBJECT(s));
 
     if (irq >= aic->num_ints) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Invalid interrupt number: %d\n",
@@ -52,7 +53,7 @@ static void aspeed_intc_update(AspeedINTCState *s, int irq, int level)
         return;
     }
 
-    trace_aspeed_intc_update_irq(irq, level);
+    trace_aspeed_intc_update_irq(name, irq, level);
     qemu_set_irq(s->output_pins[irq], level);
 }
 
@@ -66,6 +67,7 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
 {
     AspeedINTCState *s = (AspeedINTCState *)opaque;
     AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
+    const char *name = object_get_typename(OBJECT(s));
     uint32_t status_reg = GICINT_STATUS_BASE + ((0x100 * irq) >> 2);
     uint32_t select = 0;
     uint32_t enable;
@@ -77,7 +79,7 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
         return;
     }
 
-    trace_aspeed_intc_set_irq(irq, level);
+    trace_aspeed_intc_set_irq(name, irq, level);
     enable = s->enable[irq];
 
     if (!level) {
@@ -96,7 +98,7 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
         return;
     }
 
-    trace_aspeed_intc_select(select);
+    trace_aspeed_intc_select(name, select);
 
     if (s->mask[irq] || s->regs[status_reg]) {
         /*
@@ -108,14 +110,14 @@ static void aspeed_intc_set_irq(void *opaque, int irq, int level)
          * save source interrupt to pending variable.
          */
         s->pending[irq] |= select;
-        trace_aspeed_intc_pending_irq(irq, s->pending[irq]);
+        trace_aspeed_intc_pending_irq(name, irq, s->pending[irq]);
     } else {
         /*
          * notify firmware which source interrupt are coming
          * by setting status register
          */
         s->regs[status_reg] = select;
-        trace_aspeed_intc_trigger_irq(irq, s->regs[status_reg]);
+        trace_aspeed_intc_trigger_irq(name, irq, s->regs[status_reg]);
         aspeed_intc_update(s, irq, 1);
     }
 }
@@ -124,6 +126,7 @@ static void aspeed_intc_enable_handler(AspeedINTCState *s, hwaddr offset,
                                        uint64_t data)
 {
     AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
+    const char *name = object_get_typename(OBJECT(s));
     uint32_t reg = offset >> 2;
     uint32_t old_enable;
     uint32_t change;
@@ -154,7 +157,7 @@ static void aspeed_intc_enable_handler(AspeedINTCState *s, hwaddr offset,
 
     /* enable new source interrupt */
     if (old_enable != s->enable[irq]) {
-        trace_aspeed_intc_enable(s->enable[irq]);
+        trace_aspeed_intc_enable(name, s->enable[irq]);
         s->regs[reg] = data;
         return;
     }
@@ -163,10 +166,10 @@ static void aspeed_intc_enable_handler(AspeedINTCState *s, hwaddr offset,
     change = s->regs[reg] ^ data;
     if (change & data) {
         s->mask[irq] &= ~change;
-        trace_aspeed_intc_unmask(change, s->mask[irq]);
+        trace_aspeed_intc_unmask(name, change, s->mask[irq]);
     } else {
         s->mask[irq] |= change;
-        trace_aspeed_intc_mask(change, s->mask[irq]);
+        trace_aspeed_intc_mask(name, change, s->mask[irq]);
     }
 
     s->regs[reg] = data;
@@ -176,6 +179,7 @@ static void aspeed_intc_status_handler(AspeedINTCState *s, hwaddr offset,
                                        uint64_t data)
 {
     AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
+    const char *name = object_get_typename(OBJECT(s));
     uint32_t reg = offset >> 2;
     uint32_t irq;
 
@@ -207,7 +211,7 @@ static void aspeed_intc_status_handler(AspeedINTCState *s, hwaddr offset,
 
     /* All source ISR execution are done */
     if (!s->regs[reg]) {
-        trace_aspeed_intc_all_isr_done(irq);
+        trace_aspeed_intc_all_isr_done(name, irq);
         if (s->pending[irq]) {
             /*
              * handle pending source interrupt
@@ -216,11 +220,11 @@ static void aspeed_intc_status_handler(AspeedINTCState *s, hwaddr offset,
              */
             s->regs[reg] = s->pending[irq];
             s->pending[irq] = 0;
-            trace_aspeed_intc_trigger_irq(irq, s->regs[reg]);
+            trace_aspeed_intc_trigger_irq(name, irq, s->regs[reg]);
             aspeed_intc_update(s, irq, 1);
         } else {
             /* clear irq */
-            trace_aspeed_intc_clear_irq(irq, 0);
+            trace_aspeed_intc_clear_irq(name, irq, 0);
             aspeed_intc_update(s, irq, 0);
         }
     }
@@ -229,11 +233,12 @@ static void aspeed_intc_status_handler(AspeedINTCState *s, hwaddr offset,
 static uint64_t aspeed_intc_read(void *opaque, hwaddr offset, unsigned int size)
 {
     AspeedINTCState *s = ASPEED_INTC(opaque);
+    const char *name = object_get_typename(OBJECT(s));
     uint32_t reg = offset >> 2;
     uint32_t value = 0;
 
     value = s->regs[reg];
-    trace_aspeed_intc_read(offset, size, value);
+    trace_aspeed_intc_read(name, offset, size, value);
 
     return value;
 }
@@ -242,9 +247,10 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
                                         unsigned size)
 {
     AspeedINTCState *s = ASPEED_INTC(opaque);
+    const char *name = object_get_typename(OBJECT(s));
     uint32_t reg = offset >> 2;
 
-    trace_aspeed_intc_write(offset, size, data);
+    trace_aspeed_intc_write(name, offset, size, data);
 
     switch (reg) {
     case R_GICINT128_EN:
diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index 3dcf14719833..e9ca34755e09 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -80,18 +80,18 @@ aspeed_vic_update_irq(int flags) "Raising IRQ: %d"
 aspeed_vic_read(uint64_t offset, unsigned size, uint32_t value) "From 0x%" PRIx64 " of size %u: 0x%" PRIx32
 aspeed_vic_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
 # aspeed_intc.c
-aspeed_intc_read(uint64_t offset, unsigned size, uint32_t value) "From 0x%" PRIx64 " of size %u: 0x%" PRIx32
-aspeed_intc_write(uint64_t offset, unsigned size, uint32_t data) "To 0x%" PRIx64 " of size %u: 0x%" PRIx32
-aspeed_intc_set_irq(int irq, int level) "Set IRQ %d: %d"
-aspeed_intc_clear_irq(int irq, int level) "Clear IRQ %d: %d"
-aspeed_intc_update_irq(int irq, int level) "Update IRQ: %d: %d"
-aspeed_intc_pending_irq(int irq, uint32_t value) "Pending IRQ: %d: 0x%x"
-aspeed_intc_trigger_irq(int irq, uint32_t value) "Trigger IRQ: %d: 0x%x"
-aspeed_intc_all_isr_done(int irq) "All source ISR execution are done: %d"
-aspeed_intc_enable(uint32_t value) "Enable: 0x%x"
-aspeed_intc_select(uint32_t value) "Select: 0x%x"
-aspeed_intc_mask(uint32_t change, uint32_t value) "Mask: 0x%x: 0x%x"
-aspeed_intc_unmask(uint32_t change, uint32_t value) "UnMask: 0x%x: 0x%x"
+aspeed_intc_read(const char *s, uint64_t offset, unsigned size, uint32_t value) "%s: From 0x%" PRIx64 " of size %u: 0x%" PRIx32
+aspeed_intc_write(const char *s, uint64_t offset, unsigned size, uint32_t data) "%s: To 0x%" PRIx64 " of size %u: 0x%" PRIx32
+aspeed_intc_set_irq(const char *s, int irq, int level) "%s: Set IRQ %d: %d"
+aspeed_intc_clear_irq(const char *s, int irq, int level) "%s: Clear IRQ %d: %d"
+aspeed_intc_update_irq(const char *s, int irq, int level) "%s: Update IRQ: %d: %d"
+aspeed_intc_pending_irq(const char *s, int irq, uint32_t value) "%s: Pending IRQ: %d: 0x%x"
+aspeed_intc_trigger_irq(const char *s, int irq, uint32_t value) "%s: Trigger IRQ: %d: 0x%x"
+aspeed_intc_all_isr_done(const char *s, int irq) "%s: All source ISR execution are done: %d"
+aspeed_intc_enable(const char *s, uint32_t value) "%s: Enable: 0x%x"
+aspeed_intc_select(const char *s, uint32_t value) "%s: Select: 0x%x"
+aspeed_intc_mask(const char *s, uint32_t change, uint32_t value) "%s: Mask: 0x%x: 0x%x"
+aspeed_intc_unmask(const char *s, uint32_t change, uint32_t value) "%s: UnMask: 0x%x: 0x%x"
 
 # arm_gic.c
 gic_enable_irq(int irq) "irq %d enabled"
-- 
2.48.1


