Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFC77CD882
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 11:48:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt38M-0001Cw-Ds; Wed, 18 Oct 2023 05:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt388-0000mq-Hv
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:46:23 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt385-0003Wp-Pn
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:46:19 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S9Qw75WGwz4xbv;
 Wed, 18 Oct 2023 20:46:15 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9Qw56dN3z4xbC;
 Wed, 18 Oct 2023 20:46:13 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/22] vfio/common: Introduce a global VFIODevice list
Date: Wed, 18 Oct 2023 11:45:23 +0200
Message-ID: <20231018094531.733211-15-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018094531.733211-1-clg@redhat.com>
References: <20231018094531.733211-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=VFJy=GA=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Some functions iterate over all the VFIODevices. This is currently
achieved by iterating over all groups/devices. Let's
introduce a global list of VFIODevices simplifying that scan.

This will also be useful while migrating to IOMMUFD by hiding the
group specificity.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  2 ++
 hw/vfio/common.c              | 45 +++++++++++++++--------------------
 2 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index bf12e406676e5577ad9454152aec9340666241dc..54905b9dd4bbb0b2c8bc9b3ee232e539a9a46216 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -131,6 +131,7 @@ typedef struct VFIODeviceOps VFIODeviceOps;
 typedef struct VFIODevice {
     QLIST_ENTRY(VFIODevice) next;
     QLIST_ENTRY(VFIODevice) container_next;
+    QLIST_ENTRY(VFIODevice) global_next;
     struct VFIOGroup *group;
     VFIOContainer *container;
     char *sysfsdev;
@@ -232,6 +233,7 @@ int vfio_kvm_device_del_fd(int fd, Error **errp);
 
 extern const MemoryRegionOps vfio_region_ops;
 typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
+typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIOGroupList vfio_group_list;
 
 bool vfio_mig_active(void);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 55f8a113ea82afeb9620d46286f04f85dd9e8b54..95bc50bcda4c44612cda2b0d8e9d5782e31ea4c6 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -48,6 +48,8 @@
 
 VFIOGroupList vfio_group_list =
     QLIST_HEAD_INITIALIZER(vfio_group_list);
+static VFIODeviceList vfio_device_list =
+    QLIST_HEAD_INITIALIZER(vfio_device_list);
 static QLIST_HEAD(, VFIOAddressSpace) vfio_address_spaces =
     QLIST_HEAD_INITIALIZER(vfio_address_spaces);
 
@@ -94,18 +96,15 @@ static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
 
 bool vfio_mig_active(void)
 {
-    VFIOGroup *group;
     VFIODevice *vbasedev;
 
-    if (QLIST_EMPTY(&vfio_group_list)) {
+    if (QLIST_EMPTY(&vfio_device_list)) {
         return false;
     }
 
-    QLIST_FOREACH(group, &vfio_group_list, next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            if (vbasedev->migration_blocker) {
-                return false;
-            }
+    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
+        if (vbasedev->migration_blocker) {
+            return false;
         }
     }
     return true;
@@ -120,19 +119,16 @@ static Error *multiple_devices_migration_blocker;
  */
 static bool vfio_multiple_devices_migration_is_supported(void)
 {
-    VFIOGroup *group;
     VFIODevice *vbasedev;
     unsigned int device_num = 0;
     bool all_support_p2p = true;
 
-    QLIST_FOREACH(group, &vfio_group_list, next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            if (vbasedev->migration) {
-                device_num++;
+    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
+        if (vbasedev->migration) {
+            device_num++;
 
-                if (!(vbasedev->migration->mig_flags & VFIO_MIGRATION_P2P)) {
-                    all_support_p2p = false;
-                }
+            if (!(vbasedev->migration->mig_flags & VFIO_MIGRATION_P2P)) {
+                all_support_p2p = false;
             }
         }
     }
@@ -1777,22 +1773,17 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
 
 void vfio_reset_handler(void *opaque)
 {
-    VFIOGroup *group;
     VFIODevice *vbasedev;
 
-    QLIST_FOREACH(group, &vfio_group_list, next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            if (vbasedev->dev->realized) {
-                vbasedev->ops->vfio_compute_needs_reset(vbasedev);
-            }
+    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
+        if (vbasedev->dev->realized) {
+            vbasedev->ops->vfio_compute_needs_reset(vbasedev);
         }
     }
 
-    QLIST_FOREACH(group, &vfio_group_list, next) {
-        QLIST_FOREACH(vbasedev, &group->device_list, next) {
-            if (vbasedev->dev->realized && vbasedev->needs_reset) {
-                vbasedev->ops->vfio_hot_reset_multi(vbasedev);
-            }
+    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
+        if (vbasedev->dev->realized && vbasedev->needs_reset) {
+            vbasedev->ops->vfio_hot_reset_multi(vbasedev);
         }
     }
 }
@@ -2657,6 +2648,7 @@ int vfio_attach_device(char *name, VFIODevice *vbasedev,
     container = group->container;
     vbasedev->container = container;
     QLIST_INSERT_HEAD(&container->device_list, vbasedev, container_next);
+    QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
 
     return ret;
 }
@@ -2669,6 +2661,7 @@ void vfio_detach_device(VFIODevice *vbasedev)
         return;
     }
 
+    QLIST_REMOVE(vbasedev, global_next);
     QLIST_REMOVE(vbasedev, container_next);
     vbasedev->container = NULL;
     trace_vfio_detach_device(vbasedev->name, group->groupid);
-- 
2.41.0


