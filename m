Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4481E7AE399
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 04:15:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkxaj-0004eR-Ne; Mon, 25 Sep 2023 22:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qkxah-0004dh-Rw
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 22:14:23 -0400
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qkxag-0002e0-4M
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 22:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695694462; x=1727230462;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6lQYAHPuI/TlrcW63zBcoubCLGW7adiaATdLkZPOXQc=;
 b=HaJajX4rWZMiv1AJAN1/5p02I8G+f4RuiNy3totuo+kAsj0VOomjrF/5
 3IWtt2EKDpXO2MBGsyfvQnki3jxHF3c39JfZE05fmXe2XapT+r1o085/h
 NQxKsw7Y5Kzb05oSI4dxemv9d5MaGBoJ+XIY308m3dF6e0gtVsX4/40mf
 3UhDY2PyKThLrOpCrzx9jc07qnYw9uVVBYysypgkgDrN84gcY2kkEXdON
 UO1h/WOpnd6DShXNFZZp9+aAp09mKhQPGFv/4iEPqCZl+4StV7vcRMRLh
 o5b61uF0D5APzQK8wdR2ABHG6OvwKV/sh1cDQ2mk0kg3duaPxRowhBT/X g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412380121"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; d="scan'208";a="412380121"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2023 19:14:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="698283011"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; d="scan'208";a="698283011"
Received: from vmmteam.bj.intel.com ([10.240.193.84])
 by orsmga003.jf.intel.com with ESMTP; 25 Sep 2023 19:14:14 -0700
From: Jing Liu <jing2.liu@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, pbonzini@redhat.com,
 kevin.tian@intel.com, reinette.chatre@intel.com, jing2.liu@intel.com,
 jing2.liu@linux.intel.com
Subject: [PATCH v3 1/4] vfio/pci: detect the support of dynamic MSI-X
 allocation
Date: Mon, 25 Sep 2023 22:14:04 -0400
Message-Id: <20230926021407.580305-2-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230926021407.580305-1-jing2.liu@intel.com>
References: <20230926021407.580305-1-jing2.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.88; envelope-from=jing2.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Kernel provides the guidance of dynamic MSI-X allocation support of
passthrough device, by clearing the VFIO_IRQ_INFO_NORESIZE flag to
guide user space.

Fetch the flags from host to determine if dynamic MSI-X allocation is
supported.

Originally-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
---
Changes since v2:
- Apply Alex's Reviewed-by.

Changes since v1:
- Free msix when failed to get MSI-X irq info. (Cédric)
- Apply Cédric's Reviewed-by.

Changes since RFC v1:
- Filter the dynamic MSI-X allocation flag and store as a bool type.
  (Alex)
- Move the detection to vfio_msix_early_setup(). (Alex)
- Report error of getting irq info and remove the trace of failure
  case. (Alex, Cédric)
---
 hw/vfio/pci.c        | 16 ++++++++++++++--
 hw/vfio/pci.h        |  1 +
 hw/vfio/trace-events |  2 +-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 3b2ca3c24ca2..a94eef50e41e 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1493,7 +1493,9 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
     uint8_t pos;
     uint16_t ctrl;
     uint32_t table, pba;
-    int fd = vdev->vbasedev.fd;
+    int ret, fd = vdev->vbasedev.fd;
+    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info),
+                                      .index = VFIO_PCI_MSIX_IRQ_INDEX };
     VFIOMSIXInfo *msix;
 
     pos = pci_find_capability(&vdev->pdev, PCI_CAP_ID_MSIX);
@@ -1530,6 +1532,15 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
     msix->pba_offset = pba & ~PCI_MSIX_FLAGS_BIRMASK;
     msix->entries = (ctrl & PCI_MSIX_FLAGS_QSIZE) + 1;
 
+    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "failed to get MSI-X irq info");
+        g_free(msix);
+        return;
+    }
+
+    msix->noresize = !!(irq_info.flags & VFIO_IRQ_INFO_NORESIZE);
+
     /*
      * Test the size of the pba_offset variable and catch if it extends outside
      * of the specified BAR. If it is the case, we need to apply a hardware
@@ -1562,7 +1573,8 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
     }
 
     trace_vfio_msix_early_setup(vdev->vbasedev.name, pos, msix->table_bar,
-                                msix->table_offset, msix->entries);
+                                msix->table_offset, msix->entries,
+                                msix->noresize);
     vdev->msix = msix;
 
     vfio_pci_fixup_msix_region(vdev);
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 2d836093a83d..0d89eb761ece 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -113,6 +113,7 @@ typedef struct VFIOMSIXInfo {
     uint32_t table_offset;
     uint32_t pba_offset;
     unsigned long *pending;
+    bool noresize;
 } VFIOMSIXInfo;
 
 #define TYPE_VFIO_PCI "vfio-pci"
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index e64ca4a01961..0ba3c5a0e26b 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -27,7 +27,7 @@ vfio_vga_read(uint64_t addr, int size, uint64_t data) " (0x%"PRIx64", %d) = 0x%"
 vfio_pci_read_config(const char *name, int addr, int len, int val) " (%s, @0x%x, len=0x%x) 0x%x"
 vfio_pci_write_config(const char *name, int addr, int val, int len) " (%s, @0x%x, 0x%x, len=0x%x)"
 vfio_msi_setup(const char *name, int pos) "%s PCI MSI CAP @0x%x"
-vfio_msix_early_setup(const char *name, int pos, int table_bar, int offset, int entries) "%s PCI MSI-X CAP @0x%x, BAR %d, offset 0x%x, entries %d"
+vfio_msix_early_setup(const char *name, int pos, int table_bar, int offset, int entries, bool noresize) "%s PCI MSI-X CAP @0x%x, BAR %d, offset 0x%x, entries %d, noresize %d"
 vfio_check_pcie_flr(const char *name) "%s Supports FLR via PCIe cap"
 vfio_check_pm_reset(const char *name) "%s Supports PM reset"
 vfio_check_af_flr(const char *name) "%s Supports FLR via AF cap"
-- 
2.27.0


