Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CFC75F250
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 12:12:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNsWP-0007w3-Fc; Mon, 24 Jul 2023 06:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qNsW5-0007kI-Kn
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:10:13 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qNsW3-0000ke-1q
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:10:12 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bba48b0bd2so3793485ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 03:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690193408; x=1690798208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qacRUi0hhH5FP4hhwD8aVp/ujoAgoDtm7ItlVZRYtG4=;
 b=GbWrs45horAl23Wz6vxjQV1okKfcZvjhDRxRqrwUv+iAWrgJOiijz3ehjd98utimio
 aRlFdARUkkbX3LDybQ1CAqF98GHrAMc/pCBRcruyOILIZeM/9mrjkfUtKjCYlPh9sS6l
 xlR92zU5umi8rrhm+PUF+Op3k3DiA6+FBiDzUd2HtgLmjkzqO+KKPecnXRpif6mJpJM3
 GxGhh0SxXiz4tZGKsLQFrI47GQqbZzqF35wFHMAJ7siyykdvuJjaGz345s6fhaswH3zx
 XdAc/xRYtiNUPdopWqJQsLH9w8eP2G0CmZ4RijyPaoj0nGpon4KEbyYVnjtj7AqklDjX
 th0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690193408; x=1690798208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qacRUi0hhH5FP4hhwD8aVp/ujoAgoDtm7ItlVZRYtG4=;
 b=gaIqvhBRf3T3Fasp4w0Da/VlCEZnth7V+usb0dX05wrD6W2MjgE5nzm8Xi5yJ1dcIb
 V2hUJUg3+27AuD4gGV3qyrfR3J2xVniieiUFBWFMKQb72h2lvOR4+AWWFLKUVjSksMLN
 bdiXXW9Fvwp31QvdawZfVM8kPBgMjMdT/EE4+HPQ14syB5u9GZjGx4qorD76qWLaCwDR
 7mHklfjO/BTdtlwo+EXQZ/Q3+78moBfJ3t7ZivNFoYnEUFjLBq/9pOxxaREvFaAKfD/A
 b9INhaYv5YJK9Dyzdje/RW0yjE+eu3Ju+d/3s1MjaGj9N+1S3pbayGOX33X53fmyvY3E
 jG8w==
X-Gm-Message-State: ABy/qLY3t0W2HIIBH1iQ7WjQ8efYlKjgLch/93TyLUKUOewr8GkjyiTj
 wkX1EuMOikuVMmp5CPt1Gp6MYg==
X-Google-Smtp-Source: APBJJlHHmLPcy+J6/i0C9oFDwJ9NKQLhpuidmqjZbyRMEsQSbZjzjBmpGnaeurrluPDPt6krzsLwDA==
X-Received: by 2002:a17:902:f543:b0:1b6:771a:3516 with SMTP id
 h3-20020a170902f54300b001b6771a3516mr10794101plf.22.1690193408368; 
 Mon, 24 Jul 2023 03:10:08 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 je2-20020a170903264200b001bb9d6b1baasm2419124plb.198.2023.07.24.03.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 03:10:08 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com, kwolf@redhat.com, groug@kaod.org, qemu_oss@crudebyte.com,
 hreitz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, berrange@redhat.com,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v4 6/9] throttle: use enum ThrottleDirection instead of bool
 is_write
Date: Mon, 24 Jul 2023 18:09:36 +0800
Message-Id: <20230724100939.1022984-7-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724100939.1022984-1-pizhenwei@bytedance.com>
References: <20230724100939.1022984-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

enum ThrottleDirection is already there, use ThrottleDirection instead
of 'bool is_write' for throttle API, also modify related codes from
block, fsdev, cryptodev and tests.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 backends/cryptodev.c        |  9 +++++----
 block/throttle-groups.c     |  6 ++++--
 fsdev/qemu-fsdev-throttle.c |  8 +++++---
 include/qemu/throttle.h     |  5 +++--
 tests/unit/test-throttle.c  |  4 ++--
 util/throttle.c             | 31 +++++++++++++++++--------------
 6 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index 5cfa25c61c..06142eae57 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -242,10 +242,11 @@ static void cryptodev_backend_throttle_timer_cb(void *opaque)
             continue;
         }
 
-        throttle_account(&backend->ts, true, ret);
+        throttle_account(&backend->ts, THROTTLE_WRITE, ret);
         cryptodev_backend_operation(backend, op_info);
         if (throttle_enabled(&backend->tc) &&
-            throttle_schedule_timer(&backend->ts, &backend->tt, true)) {
+            throttle_schedule_timer(&backend->ts, &backend->tt,
+                                    THROTTLE_WRITE)) {
             break;
         }
     }
@@ -261,7 +262,7 @@ int cryptodev_backend_crypto_operation(
         goto do_account;
     }
 
