Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8B77DED79
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:37:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qySBN-0005II-GT; Thu, 02 Nov 2023 03:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qySB9-0004n6-I3; Thu, 02 Nov 2023 03:31:50 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qySB6-0003Ox-AX; Thu, 02 Nov 2023 03:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698910304; x=1730446304;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jfdiZ9n2PNbWWNnBELCHU65fEvg1lmnCoImg81PrcFc=;
 b=bTOhYTNYNEf18oS2OCkGM9BDzPmRvK+UjfEEUXlaCV5mJkEkz1M5wq36
 RHXUPqDBvA3nSfDNSHC9q1AdhETdp2f8hTKCNCNRRPUXf1NhtmVWO2rnp
 p5uoxQcwRU1s9BF9/v+6Fg3ZaZNCd70znRRlKDKmKeN2bHOizJqs5GGT4
 gG5/D42YsNqp9Elzu260IhZug8z8hG8XgcinxV/OU4qhK7oAYAT9aSE/I
 kBwAi1w24U812laiy66eSk/1pI3V+MEUA9Ne9CfPh4j27dF5kvuggiDfU
 BYSwwFSW3Cn+b9WIK3CdbDIcus462mppTpDZ4p8nVOfF0sLNKTFaO6MIZ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452953550"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="452953550"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:31:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711055820"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="711055820"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:31:11 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org (open list:vfio-ccw)
Subject: [PATCH v4 39/41] vfio/ccw: Make vfio cdev pre-openable by passing a
 file handle
Date: Thu,  2 Nov 2023 15:13:00 +0800
Message-Id: <20231102071302.1818071-40-zhenzhong.duan@intel.com>
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

Opportunisticly, remove a redundant definition of TYPE_VFIO_CCW.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/ccw.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 7695ede0fc..a674bd8d6d 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -30,6 +30,7 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
+#include "monitor/monitor.h"
 
 struct VFIOCCWDevice {
     S390CCWDevice cdev;
@@ -589,11 +590,12 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    if (vfio_device_get_name(vbasedev, errp)) {
+        return;
+    }
+
     vbasedev->ops = &vfio_ccw_ops;
     vbasedev->type = VFIO_DEVICE_TYPE_CCW;
-    vbasedev->name = g_strdup_printf("%x.%x.%04x", vcdev->cdev.hostid.cssid,
-                           vcdev->cdev.hostid.ssid,
-                           vcdev->cdev.hostid.devid);
     vbasedev->dev = dev;
 
     /*
@@ -690,12 +692,37 @@ static const VMStateDescription vfio_ccw_vmstate = {
     .unmigratable = 1,
 };
 
+static void vfio_ccw_instance_init(Object *obj)
+{
+    VFIOCCWDevice *vcdev = VFIO_CCW(obj);
+
+    vcdev->vdev.fd = -1;
+}
+
+#ifdef CONFIG_IOMMUFD
+static void vfio_ccw_set_fd(Object *obj, const char *str, Error **errp)
+{
+    VFIOCCWDevice *vcdev = VFIO_CCW(obj);
+    int fd = -1;
+
+    fd = monitor_fd_param(monitor_cur(), str, errp);
+    if (fd == -1) {
+        error_prepend(errp, "Could not parse remote object fd %s:", str);
+        return;
+    }
+    vcdev->vdev.fd = fd;
+}
+#endif
+
 static void vfio_ccw_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_CLASS(klass);
 
     device_class_set_props(dc, vfio_ccw_properties);
+#ifdef CONFIG_IOMMUFD
+    object_class_property_add_str(klass, "fd", NULL, vfio_ccw_set_fd);
+#endif
     dc->vmsd = &vfio_ccw_vmstate;
     dc->desc = "VFIO-based subchannel assignment";
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
@@ -713,6 +740,7 @@ static const TypeInfo vfio_ccw_info = {
     .name = TYPE_VFIO_CCW,
     .parent = TYPE_S390_CCW,
     .instance_size = sizeof(VFIOCCWDevice),
+    .instance_init = vfio_ccw_instance_init,
     .class_init = vfio_ccw_class_init,
 };
 
-- 
2.34.1


