Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA897EAE02
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 11:27:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2qdF-00050m-7J; Tue, 14 Nov 2023 05:26:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2qd6-0004qd-UJ; Tue, 14 Nov 2023 05:26:49 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2qd5-0007jy-66; Tue, 14 Nov 2023 05:26:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699957607; x=1731493607;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=h0N6dMvADyhsNgYhey+/oMoYyxQcRLQ6VpbtvN+bcFI=;
 b=aXYIFN6pENiSDptBb9q/KNIYDvkhq6Ez9JGfgrcfFaen3UQfq1GztCDP
 EbIZZWT9KYSg67pGx8j2AlhuOjwFksOVmxZBk7hisEQsjQrpSelda1uJS
 xA44mlFVITZ1h409UioDww8VV19GCA8nOM7bH0IDJVbcAgzXcYSmu8vf0
 AH/tiwoo7NdECuh5rOt+LGkJUPA6+csNNj9tN8KsPEFhAGZ8qsoki2ylL
 kLKTMSCPMNnFEIkgfOSj/7v1Dz0W0RbTtjYwP8rmGmPq6i/BRmYh9Ea4K
 LiQT37Jp8apvDQC8Gm00I0UJy3r8SMNYlRFk5YHiNrkJRSg3Va+XhtpPJ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="394543683"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; d="scan'208";a="394543683"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 02:26:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="888213186"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; d="scan'208";a="888213186"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 02:26:40 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org (open list:vfio-ccw)
Subject: [PATCH v6 17/21] vfio/ccw: Make vfio cdev pre-openable by passing a
 file handle
Date: Tue, 14 Nov 2023 18:09:51 +0800
Message-Id: <20231114100955.1961974-18-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65;
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
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 hw/vfio/ccw.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index d2d58bb677..b116b10fe7 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -590,11 +590,12 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
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
@@ -691,12 +692,29 @@ static const VMStateDescription vfio_ccw_vmstate = {
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
+    vfio_device_set_fd(&VFIO_CCW(obj)->vdev, str, errp);
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
@@ -714,6 +732,7 @@ static const TypeInfo vfio_ccw_info = {
     .name = TYPE_VFIO_CCW,
     .parent = TYPE_S390_CCW,
     .instance_size = sizeof(VFIOCCWDevice),
+    .instance_init = vfio_ccw_instance_init,
     .class_init = vfio_ccw_class_init,
 };
 
-- 
2.34.1


