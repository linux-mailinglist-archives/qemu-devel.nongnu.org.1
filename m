Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E2E82C27C
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 16:06:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOJ6F-000116-Hi; Fri, 12 Jan 2024 10:05:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOJ63-0000yP-Qt
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:05:24 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOJ61-0003b5-8Q
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:05:23 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40CEbRYb031080; Fri, 12 Jan 2024 15:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=pB10J5V4TlIpT6ePOcS4re0fCAW0nJLVqS3xWAeCGdg=;
 b=nZnCmoMSZ8D9SsxnfOdHzoWuNWg3bBwrUM5otjfT3ZgwGKvgxF6bkrdb6hEnBqUEWTm1
 Wnxk5vvm+QVjotFts01AZxvHIdnQk1l5JCjjufDnnUwjDzULF/RvWG6YuOVSGGxlFRiB
 h6SoiatXNH9rolz2nWuPVMSxOuNkygjsEB9UZjZNMIHvr6cs5HXg2FTwgqmPQ5NyXCIM
 4BOgk/eMkXhq0B/s9E1ZZ582aQ+So8XrU+U/teFFMXNHNHtMQDyd5HyItiIPJ8iLyFND
 FuCrslL0ovNdGLOtEnNJ/juIAC8QlqiXd+RDXbcW2KDjbpfrgMlI4w++F3c3Uto0/Vx9 tQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vk7bmg30n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 15:05:19 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40CEYT8t013975; Fri, 12 Jan 2024 15:05:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vfurgd8s1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 15:05:18 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40CF5BoO017833;
 Fri, 12 Jan 2024 15:05:18 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3vfurgd8k6-10; Fri, 12 Jan 2024 15:05:18 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 09/11] migration: notifier error checking
Date: Fri, 12 Jan 2024 07:05:08 -0800
Message-Id: <1705071910-174321-10-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1705071910-174321-1-git-send-email-steven.sistare@oracle.com>
References: <1705071910-174321-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-12_06,2024-01-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401120117
X-Proofpoint-GUID: kY1BGuIMhKB-tM5N-8FvLpjU2Qy-ZaH8
X-Proofpoint-ORIG-GUID: kY1BGuIMhKB-tM5N-8FvLpjU2Qy-ZaH8
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Check the status returned by migration notifiers and report errors.
If notifiers fail, call the notifiers again so they can clean up.
None of the notifiers return an error status at this time.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/misc.h |  2 +-
 migration/migration.c    | 37 ++++++++++++++++++++++++++++---------
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index e79694f..782bdec 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -73,7 +73,7 @@ void migration_add_notifier(NotifierWithReturn *notify,
 void migration_add_notifier_mode(NotifierWithReturn *notify,
                                  MigrationNotifyFunc func, MigMode mode);
 void migration_remove_notifier(NotifierWithReturn *notify);
-void migration_call_notifiers(MigrationState *s);
+int migration_call_notifiers(MigrationState *s, Error **errp);
 bool migration_in_setup(MigrationState *);
 bool migration_has_finished(MigrationState *);
 bool migration_has_failed(MigrationState *);
diff --git a/migration/migration.c b/migration/migration.c
index c828ba7..86a5a94 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1274,6 +1274,8 @@ void migrate_set_state(int *state, int old_state, int new_state)
 
 static void migrate_fd_cleanup(MigrationState *s)
 {
+    Error *local_err = NULL;
+
     qemu_bh_delete(s->cleanup_bh);
     s->cleanup_bh = NULL;
 
@@ -1321,11 +1323,23 @@ static void migrate_fd_cleanup(MigrationState *s)
                           MIGRATION_STATUS_CANCELLED);
     }
 
+    if (!migration_has_failed(s) &&
+        migration_call_notifiers(s, &local_err)) {
+
+        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+        migrate_set_error(s, local_err);
+        error_free(local_err);
+    }
+
     if (s->error) {
         /* It is used on info migrate.  We can't free it */
         error_report_err(error_copy(s->error));
     }
-    migration_call_notifiers(s);
+
+    if (migration_has_failed(s)) {
+        migration_call_notifiers(s, NULL);
+    }
+
     block_cleanup_parameters();
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
@@ -1450,13 +1464,14 @@ void migration_remove_notifier(NotifierWithReturn *notify)
     }
 }
 
-void migration_call_notifiers(MigrationState *s)
+int migration_call_notifiers(MigrationState *s, Error **errp)
 {
     MigMode mode = s->parameters.mode;
     MigrationEvent e;
 
     e.state = s->state;
-    notifier_with_return_list_notify(&migration_state_notifiers[mode], &e, 0);
+    return notifier_with_return_list_notify(&migration_state_notifiers[mode],
+                                            &e, errp);
 }
 
 bool migration_in_setup(MigrationState *s)
@@ -2520,7 +2535,9 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      * spice needs to trigger a transition now
      */
     ms->postcopy_after_devices = true;
-    migration_call_notifiers(ms);
+    if (migration_call_notifiers(ms, errp)) {
+        goto fail;
+    }
 
     migration_downtime_end(ms);
 
@@ -2540,11 +2557,10 @@ static int postcopy_start(MigrationState *ms, Error **errp)
 
     ret = qemu_file_get_error(ms->to_dst_file);
     if (ret) {
-        error_setg(errp, "postcopy_start: Migration stream errored");
-        migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                              MIGRATION_STATUS_FAILED);
+        error_setg_errno(errp, -ret, "postcopy_start: Migration stream error");
+        bql_lock();
+        goto fail;
     }
-
     trace_postcopy_preempt_enabled(migrate_postcopy_preempt());
 
     return ret;
@@ -2565,6 +2581,7 @@ fail:
             error_report_err(local_err);
         }
     }
+    migration_call_notifiers(ms, NULL);         /* Notify about failure */
     bql_unlock();
     return -1;
 }
@@ -3590,7 +3607,9 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         rate_limit = migrate_max_bandwidth();
 
         /* Notify before starting migration thread */
-        migration_call_notifiers(s);
+        if (migration_call_notifiers(s, &local_err)) {
+            goto fail;
+        }
     }
 
     migration_rate_set(rate_limit);
-- 
1.8.3.1


