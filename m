Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 571A278CFFA
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:09:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nT-00012S-Di; Tue, 29 Aug 2023 19:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qb6UC-0006Nb-CL
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:42:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qb6U9-0000iW-BX
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693345371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zteSUqlE0a6VOFukitMAWaR/lKfpKDlrLDgCs8ahJek=;
 b=eexQLTgtt/Ebb59dr+vOic8xOOdW8SfXIBQB1QFcjmC0dc3IGQLvlFw/uqXzSPVc5iEB7X
 PkP5QDoDl0DW7Jq6MXxXgdh6kC8OkUK9MzxDeE/3/tncC2sLwMv1F8NoX7bGZWeiHRms7k
 3omgQPhJsGv/HVbS2c4LLZAG78vq1KU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-INFzGFbWPVii9TVRj4ag3w-1; Tue, 29 Aug 2023 17:42:49 -0400
X-MC-Unique: INFzGFbWPVii9TVRj4ag3w-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4122babcb87so7518421cf.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 14:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693345369; x=1693950169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zteSUqlE0a6VOFukitMAWaR/lKfpKDlrLDgCs8ahJek=;
 b=Hdc+l7AJVcpaXaX42hwwwxvc2cUT3EcmvNgrTsYLC6geLATPOng1wUhwmFhLnpO6aZ
 nebVCfR/3MFI8/43BaCSMX8BjT1hUtcsVmSEXg5h7S0EoucDrnCtdOFCOoMw0tqQwwkF
 FDKRnlmZocCTQIh7OQdqRsZelTSVtvfyDLIac3hwBMJhEq1bNftjZvoYe4eHlmW6gp8g
 DFXvuKdh0S5z9z/xuhH/lYVD3l1DU5q4m9oYv/Ndidv/UpARpTWqZXA8UhHdxCso6AmG
 trZmGEOKxYoBFq5ELOj3VL2oxRIBjWu7kjEq7q0+iYavhdoJtiSepItHusOTDYrzIwnP
 nukA==
X-Gm-Message-State: AOJu0Yx79mBg79WmZjrRtu9AW/BZ38v1VGMiz7SK9zkSN5TpxjlIYi8K
 7jMWsV4jjYmrAHEof540frwYBGMcLfTTUm4HKUme/MnA+xxUjDYo9SrESPq8i0PbeABzwFJyhS0
 K9VjCCLuExGX5bc2stdBWJiJuzVpQDIhQSbni37sb+yr6W6XajX4FXK0R3Q4IlopHRQMcQCw/
X-Received: by 2002:a05:622a:1aa7:b0:410:88c6:cf22 with SMTP id
 s39-20020a05622a1aa700b0041088c6cf22mr277769qtc.3.1693345369177; 
 Tue, 29 Aug 2023 14:42:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA0ftwYLI4iRLFR4mGW4VB7ycMR7YKIw6u4g6lJirVZ2y4Q4J+lxYIrougk2AwZ8XHdu3iEQ==
X-Received: by 2002:a05:622a:1aa7:b0:410:88c6:cf22 with SMTP id
 s39-20020a05622a1aa700b0041088c6cf22mr277741qtc.3.1693345368684; 
 Tue, 29 Aug 2023 14:42:48 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 b18-20020ac86bd2000000b0040f8ac751a5sm3260343qtt.96.2023.08.29.14.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 14:42:48 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>, Xiaohui Li <xiaohli@redhat.com>
Subject: [PATCH 9/9] migration/postcopy: Allow network to fail even during
 recovery
Date: Tue, 29 Aug 2023 17:42:35 -0400
Message-ID: <20230829214235.69309-10-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829214235.69309-1-peterx@redhat.com>
References: <20230829214235.69309-1-peterx@redhat.com>
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

Normally the postcopy recover phase should only exist for a super short
period, that's the duration when QEMU is trying to recover from an
interrupted postcopy migration, during which handshake will be carried out
for continuing the procedure with state changes from PAUSED -> RECOVER ->
POSTCOPY_ACTIVE again.

