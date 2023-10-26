Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A147D7D6A
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 09:11:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvuWJ-0007YC-FB; Thu, 26 Oct 2023 03:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=sG9D=GI=redhat.com=clg@ozlabs.org>)
 id 1qvuWG-0007Xd-OT
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 03:11:04 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=sG9D=GI=redhat.com=clg@ozlabs.org>)
 id 1qvuWA-00020R-TU
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 03:11:04 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SGH5857M6z4x23;
 Thu, 26 Oct 2023 18:10:52 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGH572xMWz4wcX;
 Thu, 26 Oct 2023 18:10:51 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] vfio/pci: Check return value of vfio_set_irq_signaling()
Date: Thu, 26 Oct 2023 09:10:43 +0200
Message-ID: <20231026071043.1165994-1-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=sG9D=GI=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

and drop warning when ENOTTY is returned. Only useful for the mdev-mtty
driver today, which has partial support for INTx: the AUTOMASK
behavior is not implemented.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 46 ++++++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index b27011cee72a0fb3b2d57d297c0b5c2ccff9d9a6..5cbc771e55d83561011785e54a38dea042fc834c 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -114,15 +114,16 @@ static void vfio_intx_eoi(VFIODevice *vbasedev)
     vfio_unmask_single_irqindex(vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
 }
 
-static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
+static int vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
 {
+    int ret = 0;
 #ifdef CONFIG_KVM
     int irq_fd = event_notifier_get_fd(&vdev->intx.interrupt);
 
     if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
         vdev->intx.route.mode != PCI_INTX_ENABLED ||
         !kvm_resamplefds_enabled()) {
-        return;
+        return 0;
     }
 
     /* Get to a known interrupt state */
@@ -132,23 +133,26 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
     pci_irq_deassert(&vdev->pdev);
 
     /* Get an eventfd for resample/unmask */
-    if (event_notifier_init(&vdev->intx.unmask, 0)) {
+    ret = event_notifier_init(&vdev->intx.unmask, 0);
+    if (ret) {
         error_setg(errp, "event_notifier_init failed eoi");
         goto fail;
     }
 
-    if (kvm_irqchip_add_irqfd_notifier_gsi(kvm_state,
-                                           &vdev->intx.interrupt,
-                                           &vdev->intx.unmask,
-                                           vdev->intx.route.irq)) {
+    ret = kvm_irqchip_add_irqfd_notifier_gsi(kvm_state,
+                                             &vdev->intx.interrupt,
+                                             &vdev->intx.unmask,
+                                             vdev->intx.route.irq);
+    if (ret) {
         error_setg_errno(errp, errno, "failed to setup resample irqfd");
         goto fail_irqfd;
     }
 
-    if (vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
-                               VFIO_IRQ_SET_ACTION_UNMASK,
-                               event_notifier_get_fd(&vdev->intx.unmask),
-                               errp)) {
+    ret = vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX, 0,
+                                 VFIO_IRQ_SET_ACTION_UNMASK,
+                                 event_notifier_get_fd(&vdev->intx.unmask),
+                                 errp);
+    if (ret) {
         goto fail_vfio;
     }
 
@@ -159,7 +163,7 @@ static void vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
 
     trace_vfio_intx_enable_kvm(vdev->vbasedev.name);
 
-    return;
+    return 0;
 
 fail_vfio:
     kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &vdev->intx.interrupt,
@@ -170,6 +174,7 @@ fail:
     qemu_set_fd_handler(irq_fd, vfio_intx_interrupt, NULL, vdev);
     vfio_unmask_single_irqindex(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
 #endif
+    return ret;
 }
 
 static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
@@ -212,6 +217,7 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
 static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
 {
     Error *err = NULL;
+    int ret;
 
     trace_vfio_intx_update(vdev->vbasedev.name,
                            vdev->intx.route.irq, route->irq);
@@ -224,9 +230,13 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
         return;
     }
 
-    vfio_intx_enable_kvm(vdev, &err);
+    ret = vfio_intx_enable_kvm(vdev, &err);
     if (err) {
-        warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+        if (ret != -ENOTTY) {
+            warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+        } else {
+            error_free(err);
+        }
     }
 
     /* Re-enable the interrupt in cased we missed an EOI */
@@ -300,9 +310,13 @@ static int vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
         return -errno;
     }
 
-    vfio_intx_enable_kvm(vdev, &err);
+    ret = vfio_intx_enable_kvm(vdev, &err);
     if (err) {
-        warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+        if (ret != -ENOTTY) {
+            warn_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
+        } else {
+            error_free(err);
+        }
     }
 
     vdev->interrupt = VFIO_INT_INTx;
-- 
2.41.0


