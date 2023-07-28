Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A8C766281
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 05:39:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPD5m-0007vg-VJ; Thu, 27 Jul 2023 22:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qPD5d-0007uf-CI
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 22:20:25 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qPD5b-0006y7-N7
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 22:20:25 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1b8ad356f03so10029435ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 19:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690510822; x=1691115622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6y39WsGI6ZaymBhC0tayr2DVImGPxd/56ERoZgkjVfM=;
 b=dKHX52/KdDVjUCR/V0MslzQvUF8/jl7FNTUo2jhmq0r3syWXDo0vvk8bFZfrJAtSdI
 W/+akKONT5OPPJWIEvv1v+vqdcMbA8AZ53tsn8Xyc0XxOrjr03hNNp+QgQBfgqCwkYyj
 pkvkvKdv8Z7I0dfJ1L2DXcbzYO6QtXclHRQIlOpccVzJM7DNgepq6YM/7CWB87HcGSzO
 0AkJ/LPU4plVw8FO6NNBjZASy1x7ZTES6hc2W37s3+aPaNXMbNq6wOBktBsTpegAQSG6
 oLCEslRMmToo7cWPr7+eui6YZpdtIPxF8mNbP+C86hYWGPkSig583a1U2p9rvwFiMofQ
 SeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690510822; x=1691115622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6y39WsGI6ZaymBhC0tayr2DVImGPxd/56ERoZgkjVfM=;
 b=QT958vKchBsD9l4wEpcWVUz/9MqcoHX48q6vOz7QXOq4TwPgdKoQKFqlDxvatT934p
 uEWkN3Yv8Lkhbu9H8TxJh+gMKeGLStNNvWR3uaLdEqNSZO0Wvsjad1gXuRjfdWY/ZJDF
 eGQuJ6xii9Fv4gLGa+ikGJOLvchIfQw7rlYeb9WbeZLiNXoTlptXAf+HAnyj6UUMQHT/
 8ji8pDxCi4CyinhPZsUaa0FSZvoFyIQx6nrFED6/7ZUBR9j8RQWlbNZAlE1jbER091Ta
 4yRKexNkG6xp/FpCXY+3dUBtNMdXALh7p3P/VuoB4zeq6DOojR/YgK//01lOnaZMtgz6
 uyVg==
X-Gm-Message-State: ABy/qLama8EvcxXs4glaC1eHacxjAVpL1efnPBFB4/ahyZTC6a5aik2P
 0pvJBH1KdhRTj1GSKa/ozIndRg==
X-Google-Smtp-Source: APBJJlFtsZom+Mx62/Un/xN3hg/6mUBhhHWC/+DT10L3GeN1mEL1OkFm3MxXTk+JvMKDHlKKa83R1w==
X-Received: by 2002:a17:903:18c:b0:1b9:e481:ef3f with SMTP id
 z12-20020a170903018c00b001b9e481ef3fmr317061plg.9.1690510821932; 
 Thu, 27 Jul 2023 19:20:21 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 b21-20020a170902d31500b001bb9f104328sm2312947plc.146.2023.07.27.19.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 19:20:21 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com,
	kwolf@redhat.com,
	hreitz@redhat.com
Cc: qemu_oss@crudebyte.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v5 3/9] throttle: support read-only and write-only
Date: Fri, 28 Jul 2023 10:20:00 +0800
Message-Id: <20230728022006.1098509-4-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728022006.1098509-1-pizhenwei@bytedance.com>
References: <20230728022006.1098509-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x62f.google.com
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


