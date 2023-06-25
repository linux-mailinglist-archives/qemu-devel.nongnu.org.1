Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F5C73CF92
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 10:58:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDLYB-0003La-Gy; Sun, 25 Jun 2023 04:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qDLY8-0003KT-I5
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 04:56:48 -0400
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qDLY6-0006ob-FV
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 04:56:47 -0400
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6b5ef64bca6so2293416a34.3
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 01:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1687683405; x=1690275405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KO+x2/TwqQvfw3CG6HNni2tR6UujcphSYLJP5Y5HOWA=;
 b=OWW2mjZ8KYtt1P2gV/hssgcHBZOZuPbzWzpm3TpohlKSWUTMZqHM93a0ivp80A7rsc
 4Z7lr1emRy+2HNELEIa+11+lFkOgomKh+xKeXNwpq2OR3XdJtJdIIK6sLTut7a70Qov8
 jQStAzXEfN//Q1U3xOvd+cZKwr4L4H9kL2Xgr0ET6b6MqTeiSVCbvsp9Pv9JRTzAq10I
 MI+lIL1fX6GqNsdAKEWUo6VawkNJg9EdGA+Zn32zigpxL5fafcKnKcgM/dMxVpCOiPcg
 unj3UQfBJf+fDnLc46FoT43Ok3Vfw3It+ZeRHzOz/3DNGqDqYOlaeJSiuo6bhh+0a3Qi
 fFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687683405; x=1690275405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KO+x2/TwqQvfw3CG6HNni2tR6UujcphSYLJP5Y5HOWA=;
 b=BtUDy4UDaMO5knJAK5qB1EehBjQyckzuApafG687D5lLWSfRsX96Zc+fIHVo9xKjGK
 YxU7K5GGGjLanqUPiX/yimsAovsBhbHpAbwvTWJJ9Q5uR9zlWGl/JWa+KL7/qX4rch3g
 7+MefhxJF6ueeCeqnLt34l7NwFF3v8bJIh7y30SI+NJIfJBpoffc2Ym9JoWcEeo0FKIU
 ZjlRnli8xRnSGM9w2IStu0xOvtY+26wE5kEBKPq8UtZYUmQXu5g/UWkFRjnx5EPclsnB
 H9qM65TzsUSqem7v5M0MUdO7mPj0riDR25JQnEw4qApeftDextKi/ukSkeuxjwpepi+G
 CpAA==
X-Gm-Message-State: AC+VfDzFjMiiCIY3pCfXN0MDNiLqI08pAQLPjDnODM83MLh9urIOuRWK
 1LqKP79qV+9Q8h76ANikA5WMLg==
X-Google-Smtp-Source: ACHHUZ49Vhdbl/YL2hiP6TA4O0r2IfcqxjK1IM5Ir9g/JwarPoqrabXKlkL/m2itimrhCZW2H2VuxA==
X-Received: by 2002:a9d:7f0f:0:b0:6b6:8212:190c with SMTP id
 j15-20020a9d7f0f000000b006b68212190cmr10073301otq.1.1687683404948; 
 Sun, 25 Jun 2023 01:56:44 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 w9-20020a170902e88900b001b1f991a4d0sm2176308plg.108.2023.06.25.01.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 01:56:44 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 3/5] throttle: support read-only and write-only
Date: Sun, 25 Jun 2023 16:56:29 +0800
Message-Id: <20230625085631.372238-4-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625085631.372238-1-pizhenwei@bytedance.com>
References: <20230625085631.372238-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=pizhenwei@bytedance.com; helo=mail-ot1-x334.google.com
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

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 util/throttle.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/util/throttle.c b/util/throttle.c
index c1cc24831c..01faee783c 100644
--- a/util/throttle.c
+++ b/util/throttle.c
@@ -199,12 +199,17 @@ static bool throttle_compute_timer(ThrottleState *ts,
 void throttle_timers_attach_aio_context(ThrottleTimers *tt,
                                         AioContext *new_context)
 {
-    tt->timers[THROTTLE_TIMER_READ] =
-        aio_timer_new(new_context, tt->clock_type, SCALE_NS,
-                      tt->timer_cb[THROTTLE_TIMER_READ], tt->timer_opaque);
-    tt->timers[THROTTLE_TIMER_WRITE] =
-        aio_timer_new(new_context, tt->clock_type, SCALE_NS,
-                      tt->timer_cb[THROTTLE_TIMER_WRITE], tt->timer_opaque);
+    if (tt->timer_cb[THROTTLE_TIMER_READ]) {
+        tt->timers[THROTTLE_TIMER_READ] =
+            aio_timer_new(new_context, tt->clock_type, SCALE_NS,
+                          tt->timer_cb[THROTTLE_TIMER_READ], tt->timer_opaque);
+    }
+
+    if (tt->timer_cb[THROTTLE_TIMER_WRITE]) {
+        tt->timers[THROTTLE_TIMER_WRITE] =
+            aio_timer_new(new_context, tt->clock_type, SCALE_NS,
+                          tt->timer_cb[THROTTLE_TIMER_WRITE], tt->timer_opaque);
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
+    if (tt->timers[THROTTLE_TIMER_READ] || tt->timers[THROTTLE_TIMER_WRITE]) {
         return true;
     }
 
-- 
2.34.1


