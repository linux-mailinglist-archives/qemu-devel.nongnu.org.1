Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 053D87CBDB6
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 10:36:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsfUz-0008TN-Kb; Tue, 17 Oct 2023 04:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfUx-0008SL-0z
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:32:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfUv-0005b5-Ak
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697531535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L9QE8mwk5GY7edOuLm3/DrFaaaobWNNTb2ZcS+1k7gg=;
 b=R5GXFwxUvvfDd1hvFk9TyUN0IurrGYwFhpDMHEB9vB6NnwZPbcG4oVsCfHQUxxqz8T0Jue
 o8SUIN9+K3gC6Dev30E87n/vKuO8FuQC3bPP7XDDy2WdQVhL87//5a2AP2kZcisJofMVfC
 y9EmNzHkh0SYa901SycRqKu6B2kIWOI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-mT-V9EgZMqKNQOZMj-WzKg-1; Tue, 17 Oct 2023 04:32:01 -0400
X-MC-Unique: mT-V9EgZMqKNQOZMj-WzKg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1EA6038116F5;
 Tue, 17 Oct 2023 08:32:01 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E926A1C060B0;
 Tue, 17 Oct 2023 08:31:57 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 38/38] migration/multifd: Clarify Error usage in
 multifd_channel_connect
Date: Tue, 17 Oct 2023 10:30:03 +0200
Message-ID: <20231017083003.15951-39-quintela@redhat.com>
In-Reply-To: <20231017083003.15951-1-quintela@redhat.com>
References: <20231017083003.15951-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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

From: Fabiano Rosas <farosas@suse.de>

The function is currently called from two sites, one always gives it a
NULL Error and the other always gives it a non-NULL Error.

In the non-NULL case, all it does it trace the error and return. One
of the callers already have tracing, add a tracepoint to the other and
stop passing the error into the function.

Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231012134343.23757-4-farosas@suse.de>
---
 migration/multifd.c    | 60 ++++++++++++++++++++----------------------
 migration/trace-events |  3 ++-
 2 files changed, 30 insertions(+), 33 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index c92955de41..1fe53d3b98 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -775,7 +775,7 @@ out:
 
 static bool multifd_channel_connect(MultiFDSendParams *p,
                                     QIOChannel *ioc,
-                                    Error *error);
+                                    Error **errp);
 
 static void multifd_tls_outgoing_handshake(QIOTask *task,
                                            gpointer opaque)
@@ -784,21 +784,22 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
     QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
     Error *err = NULL;
 
-    if (qio_task_propagate_error(task, &err)) {
-        trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
-    } else {
+    if (!qio_task_propagate_error(task, &err)) {
         trace_multifd_tls_outgoing_handshake_complete(ioc);
+        if (multifd_channel_connect(p, ioc, &err)) {
+            return;
+        }
     }
 
-    if (!multifd_channel_connect(p, ioc, err)) {
-        /*
-         * Error happen, mark multifd_send_thread status as 'quit' although it
-         * is not created, and then tell who pay attention to me.
-         */
-        p->quit = true;
-        qemu_sem_post(&multifd_send_state->channels_ready);
-        qemu_sem_post(&p->sem_sync);
-    }
+    trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
+
+    /*
+     * Error happen, mark multifd_send_thread status as 'quit' although it
+     * is not created, and then tell who pay attention to me.
+     */
+    p->quit = true;
+    qemu_sem_post(&multifd_send_state->channels_ready);
+    qemu_sem_post(&p->sem_sync);
 }
 
 static void *multifd_tls_handshake_thread(void *opaque)
@@ -814,7 +815,7 @@ static void *multifd_tls_handshake_thread(void *opaque)
     return NULL;
 }
 
-static void multifd_tls_channel_connect(MultiFDSendParams *p,
+static bool multifd_tls_channel_connect(MultiFDSendParams *p,
                                         QIOChannel *ioc,
                                         Error **errp)
 {
@@ -824,7 +825,7 @@ static void multifd_tls_channel_connect(MultiFDSendParams *p,
 
     tioc = migration_tls_client_create(ioc, hostname, errp);
     if (!tioc) {
-        return;
+        return false;
     }
 
     object_unref(OBJECT(ioc));
@@ -834,31 +835,25 @@ static void multifd_tls_channel_connect(MultiFDSendParams *p,
     qemu_thread_create(&p->thread, "multifd-tls-handshake-worker",
                        multifd_tls_handshake_thread, p,
                        QEMU_THREAD_JOINABLE);
+    return true;
 }
 
 static bool multifd_channel_connect(MultiFDSendParams *p,
                                     QIOChannel *ioc,
-                                    Error *error)
+                                    Error **errp)
 {
     trace_multifd_set_outgoing_channel(
         ioc, object_get_typename(OBJECT(ioc)),
-        migrate_get_current()->hostname, error);
+        migrate_get_current()->hostname);
 
-    if (error) {
-        return false;
-    }
     if (migrate_channel_requires_tls_upgrade(ioc)) {
-        multifd_tls_channel_connect(p, ioc, &error);
-        if (!error) {
-            /*
-             * tls_channel_connect will call back to this
-             * function after the TLS handshake,
-             * so we mustn't call multifd_send_thread until then
-             */
-            return true;
-        } else {
-            return false;
-        }
+        /*
+         * tls_channel_connect will call back to this
+         * function after the TLS handshake,
+         * so we mustn't call multifd_send_thread until then
+         */
+        return multifd_tls_channel_connect(p, ioc, errp);
+
     } else {
         migration_ioc_register_yank(ioc);
         p->registered_yank = true;
@@ -897,11 +892,12 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
         p->c = ioc;
         qio_channel_set_delay(p->c, false);
         p->running = true;
-        if (multifd_channel_connect(p, ioc, local_err)) {
+        if (multifd_channel_connect(p, ioc, &local_err)) {
             return;
         }
     }
 
+    trace_multifd_new_send_channel_async_error(p->id, local_err);
     multifd_new_send_channel_cleanup(p, ioc, local_err);
 }
 
diff --git a/migration/trace-events b/migration/trace-events
index 403cc1ae11..fa9486dffe 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -125,6 +125,7 @@ postcopy_preempt_reset_channel(void) ""
 
 # multifd.c
 multifd_new_send_channel_async(uint8_t id) "channel %u"
+multifd_new_send_channel_async_error(uint8_t id, void *err) "channel=%u err=%p"
 multifd_recv(uint8_t id, uint64_t packet_num, uint32_t used, uint32_t flags, uint32_t next_packet_size) "channel %u packet_num %" PRIu64 " pages %u flags 0x%x next packet size %u"
 multifd_recv_new_channel(uint8_t id) "channel %u"
 multifd_recv_sync_main(long packet_num) "packet num %ld"
@@ -144,7 +145,7 @@ multifd_send_thread_start(uint8_t id) "%u"
 multifd_tls_outgoing_handshake_start(void *ioc, void *tioc, const char *hostname) "ioc=%p tioc=%p hostname=%s"
 multifd_tls_outgoing_handshake_error(void *ioc, const char *err) "ioc=%p err=%s"
 multifd_tls_outgoing_handshake_complete(void *ioc) "ioc=%p"
-multifd_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname, void *err)  "ioc=%p ioctype=%s hostname=%s err=%p"
+multifd_set_outgoing_channel(void *ioc, const char *ioctype, const char *hostname)  "ioc=%p ioctype=%s hostname=%s"
 
 # migration.c
 await_return_path_close_on_source_close(void) ""
-- 
2.41.0


