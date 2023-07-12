Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B03C675004D
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 09:42:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJURt-0004EF-Jn; Wed, 12 Jul 2023 03:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJURr-0004Cf-V2
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:39:43 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJURn-0006nZ-GF
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:39:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689147579; x=1720683579;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aXyXwcWq/hQu+3tQigutIIL0ROR/1SSFg6G6PFzvfCM=;
 b=AimuYqDBMW28LdzibtkMZUVQQkTkZMuYrFjTh+14u+78VQiVvfzc6iGX
 2lM59i0DQrDEM7wJ/+40gEqSPCAhyMTjIcp5DeYuE3t2nZkqQui3l7Sj2
 l3HbkbmIoOVs8KKHFB1w/q22U8P8QOAesWuXXPZlxJF0lcab+UHIsZisC
 rTKvWCej9FE4jIp1jnzlUnCRUhNzzG7Vmoy86gwiEK3QPeXFakUWcTCAo
 Sjkjm0LM+oW5OaLOETpR0H86kAZt0pqvIAOWf3l7Zvg9c3yRtgJypQGJx
 85JkJcHjrcn5PA9zfsibl7PJmzR1PxIxtOMmncetBa7qAZhNAM96kQTz2 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="430953622"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="430953622"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:39:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="835023981"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="835023981"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:39:12 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, eric.auger@redhat.com, peterx@redhat.com,
 jasonwang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [RFC PATCH v4 06/24] vfio/common: Add a vfio device iterator
Date: Wed, 12 Jul 2023 15:25:10 +0800
Message-Id: <20230712072528.275577-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712072528.275577-1-zhenzhong.duan@intel.com>
References: <20230712072528.275577-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=zhenzhong.duan@intel.com; helo=mga07.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

With a vfio device iterator added, we can make some migration and reset
related functions group agnostic.
E.x:
vfio_mig_active
vfio_migratable_device_num
vfio_devices_all_dirty_tracking
vfio_devices_all_device_dirty_tracking
vfio_devices_all_running_and_mig_active
vfio_devices_dma_logging_stop
vfio_devices_dma_logging_start
vfio_devices_query_dirty_bitmap
vfio_reset_handler

Or else we need to add container specific callback variants for above
functions just because they iterate devices based on group.

Move the reset handler registration/unregistration to a place that is not
backend-specific, saying first vfio address space created instead of the
first group.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/common.c | 226 +++++++++++++++++++++++++----------------------
 1 file changed, 121 insertions(+), 105 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index b9d493b211..f7e4dc0cef 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -84,6 +84,26 @@ static int vfio_ram_block_discard_disable(VFIOContainer *container, bool state)
     }
 }
 
+static VFIODevice *vfio_container_dev_iter_next(VFIOContainer *container,
+                                                VFIODevice *curr)
+{
+    VFIOGroup *group;
+
+    if (!curr) {
+        group = QLIST_FIRST(&container->group_list);
+    } else {
+        if (curr->next.le_next) {
+            return curr->next.le_next;
+        }
+        group = curr->group->container_next.le_next;
+    }
+
+    if (!group) {
+        return NULL;
+    }
+    return QLIST_FIRST(&group->device_list);
+}
+
 /*
  * Device state interfaces
  */
