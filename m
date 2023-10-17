Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF097CCE03
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 22:28:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsqeT-0000Wz-1f; Tue, 17 Oct 2023 16:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qsqeO-0000PU-2Z
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 16:26:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qsqeL-0000lx-O6
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 16:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697574405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6fmbaN/VcS/KEap3OOb428PF7mCjkwVBQva1/SxwhK4=;
 b=YxhbNn7sxRC03Ieq4t39u1ZJVxhzpWVcSuXYWVoKt1jpMx1L754IENuVyaKvBMXppwN79Q
 gAZYFadMUfdcFPvp4s6dOaMA1zeTUrhS5xeGw8XERBgg4wpjb9oax7mCaVpkqaAa7ic/Ja
 V1ekYwJUbla9IflQQVGlEO7vdqFY35I=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-V7bKnHC0Opqi11w0sDkyLw-1; Tue, 17 Oct 2023 16:26:38 -0400
X-MC-Unique: V7bKnHC0Opqi11w0sDkyLw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-77422b20b13so100478585a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 13:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697574397; x=1698179197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6fmbaN/VcS/KEap3OOb428PF7mCjkwVBQva1/SxwhK4=;
 b=Ai8mhKyZvlhQar1mu9BOjncZ8teY77jrJbwClqOqfN2lIqCo+0EMGmm3qfYkjd37MD
 nj9H0Ji64Sn/XeeyEKKW7ZrGUVXdr0qZViJTbEz9ptzioGaEiXY7qNQW/d8fbCqNd/eY
 ZeuMqcoSyJXY0RIK2isk5/gbQaz47MYnHlpWB5Yr55nGhZm9QMp3MN/M8LcRvu+VnM31
 JQrQddMwTDlFlKAFDfAWsSmbHC0nrJ607iyrJ0mZ42spuiMaGKTjDatoS6wayTr78O6u
 J4Bpa0tMd8rvswK0S+CrVOBoPDr1HsrHblXf5TYVqOyrO2Mn9oobGldduoqKzVUNFpas
 SaVg==
X-Gm-Message-State: AOJu0YxqvLLArHWGr7XDflOSSut+mP/LHVn9U2Zc7IoNtY6XLRGnDPGh
 QmV3TruA8OJzanvlDSRthw6k0JDw74e74uhqfny/lz6MYCybM2zuATQiicU0tAniw9PblMpwxKK
 M2fCPp6oxyRb3SP8b9CUajio7T4ty5WPUPv7qrEku3UQkLSsrj1pqS67jpa4c/AhsiH8D2iel
X-Received: by 2002:a05:620a:6589:b0:774:17d6:31dc with SMTP id
 qd9-20020a05620a658900b0077417d631dcmr3118328qkn.4.1697574397339; 
 Tue, 17 Oct 2023 13:26:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEn/SNv5OQ4VZz2E0CH8t6JhVd2pujfRNecXMQtaj2rDuFRcOr4LyOiQk7WDqgQkAc9vaZHDw==
X-Received: by 2002:a05:620a:6589:b0:774:17d6:31dc with SMTP id
 qd9-20020a05620a658900b0077417d631dcmr3118309qkn.4.1697574396926; 
 Tue, 17 Oct 2023 13:26:36 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 s17-20020ae9f711000000b0076f16e98851sm931879qkg.102.2023.10.17.13.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 13:26:36 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Xiaohui Li <xiaohli@redhat.com>
Subject: [PATCH v4 2/5] migration: Allow network to fail even during recovery
Date: Tue, 17 Oct 2023 16:26:30 -0400
Message-ID: <20231017202633.296756-3-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017202633.296756-1-peterx@redhat.com>
References: <20231017202633.296756-1-peterx@redhat.com>
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2111332
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.h |  8 ++++--
 migration/migration.c | 63 +++++++++++++++++++++++++++++++++++++++----
 migration/ram.c       |  4 ++-
 3 files changed, 67 insertions(+), 8 deletions(-)

diff --git a/migration/migration.h b/migration/migration.h
index 1d1ac13adb..0b695bbfb1 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -494,6 +494,7 @@ int migrate_init(MigrationState *s, Error **errp);
 bool migration_is_blocked(Error **errp);
 /* True if outgoing migration has entered postcopy phase */
 bool migration_in_postcopy(void);
+bool migration_postcopy_is_alive(int state);
 MigrationState *migrate_get_current(void);
 
 uint64_t ram_get_total_transferred_pages(void);
@@ -534,8 +535,11 @@ void migration_populate_vfio_info(MigrationInfo *info);
 void migration_reset_vfio_bytes_transferred(void);
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
index 3123c4a873..0661dad953 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1348,6 +1348,17 @@ bool migration_in_postcopy(void)
     }
 }
 
+bool migration_postcopy_is_alive(int state)
+{
+    switch (state) {
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
@@ -1557,8 +1568,15 @@ void qmp_migrate_pause(Error **errp)
     MigrationIncomingState *mis = migration_incoming_get_current();
     int ret = 0;
 
-    if (ms->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+    if (migration_postcopy_is_alive(ms->state)) {
         /* Source side, during postcopy */
+        Error *error = NULL;
+
+        /* Tell the core migration that we're pausing */
+        error_setg(&error, "Postcopy migration is paused by the user");
+        migrate_set_error(ms, error);
+        error_free(error);
+
         qemu_mutex_lock(&ms->qemu_file_lock);
         if (ms->to_dst_file) {
             ret = qemu_file_shutdown(ms->to_dst_file);
@@ -1567,10 +1585,17 @@ void qmp_migrate_pause(Error **errp)
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
+    if (migration_postcopy_is_alive(mis->state)) {
         ret = qemu_file_shutdown(mis->from_src_file);
         if (ret) {
             error_setg(errp, "Failed to pause destination migration");
@@ -1579,7 +1604,7 @@ void qmp_migrate_pause(Error **errp)
     }
 
     error_setg(errp, "migrate-pause is currently only supported "
-               "during postcopy-active state");
+               "during postcopy-active or postcopy-recover state");
 }
 
 bool migration_is_blocked(Error **errp)
@@ -1754,9 +1779,21 @@ void qmp_migrate_continue(MigrationStatus state, Error **errp)
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
@@ -2018,6 +2055,20 @@ out:
         trace_source_return_path_thread_bad_end();
     }
 
+    if (ms->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
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
+        migration_rp_kick(ms);
+    }
+
     trace_source_return_path_thread_end();
     rcu_unregister_thread();
 
@@ -2482,7 +2533,9 @@ static int postcopy_resume_handshake(MigrationState *s)
     qemu_savevm_send_postcopy_resume(s->to_dst_file);
 
     while (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER) {
-        migration_rp_wait(s);
+        if (migration_rp_wait(s)) {
+            return -1;
+        }
     }
 
     if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
diff --git a/migration/ram.c b/migration/ram.c
index 544c5b63cf..973e872284 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4175,7 +4175,9 @@ static int ram_dirty_bitmap_sync_all(MigrationState *s, RAMState *rs)
 
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


