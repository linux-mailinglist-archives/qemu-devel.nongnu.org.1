Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E934693A272
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jul 2024 16:17:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWGJb-00071p-Hm; Tue, 23 Jul 2024 10:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWGJE-0005RH-9k
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:16:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sWGJB-0007Eu-Nj
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721744164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HJdZwCWA36rJai5fAzKET5M9D8dSbh2TfkiP88YY4YQ=;
 b=duAs8omkOM2UuuIwXruilBqg1EwNQeLxD3dMaLf0QV1oCvAzyzgK+OzTq4b3/qC4wvm4LI
 4nRkNNXpWiYCkrbIE0DhWdi22x9leKtOndfJE/hFdVWEpxPR2bjURGjT0ESD8cxM7EQ0hy
 yMRsDLhHv8VfWCnaG4BeckLLVle+eCo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-K3ZsObdWPpe7vYkbi9VpFg-1; Tue, 23 Jul 2024 10:16:00 -0400
X-MC-Unique: K3ZsObdWPpe7vYkbi9VpFg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-367962f0cb0so3305586f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 07:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721744159; x=1722348959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HJdZwCWA36rJai5fAzKET5M9D8dSbh2TfkiP88YY4YQ=;
 b=t+0MmZOgXV7myJokWMIGdWISVgOj5rS73itMClyvvOxzKR9cxapLC3RxhMUyEkX/my
 iQs3P3Wibu8R/3ZiLzM9b+snuBxUMXIkt9bCiHjdO5zvUR1sZ5x/Yh35n3Ovb7930kER
 WcH6FHbBlBa0rR3vCzWiRDgyn2re1NzsSXOxX6WH4E5LWLMqZ8lUrloejtI5wL+F4NR1
 jh3gxQCrVdVy7ZZ399CYi7paQqXcGIdkMzkQtdNMv4EaJsPFkdV/J5OyLIvwPXxetBNC
 FAcUhP2tPYtW5usZdLo4gJos8lz8hDQoeN3sP1NwsqtDAop40rs4wRjvi/QPQpsovgdV
 vw4w==
X-Gm-Message-State: AOJu0Yw8TL7IeynBT3TDo75+OmJgsGGVYg7ipQmRNjwXYc+VKtGHoPtV
 QIkrOV9qobdhD5cb/oMM+nOKVt8si0arhF6gNPEKbhQ/6916wK4r+KtfwI4XsnNUUUgJu421FeB
 pr+S4jWyhdiobp0TDIQ8EvpsfWCJEkjX4pihhyJpSfRUt207jEOOkEzX/cIEbjiXDTLexeHqh5T
 gVJxA+r26HacdEg22dWJ/xHw8ZcEhJR+XCPFLt
X-Received: by 2002:a05:6000:18aa:b0:366:ef25:de51 with SMTP id
 ffacd0b85a97d-369bae707ecmr7393118f8f.49.1721744159083; 
 Tue, 23 Jul 2024 07:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj3HpwtcBQMJzvWUBI/P8uQSDZTfo5bXNJzluPQyep8jggzsM3lWrB8RL5LIeC7LMpMZ7nXA==
X-Received: by 2002:a05:6000:18aa:b0:366:ef25:de51 with SMTP id
 ffacd0b85a97d-369bae707ecmr7393090f8f.49.1721744158441; 
 Tue, 23 Jul 2024 07:15:58 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878811899sm11623162f8f.116.2024.07.23.07.15.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 07:15:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/11] hpet: store full 64-bit target value of the counter
Date: Tue, 23 Jul 2024 16:15:28 +0200
Message-ID: <20240723141529.551737-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723141529.551737-1-pbonzini@redhat.com>
References: <20240723141529.551737-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Store the full 64-bit value at which the timer should fire.

