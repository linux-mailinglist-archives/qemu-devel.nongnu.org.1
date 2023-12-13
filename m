Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0594B811C08
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 19:12:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDTi1-0000Uu-Nm; Wed, 13 Dec 2023 13:11:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rDThw-0000O5-Rv
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 13:11:44 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rDThr-0001ej-Sw
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 13:11:44 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3BDEQqV1015965; Wed, 13 Dec 2023 18:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-11-20;
 bh=BEWqWCQQ8J4PvKgao1tkkgLw7B20ajqOCK86i4U966U=;
 b=OaoIPThJ/1RKeaEKPsQwFblFdjJk+p83oNBDWswHI02dzzHWOsav1Ldrhrd1EzMEtsm9
 kdIdM0+M0Jh+q2UyuPXIFEIBXOOf9VOWCUUlYB+kfnrI1gH7gwDQFwBsR+WL0FdsIHMw
 +sl+ZtsI+8VkzpPmzULAQO39PV8pmjfYRkdWpgvfJ09xj79j4KZ5nX66t8Loml5u1kew
 5MHWoMKrcICLrzstnf6zZKcbMfY3HGodKd9e/LzkVs3Lw3iKFX59b268DF85pnF6tATg
 LKYSNvALvxo74oOosEW3rcTiIHdtuvdlBiaOLU/M+BMtz08daDOVn/dhI2LJg6c2EeWy 8A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwfrrqat6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Dec 2023 18:11:38 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3BDI1t2i008285; Wed, 13 Dec 2023 18:11:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uvep8p764-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Dec 2023 18:11:37 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BDIAvtt019890;
 Wed, 13 Dec 2023 18:11:36 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 3uvep8p732-4; Wed, 13 Dec 2023 18:11:36 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 3/3] vfio: allow cpr-reboot migration if suspended
Date: Wed, 13 Dec 2023 10:11:33 -0800
Message-Id: <1702491093-383782-4-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: vShOFdeWYQF0jQa2o63qpnqCwXdd9du4
X-Proofpoint-ORIG-GUID: vShOFdeWYQF0jQa2o63qpnqCwXdd9du4
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

Allow cpr-reboot for vfio if the guest is in the suspended runstate.  The
guest drivers' suspend methods flush outstanding requests and re-initialize
the devices, and thus there is no device state to save and restore.  The
user is responsible for suspending the guest before initiating cpr, such as
by issuing guest-suspend-ram to the qemu guest agent.

Relax the vfio blocker so it does not apply to cpr, and add a notifier that
verifies the guest is suspended.  Skip dirty page tracking, which is N/A for
cpr, to avoid ioctl errors.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
note: vfio_cpr_register_container is trivial in this patch and could be
squashed, but it is expanded in future patches for cpr-exec mode.
---
---
 hw/vfio/common.c              |  2 +-
 hw/vfio/container.c           | 11 ++++++++++-
 hw/vfio/cpr.c                 | 42 ++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/meson.build           |  1 +
 hw/vfio/migration.c           |  2 +-
 include/hw/vfio/vfio-common.h |  4 ++++
 migration/ram.c               |  9 +++++----
 7 files changed, 64 insertions(+), 7 deletions(-)
 create mode 100644 hw/vfio/cpr.c

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index e70fdf5..833a528 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -128,7 +128,7 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
     error_setg(&multiple_devices_migration_blocker,
                "Multiple VFIO devices migration is supported only if all of "
                "them support P2P migration");
-    ret = migrate_add_blocker(&multiple_devices_migration_blocker, errp);
+    ret = migrate_add_blocker_normal(&multiple_devices_migration_blocker, errp);
 
     return ret;
 }
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 2420100..ddae95e 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -558,10 +558,15 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         goto free_container_exit;
     }
 
+    ret = vfio_cpr_register_container(container, errp);
+    if (ret) {
+        goto free_container_exit;
+    }
+
     ret = vfio_ram_block_discard_disable(container, true);
     if (ret) {
         error_setg_errno(errp, -ret, "Cannot set discarding of RAM broken");
-        goto free_container_exit;
+        goto unregister_container_exit;
     }
 
     switch (container->iommu_type) {
@@ -638,6 +643,9 @@ listener_release_exit:
 enable_discards_exit:
     vfio_ram_block_discard_disable(container, false);
 
+unregister_container_exit:
+    vfio_cpr_unregister_container(container);
+
 free_container_exit:
     vfio_free_container(container);
 
@@ -689,6 +697,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
         }
 
         trace_vfio_disconnect_container(container->fd);
