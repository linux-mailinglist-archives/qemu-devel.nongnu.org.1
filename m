Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A72FAD59CF
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Jun 2025 17:11:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPN2Y-0004U5-U5; Wed, 11 Jun 2025 11:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2P-0004Rb-KZ
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:06:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uPN2M-00075d-SN
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 11:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749654406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+VU1TB5grpCeBAJ9Vl8LSO6PsVx0nbNU2xZlFwjklSA=;
 b=e0olNFrqmdOPfi96Gzsgi27VucuAcFnfxzDarWVskGf74n5ggB+S80nkbcX5W5bd+BHWtC
 LD1k/dXpR31BLVeivIZ8sMIT2yYkklklfjf4G74tD1wcyIeGU45mhqaGjNuClj2K306fuR
 6HRxGfFce1HYXAU932vgNtrhGGSx9PA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-ntgBjuHNMmGo3gaxaT96TA-1; Wed,
 11 Jun 2025 11:06:43 -0400
X-MC-Unique: ntgBjuHNMmGo3gaxaT96TA-1
X-Mimecast-MFC-AGG-ID: ntgBjuHNMmGo3gaxaT96TA_1749654402
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C36B919560BA; Wed, 11 Jun 2025 15:06:42 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.191])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DDC4C180045B; Wed, 11 Jun 2025 15:06:40 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 John Levon <john.levon@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 07/27] vfio: export PCI helpers needed for vfio-user
Date: Wed, 11 Jun 2025 17:05:59 +0200
Message-ID: <20250611150620.701903-8-clg@redhat.com>
In-Reply-To: <20250611150620.701903-1-clg@redhat.com>
References: <20250611150620.701903-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: John Levon <john.levon@nutanix.com>

The vfio-user code will need to re-use various parts of the vfio PCI
code. Export them in hw/vfio/pci.h, and rename them to the vfio_pci_*
namespace.

Signed-off-by: John Levon <john.levon@nutanix.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250607001056.335310-2-john.levon@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h        | 11 ++++++++++
 hw/vfio/pci.c        | 48 ++++++++++++++++++++++----------------------
 hw/vfio/trace-events |  6 +++---
 3 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 5ce0fb916f3896a448b59fc0b99e892c11c3a9e1..d4c6b2e7b77f26e44f902e6b840d7e39d39de3e9 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -248,4 +248,15 @@ void vfio_display_finalize(VFIOPCIDevice *vdev);
 
 extern const VMStateDescription vfio_display_vmstate;
 
+void vfio_pci_bars_exit(VFIOPCIDevice *vdev);
+bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp);
+bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp);
+bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp);
+void vfio_pci_intx_eoi(VFIODevice *vbasedev);
+void vfio_pci_put_device(VFIOPCIDevice *vdev);
+bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp);
+void vfio_pci_register_err_notifier(VFIOPCIDevice *vdev);
+void vfio_pci_register_req_notifier(VFIOPCIDevice *vdev);
+void vfio_pci_teardown_msi(VFIOPCIDevice *vdev);
+
 #endif /* HW_VFIO_VFIO_PCI_H */
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6748f4e876942f89138f9d8fedfb99dab95b865e..2901cedf6f3e4e1283cb59a1ff6c8ddb99a41b56 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -103,7 +103,7 @@ static void vfio_intx_interrupt(void *opaque)
     }
 }
 
-static void vfio_intx_eoi(VFIODevice *vbasedev)
+void vfio_pci_intx_eoi(VFIODevice *vbasedev)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
 
@@ -111,7 +111,7 @@ static void vfio_intx_eoi(VFIODevice *vbasedev)
         return;
     }
 
-    trace_vfio_intx_eoi(vbasedev->name);
+    trace_vfio_pci_intx_eoi(vbasedev->name);
 
     vdev->intx.pending = false;
     pci_irq_deassert(&vdev->pdev);
@@ -236,7 +236,7 @@ static void vfio_intx_update(VFIOPCIDevice *vdev, PCIINTxRoute *route)
     }
 
     /* Re-enable the interrupt in cased we missed an EOI */
-    vfio_intx_eoi(&vdev->vbasedev);
+    vfio_pci_intx_eoi(&vdev->vbasedev);
 }
 
 static void vfio_intx_routing_notifier(PCIDevice *pdev)
@@ -1743,7 +1743,7 @@ static bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
     return true;
 }
 
-static void vfio_teardown_msi(VFIOPCIDevice *vdev)
+void vfio_pci_teardown_msi(VFIOPCIDevice *vdev)
 {
     msi_uninit(&vdev->pdev);
 
@@ -1839,7 +1839,7 @@ static void vfio_bars_register(VFIOPCIDevice *vdev)
     }
 }
 
-static void vfio_bars_exit(VFIOPCIDevice *vdev)
+void vfio_pci_bars_exit(VFIOPCIDevice *vdev)
 {
     int i;
 
@@ -2430,7 +2430,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
     g_free(config);
 }
 
-static bool vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
 
@@ -2706,7 +2706,7 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
 static VFIODeviceOps vfio_pci_ops = {
     .vfio_compute_needs_reset = vfio_pci_compute_needs_reset,
     .vfio_hot_reset_multi = vfio_pci_hot_reset_multi,
-    .vfio_eoi = vfio_intx_eoi,
+    .vfio_eoi = vfio_pci_intx_eoi,
     .vfio_get_object = vfio_pci_get_object,
     .vfio_save_config = vfio_pci_save_config,
     .vfio_load_config = vfio_pci_load_config,
@@ -2777,7 +2777,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
     VFIODevice *vbasedev = &vdev->vbasedev;
     struct vfio_region_info *reg_info = NULL;
@@ -2823,7 +2823,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
         return false;
     }
 
