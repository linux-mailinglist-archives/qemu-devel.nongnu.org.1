Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 099C07518FA
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 08:42:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJq1U-0004jt-Ch; Thu, 13 Jul 2023 02:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qJq1R-0004j0-GQ
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 02:41:53 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qJq1O-0007sW-Bt
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 02:41:53 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1b9c368f4b5so11130035ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 23:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1689230509; x=1691822509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mWAgTNnK/+O89w8pPWdsdxQaPBi4WLZtbT7kA5oIS2g=;
 b=Jx+t/n/1l2MX13ySP+PmGuE0t2gkk9bbgmTDzJraj/wltunXq6EiOIctBnkNRuhlRc
 1Bv14T+thc9A4U59LqQRypaj1fwYlxOwXtbI9Y5TsZuSDGECdUi2TOrt8NO/kfSYI2Xf
 WhhR0Q5TBWYN+LC2LERHAkGObGB2h4Xe9zEG96rBZ6Co86QwCZ8t//HshQQsVdRjepb8
 pKQC6rwgoRQyqFEDEncotIKxty8amBHI0kOzTgCtxvciMtm0IsBSOtE115iC80mcta+q
 B0ubfNSp3AHr+MUIVDMYnUC+ZCLEM62SYhpSrBKcMyHlWcoWp2VPZbxQBx718WkodEIb
 5oIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689230509; x=1691822509;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mWAgTNnK/+O89w8pPWdsdxQaPBi4WLZtbT7kA5oIS2g=;
 b=L9JQ8JZT9y/Gl94CvtqglvoRf58ZNHCELQD5yQa0udLl4d5Tdx3vev7Z93v6hOUOrk
 5PIsMfEKqDV2aRmfsQLTWKEZV8fr959UPETBsKpGPajdzSwiQw70rNzNE1C1QRUxK9uV
 v9acM6VF6sxEYhEemrTmgmxf/B6NGz1csMyr+CK1Iqq/J7NXS+qP1IscZ8bhJizPy1SH
 P1Grg74Wqc3sItNmvlV7LY+DcJyh9VVCvDm6MzMcfF2kvjdE5iwcSQwbEmYa8vYFvola
 w10otOvSSBiEBRMJoGeBpsjZ9RdK600MQucGXU+fyTDy7gGSCeQhqjsvf2E499rXcOWD
 By8w==
X-Gm-Message-State: ABy/qLZafLQlLmpaTcYqcFEUu+pdOC8onheXSBLDjswn5InX8RWNTf50
 e44ZS+PIYrchzxe2KpsYjMNURw==
X-Google-Smtp-Source: APBJJlHsf5ocEyxKUIjZ4CqWF4LLVAFIY+kFSoJYBaSeS1AsqOZnHsbjYAUjpjU5K7WTpxo+/U4Q4g==
X-Received: by 2002:a17:903:2309:b0:1b8:af5e:853c with SMTP id
 d9-20020a170903230900b001b8af5e853cmr1410357plh.26.1689230509075; 
 Wed, 12 Jul 2023 23:41:49 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a170902680d00b001ac2be26340sm5144966plk.222.2023.07.12.23.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 23:41:48 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com, kwolf@redhat.com, groug@kaod.org, qemu_oss@crudebyte.com,
 hreitz@redhat.com
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v3 6/6] throttle: use enum ThrottleType instead of bool
 is_write
Date: Thu, 13 Jul 2023 14:41:11 +0800
Message-Id: <20230713064111.558652-7-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713064111.558652-1-pizhenwei@bytedance.com>
References: <20230713064111.558652-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

