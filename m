Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 507FB7320EB
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 22:28:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9tYR-000280-EW; Thu, 15 Jun 2023 16:26:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q9tYP-00027S-BH
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 16:26:49 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q9tYM-0002Fd-MB
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 16:26:49 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35FGJdZx008812; Thu, 15 Jun 2023 20:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=UrGXqxFBJy4IvvQ8t8I7N5k6cfcseo9TsBBmEA7yFYA=;
 b=KnTDlXgN3we7GDS7MyPoJwAF0Au9yC8N74/KsL5aqaQj6rMADoQOd0+j+CLKT087jZ8/
 xZNRyoTLl7ymwuByD/0olPnEfJStUvWVOcEjOATlyN2iGiV0GRLHGQ923Lxhzc7Z6tSZ
 q7TNvoGtHddRVbl7SLyl9faXyfH4sYKvW3EXA4fK0s5nihCt/qc4h3z5Oa+q0ePdlThp
 F2tuegCJMNDmcGDjo6a33xK2anpUQeUl4TbXAmNGX5zcS1GaqGDMu6ApVksSK1gThL2c
 A0351J2lHQj6mG2sXr1sMwANlL8NQbQqYrZ/3DHZq1GpC7qbdrpVDZblp2q3vEKKxjXO Bw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h2atv98-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Jun 2023 20:26:42 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35FK0mAW039111; Thu, 15 Jun 2023 20:26:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fm75mnq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Jun 2023 20:26:42 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35FKQeq8003391;
 Thu, 15 Jun 2023 20:26:41 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3r4fm75mmg-3; Thu, 15 Jun 2023 20:26:41 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 2/3] migration: fix suspended runstate
Date: Thu, 15 Jun 2023 13:26:39 -0700
Message-Id: <1686860800-34667-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1686860800-34667-1-git-send-email-steven.sistare@oracle.com>
References: <1686860800-34667-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-15_16,2023-06-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150176
X-Proofpoint-ORIG-GUID: QQLkQ2RcB1Q25_xwNgDIwBrT_7JoldqI
X-Proofpoint-GUID: QQLkQ2RcB1Q25_xwNgDIwBrT_7JoldqI
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

Migration of a guest in the suspended state is broken.  The incoming
migration code automatically tries to wake the guest, which IMO is
wrong -- the guest should end migration in the same state it started.
Further, the wakeup is done by calling qemu_system_wakeup_request(), which
bypasses vm_start().  The guest appears to be in the running state, but
it is not.

To fix, leave the guest in the suspended state, but call
qemu_system_start_on_wakeup_request() so the guest is properly resumed
later, when the client sends a system_wakeup command.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 migration/migration.c | 11 ++++-------
 softmmu/runstate.c    |  1 +
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 17b4b47..851fe6d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -496,6 +496,10 @@ static void process_incoming_migration_bh(void *opaque)
         vm_start();
     } else {
         runstate_set(global_state_get_runstate());
+        if (runstate_check(RUN_STATE_SUSPENDED)) {
+            /* Force vm_start to be called later. */
+            qemu_system_start_on_wakeup_request();
+        }
     }
     /*
      * This must happen after any state changes since as soon as an external
@@ -2101,7 +2105,6 @@ static int postcopy_start(MigrationState *ms)
     qemu_mutex_lock_iothread();
     trace_postcopy_start_set_run();
 
-    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
     global_state_store();
     ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
     if (ret < 0) {
@@ -2307,7 +2310,6 @@ static void migration_completion(MigrationState *s)
     if (s->state == MIGRATION_STATUS_ACTIVE) {
         qemu_mutex_lock_iothread();
         s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
-        qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
 
         s->vm_old_state = runstate_get();
         global_state_store();
@@ -3102,11 +3104,6 @@ static void *bg_migration_thread(void *opaque)
 
     qemu_mutex_lock_iothread();
 
-    /*
-     * If VM is currently in suspended state, then, to make a valid runstate
-     * transition in vm_stop_force_state() we need to wakeup it up.
-     */
-    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
     s->vm_old_state = runstate_get();
 
     global_state_store();
diff --git a/softmmu/runstate.c b/softmmu/runstate.c
index e127b21..771896c 100644
--- a/softmmu/runstate.c
+++ b/softmmu/runstate.c
@@ -159,6 +159,7 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_RUNNING, RUN_STATE_SUSPENDED },
     { RUN_STATE_SUSPENDED, RUN_STATE_RUNNING },
     { RUN_STATE_SUSPENDED, RUN_STATE_FINISH_MIGRATE },
+    { RUN_STATE_SUSPENDED, RUN_STATE_PAUSED },
     { RUN_STATE_SUSPENDED, RUN_STATE_PRELAUNCH },
     { RUN_STATE_SUSPENDED, RUN_STATE_COLO},
 
-- 
1.8.3.1


