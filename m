Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1EA710E22
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 16:19:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2BlJ-0004jQ-Gs; Thu, 25 May 2023 10:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2BlA-0004gQ-KU
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:16:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bl9-0007fz-2K
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685024166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eiK10lJM3Fr+F6lAulMixwUliXSAcQs4di3viP4dGw0=;
 b=AsfVU9JumCWVcY0/bA3VvypWDSdUVr18nqY8xCTxbMXD6WVymSYMIs6bVIyxuI6wft2QYF
 Z8ulvh/xhJ44JSZCrEb2lyMIW0LeacoZMQ69BAmgqFVhcQ/OeKu0RYuzsugvB87eF7ANSr
 TBa/9EzYjlmtprJiQfuTkkO7KT7BThE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-mOSMhz2iM4-od70QX53O7A-1; Thu, 25 May 2023 10:16:03 -0400
X-MC-Unique: mOSMhz2iM4-od70QX53O7A-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-510eb233a81so2350156a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 07:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685024159; x=1687616159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eiK10lJM3Fr+F6lAulMixwUliXSAcQs4di3viP4dGw0=;
 b=iS62CZX0czhMQIdOCGp8bhuXcigSfgh8wKMZ7+CL0PitDKn7umAPxTlHzL+KRLBPJt
 EE49uAKibZ4f5LrjueHCZkOs6QqDLRnw9xELI3agc8xxFwWwrFm+8+SuFd8JkVx5iWOZ
 ylp/4DgpNbDlhimCpTk+OI+PMca8j3eHQ0I734qrtuwee4Evrgzw73QyKY2uI2ZSJo9r
 WcICpm+6i+Tqd4ioUKroo/ycAcfad9fR5nypshmVHN866qyQ9am8OcoQ0tk7LZnrs8rE
 6iUbRe7hPKxsdYHU5W6rRqSbFF87yTvaBxkBCk5+M1Dorjz4bi5c6SmYg3CT22LlTbZY
 LCmw==
X-Gm-Message-State: AC+VfDwUcPGkvNrtwcuUPviK77KPhIM3pq+uhXn6uvf2EPSAS+V0rbra
 J25t3BzP8P5QGZz5A6Nj6AmvhiwVcBh4L8oLJs5T5HpQTv6l+KXE+AEdM3yD/4OB2OXEt76WQIk
 IRdWv5PGubZKkfUIATsvRLy3/jMd7Fqm2ppqvRKANWczL8yQGNWeOSTN+N2nKJ25QXMMFSfA6NU
 g=
X-Received: by 2002:a05:6402:3457:b0:50b:d495:106c with SMTP id
 l23-20020a056402345700b0050bd495106cmr4269197edc.8.1685024159735; 
 Thu, 25 May 2023 07:15:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7q4dmTyWa+2quxd0ChOihR6UaWq7uemWA10zlT2zMu7sIIepItO6/9W7R/i78duJWp9AeVlg==
X-Received: by 2002:a05:6402:3457:b0:50b:d495:106c with SMTP id
 l23-20020a056402345700b0050bd495106cmr4269176edc.8.1685024159380; 
 Thu, 25 May 2023 07:15:59 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 d27-20020a056402517b00b0050c0d651fb1sm594076ede.75.2023.05.25.07.15.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 07:15:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/20] monitor: cleanup fetching of QMP requests
Date: Thu, 25 May 2023 16:15:29 +0200
Message-Id: <20230525141532.295817-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525141532.295817-1-pbonzini@redhat.com>
References: <20230525141532.295817-1-pbonzini@redhat.com>
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
 monitor/qmp.c     | 40 +++++++++++++++-------------------------
 2 files changed, 22 insertions(+), 27 deletions(-)

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
index f0cc6dc886f8..dfc215632865 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -178,8 +178,6 @@ static QMPRequest *monitor_qmp_requests_pop_any_with_lock(void)
     Monitor *mon;
     MonitorQMP *qmp_mon;
 
-    QEMU_LOCK_GUARD(&monitor_lock);
-
     QTAILQ_FOREACH(mon, &mon_list, entry) {
         if (!monitor_is_qmp(mon)) {
             continue;
@@ -215,6 +213,10 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
     MonitorQMP *mon;
 
     while (true) {
+        /*
+         * busy must be set to true again by whoever
+         * rescheduled us to avoid double scheduling
+         */
         assert(qatomic_mb_read(&qmp_dispatcher_co_busy) == true);
 
         /*
@@ -224,36 +226,23 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
          */
         qatomic_mb_set(&qmp_dispatcher_co_busy, false);
 
-        /* On shutdown, don't take any more requests from the queue */
-        if (qmp_dispatcher_co_shutdown) {
-            qatomic_set(&qmp_dispatcher_co, NULL);
-            return;
+        WITH_QEMU_LOCK_GUARD(&monitor_lock) {
+            /* On shutdown, don't take any more requests from the queue */
+            if (qmp_dispatcher_co_shutdown) {
+                return NULL;
+            }
+
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


