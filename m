Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 399CE707DE5
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 12:19:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzaiU-0008EO-3m; Thu, 18 May 2023 06:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzaiR-00082k-FA
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:18:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzaiP-0004o4-NJ
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684405113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=16tuWLfs0lbwm4hWYeMDGeOyNmcCnS6+7x4zt9UM/tE=;
 b=gbGqyqw7xuBaTxdGrWt7cajCu42sLi8VJHqm8zPpA67GmVwcyqwZ8/V/onnN8IRWmTsIam
 pCf4A2dsZ/LWAJF5DhwjW4NLw/KRMnsJSuXoeC7JLQ/mbRMuqH3fIwe4xSes565hZeR2nk
 Mk+oEZYjk6WVjUHa7Yc0Qy7yictZlX0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-rxXRLAxoM662tJqhM7_beA-1; Thu, 18 May 2023 06:18:31 -0400
X-MC-Unique: rxXRLAxoM662tJqhM7_beA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-510ec47c66aso295891a12.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 03:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684405110; x=1686997110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=16tuWLfs0lbwm4hWYeMDGeOyNmcCnS6+7x4zt9UM/tE=;
 b=FAssxtGJPsnfpf004KzSOY1PThn/Ch1S4N9yDiu0eukMEjFLlTzTjLgqJSrLAqaLkd
 DjZY3/i8517eKaWCg69tiez8PmjkGXtkfOy8CgnQAQ2Q01Og/MZ0jFEOJpXQFrQcphO3
 YgRRemr+7W4I2viylF51wTXMkzn9szTDcZnM+fSdex0FPGCvygFmH51tNaZtBWwlvEPK
 +M0of//P0W7tbIVvkwbxXw5oa3ItAxbnyWR07SeMUDkhI5AoZEmVTMbJ08PyTFQrS0Q/
 en7RFSLRVCBO/lNqfmYrr9yFoc2ih3C9r1gJu1+vmZbmDFYa8j10dCtilHHtGXk7CFXI
 5tIw==
X-Gm-Message-State: AC+VfDwQEN0bbU9nEXiqq8mpeI9lVL3TQqftaLaq8H03fdhh3borlx8N
 rQk1h4+E2iSPH5soQWQaooOGD7wpBtQFVHN0KxEAT5tGnApXPnYs64lhiWUCM3QB2jfGrXJODkQ
 1UKJuy8qdcoA9pDwEZ4o8kAFqUtViOEsypcFQKqikPd4xIo8cdlG9G9NmsgOaltOn1lRyh+MOm5
 I=
X-Received: by 2002:a17:907:a01:b0:94a:5d5c:fe6f with SMTP id
 bb1-20020a1709070a0100b0094a5d5cfe6fmr39579611ejc.47.1684405110037; 
 Thu, 18 May 2023 03:18:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7vujvBE0iVradmdFUWKMWwWLBUQcVUSmgvxYe8Kv/2oFursZ0irY2JLjw/kafxlqmOBs9pXw==
X-Received: by 2002:a17:907:a01:b0:94a:5d5c:fe6f with SMTP id
 bb1-20020a1709070a0100b0094a5d5cfe6fmr39579593ejc.47.1684405109715; 
 Thu, 18 May 2023 03:18:29 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 qn6-20020a170907210600b0096637a19dccsm766612ejb.210.2023.05.18.03.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 03:18:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	kwolf@redhat.com
Subject: [PATCH 3/5] monitor: introduce qmp_dispatcher_co_wake
Date: Thu, 18 May 2023 12:18:21 +0200
Message-Id: <20230518101823.992158-4-pbonzini@redhat.com>
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
index 7516b92a4d3e..baa1f6652e07 100644
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


