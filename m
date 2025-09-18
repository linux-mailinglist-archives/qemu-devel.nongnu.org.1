Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC4CB1E8FA
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Aug 2025 15:14:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukLot-0006cQ-1Y; Fri, 08 Aug 2025 08:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ukLnR-0003ZI-QF
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:02:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ukLnP-00077y-Rw
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 08:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754654521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9gU7swm5ZspRBwgeTchPHmXOlAVgt162VWjPJI6eLxY=;
 b=Rt6fOTYKL3Nw00sCO5lJHS0T1S0qOmKvhxFfRboRhsqbtkZC1+1ArrArWBgH520AfFWPIp
 3fvlpDXoy/VczAdkUYfrGFdPi0vuXLH9lk5PW38bV82+A/s2SPVCD6Q3J11VEvhPzE4qw7
 3QZHSaiegWzwtoBfb+7eprxhmrfTvvY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-kUctXBwINC2Gz0gWcS9EyQ-1; Fri,
 08 Aug 2025 08:01:56 -0400
X-MC-Unique: kUctXBwINC2Gz0gWcS9EyQ-1
X-Mimecast-MFC-AGG-ID: kUctXBwINC2Gz0gWcS9EyQ_1754654515
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C9F391956058; Fri,  8 Aug 2025 12:01:55 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA9C219560B0; Fri,  8 Aug 2025 12:01:53 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, mtosatti@redhat.com
Subject: [PATCH v3 05/10] hpet: make main counter read lock-less
Date: Fri,  8 Aug 2025 14:01:32 +0200
Message-ID: <20250808120137.2208800-6-imammedo@redhat.com>
In-Reply-To: <20250808120137.2208800-1-imammedo@redhat.com>
References: <20250808120137.2208800-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Make access to main HPET counter lock-less.

In unlikely event of an update in progress, readers will busy wait
untill update is finished.

As result micro benchmark of concurrent reading of HPET counter
with large number of vCPU shows over 80% better (less) latency.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v3:
  * make reader busy wait during update and reuse existing seqlock API
       Peter Xu <peterx@redhat.com>
---
 hw/timer/hpet.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index c776afc0f2..789a31d0a0 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -39,6 +39,7 @@
 #include "system/address-spaces.h"
 #include "qom/object.h"
 #include "qemu/lockable.h"
+#include "qemu/seqlock.h"
 #include "trace.h"
 
 struct hpet_fw_config hpet_fw_cfg = {.count = UINT8_MAX};
@@ -74,6 +75,7 @@ struct HPETState {
     MemoryRegion iomem;
     uint64_t hpet_offset;
     bool hpet_offset_saved;
+    QemuSeqLock state_version;
     qemu_irq irqs[HPET_NUM_IRQ_ROUTES];
     uint32_t flags;
     uint8_t rtc_irq_level;
@@ -430,17 +432,25 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
     trace_hpet_ram_read(addr);
     addr &= ~4;
 
-    QEMU_LOCK_GUARD(&s->lock);
     if (addr == HPET_COUNTER) {
-        if (hpet_enabled(s)) {
-            cur_tick = hpet_get_ticks(s);
-        } else {
-            cur_tick = s->hpet_counter;
-        }
+        unsigned version;
+
+        /*
+         * Write update is rare, so busywait here is unlikely to happen
+         */
+        do {
+            version = seqlock_read_begin(&s->state_version);
+            if (unlikely(!hpet_enabled(s))) {
+                cur_tick = s->hpet_counter;
+            } else {
+                cur_tick = hpet_get_ticks(s);
+            }
+        } while (seqlock_read_retry(&s->state_version, version));
         trace_hpet_ram_read_reading_counter(addr & 4, cur_tick);
         return cur_tick >> shift;
     }
 
+    QEMU_LOCK_GUARD(&s->lock);
     /*address range of all global regs*/
     if (addr <= 0xff) {
         switch (addr) {
@@ -500,6 +510,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
             old_val = s->config;
             new_val = deposit64(old_val, shift, len, value);
             new_val = hpet_fixup_reg(new_val, old_val, HPET_CFG_WRITE_MASK);
+            seqlock_write_begin(&s->state_version);
             s->config = new_val;
             if (activating_bit(old_val, new_val, HPET_CFG_ENABLE)) {
                 /* Enable main counter and interrupt generation. */
@@ -518,6 +529,8 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
                     hpet_del_timer(&s->timer[i]);
                 }
             }
+            seqlock_write_end(&s->state_version);
+
             /* i8254 and RTC output pins are disabled
              * when HPET is in legacy mode */
             if (activating_bit(old_val, new_val, HPET_CFG_LEGACY)) {
@@ -686,6 +699,7 @@ static void hpet_init(Object *obj)
     HPETState *s = HPET(obj);
 
     qemu_mutex_init(&s->lock);
+    seqlock_init(&s->state_version);
     /* HPET Area */
     memory_region_init_io(&s->iomem, obj, &hpet_ram_ops, s, "hpet", HPET_LEN);
     memory_region_enable_lockless_io(&s->iomem);
-- 
2.47.1


