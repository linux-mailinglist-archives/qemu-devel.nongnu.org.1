Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A29EA74CF14
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 09:51:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIleH-0006Vi-Tr; Mon, 10 Jul 2023 03:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Zxd8=C4=redhat.com=clg@ozlabs.org>)
 id 1qIleD-0006SV-To
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:49:30 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Zxd8=C4=redhat.com=clg@ozlabs.org>)
 id 1qIleB-0006zN-HM
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:49:29 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qzx3S46qbz4wyC;
 Mon, 10 Jul 2023 17:49:24 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qzx3Q40j1z4wyL;
 Mon, 10 Jul 2023 17:49:22 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Robin Voetter <robin@streamhpc.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 11/11] vfio/pci: Enable AtomicOps completers on root ports
Date: Mon, 10 Jul 2023 09:48:48 +0200
Message-ID: <20230710074848.456453-12-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230710074848.456453-1-clg@redhat.com>
References: <20230710074848.456453-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Zxd8=C4=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Alex Williamson <alex.williamson@redhat.com>

Dynamically enable Atomic Ops completer support around realize/exit of
vfio-pci devices reporting host support for these accesses and adhering
to a minimal configuration standard.  While the Atomic Ops completer
bits in the root port device capabilities2 register are read-only, the
PCIe spec does allow RO bits to change to reflect hardware state.  We
take advantage of that here around the realize and exit functions of
the vfio-pci device.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Robin Voetter <robin@streamhpc.com>
Tested-by: Robin Voetter <robin@streamhpc.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h |  1 +
 hw/vfio/pci.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 2674476d6c77..a2771b9ff3cc 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -174,6 +174,7 @@ struct VFIOPCIDevice {
     bool no_vfio_ioeventfd;
     bool enable_ramfb;
     bool defer_kvm_irq_routing;
+    bool clear_parent_atomics_on_exit;
     VFIODisplay *dpy;
     Notifier irqchip_change_notifier;
 };
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c89fdf7ae6c2..a205c6b1130f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1828,6 +1828,81 @@ static void vfio_add_emulated_long(VFIOPCIDevice *vdev, int pos,
     vfio_set_long_bits(vdev->emulated_config_bits + pos, mask, mask);
 }
 
+static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
+{
+    struct vfio_device_info_cap_pci_atomic_comp *cap;
+    g_autofree struct vfio_device_info *info = NULL;
+    PCIBus *bus = pci_get_bus(&vdev->pdev);
+    PCIDevice *parent = bus->parent_dev;
+    struct vfio_info_cap_header *hdr;
+    uint32_t mask = 0;
+    uint8_t *pos;
+
+    /*
+     * PCIe Atomic Ops completer support is only added automatically for single
+     * function devices downstream of a root port supporting DEVCAP2.  Support
+     * is added during realize and, if added, removed during device exit.  The
+     * single function requirement avoids conflicting requirements should a
+     * slot be composed of multiple devices with differing capabilities.
+     */
+    if (pci_bus_is_root(bus) || !parent || !parent->exp.exp_cap ||
+        pcie_cap_get_type(parent) != PCI_EXP_TYPE_ROOT_PORT ||
+        pcie_cap_get_version(parent) != PCI_EXP_FLAGS_VER2 ||
+        vdev->pdev.devfn ||
+        vdev->pdev.cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+        return;
+    }
+
+    pos = parent->config + parent->exp.exp_cap + PCI_EXP_DEVCAP2;
+
+    /* Abort if there'a already an Atomic Ops configuration on the root port */
+    if (pci_get_long(pos) & (PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
+                             PCI_EXP_DEVCAP2_ATOMIC_COMP64 |
+                             PCI_EXP_DEVCAP2_ATOMIC_COMP128)) {
+        return;
+    }
+
+    info = vfio_get_device_info(vdev->vbasedev.fd);
+    if (!info) {
+        return;
+    }
+
+    hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_PCI_ATOMIC_COMP);
+    if (!hdr) {
+        return;
+    }
+
+    cap = (void *)hdr;
+    if (cap->flags & VFIO_PCI_ATOMIC_COMP32) {
+        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP32;
+    }
+    if (cap->flags & VFIO_PCI_ATOMIC_COMP64) {
+        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP64;
+    }
+    if (cap->flags & VFIO_PCI_ATOMIC_COMP128) {
+        mask |= PCI_EXP_DEVCAP2_ATOMIC_COMP128;
+    }
+
+    if (!mask) {
+        return;
+    }
+
+    pci_long_test_and_set_mask(pos, mask);
+    vdev->clear_parent_atomics_on_exit = true;
+}
+
+static void vfio_pci_disable_rp_atomics(VFIOPCIDevice *vdev)
+{
+    if (vdev->clear_parent_atomics_on_exit) {
+        PCIDevice *parent = pci_get_bus(&vdev->pdev)->parent_dev;
+        uint8_t *pos = parent->config + parent->exp.exp_cap + PCI_EXP_DEVCAP2;
+
+        pci_long_test_and_clear_mask(pos, PCI_EXP_DEVCAP2_ATOMIC_COMP32 |
+                                          PCI_EXP_DEVCAP2_ATOMIC_COMP64 |
+                                          PCI_EXP_DEVCAP2_ATOMIC_COMP128);
+    }
+}
+
 static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
                                Error **errp)
 {
@@ -1931,6 +2006,8 @@ static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
                            QEMU_PCI_EXP_LNKCAP_MLS(QEMU_PCI_EXP_LNK_2_5GT), ~0);
             vfio_add_emulated_word(vdev, pos + PCI_EXP_LNKCTL, 0, ~0);
         }
+
+        vfio_pci_enable_rp_atomics(vdev);
     }
 
     /*
@@ -3273,6 +3350,7 @@ static void vfio_exitfn(PCIDevice *pdev)
         timer_free(vdev->intx.mmap_timer);
     }
     vfio_teardown_msi(vdev);
+    vfio_pci_disable_rp_atomics(vdev);
     vfio_bars_exit(vdev);
     vfio_migration_exit(&vdev->vbasedev);
 }
-- 
2.41.0


