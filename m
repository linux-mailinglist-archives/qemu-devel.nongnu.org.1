Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7FC7518F7
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 08:42:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJq1K-0004g2-Uv; Thu, 13 Jul 2023 02:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qJq1I-0004fQ-GX
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 02:41:44 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qJq1B-0007ob-Ct
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 02:41:44 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1b9c368f4b5so11128905ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 23:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1689230491; x=1691822491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+nzZLdnHvv22BtX0bis4ofXWb7eL4AjLZDSnk3l5cPM=;
 b=jokGQ+A86gyDGZwNwZgNNUBG21K/mfzFQ3YR0zjhoZBX3gP1wfJlDw1qtfnhTgh0Wm
 YTEOm+oQAwRAfBPcUZrtdwvBR1RhkYKQRv8/ASUO1u2gokIo/L8PhU7eo4pMyq836/sh
 liki/RrHRL+2CtaKzTn1zS1960FF3wX2BMics68245tRG2IuUi9If6xFLt7vetxZUu1/
 Wbx/Fgv9RjVBRxH12I6rSQj90ZIbWOILsSQLrSaVWLKzLGMoibail5AiVAHQyArF974C
 ofTBopLKOwBXEUCM+LAI8XJJAUnehPrdGWVnrs/SnwsbRxs8qHvJ1npgk+eu3aJsFeGA
 FHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689230491; x=1691822491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+nzZLdnHvv22BtX0bis4ofXWb7eL4AjLZDSnk3l5cPM=;
 b=Kas5GXZElRWE0WSt0Dvzidjhb5X0nrvbu1RLig0KBfwerbv0ebR4iKRWCsdgDATos7
 Esx3sTSOFaK4umQt+0V8C0jGn2H5c+8ZscQgln6B+ANqfzf6Ve57ZzrIPh61uKFvbvrV
 beIietiZN8wu6NwKbXX/0swHG8TotRL6IdoZmYnK2cptYz55AFuFCS80EMuPQSwqJhgc
 uzk61LEnryAdxE0oVhQ9fSPlBM/hTImdMFUFqxNdwLCV1TUpY05hElfRLR0+4JnPtLsW
 5z6GhplWQW0MArfeGhq4qr4599/QkHpHrnFX/JkLMTGDQk9Qx9+mhmAt7VdNzJuvdYFw
 eg4g==
X-Gm-Message-State: ABy/qLbrXnS7UewbYLCQHh8oMHjHSj2b6On5hildNfIw2/biqnzhe1Cg
 QqyJGMmOq606c/ll49JN/HMT5w==
X-Google-Smtp-Source: APBJJlHIyIhGAK+ueDlqgCLNLAnFdjeXGO3SMa7rxVlKkTfGzx36VFuOfFtfJ7sW58ocvMJaAT1+kQ==
X-Received: by 2002:a17:902:c401:b0:1b1:99c9:8ce5 with SMTP id
 k1-20020a170902c40100b001b199c98ce5mr6614486plk.16.1689230491337; 
 Wed, 12 Jul 2023 23:41:31 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.11])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a170902680d00b001ac2be26340sm5144966plk.222.2023.07.12.23.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 23:41:30 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: berto@igalia.com, kwolf@redhat.com, groug@kaod.org, qemu_oss@crudebyte.com,
 hreitz@redhat.com
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH v3 1/6] throttle: introduce enum ThrottleType
Date: Thu, 13 Jul 2023 14:41:06 +0800
Message-Id: <20230713064111.558652-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713064111.558652-1-pizhenwei@bytedance.com>
References: <20230713064111.558652-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Alberto Garcia <berto@igalia.com>
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


