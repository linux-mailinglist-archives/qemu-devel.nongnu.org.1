Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A96C75004E
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 09:42:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJUSa-00066Y-V9; Wed, 12 Jul 2023 03:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJUSY-00064C-38; Wed, 12 Jul 2023 03:40:26 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJUSJ-0006oM-FF; Wed, 12 Jul 2023 03:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689147611; x=1720683611;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G7wg0WcmbnE9gP+e8jCGUoqG5OXotYKzWRcMglnD/Yg=;
 b=ZRQMiw76hDzjtMhizyyfZSASxeWiA7YFJxEwMjc++EvIzfmA2iXgScqC
 sSxuAvGznMqUl2c2xgcR79F9bd8so+XbH587loqr38b/ggcIyEWDi6GZx
 I5fD5rLa7aXQdlQsL5mewmiGmiuSHjFYptgrATwU/D6BhMVrwVkQZf37X
 Y5eZdom9QC9tZwX/FoBKheGkkzX/d0QZd9Zl6xI8M2dyJiTnA8ApV8Th2
 GzS5LEHnebc4+IhsLvCLbdT7Us8FxeLDEhC7eKWI5jZZVZvK1ZtU4PNeA
 MK/WiBuu+crwiJg0Wh6hGN/q88u9vOqDHorU2T8G22XOpFU2fa8Ph+JQu g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="430953735"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="430953735"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:39:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="835024058"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="835024058"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:39:40 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, eric.auger@redhat.com, peterx@redhat.com,
 jasonwang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org (open list:vfio-ap)
Subject: [RFC PATCH v4 13/24] vfio/ap: Use vfio_[attach/detach]_device
Date: Wed, 12 Jul 2023 15:25:17 +0800
Message-Id: <20230712072528.275577-14-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712072528.275577-1-zhenzhong.duan@intel.com>
References: <20230712072528.275577-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=zhenzhong.duan@intel.com; helo=mga07.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/ap.c | 66 +++++++---------------------------------------------
 1 file changed, 9 insertions(+), 57 deletions(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 6e21d1da5a..6ef8ce5345 100644
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
+        return;
     }
 
     vfio_ap_register_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX, &err);
@@ -227,23 +187,15 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
          */
         error_report_err(err);
     }
-
-    return;
-
-out_get_dev_err:
-    vfio_ap_put_device(vapdev);
-    vfio_put_group(vfio_group);
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
 }
 
 static Property vfio_ap_properties[] = {
-- 
2.34.1