-    trace_vfio_populate_device_config(vdev->vbasedev.name,
+    trace_vfio_pci_populate_device_config(vdev->vbasedev.name,
                                       (unsigned long)reg_info->size,
                                       (unsigned long)reg_info->offset,
                                       (unsigned long)reg_info->flags);
@@ -2845,7 +2845,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
     ret = vfio_device_get_irq_info(vbasedev, VFIO_PCI_ERR_IRQ_INDEX, &irq_info);
     if (ret) {
         /* This can fail for an old kernel or legacy PCI dev */
-        trace_vfio_populate_device_get_irq_info_failure(strerror(-ret));
+        trace_vfio_pci_populate_device_get_irq_info_failure(strerror(-ret));
     } else if (irq_info.count == 1) {
         vdev->pci_aer = true;
     } else {
@@ -2857,7 +2857,7 @@ static bool vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static void vfio_pci_put_device(VFIOPCIDevice *vdev)
+void vfio_pci_put_device(VFIOPCIDevice *vdev)
 {
     vfio_display_finalize(vdev);
     vfio_bars_finalize(vdev);
@@ -2905,7 +2905,7 @@ static void vfio_err_notifier_handler(void *opaque)
  * and continue after disabling error recovery support for the
  * device.
  */
-static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
+void vfio_pci_register_err_notifier(VFIOPCIDevice *vdev)
 {
     Error *err = NULL;
     int32_t fd;
@@ -2964,7 +2964,7 @@ static void vfio_req_notifier_handler(void *opaque)
     }
 }
 
-static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
+void vfio_pci_register_req_notifier(VFIOPCIDevice *vdev)
 {
     struct vfio_irq_info irq_info;
     Error *err = NULL;
@@ -3018,7 +3018,7 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
     vdev->req_enabled = false;
 }
 
-static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
     VFIODevice *vbasedev = &vdev->vbasedev;
@@ -3124,7 +3124,7 @@ static bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
     return true;
 }
 
-static bool vfio_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
+bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
 {
     PCIDevice *pdev = &vdev->pdev;
 
@@ -3214,7 +3214,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
         goto error;
     }
 
-    if (!vfio_populate_device(vdev, errp)) {
+    if (!vfio_pci_populate_device(vdev, errp)) {
         goto error;
     }
 
@@ -3228,7 +3228,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
         goto out_teardown;
     }
 
-    if (!vfio_add_capabilities(vdev, errp)) {
+    if (!vfio_pci_add_capabilities(vdev, errp)) {
         goto out_unset_idev;
     }
 
@@ -3244,7 +3244,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
         vfio_bar_quirk_setup(vdev, i);
     }
 
-    if (!vfio_interrupt_setup(vdev, errp)) {
+    if (!vfio_pci_interrupt_setup(vdev, errp)) {
         goto out_unset_idev;
     }
 
@@ -3288,8 +3288,8 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
         }
     }
 
-    vfio_register_err_notifier(vdev);
-    vfio_register_req_notifier(vdev);
+    vfio_pci_register_err_notifier(vdev);
+    vfio_pci_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
 
     return;
@@ -3310,8 +3310,8 @@ out_unset_idev:
         pci_device_unset_iommu_device(pdev);
     }
 out_teardown:
-    vfio_teardown_msi(vdev);
-    vfio_bars_exit(vdev);
+    vfio_pci_teardown_msi(vdev);
+    vfio_pci_bars_exit(vdev);
 error:
     error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
 }
@@ -3338,9 +3338,9 @@ static void vfio_exitfn(PCIDevice *pdev)
     if (vdev->intx.mmap_timer) {
         timer_free(vdev->intx.mmap_timer);
     }
-    vfio_teardown_msi(vdev);
+    vfio_pci_teardown_msi(vdev);
     vfio_pci_disable_rp_atomics(vdev);
-    vfio_bars_exit(vdev);
+    vfio_pci_bars_exit(vdev);
     vfio_migration_exit(vbasedev);
     if (!vbasedev->mdev) {
         pci_device_unset_iommu_device(pdev);
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index e90ec9bff8d5fa51afde7b55fb736a8d51fef1b0..f06236f37b72cc64868456be3a5a58fdb5beb829 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -2,7 +2,7 @@
 
 # pci.c
 vfio_intx_interrupt(const char *name, char line) " (%s) Pin %c"
-vfio_intx_eoi(const char *name) " (%s) EOI"
+vfio_pci_intx_eoi(const char *name) " (%s) EOI"
 vfio_intx_enable_kvm(const char *name) " (%s) KVM INTx accel enabled"
 vfio_intx_disable_kvm(const char *name) " (%s) KVM INTx accel disabled"
 vfio_intx_update(const char *name, int new_irq, int target_irq) " (%s) IRQ moved %d -> %d"
@@ -35,8 +35,8 @@ vfio_pci_hot_reset(const char *name, const char *type) " (%s) %s"
 vfio_pci_hot_reset_has_dep_devices(const char *name) "%s: hot reset dependent devices:"
 vfio_pci_hot_reset_dep_devices(int domain, int bus, int slot, int function, int group_id) "\t%04x:%02x:%02x.%x group %d"
 vfio_pci_hot_reset_result(const char *name, const char *result) "%s hot reset: %s"
-vfio_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device '%s' config: size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
-vfio_populate_device_get_irq_info_failure(const char *errstr) "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
+vfio_pci_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device '%s' config: size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
+vfio_pci_populate_device_get_irq_info_failure(const char *errstr) "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
 vfio_mdev(const char *name, bool is_mdev) " (%s) is_mdev %d"
 vfio_add_ext_cap_dropped(const char *name, uint16_t cap, uint16_t offset) "%s 0x%x@0x%x"
 vfio_pci_reset(const char *name) " (%s)"
-- 
2.49.0


