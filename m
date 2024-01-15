Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC1582D788
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:40:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPKNn-0000fJ-4m; Mon, 15 Jan 2024 05:39:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKNk-0000f3-GT
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:39:52 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKNi-0002kC-TF
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:39:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705315191; x=1736851191;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=E8nl8QWoRgG2/jDdglZ/k5bjSREUF3iMIVNY6f/l+ik=;
 b=UQyAZKFDVzDGywyBYQpDJrtKilM7erv3C9ubWXj8vB4cXX0icvq/OmWz
 gNOI8MvqNFyNVnO0q9jX/EdRc05F5jJvcp+NLBZrjCtYLtI3wtGEaTXlZ
 tJKx2m9VJVStpqabRbBT2h5S/tiWz/WC1NNJSkXYHECCr9+kYVh4wVpVI
 RAiZ5vbG5MS6iJCPkkbVykksEJiherna8c/OYcaQq0BGQVRl4gole62a3
 CjqTKXCp0GcSVNkach3VaogDyWCJ2Et/dT2j2RshZoMn+lPThcITWKTfg
 F3mx7PfEtBhcew3u6IvTu/MGID70tS9JfPirTt1Da68xjgOzmVWjYuftm Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="13067484"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="13067484"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:39:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="874065322"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="874065322"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:39:45 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH rfcv1 04/23] vfio: implement IOMMUFDDevice interface callbacks
Date: Mon, 15 Jan 2024 18:37:16 +0800
Message-Id: <20240115103735.132209-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115103735.132209-1-zhenzhong.duan@intel.com>
References: <20240115103735.132209-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Implement IOMMUFDDevice interface callbacks attach_hwpt/detach_hwpt
for vIOMMU usage. vIOMMU utilizes them to attach to or detach from
hwpt on host side.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/iommufd.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 1b174b71ee..c8c669c59a 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -26,6 +26,8 @@
 #include "qemu/chardev_open.h"
 #include "pci.h"
 
+static IOMMUFDDeviceOps vfio_iommufd_device_ops;
+
 static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly)
 {
@@ -430,7 +432,7 @@ found_container:
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
 
     iommufd_device_init(idev, sizeof(*idev), container->be, vbasedev->devid,
-                        NULL);
+                        &vfio_iommufd_device_ops);
     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
                                    vbasedev->num_regions, vbasedev->flags);
     return 0;
@@ -642,3 +644,35 @@ static const TypeInfo types[] = {
 };
 
 DEFINE_TYPES(types)
+
+static int vfio_iommufd_device_attach_hwpt(IOMMUFDDevice *idev,
+                                           uint32_t hwpt_id)
+{
+    VFIODevice *vbasedev = container_of(idev, VFIODevice, idev);
+    Error *err = NULL;
+    int ret;
+
+    ret = iommufd_cdev_attach_ioas_hwpt(vbasedev, hwpt_id, &err);
+    if (err) {
+        error_report_err(err);
+    }
+    return ret;
+}
+
+static int vfio_iommufd_device_detach_hwpt(IOMMUFDDevice *idev)
+{
+    VFIODevice *vbasedev = container_of(idev, VFIODevice, idev);
+    Error *err = NULL;
+    int ret;
+
+    ret = iommufd_cdev_detach_ioas_hwpt(vbasedev, &err);
+    if (err) {
+        error_report_err(err);
+    }
+    return ret;
+}
+
+static IOMMUFDDeviceOps vfio_iommufd_device_ops = {
+    .attach_hwpt = vfio_iommufd_device_attach_hwpt,
+    .detach_hwpt = vfio_iommufd_device_detach_hwpt,
+};
-- 
2.34.1


