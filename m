Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA87748955
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 18:37:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH5TO-0001dP-2Z; Wed, 05 Jul 2023 12:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qH5TE-0001Vv-Jx
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 12:35:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qH5TC-0003bE-F8
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 12:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688574908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tJRTau+SR09fXAE0IlyF/GqILORZ33ahEu2EbKHFPQo=;
 b=f9j+ri25+951RhEtFNaJHPntHDdqOFcRP5iqaYsRXXMhM5icNG65mINU9vW2PcHt2c2soS
 wEhf5P3pD3Sa2eLAtuY7nkH9Hq5K7Y4U5ow8SDflD+YQVTZv5+y0q5eBsQ3wqy/NYXZgR3
 wn1/9Cd0Ddd4MY+AKP1xGkepdGQna9g=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-sfNr0H41OoCrH25r1n7Pfg-1; Wed, 05 Jul 2023 12:35:06 -0400
X-MC-Unique: sfNr0H41OoCrH25r1n7Pfg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7673887b2cfso189624185a.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 09:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688574906; x=1691166906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tJRTau+SR09fXAE0IlyF/GqILORZ33ahEu2EbKHFPQo=;
 b=Dviu/bs4AOg+52U3S9Wswe34Uuig90BNBsRMOWnQDnCG3HYwTVnXy+B9sD1Fe9lT7z
 8ySKsJZJ1h5DlkhIQimevVT7AY/ixy5E9xqj31Sm4OOVXX0+Pl51OHNnjSWTiyh41Xf5
 xOi3eBz+W0cm5g7/ybx5Amy30HhI8khzBGfDey1jUkRMA9kQDWSFrOTdZx0Ct2HtU+96
 yiEOThUTkP14uZlF5GzD/ts4RkkWVte7oo6QkMoUHt+4VnsHhhSCWjpWn5bWd7nmSWh5
 Ymgv6BnUwJW4qvpp8qkO3csdWEuVmxUozvu159KPF/BliZ8xJOvvjbjhrQmZbUgDcZim
 IHyA==
X-Gm-Message-State: AC+VfDyffUdHfFekaX6CSYuFx/NE+T/b3LLw+CyaE9X2Zkpp6vIP6piE
 J5yQQoCsRPQC7uTGdr5AobatYalVjku5LecP3kvkD9tqEWVyavfhqN0Fn0AJI/fbBw60xxGLopD
 NGppS0+JEwvJHQAliebQdmEfOtU0ZwRJaehxjTijodIrbwxV3W27ODmb0PzwLkmcwSaC/G0/k
X-Received: by 2002:a05:620a:4010:b0:766:3190:8052 with SMTP id
 h16-20020a05620a401000b0076631908052mr22819750qko.0.1688574905916; 
 Wed, 05 Jul 2023 09:35:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5/5QepMsRaPcTYSamgqdNA9EMTX/3m4ncTXj7rRq2vMcJjLpwUZckBnx4pnMxoPKiQLcWwaQ==
X-Received: by 2002:a05:620a:4010:b0:766:3190:8052 with SMTP id
 h16-20020a05620a401000b0076631908052mr22819725qko.0.1688574905521; 
 Wed, 05 Jul 2023 09:35:05 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 x19-20020a05620a12b300b007620b03ee65sm6760094qki.37.2023.07.05.09.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 09:35:05 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Laszlo Ersek <lersek@redhat.com>,
 peterx@redhat.com
Subject: [PATCH v2 2/7] migration: Let migrate_set_error() take ownership
Date: Wed,  5 Jul 2023 12:34:57 -0400
Message-ID: <20230705163502.331007-3-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705163502.331007-1-peterx@redhat.com>
References: <20230705163502.331007-1-peterx@redhat.com>
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
index 6b31a4b371..507f2f111e 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -482,8 +482,8 @@ bool  migration_has_all_channels(void);
 
 uint64_t migrate_max_downtime(void);
 
-void migrate_set_error(MigrationState *s, const Error *error);
-void migrate_fd_error(MigrationState *s, const Error *error);
+void migrate_set_error(MigrationState *s, Error *error);
+void migrate_fd_error(MigrationState *s, Error *error);
 
 void migrate_fd_connect(MigrationState *s, Error *error_in);
 
@@ -528,7 +528,7 @@ int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
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
index 6a4c245f74..e5d207699b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -161,7 +161,7 @@ void migration_object_init(void)
     dirty_bitmap_mig_init();
 }
 
-void migration_cancel(const Error *error)
+void migration_cancel(Error *error)
 {
     if (error) {
         migrate_set_error(current_migration, error);
@@ -1205,11 +1205,20 @@ static void migrate_fd_cleanup_bh(void *opaque)
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
 
@@ -1222,7 +1231,7 @@ static void migrate_error_free(MigrationState *s)
     }
 }
 
-void migrate_fd_error(MigrationState *s, const Error *error)
+void migrate_fd_error(MigrationState *s, Error *error)
 {
     trace_migrate_fd_error(error_get_pretty(error));
     assert(s->to_dst_file == NULL);
@@ -1688,7 +1697,7 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
         if (!(has_resume && resume)) {
             yank_unregister_instance(MIGRATION_YANK_INSTANCE);
         }
-        migrate_fd_error(s, local_err);
+        migrate_fd_error(s, error_copy(local_err));
         error_propagate(errp, local_err);
         return;
     }
@@ -2611,7 +2620,6 @@ static MigThrError migration_detect_error(MigrationState *s)
 
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


