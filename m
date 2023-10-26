Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD527D897E
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 22:09:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw6fB-0004hD-GD; Thu, 26 Oct 2023 16:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qw6et-0004F2-UG
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 16:08:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qw6en-0008SA-W1
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 16:08:46 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39QJsL8p028643; Thu, 26 Oct 2023 20:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=D/fwwIW1ANeTA1KdqAle5D+G6L4iCHzY6a0qgjXAmrg=;
 b=1BM3gBXypfjMaYQ9/ZtfOeqLgTvwnAK1Ik0tdj5oE62nwsNNoYcjNnDP2/NzpspZ4bNV
 pjFbCetWfJHOu9pcL1iQfe6DmQd3hzFdrzmg7h+YJIQIGpHV+fMvzQXFUGawsq9ynjGs
 EzE5mHCXmiSwcGHtNiT1Y4tYpVD9bUMwi9a4vCIDoFDwyKYKnn1nZefiO3iJnpnh66Rd
 j+QisS1BTjb53AXibr/CAOeHql2AuuLigs3ltMI+i21ba9QbteO/T6WPkhrHx2uY0TeI
 HHEGQ/oSc346/PBeNAs+s4zoKWVjhl45f0C/nSwopomuB0DLJE2Y9vHcCtoAWuvUcrs3 0A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tyxmv8122-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 20:08:36 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39QImnPX009243; Thu, 26 Oct 2023 20:08:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tywqhtymv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Oct 2023 20:08:35 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39QK8YLp036361;
 Thu, 26 Oct 2023 20:08:35 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3tywqhtykn-3; Thu, 26 Oct 2023 20:08:35 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 2/6] migration: per-mode blockers
Date: Thu, 26 Oct 2023 13:08:29 -0700
Message-Id: <1698350913-415926-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1698350913-415926-1-git-send-email-steven.sistare@oracle.com>
References: <1698350913-415926-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_19,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 mlxscore=0
 spamscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310260174
X-Proofpoint-GUID: iquyIILZZb-LWuFLX_ipfHjBACiL8p7S
X-Proofpoint-ORIG-GUID: iquyIILZZb-LWuFLX_ipfHjBACiL8p7S
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Extend the blocker interface so that a blocker can be registered for
one or more migration modes.  The existing interfaces register a
blocker for all modes, and the new interfaces take a varargs list
of modes.

Internally, maintain a separate blocker list per mode.  The same Error
object may be added to multiple lists.  When a block is deleted, it is
removed from every list, and the Error is freed.

No functional change until a new mode is added.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/blocker.h | 44 +++++++++++++++++++--
 migration/migration.c       | 95 ++++++++++++++++++++++++++++++++++++++-------
 stubs/migr-blocker.c        | 10 +++++
 3 files changed, 132 insertions(+), 17 deletions(-)

diff --git a/include/migration/blocker.h b/include/migration/blocker.h
index b048f30..a687ac0 100644
--- a/include/migration/blocker.h
+++ b/include/migration/blocker.h
@@ -14,8 +14,12 @@
 #ifndef MIGRATION_BLOCKER_H
 #define MIGRATION_BLOCKER_H
 
+#include "qapi/qapi-types-migration.h"
+
+#define MIG_MODE_ALL MIG_MODE__MAX
+
 /**
- * @migrate_add_blocker - prevent migration from proceeding
+ * @migrate_add_blocker - prevent all modes of migration from proceeding
  *
  * @reasonp - address of an error to be returned whenever migration is attempted
  *
@@ -30,8 +34,8 @@
 int migrate_add_blocker(Error **reasonp, Error **errp);
 
 /**
- * @migrate_add_blocker_internal - prevent migration from proceeding without
- *                                 only-migrate implications
+ * @migrate_add_blocker_internal - prevent all modes of migration from
+ *                                 proceeding, but ignore -only-migratable
  *
  * @reasonp - address of an error to be returned whenever migration is attempted
  *
@@ -50,7 +54,7 @@ int migrate_add_blocker(Error **reasonp, Error **errp);
 int migrate_add_blocker_internal(Error **reasonp, Error **errp);
 
 /**
- * @migrate_del_blocker - remove a blocking error from migration and free it.
+ * @migrate_del_blocker - remove a migration blocker from all modes and free it.
  *
  * @reasonp - address of the error blocking migration
  *
@@ -58,4 +62,36 @@ int migrate_add_blocker_internal(Error **reasonp, Error **errp);
  */
 void migrate_del_blocker(Error **reasonp);
 
