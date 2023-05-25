Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B14F1710E36
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 16:22:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2BlK-0004lW-QH; Thu, 25 May 2023 10:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2BlB-0004gU-IG
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:16:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bl9-0007fh-2o
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685024165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O2PLsbXG5vr5D9VC6WIdD+L79W4Lo+phkDs6SMTk9b4=;
 b=cIlRGNcyfmYc0jmVlhqgdj/2roFWpgQalZUoliC9f9hkOjHrStONhTztwb5740HIbGKSGN
 8M+WPFJ2eTrAP+BxVMKvfgNCt7xM+2i4Fk7yXCELYxBMEF5+0ORxnrx9yK139ZjI6e+6Aq
 U3eL23fq7NmMoNh5F/yEPy1TQqTjcSg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-vLDMBiMkMCKpjk_nV7aPmQ-1; Thu, 25 May 2023 10:16:03 -0400
X-MC-Unique: vLDMBiMkMCKpjk_nV7aPmQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-96f9aa23593so69061766b.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 07:16:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685024161; x=1687616161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O2PLsbXG5vr5D9VC6WIdD+L79W4Lo+phkDs6SMTk9b4=;
 b=SdNG8wD9rpGZK6PeyQDIdk4bMCiOn+kxQyKFJQupoZ4eK23zlJ5dEMORbHnFZRrXaX
 qXi4ooi08Qd4KAL2Ug6OD2fYt5BCpTUU33qM8ybGIGVIB8Cxtuf2+7qtvUSod0woz1Hs
 TAWNJAfFN7G79LOwNkFQXmBjwIOt0qfQv0u4PZeVGPT0MPB2OkJcpxWQVw730pGxcS2Z
 y0ozwwAhNqvMSGdWipevlS7Yh8C+zWLVkrQEoaPhFI6yiLxjlaxRKFnYrGrGyWuQcSmp
 igFEjFgxL7pAGTUPoRiivvQkaoA0FipzyYh9wlopB46BhPEpPl2v2s++7Sj6MK8QvZ3E
 YRKQ==
X-Gm-Message-State: AC+VfDxKrxM7Z1KoZZCEbSrJjo23ywQPSqujOpi6wOx9n4rWOAprYfw9
 WVbJRenBuIX4LRGAYD1e8SA7Ihmp3Ovz03yztl1Asaxr9sntpMP5j9OH78EAxthLMUYjAI/DOoz
 CGvibxz2v2UYDgPoIEPB/1r4PCWCp0iNlGXOnXuUx7VQ0ITV3jDOyWMG5vsz9H5BpD7KbhBsaMY
 o=
X-Received: by 2002:a17:907:3fa2:b0:96f:5b7c:360b with SMTP id
 hr34-20020a1709073fa200b0096f5b7c360bmr2475392ejc.0.1685024161196; 
 Thu, 25 May 2023 07:16:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4dGgJ0PCy0rdh4gco9EtAfWOQW+M6CWqWjOxNDdc3UX3PbemmDTLUukHuSsUqnl31q/jL6sw==
X-Received: by 2002:a17:907:3fa2:b0:96f:5b7c:360b with SMTP id
 hr34-20020a1709073fa200b0096f5b7c360bmr2475365ejc.0.1685024160753; 
 Thu, 25 May 2023 07:16:00 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a1709065e0a00b0096f7e7d1566sm889963eju.224.2023.05.25.07.15.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 07:16:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 18/20] monitor: introduce qmp_dispatcher_co_wake
Date: Thu, 25 May 2023 16:15:30 +0200
Message-Id: <20230525141532.295817-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525141532.295817-1-pbonzini@redhat.com>
References: <20230525141532.295817-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

This makes it possible to turn qmp_dispatcher_co_busy into a static
variable.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 monitor/monitor-internal.h |  2 +-
 monitor/monitor.c          | 26 +-------------------------
 monitor/qmp.c              | 32 +++++++++++++++++++++++++++++---
 3 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 61c9b6916db3..252de856812f 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -165,7 +165,6 @@ typedef QTAILQ_HEAD(MonitorList, Monitor) MonitorList;
 extern IOThread *mon_iothread;
 extern Coroutine *qmp_dispatcher_co;
 extern bool qmp_dispatcher_co_shutdown;
-extern bool qmp_dispatcher_co_busy;
 extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
 extern QemuMutex monitor_lock;
 extern MonitorList mon_list;
@@ -183,6 +182,7 @@ void monitor_fdsets_cleanup(void);
 void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
 void monitor_data_destroy_qmp(MonitorQMP *mon);
 void coroutine_fn monitor_qmp_dispatcher_co(void *data);
