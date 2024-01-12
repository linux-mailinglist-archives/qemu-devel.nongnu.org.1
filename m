Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEBB82C27D
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 16:06:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOJ6P-000153-S8; Fri, 12 Jan 2024 10:05:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOJ63-0000yR-RE
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:05:25 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOJ61-0003ak-32
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:05:22 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40CEXrTm024858; Fri, 12 Jan 2024 15:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=S8Atuu7BUoXNkE6xZQjnhQZLqYZ4yu13kPzADTG1qEY=;
 b=CkhvVfLTxs59eoZChkK8/vdzlvXGHo520gGxIgNlSUxEIUw2JqT8sZpdo21rpuf5U7wS
 +mMC7MVH7h3g8smc0RboraBCHDaXkwgRA/xa3iPxRt1BDjoC8FX6W1wV3ELNJXTIMUWx
 M5hS90QNrJhqnb5PBQPpwBcy7uhuHNK2GecIMtctgfGyT9fJyaA4YrOGbSDyzRElq5w0
 c6+wTJUHe7afS78QG6ZtaEhKXKbDTexvNcad462C3BofeMb3wf670etgiygpTDTVeBIK
 6MK9Ab3x02U5hvUzycvOORbslFbW+VSbJLZhPPo51uLZRIPhkwVJXDgVr8eB3Xh527cs bg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vk68306fq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 15:05:16 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40CDqvaJ013971; Fri, 12 Jan 2024 15:05:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vfurgd8p5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 15:05:15 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40CF5BoG017833;
 Fri, 12 Jan 2024 15:05:14 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3vfurgd8k6-6; Fri, 12 Jan 2024 15:05:14 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 05/11] migration: MigrationEvent for notifiers
Date: Fri, 12 Jan 2024 07:05:04 -0800
Message-Id: <1705071910-174321-6-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: uolMpLvVJiLPRAIXoEwJ1hZzZjKXREpf
X-Proofpoint-ORIG-GUID: uolMpLvVJiLPRAIXoEwJ1hZzZjKXREpf
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

Passing MigrationState to notifiers is unsound because they could access
unstable migration state internals or even modify the state.  Instead, pass
the minimal info needed in a new MigrationEvent struct, which could be
extended in the future if needed.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/net/virtio-net.c      | 12 +++++++-----
 hw/vfio/migration.c      |  8 +++++---
 include/migration/misc.h |  5 +++++
 migration/migration.c    |  5 ++++-
 net/vhost-vdpa.c         |  7 ++++---
 ui/spice-core.c          |  9 +++++----
 6 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9570353..71e1133 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3499,7 +3499,7 @@ out:
     return !err;
 }
 
