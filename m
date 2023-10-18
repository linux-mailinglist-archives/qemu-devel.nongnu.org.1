Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 464B47CD886
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 11:48:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt38N-0001EH-SX; Wed, 18 Oct 2023 05:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt37z-0000Pi-7t
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:46:15 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt37v-0003UH-VO
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:46:10 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S9Qvx7294z4xbj;
 Wed, 18 Oct 2023 20:46:05 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9Qvv6L0dz4xbC;
 Wed, 18 Oct 2023 20:46:03 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 10/22] vfio/ccw: Use vfio_[attach/detach]_device
Date: Wed, 18 Oct 2023 11:45:19 +0200
Message-ID: <20231018094531.733211-11-clg@redhat.com>
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

From: Eric Auger <eric.auger@redhat.com>

Let the vfio-ccw device use vfio_attach_device() and
vfio_detach_device(), hence hiding the details of the used
IOMMU backend.

Note that the migration reduces the following trace
"vfio: subchannel %s has already been attached" (featuring
cssid.ssid.devid) into "device is already attached"

Also now all the devices have been migrated to use the new
vfio_attach_device/vfio_detach_device API, let's turn the
legacy functions into static functions, local to container.c.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |   5 --
 hw/vfio/ccw.c                 | 117 ++++++++--------------------------
 hw/vfio/common.c              |  10 +--
 3 files changed, 32 insertions(+), 100 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 12fbfbc37d466abcd85a838f26567dc0add84de0..c486bdef2adfe77e02f80559005d09426a7634bd 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -202,7 +202,6 @@ typedef struct {
     hwaddr pages;
 } VFIOBitmap;
 
-void vfio_put_base_device(VFIODevice *vbasedev);
 void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
 void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
 void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
@@ -220,11 +219,7 @@ void vfio_region_unmap(VFIORegion *region);
 void vfio_region_exit(VFIORegion *region);
 void vfio_region_finalize(VFIORegion *region);
 void vfio_reset_handler(void *opaque);
-VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp);
-void vfio_put_group(VFIOGroup *group);
 struct vfio_device_info *vfio_get_device_info(int fd);
-int vfio_get_device(VFIOGroup *group, const char *name,
-                    VFIODevice *vbasedev, Error **errp);
 int vfio_attach_device(char *name, VFIODevice *vbasedev,
                        AddressSpace *as, Error **errp);
 void vfio_detach_device(VFIODevice *vbasedev);
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 1e2fce83b084675d90f42777a58eb95b47ccbbae..6623ae237bbc0729fbcc131c77676dd204b7873e 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -572,88 +572,14 @@ static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
     g_free(vcdev->io_region);
 }
 
