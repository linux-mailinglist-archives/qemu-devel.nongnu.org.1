Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1AB783AE3
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:30:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLqA-0005bs-6x; Tue, 22 Aug 2023 03:30:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qYLpw-0005av-AL
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:30:00 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qYLpt-0006XO-EH
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692689397; x=1724225397;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8iAnTg/4sqWStxyxOqja9WHMf+YUwpcUVO/YKALjC4I=;
 b=eHKRmZoaePB6PLSim2VuZmzmVVgQfz02Gw0PdQaxk1uSKdx9nY9sFr5E
 gw0U/maqp2D+5aRFdk8mSKqFs4eG0O1Iv4YYxD/Ct+AgWcJuG96DsND1l
 Dw6pj0IMZXnn/qgY5f/XNbVmXhlsiHPx5HDtLGXL8z4EnOYtj+6/MKqFr
 MA5xMeC0lqFBjVQ3+ZO74iX8uly8UJ53b5Pc84iUGKq++NXJKcDukh5rN
 y5zr+3CVYvccQoTgdJvMeajij0aK0igREBqiT5zBAscPdxFRY6Iv+QIjU
 zC0b0rEKjU2iTgjj1O38xyqKq0UOKytQsJ8hHreBN/EW/grBlwOko941N w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="437721817"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; d="scan'208";a="437721817"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2023 00:29:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="850502098"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; d="scan'208";a="850502098"
Received: from vmmteam.bj.intel.com ([10.240.192.110])
 by fmsmga002.fm.intel.com with ESMTP; 22 Aug 2023 00:29:43 -0700
From: Jing Liu <jing2.liu@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, pbonzini@redhat.com,
 kevin.tian@intel.com, reinette.chatre@intel.com, jing2.liu@intel.com,
 jing2.liu@linux.intel.com
Subject: [PATCH v1 3/4] vfio/pci: use an invalid fd to enable MSI-X
Date: Tue, 22 Aug 2023 03:29:26 -0400
Message-Id: <20230822072927.224803-4-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230822072927.224803-1-jing2.liu@intel.com>
References: <20230822072927.224803-1-jing2.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.31; envelope-from=jing2.liu@intel.com;
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
vector table. To match the guest state of device, Qemu enables MSI-X by
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
Changes since RFC v1:
- A new patch. Use an invalid fd to get MSI-X enabled instead of using
  userspace triggering. (Alex)
---
 hw/vfio/pci.c | 50 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 31f36d68bb19..e24c21241a0c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -369,6 +369,39 @@ static void vfio_msi_interrupt(void *opaque)
     notify(&vdev->pdev, nr);
 }
 
+/*
+ * Get MSI-X enabled, but no vector enabled, by setting vector 0 with an invalid
+ * fd to kernel.
+ */
+static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
+{
+    struct vfio_irq_set *irq_set;
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
+    if (ret) {
+        error_report("vfio: failed to enable MSI-X with vector 0 trick, %d",
+                     ret);
+    }
+
+    g_free(irq_set);
+
+    return ret;
+}
+
 static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
 {
     struct vfio_irq_set *irq_set;
@@ -618,6 +651,8 @@ static void vfio_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
 
 static void vfio_msix_enable(VFIOPCIDevice *vdev)
 {
+    int ret;
+
     vfio_disable_interrupts(vdev);
 
     vdev->msi_vectors = g_new0(VFIOMSIVector, vdev->msix->entries);
@@ -640,8 +675,6 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
     vfio_commit_kvm_msi_virq_batch(vdev);
 
     if (vdev->nr_vectors) {
-        int ret;
-
         ret = vfio_enable_vectors(vdev, true);
         if (ret) {
             error_report("vfio: failed to enable vectors, %d", ret);
@@ -655,13 +688,14 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
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


