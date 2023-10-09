Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 588537BD3C8
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 08:50:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpk53-0006S3-2R; Mon, 09 Oct 2023 02:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=qD0P=FX=redhat.com=clg@ozlabs.org>)
 id 1qpk50-0006Rt-SV
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:49:26 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=qD0P=FX=redhat.com=clg@ozlabs.org>)
 id 1qpk4y-0007Hi-LX
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:49:26 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S3qQB4cC4z4xWl;
 Mon,  9 Oct 2023 17:49:22 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S3qQ90p3Hz4xWP;
 Mon,  9 Oct 2023 17:49:20 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Jing Liu <jing2.liu@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 5/6] vfio/pci: use an invalid fd to enable MSI-X
Date: Mon,  9 Oct 2023 08:48:59 +0200
Message-ID: <20231009064900.1465361-6-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009064900.1465361-1-clg@redhat.com>
References: <20231009064900.1465361-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=qD0P=FX=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 44 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index eb7627c5f9fcd67f346595ebe73011cc3205b58e..ad508abd6f382d518871191017859c4c4c8fd4f9 100644
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
2.41.0