enum ThrottleType is already there, use ThrottleType instead of
'bool is_write' for throttle API, also modify related codes from
block, fsdev, cryptodev and tests.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 backends/cryptodev.c        |  9 +++++----
 block/throttle-groups.c     |  6 ++++--
 fsdev/qemu-fsdev-throttle.c |  8 +++++---
 include/qemu/throttle.h     |  4 ++--
 tests/unit/test-throttle.c  |  4 ++--
 util/throttle.c             | 30 ++++++++++++++++--------------
 6 files changed, 34 insertions(+), 27 deletions(-)

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
index fb203c3ced..429b9d1dae 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -270,6 +270,7 @@ static bool throttle_group_schedule_timer(ThrottleGroupMember *tgm,
     ThrottleState *ts = tgm->throttle_state;
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
     ThrottleTimers *tt = &tgm->throttle_timers;
+    ThrottleType throttle = is_write ? THROTTLE_WRITE : THROTTLE_READ;
     bool must_wait;
 
     if (qatomic_read(&tgm->io_limits_disabled)) {
@@ -281,7 +282,7 @@ static bool throttle_group_schedule_timer(ThrottleGroupMember *tgm,
         return true;
     }
 
-    must_wait = throttle_schedule_timer(ts, tt, is_write);
+    must_wait = throttle_schedule_timer(ts, tt, throttle);
 
     /* If a timer just got armed, set tgm as the current token */
     if (must_wait) {
@@ -364,6 +365,7 @@ void coroutine_fn throttle_group_co_io_limits_intercept(ThrottleGroupMember *tgm
     bool must_wait;
     ThrottleGroupMember *token;
     ThrottleGroup *tg = container_of(tgm->throttle_state, ThrottleGroup, ts);
+    ThrottleType throttle = is_write ? THROTTLE_WRITE : THROTTLE_READ;
 
     assert(bytes >= 0);
 
@@ -386,7 +388,7 @@ void coroutine_fn throttle_group_co_io_limits_intercept(ThrottleGroupMember *tgm
     }
 
     /* The I/O will be executed, so do the accounting */
-    throttle_account(tgm->throttle_state, is_write, bytes);
+    throttle_account(tgm->throttle_state, throttle, bytes);
 
     /* Schedule the next request */
     schedule_next_request(tgm, is_write);
diff --git a/fsdev/qemu-fsdev-throttle.c b/fsdev/qemu-fsdev-throttle.c
index 5c83a1cc09..4aa5bc0196 100644
--- a/fsdev/qemu-fsdev-throttle.c
+++ b/fsdev/qemu-fsdev-throttle.c
@@ -97,16 +97,18 @@ void fsdev_throttle_init(FsThrottle *fst)
 void coroutine_fn fsdev_co_throttle_request(FsThrottle *fst, bool is_write,
                                             struct iovec *iov, int iovcnt)
 {
+    ThrottleType throttle = is_write ? THROTTLE_WRITE : THROTTLE_READ;
+
     if (throttle_enabled(&fst->cfg)) {
-        if (throttle_schedule_timer(&fst->ts, &fst->tt, is_write) ||
+        if (throttle_schedule_timer(&fst->ts, &fst->tt, throttle) ||
             !qemu_co_queue_empty(&fst->throttled_reqs[is_write])) {
             qemu_co_queue_wait(&fst->throttled_reqs[is_write], NULL);
         }
 
-        throttle_account(&fst->ts, is_write, iov_size(iov, iovcnt));
+        throttle_account(&fst->ts, throttle, iov_size(iov, iovcnt));
 
         if (!qemu_co_queue_empty(&fst->throttled_reqs[is_write]) &&
-            !throttle_schedule_timer(&fst->ts, &fst->tt, is_write)) {
+            !throttle_schedule_timer(&fst->ts, &fst->tt, throttle)) {
             qemu_co_queue_next(&fst->throttled_reqs[is_write]);
         }
     }
diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
index ba6293eeef..1cd6b0c397 100644
--- a/include/qemu/throttle.h
+++ b/include/qemu/throttle.h
@@ -154,9 +154,9 @@ void throttle_config_init(ThrottleConfig *cfg);
 /* usage */
 bool throttle_schedule_timer(ThrottleState *ts,
                              ThrottleTimers *tt,
-                             bool is_write);
+                             ThrottleType throttle);
 
-void throttle_account(ThrottleState *ts, bool is_write, uint64_t size);
+void throttle_account(ThrottleState *ts, ThrottleType throttle, uint64_t size);
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
index c0bd0c26c3..5e4dc0bfdd 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -136,11 +136,11 @@ int64_t throttle_compute_wait(LeakyBucket *bkt)
 
 /* This function compute the time that must be waited while this IO
  *
- * @is_write:   true if the current IO is a write, false if it's a read
+ * @throttle:   throttle type
  * @ret:        time to wait
  */
 static int64_t throttle_compute_wait_for(ThrottleState *ts,
-                                         bool is_write)
+                                         ThrottleType throttle)
 {
     BucketType to_check[2][4] = { {THROTTLE_BPS_TOTAL,
                                    THROTTLE_OPS_TOTAL,
@@ -154,7 +154,7 @@ static int64_t throttle_compute_wait_for(ThrottleState *ts,
     int i;
 
     for (i = 0; i < 4; i++) {
-        BucketType index = to_check[is_write][i];
+        BucketType index = to_check[throttle][i];
         wait = throttle_compute_wait(&ts->cfg.buckets[index]);
         if (wait > max_wait) {
             max_wait = wait;
@@ -166,13 +166,13 @@ static int64_t throttle_compute_wait_for(ThrottleState *ts,
 
 /* compute the timer for this type of operation
  *
- * @is_write:   the type of operation
+ * @throttle:   throttle type
  * @now:        the current clock timestamp
  * @next_timestamp: the resulting timer
  * @ret:        true if a timer must be set
  */
 static bool throttle_compute_timer(ThrottleState *ts,
-                                   bool is_write,
+                                   ThrottleType throttle,
                                    int64_t now,
                                    int64_t *next_timestamp)
 {
@@ -182,7 +182,7 @@ static bool throttle_compute_timer(ThrottleState *ts,
     throttle_do_leak(ts, now);
 
     /* compute the wait time if any */
-    wait = throttle_compute_wait_for(ts, is_write);
+    wait = throttle_compute_wait_for(ts, throttle);
 
     /* if the code must wait compute when the next timer should fire */
     if (wait) {
@@ -423,23 +423,24 @@ void throttle_get_config(ThrottleState *ts, ThrottleConfig *cfg)
  * NOTE: this function is not unit tested due to it's usage of timer_mod
  *
  * @tt:       the timers structure
- * @is_write: the type of operation (read/write)
+ * @throttle: throttle type
  * @ret:      true if the timer has been scheduled else false
  */
 bool throttle_schedule_timer(ThrottleState *ts,
                              ThrottleTimers *tt,
-                             bool is_write)
+                             ThrottleType throttle)
 {
     int64_t now = qemu_clock_get_ns(tt->clock_type);
     int64_t next_timestamp;
     QEMUTimer *timer;
     bool must_wait;
 
-    timer = is_write ? tt->timers[THROTTLE_WRITE] : tt->timers[THROTTLE_READ];
+    assert(throttle < THROTTLE_MAX);
+    timer = tt->timers[throttle];
     assert(timer);
 
     must_wait = throttle_compute_timer(ts,
-                                       is_write,
+                                       throttle,
                                        now,
                                        &next_timestamp);
 
@@ -460,10 +461,10 @@ bool throttle_schedule_timer(ThrottleState *ts,
 
 /* do the accounting for this operation
  *
- * @is_write: the type of operation (read/write)
+ * @throttle: throttle type
  * @size:     the size of the operation
  */
-void throttle_account(ThrottleState *ts, bool is_write, uint64_t size)
+void throttle_account(ThrottleState *ts, ThrottleType throttle, uint64_t size)
 {
     const BucketType bucket_types_size[2][2] = {
         { THROTTLE_BPS_TOTAL, THROTTLE_BPS_READ },
@@ -476,6 +477,7 @@ void throttle_account(ThrottleState *ts, bool is_write, uint64_t size)
     double units = 1.0;
     unsigned i;
 
+    assert(throttle < THROTTLE_MAX);
     /* if cfg.op_size is defined and smaller than size we compute unit count */
     if (ts->cfg.op_size && size > ts->cfg.op_size) {
         units = (double) size / ts->cfg.op_size;
@@ -484,13 +486,13 @@ void throttle_account(ThrottleState *ts, bool is_write, uint64_t size)
     for (i = 0; i < 2; i++) {
         LeakyBucket *bkt;
 
-        bkt = &ts->cfg.buckets[bucket_types_size[is_write][i]];
+        bkt = &ts->cfg.buckets[bucket_types_size[throttle][i]];
         bkt->level += size;
         if (bkt->burst_length > 1) {
             bkt->burst_level += size;
         }
 
-        bkt = &ts->cfg.buckets[bucket_types_units[is_write][i]];
+        bkt = &ts->cfg.buckets[bucket_types_units[throttle][i]];
         bkt->level += units;
         if (bkt->burst_length > 1) {
             bkt->burst_level += units;
-- 
2.34.1


