Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B507DED7B
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:37:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qySAZ-0000re-P0; Thu, 02 Nov 2023 03:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qySAM-0000N9-7o
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:30:58 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qySAK-0003Ox-Ip
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698910256; x=1730446256;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mgfP+9nkXo1nd7QBOZYlI1vQZnttEZ8bVbqSddms4hg=;
 b=nAlM3qyT7SdzRTTvdquUr3EirWGyxQF4W0ZYrr4cgKKF18EVEs3r7qlx
 Qq2ox0Lm63h0xPJ9QuL7CNkxoaaiJS9TdefrtRnTEGyWQcVK72s6wa5D/
 8u1uiaobcxtTHQOUttsHEcvgJoGc5tdACfrHgWufAmx3GgvEzdqhzRtXN
 GG5wtpI5lLlf7uYViOTSHo+tz+cDMHMQmkAgDP65jRLNGLaPvPbj4i1P3
 A8SFUJbG6MO2lJDUhPC0IHE4Hmbahli6B4fIZEx380pscKaeev4n0KuGa
 ycVp9rIogGCuG6wFAuLXpTKMAUMxvggND7gOGsH1EFygHKzKESA/PVWUT Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452953345"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="452953345"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:30:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711055685"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="711055685"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:30:36 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 31/41] vfio/pci: Extract out a helper
 vfio_pci_get_pci_hot_reset_info
Date: Thu,  2 Nov 2023 15:12:52 +0800
Message-Id: <20231102071302.1818071-32-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This helper will be used by both legacy and iommufd backends.

No functional changes intended.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.h |  3 +++
 hw/vfio/pci.c | 54 +++++++++++++++++++++++++++++++++++----------------
 2 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index fba8737ab2..1006061afb 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -218,6 +218,9 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr);
 
 extern const PropertyInfo qdev_prop_nv_gpudirect_clique;
 
+int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
+                                    struct vfio_pci_hot_reset_info **info_p);
+
 int vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp);
 
 int vfio_pci_igd_opregion_init(VFIOPCIDevice *vdev,
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c62c02f7b6..eb55e8ae88 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2445,22 +2445,13 @@ static bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name)
     return (strcmp(tmp, name) == 0);
 }
 
-static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
+int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
+                                    struct vfio_pci_hot_reset_info **info_p)
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
@@ -2468,24 +2459,53 @@ static int vfio_pci_hot_reset(VFIOPCIDevice *vdev, bool single)
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


