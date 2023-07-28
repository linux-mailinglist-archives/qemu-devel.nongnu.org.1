Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E7676624B
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 05:09:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPD5y-000812-Tt; Thu, 27 Jul 2023 22:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qPD5w-00080I-EO
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 22:20:44 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qPD5t-00074U-Q6
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 22:20:44 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bb9e6c2a90so12758565ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 19:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690510840; x=1691115640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HcCs4b7e0ZsFuCKArukEgfiWdiQeBbMSgre2yImNmBY=;
 b=Dd8IeL2np9jbRNT5Hjjqb2Swldm3hAvI/ENW6Y8EtrKwibHX2cDNXOwlPyFy3uLlYV
 WM5KZ5cjnic7l23XV1dvS6W0ulA9elQeblY7YaTFud2akfm/gQ39IUAy6QYZjPajcCOC
 e2uIL/8Z3pFkUOYnx4EnUfHPVc+ZNFb4d7/rT83T7OC1xQupevQoHwNtmWuP5uQiwIhl
 twgk2fWbUIJsUvw6VjaweGQMwWeSKIqqNvOJIsENIj66q0NsHqKCYCajLIA1yvcVzko8
 bEF+vW91HEDzU1JKUOVjETva+aUWYZYWFg1YoD/Ue40AWI9DCQWOeHw6cdN4YnI/VuBg
 HBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690510840; x=1691115640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HcCs4b7e0ZsFuCKArukEgfiWdiQeBbMSgre2yImNmBY=;
 b=l5b0dltfd39Eju2Qcj0WAdq8wzEFfPm+tUQYch4Md9v7NWenX7x8ekhjnh8xIZOV5g
 h68dUC+j61FfnWlkP7z9WK9KYPGN3Y4ZmJkwsIIMj9IkZ4HB8Ywzfz/N44ScEGOzjvaN
 KVbnhGTse11PJEo8o9pyT9SkpFX0V9MaK0vJtOuwT7h9nkqeQV56lhVBOu9Samy2wMTE
 DFdNAIQXyZvKZ51HrPeP1LPdfqgYEPOESMOD3Ok1Rd4NLFyEjxycqkULU3dWdF7U2C6E
 ChZhDDCvpiiLjh1HuUlhXnFbNcImXFGjaAmZc4dBeNQ1xUpzq+tIqCRiorys5RQN55RN
 +VXw==
X-Gm-Message-State: ABy/qLZdaghoKMRMZRJ4+JinQs6DANyMFmDNLkPy2u5VgMYiux835DoY
 yTSiDvDjO5HbQNwnesrzavG5KA==
X-Google-Smtp-Source: APBJJlH8sOFjS3OvjOXkcGkI+etQVyGuVTY8haxTbGWs1XsOritpaSWaJzC49MEpESE8nbNKaoa7Aw==
X-Received: by 2002:a17:902:eccc:b0:1b8:1335:b775 with SMTP id
 a12-20020a170902eccc00b001b81335b775mr578454plh.0.1690510840622; 
 Thu, 27 Jul 2023 19:20:40 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 b21-20020a170902d31500b001bb9f104328sm2312947plc.146.2023.07.27.19.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 19:20:40 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com,
	kwolf@redhat.com,
	hreitz@redhat.com
Cc: qemu_oss@crudebyte.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v5 9/9] block/throttle-groups: Use ThrottleDirection instread
 of bool is_write
Date: Fri, 28 Jul 2023 10:20:06 +0800
Message-Id: <20230728022006.1098509-10-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728022006.1098509-1-pizhenwei@bytedance.com>
References: <20230728022006.1098509-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x633.google.com
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

'bool is_write' style is obsolete from throttle framework, adapt
block throttle groups to the new style:
- use ThrottleDirection instead of 'bool is_write'. Ex,
  schedule_next_request(ThrottleGroupMember *tgm, bool is_write)
  -> schedule_next_request(ThrottleGroupMember *tgm, ThrottleDirection direction)

