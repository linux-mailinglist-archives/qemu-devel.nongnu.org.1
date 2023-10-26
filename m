Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3D47D8125
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:50:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvxv9-0003RF-8A; Thu, 26 Oct 2023 06:48:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxus-0002fF-FJ
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:48:42 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxug-0001Q0-Ei
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698317310; x=1729853310;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=p/60cmea6GKOpVhxSghBXzAP6SrSy/0FosUd0BMTBBM=;
 b=en+lmH70g1l25E7lY+XouLJN03Cbnsxp9ZeNvNA3TrhllsNLEmWYfNMM
 pBfypwIq1E6n/+tXML8tKvOFQ12fkIhct2Zf3C41oreCB4qEtNgOUWTwN
 SyQMeYWeEBQSrhWeueJlrkQTFMZYhxFG/jn8edXHSlrL5uPf2uZeYUW4a
 WRvzTbFx33QkGAWvnrplP7Ha+Tuzgtibcdt5/MkPK0DKB4JKOogrOosH8
 bllLWdb+glLfK1fHUWrAHJLqBKgTMueonrXCGfKNG3FGsb56yGqN+PD4z
 8SsmYupqsPuOMcuE3jl/IGyL1vzBUdOHaNkaISUe1+WqVI8oFVyc7utft A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="372563719"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; d="scan'208";a="372563719"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:47:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="463804"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:47:45 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 27/37] vfio/iommufd: Switch to manual hwpt allocation
Date: Thu, 26 Oct 2023 18:30:54 +0800
Message-Id: <20231026103104.1686921-28-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

IOMMUFD supports auto allocated hwpt and manually allocated one.
Manually allocated hwpt has benefit that its life cycle is under
user's control, so it could be used as stage 2 page table by nested
feature in the future.

Introduce two helpers __vfio_device_attach/detach_hwpt to facilitate
this change.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/iommufd.c | 89 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 70 insertions(+), 19 deletions(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index aee64d63f3..c1daaf1c39 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -217,38 +217,91 @@ static VFIOIOASHwpt *vfio_container_get_hwpt(VFIOIOMMUFDContainer *container,
 static void vfio_container_put_hwpt(IOMMUFDBackend *be, VFIOIOASHwpt *hwpt)
 {
     QLIST_REMOVE(hwpt, next);
+    iommufd_backend_free_id(be->fd, hwpt->hwpt_id);
     g_free(hwpt);
 }
 
-static int vfio_device_attach_container(VFIODevice *vbasedev,
-                                        VFIOIOMMUFDContainer *container,
-                                        Error **errp)
+static int __vfio_device_attach_hwpt(VFIODevice *vbasedev, uint32_t hwpt_id,
+                                     Error **errp)
 {
-    int ret, iommufd = vbasedev->iommufd->fd;
-    VFIOIOASHwpt *hwpt;
     struct vfio_device_attach_iommufd_pt attach_data = {
         .argsz = sizeof(attach_data),
         .flags = 0,
-        .pt_id = container->ioas_id,
+        .pt_id = hwpt_id,
     };
+    int ret;
 
-    /* Attach device to an ioas within iommufd */
     ret = ioctl(vbasedev->fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
     if (ret) {
         error_setg_errno(errp, errno,
-                         "[iommufd=%d] error attach %s (%d) to ioasid=%d",
-                         container->be->fd, vbasedev->name, vbasedev->fd,
-                         attach_data.pt_id);
+                         "[iommufd=%d] error attach %s (%d) to hwpt_id=%d",
+                         vbasedev->iommufd->fd, vbasedev->name, vbasedev->fd,
+                         hwpt_id);
+    }
+    return ret;
+}
+
+static int __vfio_device_detach_hwpt(VFIODevice *vbasedev, Error **errp)
+{
+    struct vfio_device_detach_iommufd_pt detach_data = {
+        .argsz = sizeof(detach_data),
+        .flags = 0,
+    };
+    int ret;
+
+    ret = ioctl(vbasedev->fd, VFIO_DEVICE_DETACH_IOMMUFD_PT, &detach_data);
+    if (ret) {
+        error_setg_errno(errp, errno, "detach %s from ioas failed",
+                         vbasedev->name);
+    }
+    return ret;
+}
+
+static int vfio_device_attach_container(VFIODevice *vbasedev,
+                                        VFIOIOMMUFDContainer *container,
+                                        Error **errp)
+{
+    int ret, iommufd = vbasedev->iommufd->fd;
+    VFIOIOASHwpt *hwpt;
+    uint32_t hwpt_id;
+    Error *err = NULL;
+
+    /* try to attach to an existing hwpt in this container */
+    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
+        ret = __vfio_device_attach_hwpt(vbasedev, hwpt->hwpt_id, &err);
+        if (ret) {
+            const char *msg = error_get_pretty(err);
+
+            trace_vfio_iommufd_fail_attach_existing_hwpt(msg);
+            error_free(err);
+            err = NULL;
+        } else {
+            goto found_hwpt;
+        }
+    }
+
+    ret = iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
+                                     container->ioas_id, &hwpt_id);
+
+    if (ret) {
+        error_setg_errno(errp, errno, "error alloc shadow hwpt");
         return ret;
+    }
 
+    /* Attach device to an hwpt within iommufd */
+    ret = __vfio_device_attach_hwpt(vbasedev, hwpt_id, errp);
+    if (ret) {
+        iommufd_backend_free_id(iommufd, hwpt_id);
+        return ret;
     }
-    hwpt = vfio_container_get_hwpt(container, attach_data.pt_id);
 
+    hwpt = vfio_container_get_hwpt(container, hwpt_id);
+found_hwpt:
     QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, next);
     vbasedev->hwpt = hwpt;
 
     trace_vfio_iommufd_attach_device(iommufd, vbasedev->name, vbasedev->fd,
-                                     container->ioas_id, attach_data.pt_id);
+                                     container->ioas_id, hwpt->hwpt_id);
     return ret;
 }
 
@@ -256,14 +309,12 @@ static void vfio_device_detach_container(VFIODevice *vbasedev,
                                          VFIOIOMMUFDContainer *container)
 {
     VFIOIOASHwpt *hwpt = vbasedev->hwpt;
-    struct vfio_device_attach_iommufd_pt detach_data = {
-        .argsz = sizeof(detach_data),
-        .flags = 0,
-    };
+    Error *err = NULL;
+    int ret;
 
-    if (ioctl(vbasedev->fd, VFIO_DEVICE_DETACH_IOMMUFD_PT, &detach_data)) {
-        error_report("detach %s from ioas id=%d failed: %m", vbasedev->name,
-                     container->ioas_id);
+    ret = __vfio_device_detach_hwpt(vbasedev, &err);
+    if (ret) {
+        error_report_err(err);
     }
 
     QLIST_REMOVE(vbasedev, next);
-- 
2.34.1


