Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B9377C025
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 20:58:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVciI-0005XJ-F1; Mon, 14 Aug 2023 14:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qVciH-0005Wa-0d
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 14:54:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qVciE-0007ro-5Q
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 14:54:48 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37EGTO6Y014698; Mon, 14 Aug 2023 18:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=txucQCp+t49rVB6R1rJtAnvS8yxv3IOpXqHmOdZwAXs=;
 b=N632TMDnI7drTEJghAQltF5wnxc0bdpZnRnCBL0N4Gcj3LJFiY8DE3YxKaPE3gSEsqKS
 sDmLF42qoUBUPGGWmur0g9dm+/1zmod8gb6gcfPKkvfTxfjdNqRWLtpg1rhXehLSNMR7
 fzQueQb/PQ2BQ2oePlOIkMXz9lCdWxjIYmskIs53euAA4HxZ0RVubMh4v5lejfkwzLzx
 /oEQbG1MuaBej4JMUMJsKcSijo+/h0Hkvr+SXB0Z6xFSSWQb/cIPnlBVJZn3wE64Hlh1
 vaEFRzCEo6KHlAtA8lIcHk/kd+FCd5aU0RdOknONCMbaMCOATjAMODF8QmIzsIAjTOoR IA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se61c37kd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Aug 2023 18:54:40 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37EIUTDM006641; Mon, 14 Aug 2023 18:54:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3sey2c8x55-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Aug 2023 18:54:40 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37EIsb3p008127;
 Mon, 14 Aug 2023 18:54:39 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3sey2c8x3f-3; Mon, 14 Aug 2023 18:54:39 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 02/10] migration: preserve suspended runstate
Date: Mon, 14 Aug 2023 11:54:28 -0700
Message-Id: <1692039276-148610-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1692039276-148610-1-git-send-email-steven.sistare@oracle.com>
References: <1692039276-148610-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_15,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140175
X-Proofpoint-GUID: liShyB3w0BzLy7DY3107oGiAS78fYdJZ
X-Proofpoint-ORIG-GUID: liShyB3w0BzLy7DY3107oGiAS78fYdJZ
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
the same state it started.  The root causes is that the outgoing migration
code automatically wakes the guest, then saves the RUNNING runstate in
global_state_store(), hence the incoming migration code thinks the guest is
running and continues the guest if autostart is true.

On the outgoing side, do not call qemu_system_wakeup_request().  That
alone fixes precopy migration, as process_incoming_migration_bh correctly
sets runstate from global_state_get_runstate().

On the incoming side for postcopy, do not wake the guest, and apply the
the same logic as found in precopy: if autostart and the runstate is
RUNNING, then vm_start, else merely restore the runstate.

In both cases, if the restored state is SUSPENDED, then a later wakeup
request will resume the guest, courtesy of the previous "start on wakeup"
patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c |  2 --
 migration/savevm.c    | 13 ++++++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5528acb..51ace82 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2109,7 +2109,6 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     qemu_mutex_lock_iothread();
     trace_postcopy_start_set_run();
 
-    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
     global_state_store();
     ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
     if (ret < 0) {
@@ -2315,7 +2314,6 @@ static void migration_completion(MigrationState *s)
     if (s->state == MIGRATION_STATUS_ACTIVE) {
         qemu_mutex_lock_iothread();
         s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
-        qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
 
         s->vm_old_state = runstate_get();
         global_state_store();
diff --git a/migration/savevm.c b/migration/savevm.c
index a2cb885..be42d0a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2070,12 +2070,15 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 
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
     } else {
-        /* leave it paused and let management decide when to start the CPU */
-        runstate_set(RUN_STATE_PAUSED);
+        runstate_set(global_state_get_runstate());
     }
 
     qemu_bh_delete(mis->bh);
-- 
1.8.3.1


