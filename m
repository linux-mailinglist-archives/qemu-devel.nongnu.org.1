Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F37873F594
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 09:26:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE34B-00080u-5L; Tue, 27 Jun 2023 03:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qE348-0007z7-Ek
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:24:44 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qE346-0005uI-Iw
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:24:44 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-666e3b15370so2540236b3a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 00:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1687850680; x=1690442680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=31NL63ixAGpk3LIat/cuu4mWxOeI4E9qGV2see5Ihc0=;
 b=idjFbBvXwKV7P6RPlI168so8sDZLzjGiIJQVCwDCMs7HZdB3zGeQa3OI8//8A6aAvj
 teqnhcbmoNiUafp28Ju26qIOYpcefUPoyin2SD7oVfWUs8DAWayZa4Y8jmMfDZSs0ECm
 yXCkdwNX+AP5nYzTyl+QODZmvb6yORbin2cqyug7N2wBfDdbD2CLDIGxdUXBiZi2VL4/
 O6RIq4tqQS1DY10HtVMxlUKK1Qel4vCFTPZIUE+CQbet8168d7PZTEGU2oS4Y4IvroS8
 PQ+ThzvBLKdT83hwbD9HAh/2oiuP+acHHA69WBe/9pddvhCTWKYCuEW3USAmE3jGfSM0
 XVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687850680; x=1690442680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=31NL63ixAGpk3LIat/cuu4mWxOeI4E9qGV2see5Ihc0=;
 b=FpGSHOArQ/lVrtypZaSUCg8IiNyNWkM0eTA8bVK0sSmXk23/HYuc6pt9epmWY+i0Z9
 BOHdnh8keBHSh0hVJwXH99H6VRjuFrsbLb6OX2fdvnG9SX9zn/yJdPiSVnY2Ec9A9qZW
 vIZSBaPRNyq8pF5zvYoJz0NjxBaYcTVaxxmMmjH3BcvJOwMuCjnbyhdsz8pH4hiRFqWb
 +r3XJ1CYDAskDnIFdcvCHqJu+Uu2Wh+EzJrpnT+1CgGpmUpEvtnl2N1yEkhcv5Dzhh88
 c5kwVdK5Eer6Mcyx/mpeC8FArjRIkPBs6ppbb0TRscYEv3NO2P8GSn61I0dbE98Pzmz5
 l80g==
X-Gm-Message-State: AC+VfDwCXlM788wvDszVFcdo9HIFVcojM3eN8x/kTygaytVo6dVApHFA
 8WDpJSSehEF3yN1qZ4LiR10Zmg==
X-Google-Smtp-Source: ACHHUZ73oV2d4QF9GQvVihiONVEGWuZJGAQbCcbiw0ot78pW1+uN7aAkL+PyTj9rcZhrwh2z/qXNSA==
X-Received: by 2002:a05:6a00:1946:b0:658:cbf1:d05a with SMTP id
 s6-20020a056a00194600b00658cbf1d05amr29579960pfk.3.1687850679770; 
 Tue, 27 Jun 2023 00:24:39 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 u22-20020aa78496000000b00640f1e4a811sm3210915pfn.22.2023.06.27.00.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 00:24:39 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v2 1/5] throttle: introduce enum ThrottleType
Date: Tue, 27 Jun 2023 15:24:27 +0800
Message-Id: <20230627072431.449171-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230627072431.449171-1-pizhenwei@bytedance.com>
References: <20230627072431.449171-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pf1-x42f.google.com
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

Use enum ThrottleType instead of number index.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 include/qemu/throttle.h | 11 ++++++++---
 util/throttle.c         | 16 +++++++++-------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/include/qemu/throttle.h b/include/qemu/throttle.h
index 05f6346137..ba6293eeef 100644
--- a/include/qemu/throttle.h
+++ b/include/qemu/throttle.h
@@ -99,13 +99,18 @@ typedef struct ThrottleState {
     int64_t previous_leak;    /* timestamp of the last leak done */
 } ThrottleState;
 
+typedef enum {
+    THROTTLE_READ = 0,
+    THROTTLE_WRITE,
+    THROTTLE_MAX
+} ThrottleType;
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


