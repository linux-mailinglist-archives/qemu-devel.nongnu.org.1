Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D350D7EA2F4
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 19:35:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2blV-0004Fe-B1; Mon, 13 Nov 2023 13:34:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r2blF-0003Sz-Fn
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:34:14 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r2blD-0003Cf-Ik
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:34:13 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ADHi8B7000446; Mon, 13 Nov 2023 18:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=QQGEahQIV0v39JMOMpNNUO/NCipv4dDRUyiJkJqUnlw=;
 b=u33EQOorlQLBQTVtGbD5cPBznr+v8wN5QVD0ZvO4CRShenTpBo1Oyz49LQeHLmgQoWMQ
 z97uXfAk6T6C/mLknE3o7cuRjNvUflGh0Dti0Z7hMlLRYxhxsyRMUMCQMtkVoql2wWPP
 lvDHiYoXnhrlABz3JsD5s5roYlQHj/8sexU6xIlIkmOU+TYzNjJnhnkkgiXvWqvOd6v+
 HCEx2s59LBqB6uNUK+zS5PXbJrRiMob53CFFQ37jC4JDyR+p+m34E96to+aeKzE8P1fa
 MuAGKhcBWOgn03CuhLATwpdxu9hiPCS018zWhpdEs96b3V9Kz3oiK7QYdTWPDbRYtUtd /w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2n9ugfn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 18:34:10 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3ADII4Zq004746; Mon, 13 Nov 2023 18:34:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ub5k23k5c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 18:34:09 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ADIY2Je026498;
 Mon, 13 Nov 2023 18:34:09 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3ub5k23k09-7; Mon, 13 Nov 2023 18:34:09 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 06/12] migration: preserve suspended for snapshot
Date: Mon, 13 Nov 2023 10:33:54 -0800
Message-Id: <1699900440-207345-7-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1699900440-207345-1-git-send-email-steven.sistare@oracle.com>
References: <1699900440-207345-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_09,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311130151
X-Proofpoint-GUID: gPdvBOj6fxyjaOoa3oBcWGAf8t2L-mDx
X-Proofpoint-ORIG-GUID: gPdvBOj6fxyjaOoa3oBcWGAf8t2L-mDx
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Restoring a snapshot can break a suspended guest.  Snapshots suffer from
the same suspended-state issues that affect live migration, plus they must
handle an additional problematic scenario, which is that a running vm must
remain running if it loads a suspended snapshot.

To save, call vm_stop_force_state to completely stop a vm in the suspended
state, and restore the suspended state using runstate_restore.  This
produces a correct vmstate file and leaves the vm in the state it had prior
to the save.

To load, if the snapshot is not suspended, then vm_stop_force_state +
runstate_restore correctly handles all states, and leaves the vm in the
state it had prior to the load.  However, if the snapshot is suspended,
restoration is trickier.  First restore the state to suspended so the
current state matches the saved state.  Then, if the pre-load state is
running, wakeup to resume running.

Prior to these changes, the vm_stop to RUN_STATE_SAVE_VM and
RUN_STATE_RESTORE_VM did not change runstate if the current state was
paused, suspended, or prelaunch, but now vm_stop_force_state forces these
transitions, so allow them.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/snapshot.h   |  7 +++++++
 migration/migration-hmp-cmds.c | 12 ++++++++----
 migration/savevm.c             | 33 +++++++++++++++++++++------------
 system/runstate.c              | 10 ++++++++++
 system/vl.c                    |  2 ++
 5 files changed, 48 insertions(+), 16 deletions(-)

diff --git a/include/migration/snapshot.h b/include/migration/snapshot.h
index e72083b..9e4dcaa 100644
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
index 86ae832..c31cdc7 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -399,15 +399,19 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
 
 void hmp_loadvm(Monitor *mon, const QDict *qdict)
 {
-    int saved_vm_running  = runstate_is_running();
+    RunState saved_state = runstate_get();
+
     const char *name = qdict_get_str(qdict, "name");
     Error *err = NULL;
 
-    vm_stop(RUN_STATE_RESTORE_VM);
+    vm_stop_force_state(RUN_STATE_RESTORE_VM);
 
-    if (load_snapshot(name, NULL, false, NULL, &err) && saved_vm_running) {
-        vm_start();
+    if (load_snapshot(name, NULL, false, NULL, &err)) {
+        load_snapshot_resume(saved_state);
+    } else {
+        vm_resume(saved_state);
     }
+
     hmp_handle_error(mon, err);
 }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 78ac2bd..b4b49bb 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3040,7 +3040,7 @@ bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
     QEMUSnapshotInfo sn1, *sn = &sn1;
     int ret = -1, ret2;
     QEMUFile *f;
-    int saved_vm_running;
+    RunState saved_state = runstate_get();
     uint64_t vm_state_size;
     g_autoptr(GDateTime) now = g_date_time_new_now_local();
     AioContext *aio_context;
@@ -3088,10 +3088,8 @@ bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
     }
     aio_context = bdrv_get_aio_context(bs);
 
-    saved_vm_running = runstate_is_running();
-
     global_state_store();
-    vm_stop(RUN_STATE_SAVE_VM);
+    vm_stop_force_state(RUN_STATE_SAVE_VM);
 
     bdrv_drain_all_begin();
 
