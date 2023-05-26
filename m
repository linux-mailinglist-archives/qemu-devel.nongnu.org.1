Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D3B713047
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 01:16:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2gfP-0004fc-OM; Fri, 26 May 2023 19:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q2gfN-0004f3-9z
 for qemu-devel@nongnu.org; Fri, 26 May 2023 19:16:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q2gfL-00082z-Df
 for qemu-devel@nongnu.org; Fri, 26 May 2023 19:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685142970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=woZ49TSbxbpvJ//MBsCbLlx2R9jmGAibuJOnxx5U/Xg=;
 b=MxvuwKpvjibAjSzVwbgzvFgo1EUO7A40Cz1l5CeN+o6fFdoTj+xwk3oBOdmskeHaFydIZ5
 xRFxEILBo/u706/caEMiMb1toYXEc/C53HLpM41GpX6+Ynh9cX2S3BeFLXOrT9ewQjwgaE
 6vYq4Q2VMQt8UibJwaN1v2n4b3W6JW0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-AlVYwEiGOdOygblnOOLRuw-1; Fri, 26 May 2023 19:16:07 -0400
X-MC-Unique: AlVYwEiGOdOygblnOOLRuw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FC7C1C04180;
 Fri, 26 May 2023 23:16:07 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.10.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 892BB40D1B66;
 Fri, 26 May 2023 23:16:06 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: robin@streamhpc.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org,
 clg@redhat.com
Subject: [RFC PATCH v2 4/4] vfio/pci: Enable AtomicOps completers on root ports
Date: Fri, 26 May 2023 17:15:58 -0600
Message-Id: <20230526231558.1660396-5-alex.williamson@redhat.com>
In-Reply-To: <20230526231558.1660396-1-alex.williamson@redhat.com>
References: <20230526231558.1660396-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Dynamically enable Atomic Ops completer support around realize/exit of
vfio-pci devices reporting host support for these accesses and adhering
to a minimal configuration standard.  While the Atomic Ops completer
bits in the root port device capabilities2 register are read-only, the
PCIe spec does allow RO bits to change to reflect hardware state.  We
take advantage of that here around the realize and exit functions of
the vfio-pci device.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.c | 78 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/pci.h |  1 +
 2 files changed, 79 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index bf27a3990564..d8a0fd595560 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1826,6 +1826,81 @@ static void vfio_add_emulated_long(VFIOPCIDevice *vdev, int pos,
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
@@ -1929,6 +2004,8 @@ static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
                            QEMU_PCI_EXP_LNKCAP_MLS(QEMU_PCI_EXP_LNK_2_5GT), ~0);
             vfio_add_emulated_word(vdev, pos + PCI_EXP_LNKCTL, 0, ~0);
         }
+
+        vfio_pci_enable_rp_atomics(vdev);
     }
 
     /*
@@ -3265,6 +3342,7 @@ static void vfio_exitfn(PCIDevice *pdev)
         timer_free(vdev->intx.mmap_timer);
     }
     vfio_teardown_msi(vdev);
+    vfio_pci_disable_rp_atomics(vdev);
     vfio_bars_exit(vdev);
     vfio_migration_exit(&vdev->vbasedev);
 }
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
-- 
2.39.2


