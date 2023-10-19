Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 721AB7CEC8C
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 02:03:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtGTj-0000ZP-FS; Wed, 18 Oct 2023 20:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+298c059cf2aa39b7dc34+7361+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qtGTX-0000Yn-9d
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 20:01:23 -0400
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+298c059cf2aa39b7dc34+7361+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1qtGTR-0007z6-Iu
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 20:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=CamM7a9S+maLlC1YZrtxHI6SkakDNXB97dJyLDq6Rn8=; b=JmW32zRUddkmnUERMEfckmPt9R
 TgmNJbWhS807telf6HHy4RvAhIc5EfH1VGHS/6SP+PwDsN5F4a/hSvgv7FFvPJ7+o+IcK83geVtjg
 JBLWrpF1dh/6KD56PWmlFZiidJQcOiXnfwoAwMcEC211dlyO3wbKUPCB8Wk416WlaT4l5sZIXFKFB
 cWI4bnewaSOVmfhgLnPLKovBDVD8dqIO8yqt9rBgzByFHAgWZASDJKN5124aRfMR7mJ23LHgHmmZ2
 uagulJWDzuRkG+WRMrXk3PjaKBaBIzPZ5MgbXINiT2f6b9cZlpQEcGFTr/UhGS34aiRj0fhAro5EU
 sRwVhs6g==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1qtGTC-008VeQ-0Q; Thu, 19 Oct 2023 00:00:58 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1qtGTA-000Gpx-1X; Thu, 19 Oct 2023 01:00:56 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH] hw/timer/hpet: fix IRQ routing in legacy support mode
Date: Thu, 19 Oct 2023 01:00:33 +0100
Message-Id: <20231019000033.64684-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+298c059cf2aa39b7dc34+7361+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

The interrupt from timer 0 in legacy mode is supposed to go to IRQ 0 on
the i8259 and IRQ 2 on the I/O APIC. The generic x86 GSI handling can't
cope with IRQ numbers differing between the two chips (despite it also
being the case for PCI INTx routing), so add a special case for the HPET.

IRQ 2 isn't valid on the i8259; it's the cascade IRQ and would be
interpreted as spurious interrupt on the secondary PIC. So we can fix
up all attempts to deliver IRQ2, to actually deliver to IRQ0 on the PIC.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/i386/x86.c   | 19 +++++++++++++++----
 hw/timer/hpet.c |  5 ++++-
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index b3d054889b..cb1a8901ff 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -597,13 +597,24 @@ DeviceState *cpu_get_current_apic(void)
 void gsi_handler(void *opaque, int n, int level)
 {
     GSIState *s = opaque;
-
+    int i8259_pin = n;
     trace_x86_gsi_interrupt(n, level);
     switch (n) {
-    case 0 ... ISA_NUM_IRQS - 1:
-        if (s->i8259_irq[n]) {
+    case 2:
+        /*
+         * Special case for HPET legacy mode, which is defined as routing HPET
+         * timer 0 to IRQ2 of the I/O APIC and IRQ0 of the i8259 PIC. Since
+         * IRQ2 on the i8259 is the cascade, it isn't otherwise valid so we
+         * handle it via this special case.
+         */
+        i8259_pin = 0;
+        /* fall through */
+    case 0:
+    case 1:
+    case 3 ... ISA_NUM_IRQS - 1:
+        if (s->i8259_irq[i8259_pin]) {
             /* Under KVM, Kernel will forward to both PIC and IOAPIC */
-            qemu_set_irq(s->i8259_irq[n], level);
+            qemu_set_irq(s->i8259_irq[i8259_pin], level);
         }
         /* fall through */
     case ISA_NUM_IRQS ... IOAPIC_NUM_PINS - 1:
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index 6998094233..9f740ffdee 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -196,8 +196,11 @@ static void update_irq(struct HPETTimer *timer, int set)
         /* if LegacyReplacementRoute bit is set, HPET specification requires
          * timer0 be routed to IRQ0 in NON-APIC or IRQ2 in the I/O APIC,
          * timer1 be routed to IRQ8 in NON-APIC or IRQ8 in the I/O APIC.
+         *
+         * There is a special case in the x86 gsi_handler() which converts
+         * IRQ2 into IRQ0 for the i8259 PIC and makes this work correctly.
          */
-        route = (timer->tn == 0) ? 0 : RTC_ISA_IRQ;
+        route = (timer->tn == 0) ? 2 : RTC_ISA_IRQ;
     } else {
         route = timer_int_route(timer);
     }
-- 
2.40.1


