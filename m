Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F5F741B25
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 23:51:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEd3M-0001IV-0f; Wed, 28 Jun 2023 17:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEd3C-0001IG-L2
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:50:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEd3A-0008Nz-Ny
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:50:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687989007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D0szFsKgCaXfzNnfYBqomvWHvj0fu1RIdHWfouYlejg=;
 b=T5x8ENkK1djTRJBLRpoRoCCISuo/10AwPWybAj8A6YNxUKH1W0kAnDjXPqXNiX8OqgrzyL
 4MArrpUL46jAlRuTWIuAhWgJ4s1C39XHW8JHlfrwPIOaHmAJhNtBgxbHzIBjYAieyPDWNY
 L6XnaDPHcScn9BIQNwhKZ7zX8RswHPs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-HPj_j3ZaPXCBZL8HGcMgcA-1; Wed, 28 Jun 2023 17:50:06 -0400
X-MC-Unique: HPj_j3ZaPXCBZL8HGcMgcA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-40234d83032so14791cf.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 14:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687989005; x=1690581005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D0szFsKgCaXfzNnfYBqomvWHvj0fu1RIdHWfouYlejg=;
 b=csc8iQfq3uP0VBRqmrYV354rUk+xgbJM7wNdA4w9Bsv6vqcjUlbGf+l8A0ZnFLwf38
 NEynlT/KHEtwsFxN15X5xiE7reZJ46qlH+o5tv+EeSRXP/+7xEiZWUjFmWL+hajQwv24
 ENVyvrxm86f9iTptZcS5mKbiXxvyRPais8BMkciE16WGElYy6TKv1OjQQoEq3prr6hJH
 6lEs8mNZkrGraSpvt93/avm3WxFgBjpPyQOh7g1yvjFp1QvLOdfGE/9qHoTn/QMo1Efr
 jOUxAM0ms0iwauww949JXtU1Pduar1BxQqUyf2hD7o50zOt5WUVWCoWRo+CDvxqB1YB7
 sXVA==
X-Gm-Message-State: AC+VfDwChvbcjZ/saXfWcavl0a5wVeOJhdMcRw+UUCFr/9FaKYd5mhZ4
 BRpInbLI7WUy1Ff18w+0lfBbGHm5nZIoVdm1P/Ft2eHaQa1dBzmQsB+LKWBKQuEuWZ/mgtr6Ec/
 3ZFLIPCpOi2l1xPi9eZbA+dKR38PwBVHVdjWyX+6dWik7yFpajV8dnMPYREo5LRNOJK8wmx+P
X-Received: by 2002:ac8:7f83:0:b0:400:9ed9:7267 with SMTP id
 z3-20020ac87f83000000b004009ed97267mr11305956qtj.3.1687989005434; 
 Wed, 28 Jun 2023 14:50:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5RnA39EARoMo8Nbasr27H2y8YkDbDkjQKngBpWjqhPLpBytNv1iuw/uIHSmjv+8a+8/M6JVA==
X-Received: by 2002:ac8:7f83:0:b0:400:9ed9:7267 with SMTP id
 z3-20020ac87f83000000b004009ed97267mr11305939qtj.3.1687989005024; 
 Wed, 28 Jun 2023 14:50:05 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 w29-20020ac84d1d000000b004032d9209a0sm255552qtv.50.2023.06.28.14.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 14:50:04 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH 1/7] migration: Let migrate_set_error() take ownership
Date: Wed, 28 Jun 2023 17:49:56 -0400
Message-ID: <20230628215002.73546-2-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628215002.73546-1-peterx@redhat.com>
References: <20230628215002.73546-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h    |  6 +++---
 migration/channel.c      |  1 -
 migration/migration.c    | 20 ++++++++++++++------
 migration/multifd.c      | 10 ++++------
 migration/postcopy-ram.c |  1 -
 migration/ram.c          |  1 -
 6 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 721b1c9473..32f87e3834 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -468,8 +468,8 @@ bool  migration_has_all_channels(void);
 
 uint64_t migrate_max_downtime(void);
 
-void migrate_set_error(MigrationState *s, const Error *error);
-void migrate_fd_error(MigrationState *s, const Error *error);
+void migrate_set_error(MigrationState *s, Error *error);
+void migrate_fd_error(MigrationState *s, Error *error);
 
 void migrate_fd_connect(MigrationState *s, Error *error_in);
 
@@ -513,7 +513,7 @@ int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
 void migration_make_urgent_request(void);
 void migration_consume_urgent_request(void);
 bool migration_rate_limit(void);
-void migration_cancel(const Error *error);
+void migration_cancel(Error *error);
 
 void populate_vfio_info(MigrationInfo *info);
 void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
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
index 203d40d4c9..13dccc4c12 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -160,7 +160,7 @@ void migration_object_init(void)
     dirty_bitmap_mig_init();
 }
 
-void migration_cancel(const Error *error)
+void migration_cancel(Error *error)
 {
     if (error) {
         migrate_set_error(current_migration, error);
@@ -1197,11 +1197,20 @@ static void migrate_fd_cleanup_bh(void *opaque)
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
     }
 }
 
@@ -1214,7 +1223,7 @@ static void migrate_error_free(MigrationState *s)
     }
 }
 
-void migrate_fd_error(MigrationState *s, const Error *error)
+void migrate_fd_error(MigrationState *s, Error *error)
 {
     trace_migrate_fd_error(error_get_pretty(error));
     assert(s->to_dst_file == NULL);
@@ -1678,7 +1687,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         if (!(has_resume && resume)) {
             yank_unregister_instance(MIGRATION_YANK_INSTANCE);
         }
-        migrate_fd_error(s, local_err);
+        migrate_fd_error(s, error_copy(local_err));
         error_propagate(errp, local_err);
         return;
     }
@@ -2595,7 +2604,6 @@ static MigThrError migration_detect_error(MigrationState *s)
 
     if (local_error) {
         migrate_set_error(s, local_error);
-        error_free(local_error);
     }
 
     if (state == MIGRATION_STATUS_POSTCOPY_ACTIVE && ret) {
diff --git a/migration/multifd.c b/migration/multifd.c
index 3387d8277f..62bc2dbf49 100644
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
index 5615ec29eb..6f6fb52bf1 100644
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
index 5283a75f02..ba4890563d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4267,7 +4267,6 @@ static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
          */
         error_setg(&err, "RAM block '%s' resized during precopy.", rb->idstr);
         migration_cancel(err);
-        error_free(err);
     }
 
     switch (ps) {
-- 
2.41.0


