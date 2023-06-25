Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FBA73CF93
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 10:58:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDLY8-0003Jg-00; Sun, 25 Jun 2023 04:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qDLY4-0003J6-RZ
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 04:56:44 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qDLY0-0006nP-Or
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 04:56:42 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1b7f223994fso5916305ad.3
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 01:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1687683399; x=1690275399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NHwZXAIUjz71eo/wFLaIVEbGhwCrrzSAD1wFSJ5bs3c=;
 b=GzHtAzC1d9EOjRv4s9DZy/8xrOST4W83P6TiBfX8c08/qP5vugJ5yqfBukon/fv85C
 tQdWHGTa0NfwuqqDrdAm9uvsT0Mr0n8XeFaz2zYAcRdmq/lS5SePgnQ5erC/85Pm2Vu+
 dvP6p0g33Tgbk7reiHLbTtpKOaAy8gRL/eKEfj24vTk7nd2IgJML9rhOQVv4HJmgVekp
 ReThB6yhycg4RIZ47GFg9eA19M0hLM7R9gYrBj4L+6V5oWr7G6wFgTTASHrXU/Ah9uiA
 VammEmc9dLk/0a0oG4G44nNcrBjC6EzJqKlisk1XYjWYQ+6rIGP2/nvMmr+/iRtGXfew
 Zwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687683399; x=1690275399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NHwZXAIUjz71eo/wFLaIVEbGhwCrrzSAD1wFSJ5bs3c=;
 b=DaNzzGJaCD3SmlCN5w44e06Ka5DcrDXLOrbETGMigyptWvfCiRfMAMjGF8mzAz6sCa
 GQR++5xsr1dOfrk3b6n7GXcxpYu2YuiUrdc+xZfQWrezaa8g2DKNd6kW3Y2corXTbIfM
 fiITu5tAtjf8qqZYOsfb0TN7a25HXKUTC9WBZMdJ90PMNdPMuixWrEeBSLKhpM/YT5Ob
 T8oEI5YD7G1SoQCbN8CZ7o/3xeTR94mFjc6npUVGJ4fzW2k+J8WvHgqp2LvKyWYluTpQ
 ZMKEKJGeNyIYgM45P9dSGykBIwzXVzuG5on2bR1fI5bdCQJr3/zV4ORaIgMeSMT0tnyl
 jtDg==
X-Gm-Message-State: AC+VfDwVsm5+TXNKaBcbnyIlc/Yuez+c1MD9KK/f8d8Z24vR8LMu6b/f
 4+zJb6PPpYk4rrU3lbhiotb0VCU6LfQNOZTyN60=
X-Google-Smtp-Source: ACHHUZ4sTnggcVuAEPZPjGQA1wim6TgOBbs9AJ4B6BiqmSEYcnKPE041w+WcMVr4ZYqKTk6ioAaSQg==
X-Received: by 2002:a17:902:728d:b0:1b0:3a03:50d0 with SMTP id
 d13-20020a170902728d00b001b03a0350d0mr4177939pll.26.1687683399476; 
 Sun, 25 Jun 2023 01:56:39 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 w9-20020a170902e88900b001b1f991a4d0sm2176308plg.108.2023.06.25.01.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 01:56:39 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 1/5] throttle: introduce enum ThrottleTimerType
Date: Sun, 25 Jun 2023 16:56:27 +0800
Message-Id: <20230625085631.372238-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625085631.372238-1-pizhenwei@bytedance.com>
References: <20230625085631.372238-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x635.google.com
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

Use enum ThrottleTimerType instead of number index.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/qemu/throttle.h | 12 +++++++++---
 util/throttle.c         | 16 +++++++++-------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
index 05f6346137..0956094115 100644
--- a/include/qemu/throttle.h
+++ b/include/qemu/throttle.h
@@ -99,13 +99,19 @@ typedef struct ThrottleState {
     int64_t previous_leak;    /* timestamp of the last leak done */
 } ThrottleState;
 
+typedef enum {
+    THROTTLE_TIMER_READ = 0,
+    THROTTLE_TIMER_WRITE,
+    THROTTLE_TIMER_MAX
+} ThrottleTimerType;
+
 typedef struct ThrottleTimers {
-    QEMUTimer *timers[2];     /* timers used to do the throttling */
+    /* timers used to do the throttling */
+    QEMUTimer *timers[THROTTLE_TIMER_MAX];
     QEMUClockType clock_type; /* the clock used */
 
     /* Callbacks */
-    QEMUTimerCB *read_timer_cb;
-    QEMUTimerCB *write_timer_cb;
+    QEMUTimerCB *timer_cb[THROTTLE_TIMER_MAX];
     void *timer_opaque;
 } ThrottleTimers;
 
diff --git a/util/throttle.c b/util/throttle.c
index 81f247a8d1..c1cc24831c 100644
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
+    tt->timers[THROTTLE_TIMER_READ] =
+        aio_timer_new(new_context, tt->clock_type, SCALE_NS,
+                      tt->timer_cb[THROTTLE_TIMER_READ], tt->timer_opaque);
+    tt->timers[THROTTLE_TIMER_WRITE] =
+        aio_timer_new(new_context, tt->clock_type, SCALE_NS,
+                      tt->timer_cb[THROTTLE_TIMER_WRITE], tt->timer_opaque);
 }
 
 /*
@@ -236,8 +238,8 @@ void throttle_timers_init(ThrottleTimers *tt,
     memset(tt, 0, sizeof(ThrottleTimers));
 
     tt->clock_type = clock_type;
-    tt->read_timer_cb = read_timer_cb;
-    tt->write_timer_cb = write_timer_cb;
+    tt->timer_cb[THROTTLE_TIMER_READ] = read_timer_cb;
+    tt->timer_cb[THROTTLE_TIMER_WRITE] = write_timer_cb;
     tt->timer_opaque = timer_opaque;
     throttle_timers_attach_aio_context(tt, aio_context);
 }
@@ -256,7 +258,7 @@ void throttle_timers_detach_aio_context(ThrottleTimers *tt)
 {
     int i;
 
-    for (i = 0; i < 2; i++) {
+    for (i = 0; i < THROTTLE_TIMER_MAX; i++) {
         throttle_timer_destroy(&tt->timers[i]);
     }
 }
-- 
2.34.1