-static void virtio_net_handle_migration_primary(VirtIONet *n, MigrationState *s)
+static void virtio_net_handle_migration_primary(VirtIONet *n, MigrationEvent *e)
 {
     bool should_be_hidden;
     Error *err = NULL;
@@ -3511,7 +3511,7 @@ static void virtio_net_handle_migration_primary(VirtIONet *n, MigrationState *s)
 
     should_be_hidden = qatomic_read(&n->failover_primary_hidden);
 
-    if (migration_in_setup(s) && !should_be_hidden) {
+    if (e->state == MIGRATION_STATUS_SETUP && !should_be_hidden) {
         if (failover_unplug_primary(n, dev)) {
             vmstate_unregister(VMSTATE_IF(dev), qdev_get_vmsd(dev), dev);
             qapi_event_send_unplug_primary(dev->id);
@@ -3519,7 +3519,8 @@ static void virtio_net_handle_migration_primary(VirtIONet *n, MigrationState *s)
         } else {
             warn_report("couldn't unplug primary device");
         }
-    } else if (migration_has_failed(s)) {
+    } else if (e->state == MIGRATION_STATUS_FAILED ||
+               e->state == MIGRATION_STATUS_CANCELLED) {
         /* We already unplugged the device let's plug it back */
         if (!failover_replug_primary(n, dev, &err)) {
             if (err) {
@@ -3532,9 +3533,10 @@ static void virtio_net_handle_migration_primary(VirtIONet *n, MigrationState *s)
 static int virtio_net_migration_state_notifier(NotifierWithReturn *notifier,
                                                void *data, Error **errp)
 {
-    MigrationState *s = data;
+    MigrationEvent *e = data;
+
     VirtIONet *n = container_of(notifier, VirtIONet, migration_state);
-    virtio_net_handle_migration_primary(n, s);
+    virtio_net_handle_migration_primary(n, e);
     return 0;
 }
 
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 6b6acc4..746ec08 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -757,19 +757,21 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
 static int vfio_migration_state_notifier(NotifierWithReturn *notifier,
                                          void *data, Error **errp)
 {
-    MigrationState *s = data;
+    MigrationEvent *e = data;
     VFIOMigration *migration = container_of(notifier, VFIOMigration,
                                             migration_state);
     VFIODevice *vbasedev = migration->vbasedev;
 
     trace_vfio_migration_state_notifier(vbasedev->name,
-                                        MigrationStatus_str(s->state));
+                                        MigrationStatus_str(e->state));
 
-    switch (s->state) {
+    switch (e->state) {
     case MIGRATION_STATUS_CANCELLING:
     case MIGRATION_STATUS_CANCELLED:
     case MIGRATION_STATUS_FAILED:
         vfio_migration_set_state_or_reset(vbasedev, VFIO_DEVICE_STATE_RUNNING);
+    default:
+        break;
     }
     return 0;
 }
diff --git a/include/migration/misc.h b/include/migration/misc.h
index dcc98bb..0b4ce0f 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -60,6 +60,11 @@ void migration_object_init(void);
 void migration_shutdown(void);
 bool migration_is_idle(void);
 bool migration_is_active(MigrationState *);
+
+typedef struct MigrationEvent {
+    MigrationStatus state;
+} MigrationEvent;
+
 void migration_add_notifier(NotifierWithReturn *notify,
                             NotifierWithReturnFunc func);
 void migration_remove_notifier(NotifierWithReturn *notify);
diff --git a/migration/migration.c b/migration/migration.c
index ad3acd1..4c5180c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1441,7 +1441,10 @@ void migration_remove_notifier(NotifierWithReturn *notify)
 
 void migration_call_notifiers(MigrationState *s)
 {
-    notifier_with_return_list_notify(&migration_state_notifiers, s, 0);
+    MigrationEvent e;
+
+    e.state = s->state;
+    notifier_with_return_list_notify(&migration_state_notifiers, &e, 0);
 }
 
 bool migration_in_setup(MigrationState *s)
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 1c00519..f96ac75 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -325,13 +325,14 @@ static void vhost_vdpa_net_log_global_enable(VhostVDPAState *s, bool enable)
 static int vdpa_net_migration_state_notifier(NotifierWithReturn *notifier,
                                              void *data, Error **errp)
 {
-    MigrationState *migration = data;
+    MigrationEvent *e = data;
     VhostVDPAState *s = container_of(notifier, VhostVDPAState,
                                      migration_state);
 
-    if (migration_in_setup(migration)) {
+    if (e->state == MIGRATION_STATUS_SETUP) {
         vhost_vdpa_net_log_global_enable(s, true);
-    } else if (migration_has_failed(migration)) {
+    } else if (e->state == MIGRATION_STATUS_FAILED ||
+               e->state == MIGRATION_STATUS_CANCELLED) {
         vhost_vdpa_net_log_global_enable(s, false);
     }
     return 0;
diff --git a/ui/spice-core.c b/ui/spice-core.c
index e43a93f..74aa3bc 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -571,19 +571,20 @@ static SpiceInfo *qmp_query_spice_real(Error **errp)
 static int migration_state_notifier(NotifierWithReturn *notifier,
                                     void *data, Error **errp)
 {
-    MigrationState *s = data;
+    MigrationEvent *e = data;
 
     if (!spice_have_target_host) {
         return 0;
     }
 
-    if (migration_in_setup(s)) {
+    if (e->state == MIGRATION_STATUS_SETUP) {
         spice_server_migrate_start(spice_server);
-    } else if (migration_has_finished(s) ||
+    } else if (e->state == MIGRATION_STATUS_COMPLETED ||
                migration_in_postcopy_after_devices()) {
         spice_server_migrate_end(spice_server, true);
         spice_have_target_host = false;
-    } else if (migration_has_failed(s)) {
+    } else if (e->state == MIGRATION_STATUS_FAILED ||
+               e->state == MIGRATION_STATUS_CANCELLED) {
         spice_server_migrate_end(spice_server, false);
         spice_have_target_host = false;
     }
-- 
1.8.3.1


