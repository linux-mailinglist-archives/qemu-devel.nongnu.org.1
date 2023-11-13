Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D44937EA2F5
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 19:35:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2blT-00045F-C4; Mon, 13 Nov 2023 13:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r2blF-0003T0-Mj
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:34:14 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r2blD-0003CZ-PP
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 13:34:13 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ADHipAY005634; Mon, 13 Nov 2023 18:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=kG54KhD0gChlSGBNjtqSu0m+TpsYCYU9fV7WT7cHDkM=;
 b=sUelFG6k/w7L3V5AcB+3eNCu/jgJyUkFANunL94dtNekw+Sp0FAuaBerbVH0TEKBNntM
 WCRobAgRF2IRGQ8mdlcX9Xz/5NIHb2rbKnEt90urTxQGoLNEcbQR90TL9bzRgk9CN6bq
 iWe970bUzo0Jc1h37PuNq0uwKDtSsugDUv/ZHwkn1ddmhwOwuVmjdw47wLNZ+3wlvW1+
 HT5HrcE8gk/An+1YCJciIphefkpIQjPD54uhin5ozPTwrNN98k3SIcsHQCeTeobo3ybM
 bvnBHxsRkryfgaMzRVdhZtCqAM2hiA+yhcLt8214FvSqi6wf4dwGdg+iL3+/TqJnHDlY 2g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2n3besw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 18:34:10 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3ADHAbeh005201; Mon, 13 Nov 2023 18:34:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ub5k23k4p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Nov 2023 18:34:08 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ADIY2Jc026498;
 Mon, 13 Nov 2023 18:34:08 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3ub5k23k09-6; Mon, 13 Nov 2023 18:34:08 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 05/12] migration: preserve suspended runstate
Date: Mon, 13 Nov 2023 10:33:53 -0800
Message-Id: <1699900440-207345-6-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: C6qgDxK3H3X8FsSd3X36LxMHzdGO5Tao
X-Proofpoint-ORIG-GUID: C6qgDxK3H3X8FsSd3X36LxMHzdGO5Tao
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

A guest that is migrated in the suspended state automaticaly wakes and
continues execution.  This is wrong; the guest should end migration in
the same state it started.  The root cause is that the outgoing migration
code automatically wakes the guest, then saves the RUNNING runstate in
global_state_store(), hence the incoming migration code thinks the guest is
running and continues the guest if autostart is true.

Simply deleting the call to qemu_system_wakeup_request() on the outgoing
side, to migrate the vm in state suspended, does not solve the problem.
The old vm_stop_force_state does little if the vm is suspended, so the cpu
clock remains running, and runstate notifiers for the stop transition are
not called (and were not called on transition to suspended). Stale cpu
timers_state is saved to the migration stream, causing time errors in the
guest when it wakes from suspend.  State that would have been modified by
runstate notifiers is wrong.

The new version of vm_stop_force_state solves the outgoing problems, by
completely stopping a vm in the suspended state.

On the incoming side for precopy, compute the desired new state from global
state received, and call runstate_restore, which will partially
resume the vm if the state is suspended.  A future system_wakeup monitor
request will cause the vm to resume running.

On the incoming side for postcopy, apply the the same restore logic found
in precopy.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 migration/migration.c | 33 ++++++++++++++++++---------------
 migration/migration.h |  1 +
 migration/savevm.c    |  8 +-------
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 28a34c9..29ed901 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -592,6 +592,7 @@ static void process_incoming_migration_bh(void *opaque)
 {
     Error *local_err = NULL;
     MigrationIncomingState *mis = opaque;
+    RunState state = migrate_new_runstate();
 
     trace_vmstate_downtime_checkpoint("dst-precopy-bh-enter");
 
@@ -602,8 +603,7 @@ static void process_incoming_migration_bh(void *opaque)
      * unless we really are starting the VM.
      */
     if (!migrate_late_block_activate() ||
-         (autostart && (!global_state_received() ||
-            global_state_get_runstate() == RUN_STATE_RUNNING))) {
+        state == RUN_STATE_RUNNING) {
         /* Make sure all file formats throw away their mutable metadata.
          * If we get an error here, just don't restart the VM yet. */
         bdrv_activate_all(&local_err);
@@ -626,19 +626,13 @@ static void process_incoming_migration_bh(void *opaque)
 
     dirty_bitmap_mig_before_vm_start();
 
-    if (!global_state_received() ||
-        global_state_get_runstate() == RUN_STATE_RUNNING) {
-        if (autostart) {
-            vm_start();
-        } else {
-            runstate_set(RUN_STATE_PAUSED);
-        }
-    } else if (migration_incoming_colo_enabled()) {
+    if (migration_incoming_colo_enabled()) {
         migration_incoming_disable_colo();
         vm_start();
     } else {
-        runstate_set(global_state_get_runstate());
+        vm_resume(state);
     }
+
     trace_vmstate_downtime_checkpoint("dst-precopy-bh-vm-started");
     /*
      * This must happen after any state changes since as soon as an external
@@ -1277,6 +1271,16 @@ void migrate_set_state(int *state, int old_state, int new_state)
     }
 }
 
+RunState migrate_new_runstate(void)
+{
+    RunState state = global_state_get_runstate();
+
+    if (!global_state_received() || state == RUN_STATE_RUNNING) {
+        state = autostart ? RUN_STATE_RUNNING : RUN_STATE_PAUSED;
+    }
+    return state;
+}
+
 static void migrate_fd_cleanup(MigrationState *s)
 {
     qemu_bh_delete(s->cleanup_bh);
@@ -2415,7 +2419,6 @@ static int postcopy_start(MigrationState *ms, Error **errp)
 
     migration_downtime_start(ms);
 
-    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
     global_state_store();
     ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
     if (ret < 0) {
@@ -2614,7 +2617,6 @@ static int migration_completion_precopy(MigrationState *s,
 
     qemu_mutex_lock_iothread();
     migration_downtime_start(s);
-    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
 
     s->vm_old_state = runstate_get();
     global_state_store();
@@ -3135,9 +3137,10 @@ static void migration_iteration_finish(MigrationState *s)
     case MIGRATION_STATUS_FAILED:
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_CANCELLING:
-        if (s->vm_old_state == RUN_STATE_RUNNING) {
+        if (s->vm_old_state == RUN_STATE_RUNNING ||
+            s->vm_old_state == RUN_STATE_SUSPENDED) {
             if (!runstate_check(RUN_STATE_SHUTDOWN)) {
-                vm_start();
+                vm_resume(s->vm_old_state);
             }
         } else {
             if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
diff --git a/migration/migration.h b/migration/migration.h
index cf2c9c8..5b7aa89 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -473,6 +473,7 @@ struct MigrationState {
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
+RunState migrate_new_runstate(void);
 
 void migration_fd_process_incoming(QEMUFile *f, Error **errp);
 void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
diff --git a/migration/savevm.c b/migration/savevm.c
index eec5503..78ac2bd 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2163,13 +2163,7 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 
     dirty_bitmap_mig_before_vm_start();
 
-    if (autostart) {
-        /* Hold onto your hats, starting the CPU */
-        vm_start();
-    } else {
-        /* leave it paused and let management decide when to start the CPU */
-        runstate_set(RUN_STATE_PAUSED);
-    }
+    vm_resume(migrate_new_runstate());
 
     qemu_bh_delete(mis->bh);
 
-- 
1.8.3.1


