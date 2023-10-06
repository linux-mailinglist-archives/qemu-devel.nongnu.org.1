Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 492877BB173
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 08:21:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoeCP-00059P-I1; Fri, 06 Oct 2023 02:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=cI0A=FU=redhat.com=clg@ozlabs.org>)
 id 1qoeCK-00056M-AV
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 02:20:29 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=cI0A=FU=redhat.com=clg@ozlabs.org>)
 id 1qoeCF-0002gc-C6
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 02:20:28 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S1yw14hDMz4xQ3;
 Fri,  6 Oct 2023 17:20:17 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S1yvz5qLKz4xGP;
 Fri,  6 Oct 2023 17:20:15 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Jing Liu <jing2.liu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/21] vfio/pci: detect the support of dynamic MSI-X allocation
Date: Fri,  6 Oct 2023 08:19:47 +0200
Message-ID: <20231006062005.1040296-4-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006062005.1040296-1-clg@redhat.com>
References: <20231006062005.1040296-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=cI0A=FU=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jing Liu <jing2.liu@intel.com>

Kernel provides the guidance of dynamic MSI-X allocation support of
passthrough device, by clearing the VFIO_IRQ_INFO_NORESIZE flag to
guide user space.

Fetch the flags from host to determine if dynamic MSI-X allocation is
supported.

Originally-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h        |  1 +
 hw/vfio/pci.c        | 16 ++++++++++++++--
 hw/vfio/trace-events |  2 +-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 2d836093a83d3df5f94dc8981ee6c61cfb6d3373..0d89eb761ece426ca1df40f63461b2bb1bcf1ab0 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -113,6 +113,7 @@ typedef struct VFIOMSIXInfo {
     uint32_t table_offset;
     uint32_t pba_offset;
     unsigned long *pending;
+    bool noresize;
 } VFIOMSIXInfo;
 
 #define TYPE_VFIO_PCI "vfio-pci"
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b2d5010b9f0effbe85a3f57b43e282e837b6383f..86c92c51a46e2d1e9856c3cbcd7c47548daab422 100644
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
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index e64ca4a01961b34dc4b9b7d78917f1d8847d887d..0ba3c5a0e26bc82f40a0d7737e68128d2c9334fe 100644
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
2.41.0


