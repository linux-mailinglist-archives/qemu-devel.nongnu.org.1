Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F607A464C
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 11:46:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiAos-0005oD-8C; Mon, 18 Sep 2023 05:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qiAoo-0005nd-25
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 05:45:26 -0400
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qiAoe-0000xj-7u
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 05:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695030316; x=1726566316;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZnuW1WYEcEDGILKnDibSvGbY0oSLRt/k2KWdG1CgWKo=;
 b=K+YeTPpeQtgG489rE67U3iPMmLTXMBoGeg7+ZfvbWVzdxSa8d4yMaymb
 m+eSFM1IjYiZSpwwxGRcrozz72U9TaAzVoMQpOrVYQ7ciNks1Y4fYwcWY
 IRB8KOjcKpo1+L8yZWIvPqrx1AHbjXdwYNiVGBRDSsCSPaYGDuySgHwNM
 jS/flOMu+vEg4hibv48th3KirVBSrN4gNLcjwzJkFn1Fm6xNz1tJEFkqb
 3+Msfcpq5/496yytxUTNxB871+nSkQAw0YtdU/gJahyvBQl57yC5uGLnY
 FW506LUdqok5XEHAtb3TxQirtei+LsTsIw4FSl22OMemUNg6umBdY9MPR g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="446072269"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; d="scan'208";a="446072269"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2023 02:45:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="835955945"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; d="scan'208";a="835955945"
Received: from vmmteam.bj.intel.com ([10.240.193.84])
 by FMSMGA003.fm.intel.com with ESMTP; 18 Sep 2023 02:45:11 -0700
From: Jing Liu <jing2.liu@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, pbonzini@redhat.com,
 kevin.tian@intel.com, reinette.chatre@intel.com, jing2.liu@intel.com,
 jing2.liu@linux.intel.com
Subject: [PATCH v2 1/4] vfio/pci: detect the support of dynamic MSI-X
 allocation
Date: Mon, 18 Sep 2023 05:45:04 -0400
Message-Id: <20230918094507.409050-2-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230918094507.409050-1-jing2.liu@intel.com>
References: <20230918094507.409050-1-jing2.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100; envelope-from=jing2.liu@intel.com;
 helo=mgamail.intel.com
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

Kernel provides the guidance of dynamic MSI-X allocation support of
passthrough device, by clearing the VFIO_IRQ_INFO_NORESIZE flag to
guide user space.

Fetch the flags from host to determine if dynamic MSI-X allocation is
supported.

Originally-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
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
index a205c6b1130f..60654ca28ab8 100644
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
index a2771b9ff3cc..0717574d79e9 100644
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
index 81ec7c7a958b..cc7c21365c92 100644
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


