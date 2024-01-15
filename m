Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 885A682D789
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:40:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPKNj-0000ek-DE; Mon, 15 Jan 2024 05:39:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKNg-0000ea-R3
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:39:49 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKNf-0002kC-5H
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:39:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705315187; x=1736851187;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CpVZAHI8xoxlAfinekUHSCH11i1K//4shVWNcQ5H+gA=;
 b=gQ+fxVkuYrBFVOir3iLQ7cBZQ49yoiSwuh3pniLbfLgNVuAj7XpgFgDc
 H8kN9xaC1dQcGWIXC+X8Z08PR6MlxErVKUAC3tvX0gOOfLLGYTnofems0
 Xr6RsP7bUXxusU9iISwMcoOPdjM9UnhXpcxVDrcw6gb/lozS+9HfZMVWy
 Cg8UJk7xnqpLJY5iSLrPhCAdGl/Xxf7OFYTry4wr/dol2t/PpFuJhlmkR
 bCX6uOlYfXZbqyDHpgK5zDzVFcOdP6UPWS3SekW6swfsJ6JRc5mU59nyF
 qbPOgk/la8c9lhLhKHQT53IJAETN6vo7DzPimBESzuexEmwxz++cjYnFL w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="13067468"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="13067468"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:39:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="874065318"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="874065318"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:39:41 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH rfcv1 03/23] backends/iommufd_device: introduce IOMMUFDDevice
 targeted interface
Date: Mon, 15 Jan 2024 18:37:15 +0800
Message-Id: <20240115103735.132209-4-zhenzhong.duan@intel.com>
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

With IOMMUFDDevice passed to vIOMMU, we can query hw IOMMU information
and allocate hwpt for a device, but still need an extensible interface
for vIOMMU usage.

This introduces an IOMMUFDDevice targeted interface for vIOMMU.
Currently this interface includes two callbacks attach_hwpt/detach_hwpt
for vIOMMU to attach to or detach from hwpt on host side.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/sysemu/iommufd_device.h | 11 ++++++++++-
 backends/iommufd_device.c       | 16 +++++++++++++++-
 hw/vfio/iommufd.c               |  3 ++-
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/iommufd_device.h b/include/sysemu/iommufd_device.h
index 795630324b..799c1345fd 100644
--- a/include/sysemu/iommufd_device.h
+++ b/include/sysemu/iommufd_device.h
@@ -17,15 +17,24 @@
 
 typedef struct IOMMUFDDevice IOMMUFDDevice;
 
+typedef struct IOMMUFDDeviceOps {
+    int (*attach_hwpt)(IOMMUFDDevice *idev, uint32_t hwpt_id);
+    int (*detach_hwpt)(IOMMUFDDevice *idev);
+} IOMMUFDDeviceOps;
+
 /* This is an abstraction of host IOMMUFD device */
 struct IOMMUFDDevice {
     IOMMUFDBackend *iommufd;
     uint32_t dev_id;
+    IOMMUFDDeviceOps *ops;
 };
 
+int iommufd_device_attach_hwpt(IOMMUFDDevice *idev, uint32_t hwpt_id);
+int iommufd_device_detach_hwpt(IOMMUFDDevice *idev);
 int iommufd_device_get_info(IOMMUFDDevice *idev,
                             enum iommu_hw_info_type *type,
                             uint32_t len, void *data);
 void iommufd_device_init(void *_idev, size_t instance_size,
-                         IOMMUFDBackend *iommufd, uint32_t dev_id);
+                         IOMMUFDBackend *iommufd, uint32_t dev_id,
+                         IOMMUFDDeviceOps *ops);
 #endif
diff --git a/backends/iommufd_device.c b/backends/iommufd_device.c
index f6e7ca1dbf..26f69252d2 100644
--- a/backends/iommufd_device.c
+++ b/backends/iommufd_device.c
@@ -14,6 +14,18 @@
 #include "qemu/error-report.h"
 #include "sysemu/iommufd_device.h"
 
+int iommufd_device_attach_hwpt(IOMMUFDDevice *idev, uint32_t hwpt_id)
+{
+    g_assert(idev->ops->attach_hwpt);
+    return idev->ops->attach_hwpt(idev, hwpt_id);
+}
+
+int iommufd_device_detach_hwpt(IOMMUFDDevice *idev)
+{
+    g_assert(idev->ops->detach_hwpt);
+    return idev->ops->detach_hwpt(idev);
+}
+
 int iommufd_device_get_info(IOMMUFDDevice *idev,
                             enum iommu_hw_info_type *type,
                             uint32_t len, void *data)
@@ -39,7 +51,8 @@ int iommufd_device_get_info(IOMMUFDDevice *idev,
 }
 
 void iommufd_device_init(void *_idev, size_t instance_size,
-                         IOMMUFDBackend *iommufd, uint32_t dev_id)
+                         IOMMUFDBackend *iommufd, uint32_t dev_id,
+                         IOMMUFDDeviceOps *ops)
 {
     IOMMUFDDevice *idev = (IOMMUFDDevice *)_idev;
 
@@ -47,4 +60,5 @@ void iommufd_device_init(void *_idev, size_t instance_size,
 
     idev->iommufd = iommufd;
     idev->dev_id = dev_id;
+    idev->ops = ops;
 }
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index cbd035f148..1b174b71ee 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -429,7 +429,8 @@ found_container:
     QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
     QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
 
-    iommufd_device_init(idev, sizeof(*idev), container->be, vbasedev->devid);
+    iommufd_device_init(idev, sizeof(*idev), container->be, vbasedev->devid,
+                        NULL);
     trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
                                    vbasedev->num_regions, vbasedev->flags);
     return 0;
-- 
2.34.1


