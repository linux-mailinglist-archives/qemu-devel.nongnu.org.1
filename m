Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CCD7BB17A
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 08:22:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoeCN-00057B-DZ; Fri, 06 Oct 2023 02:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=cI0A=FU=redhat.com=clg@ozlabs.org>)
 id 1qoeCJ-00056H-Ot
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 02:20:29 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=cI0A=FU=redhat.com=clg@ozlabs.org>)
 id 1qoeCF-0002hU-C9
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 02:20:27 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S1yw375dKz4xQT;
 Fri,  6 Oct 2023 17:20:19 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S1yw21Bgrz4xQM;
 Fri,  6 Oct 2023 17:20:17 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Jing Liu <jing2.liu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/21] vfio/pci: enable vector on dynamic MSI-X allocation
Date: Fri,  6 Oct 2023 08:19:48 +0200
Message-ID: <20231006062005.1040296-5-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006062005.1040296-1-clg@redhat.com>
References: <20231006062005.1040296-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=cI0A=FU=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 46 ++++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 86c92c51a46e2d1e9856c3cbcd7c47548daab422..eb7627c5f9fcd67f346595ebe73011cc3205b58e 100644
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
2.41.0


