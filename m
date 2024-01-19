Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D46968331A1
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 00:41:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQySZ-000212-Dd; Fri, 19 Jan 2024 18:39:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQySW-000204-Jm
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:39:36 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQySU-00020l-IA
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:39:36 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5371221C1A;
 Fri, 19 Jan 2024 23:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705707573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fkHkzmdwq/6uDzdosteMOe6B7nHrQfR82f31Xr75Ng4=;
 b=dq2VhEe28oNsjcxIRgSKTozjufdcAIMC2LX+Im0vosNCJNPN0oEV6Awr7eNxo8Vlz8XEFG
 I2fwDkcu+OexJXPH5/4ivWeRjacPm36O+biZteBxYnKITiImeqbzZr16Xx4S5e1U9XAGmy
 /1IqlPJYM3oE4Uo1+IuJuvxLa6SBilc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705707573;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fkHkzmdwq/6uDzdosteMOe6B7nHrQfR82f31Xr75Ng4=;
 b=fd2tVoZAh2e4P5OEDretzQxMEU9DM8qotp2fD5Rb5F8PanXIMwqb2RtA5kXKKIteO/8RsQ
 x6i6yL1U6UWSeWCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705707573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fkHkzmdwq/6uDzdosteMOe6B7nHrQfR82f31Xr75Ng4=;
 b=dq2VhEe28oNsjcxIRgSKTozjufdcAIMC2LX+Im0vosNCJNPN0oEV6Awr7eNxo8Vlz8XEFG
 I2fwDkcu+OexJXPH5/4ivWeRjacPm36O+biZteBxYnKITiImeqbzZr16Xx4S5e1U9XAGmy
 /1IqlPJYM3oE4Uo1+IuJuvxLa6SBilc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705707573;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fkHkzmdwq/6uDzdosteMOe6B7nHrQfR82f31Xr75Ng4=;
 b=fd2tVoZAh2e4P5OEDretzQxMEU9DM8qotp2fD5Rb5F8PanXIMwqb2RtA5kXKKIteO/8RsQ
 x6i6yL1U6UWSeWCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 633771375D;
 Fri, 19 Jan 2024 23:39:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WCinCjQIq2VxVAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 19 Jan 2024 23:39:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH 5/5] migration: Centralize BH creation and dispatch
Date: Fri, 19 Jan 2024 20:39:22 -0300
Message-Id: <20240119233922.32588-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240119233922.32588-1-farosas@suse.de>
References: <20240119233922.32588-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dq2VhEe2;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fd2tVoZA
X-Spamd-Result: default: False [1.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.69
X-Rspamd-Queue-Id: 5371221C1A
X-Spamd-Bar: +
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, URG_BIZ=0.573 autolearn=ham autolearn_force=no
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

Now that the migration state reference counting is correct, further
wrap the bottom half dispatch process to avoid future issues.

Move BH creation and scheduling together and wrap the dispatch with an
intermediary function that will ensure we always keep the ref/unref
balanced.

Also move the responsibility of deleting the BH into the wrapper and
remove the now unnecessary pointers.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 65 +++++++++++++++++++++++++------------------
 migration/migration.h |  5 +---
 migration/savevm.c    |  7 +----
 3 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 0e7f101d64..d5f705ceef 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -199,8 +199,39 @@ void migration_object_init(void)
     dirty_bitmap_mig_init();
 }
 
-static void migration_bh_schedule(MigrationState *s, QEMUBH *bh)
+typedef struct {
+    QEMUBH *bh;
+    QEMUBHFunc *cb;
+    void *opaque;
+} MigrationBH;
+
+static void migration_bh_dispatch_bh(void *opaque)
 {
+    MigrationState *s = migrate_get_current();
+    MigrationBH *migbh = opaque;
+
+    /* cleanup this BH */
+    qemu_bh_delete(migbh->bh);
+    migbh->bh = NULL;
+
+    /* dispatch the other one */
+    migbh->cb(migbh->opaque);
+    object_unref(OBJECT(s));
+
+    g_free(migbh);
+}
+
+void migration_bh_schedule(QEMUBHFunc *cb, void *opaque)
+{
+    MigrationState *s = migrate_get_current();
+    MigrationBH *migbh = g_new0(MigrationBH, 1);
+    QEMUBH *bh = qemu_bh_new(migration_bh_dispatch_bh, migbh);
+
+    /* Store these to dispatch when the BH runs */
+    migbh->bh = bh;
+    migbh->cb = cb;
+    migbh->opaque = opaque;
+
     /*
      * Ref the state for bh, because it may be called when
      * there're already no other refs
@@ -656,9 +687,7 @@ static void process_incoming_migration_bh(void *opaque)
      */
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_COMPLETED);
-    qemu_bh_delete(mis->bh);
     migration_incoming_state_destroy();
-    object_unref(OBJECT(migrate_get_current()));
 }
 
 static void coroutine_fn
@@ -723,8 +752,7 @@ process_incoming_migration_co(void *opaque)
         goto fail;
     }
 
