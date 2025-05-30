Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC485AC8B20
	for <lists+qemu-devel@lfdr.de>; Fri, 30 May 2025 11:40:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKwCx-00085B-JZ; Fri, 30 May 2025 05:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uKwCv-00084f-Qd
 for qemu-devel@nongnu.org; Fri, 30 May 2025 05:39:21 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uKwCu-0006E7-2k
 for qemu-devel@nongnu.org; Fri, 30 May 2025 05:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748597960; x=1780133960;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=i1XoNd1NYjkM5RhjY0iY2ZkYYbdxMuGBjOnPOr0yyKQ=;
 b=gDYOGahA6QCmb6exYTbLtkdshRQtOSg9BTP8l182lmV39wWms6g9eOhr
 0YvXCbQACuyi3z9M8hcmhEghDUqUbZ1G1J3A3HcMUdSTzx9BAjW0GQzn0
 +JppyXfMTAp2xhFFA46ZDhEui7QVU7JLopIiTo1UshIE0kSAzlneIuBr9
 AQ4dXMXq/5jWuDXz17y+HN9sbzBaCONQKuBue9incqXwmpeig7odtMXIz
 18NTNLHav+WBtIaQufR2+mPibSReKOr5PUCV3B/m7oY5RHoQ4lwWhMLRp
 ipWxd20uSi4iH542OL8mI381MAI9GGUtR/7q6hI66v5SGK0tfk85XX781 A==;
X-CSE-ConnectionGUID: Dh4xVlafSoCymUcyIP+zmQ==
X-CSE-MsgGUID: YuRDJKXkSkSGpY2ubEtVsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="60942072"
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; d="scan'208";a="60942072"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2025 02:39:19 -0700
X-CSE-ConnectionGUID: DXiuxMP2RoOx0mGK2eu8zw==
X-CSE-MsgGUID: cDSMXtxzQt6imgTPhdifdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; d="scan'208";a="143788753"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.127])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2025 02:39:16 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 4/4] vfio/iommufd: Save vendor specific device info
Date: Fri, 30 May 2025 17:35:12 +0800
Message-Id: <20250530093512.3959484-5-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250530093512.3959484-1-zhenzhong.duan@intel.com>
References: <20250530093512.3959484-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Some device information returned by ioctl(IOMMU_GET_HW_INFO) are vendor
specific. Save them as raw data in a union supporting different vendors,
then vendor IOMMU can query the raw data with its fixed format for
capability directly.

Because IOMMU_GET_HW_INFO is only supported in linux, so declare those
capability related structures with CONFIG_LINUX.

Suggested-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/system/host_iommu_device.h | 11 +++++++++++
 hw/vfio/iommufd.c                  |  8 +++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/system/host_iommu_device.h b/include/system/host_iommu_device.h
index 809cced4ba..10fccc10be 100644
--- a/include/system/host_iommu_device.h
+++ b/include/system/host_iommu_device.h
@@ -14,6 +14,13 @@
 
 #include "qom/object.h"
 #include "qapi/error.h"
+#ifdef CONFIG_LINUX
+#include "linux/iommufd.h"
+
+typedef union VendorCaps {
+    struct iommu_hw_info_vtd vtd;
+    struct iommu_hw_info_arm_smmuv3 smmuv3;
+} VendorCaps;
 
 /**
  * struct HostIOMMUDeviceCaps - Define host IOMMU device capabilities.
@@ -26,7 +33,9 @@
 typedef struct HostIOMMUDeviceCaps {
     uint32_t type;
     uint64_t hw_caps;
+    VendorCaps vendor_caps;
 } HostIOMMUDeviceCaps;
+#endif
 
 #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
 OBJECT_DECLARE_TYPE(HostIOMMUDevice, HostIOMMUDeviceClass, HOST_IOMMU_DEVICE)
@@ -38,7 +47,9 @@ struct HostIOMMUDevice {
     void *agent; /* pointer to agent device, ie. VFIO or VDPA device */
     PCIBus *aliased_bus;
     int aliased_devfn;
+#ifdef CONFIG_LINUX
     HostIOMMUDeviceCaps caps;
+#endif
 };
 
 /**
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index d661737c17..fbf47cab09 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -834,16 +834,14 @@ static bool hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
     VFIODevice *vdev = opaque;
     HostIOMMUDeviceIOMMUFD *idev;
     HostIOMMUDeviceCaps *caps = &hiod->caps;
+    VendorCaps *vendor_caps = &caps->vendor_caps;
     enum iommu_hw_info_type type;
-    union {
-        struct iommu_hw_info_vtd vtd;
-    } data;
     uint64_t hw_caps;
 
     hiod->agent = opaque;
 
-    if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid,
-                                         &type, &data, sizeof(data),
+    if (!iommufd_backend_get_device_info(vdev->iommufd, vdev->devid, &type,
+                                         vendor_caps, sizeof(*vendor_caps),
                                          &hw_caps, errp)) {
         return false;
     }
-- 
2.34.1


