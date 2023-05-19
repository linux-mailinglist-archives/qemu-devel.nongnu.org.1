Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3107A70A244
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 23:58:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q086o-0005zD-Kn; Fri, 19 May 2023 17:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q086m-0005yK-GP
 for qemu-devel@nongnu.org; Fri, 19 May 2023 17:57:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q086l-0004FT-1u
 for qemu-devel@nongnu.org; Fri, 19 May 2023 17:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684533474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fgLJMJytCtabs3p65dU+5yU7aU1Lzei6dYgf+/EPmqw=;
 b=SKNHp9vrxIKmdZuNPM8S8tKrHRa1yakv/M9E5BM6oTZVzskPR271d13yDI9MrsRPi/St8l
 GGBi/Cz48gV14ch7TRIPTOPAnyaWQEChyJNydVnrRDIWbBVi4aUOHW/YCMnu5A2Q8gwfAm
 X9RdGoNtaCb0E2EWuIAnK01MCSueRfo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-yoCbIoAGMYi19gyO_PTBUQ-1; Fri, 19 May 2023 17:57:50 -0400
X-MC-Unique: yoCbIoAGMYi19gyO_PTBUQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3042A2A5954B;
 Fri, 19 May 2023 21:57:50 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.10.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C854AC0004B;
 Fri, 19 May 2023 21:57:49 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: robin@streamhpc.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com
Cc: Alex Williamson <alex.williamson@redhat.com>,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 4/4] vfio/pci: Enable AtomicOps completers on root ports
Date: Fri, 19 May 2023 15:57:39 -0600
Message-Id: <20230519215739.402729-5-alex.williamson@redhat.com>
In-Reply-To: <20230519215739.402729-1-alex.williamson@redhat.com>
References: <20230519215739.402729-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124;
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

For cold-plug configurations where the vfio-pci device reports enabled
support for PCIe AtomicOps completers and we have a compatible VM
configuration, mirror the host AtomicOps completer support in the virtual
root port.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/vfio/pci.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index bf27a3990564..61d045785bf8 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1826,6 +1826,70 @@ static void vfio_add_emulated_long(VFIOPCIDevice *vdev, int pos,
     vfio_set_long_bits(vdev->emulated_config_bits + pos, mask, mask);
 }
 
+/*
+ * For a cold-plugged device connected directly to a root port where
+ * vfio-pci reports AtomicOp completer support on the host, twiddle
+ * bits in the emulated root port to reflect this capability.
+ */
+static void vfio_pci_enable_rp_atomics(VFIOPCIDevice *vdev)
+{
+    struct vfio_device_info_cap_pci_atomic_comp *cap;
+    g_autofree struct vfio_device_info *info = NULL;
+    struct vfio_info_cap_header *hdr;
+    PCIDevice *parent;
+    uint32_t mask = 0;
+    PCIBus *bus;
+
+    /*
+     * XXX
+     *  - Should this also be restricted to TYPE_VFIO_PCI_NOHOTPLUG devices?
+     *  - Should we clear the capability on exit?
+     */
+    if (vdev->pdev.qdev.hotplugged) {
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
+    bus = pci_get_bus(&vdev->pdev);
+    parent = bus->parent_dev;
+
+    if (!parent || !pci_is_express(parent) || !parent->exp.exp_cap) {
+        return;
+    }
+
+    if (pcie_cap_get_type(parent) != PCI_EXP_TYPE_ROOT_PORT ||
+        pcie_cap_get_version(parent) != PCI_EXP_FLAGS_VER2) {
+        return;
+    }
+
+    pci_long_test_and_set_mask(parent->config + parent->exp.exp_cap +
+                               PCI_EXP_DEVCAP2, mask);
+}
+
 static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
                                Error **errp)
 {
@@ -1929,6 +1993,8 @@ static int vfio_setup_pcie_cap(VFIOPCIDevice *vdev, int pos, uint8_t size,
                            QEMU_PCI_EXP_LNKCAP_MLS(QEMU_PCI_EXP_LNK_2_5GT), ~0);
             vfio_add_emulated_word(vdev, pos + PCI_EXP_LNKCTL, 0, ~0);
         }
+
+        vfio_pci_enable_rp_atomics(vdev);
     }
 
     /*
-- 
2.39.2


