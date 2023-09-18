Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 124DF7A4650
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 11:46:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiAou-0005os-BV; Mon, 18 Sep 2023 05:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qiAor-0005oH-AM
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 05:45:29 -0400
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qiAop-0000xj-Gj
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 05:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695030327; x=1726566327;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=K9qjTjP69wy9/oxYf5DYvTpAECxOt0osGbsO6aI872Y=;
 b=ITf4tbG5X115TDrDbWrvBCfX5X8OPSfpms3DQ1NaPd0QADOBYkUay8bJ
 5zYVAuNT4yAIM8Tv/pH39nTD9CGPAB6a+wjd12oAx6IVqMtiHkRv1ngH6
 90uvnwe0z6ZBobqCmTh5NnrEPvL1DLOAEkHKGc+HjpkEwxjd+QrAoUJO5
 IWySfSLdfpJAC3SIW8Wv5AESNkaxvg97K1QfAlbZe8EedBkYe2E3zUJMP
 nd1CmRqtOPzaI6Z+kyys92eOJya8+eETrytDXwxO1EgxRLxDFlnuwueNG
 B8VKgtP7u9HvJPSpSJW9ar7BmqjMal7Wn2fs9fgZ0gFysZ1x1NFNelZCz Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="446072279"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; d="scan'208";a="446072279"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2023 02:45:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="835955956"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; d="scan'208";a="835955956"
Received: from vmmteam.bj.intel.com ([10.240.193.84])
 by FMSMGA003.fm.intel.com with ESMTP; 18 Sep 2023 02:45:16 -0700
From: Jing Liu <jing2.liu@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, pbonzini@redhat.com,
 kevin.tian@intel.com, reinette.chatre@intel.com, jing2.liu@intel.com,
 jing2.liu@linux.intel.com
Subject: [PATCH v2 3/4] vfio/pci: use an invalid fd to enable MSI-X
Date: Mon, 18 Sep 2023 05:45:06 -0400
Message-Id: <20230918094507.409050-4-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230918094507.409050-1-jing2.liu@intel.com>
References: <20230918094507.409050-1-jing2.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100; envelope-from=jing2.liu@intel.com;
 helo=mgamail.intel.com
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

Guests typically enable MSI-X with all of the vectors masked in the MSI-X
vector table. To match the guest state of device, QEMU enables MSI-X by
enabling vector 0 with userspace triggering and immediately release.
However the release function actually does not release it due to already
using userspace mode.

It is no need to enable triggering on host and rely on the mask bit to
avoid spurious interrupts. Use an invalid fd (i.e. fd = -1) is enough
to get MSI-X enabled.

After dynamic MSI-X allocation is supported, the interrupt restoring
also need use such way to enable MSI-X, therefore, create a function
for that.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Jing Liu <jing2.liu@intel.com>
---
Changes since v1:
- Revise Qemu to QEMU. (Cédric)
- Use g_autofree to automatically release. (Cédric)
- Just return 'ret' and let the caller of vfio_enable_msix_no_vec()
  report the error. (Cédric)

Changes since RFC v1:
- A new patch. Use an invalid fd to get MSI-X enabled instead of using
  userspace triggering. (Alex)
---
 hw/vfio/pci.c | 44 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 84987e46fd7a..0117f230e934 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -369,6 +369,33 @@ static void vfio_msi_interrupt(void *opaque)
     notify(&vdev->pdev, nr);
 }
 
+/*
+ * Get MSI-X enabled, but no vector enabled, by setting vector 0 with an invalid
+ * fd to kernel.
+ */
+static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
+{
+    g_autofree struct vfio_irq_set *irq_set = NULL;
+    int ret = 0, argsz;
+    int32_t *fd;
+
+    argsz = sizeof(*irq_set) + sizeof(*fd);
+
+    irq_set = g_malloc0(argsz);
+    irq_set->argsz = argsz;
+    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD |
+                     VFIO_IRQ_SET_ACTION_TRIGGER;
+    irq_set->index = VFIO_PCI_MSIX_IRQ_INDEX;
+    irq_set->start = 0;
+    irq_set->count = 1;
+    fd = (int32_t *)&irq_set->data;
+    *fd = -1;
+
+    ret = ioctl(vdev->vbasedev.fd, VFIO_DEVICE_SET_IRQS, irq_set);
+
+    return ret;
+}
+
 static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
 {
     struct vfio_irq_set *irq_set;
@@ -618,6 +645,8 @@ static void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
 
 static void vfio_msix_enable(VFIOPCIDevice *vdev)
 {
+    int ret;
+
     vfio_disable_interrupts(vdev);
 
     vdev->msi_vectors = g_new0(VFIOMSIVector, vdev->msix->entries);
@@ -640,8 +669,6 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
     vfio_commit_kvm_msi_virq_batch(vdev);
 
     if (vdev->nr_vectors) {
-        int ret;
-
         ret = vfio_enable_vectors(vdev, true);
         if (ret) {
             error_report("vfio: failed to enable vectors, %d", ret);
@@ -655,13 +682,14 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
          * MSI-X capability, but leaves the vector table masked.  We therefore
          * can't rely on a vector_use callback (from request_irq() in the guest)
          * to switch the physical device into MSI-X mode because that may come a
-         * long time after pci_enable_msix().  This code enables vector 0 with
-         * triggering to userspace, then immediately release the vector, leaving
-         * the physical device with no vectors enabled, but MSI-X enabled, just
-         * like the guest view.
+         * long time after pci_enable_msix().  This code sets vector 0 with an
+         * invalid fd to make the physical device MSI-X enabled, but with no
+         * vectors enabled, just like the guest view.
          */
-        vfio_msix_vector_do_use(&vdev->pdev, 0, NULL, NULL);
-        vfio_msix_vector_release(&vdev->pdev, 0);
+        ret = vfio_enable_msix_no_vec(vdev);
+        if (ret) {
+            error_report("vfio: failed to enable MSI-X, %d", ret);
+        }
     }
 
     trace_vfio_msix_enable(vdev->vbasedev.name);
-- 
2.27.0


