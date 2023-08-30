Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB5F78D545
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 12:55:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbIq8-0006kC-0N; Wed, 30 Aug 2023 06:54:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qbIq5-0006fr-FF
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:54:21 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qbIq3-0007jy-5r
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693392859; x=1724928859;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nfgDOi+Bnd7/f8ZFjHWNuRaWM7jar4LHHKIB8rQrMAk=;
 b=B1NSc0o8XHQaI0u/d6eIPJumOYTnIGf2XVH0uEEVFbHdJ3CvfqlSXfcc
 6ZmgwjMoKMjgPKJzGncZKNjOixvEg0BznL9NGzkMjZBUfIn3R6+LU4Z87
 K+YLBF/zHLKvLzyrfeZXNZz17YpzY1W/lmJXnOhQR/mWvCsbLuzN4DSQX
 Ra115nUNHVDjwXOqtFG0D4Y5L7ySaOzqzRUIhFfeUdxzx4edYYB/Ophxz
 x984e8yMW2D0D6yF6AMbekMtZB6Te2RGSieRRgnNnLbfJ2h3A0myWxgSB
 Ousd2gDW2uDHPBYeNPwEeeJICsPMVsL30/t0ORM5mLs+atDpt2SLTHEXk g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="373016707"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; d="scan'208";a="373016707"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2023 03:53:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="715866287"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; d="scan'208";a="715866287"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2023 03:53:52 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v1 19/22] vfio/iommufd: Add vfio device iterator callback for
 iommufd
Date: Wed, 30 Aug 2023 18:37:51 +0800
Message-Id: <20230830103754.36461-20-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830103754.36461-1-zhenzhong.duan@intel.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.93;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The way to get vfio device pointer is different between legacy
container and iommufd container, with iommufd backend support
added, it's time to add the iterator support for iommufd.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/iommufd.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index 876d0e4928..dd24e76e39 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -36,6 +36,34 @@
 #include "qemu/cutils.h"
 #include "qemu/char_dev.h"
 
+static VFIODevice *iommufd_dev_iter_next(VFIOContainer *bcontainer,
+                                           VFIODevice *curr)
+{
+
+    VFIOIOASHwpt *hwpt;
+
+    assert(object_class_dynamic_cast(OBJECT_CLASS(bcontainer->ops),
+                                     TYPE_VFIO_IOMMU_BACKEND_IOMMUFD_OPS));
+
+    VFIOIOMMUFDContainer *container = container_of(bcontainer,
+                                                   VFIOIOMMUFDContainer,
+                                                   bcontainer);
+
+    if (!curr) {
+        hwpt = QLIST_FIRST(&container->hwpt_list);
+    } else {
+        if (curr->next.le_next) {
+            return curr->next.le_next;
+        }
+        hwpt = curr->hwpt->next.le_next;
+    }
+
+    if (!hwpt) {
+        return NULL;
+    }
+    return QLIST_FIRST(&hwpt->device_list);
+}
+
 static int iommufd_map(VFIOContainer *bcontainer, hwaddr iova,
                        ram_addr_t size, void *vaddr, bool readonly)
 {
@@ -501,6 +529,7 @@ static void vfio_iommu_backend_iommufd_ops_class_init(ObjectClass *oc,
                                                      void *data) {
     VFIOIOMMUBackendOpsClass *ops = VFIO_IOMMU_BACKEND_OPS_CLASS(oc);
 
+    ops->dev_iter_next = iommufd_dev_iter_next;
     ops->dma_map = iommufd_map;
     ops->dma_unmap = iommufd_unmap;
     ops->attach_device = iommufd_attach_device;
-- 
2.34.1


