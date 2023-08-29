Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2969B78D010
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:13:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7ms-0000hL-Qo; Tue, 29 Aug 2023 19:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qb3I8-0002ab-Ez
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:18:17 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qb3I5-0003UX-Fz
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:18:16 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37THii1e023429; Tue, 29 Aug 2023 18:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=b8svEifVQlkpZwsts2HrwmL6UewsjMUsdbmn7xtesCc=;
 b=ZBRw5Ovx/WT/Iyih+LxOrZUh9KuxxJ5WotBtLaA8FMjzlRtkNbmufwRmMmBlttEGyMek
 OCuUM2A7ymTJxzepf7Dbm/bnuXLPg/K/xLfjg4Yh4AWNUetLA1PML04ePPYNgNGAh7+o
 lkaHFUqER2A01bdwqw6ziRGSNr/mBjODunDgX+czFqe42iYuFz/3yvq/KLlL1R7EROJQ
 AXFqvIEccLnHBq1V/j0loUqAMOaL7tWGhgcgJyoHDjQCb9QR6bvwTRsQIIQsB0j0SZdy
 OXB5bv+gkxbtBJENAax+qUdObYsjrPG+0pHK3CDshxzQyneUlSOt62oleufHyyrjQos8 Sg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9gdwmqe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Aug 2023 18:18:09 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37THEWLP024792; Tue, 29 Aug 2023 18:18:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3sr6dnfwja-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Aug 2023 18:18:08 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37TII6ls011911;
 Tue, 29 Aug 2023 18:18:08 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3sr6dnfwgx-3; Tue, 29 Aug 2023 18:18:08 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 02/11] migration: preserve suspended runstate
Date: Tue, 29 Aug 2023 11:17:57 -0700
Message-Id: <1693333086-392798-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
References: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_13,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308290158
X-Proofpoint-ORIG-GUID: fKidjNp4-QSw-wLcUDEz5e5oDD8fI56D
X-Proofpoint-GUID: fKidjNp4-QSw-wLcUDEz5e5oDD8fI56D
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

A guest that is migrated in the suspended state automaticaly wakes and
continues execution.  This is wrong; the guest should end migration in
the same state it started.  The root cause is that the outgoing migration
code automatically wakes the guest, then saves the RUNNING runstate in
global_state_store(), hence the incoming migration code thinks the guest is
running and continues the guest if autostart is true.

On the outgoing side, do not call qemu_system_wakeup_request().

On the incoming side for precopy, prepare to start the vm, but do not
yet start it.  A future system_wakeup will cause the main loop to resume
the VCPUs.

On the incoming side for postcopy, do not wake the guest, and apply the
the same logic as found in precopy: if autostart and the runstate is
RUNNING, then vm_start, else prepare to start the vm.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c |  4 ++--
 migration/savevm.c    | 15 ++++++++++-----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5528acb..5bcc761 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -496,6 +496,8 @@ static void process_incoming_migration_bh(void *opaque)
     } else if (migration_incoming_colo_enabled()) {
         migration_incoming_disable_colo();
         vm_start();
+    } else if (global_state_get_runstate() == RUN_STATE_SUSPENDED) {
+        vm_prepare_start(false, global_state_get_runstate());
     } else {
         runstate_set(global_state_get_runstate());
     }
@@ -2109,7 +2111,6 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     qemu_mutex_lock_iothread();
     trace_postcopy_start_set_run();
 
-    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
     global_state_store();
     ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
     if (ret < 0) {
@@ -2315,7 +2316,6 @@ static void migration_completion(MigrationState *s)
     if (s->state == MIGRATION_STATUS_ACTIVE) {
         qemu_mutex_lock_iothread();
         s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
-        qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
 
         s->vm_old_state = runstate_get();
         global_state_store();
diff --git a/migration/savevm.c b/migration/savevm.c
index a2cb885..bae0a1a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2070,12 +2070,17 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 
     dirty_bitmap_mig_before_vm_start();
 
-    if (autostart) {
-        /* Hold onto your hats, starting the CPU */
-        vm_start();
+    if (!global_state_received() ||
+        global_state_get_runstate() == RUN_STATE_RUNNING) {
+        if (autostart) {
+            vm_start();
+        } else {
+            runstate_set(RUN_STATE_PAUSED);
+        }
+    } else if (global_state_get_runstate() == RUN_STATE_SUSPENDED) {
+        vm_prepare_start(false, RUN_STATE_SUSPENDED);
     } else {
-        /* leave it paused and let management decide when to start the CPU */
-        runstate_set(RUN_STATE_PAUSED);
+        runstate_set(global_state_get_runstate());
     }
 
     qemu_bh_delete(mis->bh);
-- 
1.8.3.1


