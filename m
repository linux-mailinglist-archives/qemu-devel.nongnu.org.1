Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E65ABB17B35
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Aug 2025 04:29:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhfVP-0006uE-2u; Thu, 31 Jul 2025 22:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uhfV8-0006s6-5y
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 22:28:06 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uhfV0-0003ar-3w
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 22:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754015278; x=1785551278;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/XifMCmwp6uRTNmX31C1T0NZmjpQHm31KL08Qui61HU=;
 b=lRq9c4pQKO8+DxNkpY3dbNWlNshZ+BKO13jaGvOHetjhAZ11xNhJJ0I8
 q0a3nr8VvQsA/S2myVPG2f/eCpmIqH05vfX3nwPnxZR0FIuq8uE/XcwvV
 q6GaF6HQneBr3krjNi+kP4Zr6W4G77/aKppgjS+EPzrTHGhud51etGMaM
 wBnx1ywo2w0XGrFJ1imCQL9IrYNIdqfvvbfLYHBWwZMBeK3sfMMV0/XEO
 8f5CDKBmkMywA9GB/jJcUeGUdz15RYv86ju9tJ/N9zwt433uSFyPN/Fpq
 6CqDX72CeHxQo73nsGGAM6HnkX8b4mKvfi8neFZrzuiZV7+Ie+MJ2x+bB Q==;
X-CSE-ConnectionGUID: XSRpF3MdTFeZJCLMxqzyBw==
X-CSE-MsgGUID: sRgG7UiDQsKqCPdotVCp6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11508"; a="56243144"
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; d="scan'208";a="56243144"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2025 19:27:50 -0700
X-CSE-ConnectionGUID: kWMdjM+OSYKEJKXzRJsUZg==
X-CSE-MsgGUID: 9a7G0WD0TKWTxhg69aDgfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,255,1747724400"; d="scan'208";a="167905623"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2025 19:27:49 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2] vfio: Introduce helper vfio_pci_from_vfio_device()
Date: Thu, 31 Jul 2025 22:27:32 -0400
Message-ID: <20250801022732.1457628-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Introduce helper vfio_pci_from_vfio_device() to transform from VFIODevice
to VFIOPCIDevice, also to hide low level VFIO_DEVICE_TYPE_PCI type check.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
v2: move helper to hw/vfio/pci.[hc]
    rename with vfio_pci_ prefix

 hw/vfio/pci.h       | 1 +
 hw/vfio/container.c | 4 ++--
 hw/vfio/device.c    | 2 +-
 hw/vfio/iommufd.c   | 4 ++--
 hw/vfio/listener.c  | 4 ++--
 hw/vfio/pci.c       | 8 ++++++++
 6 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 81465a8214..53842cb149 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -219,6 +219,7 @@ void vfio_pci_write_config(PCIDevice *pdev,
 uint64_t vfio_vga_read(void *opaque, hwaddr addr, unsigned size);
 void vfio_vga_write(void *opaque, hwaddr addr, uint64_t data, unsigned size);
 
+VFIOPCIDevice *vfio_pci_from_vfio_device(VFIODevice *vbasedev);
 void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev);
 bool vfio_opt_rom_in_denylist(VFIOPCIDevice *vdev);
 bool vfio_config_quirk_setup(VFIOPCIDevice *vdev, Error **errp);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 3e13feaa74..134ddccc52 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1087,7 +1087,7 @@ static int vfio_legacy_pci_hot_reset(VFIODevice *vbasedev, bool single)
         /* Prep dependent devices for reset and clear our marker. */
         QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
             if (!vbasedev_iter->dev->realized ||
-                vbasedev_iter->type != VFIO_DEVICE_TYPE_PCI) {
+                !vfio_pci_from_vfio_device(vbasedev_iter)) {
                 continue;
             }
             tmp = container_of(vbasedev_iter, VFIOPCIDevice, vbasedev);
@@ -1172,7 +1172,7 @@ out:
 
         QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
             if (!vbasedev_iter->dev->realized ||
-                vbasedev_iter->type != VFIO_DEVICE_TYPE_PCI) {
+                !vfio_pci_from_vfio_device(vbasedev_iter)) {
                 continue;
             }
             tmp = container_of(vbasedev_iter, VFIOPCIDevice, vbasedev);
diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 52a1996dc4..08f12ac31f 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -129,7 +129,7 @@ static inline const char *action_to_str(int action)
 
 static const char *index_to_str(VFIODevice *vbasedev, int index)
 {
-    if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
+    if (!vfio_pci_from_vfio_device(vbasedev)) {
         return NULL;
     }
 
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 48c590b6a9..8c27222f75 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -737,8 +737,8 @@ iommufd_cdev_dep_get_realized_vpdev(struct vfio_pci_dependent_device *dep_dev,
     }
 
     vbasedev_tmp = iommufd_cdev_pci_find_by_devid(dep_dev->devid);
-    if (!vbasedev_tmp || !vbasedev_tmp->dev->realized ||
-        vbasedev_tmp->type != VFIO_DEVICE_TYPE_PCI) {
+    if (!vfio_pci_from_vfio_device(vbasedev_tmp) ||
+        !vbasedev_tmp->dev->realized) {
         return NULL;
     }
 
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index f498e23a93..903dfd8bf2 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -450,7 +450,7 @@ static void vfio_device_error_append(VFIODevice *vbasedev, Error **errp)
      * MMIO region mapping failures are not fatal but in this case PCI
      * peer-to-peer transactions are broken.
      */
-    if (vbasedev && vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
+    if (vfio_pci_from_vfio_device(vbasedev)) {
         error_append_hint(errp, "%s: PCI peer-to-peer transactions "
                           "on BARs are not supported.\n", vbasedev->name);
     }
@@ -751,7 +751,7 @@ static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
     owner = memory_region_owner(section->mr);
 
     QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
-        if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
+        if (!vfio_pci_from_vfio_device(vbasedev)) {
             continue;
         }
         pcidev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 4fa692c1a3..fb339512ba 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2824,6 +2824,14 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
     return ret;
 }
 
+VFIOPCIDevice *vfio_pci_from_vfio_device(VFIODevice *vbasedev)
+{
+    if (vbasedev && vbasedev->type == VFIO_DEVICE_TYPE_PCI) {
+        return container_of(vbasedev, VFIOPCIDevice, vbasedev);
+    }
+    return NULL;
+}
+
 void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev)
 {
     PCIDevice *pdev = &vdev->pdev;
-- 
2.47.1