@@ -3157,9 +3155,7 @@ bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
 
     bdrv_drain_all_end();
 
-    if (saved_vm_running) {
-        vm_start();
-    }
+    vm_resume(saved_state);
     return ret == 0;
 }
 
@@ -3333,6 +3329,20 @@ err_drain:
     return false;
 }
 
+void load_snapshot_resume(RunState state)
+{
+    if (global_state_received() &&
+        global_state_get_runstate() == RUN_STATE_SUSPENDED) {
+
+        vm_resume(RUN_STATE_SUSPENDED);
+        if (state == RUN_STATE_RUNNING) {
+            qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
+        }
+    } else {
+        vm_resume(state);
+    }
+}
+
 bool delete_snapshot(const char *name, bool has_devices,
                      strList *devices, Error **errp)
 {
@@ -3397,16 +3407,15 @@ static void snapshot_load_job_bh(void *opaque)
 {
     Job *job = opaque;
     SnapshotJob *s = container_of(job, SnapshotJob, common);
-    int orig_vm_running;
+    RunState orig_state = runstate_get();
 
     job_progress_set_remaining(&s->common, 1);
 
-    orig_vm_running = runstate_is_running();
-    vm_stop(RUN_STATE_RESTORE_VM);
+    vm_stop_force_state(RUN_STATE_RESTORE_VM);
 
     s->ret = load_snapshot(s->tag, s->vmstate, true, s->devices, s->errp);
-    if (s->ret && orig_vm_running) {
-        vm_start();
+    if (s->ret) {
+        load_snapshot_resume(orig_state);
     }
 
     job_progress_update(&s->common, 1);
diff --git a/system/runstate.c b/system/runstate.c
index ea9d6c2..f1d4bc7 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -77,6 +77,8 @@ typedef struct {
 
 static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE },
+    { RUN_STATE_PRELAUNCH, RUN_STATE_PAUSED },
+    { RUN_STATE_PRELAUNCH, RUN_STATE_SUSPENDED },
 
     { RUN_STATE_DEBUG, RUN_STATE_RUNNING },
     { RUN_STATE_DEBUG, RUN_STATE_FINISH_MIGRATE },
@@ -108,6 +110,8 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_PAUSED, RUN_STATE_POSTMIGRATE },
     { RUN_STATE_PAUSED, RUN_STATE_PRELAUNCH },
     { RUN_STATE_PAUSED, RUN_STATE_COLO},
+    { RUN_STATE_PAUSED, RUN_STATE_SAVE_VM},
+    { RUN_STATE_PAUSED, RUN_STATE_RESTORE_VM},
 
     { RUN_STATE_POSTMIGRATE, RUN_STATE_RUNNING },
     { RUN_STATE_POSTMIGRATE, RUN_STATE_FINISH_MIGRATE },
@@ -131,6 +135,8 @@ static const RunStateTransition runstate_transitions_def[] = {
 
     { RUN_STATE_RESTORE_VM, RUN_STATE_RUNNING },
     { RUN_STATE_RESTORE_VM, RUN_STATE_PRELAUNCH },
+    { RUN_STATE_RESTORE_VM, RUN_STATE_PAUSED },
+    { RUN_STATE_RESTORE_VM, RUN_STATE_SUSPENDED },
 
     { RUN_STATE_COLO, RUN_STATE_RUNNING },
     { RUN_STATE_COLO, RUN_STATE_PRELAUNCH },
@@ -149,6 +155,8 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_RUNNING, RUN_STATE_COLO},
 
     { RUN_STATE_SAVE_VM, RUN_STATE_RUNNING },
+    { RUN_STATE_SAVE_VM, RUN_STATE_PAUSED },
+    { RUN_STATE_SAVE_VM, RUN_STATE_SUSPENDED },
 
     { RUN_STATE_SHUTDOWN, RUN_STATE_PAUSED },
     { RUN_STATE_SHUTDOWN, RUN_STATE_FINISH_MIGRATE },
@@ -161,6 +169,8 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_SUSPENDED, RUN_STATE_FINISH_MIGRATE },
     { RUN_STATE_SUSPENDED, RUN_STATE_PRELAUNCH },
     { RUN_STATE_SUSPENDED, RUN_STATE_COLO},
+    { RUN_STATE_SUSPENDED, RUN_STATE_SAVE_VM },
+    { RUN_STATE_SUSPENDED, RUN_STATE_RESTORE_VM },
 
     { RUN_STATE_WATCHDOG, RUN_STATE_RUNNING },
     { RUN_STATE_WATCHDOG, RUN_STATE_FINISH_MIGRATE },
diff --git a/system/vl.c b/system/vl.c
index bd7fad7..082a45a 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2702,7 +2702,9 @@ void qmp_x_exit_preconfig(Error **errp)
     qemu_machine_creation_done();
 
     if (loadvm) {
+        RunState state = autostart ? RUN_STATE_RUNNING : runstate_get();
         load_snapshot(loadvm, NULL, false, NULL, &error_fatal);
+        load_snapshot_resume(state);
     }
     if (replay_mode != REPLAY_MODE_NONE) {
         replay_vmstate_init();
-- 
1.8.3.1


