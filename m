Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E43A707DE8
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 12:19:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzaiT-00084l-AZ; Thu, 18 May 2023 06:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzaiP-0007xL-Le
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:18:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzaiO-0004np-1i
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:18:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684405111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2wwZA+6KLKuWG8tmFCtySGPofQTlJlFNtLmCibsN2TU=;
 b=Ps+WQS68AgNAoOSsnc8kHocb0JCvPxAjy81uhiJ4V/FPHsbltL1pY8D9xVIdQxPLeMQ0/9
 iPhHivtQUX88LmbGNZp8Sx9d/C06EotUx8OHSYDexNFKiLbb9sP58HCzUHE7E7jwrCIwWi
 SIec2Q206O0W1tPyYMUHyZmHa40/Yw0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-_IAGP7t8PFWEH6-3YVBr7g-1; Thu, 18 May 2023 06:18:30 -0400
X-MC-Unique: _IAGP7t8PFWEH6-3YVBr7g-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9663552473fso262449766b.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 03:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684405108; x=1686997108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2wwZA+6KLKuWG8tmFCtySGPofQTlJlFNtLmCibsN2TU=;
 b=VSCplS2NIbwuujfTrWw+zu55Sq9eHkZfCvOnfVoEESkaxMoZ7fQAmQJNIpVe52Gkb/
 2BWSGLtVBxoqe0O9f6cUbjo2IQ+VkpsxxuF3waMitjqCkRbVSHqdidRlAzUj0N4vnv+9
 23Bb0J5roTNJMZNLEtVrbvR11lDKOwxqCGLrh2b/UoFHKUskLhbGbsppMZ4h3wLilg47
 16Ouw97XYSsYVGiM1gd4hbbKIrpNsxnbG/hb2IGV2vtD0S2vAnlGF1jflJ4kkrMRWtbR
 PGyOgbXJPB9F/gWZs7U3Vy/Qmrk6vL48/jT/0S9WtSWhTZdPS/SK3DMtXpwt/CuYDRAN
 oMHg==
X-Gm-Message-State: AC+VfDywWfm88bLZa14eSXo6btLk30NJrAi3A0H/uWVk6NNCpGH9YAcC
 ZWmWngRg+OZBDQ6oGNAnrjqcbX3zTUwmJSgTycgXoqQTPqwjldfC6PCNpPHUCY8omgqfnoOKnNv
 1arEv+M21ETjfMYWdaC+psE9CjVJBoFFXYpg7lGcAlXROO3QvTwgW65e1PAKrBo2Sl74dEggY4U
 8=
X-Received: by 2002:a17:907:a0c:b0:966:2123:e0ca with SMTP id
 bb12-20020a1709070a0c00b009662123e0camr37263936ejc.34.1684405108404; 
 Thu, 18 May 2023 03:18:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7P5xpBfsP17t1F0Bo2pWcziOJhXimqzTuOznJvb+NQA/O6lsVYWI6ZHFD09qG51PSmc3dLsw==
X-Received: by 2002:a17:907:a0c:b0:966:2123:e0ca with SMTP id
 bb12-20020a1709070a0c00b009662123e0camr37263916ejc.34.1684405108006; 
 Thu, 18 May 2023 03:18:28 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 gv41-20020a1709072be900b0095ef7268ba9sm769439ejc.41.2023.05.18.03.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 03:18:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	kwolf@redhat.com
Subject: [PATCH 2/5] monitor: cleanup fetching of QMP requests
Date: Thu, 18 May 2023 12:18:20 +0200
Message-Id: <20230518101823.992158-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518101823.992158-1-pbonzini@redhat.com>
References: <20230518101823.992158-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Use a continue statement so that "after going to sleep" is treated the same
way as "after processing a request".  Pull the monitor_lock critical
section out of monitor_qmp_requests_pop_any_with_lock() and protect
qmp_dispatcher_co_shutdown with the monitor_lock.

