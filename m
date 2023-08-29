Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 857EE78CFF6
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:09:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7my-0000lW-HX; Tue, 29 Aug 2023 19:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qb3IA-0002aq-CY
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:18:18 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qb3I5-0003Ux-Fj
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 14:18:18 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37THnL1d021261; Tue, 29 Aug 2023 18:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=P9YuFI3pEGxSQ80k/zVw2ifGJXLSaaHRqk8odCfdN2I=;
 b=rJB6CeiRDF8ELSWjix4oYwXaorcqhFBrHK9S4Nld2ZYIt2oEn5D9VirJy4SzWXkjX541
 kvef5hFBITBcJ8Wrau1cu8Az0ao1YZhxSDlQi+uWmGow9VC3oqRYpMabpO5iEHGhGWmc
 llj+25stEx/tz5pxp0MNS3CcnPK/bGSSe457PbAbxUjCp2806ERChiQe6lrXiUyFoo0x
 jPI5lcF3Eoji+xM0sHcjqir/SVanjXWhBEFTnnjTDNV2SX6XoAlAMdjNZsnz7N2cG9pY
 XiLb9kDb2t1VYOkQoMCqrHfG86h6+XhQKlazPv3P0C75xEYlyk+qWzCbceBDwfuXINNY 5Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9nywk2u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Aug 2023 18:18:10 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37THDvpC024829; Tue, 29 Aug 2023 18:18:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3sr6dnfwjw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 29 Aug 2023 18:18:09 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37TII6lu011911;
 Tue, 29 Aug 2023 18:18:08 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3sr6dnfwgx-4; Tue, 29 Aug 2023 18:18:08 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 03/11] migration: add runstate function
Date: Tue, 29 Aug 2023 11:17:58 -0700
Message-Id: <1693333086-392798-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
References: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_13,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=849 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308290158
X-Proofpoint-ORIG-GUID: 8-Mu_NXmhG9o2K-ObEeEU7kr16ZygBtv
X-Proofpoint-GUID: 8-Mu_NXmhG9o2K-ObEeEU7kr16ZygBtv
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
 migration/migration.c | 37 ++++++++++++++++++++++---------------
 migration/migration.h |  1 +
 migration/savevm.c    | 13 +------------
 3 files changed, 24 insertions(+), 27 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5bcc761..a9ecb66 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -486,21 +486,8 @@ static void process_incoming_migration_bh(void *opaque)
 
     dirty_bitmap_mig_before_vm_start();
 
-    if (!global_state_received() ||
-        global_state_get_runstate() == RUN_STATE_RUNNING) {
-        if (autostart) {
-            vm_start();
-        } else {
-            runstate_set(RUN_STATE_PAUSED);
-        }
-    } else if (migration_incoming_colo_enabled()) {
-        migration_incoming_disable_colo();
-        vm_start();
-    } else if (global_state_get_runstate() == RUN_STATE_SUSPENDED) {
-        vm_prepare_start(false, global_state_get_runstate());
-    } else {
-        runstate_set(global_state_get_runstate());
-    }
+    migrate_set_runstate();
+
     /*
      * This must happen after any state changes since as soon as an external
      * observer sees this event they might start to prod at the VM assuming
@@ -1143,6 +1130,26 @@ void migrate_set_state(int *state, int old_state, int new_state)
     }
 }
 
+void migrate_set_runstate(void)
+{
+    RunState state = global_state_get_runstate();
+
+    if (!global_state_received() || state == RUN_STATE_RUNNING) {
+        if (autostart) {
+            vm_start();
+        } else {
+            runstate_set(RUN_STATE_PAUSED);
+        }
+    } else if (migration_incoming_colo_enabled()) {
+        migration_incoming_disable_colo();
+        vm_start();
+    } else if (state == RUN_STATE_SUSPENDED) {
+        vm_prepare_start(false, state);
+    } else {
+        runstate_set(state);
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
index bae0a1a..eba3653 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2070,18 +2070,7 @@ static void loadvm_postcopy_handle_run_bh(void *opaque)
 
     dirty_bitmap_mig_before_vm_start();
 
-    if (!global_state_received() ||
-        global_state_get_runstate() == RUN_STATE_RUNNING) {
-        if (autostart) {
-            vm_start();
-        } else {
-            runstate_set(RUN_STATE_PAUSED);
-        }
-    } else if (global_state_get_runstate() == RUN_STATE_SUSPENDED) {
-        vm_prepare_start(false, RUN_STATE_SUSPENDED);
-    } else {
-        runstate_set(global_state_get_runstate());
-    }
+    migrate_set_runstate();
 
     qemu_bh_delete(mis->bh);
 
-- 
1.8.3.1


