Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7DD823B76
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 05:35:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLFPu-0000al-TA; Wed, 03 Jan 2024 23:33:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFPr-0000aO-K0
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:33:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFPp-0006c1-OT
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:33:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704342789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5b2CT1KStXV150qameeAoGS09H9N9IdPg5fcDO9jm+o=;
 b=PRmxXa/s/0MvBbsR37WAogMVP0Q2GUlbrxH2iYbAfhJJ9MfHIBIM4ue0wU24CVfMJRiBSh
 /EXThTEEzj+w7bKC+OzX8HlWKKsOW/QQzL6zPfpqlZK5nu70o/O8lHn/kZCT1bkE/3h5PN
 h6rdEItY5OkhbAcUPjnOYyovxv66UNs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-HpNDakmzMs6yUiWsiMvDkg-1; Wed, 03 Jan 2024 23:33:05 -0500
X-MC-Unique: HpNDakmzMs6yUiWsiMvDkg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F976836F85;
 Thu,  4 Jan 2024 04:33:04 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A65E4C15968;
 Thu,  4 Jan 2024 04:33:00 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Steve Sistare <steven.sistare@oracle.com>,
 Juan Quintela <quintela@trasno.org>, peterx@redhat.com,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Subject: [PULL 09/26] migration: preserve suspended for snapshot
Date: Thu,  4 Jan 2024 12:31:54 +0800
Message-ID: <20240104043213.431566-10-peterx@redhat.com>
In-Reply-To: <20240104043213.431566-1-peterx@redhat.com>
References: <20240104043213.431566-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Restoring a snapshot can break a suspended guest.  Snapshots suffer from
the same suspended-state issues that affect live migration, plus they must
handle an additional problematic scenario, which is that a running vm must
remain running if it loads a suspended snapshot.

To save, the existing vm_stop call now completely stops the suspended
state.  Finish with vm_resume to leave the vm in the state it had prior
to the save, correctly restoring the suspended state.

To load, if the snapshot is not suspended, then vm_stop + vm_resume
correctly handles all states, and leaves the vm in the state it had prior
to the load.  However, if the snapshot is suspended, restoration is
trickier.  First, call vm_resume to restore the state to suspended so the
current state matches the saved state.  Then, if the pre-load state is
running, call wakeup to resume running.

Prior to these changes, the vm_stop to RUN_STATE_SAVE_VM and
RUN_STATE_RESTORE_VM did not change runstate if the current state was
suspended, but now it does, so allow these transitions.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/1704312341-66640-8-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/snapshot.h   |  7 +++++++
 migration/migration-hmp-cmds.c |  8 +++++---
 migration/savevm.c             | 23 +++++++++++++----------
 system/runstate.c              |  5 +++++
 system/vl.c                    |  2 ++
 5 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/include/migration/snapshot.h b/include/migration/snapshot.h
index e72083b117..9e4dcaaa75 100644
--- a/include/migration/snapshot.h
+++ b/include/migration/snapshot.h
@@ -16,6 +16,7 @@
 #define QEMU_MIGRATION_SNAPSHOT_H
 
 #include "qapi/qapi-builtin-types.h"
+#include "qapi/qapi-types-run-state.h"
 
 /**
  * save_snapshot: Save an internal snapshot.
@@ -61,4 +62,10 @@ bool delete_snapshot(const char *name,
                     bool has_devices, strList *devices,
                     Error **errp);
 
+/**
+ * load_snapshot_resume: Restore runstate after loading snapshot.
+ * @state: state to restore
+ */
+void load_snapshot_resume(RunState state);
+
 #endif
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 99710c8ffb..740a219aa4 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -399,15 +399,17 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
 
 void hmp_loadvm(Monitor *mon, const QDict *qdict)
 {
-    int saved_vm_running  = runstate_is_running();
+    RunState saved_state = runstate_get();
+
     const char *name = qdict_get_str(qdict, "name");
     Error *err = NULL;
 
     vm_stop(RUN_STATE_RESTORE_VM);
 
-    if (load_snapshot(name, NULL, false, NULL, &err) && saved_vm_running) {
-        vm_start();
+    if (load_snapshot(name, NULL, false, NULL, &err)) {
+        load_snapshot_resume(saved_state);
     }
+
     hmp_handle_error(mon, err);
 }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 1b9ab7b8ee..74f915f3ac 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3046,7 +3046,7 @@ bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
     QEMUSnapshotInfo sn1, *sn = &sn1;
     int ret = -1, ret2;
     QEMUFile *f;
-    int saved_vm_running;
+    RunState saved_state = runstate_get();
     uint64_t vm_state_size;
     g_autoptr(GDateTime) now = g_date_time_new_now_local();
 
@@ -3092,8 +3092,6 @@ bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
         return false;
     }
 