@@ -112,17 +132,18 @@ static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
 
 bool vfio_mig_active(void)
 {
-    VFIOGroup *group;
+    VFIOAddressSpace *space;
+    VFIOContainer *container;
     VFIODevice *vbasedev;
 
-    if (QLIST_EMPTY(&vfio_group_list)) {
-        return false;
-    }
-
-    QLIST_FOREACH(group, &vfio_group_list, next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            if (vbasedev->migration_blocker) {
-                return false;
+    QLIST_FOREACH(space, &vfio_address_spaces, list) {
+        QLIST_FOREACH(container, &space->containers, next) {
+            vbasedev = NULL;
+            while ((vbasedev = vfio_container_dev_iter_next(container,
+                                                            vbasedev))) {
+                if (vbasedev->migration_blocker) {
+                    return false;
+                }
             }
         }
     }
@@ -133,14 +154,19 @@ static Error *multiple_devices_migration_blocker;
 
 static unsigned int vfio_migratable_device_num(void)
 {
-    VFIOGroup *group;
+    VFIOAddressSpace *space;
+    VFIOContainer *container;
     VFIODevice *vbasedev;
     unsigned int device_num = 0;
 
-    QLIST_FOREACH(group, &vfio_group_list, next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            if (vbasedev->migration) {
-                device_num++;
+    QLIST_FOREACH(space, &vfio_address_spaces, list) {
+        QLIST_FOREACH(container, &space->containers, next) {
+            vbasedev = NULL;
+            while ((vbasedev = vfio_container_dev_iter_next(container,
+                                                            vbasedev))) {
+                if (vbasedev->migration) {
+                    device_num++;
+                }
             }
         }
     }
@@ -207,8 +233,7 @@ static void vfio_set_migration_error(int err)
 
 static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
 {
-    VFIOGroup *group;
-    VFIODevice *vbasedev;
+    VFIODevice *vbasedev = NULL;
     MigrationState *ms = migrate_get_current();
 
     if (ms->state != MIGRATION_STATUS_ACTIVE &&
@@ -216,19 +241,17 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
         return false;
     }
 
-    QLIST_FOREACH(group, &container->group_list, container_next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            VFIOMigration *migration = vbasedev->migration;
+    while ((vbasedev = vfio_container_dev_iter_next(container, vbasedev))) {
+        VFIOMigration *migration = vbasedev->migration;
 
-            if (!migration) {
-                return false;
-            }
+        if (!migration) {
+            return false;
+        }
 
-            if (vbasedev->pre_copy_dirty_page_tracking == ON_OFF_AUTO_OFF &&
-                (migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
-                 migration->device_state == VFIO_DEVICE_STATE_PRE_COPY)) {
-                return false;
-            }
+        if (vbasedev->pre_copy_dirty_page_tracking == ON_OFF_AUTO_OFF &&
+            (migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
+             migration->device_state == VFIO_DEVICE_STATE_PRE_COPY)) {
+            return false;
         }
     }
     return true;
@@ -236,14 +259,11 @@ static bool vfio_devices_all_dirty_tracking(VFIOContainer *container)
 
 static bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container)
 {
-    VFIOGroup *group;
-    VFIODevice *vbasedev;
+    VFIODevice *vbasedev = NULL;
 
-    QLIST_FOREACH(group, &container->group_list, container_next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            if (!vbasedev->dirty_pages_supported) {
-                return false;
-            }
+    while ((vbasedev = vfio_container_dev_iter_next(container, vbasedev))) {
+        if (!vbasedev->dirty_pages_supported) {
+            return false;
         }
     }
 
@@ -256,27 +276,24 @@ static bool vfio_devices_all_device_dirty_tracking(VFIOContainer *container)
  */
 static bool vfio_devices_all_running_and_mig_active(VFIOContainer *container)
 {
-    VFIOGroup *group;
-    VFIODevice *vbasedev;
+    VFIODevice *vbasedev = NULL;
 
     if (!migration_is_active(migrate_get_current())) {
         return false;
     }
 
-    QLIST_FOREACH(group, &container->group_list, container_next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            VFIOMigration *migration = vbasedev->migration;
+    while ((vbasedev = vfio_container_dev_iter_next(container, vbasedev))) {
+        VFIOMigration *migration = vbasedev->migration;
 
-            if (!migration) {
-                return false;
-            }
+        if (!migration) {
+            return false;
+        }
 
-            if (migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
-                migration->device_state == VFIO_DEVICE_STATE_PRE_COPY) {
-                continue;
-            } else {
-                return false;
-            }
+        if (migration->device_state == VFIO_DEVICE_STATE_RUNNING ||
+            migration->device_state == VFIO_DEVICE_STATE_PRE_COPY) {
+            continue;
+        } else {
+            return false;
         }
     }
     return true;
@@ -1243,25 +1260,22 @@ static void vfio_devices_dma_logging_stop(VFIOContainer *container)
     uint64_t buf[DIV_ROUND_UP(sizeof(struct vfio_device_feature),
                               sizeof(uint64_t))] = {};
     struct vfio_device_feature *feature = (struct vfio_device_feature *)buf;
-    VFIODevice *vbasedev;
-    VFIOGroup *group;
+    VFIODevice *vbasedev = NULL;
 
     feature->argsz = sizeof(buf);
     feature->flags = VFIO_DEVICE_FEATURE_SET |
                      VFIO_DEVICE_FEATURE_DMA_LOGGING_STOP;
 
-    QLIST_FOREACH(group, &container->group_list, container_next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            if (!vbasedev->dirty_tracking) {
-                continue;
-            }
+    while ((vbasedev = vfio_container_dev_iter_next(container, vbasedev))) {
+        if (!vbasedev->dirty_tracking) {
+            continue;
+        }
 
-            if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
-                warn_report("%s: Failed to stop DMA logging, err %d (%s)",
-                             vbasedev->name, -errno, strerror(errno));
-            }
-            vbasedev->dirty_tracking = false;
+        if (ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature)) {
+            warn_report("%s: Failed to stop DMA logging, err %d (%s)",
+                        vbasedev->name, -errno, strerror(errno));
         }
+        vbasedev->dirty_tracking = false;
     }
 }
 
@@ -1336,8 +1350,7 @@ static int vfio_devices_dma_logging_start(VFIOContainer *container)
 {
     struct vfio_device_feature *feature;
     VFIODirtyRanges ranges;
-    VFIODevice *vbasedev;
-    VFIOGroup *group;
+    VFIODevice *vbasedev = NULL;
     int ret = 0;
 
     vfio_dirty_tracking_init(container, &ranges);
@@ -1347,21 +1360,19 @@ static int vfio_devices_dma_logging_start(VFIOContainer *container)
         return -errno;
     }
 
-    QLIST_FOREACH(group, &container->group_list, container_next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            if (vbasedev->dirty_tracking) {
-                continue;
-            }
+    while ((vbasedev = vfio_container_dev_iter_next(container, vbasedev))) {
+        if (vbasedev->dirty_tracking) {
+            continue;
+        }
 
-            ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
-            if (ret) {
-                ret = -errno;
-                error_report("%s: Failed to start DMA logging, err %d (%s)",
-                             vbasedev->name, ret, strerror(errno));
-                goto out;
-            }
-            vbasedev->dirty_tracking = true;
+        ret = ioctl(vbasedev->fd, VFIO_DEVICE_FEATURE, feature);
+        if (ret) {
+            ret = -errno;
+            error_report("%s: Failed to start DMA logging, err %d (%s)",
+                         vbasedev->name, ret, strerror(errno));
+            goto out;
         }
+        vbasedev->dirty_tracking = true;
     }
 
 out:
@@ -1440,22 +1451,19 @@ static int vfio_devices_query_dirty_bitmap(VFIOContainer *container,
                                            VFIOBitmap *vbmap, hwaddr iova,
                                            hwaddr size)
 {
-    VFIODevice *vbasedev;
-    VFIOGroup *group;
+    VFIODevice *vbasedev = NULL;
     int ret;
 
-    QLIST_FOREACH(group, &container->group_list, container_next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            ret = vfio_device_dma_logging_report(vbasedev, iova, size,
-                                                 vbmap->bitmap);
-            if (ret) {
-                error_report("%s: Failed to get DMA logging report, iova: "
-                             "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx
-                             ", err: %d (%s)",
-                             vbasedev->name, iova, size, ret, strerror(-ret));
+    while ((vbasedev = vfio_container_dev_iter_next(container, vbasedev))) {
+        ret = vfio_device_dma_logging_report(vbasedev, iova, size,
+                                             vbmap->bitmap);
+        if (ret) {
+            error_report("%s: Failed to get DMA logging report, iova: "
+                         "0x%" HWADDR_PRIx ", size: 0x%" HWADDR_PRIx
+                         ", err: %d (%s)",
+                         vbasedev->name, iova, size, ret, strerror(-ret));
 
-                return ret;
-            }
+            return ret;
         }
     }
 
@@ -1739,21 +1747,30 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
 
 void vfio_reset_handler(void *opaque)
 {
-    VFIOGroup *group;
+    VFIOAddressSpace *space;
+    VFIOContainer *container;
     VFIODevice *vbasedev;
 
-    QLIST_FOREACH(group, &vfio_group_list, next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            if (vbasedev->dev->realized) {
-                vbasedev->ops->vfio_compute_needs_reset(vbasedev);
+    QLIST_FOREACH(space, &vfio_address_spaces, list) {
+        QLIST_FOREACH(container, &space->containers, next) {
+            vbasedev = NULL;
+            while ((vbasedev = vfio_container_dev_iter_next(container,
+                                                            vbasedev))) {
+                if (vbasedev->dev->realized) {
+                    vbasedev->ops->vfio_compute_needs_reset(vbasedev);
+                }
             }
         }
     }
 
-    QLIST_FOREACH(group, &vfio_group_list, next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            if (vbasedev->dev->realized && vbasedev->needs_reset) {
-                vbasedev->ops->vfio_hot_reset_multi(vbasedev);
+    QLIST_FOREACH(space, &vfio_address_spaces, list) {
+        QLIST_FOREACH(container, &space->containers, next) {
+            vbasedev = NULL;
+            while ((vbasedev = vfio_container_dev_iter_next(container,
+                                                            vbasedev))) {
+                if (vbasedev->dev->realized && vbasedev->needs_reset) {
+                    vbasedev->ops->vfio_hot_reset_multi(vbasedev);
+                    }
             }
         }
     }
@@ -1847,6 +1864,10 @@ static VFIOAddressSpace *vfio_get_address_space(AddressSpace *as)
     space->as = as;
     QLIST_INIT(&space->containers);
 
+    if (QLIST_EMPTY(&vfio_address_spaces)) {
+        qemu_register_reset(vfio_reset_handler, NULL);
+    }
+
     QLIST_INSERT_HEAD(&vfio_address_spaces, space, list);
 
     return space;
@@ -1858,6 +1879,9 @@ static void vfio_put_address_space(VFIOAddressSpace *space)
         QLIST_REMOVE(space, list);
         g_free(space);
     }
+    if (QLIST_EMPTY(&vfio_address_spaces)) {
+        qemu_unregister_reset(vfio_reset_handler, NULL);
+    }
 }
 
 /*
@@ -2323,10 +2347,6 @@ VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
         goto close_fd_exit;
     }
 
-    if (QLIST_EMPTY(&vfio_group_list)) {
-        qemu_register_reset(vfio_reset_handler, NULL);
-    }
-
     QLIST_INSERT_HEAD(&vfio_group_list, group, next);
 
     return group;
@@ -2355,10 +2375,6 @@ void vfio_put_group(VFIOGroup *group)
     trace_vfio_put_group(group->fd);
     close(group->fd);
     g_free(group);
-
-    if (QLIST_EMPTY(&vfio_group_list)) {
-        qemu_unregister_reset(vfio_reset_handler, NULL);
-    }
 }
 
 struct vfio_device_info *vfio_get_device_info(int fd)
-- 
2.34.1


