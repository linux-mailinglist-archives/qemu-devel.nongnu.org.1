Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A8E74AD8A
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 11:07:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHhQy-0003PJ-RZ; Fri, 07 Jul 2023 05:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qHhQx-0003NB-3Q
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:07:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qHhQu-0007jX-FL
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688720836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VIpvC/RbbIP8wVn40pR/GVLGYUw2TXq0JtABaDJP7X0=;
 b=hnkM310SMNTu1ofrO3F1GBjGV+7xQyn31/srov6uwwH6xm0jGpx6HyAbT+EswzjtmD2KKS
 i/rre7+t1KkZeELWguDbm2ZUdpScDiil6qMglYYmlIC6ftaQpkeeStfuTHWm6tLY/Aotdq
 Fta8RZxZ/eAZiOWw/J0Pjmk0QUxPobA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-vzn0bA6eMMqkH2Dn_sCV5g-1; Fri, 07 Jul 2023 05:07:13 -0400
X-MC-Unique: vzn0bA6eMMqkH2Dn_sCV5g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33E4C280BC50;
 Fri,  7 Jul 2023 09:07:13 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com
 (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF3691121330;
 Fri,  7 Jul 2023 09:07:10 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 14/15] e1000e: Add ICR clearing by corresponding IMS bit
Date: Fri,  7 Jul 2023 05:06:27 -0400
Message-Id: <20230707090628.2210346-15-jasowang@redhat.com>
In-Reply-To: <20230707090628.2210346-1-jasowang@redhat.com>
References: <20230707090628.2210346-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

The datasheet does not say what happens when interrupt was asserted
(ICR.INT_ASSERT=1) and auto mask is *not* active.
However, section of 13.3.27 the PCIe* GbE Controllers Open Source
Software Developer’s Manual, which were written for older devices,
namely 631xESB/632xESB, 82563EB/82564EB, 82571EB/82572EI &
82573E/82573V/82573L, does say:
> If IMS = 0b, then the ICR register is always clear-on-read. If IMS is
> not 0b, but some ICR bit is set where the corresponding IMS bit is not
> set, then a read does not clear the ICR register. For example, if
> IMS = 10101010b and ICR = 01010101b, then a read to the ICR register
> does not clear it. If IMS = 10101010b and ICR = 0101011b, then a read
> to the ICR register clears it entirely (ICR.INT_ASSERTED = 1b).

Linux does no longer activate auto mask since commit
0a8047ac68e50e4ccbadcfc6b6b070805b976885 and the real hardware clears
ICR even in such a case so we also should do so.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1707441
Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000e_core.c | 38 ++++++++++++++++++++++++++++++++------
 hw/net/trace-events  |  1 +
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 9f185d0..f8aeafa 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2604,12 +2604,38 @@ e1000e_mac_icr_read(E1000ECore *core, int index)
         e1000e_lower_interrupts(core, ICR, 0xffffffff);
     }
 
-    if ((core->mac[ICR] & E1000_ICR_ASSERTED) &&
-        (core->mac[CTRL_EXT] & E1000_CTRL_EXT_IAME)) {
-        trace_e1000e_irq_icr_clear_iame();
-        e1000e_lower_interrupts(core, ICR, 0xffffffff);
-        trace_e1000e_irq_icr_process_iame();
-        e1000e_lower_interrupts(core, IMS, core->mac[IAM]);
+    if (core->mac[ICR] & E1000_ICR_ASSERTED) {
+        if (core->mac[CTRL_EXT] & E1000_CTRL_EXT_IAME) {
+            trace_e1000e_irq_icr_clear_iame();
+            e1000e_lower_interrupts(core, ICR, 0xffffffff);
+            trace_e1000e_irq_icr_process_iame();
+            e1000e_lower_interrupts(core, IMS, core->mac[IAM]);
+        }
+
+        /*
+         * The datasheet does not say what happens when interrupt was asserted
+         * (ICR.INT_ASSERT=1) and auto mask is *not* active.
+         * However, section of 13.3.27 the PCIe* GbE Controllers Open Source
+         * Software Developer’s Manual, which were written for older devices,
+         * namely 631xESB/632xESB, 82563EB/82564EB, 82571EB/82572EI &
+         * 82573E/82573V/82573L, does say:
+         * > If IMS = 0b, then the ICR register is always clear-on-read. If IMS
+         * > is not 0b, but some ICR bit is set where the corresponding IMS bit
+         * > is not set, then a read does not clear the ICR register. For
+         * > example, if IMS = 10101010b and ICR = 01010101b, then a read to the
+         * > ICR register does not clear it. If IMS = 10101010b and
+         * > ICR = 0101011b, then a read to the ICR register clears it entirely
+         * > (ICR.INT_ASSERTED = 1b).
+         *
+         * Linux does no longer activate auto mask since commit
+         * 0a8047ac68e50e4ccbadcfc6b6b070805b976885 and the real hardware
+         * clears ICR even in such a case so we also should do so.
+         */
+        if (core->mac[ICR] & core->mac[IMS]) {
+            trace_e1000e_irq_icr_clear_icr_bit_ims(core->mac[ICR],
+                                                   core->mac[IMS]);
+            e1000e_lower_interrupts(core, ICR, 0xffffffff);
+        }
     }
 
     return ret;
diff --git a/hw/net/trace-events b/hw/net/trace-events
index e4a98b2..3eeacc5 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -217,6 +217,7 @@ e1000e_irq_read_ims(uint32_t ims) "Current IMS: 0x%x"
 e1000e_irq_icr_clear_nonmsix_icr_read(void) "Clearing ICR on read due to non MSI-X int"
 e1000e_irq_icr_clear_zero_ims(void) "Clearing ICR on read due to zero IMS"
 e1000e_irq_icr_clear_iame(void) "Clearing ICR on read due to IAME"
+e1000e_irq_icr_clear_icr_bit_ims(uint32_t icr, uint32_t ims) "Clearing ICR on read due corresponding IMS bit: 0x%x & 0x%x"
 e1000e_irq_iam_clear_eiame(uint32_t iam, uint32_t cause) "Clearing IMS due to EIAME, IAM: 0x%X, cause: 0x%X"
 e1000e_irq_icr_clear_eiac(uint32_t icr, uint32_t eiac) "Clearing ICR bits due to EIAC, ICR: 0x%X, EIAC: 0x%X"
 e1000e_irq_ims_clear_set_imc(uint32_t val) "Clearing IMS bits due to IMC write 0x%x"
-- 
2.7.4


