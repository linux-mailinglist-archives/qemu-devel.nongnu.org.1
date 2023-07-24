Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D22475F242
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 12:11:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNsWF-0007nj-AR; Mon, 24 Jul 2023 06:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qNsVx-0007hl-Aq
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:10:05 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qNsVu-0000Yt-U4
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:10:05 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6686ef86110so2212874b3a.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 03:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690193397; x=1690798197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6y39WsGI6ZaymBhC0tayr2DVImGPxd/56ERoZgkjVfM=;
 b=Fqs2hvnwuP6PRjyoFYbTqejwA3fyTXgXwkp7qPoiUgbN/iOlgk07+6RHxdJwKczmqe
 yxVDzqS9z5SYyE/Q9fS6gtM1hTxK/3sBdDzc+Qo4WPRQM3leyLVAiB3PyLPGuEXizZ30
 /RJaiqZuEtLOCBLH6PC1E69PiG0PhjS0Mnf8COjrM/ibm3KadoDeZu/skh1EE1qWaS2/
 CbqXXMnJplYeBt8u9JGJ43o4gTxNmLzO6ij/103LRIUafG4McW7ZYEIYPTIdRFCsBv/Y
 DV5TI8epw+DjpsMr1k8KnQsYdDB+vyfaHp1uY35dyPBGzDfGmLSl9uh9VzP9hy5IL2Mk
 mpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690193397; x=1690798197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6y39WsGI6ZaymBhC0tayr2DVImGPxd/56ERoZgkjVfM=;
 b=QISJkIhyWV1muPDjCYpBA7WeX86PrHwRVd6gxOt+T6EOKXGAqm51MtPzCP1NeQg5/z
 aFXQhFOe+deJBJ41VH1/o5kwe8Hv6XP2pvk4Fx8LPrhEGgSqDHOtMxMDSwndhuBnxLd9
 qe66RCac+T7yCfG5bC5RU6HbnIUL8BZXOTb7feBPniOqRkNMgsa5UUukM3uwHABQ100+
 hPU6oOqWx3BdvYsr7xjrzzhE7h468bp99+P85/SSOLV5z1v+5pbHZ8HDSWiMhERMwVs7
 HFl2iWBmefj3AlkRkEwFePud254a4WaCXG0vRYZ7Y4GHMIcdwSxe4I1pFVEUoo05ax+n
 DMyg==
X-Gm-Message-State: ABy/qLaTAZ03XxU0L9p5RNbj6+Tq4cQ4YzKwmZGLOBZKpUMpVSuseBva
 ZQBlM66Z66G6gQGNzq3uwlYdug==
X-Google-Smtp-Source: APBJJlGmcInRLpSEc4uFLn0OSWHE/uUQOLMmjcsUCX7sB0zn1d78pemg7ujnJOU6Kvk6O92qdmxhPA==
X-Received: by 2002:a05:6a20:7f93:b0:133:8229:196e with SMTP id
 d19-20020a056a207f9300b001338229196emr9695590pzj.35.1690193397260; 
 Mon, 24 Jul 2023 03:09:57 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 je2-20020a170903264200b001bb9d6b1baasm2419124plb.198.2023.07.24.03.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 03:09:56 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com, kwolf@redhat.com, groug@kaod.org, qemu_oss@crudebyte.com,
 hreitz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, berrange@redhat.com,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v4 3/9] throttle: support read-only and write-only
Date: Mon, 24 Jul 2023 18:09:33 +0800
Message-Id: <20230724100939.1022984-4-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724100939.1022984-1-pizhenwei@bytedance.com>
References: <20230724100939.1022984-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pf1-x433.google.com
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
2.34.1


