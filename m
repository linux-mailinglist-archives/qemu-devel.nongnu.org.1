Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1837DED74
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:36:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qySBG-0004mz-K4; Thu, 02 Nov 2023 03:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qySB5-0004Xg-VC; Thu, 02 Nov 2023 03:31:43 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qySB2-0003PH-88; Thu, 02 Nov 2023 03:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698910300; x=1730446300;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hg846DZ/r6i0oF59a4jSiOSK6VqIvw8JEveZ3UP+CpQ=;
 b=ZJEqaUCCZBEzIaLonJi0s60qWLkWGCFtYdx5Tk4vcPHvcigfGznUANwn
 8cCDZEKrIPsbtvK71dnv+zfVIzv/rU3zjnUpBR3wqdaG6MlmmhJShSroV
 hdIH21E9Qr7dD/bVFXBmMX/9N8RucLloD/FTUQeGmO4yf0BpOn7CMpYl9
 cAgjBIoLFhDw6w687Pit9DXsWEawNR1nGFmn/wAgk8pXycCaV7U7dR+8g
 hrSejRRLwlUEkOEvZxZ8/chVt3G6XwxWq4DBE/sWkAvp+yCrvfCqcDuXw
 LzGtQXDNittEvXMcPM6TM3ATiW5SStAC3RxKN/ZrvtIxnv0Tg+2v3a/D5 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452953537"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="452953537"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:31:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711055802"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="711055802"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:31:06 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Thomas Huth <thuth@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:S390 general arch...)
Subject: [PATCH v4 38/41] vfio/ap: Make vfio cdev pre-openable by passing a
 file handle
Date: Thu,  2 Nov 2023 15:12:59 +0800
Message-Id: <20231102071302.1818071-39-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This gives management tools like libvirt a chance to open the vfio
cdev with privilege and pass FD to qemu. This way qemu never needs
to have privilege to open a VFIO or iommu cdev node.

Opportunisticly, remove some unnecessory double-cast.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/ap.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 6a4186ccd3..0a810f8b88 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -29,6 +29,7 @@
 #include "hw/s390x/ap-bridge.h"
 #include "exec/address-spaces.h"
 #include "qom/object.h"
+#include "monitor/monitor.h"
 
 #define TYPE_VFIO_AP_DEVICE      "vfio-ap"
 
@@ -159,7 +160,10 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
     VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
     VFIODevice *vbasedev = &vapdev->vdev;
 
-    vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
+    if (vfio_device_get_name(vbasedev, errp)) {
+        return;
+    }
+
     vbasedev->ops = &vfio_ap_ops;
     vbasedev->type = VFIO_DEVICE_TYPE_AP;
     vbasedev->dev = dev;
@@ -229,11 +233,36 @@ static const VMStateDescription vfio_ap_vmstate = {
     .unmigratable = 1,
 };
 
+static void vfio_ap_instance_init(Object *obj)
+{
+    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(obj);
+
+    vapdev->vdev.fd = -1;
+}
+
+#ifdef CONFIG_IOMMUFD
+static void vfio_ap_set_fd(Object *obj, const char *str, Error **errp)
+{
+    VFIOAPDevice *vapdev = VFIO_AP_DEVICE(obj);
+    int fd = -1;
+
+    fd = monitor_fd_param(monitor_cur(), str, errp);
+    if (fd == -1) {
+        error_prepend(errp, "Could not parse remote object fd %s:", str);
+        return;
+    }
+    vapdev->vdev.fd = fd;
+}
+#endif
+
 static void vfio_ap_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     device_class_set_props(dc, vfio_ap_properties);
+#ifdef CONFIG_IOMMUFD
+    object_class_property_add_str(klass, "fd", NULL, vfio_ap_set_fd);
+#endif
     dc->vmsd = &vfio_ap_vmstate;
     dc->desc = "VFIO-based AP device assignment";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
@@ -248,6 +277,7 @@ static const TypeInfo vfio_ap_info = {
     .name = TYPE_VFIO_AP_DEVICE,
     .parent = TYPE_AP_DEVICE,
     .instance_size = sizeof(VFIOAPDevice),
+    .instance_init = vfio_ap_instance_init,
     .class_init = vfio_ap_class_init,
 };
 
-- 
2.34.1