Here RECOVER phase should be super small, that happens right after the
admin specified a new but working network link for QEMU to reconnect to
dest QEMU.

However there can still be case where the channel is broken in this small
RECOVER window.

If it happens, with current code there's no way the src QEMU can got kicked
out of RECOVER stage. No way either to retry the recover in another channel
when established.

This patch allows the RECOVER phase to fail itself too - we're mostly
ready, just some small things missing, e.g. properly kick the main
migration thread out when sleeping on rp_sem when we found that we're at
RECOVER stage.  When this happens, it fails the RECOVER itself, and
rollback to PAUSED stage.  Then the user can retry another round of
recovery.

To make it even stronger, teach QMP command migrate-pause to explicitly
kick src/dst QEMU out when needed, so even if for some reason the migration
thread didn't got kicked out already by a failing rethrn-path thread, the
admin can also kick it out.

This will be an super, super corner case, but still try to cover that.

One can try to test this with two proxy channels for migration:

  (a) socat unix-listen:/tmp/src.sock,reuseaddr,fork tcp:localhost:10000
  (b) socat tcp-listen:10000,reuseaddr,fork unix:/tmp/dst.sock

So the migration channel will be:

                      (a)          (b)
  src -> /tmp/src.sock -> tcp:10000 -> /tmp/dst.sock -> dst

Then to make QEMU hang at RECOVER stage, one can do below:

  (1) stop the postcopy using QMP command postcopy-pause
  (2) kill the 2nd proxy (b)
  (3) try to recover the postcopy using /tmp/src.sock on src
  (4) src QEMU will go into RECOVER stage but won't be able to continue
      from there, because the channel is actually broken at (b)

Before this patch, step (4) will make src QEMU stuck in RECOVER stage,
without a way to kick the QEMU out or continue the postcopy again.  After
this patch, (4) will quickly fail qemu and bounce back to PAUSED stage.

Admin can also kick QEMU from (4) into PAUSED when needed using
migrate-pause when needed.

After bouncing back to PAUSED stage, one can recover again.

Reported-by: Xiaohui Li <xiaohli@redhat.com>
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2111332
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h |  8 ++++--
 migration/migration.c | 64 +++++++++++++++++++++++++++++++++++++++----
 migration/ram.c       |  4 ++-
 3 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index b6de78dbdd..e86d9d098a 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -482,6 +482,7 @@ void migrate_init(MigrationState *s);
 bool migration_is_blocked(Error **errp);
 /* True if outgoing migration has entered postcopy phase */
 bool migration_in_postcopy(void);
+bool migration_postcopy_is_alive(void);
 MigrationState *migrate_get_current(void);
 
 uint64_t ram_get_total_transferred_pages(void);
@@ -522,8 +523,11 @@ void populate_vfio_info(MigrationInfo *info);
 void reset_vfio_bytes_transferred(void);
 void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
 
-/* Migration thread waiting for return path thread. */
-void migration_rp_wait(MigrationState *s);
+/*
+ * Migration thread waiting for return path thread.  Return non-zero if an
+ * error is detected.
+ */
+int migration_rp_wait(MigrationState *s);
 /*
  * Kick the migration thread waiting for return path messages.  NOTE: the
  * name can be slightly confusing (when read as "kick the rp thread"), just
diff --git a/migration/migration.c b/migration/migration.c
index 3a5f324781..85462ff1d7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1349,6 +1349,19 @@ bool migration_in_postcopy(void)
     }
 }
 
+bool migration_postcopy_is_alive(void)
+{
+    MigrationState *s = migrate_get_current();
+
+    switch (s->state) {
+    case MIGRATION_STATUS_POSTCOPY_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER:
+        return true;
+    default:
+        return false;
+    }
+}
+
 bool migration_in_postcopy_after_devices(MigrationState *s)
 {
     return migration_in_postcopy() && s->postcopy_after_devices;
@@ -1540,18 +1553,31 @@ void qmp_migrate_pause(Error **errp)
     MigrationIncomingState *mis = migration_incoming_get_current();
     int ret;
 
-    if (ms->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+    if (migration_postcopy_is_alive()) {
         /* Source side, during postcopy */
