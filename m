Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FA0811C06
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 19:12:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDThz-0000Oe-5X; Wed, 13 Dec 2023 13:11:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rDThw-0000NN-9w
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 13:11:44 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rDThq-0001ed-RH
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 13:11:44 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BDER02q020997; Wed, 13 Dec 2023 18:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=rA2sT6DU42BiebNicsPi3WNs2ntngV22+f2ye6LIWhA=;
 b=bFRMXQx3qFrY+jsZEO9POm6EDJyqgEyrF3oG0RvLVtpYSn4ujKx8UnMmNYEnkzfMJ9pX
 KQ1+0uNGhvKF2MBC9NZGLMWeddbTUUq3RBVdiHSxjw0UnW7TgWVDYkLx0vLqnuDyajfA
 XjTGkXyteIX1JKlIOjkHVObhNQB7QCUXE1roIjqJhhOe5eVebNSa63MBcq6//W1ugd6I
 S7JnW8G1qUcObLR5ecSfsf7AJO1t/W0gIt17gMWekORayQS7ky+ksAj0aIw8uvkX402z
 BluFAkHkM4wIbnr44lB2jKdUPk1H7gd0pmJdh9WRncBpHJ7BHZw7i3AQPVGYLUSCPUjE Hw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvfuu8wyy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Dec 2023 18:11:37 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3BDHrTQ9008350; Wed, 13 Dec 2023 18:11:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uvep8p75a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Dec 2023 18:11:36 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BDIAvtr019890;
 Wed, 13 Dec 2023 18:11:36 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3uvep8p732-3; Wed, 13 Dec 2023 18:11:36 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 2/3] migration: notifier error reporting
Date: Wed, 13 Dec 2023 10:11:32 -0800
Message-Id: <1702491093-383782-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702491093-383782-1-git-send-email-steven.sistare@oracle.com>
References: <1702491093-383782-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_12,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130130
X-Proofpoint-GUID: _0oR7GVk5bUvFp3XU5wiwSFT55b4XKcF
X-Proofpoint-ORIG-GUID: _0oR7GVk5bUvFp3XU5wiwSFT55b4XKcF
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

After calling notifiers, check if an error has been reported via
migrate_set_error, and halt the migration.

None of the notifiers call migrate_set_error at this time, so no
functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/misc.h |  2 +-
 migration/migration.c    | 26 ++++++++++++++++++++++----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 901d117..231d7e4 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -65,7 +65,7 @@ MigMode migrate_mode_of(MigrationState *);
 void migration_add_notifier(Notifier *notify,
                             void (*func)(Notifier *notifier, void *data));
 void migration_remove_notifier(Notifier *notify);
-void migration_call_notifiers(MigrationState *s);
+int migration_call_notifiers(MigrationState *s);
 bool migration_in_setup(MigrationState *);
 bool migration_has_finished(MigrationState *);
 bool migration_has_failed(MigrationState *);
diff --git a/migration/migration.c b/migration/migration.c
index d5bfe70..29a9a92 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1280,6 +1280,8 @@ void migrate_set_state(int *state, int old_state, int new_state)
 
 static void migrate_fd_cleanup(MigrationState *s)
 {
+    bool already_failed;
+
     qemu_bh_delete(s->cleanup_bh);
     s->cleanup_bh = NULL;
 
@@ -1327,11 +1329,20 @@ static void migrate_fd_cleanup(MigrationState *s)
                           MIGRATION_STATUS_CANCELLED);
     }
 
+    already_failed = migration_has_failed(s);
+    if (migration_call_notifiers(s)) {
+        if (!already_failed) {
+            migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+            /* Notify again to recover from this late failure. */
+            migration_call_notifiers(s);
+        }
+    }
+
     if (s->error) {
         /* It is used on info migrate.  We can't free it */
         error_report_err(error_copy(s->error));
     }
-    migration_call_notifiers(s);
+
     block_cleanup_parameters();
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
@@ -1450,9 +1461,10 @@ void migration_remove_notifier(Notifier *notify)
     }
 }
 
-void migration_call_notifiers(MigrationState *s)
+int migration_call_notifiers(MigrationState *s)
 {
     notifier_list_notify(&migration_state_notifiers, s);
+    return (s->error != NULL);
 }
 
 bool migration_in_setup(MigrationState *s)
@@ -2520,7 +2532,9 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      * spice needs to trigger a transition now
      */
     ms->postcopy_after_devices = true;
-    migration_call_notifiers(ms);
+    if (migration_call_notifiers(ms)) {
+        goto fail;
+    }
 
     migration_downtime_end(ms);
 
@@ -3589,7 +3603,11 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         rate_limit = migrate_max_bandwidth();
 
         /* Notify before starting migration thread */
-        migration_call_notifiers(s);
+        if (migration_call_notifiers(s)) {
+            migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+            migrate_fd_cleanup(s);
+            return;
+        }
     }
 
     migration_rate_set(rate_limit);
-- 
1.8.3.1