+        vfio_cpr_unregister_container(container);
         close(container->fd);
         vfio_free_container(container);
 
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
new file mode 100644
index 0000000..f0282ed
--- /dev/null
+++ b/hw/vfio/cpr.c
@@ -0,0 +1,42 @@
+/*
+ * Copyright (c) 2021-2023 Oracle and/or its affiliates.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/vfio/vfio-common.h"
+#include "migration/migration.h"
+#include "migration/misc.h"
+#include "qapi/error.h"
+#include "sysemu/runstate.h"
+
+static void vfio_cpr_reboot_notifier(Notifier *notifier, void *data)
+{
+    MigrationState *s = data;
+
+    if (migrate_mode_of(s) == MIG_MODE_CPR_REBOOT &&
+        !migration_has_failed(s) &&
+        !migration_has_finished(s) &&
+        !runstate_check(RUN_STATE_SUSPENDED)) {
+
+        Error *err = NULL;
+        error_setg(&err, "VFIO device only supports cpr-reboot for "
+                         "runstate suspended");
+        migrate_set_error(s, err);
+        error_free(err);
+    }
+}
+
+int vfio_cpr_register_container(VFIOContainer *container, Error **errp)
+{
+    migration_add_notifier(&container->cpr_reboot_notifier,
+                           vfio_cpr_reboot_notifier);
+    return 0;
+}
+
+void vfio_cpr_unregister_container(VFIOContainer *container)
+{
+    migration_remove_notifier(&container->cpr_reboot_notifier);
+}
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 2a6912c..3e1f9ad 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -5,6 +5,7 @@ vfio_ss.add(files(
   'container.c',
   'spapr.c',
   'migration.c',
+  'cpr.c',
 ))
 vfio_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
   'display.c',
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index 814132a..86d8c9e 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -902,7 +902,7 @@ static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
     vbasedev->migration_blocker = error_copy(err);
     error_free(err);
 
-    return migrate_add_blocker(&vbasedev->migration_blocker, errp);
+    return migrate_add_blocker_normal(&vbasedev->migration_blocker, errp);
 }
 
 /* ---------------------------------------------------------------------- */
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index a4a22ac..7da1602 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -85,6 +85,7 @@ typedef struct VFIOContainer {
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
     MemoryListener listener;
     MemoryListener prereg_listener;
+    Notifier cpr_reboot_notifier;
     unsigned iommu_type;
     Error *error;
     bool initialized;
@@ -254,6 +255,9 @@ void vfio_detach_device(VFIODevice *vbasedev);
 int vfio_kvm_device_add_fd(int fd, Error **errp);
 int vfio_kvm_device_del_fd(int fd, Error **errp);
 
+int vfio_cpr_register_container(VFIOContainer *container, Error **errp);
+void vfio_cpr_unregister_container(VFIOContainer *container);
+
 extern const MemoryRegionOps vfio_region_ops;
 typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
 typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
diff --git a/migration/ram.c b/migration/ram.c
index 8c7886a..8604b97 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2393,8 +2393,8 @@ static void ram_save_cleanup(void *opaque)
     RAMState **rsp = opaque;
     RAMBlock *block;
 
-    /* We don't use dirty log with background snapshots */
-    if (!migrate_background_snapshot()) {
+    /* We don't use dirty log with background snapshots or cpr */
+    if (!migrate_background_snapshot() && migrate_mode() == MIG_MODE_NORMAL) {
         /* caller have hold iothread lock or is in a bh, so there is
          * no writing race against the migration bitmap
          */
@@ -2805,8 +2805,9 @@ static void ram_init_bitmaps(RAMState *rs)
 
     WITH_RCU_READ_LOCK_GUARD() {
         ram_list_init_bitmaps();
-        /* We don't use dirty log with background snapshots */
-        if (!migrate_background_snapshot()) {
+        /* We don't use dirty log with background snapshots or cpr */
+        if (!migrate_background_snapshot() &&
+            migrate_mode() == MIG_MODE_NORMAL) {
             memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
             migration_bitmap_sync_precopy(rs, false);
         }
-- 
1.8.3.1


