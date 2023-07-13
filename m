Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F8B7518F9
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 08:42:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJq1I-0004em-5x; Thu, 13 Jul 2023 02:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qJq1F-0004da-IX
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 02:41:41 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qJq1D-0007q6-UN
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 02:41:41 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1b9cd6a0051so1797325ad.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 23:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1689230498; x=1691822498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jaWAmvEQQZcMF23gcTLnet2HrHi+tP++yrg1bE9ujnc=;
 b=UWakUxXuVNFrM1q1TMfK76nlA25n4YK4HA76yXHCCVHiup8RGQnDXcqfC+GxEW6LBb
 ssDBm/VMxemqh6upZCr/TNPZr36TaVnuH+CX8HwzqhkLXjBE3ukBRGgJ22Man+OyIs2x
 Im0BBrC/Pxatms7TRQiFf4PwPoyvh+byXNUr6KsxRTlFV2Jl86G0c4PCgeWfu4m5CFEC
 TkNuj2McZohZ7aNvwvVzo8oJtQLRAhIW00zjh69xsaLlRsuVi4g3v1VQlMLQPwIQZH8S
 LajjIG4FPiZoESPaiUcA3XCuvwi8vLP99zF87tkD23zgj/lo80dEBdv2Zh424JmU4O5I
 e9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689230498; x=1691822498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jaWAmvEQQZcMF23gcTLnet2HrHi+tP++yrg1bE9ujnc=;
 b=OPLuuaf6n+YSJgvMSWqptEdZ/lgn01Y74y0YNl9i1C9Sn51O8qzijBVDPCVeCvBGJ6
 8JbA/pbLT6X6eDWlX2UYGbavac5gbrjTtZRWEj/vzPrnqHUf4Pl1ruJUkci/63Ji0Aba
 VRarm5kmOrMuo2Vk5/m1RNYdV4vGlAWnWCmGVmcjeszQyndoqAc4fY+c15SD+KQ94N/k
 PqV/YEbFeD4PIBardMvRhztuOUVia/5okKa0QEOSjnVeuvpwpIY61JDwPdS39UBHGZgl
 CJh2/RVkRoerygwxBSjGUaEI3oQ5JEbze2q3ouq61OOpfUZPHG0Dx0SC4nXaylSOmdL5
 i0iA==
X-Gm-Message-State: ABy/qLZvMuvwvY6c5Rx7Vb0TO1CoI6v9ep1USvjNKa6mjpXcV70HR2KT
 +hx7TaV6YAiMEgbZ7/yOBEmJbA==
X-Google-Smtp-Source: APBJJlETg8IjpPehpeqozZeAhZ8TY9fYheTUHpZw5g9jeKULSzjkNUNr2AWDeiars7HXFZ8kW1qQ2w==
X-Received: by 2002:a17:902:bd94:b0:1b8:1e05:ed09 with SMTP id
 q20-20020a170902bd9400b001b81e05ed09mr350496pls.36.1689230498560; 
 Wed, 12 Jul 2023 23:41:38 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a170902680d00b001ac2be26340sm5144966plk.222.2023.07.12.23.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 23:41:38 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com, kwolf@redhat.com, groug@kaod.org, qemu_oss@crudebyte.com,
 hreitz@redhat.com
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v3 3/6] throttle: support read-only and write-only
Date: Thu, 13 Jul 2023 14:41:08 +0800
Message-Id: <20230713064111.558652-4-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713064111.558652-1-pizhenwei@bytedance.com>
References: <20230713064111.558652-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x631.google.com
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
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 util/throttle.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/util/throttle.c b/util/throttle.c
index 5642e61763..c0bd0c26c3 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -199,12 +199,17 @@ static bool throttle_compute_timer(ThrottleState *ts,
 void throttle_timers_attach_aio_context(ThrottleTimers *tt,
                                         AioContext *new_context)
 {
-    tt->timers[THROTTLE_READ] =
-        aio_timer_new(new_context, tt->clock_type, SCALE_NS,
-                      tt->timer_cb[THROTTLE_READ], tt->timer_opaque);
-    tt->timers[THROTTLE_WRITE] =
-        aio_timer_new(new_context, tt->clock_type, SCALE_NS,
-                      tt->timer_cb[THROTTLE_WRITE], tt->timer_opaque);
+    if (tt->timer_cb[THROTTLE_READ]) {
+        tt->timers[THROTTLE_READ] =
+            aio_timer_new(new_context, tt->clock_type, SCALE_NS,
+                          tt->timer_cb[THROTTLE_READ], tt->timer_opaque);
+    }
+
+    if (tt->timer_cb[THROTTLE_WRITE]) {
+        tt->timers[THROTTLE_WRITE] =
+            aio_timer_new(new_context, tt->clock_type, SCALE_NS,
+                          tt->timer_cb[THROTTLE_WRITE], tt->timer_opaque);
+    }
 }
 
 /*
@@ -235,6 +240,7 @@ void throttle_timers_init(ThrottleTimers *tt,
                           QEMUTimerCB *write_timer_cb,
                           void *timer_opaque)
 {
+    assert(read_timer_cb || write_timer_cb);
     memset(tt, 0, sizeof(ThrottleTimers));
 
     tt->clock_type = clock_type;
@@ -247,7 +253,9 @@ void throttle_timers_init(ThrottleTimers *tt,
 /* destroy a timer */
 static void throttle_timer_destroy(QEMUTimer **timer)
 {
-    assert(*timer != NULL);
+    if (*timer == NULL) {
+        return;
+    }
 
     timer_free(*timer);
     *timer = NULL;
@@ -272,7 +280,7 @@ void throttle_timers_destroy(ThrottleTimers *tt)
 /* is any throttling timer configured */
 bool throttle_timers_are_initialized(ThrottleTimers *tt)
 {
-    if (tt->timers[0]) {
+    if (tt->timers[THROTTLE_READ] || tt->timers[THROTTLE_WRITE]) {
         return true;
     }
 
@@ -424,8 +432,12 @@ bool throttle_schedule_timer(ThrottleState *ts,
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
@@ -437,12 +449,12 @@ bool throttle_schedule_timer(ThrottleState *ts,
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


