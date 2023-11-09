Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 891357E6A49
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 13:04:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r13kG-0003WC-G9; Thu, 09 Nov 2023 07:02:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r13jw-0002vb-A3; Thu, 09 Nov 2023 07:02:30 -0500
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r13jr-0001gn-AR; Thu, 09 Nov 2023 07:02:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699531343; x=1731067343;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7Ez0M1oR2fWQDobXTGrl0gUtV27AvdRtURYRtUsmTqE=;
 b=GOWuli5KJfawQzp3BNZnpQg0DaDWig1sx4ICNWgwCkCqIyDCDbGp2xC4
 T+UmuGADVWz6dADEb6g4JJVeaUn3Aq2wjmHtp9BlwU1iU4mXSJM3Qt1/c
 FIluyE1W/8OjRgLato5nb3iISBs8jY2J/S/IgNE+VPm/JtoIt+u5epbMt
 YUjB99G1o0cvev3nTD3ndTLWAqr14Jkct+lgK53cNfwuafRxtpIwppx+n
 PeX32BGn6CHNNEboShDval4hc5NRwKO8E5N1KN7eC/fNz0cFkzFwcvnte
 4Ss5V2G0s5JKCwxkhC0m/7FjBVsv94e7hbEVbu66zn6V5dMeFwnZDBvlL Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="369305894"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; d="scan'208";a="369305894"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 04:01:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; d="scan'208";a="11516205"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 04:01:55 -0800
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
Subject: [PATCH v5 16/20] vfio/ccw: Make vfio cdev pre-openable by passing a
 file handle
Date: Thu,  9 Nov 2023 19:45:25 +0800
Message-Id: <20231109114529.1904193-17-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
References: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/ccw.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index d2d58bb677..a566aad404 100644
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


