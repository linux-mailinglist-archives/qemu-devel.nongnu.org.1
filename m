Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD76B49677
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Sep 2025 19:04:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvf9K-0007lI-VL; Mon, 08 Sep 2025 12:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf9H-0007hZ-8q
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:55:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf96-0001r3-NJ
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757350508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Unov/+9wCa1CgQRxZUAu5LOV2dzyHa5fZ7go7/hv/VU=;
 b=WR01faMEVBY+izLoQnXFJwCuzhacQ2WtVmCQYVBm52ApiMBX5BFvygmv1/LwXcVh5YQvJZ
 kq5AKqRcGcw4oTaD+HJK4KtM0PslnpOz1+fmWmdzgH+v89VO/vZpS1RBLilrffROGd3U9w
 QMC76c3n5nysyU58/xqnb7FoXK+GCm4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-1Ds6UxzrN-CxxnD8aBDBuw-1; Mon,
 08 Sep 2025 12:55:06 -0400
X-MC-Unique: 1Ds6UxzrN-CxxnD8aBDBuw-1
X-Mimecast-MFC-AGG-ID: 1Ds6UxzrN-CxxnD8aBDBuw_1757350504
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFC4018002C3; Mon,  8 Sep 2025 16:55:04 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3B6DB3000198; Mon,  8 Sep 2025 16:55:02 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 25/31] vfio/pci.c: use QOM casts where appropriate
Date: Mon,  8 Sep 2025 18:53:48 +0200
Message-ID: <20250908165354.1731444-26-clg@redhat.com>
In-Reply-To: <20250908165354.1731444-1-clg@redhat.com>
References: <20250908165354.1731444-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Use QOM casts to convert between VFIOPCIDevice and PCIDevice instead of
accessing pdev directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250715093110.107317-17-mark.caveayland@nutanix.com
[ clg: Updated vfio_sub_page_bar_update_mappings() ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 204 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 121 insertions(+), 83 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 3fe5b03eb1160bb66fc4ae3942d14a2d71b4431a..052591d2c970a1668db390f31ea06cd90e6a420f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -117,6 +117,7 @@ static void vfio_intx_mmap_enable(void *opaque)
 static void vfio_intx_interrupt(void *opaque)
 {
     VFIOPCIDevice *vdev = opaque;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
 
     if (!event_notifier_test_and_clear(&vdev->intx.interrupt)) {
         return;
@@ -125,7 +126,7 @@ static void vfio_intx_interrupt(void *opaque)
     trace_vfio_intx_interrupt(vdev->vbasedev.name, 'A' + vdev->intx.pin);
 
     vdev->intx.pending = true;
-    pci_irq_assert(&vdev->pdev);
+    pci_irq_assert(pdev);
     vfio_mmap_set_enabled(vdev, false);
     if (vdev->intx.mmap_timeout) {
         timer_mod(vdev->intx.mmap_timer,
@@ -136,6 +137,7 @@ static void vfio_intx_interrupt(void *opaque)
 void vfio_pci_intx_eoi(VFIODevice *vbasedev)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
+    PCIDevice *pdev = PCI_DEVICE(vdev);
 
     if (!vdev->intx.pending) {
         return;
@@ -144,13 +146,14 @@ void vfio_pci_intx_eoi(VFIODevice *vbasedev)
     trace_vfio_pci_intx_eoi(vbasedev->name);
 
     vdev->intx.pending = false;
-    pci_irq_deassert(&vdev->pdev);
+    pci_irq_deassert(pdev);
     vfio_device_irq_unmask(vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
 }
 
 static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
 {
 #ifdef CONFIG_KVM
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     int irq_fd = event_notifier_get_fd(&vdev->intx.interrupt);
 
     if (vdev->no_kvm_intx || !kvm_irqfds_enabled() ||
@@ -163,7 +166,7 @@ static bool vfio_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
     qemu_set_fd_handler(irq_fd, NULL, NULL, vdev);
     vfio_device_irq_mask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
     vdev->intx.pending = false;
-    pci_irq_deassert(&vdev->pdev);
+    pci_irq_deassert(pdev);
 
     /* Get an eventfd for resample/unmask */
     if (!vfio_notifier_init(vdev, &vdev->intx.unmask, "intx-unmask", 0, errp)) {
@@ -241,6 +244,8 @@ static bool vfio_cpr_intx_enable_kvm(VFIOPCIDevice *vdev, Error **errp)
 static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
 {
 #ifdef CONFIG_KVM
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+
     if (!vdev->intx.kvm_accel) {
         return;
     }
@@ -251,7 +256,7 @@ static void vfio_intx_disable_kvm(VFIOPCIDevice *vdev)
      */
     vfio_device_irq_mask(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
     vdev->intx.pending = false;
-    pci_irq_deassert(&vdev->pdev);
+    pci_irq_deassert(pdev);
 
     /* Tell KVM to stop listening for an INTx irqfd */
     if (kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state, &vdev->intx.interrupt,
@@ -307,7 +312,7 @@ static void vfio_intx_routing_notifier(PCIDevice *pdev)
         return;
     }
 
-    route = pci_device_route_intx_to_irq(&vdev->pdev, vdev->intx.pin);
+    route = pci_device_route_intx_to_irq(pdev, vdev->intx.pin);
 
     if (pci_intx_route_changed(&vdev->intx.route, &route)) {
         vfio_intx_update(vdev, &route);
@@ -324,7 +329,8 @@ static void vfio_irqchip_change(Notifier *notify, void *data)
 
 static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
 {
-    uint8_t pin = vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1);
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+    uint8_t pin = vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1);
     Error *err = NULL;
     int32_t fd;
 
@@ -342,7 +348,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     }
 
     vdev->intx.pin = pin - 1; /* Pin A (1) -> irq[0] */
-    pci_config_set_interrupt_pin(vdev->pdev.config, pin);
+    pci_config_set_interrupt_pin(pdev->config, pin);
 
 #ifdef CONFIG_KVM
     /*
@@ -350,7 +356,7 @@ static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
      * where we won't actually use the result anyway.
      */
     if (kvm_irqfds_enabled() && kvm_resamplefds_enabled()) {
-        vdev->intx.route = pci_device_route_intx_to_irq(&vdev->pdev,
+        vdev->intx.route = pci_device_route_intx_to_irq(pdev,
                                                         vdev->intx.pin);
     }
 #endif
@@ -390,13 +396,14 @@ skip_signaling:
 
 static void vfio_intx_disable(VFIOPCIDevice *vdev)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     int fd;
 
     timer_del(vdev->intx.mmap_timer);
     vfio_intx_disable_kvm(vdev);
     vfio_device_irq_disable(&vdev->vbasedev, VFIO_PCI_INTX_IRQ_INDEX);
     vdev->intx.pending = false;
-    pci_irq_deassert(&vdev->pdev);
+    pci_irq_deassert(pdev);
     vfio_mmap_set_enabled(vdev, true);
 
     fd = event_notifier_get_fd(&vdev->intx.interrupt);
@@ -428,6 +435,7 @@ static void vfio_msi_interrupt(void *opaque)
 {
     VFIOMSIVector *vector = opaque;
     VFIOPCIDevice *vdev = vector->vdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     MSIMessage (*get_msg)(PCIDevice *dev, unsigned vector);
     void (*notify)(PCIDevice *dev, unsigned vector);
     MSIMessage msg;
@@ -442,9 +450,9 @@ static void vfio_msi_interrupt(void *opaque)
         notify = msix_notify;
 
         /* A masked vector firing needs to use the PBA, enable it */
-        if (msix_is_masked(&vdev->pdev, nr)) {
+        if (msix_is_masked(pdev, nr)) {
             set_bit(nr, vdev->msix->pending);
-            memory_region_set_enabled(&vdev->pdev.msix_pba_mmio, true);
+            memory_region_set_enabled(&pdev->msix_pba_mmio, true);
             trace_vfio_msix_pba_enable(vdev->vbasedev.name);
         }
     } else if (vdev->interrupt == VFIO_INT_MSI) {
@@ -454,9 +462,9 @@ static void vfio_msi_interrupt(void *opaque)
         abort();
     }
 
-    msg = get_msg(&vdev->pdev, nr);
+    msg = get_msg(pdev, nr);
     trace_vfio_msi_interrupt(vdev->vbasedev.name, nr, msg.address, msg.data);
-    notify(&vdev->pdev, nr);
+    notify(pdev, nr);
 }
 
 void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr, bool enable)
@@ -495,6 +503,7 @@ static int vfio_enable_msix_no_vec(VFIOPCIDevice *vdev)
 
 static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     struct vfio_irq_set *irq_set;
     int ret = 0, i, argsz;
     int32_t *fds;
@@ -537,7 +546,7 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
          */
         if (vdev->msi_vectors[i].use) {
             if (vdev->msi_vectors[i].virq < 0 ||
-                (msix && msix_is_masked(&vdev->pdev, i))) {
+                (msix && msix_is_masked(pdev, i))) {
                 fd = event_notifier_get_fd(&vdev->msi_vectors[i].interrupt);
             } else {
                 fd = event_notifier_get_fd(&vdev->msi_vectors[i].kvm_interrupt);
@@ -557,12 +566,14 @@ static int vfio_enable_vectors(VFIOPCIDevice *vdev, bool msix)
 void vfio_pci_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
                                int vector_n, bool msix)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+
     if ((msix && vdev->no_kvm_msix) || (!msix && vdev->no_kvm_msi)) {
         return;
     }
 
     vector->virq = kvm_irqchip_add_msi_route(&vfio_route_change,
-                                             vector_n, &vdev->pdev);
+                                             vector_n, pdev);
 }
 
 static void vfio_connect_kvm_msi_virq(VFIOMSIVector *vector, int nr)
@@ -631,7 +642,7 @@ static void set_irq_signalling(VFIODevice *vbasedev, VFIOMSIVector *vector,
 void vfio_pci_vector_init(VFIOPCIDevice *vdev, int nr)
 {
     VFIOMSIVector *vector = &vdev->msi_vectors[nr];
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     Error *local_err = NULL;
 
     vector->vdev = vdev;
@@ -720,7 +731,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
     clear_bit(nr, vdev->msix->pending);
     if (find_first_bit(vdev->msix->pending,
                        vdev->nr_vectors) == vdev->nr_vectors) {
-        memory_region_set_enabled(&vdev->pdev.msix_pba_mmio, false);
+        memory_region_set_enabled(&pdev->msix_pba_mmio, false);
         trace_vfio_msix_pba_disable(vdev->vbasedev.name);
     }
 
@@ -771,7 +782,9 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
 
 void vfio_pci_msix_set_notifiers(VFIOPCIDevice *vdev)
 {
-    msix_set_vector_notifiers(&vdev->pdev, vfio_msix_vector_use,
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+
+    msix_set_vector_notifiers(pdev, vfio_msix_vector_use,
                               vfio_msix_vector_release, NULL);
 }
 
@@ -798,6 +811,7 @@ void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
 
 static void vfio_msix_enable(VFIOPCIDevice *vdev)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     int ret;
 
     vfio_disable_interrupts(vdev);
@@ -814,7 +828,7 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
      */
     vfio_pci_prepare_kvm_msi_virq_batch(vdev);
 
-    if (msix_set_vector_notifiers(&vdev->pdev, vfio_msix_vector_use,
+    if (msix_set_vector_notifiers(pdev, vfio_msix_vector_use,
                                   vfio_msix_vector_release, NULL)) {
         error_report("vfio: msix_set_vector_notifiers failed");
     }
@@ -852,11 +866,12 @@ static void vfio_msix_enable(VFIOPCIDevice *vdev)
 
 static void vfio_msi_enable(VFIOPCIDevice *vdev)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     int ret, i;
 
     vfio_disable_interrupts(vdev);
 
-    vdev->nr_vectors = msi_nr_vectors_allocated(&vdev->pdev);
+    vdev->nr_vectors = msi_nr_vectors_allocated(pdev);
 retry:
     /*
      * Setting vector notifiers needs to enable route for each vector.
@@ -949,10 +964,11 @@ static void vfio_msi_disable_common(VFIOPCIDevice *vdev)
 
 static void vfio_msix_disable(VFIOPCIDevice *vdev)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     Error *err = NULL;
     int i;
 
-    msix_unset_vector_notifiers(&vdev->pdev);
+    msix_unset_vector_notifiers(pdev);
 
     /*
      * MSI-X will only release vectors if MSI-X is still enabled on the
@@ -960,8 +976,8 @@ static void vfio_msix_disable(VFIOPCIDevice *vdev)
      */
     for (i = 0; i < vdev->nr_vectors; i++) {
         if (vdev->msi_vectors[i].use) {
-            vfio_msix_vector_release(&vdev->pdev, i);
-            msix_vector_unuse(&vdev->pdev, i);
+            vfio_msix_vector_release(pdev, i);
+            msix_vector_unuse(pdev, i);
         }
     }
 
@@ -998,6 +1014,7 @@ static void vfio_msi_disable(VFIOPCIDevice *vdev)
 
 static void vfio_update_msi(VFIOPCIDevice *vdev)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     int i;
 
     for (i = 0; i < vdev->nr_vectors; i++) {
@@ -1008,8 +1025,8 @@ static void vfio_update_msi(VFIOPCIDevice *vdev)
             continue;
         }
 
-        msg = msi_get_message(&vdev->pdev, i);
-        vfio_update_kvm_msi_virq(vector, msg, &vdev->pdev);
+        msg = msi_get_message(pdev, i);
+        vfio_update_kvm_msi_virq(vector, msg, pdev);
     }
 }
 
@@ -1171,13 +1188,14 @@ static const MemoryRegionOps vfio_rom_ops = {
 
 static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
     char *name;
 
-    if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
+    if (pdev->romfile || !pdev->rom_bar) {
         /* Since pci handles romfile, just print a message and return */
-        if (vfio_opt_rom_in_denylist(vdev) && vdev->pdev.romfile) {
+        if (vfio_opt_rom_in_denylist(vdev) && pdev->romfile) {
             warn_report("Device at %s is known to cause system instability"
                         " issues during option rom execution",
                         vdev->vbasedev.name);
@@ -1206,7 +1224,7 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
     }
 
     if (vfio_opt_rom_in_denylist(vdev)) {
-        if (vdev->pdev.rom_bar > 0) {
+        if (pdev->rom_bar > 0) {
             warn_report("Device at %s is known to cause system instability"
                         " issues during option rom execution",
                         vdev->vbasedev.name);
@@ -1225,12 +1243,12 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
 
     name = g_strdup_printf("vfio[%s].rom", vdev->vbasedev.name);
 
-    memory_region_init_io(&vdev->pdev.rom, OBJECT(vdev),
+    memory_region_init_io(&pdev->rom, OBJECT(vdev),
                           &vfio_rom_ops, vdev, name, size);
     g_free(name);
 
-    pci_register_bar(&vdev->pdev, PCI_ROM_SLOT,
-                     PCI_BASE_ADDRESS_SPACE_MEMORY, &vdev->pdev.rom);
+    pci_register_bar(pdev, PCI_ROM_SLOT,
+                     PCI_BASE_ADDRESS_SPACE_MEMORY, &pdev->rom);
 
     vdev->rom_read_failed = false;
 }
@@ -1503,6 +1521,7 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev)
 
 static bool vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     uint16_t ctrl;
     bool msi_64bit, msi_maskbit;
     int ret, entries;
@@ -1523,7 +1542,7 @@ static bool vfio_msi_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
 
     trace_vfio_msi_setup(vdev->vbasedev.name, pos);
 
-    ret = msi_init(&vdev->pdev, pos, entries, msi_64bit, msi_maskbit, &err);
+    ret = msi_init(pdev, pos, entries, msi_64bit, msi_maskbit, &err);
     if (ret < 0) {
         if (ret == -ENOTSUP) {
             return true;
@@ -1716,6 +1735,7 @@ static bool vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
  */
 static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     uint8_t pos;
     uint16_t ctrl;
     uint32_t table, pba;
@@ -1723,7 +1743,7 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
     VFIOMSIXInfo *msix;
     int ret;
 
-    pos = pci_find_capability(&vdev->pdev, PCI_CAP_ID_MSIX);
+    pos = pci_find_capability(pdev, PCI_CAP_ID_MSIX);
     if (!pos) {
         return true;
     }
@@ -1815,12 +1835,13 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
 
 static bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     int ret;
     Error *err = NULL;
 
     vdev->msix->pending = g_new0(unsigned long,
                                  BITS_TO_LONGS(vdev->msix->entries));
-    ret = msix_init(&vdev->pdev, vdev->msix->entries,
+    ret = msix_init(pdev, vdev->msix->entries,
                     vdev->bars[vdev->msix->table_bar].mr,
                     vdev->msix->table_bar, vdev->msix->table_offset,
                     vdev->bars[vdev->msix->pba_bar].mr,
@@ -1852,7 +1873,7 @@ static bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
      * vector-use notifier is called, which occurs on unmask, we test whether
      * PBA emulation is needed and again disable if not.
      */
-    memory_region_set_enabled(&vdev->pdev.msix_pba_mmio, false);
+    memory_region_set_enabled(&pdev->msix_pba_mmio, false);
 
     /*
      * The emulated machine may provide a paravirt interface for MSIX setup
@@ -1864,7 +1885,7 @@ static bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
      */
     if (object_property_get_bool(OBJECT(qdev_get_machine()),
                                  "vfio-no-msix-emulation", NULL)) {
-        memory_region_set_enabled(&vdev->pdev.msix_table_mmio, false);
+        memory_region_set_enabled(&pdev->msix_table_mmio, false);
     }
 
     return true;
@@ -1872,10 +1893,12 @@ static bool vfio_msix_setup(VFIOPCIDevice *vdev, int pos, Error **errp)
 
 void vfio_pci_teardown_msi(VFIOPCIDevice *vdev)
 {
-    msi_uninit(&vdev->pdev);
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+
+    msi_uninit(pdev);
 
     if (vdev->msix) {
-        msix_uninit(&vdev->pdev,
+        msix_uninit(pdev,
                     vdev->bars[vdev->msix->table_bar].mr,
                     vdev->bars[vdev->msix->pba_bar].mr);
         g_free(vdev->msix->pending);
@@ -1936,6 +1959,7 @@ static void vfio_bars_prepare(VFIOPCIDevice *vdev)
 
 static void vfio_bar_register(VFIOPCIDevice *vdev, int nr)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     VFIOBAR *bar = &vdev->bars[nr];
     char *name;
 
@@ -1957,7 +1981,7 @@ static void vfio_bar_register(VFIOPCIDevice *vdev, int nr)
         }
     }
 
-    pci_register_bar(&vdev->pdev, nr, bar->type, bar->mr);
+    pci_register_bar(pdev, nr, bar->type, bar->mr);
 }
 
 static void vfio_bars_register(VFIOPCIDevice *vdev)
@@ -1971,6 +1995,7 @@ static void vfio_bars_register(VFIOPCIDevice *vdev)
 
 void vfio_pci_bars_exit(VFIOPCIDevice *vdev)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     int i;
 
     for (i = 0; i < PCI_ROM_SLOT; i++) {
@@ -1984,7 +2009,7 @@ void vfio_pci_bars_exit(VFIOPCIDevice *vdev)
     }
 
     if (vdev->vga) {
-        pci_unregister_vga(&vdev->pdev);
+        pci_unregister_vga(pdev);
         vfio_vga_quirk_exit(vdev);
     }
 }
@@ -2056,8 +2081,10 @@ static void vfio_set_word_bits(uint8_t *buf, uint16_t val, uint16_t mask)
 static void vfio_add_emulated_word(VFIOPCIDevice *vdev, int pos,
                                    uint16_t val, uint16_t mask)
 {
-    vfio_set_word_bits(vdev->pdev.config + pos, val, mask);
-    vfio_set_word_bits(vdev->pdev.wmask + pos, ~mask, mask);
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+
+    vfio_set_word_bits(pdev->config + pos, val, mask);
+    vfio_set_word_bits(pdev->wmask + pos, ~mask, mask);
     vfio_set_word_bits(vdev->emulated_config_bits + pos, mask, mask);
 }
 
@@ -2069,8 +2096,10 @@ static void vfio_set_long_bits(uint8_t *buf, uint32_t val, uint32_t mask)
 static void vfio_add_emulated_long(VFIOPCIDevice *vdev, int pos,
                                    uint32_t val, uint32_t mask)
 {
-    vfio_set_long_bits(vdev->pdev.config + pos, val, mask);
-    vfio_set_long_bits(vdev->pdev.wmask + pos, ~mask, mask);
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+
+    vfio_set_long_bits(pdev->config + pos, val, mask);
+    vfio_set_long_bits(pdev->wmask + pos, ~mask, mask);
     vfio_set_long_bits(vdev->emulated_config_bits + pos, mask, mask);
 }
 
@@ -2078,7 +2107,8 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
 {
     struct vfio_device_info_cap_pci_atomic_comp *cap;
     g_autofree struct vfio_device_info *info = NULL;
-    PCIBus *bus = pci_get_bus(&vdev->pdev);
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+    PCIBus *bus = pci_get_bus(pdev);
     PCIDevice *parent = bus->parent_dev;
     struct vfio_info_cap_header *hdr;
     uint32_t mask = 0;
@@ -2094,8 +2124,8 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
     if (pci_bus_is_root(bus) || !parent || !parent->exp.exp_cap ||
         pcie_cap_get_type(parent) != PCI_EXP_TYPE_ROOT_PORT ||
         pcie_cap_get_version(parent) != PCI_EXP_FLAGS_VER2 ||
-        vdev->pdev.devfn ||
-        vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+        pdev->devfn ||
+        pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
         return;
     }
 
@@ -2139,8 +2169,10 @@ static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
 
 static void vfio_pci_disable_rp_atomics(VFIOPCIDevice *vdev)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+
     if (vdev->clear_parent_atomics_on_exit) {
-        PCIDevice *parent = pci_get_bus(&vdev->pdev)->parent_dev;
+        PCIDevice *parent = pci_get_bus(pdev)->parent_dev;
         uint8_t *pos = parent->config + parent->exp.exp_cap + PCI_EXP_DEVCAP2;
 
         pci_long_test_and_clear_mask(pos, PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
@@ -2152,10 +2184,11 @@ static void vfio_pci_disable_rp_atomics(VFIOPCIDevice *vdev)
 static bool vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
                                 Error **errp)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     uint16_t flags;
     uint8_t type;
 
-    flags = pci_get_word(vdev->pdev.config + pos + PCI_CAP_FLAGS);
+    flags = pci_get_word(pdev->config + pos + PCI_CAP_FLAGS);
     type = (flags & PCI_EXP_FLAGS_TYPE) >> 4;
 
     if (type != PCI_EXP_TYPE_ENDPOINT &&
@@ -2167,8 +2200,8 @@ static bool vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
         return false;
     }
 
-    if (!pci_bus_is_express(pci_get_bus(&vdev->pdev))) {
-        PCIBus *bus = pci_get_bus(&vdev->pdev);
+    if (!pci_bus_is_express(pci_get_bus(pdev))) {
+        PCIBus *bus = pci_get_bus(pdev);
         PCIDevice *bridge;
 
         /*
@@ -2200,7 +2233,7 @@ static bool vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
             return true;
         }
 
-    } else if (pci_bus_is_root(pci_get_bus(&vdev->pdev))) {
+    } else if (pci_bus_is_root(pci_get_bus(pdev))) {
         /*
          * On a Root Complex bus Endpoints become Root Complex Integrated
          * Endpoints, which changes the type and clears the LNK & LNK2 fields.
@@ -2268,20 +2301,20 @@ static bool vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
                                1, PCI_EXP_FLAGS_VERS);
     }
 
-    pos = pci_add_capability(&vdev->pdev, PCI_CAP_ID_EXP, pos, size,
-                             errp);
+    pos = pci_add_capability(pdev, PCI_CAP_ID_EXP, pos, size, errp);
     if (pos < 0) {
         return false;
     }
 
-    vdev->pdev.exp.exp_cap = pos;
+    pdev->exp.exp_cap = pos;
 
     return true;
 }
 
 static void vfio_check_pcie_flr(VFIOPCIDevice *vdev, uint8_t pos)
 {
-    uint32_t cap = pci_get_long(vdev->pdev.config + pos + PCI_EXP_DEVCAP);
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+    uint32_t cap = pci_get_long(pdev->config + pos + PCI_EXP_DEVCAP);
 
     if (cap & PCI_EXP_DEVCAP_FLR) {
         trace_vfio_check_pcie_flr(vdev->vbasedev.name);
@@ -2291,7 +2324,8 @@ static void vfio_check_pcie_flr(VFIOPCIDevice *vdev, uint8_t pos)
 
 static void vfio_check_pm_reset(VFIOPCIDevice *vdev, uint8_t pos)
 {
-    uint16_t csr = pci_get_word(vdev->pdev.config + pos + PCI_PM_CTRL);
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+    uint16_t csr = pci_get_word(pdev->config + pos + PCI_PM_CTRL);
 
     if (!(csr & PCI_PM_CTRL_NO_SOFT_RESET)) {
         trace_vfio_check_pm_reset(vdev->vbasedev.name);
@@ -2301,7 +2335,8 @@ static void vfio_check_pm_reset(VFIOPCIDevice *vdev, uint8_t pos)
 
 static void vfio_check_af_flr(VFIOPCIDevice *vdev, uint8_t pos)
 {
-    uint8_t cap = pci_get_byte(vdev->pdev.config + pos + PCI_AF_CAP);
+    PCIDevice *pdev = PCI_DEVICE(vdev);
+    uint8_t cap = pci_get_byte(pdev->config + pos + PCI_AF_CAP);
 
     if ((cap & PCI_AF_CAP_TP) && (cap & PCI_AF_CAP_FLR)) {
         trace_vfio_check_af_flr(vdev->vbasedev.name);
@@ -2312,7 +2347,7 @@ static void vfio_check_af_flr(VFIOPCIDevice *vdev, uint8_t pos)
 static bool vfio_add_vendor_specific_cap(VFIOPCIDevice *vdev, int pos,
                                          uint8_t size, Error **errp)
 {
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
 
     pos = pci_add_capability(pdev, PCI_CAP_ID_VNDR, pos, size, errp);
     if (pos < 0) {
@@ -2334,7 +2369,7 @@ static bool vfio_add_vendor_specific_cap(VFIOPCIDevice *vdev, int pos,
 static bool vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
 {
     ERRP_GUARD();
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     uint8_t cap_id, next, size;
     bool ret;
 
@@ -2420,17 +2455,18 @@ static bool vfio_add_std_cap(VFIOPCIDevice *vdev, uint8_t pos, Error **errp)
 
 static int vfio_setup_rebar_ecap(VFIOPCIDevice *vdev, uint16_t pos)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     uint32_t ctrl;
     int i, nbar;
 
-    ctrl = pci_get_long(vdev->pdev.config + pos + PCI_REBAR_CTRL);
+    ctrl = pci_get_long(pdev->config + pos + PCI_REBAR_CTRL);
     nbar = (ctrl & PCI_REBAR_CTRL_NBAR_MASK) >> PCI_REBAR_CTRL_NBAR_SHIFT;
 
     for (i = 0; i < nbar; i++) {
         uint32_t cap;
         int size;
 
-        ctrl = pci_get_long(vdev->pdev.config + pos + PCI_REBAR_CTRL + (i * 8));
+        ctrl = pci_get_long(pdev->config + pos + PCI_REBAR_CTRL + (i * 8));
         size = (ctrl & PCI_REBAR_CTRL_BAR_SIZE) >> PCI_REBAR_CTRL_BAR_SHIFT;
 
         /* The cap register reports sizes 1MB to 128TB, with 4 reserved bits */
@@ -2468,7 +2504,7 @@ static int vfio_setup_rebar_ecap(VFIOPCIDevice *vdev, uint16_t pos)
 
 static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
 {
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     uint32_t header;
     uint16_t cap_id, next, size;
     uint8_t cap_ver;
@@ -2562,7 +2598,7 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
 
 bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
 {
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
 
     if (!(pdev->config[PCI_STATUS] & PCI_STATUS_CAP_LIST) ||
         !pdev->config[PCI_CAPABILITY_LIST]) {
@@ -2579,7 +2615,7 @@ bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
 
 void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
 {
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     uint16_t cmd;
 
     vfio_disable_interrupts(vdev);
@@ -2796,7 +2832,7 @@ static int vfio_pci_save_config(VFIODevice *vbasedev, QEMUFile *f, Error **errp)
 static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
 {
     VFIOPCIDevice *vdev = container_of(vbasedev, VFIOPCIDevice, vbasedev);
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     pcibus_t old_addr[PCI_NUM_REGIONS - 1];
     int bar, ret;
 
@@ -2844,7 +2880,7 @@ VFIOPCIDevice *vfio_pci_from_vfio_device(VFIODevice *vbasedev)
 
 void vfio_sub_page_bar_update_mappings(VFIOPCIDevice *vdev)
 {
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     int page_size = qemu_real_host_page_size();
     int bar;
 
@@ -2928,6 +2964,7 @@ bool vfio_populate_vga(VFIOPCIDevice *vdev, Error **errp)
 
 bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     struct vfio_region_info *reg_info = NULL;
     struct vfio_irq_info irq_info;
@@ -2979,7 +3016,7 @@ bool vfio_pci_populate_device(VFIOPCIDevice *vdev, Error **errp)
 
     vdev->config_size = reg_info->size;
     if (vdev->config_size == PCI_CONFIG_SPACE_SIZE) {
-        vdev->pdev.cap_present &= ~QEMU_PCI_CAP_EXPRESS;
+        pdev->cap_present &= ~QEMU_PCI_CAP_EXPRESS;
     }
     vdev->config_offset = reg_info->offset;
 
@@ -3183,25 +3220,26 @@ static void vfio_unregister_req_notifier(VFIOPCIDevice *vdev)
 
 void vfio_pci_config_register_vga(VFIOPCIDevice *vdev)
 {
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     assert(vdev->vga != NULL);
 
-    pci_register_vga(&vdev->pdev, &vdev->vga->region[QEMU_PCI_VGA_MEM].mem,
+    pci_register_vga(pdev, &vdev->vga->region[QEMU_PCI_VGA_MEM].mem,
                      &vdev->vga->region[QEMU_PCI_VGA_IO_LO].mem,
                      &vdev->vga->region[QEMU_PCI_VGA_IO_HI].mem);
 }
 
 bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
 {
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     VFIODevice *vbasedev = &vdev->vbasedev;
     uint32_t config_space_size;
     int ret;
 
-    config_space_size = MIN(pci_config_size(&vdev->pdev), vdev->config_size);
+    config_space_size = MIN(pci_config_size(pdev), vdev->config_size);
 
     /* Get a copy of config space */
     ret = vfio_pci_config_space_read(vdev, 0, config_space_size,
-                                     vdev->pdev.config);
+                                     pdev->config);
     if (ret < (int)config_space_size) {
         ret = ret < 0 ? -ret : EFAULT;
         error_setg_errno(errp, ret, "failed to read device config space");
@@ -3286,10 +3324,10 @@ bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
                                               PCI_HEADER_TYPE_MULTI_FUNCTION;
 
     /* Restore or clear multifunction, this is always controlled by QEMU */
-    if (vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
-        vdev->pdev.config[PCI_HEADER_TYPE] |= PCI_HEADER_TYPE_MULTI_FUNCTION;
+    if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+        pdev->config[PCI_HEADER_TYPE] |= PCI_HEADER_TYPE_MULTI_FUNCTION;
     } else {
-        vdev->pdev.config[PCI_HEADER_TYPE] &= ~PCI_HEADER_TYPE_MULTI_FUNCTION;
+        pdev->config[PCI_HEADER_TYPE] &= ~PCI_HEADER_TYPE_MULTI_FUNCTION;
     }
 
     /*
@@ -3297,8 +3335,8 @@ bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
      * BAR, such as might be the case with the option ROM, we can get
      * confusing, unwritable, residual addresses from the host here.
      */
-    memset(&vdev->pdev.config[PCI_BASE_ADDRESS_0], 0, 24);
-    memset(&vdev->pdev.config[PCI_ROM_ADDRESS], 0, 4);
+    memset(&pdev->config[PCI_BASE_ADDRESS_0], 0, 24);
+    memset(&pdev->config[PCI_ROM_ADDRESS], 0, 4);
 
     vfio_pci_size_rom(vdev);
 
@@ -3319,7 +3357,7 @@ bool vfio_pci_config_setup(VFIOPCIDevice *vdev, Error **errp)
 
 bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
 {
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
 
     /* QEMU emulates all of MSI & MSIX */
     if (pdev->cap_present & QEMU_PCI_CAP_MSIX) {
@@ -3332,10 +3370,10 @@ bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
                vdev->msi_cap_size);
     }
 
-    if (vfio_pci_read_config(&vdev->pdev, PCI_INTERRUPT_PIN, 1)) {
+    if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
         vdev->intx.mmap_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
                                              vfio_intx_mmap_enable, vdev);
-        pci_device_set_intx_routing_notifier(&vdev->pdev,
+        pci_device_set_intx_routing_notifier(pdev,
                                              vfio_intx_routing_notifier);
         vdev->irqchip_change_notifier.notify = vfio_irqchip_change;
         kvm_irqchip_add_change_notifier(&vdev->irqchip_change_notifier);
@@ -3347,7 +3385,7 @@ bool vfio_pci_interrupt_setup(VFIOPCIDevice *vdev, Error **errp)
          */
         if (!cpr_is_incoming() && !vfio_intx_enable(vdev, errp)) {
             timer_free(vdev->intx.mmap_timer);
-            pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
+            pci_device_set_intx_routing_notifier(pdev, NULL);
             kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
             return false;
         }
@@ -3498,7 +3536,7 @@ out_deregister:
     if (vdev->interrupt == VFIO_INT_INTx) {
         vfio_intx_disable(vdev);
     }
-    pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
+    pci_device_set_intx_routing_notifier(pdev, NULL);
     if (vdev->irqchip_change_notifier.notify) {
         kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
     }
@@ -3530,7 +3568,7 @@ static void vfio_exitfn(PCIDevice *pdev)
 
     vfio_unregister_req_notifier(vdev);
     vfio_unregister_err_notifier(vdev);
-    pci_device_set_intx_routing_notifier(&vdev->pdev, NULL);
+    pci_device_set_intx_routing_notifier(pdev, NULL);
     if (vdev->irqchip_change_notifier.notify) {
         kvm_irqchip_remove_change_notifier(&vdev->irqchip_change_notifier);
     }
-- 
2.51.0


