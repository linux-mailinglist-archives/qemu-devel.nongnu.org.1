Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 008D176554F
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 15:47:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP1H6-00062E-RE; Thu, 27 Jul 2023 09:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qOvVt-0005ew-1y
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:34:21 -0400
Received: from [192.55.52.136] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qOvVr-0004N7-CH
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690443259; x=1721979259;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=loxFiijST0IQty0YeY0ldu2O+ixiW/kkhN5LYkEB+U0=;
 b=TKCDCWI7MMVs3rIuqS861z1NIQN6zxmd/1bKz1IFFegSSit63oLihP+H
 wX3utb+wFcjJ05hoXQu5O5BiRtvx9m/U9JHCMNNFDz1kSsB3SOlpH/Gwq
 LHQQfK87PNVSQX0nVm/bgGZG1LnEj5F3As1hYlYWoyX0KK3tUiH8ssYn+
 Wi4yKpRmU61AiMbPqE44C6uxZ7Xv17/odl9F3u1S5LQ+EeleYYBHBfUAW
 gw91O/nnbxjSPMJ/ze9bRlpqOzb5xkA7c5Pxz18gFEmno5WakCoKaruVS
 zLH6U4HtSLRN4B8q0W4Wb+pnS+uJJDSvkbZJPtz8/WMb4h+G6MNgeEDV+ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="347842874"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; d="scan'208";a="347842874"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2023 00:24:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="756547372"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; d="scan'208";a="756547372"
Received: from vmmteam.bj.intel.com ([10.240.192.110])
 by orsmga008.jf.intel.com with ESMTP; 27 Jul 2023 00:24:17 -0700
From: Jing Liu <jing2.liu@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, pbonzini@redhat.com,
 kevin.tian@intel.com, reinette.chatre@intel.com, jing2.liu@intel.com
Subject: [PATCH RFC v1 2/3] vfio/pci: enable vector on dynamic MSI-X allocation
Date: Thu, 27 Jul 2023 03:24:09 -0400
Message-Id: <20230727072410.135743-3-jing2.liu@intel.com>
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

The vector_use callback is used to enable vector that is unmasked in
guest. The kernel used to only support static MSI-X allocation. When
allocating a new interrupt using "static MSI-X allocation" kernels,
Qemu first disables all previously allocated vectors and then
re-allocates all including the new one. The nr_vectors of VFIOPCIDevice
indicates that all vectors from 0 to nr_vectors are allocated (and may
be enabled), which is used to to loop all the possibly used vectors
When, e.g., disabling MSI-X interrupts.

Extend the vector_use function to support dynamic MSI-X allocation when
host supports the capability. Qemu therefore can individually allocate
and enable a new interrupt without affecting others or causing interrupts
lost during runtime.

Utilize nr_vectors to calculate the upper bound of enabled vectors in
dynamic MSI-X allocation mode since looping all msix_entries_nr is not
efficient and unnecessary.

Signed-off-by: Jing Liu <jing2.liu@intel.com>
Tested-by: Reinette Chatre <reinette.chatre@intel.com>
---
 hw/vfio/pci.c | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 0c4ac0873d40..8c485636445c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -512,12 +512,20 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
     }
 
     /*
-     * We don't want to have the host allocate all possible MSI vectors
-     * for a device if they're not in use, so we shutdown and incrementally
-     * increase them as needed.
+     * When dynamic allocation is not supported, we don't want to have the
+     * host allocate all possible MSI vectors for a device if they're not
+     * in use, so we shutdown and incrementally increase them as needed.
+     * And nr_vectors stands for the number of vectors being allocated.
+     *
+     * When dynamic allocation is supported, let the host only allocate
+     * and enable a vector when it is in use in guest. nr_vectors stands
+     * for the upper bound of vectors being enabled (but not all of the
+     * ranges is allocated or enabled).
      */
-    if (vdev->nr_vectors < nr + 1) {
+    if ((vdev->msix->irq_info_flags & VFIO_IRQ_INFO_NORESIZE) &&
+        (vdev->nr_vectors < nr + 1)) {
         vdev->nr_vectors = nr + 1;
+
         if (!vdev->defer_kvm_irq_routing) {
             vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
             ret = vfio_enable_vectors(vdev, true);
@@ -529,16 +537,22 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
         Error *err = NULL;
         int32_t fd;
 
-        if (vector->virq >= 0) {
-            fd = event_notifier_get_fd(&vector->kvm_interrupt);
-        } else {
-            fd = event_notifier_get_fd(&vector->interrupt);
-        }
+        if (!vdev->defer_kvm_irq_routing) {
+            if (vector->virq >= 0) {
+                fd = event_notifier_get_fd(&vector->kvm_interrupt);
+            } else {
+                fd = event_notifier_get_fd(&vector->interrupt);
+            }
 
-        if (vfio_set_irq_signaling(&vdev->vbasedev,
-                                     VFIO_PCI_MSIX_IRQ_INDEX, nr,
-                                     VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
-            error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+            if (vfio_set_irq_signaling(&vdev->vbasedev,
+                                       VFIO_PCI_MSIX_IRQ_INDEX, nr,
+                                       VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
+                error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+            }
+        }
+        /* Increase for dynamic allocation case. */
+        if (vdev->nr_vectors < nr + 1) {
+            vdev->nr_vectors = nr + 1;
         }
     }
 
-- 
2.27.0


