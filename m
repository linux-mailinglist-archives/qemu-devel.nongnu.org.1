Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 073FD7AE397
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 04:15:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkxal-0004ev-9u; Mon, 25 Sep 2023 22:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qkxai-0004e3-A9
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 22:14:24 -0400
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qkxag-0002dW-LH
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 22:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695694462; x=1727230462;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=H6jSarW2lCotbNiDl5NvQoomn5YR3Bbd4nBXLPh3NX8=;
 b=KJfl7lYFpri4AlSU2EDt5E9s8rku81x1B5UpSgYJ8FGc0wX5m0vrTU0o
 4bjTVyjMtBMqUlsb3QIT1AlgCxsdN4gLhiL3MY3oxYTMfGDMFzokm8N1X
 8yzXPDixqjl6LAYILUKqVmH+LoEINu9nbzYhTx8EC5kfuCLEXu6WFfs2Z
 dRIT3Y0MXfwNjkE2gYWTMXTlqkDMEdhjHfTl6f+C8KqbAqqeRwwjiPR6e
 aT+y3UKM4/lS7oQEdQBM7gVKkYZZsYvH7ZuERYBz0WXPmbUCUjxXyupuA
 fcChHVaMnmDbWlyzd74e8U0DPFrik5Y0ugyVrTMrfsgSCxXDDOTVttlg4 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412380127"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; d="scan'208";a="412380127"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2023 19:14:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="698283018"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; d="scan'208";a="698283018"
Received: from vmmteam.bj.intel.com ([10.240.193.84])
 by orsmga003.jf.intel.com with ESMTP; 25 Sep 2023 19:14:17 -0700
From: Jing Liu <jing2.liu@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, pbonzini@redhat.com,
 kevin.tian@intel.com, reinette.chatre@intel.com, jing2.liu@intel.com,
 jing2.liu@linux.intel.com
Subject: [PATCH v3 2/4] vfio/pci: enable vector on dynamic MSI-X allocation
Date: Mon, 25 Sep 2023 22:14:05 -0400
Message-Id: <20230926021407.580305-3-jing2.liu@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20230926021407.580305-1-jing2.liu@intel.com>
References: <20230926021407.580305-1-jing2.liu@intel.com>
MIME-Version: 1.0
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

The vector_use callback is used to enable vector that is unmasked in
guest. The kernel used to only support static MSI-X allocation. When
allocating a new interrupt using "static MSI-X allocation" kernels,
QEMU first disables all previously allocated vectors and then
re-allocates all including the new one. The nr_vectors of VFIOPCIDevice
indicates that all vectors from 0 to nr_vectors are allocated (and may
be enabled), which is used to loop all the possibly used vectors when
e.g., disabling MSI-X interrupts.

Extend the vector_use function to support dynamic MSI-X allocation when
host supports the capability. QEMU therefore can individually allocate
and enable a new interrupt without affecting others or causing interrupts
lost during runtime.

Utilize nr_vectors to calculate the upper bound of enabled vectors in
dynamic MSI-X allocation mode since looping all msix_entries_nr is not
efficient and unnecessary.

Signed-off-by: Jing Liu <jing2.liu@intel.com>
Tested-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
---
Changes since v2:
- Use a bool type to test (vdev->nr_vectors < nr + 1). (Alex)
- Revise the comments. (Alex)
- Apply Alex's Reviewed-by.

Changes since v1:
- Revise Qemu to QEMU.

Changes since RFC v1:
- Test vdev->msix->noresize to identify the allocation mode. (Alex)
- Move defer_kvm_irq_routing test out and update nr_vectors in a
  common place before vfio_enable_vectors(). (Alex)
- Revise the comments. (Alex)
---
 hw/vfio/pci.c | 46 ++++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a94eef50e41e..27a65302ea69 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -470,6 +470,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
     VFIOMSIVector *vector;
     int ret;
+    bool resizing = !!(vdev->nr_vectors < nr + 1);
 
     trace_vfio_msix_vector_do_use(vdev->vbasedev.name, nr);
 
@@ -512,33 +513,42 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
     }
 
     /*
-     * We don't want to have the host allocate all possible MSI vectors
-     * for a device if they're not in use, so we shutdown and incrementally
-     * increase them as needed.
+     * When dynamic allocation is not supported, we don't want to have the
+     * host allocate all possible MSI vectors for a device if they're not
+     * in use, so we shutdown and incrementally increase them as needed.
+     * nr_vectors represents the total number of vectors allocated.
+     *
+     * When dynamic allocation is supported, let the host only allocate
+     * and enable a vector when it is in use in guest. nr_vectors represents
+     * the upper bound of vectors being enabled (but not all of the ranges
+     * is allocated or enabled).
      */
-    if (vdev->nr_vectors < nr + 1) {
+    if (resizing) {
         vdev->nr_vectors = nr + 1;
-        if (!vdev->defer_kvm_irq_routing) {
+    }
+
+    if (!vdev->defer_kvm_irq_routing) {
+        if (vdev->msix->noresize && resizing) {
             vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
             ret = vfio_enable_vectors(vdev, true);
             if (ret) {
                 error_report("vfio: failed to enable vectors, %d", ret);
             }
-        }
-    } else {
-        Error *err = NULL;
-        int32_t fd;
-
-        if (vector->virq >= 0) {
-            fd = event_notifier_get_fd(&vector->kvm_interrupt);
         } else {
-            fd = event_notifier_get_fd(&vector->interrupt);
-        }
+            Error *err = NULL;
+            int32_t fd;
 
-        if (vfio_set_irq_signaling(&vdev->vbasedev,
-                                     VFIO_PCI_MSIX_IRQ_INDEX, nr,
-                                     VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
-            error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+            if (vector->virq >= 0) {
+                fd = event_notifier_get_fd(&vector->kvm_interrupt);
+            } else {
+                fd = event_notifier_get_fd(&vector->interrupt);
+            }
+
+            if (vfio_set_irq_signaling(&vdev->vbasedev,
+                                       VFIO_PCI_MSIX_IRQ_INDEX, nr,
+                                       VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
+                error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+            }
         }
     }
 
-- 
2.27.0


