Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC297CDDB9
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:45:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6mx-0004Jf-Eu; Wed, 18 Oct 2023 09:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qt6mu-0004HA-3S
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:40:40 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qt6mr-0006hy-1m
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:40:39 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39ICxGdl015416; Wed, 18 Oct 2023 13:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id; s=corp-2023-03-30;
 bh=oSOg7E04cHgarCqEsW/N7A+qfWi3fgjB94knxbihj4k=;
 b=bcwmH0EJvwJUf8ODjDYw6XCvBWCC+NkgtGT5mRDaZG88CKwfj4z2tmQ9ydRufvwNGIbf
 AJ2sc0ARUDF5TUzB0o0BzRg9rAbE5WCc+W1X3nfPyt1YDCVKN74Zo/UMr4qZ/+L3atuV
 m8vIuvSoM4ZrRNTuIxDngqnyHbYOVDRiOv8y3CzADoqTwNQjUC7Xe072LfkNO9qKuw4q
 UpzhdAUmVV0eXuilRxIiJM1+r41mZc+tdgcerkwaJ4dUL2NkXB286DA9DJOa0QTmhbbH
 JdbSHiVoa3hwse/lHrOcJ3ZNJyKfmYkU9PW8ann0bNAQ+DJERcH47KtczOHdvSCqTOjo 9g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqjy1fh13-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Oct 2023 13:40:34 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39ID0X1l040556; Wed, 18 Oct 2023 13:40:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3trfyns2gu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Oct 2023 13:40:32 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39IDeWxh020006;
 Wed, 18 Oct 2023 13:40:32 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 3trfyns2fd-1; Wed, 18 Oct 2023 13:40:32 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4] migration: simplify notifiers
Date: Wed, 18 Oct 2023 06:40:30 -0700
Message-Id: <1697636430-87083-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_12,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180114
X-Proofpoint-GUID: pQkeEfM67M1b_hMHIcmTtpcBM4gT8-Xz
X-Proofpoint-ORIG-GUID: pQkeEfM67M1b_hMHIcmTtpcBM4gT8-Xz
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

Pass the callback function to add_migration_state_change_notifier so
that migration can initialize the notifier on add and clear it on
delete, which simplifies the call sites.  Shorten the function names
so the extra arg can be added more legibly.  Hide the global notifier
list in a new function migration_call_notifiers, and make it externally
visible so future live update code can call it.

No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Tested-by: Michael Galaxy <mgalaxy@akamai.com>
Reviewed-by: Michael Galaxy <mgalaxy@akamai.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 hw/net/virtio-net.c      |  6 +++---
 hw/vfio/migration.c      |  6 +++---
 include/migration/misc.h |  6 ++++--
 migration/migration.c    | 22 ++++++++++++++++------
 net/vhost-vdpa.c         |  7 ++++---
 ui/spice-core.c          |  3 +--
 6 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 29e33ea..b85c794 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3624,8 +3624,8 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
         n->primary_listener.hide_device = failover_hide_primary_device;
         qatomic_set(&n->failover_primary_hidden, true);
         device_listener_register(&n->primary_listener);
-        n->migration_state.notify = virtio_net_migration_state_notifier;
-        add_migration_state_change_notifier(&n->migration_state);
+        migration_add_notifier(&n->migration_state,
+                               virtio_net_migration_state_notifier);
         n->host_features |= (1ULL << VIRTIO_NET_F_STANDBY);
     }
 
@@ -3788,7 +3788,7 @@ static void virtio_net_device_unrealize(DeviceState *dev)
     if (n->failover) {
         qobject_unref(n->primary_opts);
         device_listener_unregister(&n->primary_listener);
-        remove_migration_state_change_notifier(&n->migration_state);
+        migration_remove_notifier(&n->migration_state);
     } else {
         assert(n->primary_opts == NULL);
     }
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 0aaad65..28d422b 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -872,8 +872,8 @@ static int vfio_migration_init(VFIODevice *vbasedev)
                      NULL;
     migration->vm_state = qdev_add_vm_change_state_handler_full(
         vbasedev->dev, vfio_vmstate_change, prepare_cb, vbasedev);
-    migration->migration_state.notify = vfio_migration_state_notifier;
-    add_migration_state_change_notifier(&migration->migration_state);
+    migration_add_notifier(&migration->migration_state,
+                           vfio_migration_state_notifier);
 
     return 0;
 }
