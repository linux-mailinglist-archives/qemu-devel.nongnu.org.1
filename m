Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E817AEBC2
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 13:49:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql6Y0-00032H-Pq; Tue, 26 Sep 2023 07:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ql6Xy-0002zf-6K; Tue, 26 Sep 2023 07:48:10 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ql6Xv-0002RC-N6; Tue, 26 Sep 2023 07:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695728887; x=1727264887;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BPeSCKBcYSn7Dso+6hdGbPlqMsLlfacGi6Zn0HNxVpk=;
 b=BfRJLQ39B/jwNrGqQSLsST2msXiuiMV7Fipf4NqBR1X2VT7/qPQAgMFu
 6CwmXR409CQ92bPlRMtwb0Ow4iIP0fO28M+5xnA+0ejNFEcTF8nNBE0fD
 rQ3gn+31wCEA8tQmu4eM3utZ3iPKR0GqDwIaPwvF8cgwzBaJR7ZuDu/at
 UMoHrCxI3u3rzJ1g9K1ZMtrRLchmwnkz/QQh/MmF7gIxNlLS/qmGHERXf
 lpLWiA451GB+R1L6WpFoXgu2eDFpCuDDIqpM1FXJA7PdlEU2Lal8OH8iz
 0GGECpGjkxakr2fkaoQDoY2G68raRb0w2ENnMIbMGhYfZAz8+832jVYKX Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="378825471"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; d="scan'208";a="378825471"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 04:48:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="748789748"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; d="scan'208";a="748789748"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 04:48:00 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:S390 general arch...)
Subject: [PATCH v2 09/12] vfio/ccw: Use vfio_[attach/detach]_device
Date: Tue, 26 Sep 2023 19:32:52 +0800
Message-Id: <20230926113255.1177834-10-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.93;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Also now all the devices have been migrated to use the new
vfio_attach_device/vfio_detach_device API, let's turn the
legacy functions into static functions, local to container.c.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h |   5 --
 hw/vfio/ccw.c                 | 115 ++++++++--------------------------
 hw/vfio/common.c              |  10 +--
 3 files changed, 30 insertions(+), 100 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 12fbfbc37d..c486bdef2a 100644
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
index 1e2fce83b0..6893a30ab1 100644
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
@@ -663,14 +589,25 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    group = vfio_ccw_get_group(cdev, &err);
-    if (!group) {
-        goto out_group_err;
-    }
+    vbasedev->ops = &vfio_ccw_ops;
+    vbasedev->type = VFIO_DEVICE_TYPE_CCW;
+    vbasedev->name = g_strdup(cdev->mdevid);
+    vbasedev->dev = &vcdev->cdev.parent_obj.parent_obj;
 
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
+    ret = vfio_attach_device(vbasedev->name, vbasedev,
+                             &address_space_memory, errp);
+    if (ret) {
+        goto out_attach_dev_err;
     }
 
     vfio_ccw_get_region(vcdev, &err);
@@ -708,10 +645,9 @@ out_irq_notifier_err:
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
@@ -724,14 +660,13 @@ static void vfio_ccw_unrealize(DeviceState *dev)
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
index 7f3798b152..65516b319e 100644
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
2.34.1


