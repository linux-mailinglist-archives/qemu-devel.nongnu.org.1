Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F27077D0356
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 22:49:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtZw9-0007Pb-2d; Thu, 19 Oct 2023 16:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qtZvz-0007G4-4p
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 16:47:59 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qtZvu-0003To-IP
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 16:47:58 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JKi5RF028662; Thu, 19 Oct 2023 20:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=q8E4V2n2dPrbJ5dVbcfm802wPss1Ul4Z/5tl9bw+K7I=;
 b=dT/Tz02zCaRePHme6C7rRtPTDL04F+qPscTn+qEbG11NE/JfZ+dtnRwCQvO+xnDtjL+n
 h9MpIpTUGu1gUSXNSNumHLS2uAUEkWh4pnsb5Ww0HGjmQ7Y2Yv4NEff6+s7S9xeni4GV
 lBNaJqrWyBKa6jum8yY43EclaoZrIdjdpj679DwjFIuh4QedHxPYkB3TR+Gxo8PlBLhO
 Ckvm4fXipe4EjWTry7G/jhW9kv37Ep47vDwehYwxUeRxPA+8++N52omGzWxR6RshpYBy
 GQEMvueLbGTgqfPtVNvLimYFQbAsJmQGm3+3DChUkl7szr4u3/714AgqBCB65np/XKFE GA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqkhubuga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 20:47:51 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39JJtgbX040431; Thu, 19 Oct 2023 20:47:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3trfyqqaj0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 20:47:50 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39JKllWK014514;
 Thu, 19 Oct 2023 20:47:49 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3trfyqqafy-3; Thu, 19 Oct 2023 20:47:49 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 2/4] migration: per-mode blockers
Date: Thu, 19 Oct 2023 13:47:44 -0700
Message-Id: <1697748466-373230-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_20,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190176
X-Proofpoint-GUID: BT8CdHFrqyiwIxAlTJOo35VG_Tm9npJV
X-Proofpoint-ORIG-GUID: BT8CdHFrqyiwIxAlTJOo35VG_Tm9npJV
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


