Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A956D7C5E0E
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 22:11:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqfWn-0006tm-1h; Wed, 11 Oct 2023 16:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qqfWk-0006tJ-QE
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:09:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qqfWe-0005az-Qh
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697054987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3BS/fc804UiXsm3wpdaigwvteR9Jg7tc0CoVQptAzpM=;
 b=O3awGVE8hqdM1ZvtvVGblc/bES0x0wT1oFZHvSWMtvJxv5vB2kskMJfey+Q9iJbMiQYxc5
 hgP2EDiIDAs084/biivYq2prXhKLoavMp9R6peNUkroPHgJdbZR7nF3v61mH5qmAgbpBY0
 L8/PV2INVLcpbyoR1s3DQIuBSFedMr0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-439--0Ofx3xsMQ65n1O4u9V2ng-1; Wed, 11 Oct 2023 16:09:43 -0400
X-MC-Unique: -0Ofx3xsMQ65n1O4u9V2ng-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7BE6E2825EB6;
 Wed, 11 Oct 2023 20:09:43 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0C1A901;
 Wed, 11 Oct 2023 20:09:41 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, clg@redhat.com, zhenzhong.duan@intel.com,
 yi.l.liu@intel.com, yanghliu@redhat.com
Subject: [PATCH] vfio/pci: Remove vfio_detach_device from vfio_realize error
 path
Date: Wed, 11 Oct 2023 22:09:34 +0200
Message-ID: <20231011200934.549735-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

---

This applies on top of vfio-next

Note I am not sure the SHA1 of
vfio/pci: Introduce vfio_[attach/detach]_device
is stable.
---
 hw/vfio/pci.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 40ae46266e..6e3f6aba28 100644
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