- use THROTTLE_MAX instead of hard code. Ex, ThrottleGroupMember *tokens[2]
  -> ThrottleGroupMember *tokens[THROTTLE_MAX]

- use ThrottleDirection instead of hard code on iteration. Ex, (i = 0; i < 2; i++)
  -> for (dir = THROTTLE_READ; dir < THROTTLE_MAX; dir++)

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
 block/block-backend.c           |   4 +-
 block/throttle-groups.c         | 161 ++++++++++++++++----------------
 block/throttle.c                |   8 +-
 include/block/throttle-groups.h |   6 +-
 4 files changed, 90 insertions(+), 89 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 4009ed5fed..47d360c97a 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1341,7 +1341,7 @@ blk_co_do_preadv_part(BlockBackend *blk, int64_t offset, int64_t bytes,
     /* throttling disk I/O */
     if (blk->public.throttle_group_member.throttle_state) {
         throttle_group_co_io_limits_intercept(&blk->public.throttle_group_member,
-                bytes, false);
+                bytes, THROTTLE_READ);
     }
 
     ret = bdrv_co_preadv_part(blk->root, offset, bytes, qiov, qiov_offset,
@@ -1415,7 +1415,7 @@ blk_co_do_pwritev_part(BlockBackend *blk, int64_t offset, int64_t bytes,
     /* throttling disk I/O */
     if (blk->public.throttle_group_member.throttle_state) {
         throttle_group_co_io_limits_intercept(&blk->public.throttle_group_member,
-                bytes, true);
+                bytes, THROTTLE_WRITE);
     }
 
     if (!blk->enable_write_cache) {
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 3847d27801..3eda4c4e3d 100644
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
 
@@ -447,18 +448,18 @@ static void throttle_group_restart_queue(ThrottleGroupMember *tgm, bool is_write
 
 void throttle_group_restart_tgm(ThrottleGroupMember *tgm)
 {
-    int i;
+    ThrottleDirection dir;
 
     if (tgm->throttle_state) {
-        for (i = 0; i < 2; i++) {
-            QEMUTimer *t = tgm->throttle_timers.timers[i];
+        for (dir = THROTTLE_READ; dir < THROTTLE_MAX; dir++) {
+            QEMUTimer *t = tgm->throttle_timers.timers[dir];
             if (timer_pending(t)) {
                 /* If there's a pending timer on this tgm, fire it now */
                 timer_del(t);
-                timer_cb(tgm, i);
+                timer_cb(tgm, dir);
             } else {
                 /* Else run the next request from the queue manually */
-                throttle_group_restart_queue(tgm, i);
+                throttle_group_restart_queue(tgm, dir);
             }
         }
     }
@@ -502,30 +503,30 @@ void throttle_group_get_config(ThrottleGroupMember *tgm, ThrottleConfig *cfg)
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
 {
-    timer_cb(opaque, false);
+    timer_cb(opaque, THROTTLE_READ);
 }
 
 static void write_timer_cb(void *opaque)
 {
-    timer_cb(opaque, true);
+    timer_cb(opaque, THROTTLE_WRITE);
 }
 
 /* Register a ThrottleGroupMember from the throttling group, also initializing
@@ -543,7 +544,7 @@ void throttle_group_register_tgm(ThrottleGroupMember *tgm,
                                  const char *groupname,
                                  AioContext *ctx)
 {
-    int i;
+    ThrottleDirection dir;
     ThrottleState *ts = throttle_group_incref(groupname);
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
 
@@ -553,10 +554,11 @@ void throttle_group_register_tgm(ThrottleGroupMember *tgm,
 
     QEMU_LOCK_GUARD(&tg->lock);
     /* If the ThrottleGroup is new set this ThrottleGroupMember as the token */
-    for (i = 0; i < 2; i++) {
-        if (!tg->tokens[i]) {
-            tg->tokens[i] = tgm;
+    for (dir = THROTTLE_READ; dir < THROTTLE_MAX; dir++) {
+        if (!tg->tokens[dir]) {
+            tg->tokens[dir] = tgm;
         }
+        qemu_co_queue_init(&tgm->throttled_reqs[dir]);
     }
 
     QLIST_INSERT_HEAD(&tg->head, tgm, round_robin);
@@ -568,8 +570,6 @@ void throttle_group_register_tgm(ThrottleGroupMember *tgm,
                          write_timer_cb,
                          tgm);
     qemu_co_mutex_init(&tgm->throttled_reqs_lock);
-    qemu_co_queue_init(&tgm->throttled_reqs[0]);
-    qemu_co_queue_init(&tgm->throttled_reqs[1]);
 }
 
 /* Unregister a ThrottleGroupMember from its group, removing it from the list,
@@ -587,7 +587,7 @@ void throttle_group_unregister_tgm(ThrottleGroupMember *tgm)
     ThrottleState *ts = tgm->throttle_state;
     ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
     ThrottleGroupMember *token;
-    int i;
+    ThrottleDirection dir;
 
     if (!ts) {
         /* Discard already unregistered tgm */
@@ -598,17 +598,17 @@ void throttle_group_unregister_tgm(ThrottleGroupMember *tgm)
     AIO_WAIT_WHILE(tgm->aio_context, qatomic_read(&tgm->restart_pending) > 0);
 
     WITH_QEMU_LOCK_GUARD(&tg->lock) {
-        for (i = 0; i < 2; i++) {
-            assert(tgm->pending_reqs[i] == 0);
-            assert(qemu_co_queue_empty(&tgm->throttled_reqs[i]));
-            assert(!timer_pending(tgm->throttle_timers.timers[i]));
-            if (tg->tokens[i] == tgm) {
+        for (dir = THROTTLE_READ; dir < THROTTLE_MAX; dir++) {
+            assert(tgm->pending_reqs[dir] == 0);
+            assert(qemu_co_queue_empty(&tgm->throttled_reqs[dir]));
+            assert(!timer_pending(tgm->throttle_timers.timers[dir]));
+            if (tg->tokens[dir] == tgm) {
                 token = throttle_group_next_tgm(tgm);
                 /* Take care of the case where this is the last tgm in the group */
                 if (token == tgm) {
                     token = NULL;
                 }
-                tg->tokens[i] = token;
+                tg->tokens[dir] = token;
             }
         }
 
@@ -633,19 +633,20 @@ void throttle_group_detach_aio_context(ThrottleGroupMember *tgm)
 {
     ThrottleGroup *tg = container_of(tgm->throttle_state, ThrottleGroup, ts);
     ThrottleTimers *tt = &tgm->throttle_timers;
-    int i;
+    ThrottleDirection dir;
 
     /* Requests must have been drained */
-    assert(tgm->pending_reqs[0] == 0 && tgm->pending_reqs[1] == 0);
-    assert(qemu_co_queue_empty(&tgm->throttled_reqs[0]));
-    assert(qemu_co_queue_empty(&tgm->throttled_reqs[1]));
+    for (dir = THROTTLE_READ; dir < THROTTLE_MAX; dir++) {
+        assert(tgm->pending_reqs[dir] == 0);
+        assert(qemu_co_queue_empty(&tgm->throttled_reqs[dir]));
+    }
 
     /* Kick off next ThrottleGroupMember, if necessary */
     WITH_QEMU_LOCK_GUARD(&tg->lock) {
-        for (i = 0; i < 2; i++) {
-            if (timer_pending(tt->timers[i])) {
-                tg->any_timer_armed[i] = false;
-                schedule_next_request(tgm, i);
+        for (dir = THROTTLE_READ; dir < THROTTLE_MAX; dir++) {
+            if (timer_pending(tt->timers[dir])) {
+                tg->any_timer_armed[dir] = false;
+                schedule_next_request(tgm, dir);
             }
         }
     }
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


