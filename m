Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5779C75F249
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 12:11:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNsWS-00084H-Am; Mon, 24 Jul 2023 06:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qNsWO-0007vx-Kq
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:10:32 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qNsWC-0000pv-Rf
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:10:27 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1b8ad8383faso32046235ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 03:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690193419; x=1690798219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6VPEAG/rwGthrLq2mN5H5WqCPAGdQoLGAKzXLULMkIQ=;
 b=Kr4++d2DubKl3dIili3qhgBXoC6rJR6NAo6rROwRKoXYxvoiLlC5owM/3YL0rx4ecJ
 nwQS6O99rVNpI/aldD1ix/qgwDSC+b4hjIj0tPgLcmkVhieYSku4/O1ODewvEuFtzr0R
 zl/vZQ7obX0yALMtgG/Pc0g7XYfTKqT3ECpABhYfAGMDuIq1sGKu7hlJMgcqgc98DlH3
 3CUP3lgInmXvJXoVnECYMSJsk5qd/AoZAFuTDlUvIAWKZgQgywdN32XS+SsWdMtAnR3n
 waDxfQ0g3tFFwBqdYklYLljet7ebhywGysqLWIIzpWh3CyUwfkjb8zh7N/+t8o7JON8q
 c8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690193419; x=1690798219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6VPEAG/rwGthrLq2mN5H5WqCPAGdQoLGAKzXLULMkIQ=;
 b=Brrn7bN4Qez0b9UJG05oq6Nl2FVlzH1izHfTfIGAV4TqzJI0/3iU47BL+T4vMIouUA
 8WIVnn7IkR82NkY77munveJf+y3G3iLdynOCBGiXJzVuLLWWThVkLaPB+ZhtKf2F6BTW
 2cfiuNvcWqechubGFzEVUJ1ptQ2R3m+LLkyE+MUL2dh8OaM89jp7wa7yPrJPYl72tXYL
 o1zDo8fnx5ixUlQVM2uFVTs/CFHkrDe7J2Xt4royzbiSsMMcGWhpY2ebPvW/0pPUtOJW
 8kTgh/+7XcAsFNmO/uzibGrZbQKuRSiLXKKXdVQclZJ0g9KQLHV6bD5Ke7u5y6/HiUuP
 9j5w==
X-Gm-Message-State: ABy/qLaamsgj7ki92HkTbSWwa4Bux9BOVmRaj6llChZuG9TRA8cRp2py
 7+fdyB9uZSqKyPkaSXpbLwAkxg==
X-Google-Smtp-Source: APBJJlHqLSry+sOvY+RnnOc8RHfoK+bRM44u8v78eKN0M6wXssbWhRA/gf3+jE9AQj9Ih+bqfyC85A==
X-Received: by 2002:a17:902:c404:b0:1b8:abe7:5a80 with SMTP id
 k4-20020a170902c40400b001b8abe75a80mr15197611plk.40.1690193418753; 
 Mon, 24 Jul 2023 03:10:18 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 je2-20020a170903264200b001bb9d6b1baasm2419124plb.198.2023.07.24.03.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 03:10:18 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com, kwolf@redhat.com, groug@kaod.org, qemu_oss@crudebyte.com,
 hreitz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, berrange@redhat.com,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v4 9/9] block/throttle-groups: Use ThrottleDirection instread
 of bool is_write
Date: Mon, 24 Jul 2023 18:09:39 +0800
Message-Id: <20230724100939.1022984-10-pizhenwei@bytedance.com>
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

'bool is_write' style is obsolete from throttle framework, adapt
block throttle groups to the new style.

Use a simple python script to test the new style:
 #!/usr/bin/python3
import subprocess
import random
import time

commands = ['virsh blkdeviotune jammy vda --write-bytes-sec ', \
            'virsh blkdeviotune jammy vda --write-iops-sec ', \
            'virsh blkdeviotune jammy vda --read-bytes-sec ', \
            'virsh blkdeviotune jammy vda --read-iops-sec ']

for loop in range(1, 1000):
    time.sleep(random.randrange(3, 5))
    command = commands[random.randrange(0, 3)] + str(random.randrange(0, 1000000))
    subprocess.run(command, shell=True, check=True)

This works fine.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 block/throttle-groups.c         | 105 ++++++++++++++++----------------
 block/throttle.c                |   8 +--
 include/block/throttle-groups.h |   6 +-
 3 files changed, 60 insertions(+), 59 deletions(-)

diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 3847d27801..c7c700fdb6 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -37,7 +37,7 @@
 
 static void throttle_group_obj_init(Object *obj);
 static void throttle_group_obj_complete(UserCreatable *obj, Error **errp);
-static void timer_cb(ThrottleGroupMember *tgm, bool is_write);
+static void timer_cb(ThrottleGroupMember *tgm, ThrottleDirection direction);
 
 /* The ThrottleGroup structure (with its ThrottleState) is shared
  * among different ThrottleGroupMembers and it's independent from
@@ -73,8 +73,8 @@ struct ThrottleGroup {
     QemuMutex lock; /* This lock protects the following four fields */
     ThrottleState ts;
     QLIST_HEAD(, ThrottleGroupMember) head;
-    ThrottleGroupMember *tokens[2];
-    bool any_timer_armed[2];
+    ThrottleGroupMember *tokens[THROTTLE_MAX];
+    bool any_timer_armed[THROTTLE_MAX];
     QEMUClockType clock_type;
 
     /* This field is protected by the global QEMU mutex */
@@ -197,13 +197,13 @@ static ThrottleGroupMember *throttle_group_next_tgm(ThrottleGroupMember *tgm)
  * This assumes that tg->lock is held.
  *
  * @tgm:        the ThrottleGroupMember
