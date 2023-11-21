Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 780BE7F27F7
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 09:50:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5MP8-00065X-7z; Tue, 21 Nov 2023 03:46:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MP5-00065F-Kc
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:46:43 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MP3-0001Qo-TI
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:46:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700556401; x=1732092401;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uw7DnlmdMZPLbQL7qWgqiELopkS8trDa/dLDZoi3etc=;
 b=OrbcSvY3b9LK4Gl0H0hiSqnbLJyqsmupwfs3GlDR/KJ3XP622gaGiW8q
 6aoBWdM7K8g5yho6gCUfngED/jXgntjTaomDL0kQKmf3LJXpeM3kUaftP
 29cDEz+y/NRKqO7LkMvgFl4jXe8DLmoYPYpmY8ItqBHv+NHZpAfSOJPYf
 zT4NLM2CSZ7R3w62Btq/3b5ZgGHLuofg5HgnHAxpxAKIpQYzBOO9Oo+Mx
 wh34RCyU4ASrmj88mXcRTnir0X5OmjuVk3VYCkgFhvEzgMVGteLF37dJ/
 o9KvWeNKx5viH8rh2qgAkg/ZvEuF4qYZciA28QnFy7jHXPW7BOsSBUhWC Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="395722046"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="395722046"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:46:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="884124886"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="884124886"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:46:37 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com
Subject: [PATCH v7 06/27] vfio/iommufd: Add support for iova_ranges and pgsizes
Date: Tue, 21 Nov 2023 16:44:05 +0800
Message-Id: <20231121084426.1286987-7-zhenzhong.duan@intel.com>
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

Some vIOMMU such as virtio-iommu use IOVA ranges from host side to
setup reserved ranges for passthrough device, so that guest will not
use an IOVA range beyond host support.

Use an uAPI of IOMMUFD to get IOVA ranges of host side and pass to
vIOMMU just like the legacy backend, if this fails, fallback to
64bit IOVA range.

Also use out_iova_alignment returned from uAPI as pgsizes instead of
qemu_real_host_page_size() as a fallback.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
---
 hw/vfio/iommufd.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 6d31aeac7b..01b448e840 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -261,6 +261,53 @@ static int iommufd_cdev_ram_block_discard_disable(bool state)
     return ram_block_uncoordinated_discard_disable(state);
 }
 
+static int iommufd_cdev_get_info_iova_range(VFIOIOMMUFDContainer *container,
+                                            uint32_t ioas_id, Error **errp)
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
+    error_setg_errno(errp, errno, "Cannot get IOVA ranges");
+    return ret;
+}
+
 static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
                                AddressSpace *as, Error **errp)
 {
@@ -335,7 +382,14 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         goto err_discard_disable;
     }
 
-    bcontainer->pgsizes = qemu_real_host_page_size();
+    ret = iommufd_cdev_get_info_iova_range(container, ioas_id, &err);
+    if (ret) {
+        error_append_hint(&err,
+                   "Fallback to default 64bit IOVA range and 4K page size\n");
+        warn_report_err(err);
+        err = NULL;
+        bcontainer->pgsizes = qemu_real_host_page_size();
+    }
 
     bcontainer->listener = vfio_memory_listener;
     memory_listener_register(&bcontainer->listener, bcontainer->space->as);
-- 
2.34.1


