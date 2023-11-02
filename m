Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 282F87DED83
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:37:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyS8b-0003LZ-Po; Thu, 02 Nov 2023 03:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS8Z-0003LC-Es
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:29:07 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS8X-0003Iu-P4
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698910145; x=1730446145;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fUm8JL0SeQgChdWgcZIV4ZbFjiGIcOSVo1Keh6d/NJA=;
 b=DaBpSiZD3/rM7XdVn5wKaP5zS1GXyW2X8ZOssAK5nE7jvFpylMCCb6Dz
 cWbFnG2vEj0a0jByxRrVkFk7JwcmkJjgTWMfNapZVIVIicsCN1KZ2wMdG
 w2Ttiii0K5fFVJFjDycxcD72pwOD1cST21F90X/znwhUe5eqeNxjiVvLF
 /4Rp4SxIP7xhatPX3FCALqvbUhLGDkTTuXwyewcWJpuLsZZ8oXuxVHLuc
 BdmrE79EXj2uONokmHop+ILAoGRKYRKsCoEL4fcJjzSh00cmyl4De56aN
 cJM/aUbFwdOJmYTohP/kY72J8QizB9yth/5zbi9L2zSeeAMi0O/b8H/Ux g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452953118"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="452953118"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:29:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711055282"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="711055282"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:29:00 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 09/41] vfio/common: Introduce vfio_container_init/destroy
 helper
Date: Thu,  2 Nov 2023 15:12:30 +0800
Message-Id: <20231102071302.1818071-10-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This adds two helper functions vfio_container_init/destroy which will be
used by both legacy and iommufd containers to do base container specific
initialization and release.

No fucntional change intended.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-container-base.h | 4 ++++
 hw/vfio/container-base.c              | 9 +++++++++
 hw/vfio/container.c                   | 4 +++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 56b033f59f..577f52ccbc 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -38,6 +38,10 @@ int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
                              hwaddr iova, ram_addr_t size,
                              IOMMUTLBEntry *iotlb);
 
+void vfio_container_init(VFIOContainerBase *bcontainer,
+                         const VFIOIOMMUOps *ops);
+void vfio_container_destroy(VFIOContainerBase *bcontainer);
+
 struct VFIOIOMMUOps {
     /* basic feature */
     int (*dma_map)(VFIOContainerBase *bcontainer,
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
index 55d3a35fa4..e929435751 100644
--- a/hw/vfio/container-base.c
+++ b/hw/vfio/container-base.c
@@ -30,3 +30,12 @@ int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
     g_assert(bcontainer->ops->dma_unmap);
     return bcontainer->ops->dma_unmap(bcontainer, iova, size, iotlb);
 }
+
+void vfio_container_init(VFIOContainerBase *bcontainer, const VFIOIOMMUOps *ops)
+{
+    bcontainer->ops = ops;
+}
+
+void vfio_container_destroy(VFIOContainerBase *bcontainer)
+{
+}
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index c04df26323..32a0251dd1 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -559,7 +559,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     QLIST_INIT(&container->giommu_list);
     QLIST_INIT(&container->vrdl_list);
     bcontainer = &container->bcontainer;
-    bcontainer->ops = &vfio_legacy_ops;
+    vfio_container_init(bcontainer, &vfio_legacy_ops);
 
     ret = vfio_init_container(container, group->fd, errp);
     if (ret) {
@@ -661,6 +661,7 @@ put_space_exit:
 static void vfio_disconnect_container(VFIOGroup *group)
 {
     VFIOContainer *container = group->container;
+    VFIOContainerBase *bcontainer = &container->bcontainer;
 
     QLIST_REMOVE(group, container_next);
     group->container = NULL;
@@ -695,6 +696,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
             QLIST_REMOVE(giommu, giommu_next);
             g_free(giommu);
         }
+        vfio_container_destroy(bcontainer);
 
         trace_vfio_disconnect_container(container->fd);
         close(container->fd);
-- 
2.34.1


