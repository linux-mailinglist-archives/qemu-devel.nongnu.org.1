Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8655778D06E
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:24:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7oE-0002Lu-Re; Tue, 29 Aug 2023 19:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qb6U3-0006Ki-Ck
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:42:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qb6U0-0000db-7G
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693345363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VBJUvVKr9ywnzsnevPjeEHCHeGxc9AC8Z+wZG3cb7nU=;
 b=ZBlx3PFM8vq5j0Go/C6shebDL7M+ty07w3i0ayM2n4AriglcG6galXtfdn5CiHZsSkIoIj
 TzrdQwBwlqqP/ZJBOrp5BiG3tfe3uBg7QpivH9SBdIk7yL51lE2iTeWoxJKphgX1KJ1k2H
 7KxdfforEZFEheUkbaEnU0Mmh41NmDI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-mXKfchJAPo2W0Vh5LsQm_Q-1; Tue, 29 Aug 2023 17:42:41 -0400
X-MC-Unique: mXKfchJAPo2W0Vh5LsQm_Q-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-410a3a86a88so14248051cf.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 14:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693345361; x=1693950161;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VBJUvVKr9ywnzsnevPjeEHCHeGxc9AC8Z+wZG3cb7nU=;
 b=AFbny35MTi8rdWQRz7XZttKRQKbiaHDL3NzAdLoPeOatvXccUKlviAIXouaFjeppik
 ZBhg3lJEbthoRtsrrMfPOjB00H3H51u6lpPDiHOvZWhokFXOLo59c4EbC+0c6dsi2jGY
 qMg1NHqm4JpO/NgZS8rjfGCRYbkXIDh2bSKT9JPdIyN+fA2xdcj5jaNjQna4R4HarJMs
 twENB01nrFCmPOcTDu903WTGHEOuwYYEw6zQkA2BIkJqiH8h3xJ2zd+OWqqBnXPUYpXo
 nbFK2AKq0e1N0uV+DTL7CwXi+LIX5UNXScgkFuoZkOTUfcnQPH/FqRZLwYkUIqpcWJgU
 009A==
X-Gm-Message-State: AOJu0YwwHE2raeDGGwKD6eUJ8lck2EpmyRxpTQdXKwIbVtRw/MTi+5G0
 K3cn+JrMckTiNwDYUAF6prSERqsEPc2Bh9yqUlDkQdfAngqJjz74jI2IttMOl9B3rGwCofvwpFg
 RVJeiQtmLEyC7tHaue1BdTXT8pgPDWSBM3/LF9zHjm+27uWVhipMcrGWZvFWnj6z8aZOo72oz
X-Received: by 2002:a05:622a:1a9a:b0:412:d46:a8df with SMTP id
 s26-20020a05622a1a9a00b004120d46a8dfmr336878qtc.1.1693345361210; 
 Tue, 29 Aug 2023 14:42:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJBSUGxJ13pa6PoF3G+tqFQH83862AxvTlhOEgGJFohSAnoAm1NC1Z08PfXv4InYYcHPAm/g==
X-Received: by 2002:a05:622a:1a9a:b0:412:d46:a8df with SMTP id
 s26-20020a05622a1a9a00b004120d46a8dfmr336857qtc.1.1693345360808; 
 Tue, 29 Aug 2023 14:42:40 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 b18-20020ac86bd2000000b0040f8ac751a5sm3260343qtt.96.2023.08.29.14.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 14:42:39 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH 2/9] migration: Let migrate_set_error() take ownership
Date: Tue, 29 Aug 2023 17:42:28 -0400
Message-ID: <20230829214235.69309-3-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829214235.69309-1-peterx@redhat.com>
References: <20230829214235.69309-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URG_BIZ=0.573 autolearn=no autolearn_force=no
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

migrate_set_error() used one error_copy() so it always copy an error.
However that's not the major use case - the major use case is one would
like to pass the error to migrate_set_error() without further touching the
error.

It can be proved if we see most of the callers are freeing the error
explicitly right afterwards.  There're a few outliers (only if when the
caller) where we can use error_copy() explicitly there.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h    |  4 ++--
 migration/channel.c      |  1 -
 migration/migration.c    | 22 ++++++++++++++++------
 migration/multifd.c      | 10 ++++------
 migration/postcopy-ram.c |  1 -
 migration/ram.c          |  1 -
 6 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 6eea18db36..76e35a5ecf 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -465,7 +465,7 @@ bool  migration_has_all_channels(void);
 
 uint64_t migrate_max_downtime(void);
 
-void migrate_set_error(MigrationState *s, const Error *error);
+void migrate_set_error(MigrationState *s, Error *error);
 
 void migrate_fd_connect(MigrationState *s, Error *error_in);
 
@@ -510,7 +510,7 @@ int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
 void migration_make_urgent_request(void);
 void migration_consume_urgent_request(void);
 bool migration_rate_limit(void);
-void migration_cancel(const Error *error);
+void migration_cancel(Error *error);
 
 void populate_vfio_info(MigrationInfo *info);
 void reset_vfio_bytes_transferred(void);
