Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3031743D05
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:52:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFEWx-0006fD-If; Fri, 30 Jun 2023 09:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qFEVd-0006EI-Gr
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:50:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qFEVY-00072H-Le
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:50:01 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UBOaTT011855; Fri, 30 Jun 2023 13:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=tqg7P+hJlWeTBmZ966zG9+KbGAGskbhcMbApZFCqidg=;
 b=GfA+G3QA4JJjbYGk64cNh6ttq5H6XDh5MueesHBEVpPsS8L36N22TKISsiyGaWqYM47F
 EEgzyGvqMZ3jAr/aswiEqPtrMrzWwXQh9/v/qa7UaRlqCbLS4mC74e6h+MSCvuqzO6MI
 lohMkhNegJBIngAGHRjIg447l5IzFHQVFkLmxF2k0L92CtaFqoKV183rpIhy+NnQ1xHx
 CnqjCRtouEiHMPH9nx7b7vnZXqlkFPeDOr6jqXF3uzGfOjHzmSuA2KzmJmDeyyqm+nCN
 6S4Qb1EGECvi3RHz4byU1xOsJy0Eam5UiFFXyRpTK1zYci4ImAkdXlvYdur8SLJeroGb uQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdqdu108w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 13:49:51 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35UDXngi008658; Fri, 30 Jun 2023 13:49:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx8v0gr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 13:49:50 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35UDnmMl039660;
 Fri, 30 Jun 2023 13:49:50 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3rdpx8v0f9-4; Fri, 30 Jun 2023 13:49:50 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 03/10] migration: add runstate function
Date: Fri, 30 Jun 2023 06:49:41 -0700
Message-Id: <1688132988-314397-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1688132988-314397-1-git-send-email-steven.sistare@oracle.com>
References: <1688132988-314397-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=787
 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300118
X-Proofpoint-GUID: WaZzA5g0eKYtO1AMXdZ6lhBOwtgJsl1K
X-Proofpoint-ORIG-GUID: WaZzA5g0eKYtO1AMXdZ6lhBOwtgJsl1K
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

Create a subroutine for preserving the runstate after migration,
to be used in a subsequent patch.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 migration/migration.c | 14 ++++++++++++++
 migration/migration.h |  1 +
 migration/savevm.c    | 11 +----------
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5495571..7a9218b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1125,6 +1125,20 @@ void migrate_set_state(int *state, int old_state, int new_state)
     }
 }
 
+void migrate_set_runstate(void)
+{
+    if (!global_state_received() ||
+        global_state_get_runstate() == RUN_STATE_RUNNING) {
+        if (autostart) {
+            vm_start();
+        } else {
+            runstate_set(RUN_STATE_PAUSED);
+        }
+    } else {
+        runstate_set(global_state_get_runstate());
+    }
+}
+
 static void migrate_fd_cleanup(MigrationState *s)
 {
     qemu_bh_delete(s->cleanup_bh);
diff --git a/migration/migration.h b/migration/migration.h
index 30c3e97..91c66b5 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -443,6 +443,7 @@ struct MigrationState {
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
+void migrate_set_runstate(void);
 
 void migration_fd_process_incoming(QEMUFile *f, Error **errp);
 void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
diff --git a/migration/savevm.c b/migration/savevm.c
index dfdbf02..e0f4972 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2069,16 +2069,7 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 
     dirty_bitmap_mig_before_vm_start();
 
-    if (!global_state_received() ||
-        global_state_get_runstate() == RUN_STATE_RUNNING) {
-        if (autostart) {
-            vm_start();
-        } else {
-            runstate_set(RUN_STATE_PAUSED);
-        }
-    } else {
-        runstate_set(global_state_get_runstate());
-    }
+    migrate_set_runstate();
 
     qemu_bh_delete(mis->bh);
 
-- 
1.8.3.1


