Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87546743D06
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:52:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFEXI-0006z1-Kf; Fri, 30 Jun 2023 09:51:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qFEVa-0006DZ-Ui
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:49:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qFEVX-00072X-EV
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:49:58 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UBOa70015241; Fri, 30 Jun 2023 13:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=kBuaUtzoyCnKRCaXlqAfbP/t5uqZ4dC8JiefplOS4nk=;
 b=JkYgKK0A5Atuw7nnGFcpFuAB4n+nZ3yXeuiG11PUOftbJeOdjIGLh/9fuay3Ra3kLkaz
 EtekORqqlZ5KbfgkfmDhFa5IStihKYNDImfZSJQ1dVE2UBEzk7qiIDeQmTz5IiakBm40
 Jlt0uyk4TFNVjC4bxDEFOZjCa+It1z7oqpGFjIBpjMF/1p0sTfwK9gJrAL5HaTVGmsiL
 EAUZxqKbWVMqV0uCSVLy++UFiFw0EtT6V3BIQoXMizDQCQIENQU6kGb71LtT4ADxZGp7
 CURZBmzLpZdSRKY9hiEojCe0YW7A25LDo+IrY2jdm9soOQxKJ3JFAy8Ldhdt8kIxXMy7 6Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrcagh0u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 13:49:52 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35UDXngj008658; Fri, 30 Jun 2023 13:49:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx8v0hp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 13:49:52 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UDnmMp039660;
 Fri, 30 Jun 2023 13:49:51 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3rdpx8v0f9-6; Fri, 30 Jun 2023 13:49:51 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 05/10] migration: preserve suspended for bg_migration
Date: Fri, 30 Jun 2023 06:49:43 -0700
Message-Id: <1688132988-314397-6-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: ZrJ3L3-4mybxSvYX1nVNdbYu33E8NVeB
X-Proofpoint-GUID: ZrJ3L3-4mybxSvYX1nVNdbYu33E8NVeB
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

Do not wake a suspended guest during bg_migration.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 migration/migration.c | 12 +++++-------
 softmmu/runstate.c    |  1 +
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 7a9218b..125e060 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3044,7 +3044,9 @@ static void bg_migration_vm_start_bh(void *opaque)
     qemu_bh_delete(s->vm_start_bh);
     s->vm_start_bh = NULL;
 
-    vm_start();
+    if (!runstate_check(RUN_STATE_SUSPENDED)) {
+        vm_start();
+    }
     s->downtime = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - s->downtime_start;
 }
 
@@ -3114,16 +3116,12 @@ static void *bg_migration_thread(void *opaque)
 
     qemu_mutex_lock_iothread();
 
-    /*
-     * If VM is currently in suspended state, then, to make a valid runstate
-     * transition in vm_stop_force_state() we need to wakeup it up.
-     */
-    qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
     s->vm_old_state = runstate_get();
 
     global_state_store();
     /* Forcibly stop VM before saving state of vCPUs and devices */
-    if (vm_stop_force_state(RUN_STATE_PAUSED)) {
+    if (!runstate_check(RUN_STATE_SUSPENDED) &&
+        vm_stop_force_state(RUN_STATE_PAUSED)) {
         goto fail;
     }
     /*
diff --git a/softmmu/runstate.c b/softmmu/runstate.c
index 18efe31..35ce343 100644
--- a/softmmu/runstate.c
+++ b/softmmu/runstate.c
@@ -163,6 +163,7 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_SUSPENDED, RUN_STATE_FINISH_MIGRATE },
     { RUN_STATE_SUSPENDED, RUN_STATE_PRELAUNCH },
     { RUN_STATE_SUSPENDED, RUN_STATE_COLO},
+    { RUN_STATE_SUSPENDED, RUN_STATE_PAUSED },
 
     { RUN_STATE_WATCHDOG, RUN_STATE_RUNNING },
     { RUN_STATE_WATCHDOG, RUN_STATE_FINISH_MIGRATE },
-- 
1.8.3.1


