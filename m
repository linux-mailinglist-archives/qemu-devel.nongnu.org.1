Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2332B783AF1
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:32:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLpv-0005aO-Uz; Tue, 22 Aug 2023 03:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qYLpt-0005ZB-4H
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:29:57 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qYLpq-0006XO-Bj
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1692689394; x=1724225394;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PVRuLt02WMM11u89aqiq5phWxZsW3LYwM6qdkVNQNnU=;
 b=cCA77phkewA3H/gB+xfbsQLZdPGdNNIRQhgDlNfMO5qj8aWuW/6wg+bf
 Q6Df/yGCQT8DQRD+Hvk1yryxiDachx3qvpNO6tS+1+S/0yi8QTifIBhY1
 q2kMDGIwCfbAYarTuLNDsGaxoUbeiVK46Mo+xyhicVDR2sEK4w+o4wuNY
 EcRJW87PC04P3uyraGWrd8DcX0xnkNyxt9rhd6AElZE/K/TBb9aevfdQF
 dK/6nPMUNhXdzGF+8foazE3ZtEsLAC+u8/3+e5SY7sD0q/BiBzQ0yljCA
 cvh9xVgA1/emBlNDtlPNwmfLdkNt2FZXWzLW9GXqv9K169lGHwNjoFGXX Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="437721789"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; d="scan'208";a="437721789"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Aug 2023 00:29:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="850502042"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; d="scan'208";a="850502042"
Received: from vmmteam.bj.intel.com ([10.240.192.110])
 by fmsmga002.fm.intel.com with ESMTP; 22 Aug 2023 00:29:40 -0700
From: Jing Liu <jing2.liu@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, pbonzini@redhat.com,
 kevin.tian@intel.com, reinette.chatre@intel.com, jing2.liu@intel.com,
 jing2.liu@linux.intel.com
Subject: [PATCH v1 2/4] vfio/pci: enable vector on dynamic MSI-X allocation
Date: Tue, 22 Aug 2023 03:29:25 -0400
Message-Id: <20230822072927.224803-3-jing2.liu@intel.com>
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
Changes since RFC v1:
- Test vdev->msix->noresize to identify the allocation mode. (Alex)
- Move defer_kvm_irq_routing test out and update nr_vectors in a
  common place before vfio_enable_vectors(). (Alex)
- Revise the comments. (Alex)
---
 hw/vfio/pci.c | 44 +++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 8a3b34f3c196..31f36d68bb19 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -470,6 +470,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
     VFIOMSIVector *vector;
     int ret;
+    int old_nr_vecs = vdev->nr_vectors;
 
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
     if (vdev->nr_vectors < nr + 1) {
         vdev->nr_vectors = nr + 1;
-        if (!vdev->defer_kvm_irq_routing) {
+    }
+
+    if (!vdev->defer_kvm_irq_routing) {
+        if (vdev->msix->noresize && (old_nr_vecs < nr + 1)) {
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


