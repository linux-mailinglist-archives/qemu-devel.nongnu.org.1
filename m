Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E77979DBDB
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 00:23:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgBld-0007oR-Gt; Tue, 12 Sep 2023 18:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgBlb-0007lz-60
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:21:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgBlY-0003H2-Bx
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694557311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3gOUX6Fqs7kwRjqFLtp8oxY2w4IFXK1WS15a0m7KLJc=;
 b=RhSBx92k7HwVE9FBLqg9wQOLlEZ6TniiR93UNj+8TqbAiMp2d3hMHS8IKgkFYNF0DT4ujz
 lynBjE8GC+BuyL5v4AvItUEQ32/5hMNWUc3p/oTj3VGVLplo6YB+RDfpVHBcibaY91wFuX
 vC7kWa0mJULmCAeVAddUdisDtmBreXs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-ykkTrRAzNCuRCRAcPzZrmA-1; Tue, 12 Sep 2023 18:21:50 -0400
X-MC-Unique: ykkTrRAzNCuRCRAcPzZrmA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-76f025ed860so93067885a.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 15:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694557309; x=1695162109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3gOUX6Fqs7kwRjqFLtp8oxY2w4IFXK1WS15a0m7KLJc=;
 b=b4IP1R5WgBwowguo2MgppyqTdc8qeciED5XjpiRLRSbNUAhIPOo0D2w3uxsQtlTAWf
 MjLes6LaPQFaCegJsUv0vFjFLqDY7LOwCcaTw0L2yRcfqCtmneCm0xNEfCNCK+GWwv2b
 QqGKdcUeG2c734RsbyaPXYQXWoP1y92cH16UY8XTy83fLs6tjo3X6Znp6xfblhoVHyhH
 shVDrl+aMEhAG2A4ea9ieHpCnj/ORYlfyMPubLUrQX9F/RFcYAiIigc9OABVxmOwV0j3
 t2wK8PXv5OqN/9vl1WlGcEQvRRNxiV7ZXtfAIObeUV2ITLi5teB3zrlrYEB1bke17hDP
 brZw==
X-Gm-Message-State: AOJu0Yxe9VoP7kFO8DczDhsWM4GFhpbOrxO55bnRRNYS0faMVfd9y4Y0
 nN3QOQRzeES6vwP+8A4ErS9AXroZBJA/FzFw0qtAkIWHwgS5uoBhZp7rm68FGS+rLqZDyxJiP7W
 iOiIoJxBW4ylmpHbe+YOPm4ZivBrbQhCUwx9K8NR5DdK12plFW/7syEEG0ItdhCCZBg4hhKGM
X-Received: by 2002:a05:620a:192a:b0:76f:1846:2f6b with SMTP id
 bj42-20020a05620a192a00b0076f18462f6bmr774229qkb.1.1694557309465; 
 Tue, 12 Sep 2023 15:21:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER/cHaKCkXCQ8rNkHTCP+dXnw7bnRTAiqPiFQSmup+2C4nRuYypDmiVytFckFwDAEHOQ28xQ==
X-Received: by 2002:a05:620a:192a:b0:76f:1846:2f6b with SMTP id
 bj42-20020a05620a192a00b0076f18462f6bmr774212qkb.1.1694557309147; 
 Tue, 12 Sep 2023 15:21:49 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a05620a136500b0076f206cf16fsm3494272qkl.89.2023.09.12.15.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 15:21:48 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 02/11] migration: Let migrate_set_error() take ownership
Date: Tue, 12 Sep 2023 18:21:36 -0400
Message-ID: <20230912222145.731099-3-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912222145.731099-1-peterx@redhat.com>
References: <20230912222145.731099-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Drop three call sites where we called migrate_set_error() then following a
error_report_err(): otherwise we need to do error_copy() for them. Since we
already have them stored in MigrationState.error, the error report can be
slightly duplicated.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h    |  4 ++--
 migration/channel.c      |  1 -
 migration/migration.c    | 25 ++++++++++++++++---------
 migration/multifd.c      | 10 ++++------
 migration/postcopy-ram.c |  1 -
 migration/ram.c          |  1 -
 6 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index c390500604..1eefa563c4 100644
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
 
 void migration_populate_vfio_info(MigrationInfo *info);
 void migration_reset_vfio_bytes_transferred(void);
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
index 61e91f61af..4b4dba5b12 100644
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
@@ -1714,7 +1725,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         if (!resume_requested) {
             yank_unregister_instance(MIGRATION_YANK_INSTANCE);
         }
-        migrate_fd_error(s, local_err);
+        migrate_fd_error(s, error_copy(local_err));
         error_propagate(errp, local_err);
         return;
     }
@@ -2637,7 +2648,6 @@ static MigThrError migration_detect_error(MigrationState *s)
 
     if (local_error) {
         migrate_set_error(s, local_error);
-        error_free(local_error);
     }
 
     if (state == MIGRATION_STATUS_POSTCOPY_ACTIVE && ret) {
@@ -2789,7 +2799,6 @@ static MigIterateState migration_iteration_run(MigrationState *s)
         qatomic_read(&s->start_postcopy)) {
         if (postcopy_start(s, &local_err)) {
             migrate_set_error(s, local_err);
-            error_report_err(local_err);
         }
         return MIG_ITERATE_SKIP;
     }
@@ -3283,7 +3292,6 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
             error_setg(&local_err, "Unable to open return-path for postcopy");
             migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
             migrate_set_error(s, local_err);
-            error_report_err(local_err);
             migrate_fd_cleanup(s);
             return;
         }
@@ -3308,7 +3316,6 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
 
     if (multifd_save_setup(&local_err) != 0) {
         migrate_set_error(s, local_err);
-        error_report_err(local_err);
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_FAILED);
         migrate_fd_cleanup(s);
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


