Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC4082C285
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 16:07:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOJ6g-0001WS-EW; Fri, 12 Jan 2024 10:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOJ67-000101-H7
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:05:29 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOJ61-0003a4-PL
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:05:25 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40CEXr8D005084; Fri, 12 Jan 2024 15:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=Ar3x9cyONg4aBbtVYfQmlee4U/JNBSENbC5nZnM5AC4=;
 b=BCbPnajBg0FGN/PUz2NtRHgGGWlmXETgkZXeeYT1ao7J4upfaF+jBA2lmAGJ9USXqAJF
 xJbzvfSYXqNa82n67MEuq0tLSckEpmJzNiavI39QfG6FDD+ZR31rTWbXZxmhCc5kfIo0
 OJJpOLmPMOltkVMDFjdULAmr+HxyQAYoywb2xmrEjtvnpex/+XAYst7I7IIGAcQyq7TD
 j15jTEPE18S7cjsWb8ACqHUaQ1VGsG/UCPlUancZWhsJcTyuilyTXaKqW9HG/+kVAHR2
 xZhHR4SQcxUBGdmVvRuqYdCNQb2D3w7zHvtnu1xxPnnUdi599CSQY6hZNwDbQU3WfoB1 HA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vk6afg6a5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 15:05:16 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40CDlgkE013725; Fri, 12 Jan 2024 15:05:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vfurgd8nh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 15:05:15 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40CF5BoE017833;
 Fri, 12 Jan 2024 15:05:14 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3vfurgd8k6-5; Fri, 12 Jan 2024 15:05:14 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 04/11] migration: remove migration_in_postcopy parameter
Date: Fri, 12 Jan 2024 07:05:03 -0800
Message-Id: <1705071910-174321-5-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: RAW6mYR5pLD0-M3SPz1EBH3XlpSmxX00
X-Proofpoint-GUID: RAW6mYR5pLD0-M3SPz1EBH3XlpSmxX00
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Delete the explicit MigrationState parameter from migration_in_postcopy,
so we can eliminate MigrationState from notifiers in a later patch.
No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/misc.h |  2 +-
 migration/migration.c    | 27 ++++++++++++++++-----------
 ui/spice-core.c          |  2 +-
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index b62e351..dcc98bb 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -68,7 +68,7 @@ bool migration_in_setup(MigrationState *);
 bool migration_has_finished(MigrationState *);
 bool migration_has_failed(MigrationState *);
 /* ...and after the device transmission */
-bool migration_in_postcopy_after_devices(MigrationState *);
+bool migration_in_postcopy_after_devices(void);
 /* True if incoming migration entered POSTCOPY_INCOMING_DISCARD */
 bool migration_in_incoming_postcopy(void);
 /* True if incoming migration entered POSTCOPY_INCOMING_ADVISE */
diff --git a/migration/migration.c b/migration/migration.c
index fa662a5..ad3acd1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1460,18 +1460,22 @@ bool migration_has_failed(MigrationState *s)
             s->state == MIGRATION_STATUS_FAILED);
 }
 
+static bool migration_state_in_postcopy(MigrationState *s)
+{
+    switch (s->state) {
+    case MIGRATION_STATUS_POSTCOPY_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_PAUSED:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER:
+        return true;
+    default:
+        return false;
+    }
+}
+
 bool migration_in_postcopy(void)
 {
     MigrationState *s = migrate_get_current();
-
-    switch (s->state) {
-    case MIGRATION_STATUS_POSTCOPY_ACTIVE:
-    case MIGRATION_STATUS_POSTCOPY_PAUSED:
-    case MIGRATION_STATUS_POSTCOPY_RECOVER:
-        return true;
-    default:
-        return false;
-    }
+    return migration_state_in_postcopy(s);
 }
 
 bool migration_postcopy_is_alive(int state)
@@ -1485,9 +1489,10 @@ bool migration_postcopy_is_alive(int state)
     }
 }
 
-bool migration_in_postcopy_after_devices(MigrationState *s)
+bool migration_in_postcopy_after_devices(void)
 {
-    return migration_in_postcopy() && s->postcopy_after_devices;
+    MigrationState *s = migrate_get_current();
+    return migration_state_in_postcopy(s) && s->postcopy_after_devices;
 }
 
 bool migration_in_incoming_postcopy(void)
diff --git a/ui/spice-core.c b/ui/spice-core.c
index b3cd229..e43a93f 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -580,7 +580,7 @@ static int migration_state_notifier(NotifierWithReturn *notifier,
     if (migration_in_setup(s)) {
         spice_server_migrate_start(spice_server);
     } else if (migration_has_finished(s) ||
-               migration_in_postcopy_after_devices(s)) {
+               migration_in_postcopy_after_devices()) {
         spice_server_migrate_end(spice_server, true);
         spice_have_target_host = false;
     } else if (migration_has_failed(s)) {
-- 
1.8.3.1