+/**
+ * @migrate_add_blocker_normal - prevent normal migration mode from proceeding
+ *
+ * @reasonp - address of an error to be returned whenever migration is attempted
+ *
+ * @errp - [out] The reason (if any) we cannot block migration right now.
+ *
+ * @returns - 0 on success, -EBUSY/-EACCES on failure, with errp set.
+ *
+ * *@reasonp is freed and set to NULL if failure is returned.
+ * On success, the caller must not free @reasonp, except by
+ *   calling migrate_del_blocker.
+ */
+int migrate_add_blocker_normal(Error **reasonp, Error **errp);
+
+/**
+ * @migrate_add_blocker_modes - prevent some modes of migration from proceeding
+ *
+ * @reasonp - address of an error to be returned whenever migration is attempted
+ *
+ * @errp - [out] The reason (if any) we cannot block migration right now.
+ *
+ * @mode - one or more migration modes to be blocked.  The list is terminated
+ *         by -1 or MIG_MODE_ALL.  For the latter, all modes are blocked.
+ *
+ * @returns - 0 on success, -EBUSY/-EACCES on failure, with errp set.
+ *
+ * *@reasonp is freed and set to NULL if failure is returned.
+ * On success, the caller must not free *@reasonp before the blocker is removed.
+ */
+int migrate_add_blocker_modes(Error **reasonp, Error **errp, MigMode mode, ...);
+
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 67547eb..b8b54e6 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -92,7 +92,7 @@ enum mig_rp_message_type {
 static MigrationState *current_migration;
 static MigrationIncomingState *current_incoming;
 
-static GSList *migration_blockers;
+static GSList *migration_blockers[MIG_MODE__MAX];
 
 static bool migration_object_check(MigrationState *ms, Error **errp);
 static int migration_maybe_pause(MigrationState *s,
@@ -1011,7 +1011,7 @@ static void fill_source_migration_info(MigrationInfo *info)
 {
     MigrationState *s = migrate_get_current();
     int state = qatomic_read(&s->state);
-    GSList *cur_blocker = migration_blockers;
+    GSList *cur_blocker = migration_blockers[migrate_mode()];
 
     info->blocked_reasons = NULL;
 
@@ -1475,38 +1475,105 @@ int migrate_init(MigrationState *s, Error **errp)
     return 0;
 }
 
-int migrate_add_blocker_internal(Error **reasonp, Error **errp)
+static bool is_busy(Error **reasonp, Error **errp)
 {
+    ERRP_GUARD();
+
     /* Snapshots are similar to migrations, so check RUN_STATE_SAVE_VM too. */
     if (runstate_check(RUN_STATE_SAVE_VM) || !migration_is_idle()) {
         error_propagate_prepend(errp, *reasonp,
                                 "disallowing migration blocker "
                                 "(migration/snapshot in progress) for: ");
         *reasonp = NULL;
-        return -EBUSY;
+        return true;
     }
-
-    migration_blockers = g_slist_prepend(migration_blockers, *reasonp);
-    return 0;
+    return false;
 }
 
-int migrate_add_blocker(Error **reasonp, Error **errp)
+static bool is_only_migratable(Error **reasonp, Error **errp, int modes)
 {
-    if (only_migratable) {
+    ERRP_GUARD();
+
+    if (only_migratable && (modes & BIT(MIG_MODE_NORMAL))) {
         error_propagate_prepend(errp, *reasonp,
                                 "disallowing migration blocker "
                                 "(--only-migratable) for: ");
         *reasonp = NULL;
+        return true;
+    }
+    return false;
+}
+
+static int get_modes(MigMode mode, va_list ap)
+{
+    int modes = 0;
+
+    while (mode != -1 && mode != MIG_MODE_ALL) {
+        assert(mode >= MIG_MODE_NORMAL && mode < MIG_MODE__MAX);
+        modes |= BIT(mode);
+        mode = va_arg(ap, MigMode);
+    }
+    if (mode == MIG_MODE_ALL) {
+        modes = BIT(MIG_MODE__MAX) - 1;
+    }
+    return modes;
+}
+
+static int add_blockers(Error **reasonp, Error **errp, int modes)
+{
+    for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
+        if (modes & BIT(mode)) {
+            migration_blockers[mode] = g_slist_prepend(migration_blockers[mode],
+                                                       *reasonp);
+        }
+    }
+    return 0;
+}
+
+int migrate_add_blocker(Error **reasonp, Error **errp)
+{
+    return migrate_add_blocker_modes(reasonp, errp, MIG_MODE_ALL);
+}
+
+int migrate_add_blocker_normal(Error **reasonp, Error **errp)
+{
+    return migrate_add_blocker_modes(reasonp, errp, MIG_MODE_NORMAL, -1);
+}
+
+int migrate_add_blocker_modes(Error **reasonp, Error **errp, MigMode mode, ...)
+{
+    int modes;
+    va_list ap;
+
+    va_start(ap, mode);
+    modes = get_modes(mode, ap);
+    va_end(ap);
+
+    if (is_only_migratable(reasonp, errp, modes)) {
         return -EACCES;
+    } else if (is_busy(reasonp, errp)) {
+        return -EBUSY;
     }
+    return add_blockers(reasonp, errp, modes);
+}
 
-    return migrate_add_blocker_internal(reasonp, errp);
+int migrate_add_blocker_internal(Error **reasonp, Error **errp)
+{
+    int modes = BIT(MIG_MODE__MAX) - 1;
+
+    if (is_busy(reasonp, errp)) {
+        return -EBUSY;
+    }
+    return add_blockers(reasonp, errp, modes);
 }
 
 void migrate_del_blocker(Error **reasonp)
 {
     if (*reasonp) {
-        migration_blockers = g_slist_remove(migration_blockers, *reasonp);
+        for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
+            migration_blockers[mode] = g_slist_remove(migration_blockers[mode],
+                                                      *reasonp);
+        }
         error_free(*reasonp);
         *reasonp = NULL;
     }
@@ -1602,12 +1669,14 @@ void qmp_migrate_pause(Error **errp)
 
 bool migration_is_blocked(Error **errp)
 {
+    GSList *blockers = migration_blockers[migrate_mode()];
+
     if (qemu_savevm_state_blocked(errp)) {
         return true;
     }
 
-    if (migration_blockers) {
-        error_propagate(errp, error_copy(migration_blockers->data));
+    if (blockers) {
+        error_propagate(errp, error_copy(blockers->data));
         return true;
     }
 
diff --git a/stubs/migr-blocker.c b/stubs/migr-blocker.c
index 17a5dbf..11cbff2 100644
--- a/stubs/migr-blocker.c
+++ b/stubs/migr-blocker.c
@@ -6,6 +6,16 @@ int migrate_add_blocker(Error **reasonp, Error **errp)
     return 0;
 }
 
+int migrate_add_blocker_normal(Error **reasonp, Error **errp)
+{
+    return 0;
+}
+
+int migrate_add_blocker_modes(Error **reasonp, Error **errp, MigMode mode, ...)
+{
+    return 0;
+}
+
 void migrate_del_blocker(Error **reasonp)
 {
 }
-- 
1.8.3.1


