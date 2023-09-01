Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E84B78F9CE
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 10:18:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbzMF-0006zd-O4; Fri, 01 Sep 2023 04:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qbzMD-0006yU-8K
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 04:18:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qbzMA-00014Q-W1
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 04:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693556298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ImCY/zE0R5uCUSulpw7t0PCwQ8u6pO13dzCZDBfU+fk=;
 b=DmPUNfO9g/ubsevIrVgngf3pnJuEy2KPbMTt4J256w1HKKVxxItt6oXHlnmdCQZTDiDJiw
 tsokhcQSPIY6394wgXJt9riBmLwBxEUZbObg2a2XCQhTfgURxm4LHcBh6IJmbI6we7WvrU
 gCmOuRXWaJBe4RGDuQSdDCMBnwnpaBw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-684-K6lSJNhVPfSbqmFY7iguwA-1; Fri, 01 Sep 2023 04:18:15 -0400
X-MC-Unique: K6lSJNhVPfSbqmFY7iguwA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C7DF858EED;
 Fri,  1 Sep 2023 08:18:15 +0000 (UTC)
Received: from localhost (unknown [10.39.194.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C1C21492C13;
 Fri,  1 Sep 2023 08:18:14 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
	Hanna Czenczek <hreitz@redhat.com>
Subject: [PULL 03/14] throttle: support read-only and write-only
Date: Fri,  1 Sep 2023 10:17:58 +0200
Message-ID: <20230901081804.31377-4-hreitz@redhat.com>
In-Reply-To: <20230901081804.31377-1-hreitz@redhat.com>
References: <20230901081804.31377-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: zhenwei pi <pizhenwei@bytedance.com>

Only one direction is necessary in several scenarios:
- a read-only disk
- operations on a device are considered as *write* only. For example,
  encrypt/decrypt/sign/verify operations on a cryptodev use a single
  *write* timer(read timer callback is defined, but never invoked).

Allow a single direction in throttle, this reduces memory, and uplayer
does not need a dummy callback any more.

Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Message-Id: <20230728022006.1098509-4-pizhenwei@bytedance.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 util/throttle.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/util/throttle.c b/util/throttle.c
index 5642e61763..0439028d21 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -199,12 +199,15 @@ static bool throttle_compute_timer(ThrottleState *ts,
 void throttle_timers_attach_aio_context(ThrottleTimers *tt,
                                         AioContext *new_context)
 {
-    tt->timers[THROTTLE_READ] =
-        aio_timer_new(new_context, tt->clock_type, SCALE_NS,
-                      tt->timer_cb[THROTTLE_READ], tt->timer_opaque);
-    tt->timers[THROTTLE_WRITE] =
-        aio_timer_new(new_context, tt->clock_type, SCALE_NS,
-                      tt->timer_cb[THROTTLE_WRITE], tt->timer_opaque);
+    ThrottleDirection dir;
+
+    for (dir = THROTTLE_READ; dir < THROTTLE_MAX; dir++) {
+        if (tt->timer_cb[dir]) {
+            tt->timers[dir] =
+                aio_timer_new(new_context, tt->clock_type, SCALE_NS,
+                              tt->timer_cb[dir], tt->timer_opaque);
+        }
+    }
 }
 
 /*
@@ -235,6 +238,7 @@ void throttle_timers_init(ThrottleTimers *tt,
                           QEMUTimerCB *write_timer_cb,
                           void *timer_opaque)
 {
+    assert(read_timer_cb || write_timer_cb);
     memset(tt, 0, sizeof(ThrottleTimers));
 
     tt->clock_type = clock_type;
@@ -247,7 +251,9 @@ void throttle_timers_init(ThrottleTimers *tt,
 /* destroy a timer */
 static void throttle_timer_destroy(QEMUTimer **timer)
 {
-    assert(*timer != NULL);
+    if (*timer == NULL) {
+        return;
+    }
 
     timer_free(*timer);
     *timer = NULL;
@@ -256,10 +262,10 @@ static void throttle_timer_destroy(QEMUTimer **timer)
 /* Remove timers from event loop */
 void throttle_timers_detach_aio_context(ThrottleTimers *tt)
 {
-    int i;
+    ThrottleDirection dir;
 
-    for (i = 0; i < THROTTLE_MAX; i++) {
-        throttle_timer_destroy(&tt->timers[i]);
+    for (dir = THROTTLE_READ; dir < THROTTLE_MAX; dir++) {
+        throttle_timer_destroy(&tt->timers[dir]);
     }
 }
 
@@ -272,8 +278,12 @@ void throttle_timers_destroy(ThrottleTimers *tt)
 /* is any throttling timer configured */
 bool throttle_timers_are_initialized(ThrottleTimers *tt)
 {
-    if (tt->timers[0]) {
-        return true;
+    ThrottleDirection dir;
+
+    for (dir = THROTTLE_READ; dir < THROTTLE_MAX; dir++) {
+        if (tt->timers[dir]) {
+            return true;
+        }
     }
 
     return false;
@@ -424,8 +434,12 @@ bool throttle_schedule_timer(ThrottleState *ts,
 {
     int64_t now = qemu_clock_get_ns(tt->clock_type);
     int64_t next_timestamp;
+    QEMUTimer *timer;
     bool must_wait;
 
+    timer = is_write ? tt->timers[THROTTLE_WRITE] : tt->timers[THROTTLE_READ];
+    assert(timer);
+
     must_wait = throttle_compute_timer(ts,
                                        is_write,
                                        now,
@@ -437,12 +451,12 @@ bool throttle_schedule_timer(ThrottleState *ts,
     }
 
     /* request throttled and timer pending -> do nothing */
-    if (timer_pending(tt->timers[is_write])) {
+    if (timer_pending(timer)) {
         return true;
     }
 
     /* request throttled and timer not pending -> arm timer */
-    timer_mod(tt->timers[is_write], next_timestamp);
+    timer_mod(timer, next_timestamp);
     return true;
 }
 
-- 
2.41.0