The two changes are complex to separate because monitor_qmp_dispatcher_co()
previously had a complicated logic to check for shutdown both before
and after going to sleep.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 monitor/monitor.c |  9 +++++++--
 monitor/qmp.c     | 38 ++++++++++++++------------------------
 2 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/monitor/monitor.c b/monitor/monitor.c
index c4ed2547c25f..042a1ab918f9 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -56,7 +56,10 @@ IOThread *mon_iothread;
 /* Coroutine to dispatch the requests received from I/O thread */
 Coroutine *qmp_dispatcher_co;
 
-/* Set to true when the dispatcher coroutine should terminate */
+/*
+ * Set to true when the dispatcher coroutine should terminate.  Protected
+ * by monitor_lock.
+ */
 bool qmp_dispatcher_co_shutdown;
 
 /*
@@ -679,7 +682,9 @@ void monitor_cleanup(void)
      * we'll just leave them in the queue without sending a response
      * and monitor_data_destroy() will free them.
      */
-    qmp_dispatcher_co_shutdown = true;
+    WITH_QEMU_LOCK_GUARD(&monitor_lock) {
+        qmp_dispatcher_co_shutdown = true;
+    }
     if (!qatomic_xchg(&qmp_dispatcher_co_busy, true)) {
         aio_co_wake(qmp_dispatcher_co);
     }
diff --git a/monitor/qmp.c b/monitor/qmp.c
index f0cc6dc886f8..7516b92a4d3e 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -178,7 +178,10 @@ static QMPRequest *monitor_qmp_requests_pop_any_with_lock(void)
     Monitor *mon;
     MonitorQMP *qmp_mon;
 
-    QEMU_LOCK_GUARD(&monitor_lock);
+    /* On shutdown, don't take any more requests from the queue */
+    if (qmp_dispatcher_co_shutdown) {
+        return NULL;
+    }
 
     QTAILQ_FOREACH(mon, &mon_list, entry) {
         if (!monitor_is_qmp(mon)) {
@@ -215,6 +218,10 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
     MonitorQMP *mon;
 
     while (true) {
+        /*
+         * busy must be set to true again by whoever
+         * rescheduled us to avoid double scheduling
+         */
         assert(qatomic_mb_read(&qmp_dispatcher_co_busy) == true);
 
         /*
@@ -224,36 +231,18 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
          */
         qatomic_mb_set(&qmp_dispatcher_co_busy, false);
 
-        /* On shutdown, don't take any more requests from the queue */
-        if (qmp_dispatcher_co_shutdown) {
-            qatomic_set(&qmp_dispatcher_co, NULL);
-            return;
+        WITH_QEMU_LOCK_GUARD(&monitor_lock) {
+            req_obj = monitor_qmp_requests_pop_any_with_lock();
         }
 
-        while (!(req_obj = monitor_qmp_requests_pop_any_with_lock())) {
+        if (!req_obj) {
             /*
              * No more requests to process.  Wait to be reentered from
              * handle_qmp_command() when it pushes more requests, or
              * from monitor_cleanup() when it requests shutdown.
              */
-            if (!qmp_dispatcher_co_shutdown) {
-                qemu_coroutine_yield();
-
-                /*
-                 * busy must be set to true again by whoever
-                 * rescheduled us to avoid double scheduling
-                 */
-                assert(qatomic_xchg(&qmp_dispatcher_co_busy, false) == true);
-            }
-
-            /*
-             * qmp_dispatcher_co_shutdown may have changed if we
-             * yielded and were reentered from monitor_cleanup()
-             */
-            if (qmp_dispatcher_co_shutdown) {
-                qatomic_set(&qmp_dispatcher_co, NULL);
-                return;
-            }
+            qemu_coroutine_yield();
+            continue;
         }
 
         trace_monitor_qmp_in_band_dequeue(req_obj,
@@ -342,6 +331,7 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
         aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
         qemu_coroutine_yield();
     }
+    qatomic_set(&qmp_dispatcher_co, NULL);
 }
 
 static void handle_qmp_command(void *opaque, QObject *req, Error *err)
-- 
2.40.1


