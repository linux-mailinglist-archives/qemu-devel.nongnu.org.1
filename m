Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF697E6A39
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 13:02:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r13iw-0001re-Jn; Thu, 09 Nov 2023 07:01:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r13it-0001rB-5w
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:01:23 -0500
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r13iq-0001a4-MW
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699531280; x=1731067280;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rytyz8Fzz3g/DCRqLnp/ASJ9aH0+cH73LB9Px/8LGu4=;
 b=E1UvGKgmOnGtgwi96vBQywdvxVntLio7rBuKGuRlcL2B4obcAT9orP2A
 2gLbWLMi0NlkMpZ+P9S5ZWbg5r2ZA7q1p7LeKM7OHGgTrus42kJcQa6+Q
 Lj3K1Nmy6xrN/yEaakijsl5qlnOdr4eL2NOKOymfuFCa0sPIxRCg3HRCW
 d5V/9i1/yYf7u16JwgQ7FrVWQCOWLggat7jpk+kSafEmf+7j2WEi+F/0n
 8wMYFlHj/wfVvshuXHn0wUOhyj9flgG9o1faIgcRXmgT7SFaiwriiFFJV
 FpVKGDeBN0atvAA6IN3zZOp56hic25e43GPzjhu4rNHxdV5O4lBPfv0oq A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="369305366"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; d="scan'208";a="369305366"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 04:01:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; d="scan'208";a="11515624"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 04:01:12 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 05/20] vfio/iommufd: Add support for iova_ranges and pgsizes
Date: Thu,  9 Nov 2023 19:45:14 +0800
Message-Id: <20231109114529.1904193-6-zhenzhong.duan@intel.com>
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

Some vIOMMU such as virtio-iommu use iova ranges from host side to
setup reserved ranges for passthrough device, so that guest will not
use an iova range beyond host support.

Use an uAPI of IOMMUFD to get iova ranges of host side and pass to
vIOMMU just like the legacy backend.

Also use out_iova_alignment returned from uAPI as pgsizes instead of
qemu_real_host_page_size() as a fallback.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
v5: Add missed pgsizes initialization in vfio_get_info_iova_range

 hw/vfio/iommufd.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index ea4e23f4ec..958c3e794f 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -267,6 +267,53 @@ static int iommufd_ram_block_discard_disable(bool state)
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
+    iova_ranges = (struct iommu_iova_range *)(uintptr_t)info->allowed_iovas;
+
+    for (int i = 0; i < info->num_iovas; i++) {
+        Range *range = g_new(Range, 1);
+
+        range_set_bounds(range, iova_ranges[i].start, iova_ranges[i].last);
+        bcontainer->iova_ranges =
+            range_list_insert(bcontainer->iova_ranges, range);
+    }
+    bcontainer->pgsizes = info->out_iova_alignment;
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
@@ -343,6 +390,7 @@ static int iommufd_attach_device(const char *name, VFIODevice *vbasedev,
     }
 
     bcontainer->pgsizes = qemu_real_host_page_size();
+    vfio_get_info_iova_range(container, ioas_id);
 
     bcontainer->listener = vfio_memory_listener;
     memory_listener_register(&bcontainer->listener, bcontainer->space->as);
-- 
2.34.1


