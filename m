Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A6075F23F
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 12:11:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNsWB-0007lc-NP; Mon, 24 Jul 2023 06:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qNsW1-0007ir-MG
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:10:11 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qNsVl-0000Xu-F0
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 06:10:08 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bb775625e2so13587025ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 03:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1690193390; x=1690798190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mq2kY4BOOQ8xYk3QtPY1kkHoxXQ+5tDDw4bi3Y5yR8Q=;
 b=Ar3Su0aKRrEhtzRnZebXUFgIAXQTPpnLtXlPa9RBUjweTRERYBIUcNZ+re4t9lZ3Pj
 15Y6BPDL+oFu7hF/Kd4pVHEICvJBUYKa/p1HoT/rvIwPAI605ZagQnlgSKHm2A4n0enV
 d/mWO08b7R1WLg6l/+t+bL7Z/yZUKd8bhfAp5lM5rJph9xJDCEhVE10V+acXMXkvXI9S
 eywmYy7GOy+/JddUTpzjn/HurYwRLdBPE4PGwnGVX2XD3ms/65Iet9IvRK+ZVaPBjMWY
 /1Aj+OsnZXKGMPO2hKPg/yBAkwj2BdD7KNpI8zGCp0OqWuAO7WL/CBbQDnMpoizFBJN2
 81eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690193390; x=1690798190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mq2kY4BOOQ8xYk3QtPY1kkHoxXQ+5tDDw4bi3Y5yR8Q=;
 b=RbsKFDzZpsdq0iJr1VqPxoa9VvEr5M0JzUX/v9gtqg9kynosgoA2mtMMdXlVJKTnJm
 4yvkVPm+fZX0ymCVG42PhdC1n/vSvsfAqi/mZNviAmy5Jctujwb7iQQUnYRrXYsMlO2l
 h0kntG1lH03+5B8H/G5xixjcFAEEmNky4SNlWFNjG9uBtBb0NtXSV+axWb64S+/jsswN
 46hwhLvBpZP+7A7ow7eXbold0hDTxTnfkDxEkO8qGVfDFk+c8Qaz5o6U4m8AJNMDpQGF
 TsSnleTiOncwdiq/kovIbDaTKZXlBneypPbH7bpJWBGLorir7Xuj4bIEHGAYw4Yn3li6
 bl8Q==
X-Gm-Message-State: ABy/qLa7ggVYgMlh0s9P0YOJHZDmhrP2SG57I/wQoD6Y/ai1wNQ74WRY
 eI8iHNg8w2kIdofOFsedYS/wSw==
X-Google-Smtp-Source: APBJJlGtQjbtyEcrk5ObCtvBVaqka/oHEb620/0ZzSAT29SNAN/HkxktOMG9jOqBArAlrivHsumGVA==
X-Received: by 2002:a17:902:d502:b0:1b8:417d:d042 with SMTP id
 b2-20020a170902d50200b001b8417dd042mr12271818plg.20.1690193390265; 
 Mon, 24 Jul 2023 03:09:50 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 je2-20020a170903264200b001bb9d6b1baasm2419124plb.198.2023.07.24.03.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 03:09:49 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com, kwolf@redhat.com, groug@kaod.org, qemu_oss@crudebyte.com,
 hreitz@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, berrange@redhat.com,
 zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v4 1/9] throttle: introduce enum ThrottleDirection
Date: Mon, 24 Jul 2023 18:09:31 +0800
Message-Id: <20230724100939.1022984-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724100939.1022984-1-pizhenwei@bytedance.com>
References: <20230724100939.1022984-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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


