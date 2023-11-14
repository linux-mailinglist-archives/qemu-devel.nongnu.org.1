Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2FD7EADF6
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 11:26:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2qcM-000370-18; Tue, 14 Nov 2023 05:26:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2qcG-00034n-8b
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:25:56 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2qcE-0007i0-IQ
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699957554; x=1731493554;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ni/RUjlsiVAzw7pWluqty2WRMuGxUUBrIcrk+0TiPeY=;
 b=bmTXGCGTljLgauelwr9NICyb0IjbDxNm7hRO1rOJxTN1TayOw8s8wxQp
 vgd2wMGVufy17C4RfIU+PjRwS621J7wKiHLoojQFroqDL31IfGSJHXB7G
 lit8qzfYH3D5VrjK4bX0CAcQ4cyJ6njTqYReBb/Gu3Dj9ofMu/vy+oxly
 zXWjX8eBoV4BYt91rqJSut8BCvKlBQ31E4HJurXCvWLSUkTdbFP0G6jUZ
 mENJ76UBQMOtUbKlERG96/5zA/cFRDBw9n119AWRfO1eGsJ1ZxeSh21W0
 Xm7aVGL4BvawMqrsQTxSm7nPuksZtUvZ4tZqAuA3H070aqQ8h0yuX8uiQ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="394543451"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; d="scan'208";a="394543451"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 02:25:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="888212898"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; d="scan'208";a="888212898"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 02:25:48 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 06/21] vfio/iommufd: Add support for iova_ranges and pgsizes
Date: Tue, 14 Nov 2023 18:09:40 +0800
Message-Id: <20231114100955.1961974-7-zhenzhong.duan@intel.com>
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

Some vIOMMU such as virtio-iommu use IOVA ranges from host side to
setup reserved ranges for passthrough device, so that guest will not
use an IOVA range beyond host support.

Use an uAPI of IOMMUFD to get IOVA ranges of host side and pass to
vIOMMU just like the legacy backend, if this fails, fallback to
64bit IOVA range.

Also use out_iova_alignment returned from uAPI as pgsizes instead of
qemu_real_host_page_size() as a fallback.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
v6: propagate iommufd_cdev_get_info_iova_range err and print as warning

 hw/vfio/iommufd.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 06282d885c..e5bf528e89 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -267,6 +267,53 @@ static int iommufd_cdev_ram_block_discard_disable(bool state)
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
@@ -341,7 +388,13 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
         goto err_discard_disable;
     }
 
-    bcontainer->pgsizes = qemu_real_host_page_size();
+    ret = iommufd_cdev_get_info_iova_range(container, ioas_id, &err);
+    if (ret) {
+        warn_report_err(err);
+        err = NULL;
+        error_printf("Fallback to default 64bit IOVA range and 4K page size\n");
+        bcontainer->pgsizes = qemu_real_host_page_size();
+    }
 
     bcontainer->listener = vfio_memory_listener;
     memory_listener_register(&bcontainer->listener, bcontainer->space->as);
-- 
2.34.1


