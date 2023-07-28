Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF9F76626B
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 05:29:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPD5d-0007tr-Lu; Thu, 27 Jul 2023 22:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qPD5a-0007su-It
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 22:20:22 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qPD5Y-0006u1-Ne
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 22:20:22 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bba2318546so13323815ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 19:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690510816; x=1691115616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mq2kY4BOOQ8xYk3QtPY1kkHoxXQ+5tDDw4bi3Y5yR8Q=;
 b=MU+3C2/mKJj+HSXsyJcSKa3ZeZ3U+3FvFiGVh5VJlIsB9Y/b2d47wlW5GITa+gTrlx
 +qyEBwra7SJmQ2Q8/c0y4JmXK7FbQCVULmluGfrwwjNm3VizHO8Mn1isL/iMvOf17avw
 RN72ap2VPzrYxKHuG1PSSk56xdYAGaIZaCdBOCZyRuwOqyRFU1V+S14NiwgUdulnFVD/
 s87uclcXjbD97snU/GboJJUgMMvyJdrtXmLks+m/aJ5f2/Brphw+qNjIsm3kwhGyz+9+
 nOd6JUIrw2n6NL+70OYjnIMnPIbKnIJaeDSvXqrWpa6SRcjGIaLKJXE3Ek4ncV/A3ALQ
 Lw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690510816; x=1691115616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mq2kY4BOOQ8xYk3QtPY1kkHoxXQ+5tDDw4bi3Y5yR8Q=;
 b=MqLZ3uGhgDgxHj7d+XsZcORDEzmecLQtjVS9sXycVI7yClyDZjQD3sqwpbFqtio6TG
 nyKlDIt0e1Y4O8vYb+RYhVtlnWrIgPlQYeaNeYAP5hl6+f5CeAaljgwJQAbrWlEI5Xze
 r1UXk8l8OcAg9nMiwkT+N9eTqHYEAMEw4lgFK3fpQeErGjI+BxJvNvSaxr0txbTaZfjn
 y6yR92MurqIafOqrIUOkRFxXLWm0pwHCmWlbnlAdoMEk4FotpSh4BGShH+hbiWcjG6oA
 vd4IJlMxFJDJA8I723WraLUlWjwOn2jLgp3se0xCUdjazeLjDFkRhSMs/VDoElobIVPW
 /yww==
X-Gm-Message-State: ABy/qLZZtDZPzSCQfYwlxYkzOe0SgFGvdPeH91HNLR8ooOLvzmx0Sp+i
 VJC582dpsbLnXVBn3zN4Gf+2cA==
X-Google-Smtp-Source: APBJJlEmdkOyYJX1Hb1GYkIJhyHtll2BbB+dB0ZWWURkGwYX/YR1m1taIJeJ/GkWsGnD1O0pQUhfAA==
X-Received: by 2002:a17:902:8542:b0:1b7:ecbb:aa06 with SMTP id
 d2-20020a170902854200b001b7ecbbaa06mr385124plo.55.1690510815953; 
 Thu, 27 Jul 2023 19:20:15 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 b21-20020a170902d31500b001bb9f104328sm2312947plc.146.2023.07.27.19.20.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 19:20:15 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com,
	kwolf@redhat.com,
	hreitz@redhat.com
Cc: qemu_oss@crudebyte.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v5 1/9] throttle: introduce enum ThrottleDirection
Date: Fri, 28 Jul 2023 10:19:58 +0800
Message-Id: <20230728022006.1098509-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728022006.1098509-1-pizhenwei@bytedance.com>
References: <20230728022006.1098509-1-pizhenwei@bytedance.com>
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

Use enum ThrottleDirection instead of number index.

Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/qemu/throttle.h | 11 ++++++++---
 util/throttle.c         | 16 +++++++++-------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
index 05f6346137..9ca5ab8197 100644
--- a/include/qemu/throttle.h
+++ b/include/qemu/throttle.h
@@ -99,13 +99,18 @@ typedef struct ThrottleState {
     int64_t previous_leak;    /* timestamp of the last leak done */
 } ThrottleState;
 
+typedef enum {
+    THROTTLE_READ = 0,
+    THROTTLE_WRITE,
+    THROTTLE_MAX
+} ThrottleDirection;
+
 typedef struct ThrottleTimers {
-    QEMUTimer *timers[2];     /* timers used to do the throttling */
+    QEMUTimer *timers[THROTTLE_MAX];    /* timers used to do the throttling */
     QEMUClockType clock_type; /* the clock used */
 
     /* Callbacks */
-    QEMUTimerCB *read_timer_cb;
-    QEMUTimerCB *write_timer_cb;
+    QEMUTimerCB *timer_cb[THROTTLE_MAX];
     void *timer_opaque;
 } ThrottleTimers;
 
diff --git a/util/throttle.c b/util/throttle.c
index 81f247a8d1..5642e61763 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -199,10 +199,12 @@ static bool throttle_compute_timer(ThrottleState *ts,
 void throttle_timers_attach_aio_context(ThrottleTimers *tt,
                                         AioContext *new_context)
 {
-    tt->timers[0] = aio_timer_new(new_context, tt->clock_type, SCALE_NS,
-                                  tt->read_timer_cb, tt->timer_opaque);
-    tt->timers[1] = aio_timer_new(new_context, tt->clock_type, SCALE_NS,
-                                  tt->write_timer_cb, tt->timer_opaque);
+    tt->timers[THROTTLE_READ] =
+        aio_timer_new(new_context, tt->clock_type, SCALE_NS,
+                      tt->timer_cb[THROTTLE_READ], tt->timer_opaque);
+    tt->timers[THROTTLE_WRITE] =
+        aio_timer_new(new_context, tt->clock_type, SCALE_NS,
+                      tt->timer_cb[THROTTLE_WRITE], tt->timer_opaque);
 }
 
 /*
@@ -236,8 +238,8 @@ void throttle_timers_init(ThrottleTimers *tt,
     memset(tt, 0, sizeof(ThrottleTimers));
 
     tt->clock_type = clock_type;
-    tt->read_timer_cb = read_timer_cb;
-    tt->write_timer_cb = write_timer_cb;
+    tt->timer_cb[THROTTLE_READ] = read_timer_cb;
+    tt->timer_cb[THROTTLE_WRITE] = write_timer_cb;
     tt->timer_opaque = timer_opaque;
     throttle_timers_attach_aio_context(tt, aio_context);
 }
@@ -256,7 +258,7 @@ void throttle_timers_detach_aio_context(ThrottleTimers *tt)
 {
     int i;
 
-    for (i = 0; i < 2; i++) {
+    for (i = 0; i < THROTTLE_MAX; i++) {
         throttle_timer_destroy(&tt->timers[i]);
     }
 }
-- 
2.34.1