diff --git a/migration/channel.c b/migration/channel.c
index ca3319a309..48b3f6abd6 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -90,7 +90,6 @@ void migration_channel_connect(MigrationState *s,
         }
     }
     migrate_fd_connect(s, error);
-    error_free(error);
 }
 
 
diff --git a/migration/migration.c b/migration/migration.c
index c60064d48e..0f3ca168ed 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -162,7 +162,7 @@ void migration_object_init(void)
     dirty_bitmap_mig_init();
 }
 
-void migration_cancel(const Error *error)
+void migration_cancel(Error *error)
 {
     if (error) {
         migrate_set_error(current_migration, error);
@@ -1218,11 +1218,22 @@ static void migrate_fd_cleanup_bh(void *opaque)
     object_unref(OBJECT(s));
 }
 
-void migrate_set_error(MigrationState *s, const Error *error)
+/*
+ * Set error for current migration state.  The `error' ownership will be
+ * moved from the caller to MigrationState, so the caller doesn't need to
+ * free the error.
+ *
+ * If the caller still needs to reference the `error' passed in, one should
+ * use error_copy() explicitly.
+ */
+void migrate_set_error(MigrationState *s, Error *error)
 {
     QEMU_LOCK_GUARD(&s->error_mutex);
     if (!s->error) {
-        s->error = error_copy(error);
+        /* Record the first error triggered */
+        s->error = error;
+    } else {
+        error_free(error);
     }
 }
 
@@ -1235,7 +1246,7 @@ static void migrate_error_free(MigrationState *s)
     }
 }
 
-static void migrate_fd_error(MigrationState *s, const Error *error)
+static void migrate_fd_error(MigrationState *s, Error *error)
 {
     trace_migrate_fd_error(error_get_pretty(error));
     assert(s->to_dst_file == NULL);
@@ -1703,7 +1714,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         if (!resume_requested) {
             yank_unregister_instance(MIGRATION_YANK_INSTANCE);
         }
-        migrate_fd_error(s, local_err);
+        migrate_fd_error(s, error_copy(local_err));
         error_propagate(errp, local_err);
         return;
     }
@@ -2626,7 +2637,6 @@ static MigThrError migration_detect_error(MigrationState *s)
 
     if (local_error) {
         migrate_set_error(s, local_error);
-        error_free(local_error);
     }
 
     if (state == MIGRATION_STATUS_POSTCOPY_ACTIVE && ret) {
diff --git a/migration/multifd.c b/migration/multifd.c
index 0f6b203877..69d56104fb 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -551,7 +551,6 @@ void multifd_save_cleanup(void)
         multifd_send_state->ops->send_cleanup(p, &local_err);
         if (local_err) {
             migrate_set_error(migrate_get_current(), local_err);
-            error_free(local_err);
         }
     }
     qemu_sem_destroy(&multifd_send_state->channels_ready);
@@ -750,7 +749,6 @@ out:
     if (local_err) {
         trace_multifd_send_error(p->id);
         multifd_send_terminate_threads(local_err);
-        error_free(local_err);
     }
 
     /*
@@ -883,7 +881,6 @@ static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
       */
      p->quit = true;
      object_unref(OBJECT(ioc));
-     error_free(err);
 }
 
 static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
@@ -1148,7 +1145,6 @@ static void *multifd_recv_thread(void *opaque)
 
     if (local_err) {
         multifd_recv_terminate_threads(local_err);
-        error_free(local_err);
     }
     qemu_mutex_lock(&p->mutex);
     p->running = false;
@@ -1240,7 +1236,8 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
 
     id = multifd_recv_initial_packet(ioc, &local_err);
     if (id < 0) {
-        multifd_recv_terminate_threads(local_err);
+        /* Copy local error because we'll also return it to caller */
+        multifd_recv_terminate_threads(error_copy(local_err));
         error_propagate_prepend(errp, local_err,
                                 "failed to receive packet"
                                 " via multifd channel %d: ",
@@ -1253,7 +1250,8 @@ void multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
     if (p->c != NULL) {
         error_setg(&local_err, "multifd: received id '%d' already setup'",
                    id);
-        multifd_recv_terminate_threads(local_err);
+        /* Copy local error because we'll also return it to caller */
+        multifd_recv_terminate_threads(error_copy(local_err));
         error_propagate(errp, local_err);
         return;
     }
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 29aea9456d..8a93b5504d 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1594,7 +1594,6 @@ postcopy_preempt_send_channel_done(MigrationState *s,
 {
     if (local_err) {
         migrate_set_error(s, local_err);
-        error_free(local_err);
     } else {
         migration_ioc_register_yank(ioc);
         s->postcopy_qemufile_src = qemu_file_new_output(ioc);
diff --git a/migration/ram.c b/migration/ram.c
index 9040d66e61..fc7fe0e6e8 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4308,7 +4308,6 @@ static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
          */
         error_setg(&err, "RAM block '%s' resized during precopy.", rb->idstr);
         migration_cancel(err);
-        error_free(err);
     }
 
     switch (ps) {
-- 
2.41.0


