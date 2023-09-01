Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0265C78F9D5
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 10:19:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbzMD-0006yN-4D; Fri, 01 Sep 2023 04:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qbzM9-0006xV-PM
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 04:18:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qbzM6-00012i-EK
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 04:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693556293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z1OXWv7qlYmsLhZprrKKPS6RUFj9LLRtdbkmp6RPMiM=;
 b=ErLeiYW++fqfy/ZIobLCARqyfYZSS71v/A+9jWIw4TA4ULkdX1m/c+8JFUJGn7PuDNrZGH
 LhcN0UW1w3Tn/mlW5/z4bbIBRXiQ7xr5zBnl9U5QVzf8Wmxgwj3DwoBciUqZuBx7D2F2ZF
 w6FR03sU/NOX69s/UaV/aLg97magPoE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-IXsayFwDNXaa9eiU2qVBpA-1; Fri, 01 Sep 2023 04:18:10 -0400
X-MC-Unique: IXsayFwDNXaa9eiU2qVBpA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 636851C0759F;
 Fri,  1 Sep 2023 08:18:10 +0000 (UTC)
Received: from localhost (unknown [10.39.194.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 185FE40C2063;
 Fri,  1 Sep 2023 08:18:09 +0000 (UTC)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org,
	Hanna Czenczek <hreitz@redhat.com>
Subject: [PULL 01/14] throttle: introduce enum ThrottleDirection
Date: Fri,  1 Sep 2023 10:17:56 +0200
Message-ID: <20230901081804.31377-2-hreitz@redhat.com>
In-Reply-To: <20230901081804.31377-1-hreitz@redhat.com>
References: <20230901081804.31377-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: zhenwei pi <pizhenwei@bytedance.com>

Use enum ThrottleDirection instead of number index.

Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Message-Id: <20230728022006.1098509-2-pizhenwei@bytedance.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
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
2.41.0


