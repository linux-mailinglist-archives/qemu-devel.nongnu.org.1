Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FF37AF07E
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 18:19:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlAmB-0002co-Kb; Tue, 26 Sep 2023 12:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qlAm9-0002cS-Mh
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:19:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qlAm6-0004qk-9J
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:19:05 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38QFOGGh012299; Tue, 26 Sep 2023 16:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-03-30;
 bh=Xr36l8WWm2fA0qQlHeA3gszn8JlFpazIANHUFIyRB2s=;
 b=v10LzEDwLjOmph5k2bzdj75dUOCCO87mM/yyK18R68dhFTeQ/qbmWZb4ESfVCTCWPdVQ
 0mrdQniLRxd422feDnkD3lHb5yTv+Z/6+l0AUnHjlD30cOTASRL6IwW1HWZ0PdnYFcqp
 hLUtxGXWiKshsLkFiaaIX8GAlFghbLj5TjzHiL1nSIUyjDWdE1b/00gsVvt8rr8x8AuK
 Nosuh+TyRHUN4/nnmtWrk3VSZ/bbXannZ33oOP9qz/gYa2RKN+eG65xoli4rR1qJyCTz
 POdxSqwl8zrTB0k66F0jQvMhaXlBuELZFBk2eerSKdkV9DTuBaZ9k8VJsjC3qHZNYtJ/ ng== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pee6yve-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 16:18:59 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38QFTek5039482; Tue, 26 Sep 2023 16:18:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t9pfceaek-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 26 Sep 2023 16:18:59 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38QGIt9r007977;
 Tue, 26 Sep 2023 16:18:58 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-210-190.vpn.oracle.com
 [10.175.210.190])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 3t9pfcea8h-2; Tue, 26 Sep 2023 16:18:58 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH 1/5] migration: Store downtime timestamps in an array
Date: Tue, 26 Sep 2023 17:18:37 +0100
Message-Id: <20230926161841.98464-2-joao.m.martins@oracle.com>
In-Reply-To: <20230926161841.98464-1-joao.m.martins@oracle.com>
References: <20230926161841.98464-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_13,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309260143
X-Proofpoint-ORIG-GUID: 9H6ZoGZX7TF40KUkOOkTCzVvqI1ofx6E
X-Proofpoint-GUID: 9H6ZoGZX7TF40KUkOOkTCzVvqI1ofx6E
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Right now downtime_start is stored in MigrationState.

In preparation to having more downtime timestamps during
switchover, move downtime_start to an array namely, @timestamp.

Add a setter/getter surrounding which timestamps to record,
to make it easier to spread to various migration functions.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 qapi/migration.json   | 14 ++++++++++++++
 migration/migration.h |  7 +++++--
 migration/migration.c | 24 ++++++++++++++++++++----
 3 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 8843e74b59c7..b836cc881d33 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -190,6 +190,20 @@
 { 'struct': 'VfioStats',
   'data': {'transferred': 'int' } }
 
+##
+# @MigrationDowntime:
+#
+# An enumeration of downtime timestamps for all
+# steps of the switchover.
+#
+# @start:Timestamp taken at the start of the switchover right before
+#        we stop the VM.
+#
+# Since: 8.2
+##
+{ 'enum': 'MigrationDowntime',
+  'data': [ 'start' ] }
+
 ##
 # @MigrationInfo:
 #
diff --git a/migration/migration.h b/migration/migration.h
index c390500604b6..180dc31c5306 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -319,8 +319,8 @@ struct MigrationState {
     int64_t start_time;
     /* Total time used by latest migration (ms) */
     int64_t total_time;
-    /* Timestamp when VM is down (ms) to migrate the last stuff */
-    int64_t downtime_start;
+    /* Timestamps e.g. when VM is down (ms) to migrate the last stuff */
+    int64_t timestamp[MIGRATION_DOWNTIME__MAX];
     int64_t downtime;
     int64_t expected_downtime;
     bool capabilities[MIGRATION_CAPABILITY__MAX];
@@ -516,4 +516,7 @@ void migration_populate_vfio_info(MigrationInfo *info);
 void migration_reset_vfio_bytes_transferred(void);
 void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
 
+void migration_set_timestamp(MigrationDowntime tm);
+int64_t migration_get_timestamp(MigrationDowntime tm);
+
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index d61e5727429a..dd955c61acc7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2312,6 +2312,21 @@ static int migration_maybe_pause(MigrationState *s,
     return s->state == new_state ? 0 : -EINVAL;
 }
 
+void migration_set_timestamp(MigrationDowntime type)
+{
+    MigrationState *s = migrate_get_current();
+
+    s->timestamp[type] = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+}
+
+int64_t migration_get_timestamp(MigrationDowntime type)
+{
+    MigrationState *s = migrate_get_current();
+
+    return s->timestamp[type];
+}
+
+
 /**
  * migration_completion: Used by migration_thread when there's not much left.
  *   The caller 'breaks' the loop when this returns.
@@ -2325,7 +2340,7 @@ static void migration_completion(MigrationState *s)
 
     if (s->state == MIGRATION_STATUS_ACTIVE) {
         qemu_mutex_lock_iothread();
-        s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+        migration_set_timestamp(MIGRATION_DOWNTIME_START);
         qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
 
         s->vm_old_state = runstate_get();
@@ -2670,7 +2685,7 @@ static void migration_calculate_complete(MigrationState *s)
          * It's still not set, so we are precopy migration.  For
          * postcopy, downtime is calculated during postcopy_start().
          */
-        s->downtime = end_time - s->downtime_start;
+        s->downtime = end_time - migration_get_timestamp(MIGRATION_DOWNTIME_START);
     }
 
     transfer_time = s->total_time - s->setup_time;
@@ -3069,7 +3084,8 @@ static void bg_migration_vm_start_bh(void *opaque)
     s->vm_start_bh = NULL;
 
     vm_start();
-    s->downtime = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - s->downtime_start;
+    s->downtime = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) -
+             migration_get_timestamp(MIGRATION_DOWNTIME_START);
 }
 
 /**
@@ -3134,7 +3150,7 @@ static void *bg_migration_thread(void *opaque)
     s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
 
     trace_migration_thread_setup_complete();
-    s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    migration_set_timestamp(MIGRATION_DOWNTIME_START);
 
     qemu_mutex_lock_iothread();
 
-- 
2.39.3


