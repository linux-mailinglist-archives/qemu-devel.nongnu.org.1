Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D39568B51C7
	for <lists+qemu-devel@lfdr.de>; Mon, 29 Apr 2024 08:54:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Ktk-0001jI-0e; Mon, 29 Apr 2024 02:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1Ktf-0001i1-Hb
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:53:55 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s1Ktd-0007m1-Px
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 02:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714373634; x=1745909634;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YlBWPY+nZvenxvE2K0yAhC5S7Ucg9G5VHHQ4uysEptc=;
 b=lhrCszpfJBH/GYlONyoWeFkoSxDtzaltIhQDyEyChtXD/by1GVkHyR/O
 Y3Fkl9WhaaOLtDBWFXzVKtFWI/UgHR84gk/6zcmHDLMJP064+6c8NCXnu
 ObDocw/eTrWCjPaBQQpsBguygQn4m/4JgeQ97h5CoxcHdlnTjIuJU696+
 0ZoiOd5KgmbSSA+Dd6tm2K/lyM5HIvRqFMEn88UsYySoLB/7eyOIhmBER
 9viFBIIMYGaCdJiSuJuAotPd0lGNtQKEK+Is3IfEi1PaX7IucPGk1HOd7
 kX8wht35sbXs16ZcIhqruzupBRBtC/+NIT91wp7vgo4nP3/k+xGUokIaZ w==;
X-CSE-ConnectionGUID: ubYAO+Q+Ta6+LoptP+EF3A==
X-CSE-MsgGUID: pPCiCI1ZTv+4huGMIie6Vw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10560705"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="10560705"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:53:53 -0700
X-CSE-ConnectionGUID: Od34pW10QSe0Ic4IZLXMCw==
X-CSE-MsgGUID: GiRo1UPxTuGj0HZS+otJgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; d="scan'208";a="63488058"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2024 23:53:50 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH v3 08/19] backends/iommufd: Introduce helper function
 iommufd_backend_get_device_info()
Date: Mon, 29 Apr 2024 14:50:35 +0800
Message-Id: <20240429065046.3688701-9-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
References: <20240429065046.3688701-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.114,
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

Introduce a helper function iommufd_backend_get_device_info() to get
host IOMMU related information through iommufd uAPI.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/sysemu/iommufd.h |  4 ++++
 backends/iommufd.c       | 24 +++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
index 6a9fb0007a..e9593637a3 100644
--- a/include/sysemu/iommufd.h
+++ b/include/sysemu/iommufd.h
@@ -17,6 +17,7 @@
 #include "qom/object.h"
 #include "exec/hwaddr.h"
 #include "exec/cpu-common.h"
+#include <linux/iommufd.h>
 #include "sysemu/host_iommu_device.h"
 
 #define TYPE_IOMMUFD_BACKEND "iommufd"
@@ -47,6 +48,9 @@ int iommufd_backend_map_dma(IOMMUFDBackend *be, uint32_t ioas_id, hwaddr iova,
                             ram_addr_t size, void *vaddr, bool readonly);
 int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
                               hwaddr iova, ram_addr_t size);
+int iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
+                                    enum iommu_hw_info_type *type,
+                                    void *data, uint32_t len, Error **errp);
 
 #define TYPE_HOST_IOMMU_DEVICE_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
 OBJECT_DECLARE_TYPE(HostIOMMUDeviceIOMMUFD, HostIOMMUDeviceIOMMUFDClass,
diff --git a/backends/iommufd.c b/backends/iommufd.c
index 19e46194a2..d61209788a 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -19,7 +19,6 @@
 #include "monitor/monitor.h"
 #include "trace.h"
 #include <sys/ioctl.h>
-#include <linux/iommufd.h>
 
 static void iommufd_backend_init(Object *obj)
 {
@@ -211,6 +210,29 @@ int iommufd_backend_unmap_dma(IOMMUFDBackend *be, uint32_t ioas_id,
     return ret;
 }
 
+int iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
+                                    enum iommu_hw_info_type *type,
+                                    void *data, uint32_t len, Error **errp)
+{
+    struct iommu_hw_info info = {
+        .size = sizeof(info),
+        .dev_id = devid,
+        .data_len = len,
+        .data_uptr = (uintptr_t)data,
+    };
+    int ret;
+
+    ret = ioctl(be->fd, IOMMU_GET_HW_INFO, &info);
+    if (ret) {
+        error_setg_errno(errp, errno, "Failed to get hardware info");
+    } else {
+        g_assert(type);
+        *type = info.out_data_type;
+    }
+
+    return ret;
+}
+
 static const TypeInfo types[] = {
     {
         .name = TYPE_IOMMUFD_BACKEND,
-- 
2.34.1