@@ -882,7 +882,7 @@ static void vfio_migration_deinit(VFIODevice *vbasedev)
 {
     VFIOMigration *migration = vbasedev->migration;
 
-    remove_migration_state_change_notifier(&migration->migration_state);
+    migration_remove_notifier(&migration->migration_state);
     qemu_del_vm_change_state_handler(migration->vm_state);
     unregister_savevm(VMSTATE_IF(vbasedev->dev), "vfio", vbasedev);
     vfio_migration_free(vbasedev);
diff --git a/include/migration/misc.h b/include/migration/misc.h
index 7dcc0b5..673ac49 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -60,8 +60,10 @@ void migration_object_init(void);
 void migration_shutdown(void);
 bool migration_is_idle(void);
 bool migration_is_active(MigrationState *);
-void add_migration_state_change_notifier(Notifier *notify);
-void remove_migration_state_change_notifier(Notifier *notify);
+void migration_add_notifier(Notifier *notify,
+                            void (*func)(Notifier *notifier, void *data));
+void migration_remove_notifier(Notifier *notify);
+void migration_call_notifiers(MigrationState *s);
 bool migration_in_setup(MigrationState *);
 bool migration_has_finished(MigrationState *);
 bool migration_has_failed(MigrationState *);
diff --git a/migration/migration.c b/migration/migration.c
index 65f9791..29a69bf 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1204,7 +1204,7 @@ static void migrate_fd_cleanup(MigrationState *s)
         /* It is used on info migrate.  We can't free it */
         error_report_err(error_copy(s->error));
     }
-    notifier_list_notify(&migration_state_notifiers, s);
+    migration_call_notifiers(s);
     block_cleanup_parameters();
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
@@ -1308,14 +1308,24 @@ static void migrate_fd_cancel(MigrationState *s)
     }
 }
 
-void add_migration_state_change_notifier(Notifier *notify)
+void migration_add_notifier(Notifier *notify,
+                            void (*func)(Notifier *notifier, void *data))
 {
+    notify->notify = func;
     notifier_list_add(&migration_state_notifiers, notify);
 }
 
-void remove_migration_state_change_notifier(Notifier *notify)
+void migration_remove_notifier(Notifier *notify)
 {
-    notifier_remove(notify);
+    if (notify->notify) {
+        notifier_remove(notify);
+        notify->notify = NULL;
+    }
+}
+
+void migration_call_notifiers(MigrationState *s)
+{
+    notifier_list_notify(&migration_state_notifiers, s);
 }
 
 bool migration_in_setup(MigrationState *s)
@@ -2231,7 +2241,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      * spice needs to trigger a transition now
      */
     ms->postcopy_after_devices = true;
-    notifier_list_notify(&migration_state_notifiers, ms);
+    migration_call_notifiers(ms);
 
     ms->downtime =  qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - time_at_stop;
 
@@ -3265,7 +3275,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
         rate_limit = migrate_max_bandwidth();
 
         /* Notify before starting migration thread */
-        notifier_list_notify(&migration_state_notifiers, s);
+        migration_call_notifiers(s);
     }
 
     migration_rate_set(rate_limit);
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 939c984..0f2e6fc 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -339,7 +339,8 @@ static void vhost_vdpa_net_data_start_first(VhostVDPAState *s)
 {
     struct vhost_vdpa *v = &s->vhost_vdpa;
 
-    add_migration_state_change_notifier(&s->migration_state);
+    migration_add_notifier(&s->migration_state,
+                           vdpa_net_migration_state_notifier);
     if (v->shadow_vqs_enabled) {
         v->iova_tree = vhost_iova_tree_new(v->iova_range.first,
                                            v->iova_range.last);
@@ -399,7 +400,7 @@ static void vhost_vdpa_net_client_stop(NetClientState *nc)
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
 
     if (s->vhost_vdpa.index == 0) {
-        remove_migration_state_change_notifier(&s->migration_state);
+        migration_remove_notifier(&s->migration_state);
     }
 
     dev = s->vhost_vdpa.dev;
@@ -1456,7 +1457,7 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
     s->vhost_vdpa.device_fd = vdpa_device_fd;
     s->vhost_vdpa.index = queue_pair_index;
     s->always_svq = svq;
-    s->migration_state.notify = vdpa_net_migration_state_notifier;
+    s->migration_state.notify = NULL;
     s->vhost_vdpa.shadow_vqs_enabled = svq;
     s->vhost_vdpa.iova_range = iova_range;
     s->vhost_vdpa.shadow_data = svq;
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 52a5938..db21db2 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -821,8 +821,7 @@ static void qemu_spice_init(void)
     };
     using_spice = 1;
 
-    migration_state.notify = migration_state_notifier;
-    add_migration_state_change_notifier(&migration_state);
+    migration_add_notifier(&migration_state, migration_state_notifier);
     spice_migrate.base.sif = &migrate_interface.base;
     qemu_spice.add_interface(&spice_migrate.base);
 
-- 
1.8.3.1