-    mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
-    migration_bh_schedule(migrate_get_current(), mis->bh);
+    migration_bh_schedule(process_incoming_migration_bh, mis);
     return;
 fail:
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
@@ -1285,9 +1313,6 @@ void migrate_set_state(int *state, int old_state, int new_state)
 
 static void migrate_fd_cleanup(MigrationState *s)
 {
-    qemu_bh_delete(s->cleanup_bh);
-    s->cleanup_bh = NULL;
-
     g_free(s->hostname);
     s->hostname = NULL;
     json_writer_free(s->vmdesc);
@@ -1343,9 +1368,7 @@ static void migrate_fd_cleanup(MigrationState *s)
 
 static void migrate_fd_cleanup_bh(void *opaque)
 {
-    MigrationState *s = opaque;
-    migrate_fd_cleanup(s);
-    object_unref(OBJECT(s));
+    migrate_fd_cleanup(opaque);
 }
 
 void migrate_set_error(MigrationState *s, const Error *error)
@@ -1568,8 +1591,6 @@ int migrate_init(MigrationState *s, Error **errp)
      * parameters/capabilities that the user set, and
      * locks.
      */
-    s->cleanup_bh = 0;
-    s->vm_start_bh = 0;
     s->to_dst_file = NULL;
     s->state = MIGRATION_STATUS_NONE;
     s->rp_state.from_dst_file = NULL;
@@ -3139,7 +3160,8 @@ static void migration_iteration_finish(MigrationState *s)
         error_report("%s: Unknown ending state %d", __func__, s->state);
         break;
     }
-    migration_bh_schedule(s, s->cleanup_bh);
+
+    migration_bh_schedule(migrate_fd_cleanup_bh, s);
     bql_unlock();
 }
 
@@ -3170,7 +3192,7 @@ static void bg_migration_iteration_finish(MigrationState *s)
         break;
     }
 
-    migration_bh_schedule(s, s->cleanup_bh);
+    migration_bh_schedule(migrate_fd_cleanup_bh, s);
     bql_unlock();
 }
 
@@ -3376,12 +3398,8 @@ static void bg_migration_vm_start_bh(void *opaque)
 {
     MigrationState *s = opaque;
 
-    qemu_bh_delete(s->vm_start_bh);
-    s->vm_start_bh = NULL;
-
     vm_resume(s->vm_old_state);
     migration_downtime_end(s);
-    object_unref(OBJECT(s));
 }
 
 /**
@@ -3485,8 +3503,7 @@ static void *bg_migration_thread(void *opaque)
      * calling VM state change notifiers from vm_start() would initiate
      * writes to virtio VQs memory which is in write-protected region.
      */
-    s->vm_start_bh = qemu_bh_new(bg_migration_vm_start_bh, s);
-    migration_bh_schedule(s, s->vm_start_bh);
+    migration_bh_schedule(bg_migration_vm_start_bh, s);
     bql_unlock();
 
     while (migration_is_active(s)) {
@@ -3542,12 +3559,6 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
     migrate_error_free(s);
 
     s->expected_downtime = migrate_downtime_limit();
-    if (resume) {
-        assert(s->cleanup_bh);
-    } else {
-        assert(!s->cleanup_bh);
-        s->cleanup_bh = qemu_bh_new(migrate_fd_cleanup_bh, s);
-    }
     if (error_in) {
         migrate_fd_error(s, error_in);
         if (resume) {
diff --git a/migration/migration.h b/migration/migration.h
index 17972dac34..db98979e6e 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -159,8 +159,6 @@ struct MigrationIncomingState {
     /* PostCopyFD's for external userfaultfds & handlers of shared memory */
     GArray   *postcopy_remote_fds;
 
-    QEMUBH *bh;
-
     int state;
 
     /*
@@ -255,8 +253,6 @@ struct MigrationState {
 
     /*< public >*/
     QemuThread thread;
-    QEMUBH *vm_start_bh;
-    QEMUBH *cleanup_bh;
     /* Protected by qemu_file_lock */
     QEMUFile *to_dst_file;
     /* Postcopy specific transfer channel */
@@ -528,6 +524,7 @@ int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
 void migration_make_urgent_request(void);
 void migration_consume_urgent_request(void);
 bool migration_rate_limit(void);
+void migration_bh_schedule(QEMUBHFunc *cb, void *opaque);
 void migration_cancel(const Error *error);
 
 void migration_populate_vfio_info(MigrationInfo *info);
diff --git a/migration/savevm.c b/migration/savevm.c
index 93387350c7..d612c8a902 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2171,10 +2171,7 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
         runstate_set(RUN_STATE_PAUSED);
     }
 
-    qemu_bh_delete(mis->bh);
-
     trace_vmstate_downtime_checkpoint("dst-postcopy-bh-vm-started");
-    object_unref(OBJECT(migration_get_current()));
 }
 
 /* After all discards we can start running and asking for pages */
@@ -2189,9 +2186,7 @@ static int loadvm_postcopy_handle_run(MigrationIncomingState *mis)
     }
 
     postcopy_state_set(POSTCOPY_INCOMING_RUNNING);
-    mis->bh = qemu_bh_new(loadvm_postcopy_handle_run_bh, mis);
-    object_ref(OBJECT(migration_get_current()));
-    qemu_bh_schedule(mis->bh);
+    migration_bh_schedule(loadvm_postcopy_handle_run_bh, mis);
 
     /* We need to finish reading the stream from the package
      * and also stop reading anything more from the stream that loaded the
-- 
2.35.3