-    if (throttle_schedule_timer(&backend->ts, &backend->tt, true) ||
+    if (throttle_schedule_timer(&backend->ts, &backend->tt, THROTTLE_WRITE) ||
         !QTAILQ_EMPTY(&backend->opinfos)) {
         QTAILQ_INSERT_TAIL(&backend->opinfos, op_info, next);
         return 0;
@@ -273,7 +274,7 @@ do_account:
         return ret;
     }
 
-    throttle_account(&backend->ts, true, ret);
+    throttle_account(&backend->ts, THROTTLE_WRITE, ret);
 
     return cryptodev_backend_operation(backend, op_info);
 }
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index fb203c3ced..3847d27801 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -270,6 +270,7 @@ static bool throttle_group_schedule_timer(ThrottleGroupMember *tgm,
     ThrottleState *ts = tgm->throttle_state;
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
     ThrottleTimers *tt = &tgm->throttle_timers;
+    ThrottleDirection direction = is_write ? THROTTLE_WRITE : THROTTLE_READ;
     bool must_wait;
 
     if (qatomic_read(&tgm->io_limits_disabled)) {
@@ -281,7 +282,7 @@ static bool throttle_group_schedule_timer(ThrottleGroupMember *tgm,
         return true;
     }
 
-    must_wait = throttle_schedule_timer(ts, tt, is_write);
+    must_wait = throttle_schedule_timer(ts, tt, direction);
 
     /* If a timer just got armed, set tgm as the current token */
     if (must_wait) {
@@ -364,6 +365,7 @@ void coroutine_fn throttle_group_co_io_limits_intercept(ThrottleGroupMember *tgm
     bool must_wait;
     ThrottleGroupMember *token;
     ThrottleGroup *tg = container_of(tgm->throttle_state, ThrottleGroup, ts);
+    ThrottleDirection direction = is_write ? THROTTLE_WRITE : THROTTLE_READ;
 
     assert(bytes >= 0);
 
@@ -386,7 +388,7 @@ void coroutine_fn throttle_group_co_io_limits_intercept(ThrottleGroupMember *tgm
     }
 
     /* The I/O will be executed, so do the accounting */
-    throttle_account(tgm->throttle_state, is_write, bytes);
+    throttle_account(tgm->throttle_state, direction, bytes);
 
     /* Schedule the next request */
     schedule_next_request(tgm, is_write);
diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
index 5c83a1cc09..1c137d6f0f 100644
--- a/fsdev/qemu-fsdev-throttle.c
+++ b/fsdev/qemu-fsdev-throttle.c
@@ -97,16 +97,18 @@ void fsdev_throttle_init(FsThrottle *fst)
 void coroutine_fn fsdev_co_throttle_request(FsThrottle *fst, bool is_write,
                                             struct iovec *iov, int iovcnt)
 {
+    ThrottleDirection direction = is_write ? THROTTLE_WRITE : THROTTLE_READ;
+
     if (throttle_enabled(&fst->cfg)) {
-        if (throttle_schedule_timer(&fst->ts, &fst->tt, is_write) ||
+        if (throttle_schedule_timer(&fst->ts, &fst->tt, direction) ||
             !qemu_co_queue_empty(&fst->throttled_reqs[is_write])) {
             qemu_co_queue_wait(&fst->throttled_reqs[is_write], NULL);
         }
 
-        throttle_account(&fst->ts, is_write, iov_size(iov, iovcnt));
+        throttle_account(&fst->ts, direction, iov_size(iov, iovcnt));
 
         if (!qemu_co_queue_empty(&fst->throttled_reqs[is_write]) &&
-            !throttle_schedule_timer(&fst->ts, &fst->tt, is_write)) {
+            !throttle_schedule_timer(&fst->ts, &fst->tt, direction)) {
             qemu_co_queue_next(&fst->throttled_reqs[is_write]);
         }
     }
diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
index 9ca5ab8197..181245d29b 100644
--- a/include/qemu/throttle.h
+++ b/include/qemu/throttle.h
@@ -154,9 +154,10 @@ void throttle_config_init(ThrottleConfig *cfg);
 /* usage */
 bool throttle_schedule_timer(ThrottleState *ts,
                              ThrottleTimers *tt,
-                             bool is_write);
+                             ThrottleDirection direction);
 
-void throttle_account(ThrottleState *ts, bool is_write, uint64_t size);
+void throttle_account(ThrottleState *ts, ThrottleDirection direction,
+                      uint64_t size);
 void throttle_limits_to_config(ThrottleLimits *arg, ThrottleConfig *cfg,
                                Error **errp);
 void throttle_config_to_limits(ThrottleConfig *cfg, ThrottleLimits *var);
diff --git a/tests/unit/test-throttle.c b/tests/unit/test-throttle.c
index 5547837a58..2c4754fb8a 100644
--- a/tests/unit/test-throttle.c
+++ b/tests/unit/test-throttle.c
@@ -637,9 +637,9 @@ static bool do_test_accounting(bool is_ops, /* are we testing bps or ops */
     throttle_config(&ts, QEMU_CLOCK_VIRTUAL, &cfg);
 
     /* account a read */
-    throttle_account(&ts, false, size);
+    throttle_account(&ts, THROTTLE_READ, size);
     /* account a write */
-    throttle_account(&ts, true, size);
+    throttle_account(&ts, THROTTLE_WRITE, size);
 
     /* check total result */
     index = to_test[is_ops][0];
diff --git a/util/throttle.c b/util/throttle.c
index 0439028d21..9a37209bb8 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -136,11 +136,11 @@ int64_t throttle_compute_wait(LeakyBucket *bkt)
 
 /* This function compute the time that must be waited while this IO
  *
- * @is_write:   true if the current IO is a write, false if it's a read
+ * @throttle:   throttle direction
  * @ret:        time to wait
  */
 static int64_t throttle_compute_wait_for(ThrottleState *ts,
-                                         bool is_write)
+                                         ThrottleDirection direction)
 {
     BucketType to_check[2][4] = { {THROTTLE_BPS_TOTAL,
                                    THROTTLE_OPS_TOTAL,
@@ -154,7 +154,7 @@ static int64_t throttle_compute_wait_for(ThrottleState *ts,
     int i;
 
     for (i = 0; i < 4; i++) {
-        BucketType index = to_check[is_write][i];
+        BucketType index = to_check[direction][i];
         wait = throttle_compute_wait(&ts->cfg.buckets[index]);
         if (wait > max_wait) {
             max_wait = wait;
@@ -166,13 +166,13 @@ static int64_t throttle_compute_wait_for(ThrottleState *ts,
 
 /* compute the timer for this type of operation
  *
- * @is_write:   the type of operation
+ * @throttle:   throttle direction
  * @now:        the current clock timestamp
  * @next_timestamp: the resulting timer
  * @ret:        true if a timer must be set
  */
 static bool throttle_compute_timer(ThrottleState *ts,
-                                   bool is_write,
+                                   ThrottleDirection direction,
                                    int64_t now,
                                    int64_t *next_timestamp)
 {
@@ -182,7 +182,7 @@ static bool throttle_compute_timer(ThrottleState *ts,
     throttle_do_leak(ts, now);
 
     /* compute the wait time if any */
-    wait = throttle_compute_wait_for(ts, is_write);
+    wait = throttle_compute_wait_for(ts, direction);
 
     /* if the code must wait compute when the next timer should fire */
     if (wait) {
@@ -425,23 +425,24 @@ void throttle_get_config(ThrottleState *ts, ThrottleConfig *cfg)
  * NOTE: this function is not unit tested due to it's usage of timer_mod
  *
  * @tt:       the timers structure
- * @is_write: the type of operation (read/write)
+ * @throttle: throttle direction
  * @ret:      true if the timer has been scheduled else false
  */
 bool throttle_schedule_timer(ThrottleState *ts,
                              ThrottleTimers *tt,
-                             bool is_write)
+                             ThrottleDirection direction)
 {
     int64_t now = qemu_clock_get_ns(tt->clock_type);
     int64_t next_timestamp;
     QEMUTimer *timer;
     bool must_wait;
 
-    timer = is_write ? tt->timers[THROTTLE_WRITE] : tt->timers[THROTTLE_READ];
+    assert(direction < THROTTLE_MAX);
+    timer = tt->timers[direction];
     assert(timer);
 
     must_wait = throttle_compute_timer(ts,
-                                       is_write,
+                                       direction,
                                        now,
                                        &next_timestamp);
 
@@ -462,10 +463,11 @@ bool throttle_schedule_timer(ThrottleState *ts,
 
 /* do the accounting for this operation
  *
- * @is_write: the type of operation (read/write)
+ * @throttle: throttle direction
  * @size:     the size of the operation
  */
-void throttle_account(ThrottleState *ts, bool is_write, uint64_t size)
+void throttle_account(ThrottleState *ts, ThrottleDirection direction,
+                      uint64_t size)
 {
     const BucketType bucket_types_size[2][2] = {
         { THROTTLE_BPS_TOTAL, THROTTLE_BPS_READ },
@@ -478,6 +480,7 @@ void throttle_account(ThrottleState *ts, bool is_write, uint64_t size)
     double units = 1.0;
     unsigned i;
 
+    assert(direction < THROTTLE_MAX);
     /* if cfg.op_size is defined and smaller than size we compute unit count */
     if (ts->cfg.op_size && size > ts->cfg.op_size) {
         units = (double) size / ts->cfg.op_size;
@@ -486,13 +489,13 @@ void throttle_account(ThrottleState *ts, bool is_write, uint64_t size)
     for (i = 0; i < 2; i++) {
         LeakyBucket *bkt;
 
-        bkt = &ts->cfg.buckets[bucket_types_size[is_write][i]];
+        bkt = &ts->cfg.buckets[bucket_types_size[direction][i]];
         bkt->level += size;
         if (bkt->burst_length > 1) {
             bkt->burst_level += size;
         }
 
-        bkt = &ts->cfg.buckets[bucket_types_units[is_write][i]];
+        bkt = &ts->cfg.buckets[bucket_types_units[direction][i]];
         bkt->level += units;
         if (bkt->burst_length > 1) {
             bkt->burst_level += units;
-- 
2.34.1


