Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8170D7DED6F
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:36:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qySAY-0000eZ-CT; Thu, 02 Nov 2023 03:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qySAJ-0000LU-3G
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:30:58 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qySAG-0003OZ-0Y
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698910252; x=1730446252;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=r/VMm/1Z4Z01iP7zIyomy6106isBuemKDquVKatVN7I=;
 b=G+jvX6hiKAeJOxQcQx8h3+i5mdssYIIlFvRouEq4wSUmDhiwqlFdtGsr
 1cfOXzxOElHgVZGafSv7+R2RxqCc9sUwxvhof+kU8HIpWUj2nfw2HUzxO
 FfBoOZoKso0JNVUM/7ahwRv7Tk+d4YaiTWz6T3dS49evfBy81XX4eAn5y
 z8ori6ZM/Dmke6+DiWCeeFcZg0hVDQmmsAWHBedcnjbBw8ZXKv4z2hxIl
 G5ts5D1dW7ZMIjXbwGfYqeDMWeD51rtI3zaJkX6/w000GUaPyo75A0PqN
 ehpfNFky8V2ubCODFp/ObJ9sM+D/XR9ZLKVV3YXvXvLvBpLSZEWGgzd08 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452953340"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="452953340"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:30:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711055678"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="711055678"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:30:33 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 30/41] vfio/iommufd: Add support for iova_ranges
Date: Thu,  2 Nov 2023 15:12:51 +0800
Message-Id: <20231102071302.1818071-31-zhenzhong.duan@intel.com>
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

Some vIOMMU such as virtio-iommu use iova ranges from host side to
setup reserved ranges for passthrough device, so that guest will not
use an iova range beyond host support.

Use an uAPI of IOMMUFD to get iova ranges of host side and pass to
vIOMMU just like the legacy backend.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
v4: fix build error in 32bit fedora

 hw/vfio/iommufd.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 1bb55ca2c4..22f02f92a9 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -341,6 +341,52 @@ static int iommufd_ram_block_discard_disable(bool state)
     return ram_block_uncoordinated_discard_disable(state);
 }
 
+static int vfio_get_info_iova_range(VFIOIOMMUFDContainer *container,
+                                    uint32_t ioas_id)
+{
+    VFIOContainerBase *bcontainer = &container->bcontainer;
+    struct iommu_ioas_iova_ranges *info;
+    struct iommu_iova_range *iova_ranges;
+    int ret, sz, fd = container->be->fd;
+
+    info = g_malloc0(sizeof(*info));
+    info->size = sizeof(*info);
+    info->ioas_id = ioas_id;
+
+    ret = ioctl(fd, IOMMU_IOAS_IOVA_RANGES, info);
+    if (ret && errno != EMSGSIZE) {
+        goto error;
+    }
+
+    sz = info->num_iovas * sizeof(struct iommu_iova_range);
+    info = g_realloc(info, sizeof(*info) + sz);
+    info->allowed_iovas = (uintptr_t)(info + 1);
+
+    ret = ioctl(fd, IOMMU_IOAS_IOVA_RANGES, info);
+    if (ret) {
+        goto error;
+    }
+
+    iova_ranges = (struct iommu_iova_range *)info->allowed_iovas;
+
+    for (int i = 0; i < info->num_iovas; i++) {
+        Range *range = g_new(Range, 1);
+
+        range_set_bounds(range, iova_ranges[i].start, iova_ranges[i].last);
+        bcontainer->iova_ranges =
+            range_list_insert(bcontainer->iova_ranges, range);
+    }
+
+    g_free(info);
+    return 0;
+
+error:
+    ret = -errno;
+    g_free(info);
+    error_report("vfio/iommufd: Cannot get iova ranges: %m");
+    return ret;
+}
+
 static int iommufd_attach_device(const char *name, VFIODevice *vbasedev,
                                  AddressSpace *as, Error **errp)
 {
@@ -418,6 +464,7 @@ static int iommufd_attach_device(const char *name, VFIODevice *vbasedev,
     }
 
     bcontainer->pgsizes = qemu_real_host_page_size();
+    vfio_get_info_iova_range(container, ioas_id);
 
     bcontainer->listener = vfio_memory_listener;
     memory_listener_register(&bcontainer->listener, bcontainer->space->as);
-- 
2.34.1