-    saved_vm_running = runstate_is_running();
-
     global_state_store();
     vm_stop(RUN_STATE_SAVE_VM);
 
@@ -3147,9 +3145,7 @@ bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
  the_end:
     bdrv_drain_all_end();
 
-    if (saved_vm_running) {
-        vm_start();
-    }
+    vm_resume(saved_state);
     return ret == 0;
 }
 
@@ -3317,6 +3313,14 @@ err_drain:
     return false;
 }
 
+void load_snapshot_resume(RunState state)
+{
+    vm_resume(state);
+    if (state == RUN_STATE_RUNNING && runstate_get() == RUN_STATE_SUSPENDED) {
+        qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, &error_abort);
+    }
+}
+
 bool delete_snapshot(const char *name, bool has_devices,
                      strList *devices, Error **errp)
 {
@@ -3381,16 +3385,15 @@ static void snapshot_load_job_bh(void *opaque)
 {
     Job *job = opaque;
     SnapshotJob *s = container_of(job, SnapshotJob, common);
-    int orig_vm_running;
+    RunState orig_state = runstate_get();
 
     job_progress_set_remaining(&s->common, 1);
 
-    orig_vm_running = runstate_is_running();
     vm_stop(RUN_STATE_RESTORE_VM);
 
     s->ret = load_snapshot(s->tag, s->vmstate, true, s->devices, s->errp);
-    if (s->ret && orig_vm_running) {
-        vm_start();
+    if (s->ret) {
+        load_snapshot_resume(orig_state);
     }
 
     job_progress_update(&s->common, 1);
diff --git a/system/runstate.c b/system/runstate.c
index e2fa2040cb..ca9eb54cde 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -77,6 +77,7 @@ typedef struct {
 
 static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE },
+    { RUN_STATE_PRELAUNCH, RUN_STATE_SUSPENDED },
 
     { RUN_STATE_DEBUG, RUN_STATE_RUNNING },
     { RUN_STATE_DEBUG, RUN_STATE_FINISH_MIGRATE },
@@ -132,6 +133,7 @@ static const RunStateTransition runstate_transitions_def[] = {
 
     { RUN_STATE_RESTORE_VM, RUN_STATE_RUNNING },
     { RUN_STATE_RESTORE_VM, RUN_STATE_PRELAUNCH },
+    { RUN_STATE_RESTORE_VM, RUN_STATE_SUSPENDED },
 
     { RUN_STATE_COLO, RUN_STATE_RUNNING },
     { RUN_STATE_COLO, RUN_STATE_PRELAUNCH },
@@ -150,6 +152,7 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_RUNNING, RUN_STATE_COLO},
 
     { RUN_STATE_SAVE_VM, RUN_STATE_RUNNING },
+    { RUN_STATE_SAVE_VM, RUN_STATE_SUSPENDED },
 
     { RUN_STATE_SHUTDOWN, RUN_STATE_PAUSED },
     { RUN_STATE_SHUTDOWN, RUN_STATE_FINISH_MIGRATE },
@@ -163,6 +166,8 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_SUSPENDED, RUN_STATE_PRELAUNCH },
     { RUN_STATE_SUSPENDED, RUN_STATE_COLO},
     { RUN_STATE_SUSPENDED, RUN_STATE_PAUSED},
+    { RUN_STATE_SUSPENDED, RUN_STATE_SAVE_VM },
+    { RUN_STATE_SUSPENDED, RUN_STATE_RESTORE_VM },
 
     { RUN_STATE_WATCHDOG, RUN_STATE_RUNNING },
     { RUN_STATE_WATCHDOG, RUN_STATE_FINISH_MIGRATE },
diff --git a/system/vl.c b/system/vl.c
index 6b87bfa32c..1eec5f627f 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2710,7 +2710,9 @@ void qmp_x_exit_preconfig(Error **errp)
     qemu_machine_creation_done();
 
     if (loadvm) {
+        RunState state = autostart ? RUN_STATE_RUNNING : runstate_get();
         load_snapshot(loadvm, NULL, false, NULL, &error_fatal);
+        load_snapshot_resume(state);
     }
     if (replay_mode != REPLAY_MODE_NONE) {
         replay_vmstate_init();
-- 
2.41.0


