Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BCFD7D25C4
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 22:14:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1queoZ-0005FX-6u; Sun, 22 Oct 2023 16:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1queoW-0005Ea-9g
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 16:12:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1queoU-00061J-A6
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 16:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698005561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F96rZlJDGWqR9lE4rEHkK4a/bYoywEb7PcXAjwNkcmM=;
 b=V38lsjf9QGJVJ0M+GmW8EsJBF37Z2gmbqQI3f14XaqVwSJYT3qMIEuyKiwN6XAk8IRY6VB
 YwfzZ7N3Lu8kUJcNQszqYBFqDuj3OsKUx1xKIQ60ZFFpvpD5ZKI2BFaZuyiV0wD48gpy+o
 n0R++9LlacTERawIVQ8JZPzsRBCs6k4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-grsD6fm_N9u8gj2aJojSIA-1; Sun, 22 Oct 2023 16:12:39 -0400
X-MC-Unique: grsD6fm_N9u8gj2aJojSIA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-66cfa898cfeso7839746d6.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 13:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698005559; x=1698610359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F96rZlJDGWqR9lE4rEHkK4a/bYoywEb7PcXAjwNkcmM=;
 b=wT6ONSQCbvcAaPO6EjXd5lZtGZYofIajrv941KT6arYyet9Zfa/SxzKy0y+HEH4ykc
 2IeovzKvCUasEm+FYBzZmfEW4qdmJrJqslviFHqDplHb1mFr6iIT5O0zuHcXi3RY1QCs
 Y0J50cOQetlddXLk/qr8RjGUln02QSAby1Kdt/OwuBBoLfJvzEfjf/KTle4POGR8C/9k
 b/OjGdqjSY+0VJmfBmwW6UlZGEjpMMbSJdxvX0nrbTxd/6LzMbVpWYD6QhehysDdrbNY
 QAx1vZZUoSsDLceYu0u71JoejJsBtgYp+dZ2HNqRNAOxs8Ib3B/hIrOYu2jOLUEOEeh1
 fT1g==
X-Gm-Message-State: AOJu0YwgCKRKPdWJ8aPuLDQ2lyXJ2Q+m/41wECpsFCEBEzdejEi4iln3
 x//oqX4JKP4JxyakyeuHkAd2UjkVXMTwblo8JRXZ0l34n8cQc/d16ubzVJvLUJQMjgukmPtldKO
 6GuN84uqEHsgzm9muCuuZBCgqvsMTqDIviWX+CEnfzAM/Ha90GcIbcNLH+hvSNO5W8uR0wISq
X-Received: by 2002:ad4:58f2:0:b0:66d:44f2:7fcb with SMTP id
 di18-20020ad458f2000000b0066d44f27fcbmr7838428qvb.2.1698005558894; 
 Sun, 22 Oct 2023 13:12:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAENAIwIcNGFVixg6pmS9mVIF2qQxYLvxbj3IkO+bkcFElgBRxoWnkoz12xc/6BGDeiQxn+w==
X-Received: by 2002:ad4:58f2:0:b0:66d:44f2:7fcb with SMTP id
 di18-20020ad458f2000000b0066d44f27fcbmr7838413qvb.2.1698005558552; 
 Sun, 22 Oct 2023 13:12:38 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a0cfe0b000000b0065af657ddf7sm2330515qvr.144.2023.10.22.13.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 13:12:37 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com
Subject: [PATCH RFC 4/7] migration: Drop MultiFDSendParams.quit and cleanup
 error paths
Date: Sun, 22 Oct 2023 16:12:08 -0400
Message-ID: <20231022201211.452861-5-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231022201211.452861-1-peterx@redhat.com>
References: <20231022201211.452861-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Multifd send side has two fields to indicate error quits:

  - MultiFDSendParams.quit
  - &multifd_send_state->exiting

Merge them into the global one.  The replacement is done by changing all
p->quit checks into the global var check.  The global check doesn't need
any lock.

