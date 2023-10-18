Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 050227CD88B
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 11:51:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt38O-0001Ei-Ed; Wed, 18 Oct 2023 05:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt38K-0001Co-Ts
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:46:32 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt38J-0003YN-0V
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:46:32 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S9QwN2k51z4xc7;
 Wed, 18 Oct 2023 20:46:28 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9QwL3vwGz4xbC;
 Wed, 18 Oct 2023 20:46:26 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 19/22] vfio/pci: Remove vfio_detach_device from vfio_realize
 error path
Date: Wed, 18 Oct 2023 11:45:28 +0200
Message-ID: <20231018094531.733211-20-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018094531.733211-1-clg@redhat.com>
References: <20231018094531.733211-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=VFJy=GA=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

From: Eric Auger <eric.auger@redhat.com>

In vfio_realize, on the error path, we currently call
vfio_detach_device() after a successful vfio_attach_device.
While this looks natural, vfio_instance_finalize also induces
a vfio_detach_device(), and it seems to be the right place
instead as other resources are released there which happen
to be a prerequisite to a successful UNSET_CONTAINER.

So let's rely on the finalize vfio_detach_device call to free
all the relevant resources.

Fixes: a28e06621170 ("vfio/pci: Introduce vfio_[attach/detach]_device")
Reported-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 40ae46266e33a2b58ed1069113c2967489ed3b95..6e3f6aba28e55311e8bcc4ac757e18c8aa2433f1 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3115,7 +3115,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     vfio_populate_device(vdev, &err);
     if (err) {
         error_propagate(errp, err);
-        goto out_detach;
+        goto error;
     }
 
     /* Get a copy of config space */
@@ -3125,7 +3125,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     if (ret < (int)MIN(pci_config_size(&vdev->pdev), vdev->config_size)) {
         ret = ret < 0 ? -errno : -EFAULT;
         error_setg_errno(errp, -ret, "failed to read device config space");
-        goto out_detach;
+        goto error;
     }
 
     /* vfio emulates a lot for us, but some bits need extra love */
@@ -3144,7 +3144,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     if (vdev->vendor_id != PCI_ANY_ID) {
         if (vdev->vendor_id >= 0xffff) {
             error_setg(errp, "invalid PCI vendor ID provided");
-            goto out_detach;
+            goto error;
         }
         vfio_add_emulated_word(vdev, PCI_VENDOR_ID, vdev->vendor_id, ~0);
         trace_vfio_pci_emulated_vendor_id(vbasedev->name, vdev->vendor_id);
@@ -3155,7 +3155,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     if (vdev->device_id != PCI_ANY_ID) {
         if (vdev->device_id > 0xffff) {
             error_setg(errp, "invalid PCI device ID provided");
-            goto out_detach;
+            goto error;
         }
         vfio_add_emulated_word(vdev, PCI_DEVICE_ID, vdev->device_id, ~0);
         trace_vfio_pci_emulated_device_id(vbasedev->name, vdev->device_id);
@@ -3166,7 +3166,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     if (vdev->sub_vendor_id != PCI_ANY_ID) {
         if (vdev->sub_vendor_id > 0xffff) {
             error_setg(errp, "invalid PCI subsystem vendor ID provided");
-            goto out_detach;
+            goto error;
         }
         vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_VENDOR_ID,
                                vdev->sub_vendor_id, ~0);
@@ -3177,7 +3177,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     if (vdev->sub_device_id != PCI_ANY_ID) {
         if (vdev->sub_device_id > 0xffff) {
             error_setg(errp, "invalid PCI subsystem device ID provided");
-            goto out_detach;
+            goto error;
         }
         vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_ID, vdev->sub_device_id, ~0);
         trace_vfio_pci_emulated_sub_device_id(vbasedev->name,
@@ -3210,7 +3210,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     vfio_msix_early_setup(vdev, &err);
     if (err) {
         error_propagate(errp, err);
-        goto out_detach;
+        goto error;
     }
 
     vfio_bars_register(vdev);
@@ -3326,8 +3326,6 @@ out_deregister:
 out_teardown:
     vfio_teardown_msi(vdev);
     vfio_bars_exit(vdev);
-out_detach:
-    vfio_detach_device(vbasedev);
 error:
     error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
 }
-- 
2.41.0