- * @is_write:   the type of operation (read/write)
+ * @direction:  the ThrottleDirection
  * @ret:        whether the ThrottleGroupMember has pending requests.
  */
 static inline bool tgm_has_pending_reqs(ThrottleGroupMember *tgm,
-                                        bool is_write)
+                                        ThrottleDirection direction)
 {
-    return tgm->pending_reqs[is_write];
+    return tgm->pending_reqs[direction];
 }
 
 /* Return the next ThrottleGroupMember in the round-robin sequence with pending
@@ -212,12 +212,12 @@ static inline bool tgm_has_pending_reqs(ThrottleGroupMember *tgm,
  * This assumes that tg->lock is held.
  *
  * @tgm:       the current ThrottleGroupMember
- * @is_write:  the type of operation (read/write)
+ * @direction: the ThrottleDirection
  * @ret:       the next ThrottleGroupMember with pending requests, or tgm if
  *             there is none.
  */
 static ThrottleGroupMember *next_throttle_token(ThrottleGroupMember *tgm,
-                                                bool is_write)
+                                                ThrottleDirection direction)
 {
     ThrottleState *ts = tgm->throttle_state;
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
@@ -227,16 +227,16 @@ static ThrottleGroupMember *next_throttle_token(ThrottleGroupMember *tgm,
      * it's being drained. Skip the round-robin search and return tgm
      * immediately if it has pending requests. Otherwise we could be
      * forcing it to wait for other member's throttled requests. */
-    if (tgm_has_pending_reqs(tgm, is_write) &&
+    if (tgm_has_pending_reqs(tgm, direction) &&
         qatomic_read(&tgm->io_limits_disabled)) {
         return tgm;
     }
 
-    start = token = tg->tokens[is_write];
+    start = token = tg->tokens[direction];
 
     /* get next bs round in round robin style */
     token = throttle_group_next_tgm(token);
-    while (token != start && !tgm_has_pending_reqs(token, is_write)) {
+    while (token != start && !tgm_has_pending_reqs(token, direction)) {
         token = throttle_group_next_tgm(token);
     }
 
@@ -244,12 +244,12 @@ static ThrottleGroupMember *next_throttle_token(ThrottleGroupMember *tgm,
      * then decide the token is the current tgm because chances are
      * the current tgm got the current request queued.
      */
-    if (token == start && !tgm_has_pending_reqs(token, is_write)) {
+    if (token == start && !tgm_has_pending_reqs(token, direction)) {
         token = tgm;
     }
 
     /* Either we return the original TGM, or one with pending requests */
-    assert(token == tgm || tgm_has_pending_reqs(token, is_write));
+    assert(token == tgm || tgm_has_pending_reqs(token, direction));
 
     return token;
 }
@@ -261,16 +261,15 @@ static ThrottleGroupMember *next_throttle_token(ThrottleGroupMember *tgm,
  * This assumes that tg->lock is held.
  *
  * @tgm:        the current ThrottleGroupMember
- * @is_write:   the type of operation (read/write)
+ * @direction:  the ThrottleDirection
  * @ret:        whether the I/O request needs to be throttled or not
  */
 static bool throttle_group_schedule_timer(ThrottleGroupMember *tgm,
-                                          bool is_write)
+                                          ThrottleDirection direction)
 {
     ThrottleState *ts = tgm->throttle_state;
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
     ThrottleTimers *tt = &tgm->throttle_timers;
-    ThrottleDirection direction = is_write ? THROTTLE_WRITE : THROTTLE_READ;
     bool must_wait;
 
     if (qatomic_read(&tgm->io_limits_disabled)) {
@@ -278,7 +277,7 @@ static bool throttle_group_schedule_timer(ThrottleGroupMember *tgm,
     }
 
     /* Check if any of the timers in this group is already armed */
-    if (tg->any_timer_armed[is_write]) {
+    if (tg->any_timer_armed[direction]) {
         return true;
     }
 
@@ -286,8 +285,8 @@ static bool throttle_group_schedule_timer(ThrottleGroupMember *tgm,
 
     /* If a timer just got armed, set tgm as the current token */
     if (must_wait) {
-        tg->tokens[is_write] = tgm;
-        tg->any_timer_armed[is_write] = true;
+        tg->tokens[direction] = tgm;
+        tg->any_timer_armed[direction] = true;
     }
 
     return must_wait;
@@ -297,15 +296,15 @@ static bool throttle_group_schedule_timer(ThrottleGroupMember *tgm,
  * any request was actually pending.
  *
  * @tgm:       the current ThrottleGroupMember
- * @is_write:  the type of operation (read/write)
+ * @direction: the ThrottleDirection
  */
 static bool coroutine_fn throttle_group_co_restart_queue(ThrottleGroupMember *tgm,
-                                                         bool is_write)
+                                                         ThrottleDirection direction)
 {
     bool ret;
 
     qemu_co_mutex_lock(&tgm->throttled_reqs_lock);
-    ret = qemu_co_queue_next(&tgm->throttled_reqs[is_write]);
+    ret = qemu_co_queue_next(&tgm->throttled_reqs[direction]);
     qemu_co_mutex_unlock(&tgm->throttled_reqs_lock);
 
     return ret;
@@ -316,9 +315,10 @@ static bool coroutine_fn throttle_group_co_restart_queue(ThrottleGroupMember *tg
  * This assumes that tg->lock is held.
  *
  * @tgm:       the current ThrottleGroupMember
- * @is_write:  the type of operation (read/write)
+ * @direction: the ThrottleDirection
  */
-static void schedule_next_request(ThrottleGroupMember *tgm, bool is_write)
+static void schedule_next_request(ThrottleGroupMember *tgm,
+                                  ThrottleDirection direction)
 {
     ThrottleState *ts = tgm->throttle_state;
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
@@ -326,27 +326,27 @@ static void schedule_next_request(ThrottleGroupMember *tgm, bool is_write)
     ThrottleGroupMember *token;
 
     /* Check if there's any pending request to schedule next */
-    token = next_throttle_token(tgm, is_write);
-    if (!tgm_has_pending_reqs(token, is_write)) {
+    token = next_throttle_token(tgm, direction);
+    if (!tgm_has_pending_reqs(token, direction)) {
         return;
     }
 
     /* Set a timer for the request if it needs to be throttled */
-    must_wait = throttle_group_schedule_timer(token, is_write);
+    must_wait = throttle_group_schedule_timer(token, direction);
 
     /* If it doesn't have to wait, queue it for immediate execution */
     if (!must_wait) {
         /* Give preference to requests from the current tgm */
         if (qemu_in_coroutine() &&
-            throttle_group_co_restart_queue(tgm, is_write)) {
+            throttle_group_co_restart_queue(tgm, direction)) {
             token = tgm;
         } else {
             ThrottleTimers *tt = &token->throttle_timers;
             int64_t now = qemu_clock_get_ns(tg->clock_type);
-            timer_mod(tt->timers[is_write], now);
-            tg->any_timer_armed[is_write] = true;
+            timer_mod(tt->timers[direction], now);
+            tg->any_timer_armed[direction] = true;
         }
-        tg->tokens[is_write] = token;
+        tg->tokens[direction] = token;
     }
 }
 
@@ -356,49 +356,49 @@ static void schedule_next_request(ThrottleGroupMember *tgm, bool is_write)
  *
  * @tgm:       the current ThrottleGroupMember
  * @bytes:     the number of bytes for this I/O
- * @is_write:  the type of operation (read/write)
+ * @direction: the ThrottleDirection
  */
 void coroutine_fn throttle_group_co_io_limits_intercept(ThrottleGroupMember *tgm,
                                                         int64_t bytes,
-                                                        bool is_write)
+                                                        ThrottleDirection direction)
 {
     bool must_wait;
     ThrottleGroupMember *token;
     ThrottleGroup *tg = container_of(tgm->throttle_state, ThrottleGroup, ts);
-    ThrottleDirection direction = is_write ? THROTTLE_WRITE : THROTTLE_READ;
 
     assert(bytes >= 0);
+    assert(direction < THROTTLE_MAX);
 
     qemu_mutex_lock(&tg->lock);
 
     /* First we check if this I/O has to be throttled. */
-    token = next_throttle_token(tgm, is_write);
-    must_wait = throttle_group_schedule_timer(token, is_write);
+    token = next_throttle_token(tgm, direction);
+    must_wait = throttle_group_schedule_timer(token, direction);
 
     /* Wait if there's a timer set or queued requests of this type */
-    if (must_wait || tgm->pending_reqs[is_write]) {
-        tgm->pending_reqs[is_write]++;
+    if (must_wait || tgm->pending_reqs[direction]) {
+        tgm->pending_reqs[direction]++;
         qemu_mutex_unlock(&tg->lock);
         qemu_co_mutex_lock(&tgm->throttled_reqs_lock);
-        qemu_co_queue_wait(&tgm->throttled_reqs[is_write],
+        qemu_co_queue_wait(&tgm->throttled_reqs[direction],
                            &tgm->throttled_reqs_lock);
         qemu_co_mutex_unlock(&tgm->throttled_reqs_lock);
         qemu_mutex_lock(&tg->lock);
-        tgm->pending_reqs[is_write]--;
+        tgm->pending_reqs[direction]--;
     }
 
     /* The I/O will be executed, so do the accounting */
     throttle_account(tgm->throttle_state, direction, bytes);
 
     /* Schedule the next request */
-    schedule_next_request(tgm, is_write);
+    schedule_next_request(tgm, direction);
 
     qemu_mutex_unlock(&tg->lock);
 }
 
 typedef struct {
     ThrottleGroupMember *tgm;
-    bool is_write;
+    ThrottleDirection direction;
 } RestartData;
 
 static void coroutine_fn throttle_group_restart_queue_entry(void *opaque)
@@ -407,16 +407,16 @@ static void coroutine_fn throttle_group_restart_queue_entry(void *opaque)
     ThrottleGroupMember *tgm = data->tgm;
     ThrottleState *ts = tgm->throttle_state;
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
-    bool is_write = data->is_write;
+    ThrottleDirection direction = data->direction;
     bool empty_queue;
 
-    empty_queue = !throttle_group_co_restart_queue(tgm, is_write);
+    empty_queue = !throttle_group_co_restart_queue(tgm, direction);
 
     /* If the request queue was empty then we have to take care of
      * scheduling the next one */
     if (empty_queue) {
         qemu_mutex_lock(&tg->lock);
-        schedule_next_request(tgm, is_write);
+        schedule_next_request(tgm, direction);
         qemu_mutex_unlock(&tg->lock);
     }
 
@@ -426,18 +426,19 @@ static void coroutine_fn throttle_group_restart_queue_entry(void *opaque)
     aio_wait_kick();
 }
 
-static void throttle_group_restart_queue(ThrottleGroupMember *tgm, bool is_write)
+static void throttle_group_restart_queue(ThrottleGroupMember *tgm,
+                                        ThrottleDirection direction)
 {
     Coroutine *co;
     RestartData *rd = g_new0(RestartData, 1);
 
     rd->tgm = tgm;
-    rd->is_write = is_write;
+    rd->direction = direction;
 
     /* This function is called when a timer is fired or when
      * throttle_group_restart_tgm() is called. Either way, there can
      * be no timer pending on this tgm at this point */
-    assert(!timer_pending(tgm->throttle_timers.timers[is_write]));
+    assert(!timer_pending(tgm->throttle_timers.timers[direction]));
 
     qatomic_inc(&tgm->restart_pending);
 
@@ -502,20 +503,20 @@ void throttle_group_get_config(ThrottleGroupMember *tgm, ThrottleConfig *cfg)
  * because it had been throttled.
  *
  * @tgm:       the ThrottleGroupMember whose request had been throttled
- * @is_write:  the type of operation (read/write)
+ * @direction: the ThrottleDirection
  */
-static void timer_cb(ThrottleGroupMember *tgm, bool is_write)
+static void timer_cb(ThrottleGroupMember *tgm, ThrottleDirection direction)
 {
     ThrottleState *ts = tgm->throttle_state;
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
 
     /* The timer has just been fired, so we can update the flag */
     qemu_mutex_lock(&tg->lock);
-    tg->any_timer_armed[is_write] = false;
+    tg->any_timer_armed[direction] = false;
     qemu_mutex_unlock(&tg->lock);
 
     /* Run the request that was waiting for this timer */
-    throttle_group_restart_queue(tgm, is_write);
+    throttle_group_restart_queue(tgm, direction);
 }
 
 static void read_timer_cb(void *opaque)
diff --git a/block/throttle.c b/block/throttle.c
index 3aaef18d4e..1098a4ae9a 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -118,7 +118,7 @@ throttle_co_preadv(BlockDriverState *bs, int64_t offset, int64_t bytes,
 {
 
     ThrottleGroupMember *tgm = bs->opaque;
-    throttle_group_co_io_limits_intercept(tgm, bytes, false);
+    throttle_group_co_io_limits_intercept(tgm, bytes, THROTTLE_READ);
 
     return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
 }
@@ -128,7 +128,7 @@ throttle_co_pwritev(BlockDriverState *bs, int64_t offset, int64_t bytes,
                     QEMUIOVector *qiov, BdrvRequestFlags flags)
 {
     ThrottleGroupMember *tgm = bs->opaque;
-    throttle_group_co_io_limits_intercept(tgm, bytes, true);
+    throttle_group_co_io_limits_intercept(tgm, bytes, THROTTLE_WRITE);
 
     return bdrv_co_pwritev(bs->file, offset, bytes, qiov, flags);
 }
@@ -138,7 +138,7 @@ throttle_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
                           BdrvRequestFlags flags)
 {
     ThrottleGroupMember *tgm = bs->opaque;
-    throttle_group_co_io_limits_intercept(tgm, bytes, true);
+    throttle_group_co_io_limits_intercept(tgm, bytes, THROTTLE_WRITE);
 
     return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
 }
@@ -147,7 +147,7 @@ static int coroutine_fn GRAPH_RDLOCK
 throttle_co_pdiscard(BlockDriverState *bs, int64_t offset, int64_t bytes)
 {
     ThrottleGroupMember *tgm = bs->opaque;
-    throttle_group_co_io_limits_intercept(tgm, bytes, true);
+    throttle_group_co_io_limits_intercept(tgm, bytes, THROTTLE_WRITE);
 
     return bdrv_co_pdiscard(bs->file, offset, bytes);
 }
diff --git a/include/block/throttle-groups.h b/include/block/throttle-groups.h
index ff282fc0f8..2355e8d9de 100644
--- a/include/block/throttle-groups.h
+++ b/include/block/throttle-groups.h
@@ -37,7 +37,7 @@ typedef struct ThrottleGroupMember {
     AioContext   *aio_context;
     /* throttled_reqs_lock protects the CoQueues for throttled requests.  */
     CoMutex      throttled_reqs_lock;
-    CoQueue      throttled_reqs[2];
+    CoQueue      throttled_reqs[THROTTLE_MAX];
 
     /* Nonzero if the I/O limits are currently being ignored; generally
      * it is zero.  Accessed with atomic operations.
@@ -54,7 +54,7 @@ typedef struct ThrottleGroupMember {
      * throttle_state tells us if I/O limits are configured. */
     ThrottleState *throttle_state;
     ThrottleTimers throttle_timers;
-    unsigned       pending_reqs[2];
+    unsigned       pending_reqs[THROTTLE_MAX];
     QLIST_ENTRY(ThrottleGroupMember) round_robin;
 
 } ThrottleGroupMember;
@@ -78,7 +78,7 @@ void throttle_group_restart_tgm(ThrottleGroupMember *tgm);
 
 void coroutine_fn throttle_group_co_io_limits_intercept(ThrottleGroupMember *tgm,
                                                         int64_t bytes,
-                                                        bool is_write);
+                                                        ThrottleDirection direction);
 void throttle_group_attach_aio_context(ThrottleGroupMember *tgm,
                                        AioContext *new_context);
 void throttle_group_detach_aio_context(ThrottleGroupMember *tgm);
-- 
2.34.1