+        Error *error = NULL;
+
+        /* Tell the core migration that we're pausing */
+        error_setg(&error, "Postcopy migration is paused by the user");
+        migrate_set_error(ms, error);
+
         qemu_mutex_lock(&ms->qemu_file_lock);
         ret = qemu_file_shutdown(ms->to_dst_file);
         qemu_mutex_unlock(&ms->qemu_file_lock);
         if (ret) {
             error_setg(errp, "Failed to pause source migration");
         }
+
+        /*
+         * Kick the migration thread out of any waiting windows (on behalf
+         * of the rp thread).
+         */
+        migration_rp_kick(ms);
+
         return;
     }
 
-    if (mis->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+    if (migration_postcopy_is_alive()) {
         ret = qemu_file_shutdown(mis->from_src_file);
         if (ret) {
             error_setg(errp, "Failed to pause destination migration");
@@ -1560,7 +1586,7 @@ void qmp_migrate_pause(Error **errp)
     }
 
     error_setg(errp, "migrate-pause is currently only supported "
-               "during postcopy-active state");
+               "during postcopy-active or postcopy-recover state");
 }
 
 bool migration_is_blocked(Error **errp)
@@ -1742,9 +1768,21 @@ void qmp_migrate_continue(MigrationStatus state, Error **errp)
     qemu_sem_post(&s->pause_sem);
 }
 
-void migration_rp_wait(MigrationState *s)
+int migration_rp_wait(MigrationState *s)
 {
+    /* If migration has failure already, ignore the wait */
+    if (migrate_has_error(s)) {
+        return -1;
+    }
+
     qemu_sem_wait(&s->rp_state.rp_sem);
+
+    /* After wait, double check that there's no failure */
+    if (migrate_has_error(s)) {
+        return -1;
+    }
+
+    return 0;
 }
 
 void migration_rp_kick(MigrationState *s)
@@ -1798,6 +1836,20 @@ static bool postcopy_pause_return_path_thread(MigrationState *s)
 {
     trace_postcopy_pause_return_path();
 
+    if (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
+        /*
+         * this will be extremely unlikely: that we got yet another network
+         * issue during recovering of the 1st network failure.. during this
+         * period the main migration thread can be waiting on rp_sem for
+         * this thread to sync with the other side.
+         *
+         * When this happens, explicitly kick the migration thread out of
+         * RECOVER stage and back to PAUSED, so the admin can try
+         * everything again.
+         */
+        migration_rp_kick(s);
+    }
+
     qemu_sem_wait(&s->postcopy_pause_rp_sem);
 
     trace_postcopy_pause_return_path_continued();
@@ -2503,7 +2555,9 @@ static int postcopy_resume_handshake(MigrationState *s)
     qemu_savevm_send_postcopy_resume(s->to_dst_file);
 
     while (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
-        migration_rp_wait(s);
+        if (migration_rp_wait(s)) {
+            return -1;
+        }
     }
 
     if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
diff --git a/migration/ram.c b/migration/ram.c
index b5f6d65d84..199fd3e117 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4157,7 +4157,9 @@ static int ram_dirty_bitmap_sync_all(MigrationState *s, RAMState *rs)
 
     /* Wait until all the ramblocks' dirty bitmap synced */
     while (qatomic_read(&rs->postcopy_bmap_sync_requested)) {
-        migration_rp_wait(s);
+        if (migration_rp_wait(s)) {
+            return -1;
+        }
     }
 
     trace_ram_dirty_bitmap_sync_complete();
-- 
2.41.0