+void qmp_dispatcher_co_wake(void);
 
 int get_monitor_def(Monitor *mon, int64_t *pval, const char *name);
 void handle_hmp_command(MonitorHMP *mon, const char *cmdline);
diff --git a/monitor/monitor.c b/monitor/monitor.c
index 042a1ab918f9..dc352f9e9d95 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -62,27 +62,6 @@ Coroutine *qmp_dispatcher_co;
  */
 bool qmp_dispatcher_co_shutdown;
 
-/*
- * qmp_dispatcher_co_busy is used for synchronisation between the
- * monitor thread and the main thread to ensure that the dispatcher
- * coroutine never gets scheduled a second time when it's already
- * scheduled (scheduling the same coroutine twice is forbidden).
- *
- * It is true if the coroutine is active and processing requests.
- * Additional requests may then be pushed onto mon->qmp_requests,
- * and @qmp_dispatcher_co_shutdown may be set without further ado.
- * @qmp_dispatcher_co_busy must not be woken up in this case.
- *
- * If false, you also have to set @qmp_dispatcher_co_busy to true and
- * wake up @qmp_dispatcher_co after pushing the new requests.
- *
- * The coroutine will automatically change this variable back to false
- * before it yields.  Nobody else may set the variable to false.
- *
- * Access must be atomic for thread safety.
- */
-bool qmp_dispatcher_co_busy;
-
 /*
  * Protects mon_list, monitor_qapi_event_state, coroutine_mon,
  * monitor_destroyed.
@@ -685,9 +664,7 @@ void monitor_cleanup(void)
     WITH_QEMU_LOCK_GUARD(&monitor_lock) {
         qmp_dispatcher_co_shutdown = true;
     }
-    if (!qatomic_xchg(&qmp_dispatcher_co_busy, true)) {
-        aio_co_wake(qmp_dispatcher_co);
-    }
+    qmp_dispatcher_co_wake();
 
     AIO_WAIT_WHILE_UNLOCKED(NULL,
                    (aio_poll(iohandler_get_aio_context(), false),
@@ -742,7 +719,6 @@ void monitor_init_globals(void)
      * rid of those assumptions.
      */
     qmp_dispatcher_co = qemu_coroutine_create(monitor_qmp_dispatcher_co, NULL);
-    qatomic_mb_set(&qmp_dispatcher_co_busy, true);
     aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
 }
 
diff --git a/monitor/qmp.c b/monitor/qmp.c
index dfc215632865..613b74ec74a7 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -33,6 +33,27 @@
 #include "qapi/qmp/qlist.h"
 #include "trace.h"
 
+/*
+ * qmp_dispatcher_co_busy is used for synchronisation between the
+ * monitor thread and the main thread to ensure that the dispatcher
+ * coroutine never gets scheduled a second time when it's already
+ * scheduled (scheduling the same coroutine twice is forbidden).
+ *
+ * It is true if the coroutine is active and processing requests.
+ * Additional requests may then be pushed onto mon->qmp_requests,
+ * and @qmp_dispatcher_co_shutdown may be set without further ado.
+ * @qmp_dispatcher_co_busy must not be woken up in this case.
+ *
+ * If false, you also have to set @qmp_dispatcher_co_busy to true and
+ * wake up @qmp_dispatcher_co after pushing the new requests.
+ *
+ * The coroutine will automatically change this variable back to false
+ * before it yields.  Nobody else may set the variable to false.
+ *
+ * Access must be atomic for thread safety.
+ */
+static bool qmp_dispatcher_co_busy = true;
+
 struct QMPRequest {
     /* Owner of the request */
     MonitorQMP *mon;
@@ -334,6 +355,13 @@ void coroutine_fn monitor_qmp_dispatcher_co(void *data)
     qatomic_set(&qmp_dispatcher_co, NULL);
 }
 
+void qmp_dispatcher_co_wake(void)
+{
+    if (!qatomic_xchg(&qmp_dispatcher_co_busy, true)) {
+        aio_co_wake(qmp_dispatcher_co);
+    }
+}
+
 static void handle_qmp_command(void *opaque, QObject *req, Error *err)
 {
     MonitorQMP *mon = opaque;
@@ -395,9 +423,7 @@ static void handle_qmp_command(void *opaque, QObject *req, Error *err)
     }
 
     /* Kick the dispatcher routine */
-    if (!qatomic_xchg(&qmp_dispatcher_co_busy, true)) {
-        aio_co_wake(qmp_dispatcher_co);
-    }
+    qmp_dispatcher_co_wake();
 }
 
 static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
-- 
2.40.1


