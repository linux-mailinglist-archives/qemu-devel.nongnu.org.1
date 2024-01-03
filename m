Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ECB823620
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 21:07:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL7VS-00057e-Bd; Wed, 03 Jan 2024 15:06:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rL7VM-0004xo-Vp
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 15:06:21 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rL7VJ-0002HZ-TD
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 15:06:19 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 403JXQEv003044; Wed, 3 Jan 2024 20:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=h4YP699pHqFu+oZKrSGgYwEFMoMb4DP9/SgUZkepa4k=;
 b=mM9Su54jq4HKZ7ajiz8HS+4Pxn6/4i6wTnhtZD1viQCsXsb+FzP/DwKWMiMtJYrZs0qL
 MK5asGmfSKZTyFHLEx83MJzTA7VGhCQ7AnIOWeLDmAosOSj69irSVONhR6fIBlZagAVd
 ycP3dimLP8kU5ooKitv8VxvRn0nHL41qyCVzeTYfdlkaMEGbRDi2PRk/fPb6jl/Y7lz7
 yfMubfW04crE1wqn5DKNOmU+lGnRLD7D0T2NUXScIRUU6Keu08S0q8Ib8pI2Z+rGCRUS
 MPPNtPXZClEbPksoh127OukmFYVMevTfMqSLBMsZPwTqSC80/dwr/prX7wcjHjZJDY4L Fg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vab8d5sxr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Jan 2024 20:05:51 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 403K22AT013703; Wed, 3 Jan 2024 20:05:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vddsvtbht-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 03 Jan 2024 20:05:50 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 403K2UZp020511;
 Wed, 3 Jan 2024 20:05:50 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3vddsvtba4-8; Wed, 03 Jan 2024 20:05:50 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Paul Durrant <paul@xen.org>, Eric Blake <eblake@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V9 07/12] migration: preserve suspended for snapshot
Date: Wed,  3 Jan 2024 12:05:36 -0800
Message-Id: <1704312341-66640-8-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1704312341-66640-1-git-send-email-steven.sistare@oracle.com>
References: <1704312341-66640-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_08,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401030162
X-Proofpoint-GUID: 5ktBXcL-dxg4RmUblXzJGQipREGorCZi
X-Proofpoint-ORIG-GUID: 5ktBXcL-dxg4RmUblXzJGQipREGorCZi
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 include/migration/snapshot.h   |  7 +++++++
 migration/migration-hmp-cmds.c |  8 +++++---
 migration/savevm.c             | 23 +++++++++++++----------
 system/runstate.c              |  5 +++++
 system/vl.c                    |  2 ++
 5 files changed, 32 insertions(+), 13 deletions(-)

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
index 99710c8..740a219 100644
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
index 1b9ab7b..74f915f 100644
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
index e2fa204..ca9eb54 100644
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
index 6b87bfa..1eec5f6 100644
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
1.8.3.1