A few more things done on top of this altogether:

  - multifd_send_terminate_threads()

    Moving the xchg() of &multifd_send_state->exiting upper, so as to cover
    the tracepoint, migrate_set_error() and migrate_set_state().

  - multifd_send_sync_main()

    In the 2nd loop, add one more check over the global var to make sure we
    don't keep the looping if QEMU already decided to quit.

  - multifd_tls_outgoing_handshake()

    Use multifd_send_terminate_threads() to set the error state.  That has
    a benefit of updating MigrationState.error to that error too, so we can
    persist that 1st error we hit in that specific channel.

  - multifd_new_send_channel_async()

    Take similar approach like above, drop the migrate_set_error() because
    multifd_send_terminate_threads() already covers that.  Unwrap the helper
    multifd_new_send_channel_cleanup() along the way; not really needed.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h |  2 --
 migration/multifd.c | 82 ++++++++++++++-------------------------------
 2 files changed, 26 insertions(+), 58 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index a835643b48..2acf400085 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -97,8 +97,6 @@ typedef struct {
     QemuMutex mutex;
     /* is this channel thread running */
     bool running;
-    /* should this thread finish */
-    bool quit;
     /* multifd flags for each packet */
     uint32_t flags;
     /* global number of generated multifd packets */
diff --git a/migration/multifd.c b/migration/multifd.c
index 33fb21d0e4..9d458914a9 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -411,10 +411,6 @@ static int multifd_send_pages(QEMUFile *f)
     MultiFDSendParams *p = NULL; /* make happy gcc */
     MultiFDPages_t *pages = multifd_send_state->pages;
 
-    if (qatomic_read(&multifd_send_state->exiting)) {
-        return -1;
-    }
-
     qemu_sem_wait(&multifd_send_state->channels_ready);
     /*
      * next_channel can remain from a previous migration that was
@@ -423,14 +419,11 @@ static int multifd_send_pages(QEMUFile *f)
      */
     next_channel %= migrate_multifd_channels();
     for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
-        p = &multifd_send_state->params[i];
-
-        qemu_mutex_lock(&p->mutex);
-        if (p->quit) {
-            error_report("%s: channel %d has already quit!", __func__, i);
-            qemu_mutex_unlock(&p->mutex);
+        if (qatomic_read(&multifd_send_state->exiting)) {
             return -1;
         }
+        p = &multifd_send_state->params[i];
+        qemu_mutex_lock(&p->mutex);
         if (!p->pending_job) {
             p->pending_job++;
             next_channel = (i + 1) % migrate_multifd_channels();
@@ -485,6 +478,16 @@ static void multifd_send_terminate_threads(Error *err)
 {
     int i;
 
+    /*
+     * We don't want to exit each threads twice.  Depending on where
+     * we get the error, or if there are two independent errors in two
+     * threads at the same time, we can end calling this function
+     * twice.
+     */
+    if (qatomic_xchg(&multifd_send_state->exiting, 1)) {
+        return;
+    }
+
     trace_multifd_send_terminate_threads(err != NULL);
 
     if (err) {
@@ -499,26 +502,13 @@ static void multifd_send_terminate_threads(Error *err)
         }
     }
 
-    /*
-     * We don't want to exit each threads twice.  Depending on where
-     * we get the error, or if there are two independent errors in two
-     * threads at the same time, we can end calling this function
-     * twice.
-     */
-    if (qatomic_xchg(&multifd_send_state->exiting, 1)) {
-        return;
-    }
-
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
-        qemu_mutex_lock(&p->mutex);
-        p->quit = true;
         qemu_sem_post(&p->sem);
         if (p->c) {
             qio_channel_shutdown(p->c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
         }
-        qemu_mutex_unlock(&p->mutex);
     }
 }
 
@@ -617,16 +607,13 @@ int multifd_send_sync_main(QEMUFile *f)
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
-        trace_multifd_send_sync_main_signal(p->id);
-
-        qemu_mutex_lock(&p->mutex);
-
-        if (p->quit) {
-            error_report("%s: channel %d has already quit", __func__, i);
-            qemu_mutex_unlock(&p->mutex);
+        if (qatomic_read(&multifd_send_state->exiting)) {
             return -1;
         }
 
+        trace_multifd_send_sync_main_signal(p->id);
+
+        qemu_mutex_lock(&p->mutex);
         p->packet_num = multifd_send_state->packet_num++;
         p->flags |= MULTIFD_FLAG_SYNC;
         p->pending_job++;
@@ -636,6 +623,10 @@ int multifd_send_sync_main(QEMUFile *f)
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
+        if (qatomic_read(&multifd_send_state->exiting)) {
+            return -1;
+        }
+
         qemu_sem_wait(&multifd_send_state->channels_ready);
         trace_multifd_send_sync_main_wait(p->id);
         qemu_sem_wait(&p->sem_sync);
@@ -744,9 +735,6 @@ static void *multifd_send_thread(void *opaque)
             if (flags & MULTIFD_FLAG_SYNC) {
                 qemu_sem_post(&p->sem_sync);
             }
-        } else if (p->quit) {
-            qemu_mutex_unlock(&p->mutex);
-            break;
         } else {
             qemu_mutex_unlock(&p->mutex);
             /* sometimes there are spurious wakeups */
@@ -793,11 +781,7 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
 
     trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
 
-    /*
-     * Error happen, mark multifd_send_thread status as 'quit' although it
-     * is not created, and then tell who pay attention to me.
-     */
-    p->quit = true;
+    multifd_send_terminate_threads(err);
     multifd_send_kick_main(p);
     error_free(err);
 }
@@ -864,22 +848,6 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
     return true;
 }
 
-static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
-                                             QIOChannel *ioc, Error *err)
-{
-     migrate_set_error(migrate_get_current(), err);
-     /* Error happen, we need to tell who pay attention to me */
-     multifd_send_kick_main(p);
-     /*
-      * Although multifd_send_thread is not created, but main migration
-      * thread need to judge whether it is running, so we need to mark
-      * its status.
-      */
-     p->quit = true;
-     object_unref(OBJECT(ioc));
-     error_free(err);
-}
-
 static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
 {
     MultiFDSendParams *p = opaque;
@@ -897,7 +865,10 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
     }
 
     trace_multifd_new_send_channel_async_error(p->id, local_err);
-    multifd_new_send_channel_cleanup(p, ioc, local_err);
+    multifd_send_terminate_threads(local_err);
+    multifd_send_kick_main(p);
+    object_unref(OBJECT(ioc));
+    error_free(local_err);
 }
 
 static void multifd_new_send_channel_create(gpointer opaque)
@@ -929,7 +900,6 @@ int multifd_save_setup(Error **errp)
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
         qemu_sem_init(&p->sem_sync, 0);
-        p->quit = false;
         p->pending_job = 0;
         p->id = i;
         p->pages = multifd_pages_init(page_count);
-- 
2.41.0


