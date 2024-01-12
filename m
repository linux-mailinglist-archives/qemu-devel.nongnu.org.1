Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D258C82C27F
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 16:06:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOJ6f-0001QW-Fv; Fri, 12 Jan 2024 10:06:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOJ69-000114-M4
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:05:31 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOJ63-0003aD-Cr
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:05:28 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40CEXs8h005113; Fri, 12 Jan 2024 15:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=8DkY47YFvJKJKLVtK0xNmmEYSKnyHnFUavv6KB8+060=;
 b=JFzMV1requMcZ2xyJDaVERa257JHvxhuG6wAKyOMBhkOjM3w4LytzTUgzDsgRxJpDWSN
 /+G8DojctIeubXcinptCHKtcDPjr0nlkXsIgwz+FcXxN0IWK7mbCgOAOpB1l5rbgFOu8
 S6JmiMYxFNj+8tzwnCUAalSk2vefjQ5MBZxSeqyxmKaDrcoBtkOnKNdWUGvLQIHTxRGG
 c2ULtXJhhlzkLIefmvNEn+HhzcQ+P/2aiDu4C3oon9cf8Mh1PSKsAoEo0NOqAjI2VqS4
 1qrbj+widIjAzKXgOBQcvYWNfD4gMBikFZYrj9WxPBp+JYUQm9/hPcDx4Lse4ODEk3aS ww== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vk6afg6a7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 15:05:17 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40CEQ3SU014048; Fri, 12 Jan 2024 15:05:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vfurgd8q1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 15:05:16 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40CF5BoI017833;
 Fri, 12 Jan 2024 15:05:15 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3vfurgd8k6-7; Fri, 12 Jan 2024 15:05:15 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 06/11] migration: MigrationNotifyFunc
Date: Fri, 12 Jan 2024 07:05:05 -0800
Message-Id: <1705071910-174321-7-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: NGpiEEE1g4ExKX8N1iaqQknxuxaJw31k
X-Proofpoint-GUID: NGpiEEE1g4ExKX8N1iaqQknxuxaJw31k
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

Define MigrationNotifyFunc to improve type safety and simplify migration
notifiers.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/net/virtio-net.c      | 4 +---
 hw/vfio/migration.c      | 3 +--
 include/migration/misc.h | 5 ++++-
 migration/migration.c    | 4 ++--
 net/vhost-vdpa.c         | 6 ++----
 ui/spice-core.c          | 4 +---
 6 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 71e1133..f7f2c3b 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3531,10 +3531,8 @@ static void virtio_net_handle_migration_primary(VirtIONet *n, MigrationEvent *e)
 }
 
 static int virtio_net_migration_state_notifier(NotifierWithReturn *notifier,
-                                               void *data, Error **errp)
+                                               MigrationEvent *e, Error **errp)
 {
-    MigrationEvent *e = data;
-
     VirtIONet *n = container_of(notifier, VirtIONet, migration_state);
     virtio_net_handle_migration_primary(n, e);
     return 0;
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 746ec08..534fddf 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -755,9 +755,8 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
 }
 
 static int vfio_migration_state_notifier(NotifierWithReturn *notifier,
-                                         void *data, Error **errp)
+                                         MigrationEvent *e, Error **errp)
 {
-    MigrationEvent *e = data;
     VFIOMigration *migration = container_of(notifier, VFIOMigration,
                                             migration_state);
     VFIODevice *vbasedev = migration->vbasedev;
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 0b4ce0f..8eeb9d5 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -65,8 +65,11 @@ typedef struct MigrationEvent {
     MigrationStatus state;
 } MigrationEvent;
 
+typedef int (*MigrationNotifyFunc)(NotifierWithReturn *notify,
+                                  MigrationEvent *e, Error **errp);
+
 void migration_add_notifier(NotifierWithReturn *notify,
-                            NotifierWithReturnFunc func);
+                            MigrationNotifyFunc func);
 void migration_remove_notifier(NotifierWithReturn *notify);
 void migration_call_notifiers(MigrationState *s);
 bool migration_in_setup(MigrationState *);
diff --git a/migration/migration.c b/migration/migration.c
index 4c5180c..33288bc 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1425,9 +1425,9 @@ static void migrate_fd_cancel(MigrationState *s)
 }
 
 void migration_add_notifier(NotifierWithReturn *notify,
-                            NotifierWithReturnFunc func)
+                            MigrationNotifyFunc func)
 {
-    notify->notify = func;
+    notify->notify = (NotifierWithReturnFunc)func;
     notifier_with_return_list_add(&migration_state_notifiers, notify);
 }
 
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index f96ac75..bffa666 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -323,11 +323,9 @@ static void vhost_vdpa_net_log_global_enable(VhostVDPAState *s, bool enable)
 }
 
 static int vdpa_net_migration_state_notifier(NotifierWithReturn *notifier,
-                                             void *data, Error **errp)
+                                             MigrationEvent *e, Error **errp)
 {
-    MigrationEvent *e = data;
-    VhostVDPAState *s = container_of(notifier, VhostVDPAState,
-                                     migration_state);
+    VhostVDPAState *s = container_of(notifier, VhostVDPAState, migration_state);
 
     if (e->state == MIGRATION_STATUS_SETUP) {
         vhost_vdpa_net_log_global_enable(s, true);
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 74aa3bc..1fdcd1a 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -569,10 +569,8 @@ static SpiceInfo *qmp_query_spice_real(Error **errp)
 }
 
 static int migration_state_notifier(NotifierWithReturn *notifier,
-                                    void *data, Error **errp)
+                                    MigrationEvent *e, Error **errp)
 {
-    MigrationEvent *e = data;
-
     if (!spice_have_target_host) {
         return 0;
     }
-- 
1.8.3.1