-static void vfio_ccw_put_device(VFIOCCWDevice *vcdev)
-{
-    g_free(vcdev->vdev.name);
-    vfio_put_base_device(&vcdev->vdev);
-}
-
-static void vfio_ccw_get_device(VFIOGroup *group, VFIOCCWDevice *vcdev,
-                                Error **errp)
-{
-    S390CCWDevice *cdev = S390_CCW_DEVICE(vcdev);
-    char *name = g_strdup_printf("%x.%x.%04x", cdev->hostid.cssid,
-                                 cdev->hostid.ssid,
-                                 cdev->hostid.devid);
-    VFIODevice *vbasedev;
-
-    QLIST_FOREACH(vbasedev, &group->device_list, next) {
-        if (strcmp(vbasedev->name, name) == 0) {
-            error_setg(errp, "vfio: subchannel %s has already been attached",
-                       name);
-            goto out_err;
-        }
-    }
-
-    /*
-     * All vfio-ccw devices are believed to operate in a way compatible with
-     * discarding of memory in RAM blocks, ie. pages pinned in the host are
-     * in the current working set of the guest driver and therefore never
-     * overlap e.g., with pages available to the guest balloon driver.  This
-     * needs to be set before vfio_get_device() for vfio common to handle
-     * ram_block_discard_disable().
-     */
-    vcdev->vdev.ram_block_discard_allowed = true;
-
-    if (vfio_get_device(group, cdev->mdevid, &vcdev->vdev, errp)) {
-        goto out_err;
-    }
-
-    vcdev->vdev.ops = &vfio_ccw_ops;
-    vcdev->vdev.type = VFIO_DEVICE_TYPE_CCW;
-    vcdev->vdev.name = name;
-    vcdev->vdev.dev = DEVICE(vcdev);
-
-    return;
-
-out_err:
-    g_free(name);
-}
-
-static VFIOGroup *vfio_ccw_get_group(S390CCWDevice *cdev, Error **errp)
-{
-    char *tmp, group_path[PATH_MAX];
-    ssize_t len;
-    int groupid;
-
-    tmp = g_strdup_printf("/sys/bus/css/devices/%x.%x.%04x/%s/iommu_group",
-                          cdev->hostid.cssid, cdev->hostid.ssid,
-                          cdev->hostid.devid, cdev->mdevid);
-    len = readlink(tmp, group_path, sizeof(group_path));
-    g_free(tmp);
-
-    if (len <= 0 || len >= sizeof(group_path)) {
-        error_setg(errp, "vfio: no iommu_group found");
-        return NULL;
-    }
-
-    group_path[len] = 0;
-
-    if (sscanf(basename(group_path), "%d", &groupid) != 1) {
-        error_setg(errp, "vfio: failed to read %s", group_path);
-        return NULL;
-    }
-
-    return vfio_get_group(groupid, &address_space_memory, errp);
-}
-
 static void vfio_ccw_realize(DeviceState *dev, Error **errp)
 {
-    VFIOGroup *group;
     S390CCWDevice *cdev = S390_CCW_DEVICE(dev);
     VFIOCCWDevice *vcdev = VFIO_CCW(cdev);
     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
+    VFIODevice *vbasedev = &vcdev->vdev;
     Error *err = NULL;
+    int ret;
 
     /* Call the class init function for subchannel. */
     if (cdc->realize) {
@@ -663,14 +589,27 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    group = vfio_ccw_get_group(cdev, &err);
-    if (!group) {
-        goto out_group_err;
-    }
+    vbasedev->ops = &vfio_ccw_ops;
+    vbasedev->type = VFIO_DEVICE_TYPE_CCW;
+    vbasedev->name = g_strdup_printf("%x.%x.%04x", vcdev->cdev.hostid.cssid,
+                           vcdev->cdev.hostid.ssid,
+                           vcdev->cdev.hostid.devid);
+    vbasedev->dev = dev;
 
-    vfio_ccw_get_device(group, vcdev, &err);
-    if (err) {
-        goto out_device_err;
+    /*
+     * All vfio-ccw devices are believed to operate in a way compatible with
+     * discarding of memory in RAM blocks, ie. pages pinned in the host are
+     * in the current working set of the guest driver and therefore never
+     * overlap e.g., with pages available to the guest balloon driver.  This
+     * needs to be set before vfio_get_device() for vfio common to handle
+     * ram_block_discard_disable().
+     */
+    vbasedev->ram_block_discard_allowed = true;
+
+    ret = vfio_attach_device(cdev->mdevid, vbasedev,
+                             &address_space_memory, errp);
+    if (ret) {
+        goto out_attach_dev_err;
     }
 
     vfio_ccw_get_region(vcdev, &err);
@@ -708,10 +647,9 @@ out_irq_notifier_err:
 out_io_notifier_err:
     vfio_ccw_put_region(vcdev);
 out_region_err:
-    vfio_ccw_put_device(vcdev);
-out_device_err:
-    vfio_put_group(group);
-out_group_err:
+    vfio_detach_device(vbasedev);
+out_attach_dev_err:
+    g_free(vbasedev->name);
     if (cdc->unrealize) {
         cdc->unrealize(cdev);
     }
@@ -724,14 +662,13 @@ static void vfio_ccw_unrealize(DeviceState *dev)
     S390CCWDevice *cdev = S390_CCW_DEVICE(dev);
     VFIOCCWDevice *vcdev = VFIO_CCW(cdev);
     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
-    VFIOGroup *group = vcdev->vdev.group;
 
     vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_REQ_IRQ_INDEX);
     vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_CRW_IRQ_INDEX);
     vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX);
     vfio_ccw_put_region(vcdev);
-    vfio_ccw_put_device(vcdev);
-    vfio_put_group(group);
+    vfio_detach_device(&vcdev->vdev);
+    g_free(vcdev->vdev.name);
 
     if (cdc->unrealize) {
         cdc->unrealize(cdev);
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index f4c33c9858f5cc2b8245a9725fd660e7898ee760..56cfe94d97779b539dbb15d88f2968c377d16bae 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -2335,7 +2335,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
     }
 }
 
-VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
+static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
 {
     VFIOGroup *group;
     char path[32];
@@ -2402,7 +2402,7 @@ free_group_exit:
     return NULL;
 }
 
-void vfio_put_group(VFIOGroup *group)
+static void vfio_put_group(VFIOGroup *group)
 {
     if (!group || !QLIST_EMPTY(&group->device_list)) {
         return;
@@ -2447,8 +2447,8 @@ retry:
     return info;
 }
 
-int vfio_get_device(VFIOGroup *group, const char *name,
-                    VFIODevice *vbasedev, Error **errp)
+static int vfio_get_device(VFIOGroup *group, const char *name,
+                           VFIODevice *vbasedev, Error **errp)
 {
     g_autofree struct vfio_device_info *info = NULL;
     int fd;
@@ -2506,7 +2506,7 @@ int vfio_get_device(VFIOGroup *group, const char *name,
     return 0;
 }
 
-void vfio_put_base_device(VFIODevice *vbasedev)
+static void vfio_put_base_device(VFIODevice *vbasedev)
 {
     if (!vbasedev->group) {
         return;
-- 
2.41.0


