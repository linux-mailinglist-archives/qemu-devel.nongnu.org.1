Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9608E7CD888
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 11:50:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt38N-0001Du-C3; Wed, 18 Oct 2023 05:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt37w-0000PY-Df
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:46:14 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt37t-0003UD-G6
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:46:08 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S9Qvv2cQZz4xbg;
 Wed, 18 Oct 2023 20:46:03 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9Qvr6Br5z4xbC;
 Wed, 18 Oct 2023 20:46:00 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/22] vfio/ap: Use vfio_[attach/detach]_device
Date: Wed, 18 Oct 2023 11:45:18 +0200
Message-ID: <20231018094531.733211-10-clg@redhat.com>
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

Let the vfio-ap device use vfio_attach_device() and
vfio_detach_device(), hence hiding the details of the used
IOMMU backend.

We take the opportunity to use g_path_get_basename() which
is prefered, as suggested by
3e015d815b ("use g_path_get_basename instead of basename")

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/ap.c | 67 ++++++++++------------------------------------------
 1 file changed, 13 insertions(+), 54 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 6e21d1da5a7090a6b9c77485d67e8eabc261438f..f870f51ffab4a637d2472db4fe4141ec7c54a470 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -53,40 +53,6 @@ struct VFIODeviceOps vfio_ap_ops = {
     .vfio_compute_needs_reset = vfio_ap_compute_needs_reset,
 };
 
-static void vfio_ap_put_device(VFIOAPDevice *vapdev)
-{
-    g_free(vapdev->vdev.name);
-    vfio_put_base_device(&vapdev->vdev);
-}
-
-static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vapdev, Error **errp)
-{
-    GError *gerror = NULL;
-    char *symlink, *group_path;
-    int groupid;
-
-    symlink = g_strdup_printf("%s/iommu_group", vapdev->vdev.sysfsdev);
-    group_path = g_file_read_link(symlink, &gerror);
-    g_free(symlink);
-
-    if (!group_path) {
-        error_setg(errp, "%s: no iommu_group found for %s: %s",
-                   TYPE_VFIO_AP_DEVICE, vapdev->vdev.sysfsdev, gerror->message);
-        g_error_free(gerror);
-        return NULL;
-    }
-
-    if (sscanf(basename(group_path), "%d", &groupid) != 1) {
-        error_setg(errp, "vfio: failed to read %s", group_path);
-        g_free(group_path);
-        return NULL;
-    }
-
-    g_free(group_path);
-
-    return vfio_get_group(groupid, &address_space_memory, errp);
-}
-
 static void vfio_ap_req_notifier_handler(void *opaque)
 {
     VFIOAPDevice *vapdev = opaque;
@@ -189,22 +155,15 @@ static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
 static void vfio_ap_realize(DeviceState *dev, Error **errp)
 {
     int ret;
-    char *mdevid;
     Error *err = NULL;
-    VFIOGroup *vfio_group;
     APDevice *apdev = AP_DEVICE(dev);
     VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
+    VFIODevice *vbasedev = &vapdev->vdev;
 
-    vfio_group = vfio_ap_get_group(vapdev, errp);
-    if (!vfio_group) {
-        return;
-    }
-
-    vapdev->vdev.ops = &vfio_ap_ops;
-    vapdev->vdev.type = VFIO_DEVICE_TYPE_AP;
-    mdevid = basename(vapdev->vdev.sysfsdev);
-    vapdev->vdev.name = g_strdup_printf("%s", mdevid);
-    vapdev->vdev.dev = dev;
+    vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
+    vbasedev->ops = &vfio_ap_ops;
+    vbasedev->type = VFIO_DEVICE_TYPE_AP;
+    vbasedev->dev = dev;
 
     /*
      * vfio-ap devices operate in a way compatible with discarding of
@@ -214,9 +173,10 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
      */
     vapdev->vdev.ram_block_discard_allowed = true;
 
-    ret = vfio_get_device(vfio_group, mdevid, &vapdev->vdev, errp);
+    ret = vfio_attach_device(vbasedev->name, vbasedev,
+                             &address_space_memory, errp);
     if (ret) {
-        goto out_get_dev_err;
+        goto error;
     }
 
     vfio_ap_register_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX, &err);
@@ -230,20 +190,19 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
 
     return;
 
-out_get_dev_err:
-    vfio_ap_put_device(vapdev);
-    vfio_put_group(vfio_group);
+error:
+    error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
+    g_free(vbasedev->name);
 }
 
 static void vfio_ap_unrealize(DeviceState *dev)
 {
     APDevice *apdev = AP_DEVICE(dev);
     VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
-    VFIOGroup *group = vapdev->vdev.group;
 
     vfio_ap_unregister_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX);
-    vfio_ap_put_device(vapdev);
-    vfio_put_group(group);
+    vfio_detach_device(&vapdev->vdev);
+    g_free(vapdev->vdev.name);
 }
 
 static Property vfio_ap_properties[] = {
-- 
2.41.0


