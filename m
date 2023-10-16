Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3ED7CA270
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:49:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJIN-00062p-9B; Mon, 16 Oct 2023 04:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJIF-0005Tw-GH; Mon, 16 Oct 2023 04:49:45 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJID-0001HS-Pv; Mon, 16 Oct 2023 04:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697446181; x=1728982181;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=p2MFIpHYT4awebGkY68CJ2k7+kXfIV8jtABCfQUYiRo=;
 b=AdZbB/4HjZwvYNUv3TF1a7PUcsBZmyBB2jJNRo6SRZtLn8VAxerDzbww
 dO1HzvytsS18n1cWynk3uI8xZmJUh1PBa78dPKfl1AVW/xKyI0Aahbm1K
 NsJlYjUCdclDCTmbW+BVSqDFYBv2OCbw1Oj6yuCSvyZD7ubp2HC8S1FSn
 /VvqtmGUjy+v3ayA+PETWOduwf9fsYOKWOCnanOyrdPrBYFxpSPTN4vwq
 xwrcE7+1QQe2X58ryVwYFn0tNDdGbz37phud5JNqADMTdTTu+HfB2gVmb
 NfRSvH7xoicAkWZXYNRUeQ8L0+W9Q6TvpX4QUaRA0RA6k1XIdWYUU6VQt Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365737766"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="365737766"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:49:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="749223099"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="749223099"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:49:12 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:S390 general arch...)
Subject: [PATCH v2 27/27] vfio/ccw: Make vfio cdev pre-openable by passing a
 file handle
Date: Mon, 16 Oct 2023 16:32:23 +0800
Message-Id: <20231016083223.1519410-28-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
References: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.151;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index c7f8e70783..f151652bc2 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -31,6 +31,7 @@
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
+#include "monitor/monitor.h"
 
 struct VFIOCCWDevice {
     S390CCWDevice cdev;
@@ -590,11 +591,12 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
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
@@ -691,12 +693,37 @@ static const VMStateDescription vfio_ccw_vmstate = {
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
@@ -714,6 +741,7 @@ static const TypeInfo vfio_ccw_info = {
     .name = TYPE_VFIO_CCW,
     .parent = TYPE_S390_CCW,
     .instance_size = sizeof(VFIOCCWDevice),
+    .instance_init = vfio_ccw_instance_init,
     .class_init = vfio_ccw_class_init,
 };
 
-- 
2.34.1


