Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6751982C293
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 16:11:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOJB8-0002wz-Md; Fri, 12 Jan 2024 10:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOJAx-0002fO-5F
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:10:29 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOJAq-0006gu-OQ
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:10:26 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40CF3LVi024447; Fri, 12 Jan 2024 15:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=XbM+Id4qz6rqKHTOWLzYE0lZwV9Rax0WbMbHtD65rRs=;
 b=mhJ3edqr0L5Jsx9ASveuq8RDJbhjgEydf1tQpc0MmwpMVOVFtDkhCodVmBVBNXoePUfd
 pdwbc8XR2vcvPZNLHnf3MD8ig2u4hj+ojpzazGT34xGnQPW+FExRLk0HdA4czn7eSucx
 Z2E5HcrC1FoDd2r0mmWUwryHMPF3IxkPwckc05fwbbMdQ/VdmFO0OK4L2TmpcEDkkNGd
 1KDk/3UNTH4npPAskKgscFa1E/HwXtjK92cZMrZqlPzbCvvutNaFTXb4IkmuJcug1HrC
 x9LxN9PLdA18b3EyFSdoWoxOo1t0OXoy59ykr/g2rMwkJB6jBxueDvnipCO6K3XDiTVY hg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vk7qjg0k7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 15:10:18 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40CDW2mB013666; Fri, 12 Jan 2024 15:05:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vfurgd8qt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 15:05:17 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40CF5BoK017833;
 Fri, 12 Jan 2024 15:05:16 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3vfurgd8k6-8; Fri, 12 Jan 2024 15:05:16 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 07/11] migration: per-mode notifiers
Date: Fri, 12 Jan 2024 07:05:06 -0800
Message-Id: <1705071910-174321-8-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: SyPPH6oddiM04ulfJ3kT494d4luHkYmg
X-Proofpoint-GUID: SyPPH6oddiM04ulfJ3kT494d4luHkYmg
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

Keep a separate list of migration notifiers for each migration mode.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/misc.h |  2 ++
 migration/migration.c    | 22 +++++++++++++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 8eeb9d5..e79694f 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -70,6 +70,8 @@ typedef int (*MigrationNotifyFunc)(NotifierWithReturn *notify,
 
 void migration_add_notifier(NotifierWithReturn *notify,
                             MigrationNotifyFunc func);
+void migration_add_notifier_mode(NotifierWithReturn *notify,
+                                 MigrationNotifyFunc func, MigMode mode);
 void migration_remove_notifier(NotifierWithReturn *notify);
 void migration_call_notifiers(MigrationState *s);
 bool migration_in_setup(MigrationState *);
diff --git a/migration/migration.c b/migration/migration.c
index 33288bc..e9914aa 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -68,8 +68,13 @@
 #include "sysemu/dirtylimit.h"
 #include "qemu/sockets.h"
 
-static NotifierWithReturnList migration_state_notifiers =
-    NOTIFIER_WITH_RETURN_LIST_INITIALIZER(migration_state_notifiers);
+#define NOTIFIER_ELEM_INIT(array, elem)    \
+    [elem] = NOTIFIER_WITH_RETURN_LIST_INITIALIZER((array)[elem])
+
+static NotifierWithReturnList migration_state_notifiers[] = {
+    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_NORMAL),
+    NOTIFIER_ELEM_INIT(migration_state_notifiers, MIG_MODE_CPR_REBOOT),
+};
 
 /* Messages sent on the return path from destination to source */
 enum mig_rp_message_type {
@@ -1424,11 +1429,17 @@ static void migrate_fd_cancel(MigrationState *s)
     }
 }
 
+void migration_add_notifier_mode(NotifierWithReturn *notify,
+                                 MigrationNotifyFunc func, MigMode mode)
+{
+    notify->notify = (NotifierWithReturnFunc)func;
+    notifier_with_return_list_add(&migration_state_notifiers[mode], notify);
+}
+
 void migration_add_notifier(NotifierWithReturn *notify,
                             MigrationNotifyFunc func)
 {
-    notify->notify = (NotifierWithReturnFunc)func;
-    notifier_with_return_list_add(&migration_state_notifiers, notify);
+    migration_add_notifier_mode(notify, func, MIG_MODE_NORMAL);
 }
 
 void migration_remove_notifier(NotifierWithReturn *notify)
@@ -1441,10 +1452,11 @@ void migration_remove_notifier(NotifierWithReturn *notify)
 
 void migration_call_notifiers(MigrationState *s)
 {
+    MigMode mode = s->parameters.mode;
     MigrationEvent e;
 
     e.state = s->state;
-    notifier_with_return_list_notify(&migration_state_notifiers, &e, 0);
+    notifier_with_return_list_notify(&migration_state_notifiers[mode], &e, 0);
 }
 
 bool migration_in_setup(MigrationState *s)
-- 
1.8.3.1


