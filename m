Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1093743CFF
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:51:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFEWM-0006ED-BC; Fri, 30 Jun 2023 09:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qFEVa-0006DI-1V
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:49:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qFEVX-00072B-M0
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:49:57 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UBOek2007730; Fri, 30 Jun 2023 13:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=7rkT1wGI0BiAUDUX+aNDTDl148SfM/hkoHqVJ7zg1WU=;
 b=E/v5Vsggm5/ueenDNhOThOs4X159hJarXNDN1VV5/jWFDmgqKA9CNu5duSLPmO0/SCNb
 YIAefoXHDt02d5gn6mFKzLk8ByPZbsW2CkaYDaVHCxsT9/pz9PfyhpkIfvWEPrySgUWa
 i88ZlACwYWFY3xQGxVRxYiUJU9BHWbsovO7B1Lsmzdey6JmTIdbVD5H0PyYCdCh3V8d4
 z1FtciYYEmEQWIkxJDkVsxoP4eSufdMN0kP5kxHZG4sKCHcKEKRn9tQwtEWX9OEMbkOV
 GLz7+6lkA70n4HRuvxPNV3CjfOucQBWEePdRTiNfflOb08Fi9eCNfRlkmgiLe8agSMrN rw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rds1uh06b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 13:49:51 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35UCF7hH008611; Fri, 30 Jun 2023 13:49:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx8v0ga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 13:49:50 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UDnmMj039660;
 Fri, 30 Jun 2023 13:49:49 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3rdpx8v0f9-3; Fri, 30 Jun 2023 13:49:49 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 02/10] migration: preserve suspended runstate
Date: Fri, 30 Jun 2023 06:49:40 -0700
Message-Id: <1688132988-314397-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1688132988-314397-1-git-send-email-steven.sistare@oracle.com>
References: <1688132988-314397-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300118
X-Proofpoint-GUID: Q22DSSbxDlKwRrJx58MEXraZeQ9RvrV1
X-Proofpoint-ORIG-GUID: Q22DSSbxDlKwRrJx58MEXraZeQ9RvrV1
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
---
 migration/migration.c |  2 --
 migration/savevm.c    | 13 ++++++++-----
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 17b4b47..5495571 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2101,7 +2101,6 @@ static int postcopy_start(MigrationState *ms)
     qemu_mutex_lock_iothread();
     trace_postcopy_start_set_run();
 
-    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
     global_state_store();
     ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
     if (ret < 0) {
@@ -2307,7 +2306,6 @@ static void migration_completion(MigrationState *s)
     if (s->state == MIGRATION_STATUS_ACTIVE) {
         qemu_mutex_lock_iothread();
         s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
-        qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
 
         s->vm_old_state = runstate_get();
         global_state_store();
diff --git a/migration/savevm.c b/migration/savevm.c
index bc28408..dfdbf02 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2069,12 +2069,15 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 
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


