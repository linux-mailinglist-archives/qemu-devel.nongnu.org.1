Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB337D813E
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:53:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvxvE-00040f-2v; Thu, 26 Oct 2023 06:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxv5-0003ie-0j
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:48:57 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxv2-0001Q0-SZ
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:48:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698317332; x=1729853332;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jjlVJ29JqSy3D8jINIsIygktcWD2qs3ZSL2RaHPUFuI=;
 b=lweTTt+aUD5nX6s5WhcmA7pNZ1TQULBgI62r7xKaaBjW2D7uKK6Uti+Z
 mYDccRbFRM/2/7aSBH9z0lcgrWXxsUbHSkueVY7qpwIspcdmsafyhWZCH
 P+ismcyE3G+KZIVwY2ri4FxZpyYqzIYncnAXeFMiXa/oXCmPGcV8Paw7k
 LdkQUJYgCF9exn8fC0HnmJ0BgxA4gO8G+5joDsw/pMZ7F8h6iIZKBb0Hc
 0vVo2I8pmsrHUELqvoWz5nI+w4xy3YW1yQ+IBsMkEhRNdqKFjrhT+pody
 1ZOahlaLlEwF97GVD6mVA6gwb4f1XSBtRXAMSblGwBlAjnWtybfnX30qW Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="372563779"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; d="scan'208";a="372563779"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:48:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="463833"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:47:57 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 30/37] vfio/pci: Extract out a helper
 vfio_pci_get_pci_hot_reset_info
Date: Thu, 26 Oct 2023 18:30:57 +0800
Message-Id: <20231026103104.1686921-31-zhenzhong.duan@intel.com>
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

This helper will be used by both legacy and iommufd backends.

No functional changes intended.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c | 54 +++++++++++++++++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5cbc771e55..c17e1f4376 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2459,22 +2459,13 @@ static bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name)
     return (strcmp(tmp, name) == 0);
 }
 
-static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
+static int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
+                                       struct vfio_pci_hot_reset_info **info_p)
 {
-    VFIOGroup *group;
     struct vfio_pci_hot_reset_info *info;
-    struct vfio_pci_dependent_device *devices;
-    struct vfio_pci_hot_reset *reset;
-    int32_t *fds;
-    int ret, i, count;
-    bool multi = false;
+    int ret, count;
 
-    trace_vfio_pci_hot_reset(vdev->vbasedev.name, single ? "one" : "multi");
-
-    if (!single) {
-        vfio_pci_pre_reset(vdev);
-    }
-    vdev->vbasedev.needs_reset = false;
+    assert(info_p && !*info_p);
 
     info = g_malloc0(sizeof(*info));
     info->argsz = sizeof(*info);
@@ -2482,24 +2473,53 @@ static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
     ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_PCI_HOT_RESET_INFO, info);
     if (ret && errno != ENOSPC) {
         ret = -errno;
+        g_free(info);
         if (!vdev->has_pm_reset) {
             error_report("vfio: Cannot reset device %s, "
                          "no available reset mechanism.", vdev->vbasedev.name);
         }
-        goto out_single;
+        return ret;
     }
 
     count = info->count;
-    info = g_realloc(info, sizeof(*info) + (count * sizeof(*devices)));
-    info->argsz = sizeof(*info) + (count * sizeof(*devices));
-    devices = &info->devices[0];
+    info = g_realloc(info, sizeof(*info) + (count * sizeof(info->devices[0])));
+    info->argsz = sizeof(*info) + (count * sizeof(info->devices[0]));
 
     ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_PCI_HOT_RESET_INFO, info);
     if (ret) {
         ret = -errno;
+        g_free(info);
         error_report("vfio: hot reset info failed: %m");
+        return ret;
+    }
+
+    *info_p = info;
+    return 0;
+}
+
+static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
+{
+    VFIOGroup *group;
+    struct vfio_pci_hot_reset_info *info = NULL;
+    struct vfio_pci_dependent_device *devices;
+    struct vfio_pci_hot_reset *reset;
+    int32_t *fds;
+    int ret, i, count;
+    bool multi = false;
+
+    trace_vfio_pci_hot_reset(vdev->vbasedev.name, single ? "one" : "multi");
+
+    if (!single) {
+        vfio_pci_pre_reset(vdev);
+    }
+    vdev->vbasedev.needs_reset = false;
+
+    ret = vfio_pci_get_pci_hot_reset_info(vdev, &info);
+
+    if (ret) {
         goto out_single;
     }
+    devices = &info->devices[0];
 
     trace_vfio_pci_hot_reset_has_dep_devices(vdev->vbasedev.name);
 
-- 
2.34.1


