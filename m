Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F061E73F596
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 09:26:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE34E-00082S-Om; Tue, 27 Jun 2023 03:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qE34C-00081s-F9
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:24:48 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qE34A-0005wN-RE
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:24:48 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-666e6541c98so4125264b3a.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 00:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1687850685; x=1690442685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kBqk0P8ZAq/bseWj2v63OA5vbf0dCu8gI6RyFAhm6VE=;
 b=dMZ5SczmifPG3Z/AE4OsdO3FfB+xzMeJl9psEySF6VSreSWYfIxKQZ6j9xbWx7ft5a
 gouiO+tPRu/RYI5PzrRdXrEdCFwPa+neN6uc2MNkUUsCGFFmGITo5mFgvF78HcfKtIuk
 bQx1rOnCqxBrfpcLypcUrPUkCtec0X2xUP8u88lXxnVe/mQnurcWJ27O12c6PDLN+FWC
 9TTeEdGzEcgAAcbecsV05AS5h7vMRRLI7VQCY8FCD+oP9LRc5qQpxfMuOvwouJbINYQN
 O8c46i2Ht2RVNPW/QvrG7Mcn6A55SVwrB+qTwhWlyZZ6Swx42fJHzaEYeerfwOcsiu1N
 iuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687850685; x=1690442685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kBqk0P8ZAq/bseWj2v63OA5vbf0dCu8gI6RyFAhm6VE=;
 b=a9FvdJ32bkz6NP411L70tAFxFSR4yhf53hDB1XvwlBG5YBJtaBVMxm5b96f+Lcc1ae
 nUdGGOj9C4RtS9MKZT1eWnsFtRWESpWne+TFBFtQb0s4FEvD8GiiTUKP2hJXV0E1IbHi
 Geqz6mwPwyEVi2wkxoQWSf2eFXfdGQ1FQqhe8/ChTnDtqe+duwGFFL6Jd+GpPfqm0MK7
 eq06yqMY9V/GAP5sja4ms1tR/cFsmUNXFE1MP842RiD8aptOiQ2JqryLT4Q+1T/6OzQZ
 JzZxxG9L9EMACB+ojb88aDIXnmrcndyPEJRyATGlbi5c8r8Lmr2zA1aUIt2dbsI/lDOF
 DqTw==
X-Gm-Message-State: AC+VfDwVd1qihHlwUVR+aI5U/QOtVXWxz2gsp9d/LNYLWVyNc5Up8tBc
 lZCZF3YkBU83RWDLpU4As3lwbA==
X-Google-Smtp-Source: ACHHUZ4N2Vj4H1uP9sXnc6Sg3hh6r+xim33RXrLEi2g9ASnuAdy6y6/XHMGf934+y5U1BoItzDLcYA==
X-Received: by 2002:a05:6a00:b8c:b0:673:aca1:a0b0 with SMTP id
 g12-20020a056a000b8c00b00673aca1a0b0mr9137935pfj.3.1687850685437; 
 Tue, 27 Jun 2023 00:24:45 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 u22-20020aa78496000000b00640f1e4a811sm3210915pfn.22.2023.06.27.00.24.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 00:24:44 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 3/5] throttle: support read-only and write-only
Date: Tue, 27 Jun 2023 15:24:29 +0800
Message-Id: <20230627072431.449171-4-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230627072431.449171-1-pizhenwei@bytedance.com>
References: <20230627072431.449171-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pf1-x430.google.com
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


