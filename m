Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFC077C01B
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 20:56:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVciR-0005ZC-Ku; Mon, 14 Aug 2023 14:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qVciG-0005WW-Uv
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 14:54:48 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qVciE-0007rs-5L
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 14:54:48 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37EGTtsj017832; Mon, 14 Aug 2023 18:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=0NZPE22R3UYV4oKfX1wrAJjkce8BAh+QitD5ICo+hVk=;
 b=HqzhoeMHepBnS/lVq5XwuFKnEx05d2rpxX6ed/d9h7ODNKhsxYrWzoa7U+FFmyRNwHEO
 RJG60muTOvWwMwRSXs/Cit3PVbBnzanU4jyqw6e12ojpgiUcbZXfYQorFKXj4/JdQQZQ
 kv23brxczOxp8yBAPXymUUCOj+F9BdHUDHOtVagx/aQiINkBzfAeLO8byRp78Hey2bNQ
 xGFoWHB3iMRz16QPKzuWoT26/Y28brXDOSAU+PWBBvdamlRzzmWp6GPgPvxuWem06lmD
 Qc/bWFIUEi/MrRfT9w46zCC1VlwhenJF58kIny9Eh834b28SBDbPa8mV8lQEgE1xgiad uQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se61c37kg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Aug 2023 18:54:41 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37EIj4UT006703; Mon, 14 Aug 2023 18:54:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3sey2c8x5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Aug 2023 18:54:41 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37EIsb3r008127;
 Mon, 14 Aug 2023 18:54:40 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3sey2c8x3f-4; Mon, 14 Aug 2023 18:54:40 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 03/10] migration: add runstate function
Date: Mon, 14 Aug 2023 11:54:29 -0700
Message-Id: <1692039276-148610-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1692039276-148610-1-git-send-email-steven.sistare@oracle.com>
References: <1692039276-148610-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_15,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0
 mlxlogscore=791 bulkscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140175
X-Proofpoint-GUID: ZGai889Ay75fWH_6ao9qtz-NghWflok6
X-Proofpoint-ORIG-GUID: ZGai889Ay75fWH_6ao9qtz-NghWflok6
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

Create a subroutine for preserving the runstate after migration,
to be used in a subsequent patch.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 14 ++++++++++++++
 migration/migration.h |  1 +
 migration/savevm.c    | 11 +----------
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 51ace82..1a5484a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1141,6 +1141,20 @@ void migrate_set_state(int *state, int old_state, int new_state)
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
index 6eea18d..45e9805 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -456,6 +456,7 @@ struct MigrationState {
 };
 
 void migrate_set_state(int *state, int old_state, int new_state);
+void migrate_set_runstate(void);
 
 void migration_fd_process_incoming(QEMUFile *f, Error **errp);
 void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
diff --git a/migration/savevm.c b/migration/savevm.c
index be42d0a..eba3653 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2070,16 +2070,7 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 
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