This makes it possible to skip the imprecise hpet_calculate_diff()
step, and to remove the clamping of the period to 31 or 63 bits.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/hpet.c | 111 +++++++++++++++++++++---------------------------
 1 file changed, 49 insertions(+), 62 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index ac55dd1ebd6..1654b7cb8b8 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -54,6 +54,7 @@ typedef struct HPETTimer {  /* timers */
     uint64_t cmp;           /* comparator */
     uint64_t fsb;           /* FSB route */
     /* Hidden register state */
+    uint64_t cmp64;         /* comparator (extended to counter width) */
     uint64_t period;        /* Last value written to comparator */
     uint8_t wrap_flag;      /* timer pop will indicate wrap for one-shot 32-bit
                              * mode. Next pop will be actual timer expiration.
@@ -115,11 +116,6 @@ static uint32_t timer_enabled(HPETTimer *t)
 }
 
 static uint32_t hpet_time_after(uint64_t a, uint64_t b)
-{
-    return ((int32_t)(b - a) < 0);
-}
-
-static uint32_t hpet_time_after64(uint64_t a, uint64_t b)
 {
     return ((int64_t)(b - a) < 0);
 }
@@ -156,29 +152,34 @@ static uint64_t hpet_get_ticks(HPETState *s)
     return ns_to_ticks(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->hpet_offset);
 }
 
-/*
- * calculate diff between comparator value and current ticks
- */
-static inline uint64_t hpet_calculate_diff(HPETTimer *t, uint64_t current)
+static uint64_t hpet_get_ns(HPETState *s, uint64_t tick)
 {
+    return ticks_to_ns(tick) - s->hpet_offset;
+}
 
+/*
+ * calculate next value of the general counter that matches the
+ * target (either entirely, or the low 32-bit only depending on
+ * the timer mode).
+ */
+static uint64_t hpet_calculate_cmp64(HPETTimer *t, uint64_t cur_tick, uint64_t target)
+{
     if (t->config & HPET_TN_32BIT) {
-        uint32_t diff, cmp;
-
-        cmp = (uint32_t)t->cmp;
-        diff = cmp - (uint32_t)current;
-        diff = (int32_t)diff > 0 ? diff : (uint32_t)1;
-        return (uint64_t)diff;
+        uint64_t result = deposit64(cur_tick, 0, 32, target);
+        if (result < cur_tick) {
+            result += 0x100000000ULL;
+        }
+        return result;
     } else {
-        uint64_t diff, cmp;
-
-        cmp = t->cmp;
-        diff = cmp - current;
-        diff = (int64_t)diff > 0 ? diff : (uint64_t)1;
-        return diff;
+        return target;
     }
 }
 
+static uint64_t hpet_next_wrap(uint64_t cur_tick)
+{
+    return (cur_tick | 0xffffffffU) + 1;
+}
+
 static void update_irq(struct HPETTimer *timer, int set)
 {
     uint64_t mask;
@@ -260,7 +261,12 @@ static bool hpet_validate_num_timers(void *opaque, int version_id)
 static int hpet_post_load(void *opaque, int version_id)
 {
     HPETState *s = opaque;
+    int i;
 
+    for (i = 0; i < s->num_timers; i++) {
+        HPETTimer *t = &s->timer[i];
+        t->cmp64 = hpet_calculate_cmp64(t, s->hpet_counter, t->cmp);
+    }
     /* Recalculate the offset between the main counter and guest time */
     if (!s->hpet_offset_saved) {
         s->hpet_offset = ticks_to_ns(s->hpet_counter)
@@ -356,14 +362,10 @@ static const VMStateDescription vmstate_hpet = {
     }
 };
 
-static void hpet_arm(HPETTimer *t, uint64_t ticks)
+static void hpet_arm(HPETTimer *t, uint64_t tick)
 {
-    if (ticks < ns_to_ticks(INT64_MAX / 2)) {
-        timer_mod(t->qemu_timer,
-                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + ticks_to_ns(ticks));
-    } else {
-        timer_del(t->qemu_timer);
-    }
+    /* FIXME: Clamp period to reasonable min value? */
+    timer_mod(t->qemu_timer, hpet_get_ns(t->state, tick));
 }
 
 /*
@@ -372,54 +374,44 @@ static void hpet_arm(HPETTimer *t, uint64_t ticks)
 static void hpet_timer(void *opaque)
 {
     HPETTimer *t = opaque;
-    uint64_t diff;
-
     uint64_t period = t->period;
     uint64_t cur_tick = hpet_get_ticks(t->state);
 
     if (timer_is_periodic(t) && period != 0) {
+        while (hpet_time_after(cur_tick, t->cmp64)) {
+            t->cmp64 += period;
+        }
         if (t->config & HPET_TN_32BIT) {
-            while (hpet_time_after(cur_tick, t->cmp)) {
-                t->cmp = (uint32_t)(t->cmp + t->period);
-            }
+            t->cmp = (uint32_t)t->cmp64;
         } else {
-            while (hpet_time_after64(cur_tick, t->cmp)) {
-                t->cmp += period;
-            }
-        }
-        diff = hpet_calculate_diff(t, cur_tick);
-        hpet_arm(t, diff);
-    } else if (t->config & HPET_TN_32BIT && !timer_is_periodic(t)) {
-        if (t->wrap_flag) {
-            diff = hpet_calculate_diff(t, cur_tick);
-            hpet_arm(t, diff);
-            t->wrap_flag = 0;
+            t->cmp = t->cmp64;
         }
+        hpet_arm(t, t->cmp64);
+    } else if (t->wrap_flag) {
+        t->wrap_flag = 0;
+        hpet_arm(t, t->cmp64);
     }
     update_irq(t, 1);
 }
 
 static void hpet_set_timer(HPETTimer *t)
 {
-    uint64_t diff;
-    uint32_t wrap_diff;  /* how many ticks until we wrap? */
     uint64_t cur_tick = hpet_get_ticks(t->state);
 
-    /* whenever new timer is being set up, make sure wrap_flag is 0 */
     t->wrap_flag = 0;
-    diff = hpet_calculate_diff(t, cur_tick);
+    t->cmp64 = hpet_calculate_cmp64(t, cur_tick, t->cmp);
+    if (t->config & HPET_TN_32BIT) {
 
-    /* hpet spec says in one-shot 32-bit mode, generate an interrupt when
-     * counter wraps in addition to an interrupt with comparator match.
-     */
-    if (t->config & HPET_TN_32BIT && !timer_is_periodic(t)) {
-        wrap_diff = 0xffffffff - (uint32_t)cur_tick;
-        if (wrap_diff < (uint32_t)diff) {
-            diff = wrap_diff;
+        /* hpet spec says in one-shot 32-bit mode, generate an interrupt when
+         * counter wraps in addition to an interrupt with comparator match.
+         */
+        if (!timer_is_periodic(t) && t->cmp64 > hpet_next_wrap(cur_tick)) {
             t->wrap_flag = 1;
+            hpet_arm(t, hpet_next_wrap(cur_tick));
+            return;
         }
     }
-    hpet_arm(t, diff);
+    hpet_arm(t, t->cmp64);
 }
 
 static void hpet_del_timer(HPETTimer *t)
@@ -550,12 +542,7 @@ static void hpet_ram_write(void *opaque, hwaddr addr,
                 timer->cmp = deposit64(timer->cmp, shift, len, value);
             }
             if (timer_is_periodic(timer)) {
-                /*
-                 * FIXME: Clamp period to reasonable min value?
-                 * Clamp period to reasonable max value
-                 */
-                new_val = deposit64(timer->period, shift, len, value);
-                timer->period = MIN(new_val, (timer->config & HPET_TN_32BIT ? ~0u : ~0ull) >> 1);
+                timer->period = deposit64(timer->period, shift, len, value);
             }
             timer->config &= ~HPET_TN_SETVAL;
             if (hpet_enabled(s)) {
-- 
2.45.2


