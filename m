Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1197C6F8F
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 15:45:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqvzF-0000Bw-I6; Thu, 12 Oct 2023 09:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqvyp-0008SU-1M
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:44:03 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqvyj-0003Tw-LE
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:43:55 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 78C241F88F;
 Thu, 12 Oct 2023 13:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697118232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Gucl702KLqRm7/jhIgz9mGTt6PJ2y5ayCd8zKfU9V0=;
 b=YZ59kMi1bpi2xePmyxU/0OL6hxdDQPzuT7ONNh1lag35yZU6v29SjOkZQaCP98E0t80nFj
 T3MhlrlnX3c3mL7v8NuSyy5oo3JgYI8Yzb/yDFPy4zrjj0bOxj8U62CiAiRDAjumDFC3ET
 5GQpCt09WCRcBwfoThUrx9l5RaSCbVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697118232;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Gucl702KLqRm7/jhIgz9mGTt6PJ2y5ayCd8zKfU9V0=;
 b=5t0tqFYwOiL9KhCmGfYGl2khREwecTeOCj5T/cEo5IQbG5+Rpao851ilM/4DkyPRwT+0LB
 bAcjbcZmxomwX7Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 03788139ED;
 Thu, 12 Oct 2023 13:43:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ALYPMBb4J2UQfAAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 12 Oct 2023 13:43:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 3/3] migration/multifd: Clarify Error usage in
 multifd_channel_connect
Date: Thu, 12 Oct 2023 10:43:43 -0300
Message-Id: <20231012134343.23757-4-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231012134343.23757-1-farosas@suse.de>
References: <20231012134343.23757-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 0.90
X-Spamd-Result: default: False [0.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The function is currently called from two sites, one always gives it a
NULL Error and the other always gives it a non-NULL Error.

In the non-NULL case, all it does it trace the error and return. One
of the callers already have tracing, add a tracepoint to the other and
stop passing the error into the function.

Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd.c    | 60 ++++++++++++++++++++----------------------
 migration/trace-events |  3 ++-
 2 files changed, 30 insertions(+), 33 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index bc3994c567..2947a99dc0 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -774,7 +774,7 @@ out:
 
 static bool multifd_channel_connect(MultiFDSendParams *p,
                                     QIOChannel *ioc,
-                                    Error *error);
+                                    Error **errp);
 
 static void multifd_tls_outgoing_handshake(QIOTask *task,
                                            gpointer opaque)
@@ -783,21 +783,22 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
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
@@ -813,7 +814,7 @@ static void *multifd_tls_handshake_thread(void *opaque)
     return NULL;
 }
 
-static void multifd_tls_channel_connect(MultiFDSendParams *p,
+static bool multifd_tls_channel_connect(MultiFDSendParams *p,
                                         QIOChannel *ioc,
                                         Error **errp)
 {
@@ -823,7 +824,7 @@ static void multifd_tls_channel_connect(MultiFDSendParams *p,
 
     tioc = migration_tls_client_create(ioc, hostname, errp);
     if (!tioc) {
-        return;
+        return false;
     }
 
     object_unref(OBJECT(ioc));
@@ -833,31 +834,25 @@ static void multifd_tls_channel_connect(MultiFDSendParams *p,
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
@@ -896,11 +891,12 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
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
index ee9c8f4d63..0b442cc7cc 100644
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
2.35.3


