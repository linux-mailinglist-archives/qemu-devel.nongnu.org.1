Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 264047F27E0
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 09:47:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5MPp-0006n3-Qw; Tue, 21 Nov 2023 03:47:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MPn-0006dM-Aw
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:47:27 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MPl-0001gM-CP
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700556445; x=1732092445;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UPAOUojblgTst9HnU7B0CVXxHRF8+Gvxw59jZTn4acM=;
 b=OkCk3Y2ntQ9K0KYhLL8UD0j7VXf6tn6w/8t1nKNE8AXQm1dTBJx2bjmX
 geweHB2rscPZwmWbPRTvnd/htKzukr04bHXdgiid1914OSof4sSv0OpkM
 qL0EtJZPPU9/nWcZET96D3o2FxDmYAl1mR/sRpNNWcrmVWiueOTEZApII
 kjGNRCQUlmSenxOKgY7DSH4AkdCoAp2GmxiCwZ+5dEGqcuvcpiKxYOL/O
 pW39e2JiVTzMOJPeY1uLcCgkYX3Pq6ozgmZIDKg/yHbXVQwxii68UZvH6
 TPqi81u2HiJMNAjB5t+bZQFK4gBThSiaEVrpS644/lpgMKpL0f/5Q5WcL g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="395722188"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="395722188"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:47:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="884125001"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="884125001"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:47:18 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com
Subject: [PATCH v7 15/27] vfio/ap: Make vfio cdev pre-openable by passing a
 file handle
Date: Tue, 21 Nov 2023 16:44:14 +0800
Message-Id: <20231121084426.1286987-16-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
References: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/ap.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 80629609ae..f180e4a32a 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -160,7 +160,10 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
     VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
     VFIODevice *vbasedev = &vapdev->vdev;
 
-    vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
+    if (vfio_device_get_name(vbasedev, errp) < 0) {
+        return;
+    }
+
     vbasedev->ops = &vfio_ap_ops;
     vbasedev->type = VFIO_DEVICE_TYPE_AP;
     vbasedev->dev = dev;
@@ -230,11 +233,28 @@ static const VMStateDescription vfio_ap_vmstate = {
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
+    vfio_device_set_fd(&VFIO_AP_DEVICE(obj)->vdev, str, errp);
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
@@ -249,6 +269,7 @@ static const TypeInfo vfio_ap_info = {
     .name = TYPE_VFIO_AP_DEVICE,
     .parent = TYPE_AP_DEVICE,
     .instance_size = sizeof(VFIOAPDevice),
+    .instance_init = vfio_ap_instance_init,
     .class_init = vfio_ap_class_init,
 };
 
-- 
2.34.1


