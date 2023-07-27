Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA13B765563
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 15:55:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP1H6-00061j-94; Thu, 27 Jul 2023 09:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qOvVv-0005f9-7C
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:34:23 -0400
Received: from [192.55.52.136] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qOvVt-0004N7-GO
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690443261; x=1721979261;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WABoFA/wWazeez7zhBvvVv7o7DbqHVzXK2WHrjvGk54=;
 b=mqeCJvk3fU0Rlz0yfHpMRYTsF8sDNpxB+dBu04r5c0GhenSYvYDjsXxw
 y4z2Kj9EizYWcF8VZ9bpMBfwL9QJd4mrukdJtBbcbn8XKn7MuEPiOE3hj
 CKP6Ug+dZVH6vTAMSddVBx/HlAn5kuIyHfZhq4ihqDADI872p9qzNVoXt
 Iqx1I8ph/gEQyTDnreCj/1afBL+vS6iCEejhHyvHbJb8DxkRxcaQtDo8t
 T2p99loWjbEycfKy33HUCpn3DJPTfJUpomJaa+tQn1mrHCCZ79myH6sRt
 fuqgJuesctc0XvKFM44A0pA/I10GAgXZ5yNqBgZtKTL1r9KFv4nN+9M8N g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="347842868"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; d="scan'208";a="347842868"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2023 00:24:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="756547369"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; d="scan'208";a="756547369"
Received: from vmmteam.bj.intel.com ([10.240.192.110])
 by orsmga008.jf.intel.com with ESMTP; 27 Jul 2023 00:24:15 -0700
From: Jing Liu <jing2.liu@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, pbonzini@redhat.com,
 kevin.tian@intel.com, reinette.chatre@intel.com, jing2.liu@intel.com
Subject: [PATCH RFC v1 1/3] vfio/pci: detect the support of dynamic MSI-X
 allocation
Date: Thu, 27 Jul 2023 03:24:08 -0400
Message-Id: <20230727072410.135743-2-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230727072410.135743-1-jing2.liu@intel.com>
References: <20230727072410.135743-1-jing2.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 192.55.52.136 (failed)
Received-SPF: pass client-ip=192.55.52.136; envelope-from=jing2.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 27 Jul 2023 09:43:26 -0400
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

From: Reinette Chatre <reinette.chatre@intel.com>

Kernel provides the guidance of dynamic MSI-X allocation support of
passthrough device, by clearing the VFIO_IRQ_INFO_NORESIZE flag to
guide user space.

Fetch and store the flags from host for later use to determine if
specific flags are set.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
---
 hw/vfio/pci.c        | 12 ++++++++++++
 hw/vfio/pci.h        |  1 +
 hw/vfio/trace-events |  2 ++
 3 files changed, 15 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a205c6b1130f..0c4ac0873d40 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1572,6 +1572,7 @@ static void vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
 
 static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
 {
+    struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
     int ret;
     Error *err = NULL;
 
@@ -1624,6 +1625,17 @@ static int vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
         memory_region_set_enabled(&vdev->pdev.msix_table_mmio, false);
     }
 
+    irq_info.index = VFIO_PCI_MSIX_IRQ_INDEX;
+    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_GET_IRQ_INFO, &irq_info);
+    if (ret) {
+        /* This can fail for an old kernel or legacy PCI dev */
+        trace_vfio_msix_setup_get_irq_info_failure(strerror(errno));
+    } else {
+        vdev->msix->irq_info_flags = irq_info.flags;
+    }
+    trace_vfio_msix_setup_irq_info_flags(vdev->vbasedev.name,
+                                         vdev->msix->irq_info_flags);
+
     return 0;
 }
 
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index a2771b9ff3cc..ad34ec56d0ae 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -113,6 +113,7 @@ typedef struct VFIOMSIXInfo {
     uint32_t table_offset;
     uint32_t pba_offset;
     unsigned long *pending;
+    uint32_t irq_info_flags;
 } VFIOMSIXInfo;
 
 #define TYPE_VFIO_PCI "vfio-pci"
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index ee7509e68e4f..7d4a398f044d 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -28,6 +28,8 @@ vfio_pci_read_config(const char *name, int addr, int len, int val) " (%s, @0x%x,
 vfio_pci_write_config(const char *name, int addr, int val, int len) " (%s, @0x%x, 0x%x, len=0x%x)"
 vfio_msi_setup(const char *name, int pos) "%s PCI MSI CAP @0x%x"
 vfio_msix_early_setup(const char *name, int pos, int table_bar, int offset, int entries) "%s PCI MSI-X CAP @0x%x, BAR %d, offset 0x%x, entries %d"
+vfio_msix_setup_get_irq_info_failure(const char *errstr) "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
+vfio_msix_setup_irq_info_flags(const char *name, uint32_t flags) " (%s) MSI-X irq info flags 0x%x"
 vfio_check_pcie_flr(const char *name) "%s Supports FLR via PCIe cap"
 vfio_check_pm_reset(const char *name) "%s Supports PM reset"
 vfio_check_af_flr(const char *name) "%s Supports FLR via AF cap"
-- 
2.27.0


