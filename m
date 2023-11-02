Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D12F7DED73
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:36:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyS9q-0006QY-FX; Thu, 02 Nov 2023 03:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS9n-0006Do-Mr; Thu, 02 Nov 2023 03:30:23 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS9m-0003PH-3b; Thu, 02 Nov 2023 03:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698910222; x=1730446222;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=l3YZkNwIq5jBPCpzck0bFALAvay/0LAv+uWO0ePCl98=;
 b=Illy0yr2KmN/KKP5fgo8D1mJ4rlb05gG+B1t38RTB7fICZBRVi4LxsnZ
 sMUlinilLekScagEQFyu1pLgx3r3Cq/WAsjAj4zE2ycrQcEoBXxpqOkpP
 8NkWcV14lEib+JsYa2veN+P00sHmDFGIOu77shP2NWl0hBIUW7CklZCh+
 hyaS0JB4p6X0Lb3IQsIALakKez3pqRfUt+sZ5AAqUUvsQfOep7nv/jek6
 GARRNlDE/Sqeo0OgRWaAQcz+6YANMIHHMO90kPL7dM/9ja04Tm2R2K7FJ
 AomZTL91N7jgW3+apw/K0J7ule41oww9oDQfsJI8vr92jzRxN+/EVhWEi Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452953232"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="452953232"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:29:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711055459"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="711055459"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:29:51 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-ppc@nongnu.org (open list:sPAPR (pseries))
Subject: [PATCH v4 21/41] vfio/spapr: Introduce spapr backend and target
 interface
Date: Thu,  2 Nov 2023 15:12:42 +0800
Message-Id: <20231102071302.1818071-22-zhenzhong.duan@intel.com>
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

Introduce an empty spapr backend which will hold spapr specific
content, currently only prereg_listener and hostwin_list.

Also introduce two spapr specific callbacks add/del_window into
VFIOIOMMUOps. Instantiate a spapr ops with a helper setup_spapr_ops
and assign it to bcontainer->ops.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
v4: remove VFIOIOMMUSpaprOps

 include/hw/vfio/vfio-container-base.h |  6 ++++++
 hw/vfio/spapr.c                       | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 9658ffb526..f62a14ac73 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -101,5 +101,11 @@ struct VFIOIOMMUOps {
     int (*set_dirty_page_tracking)(VFIOContainerBase *bcontainer, bool start);
     int (*query_dirty_bitmap)(VFIOContainerBase *bcontainer, VFIOBitmap *vbmap,
                               hwaddr iova, hwaddr size);
+    /* SPAPR specific */
+    int (*add_window)(VFIOContainerBase *bcontainer,
+                      MemoryRegionSection *section,
+                      Error **errp);
+    void (*del_window)(VFIOContainerBase *bcontainer,
+                       MemoryRegionSection *section);
 };
 #endif /* HW_VFIO_VFIO_CONTAINER_BASE_H */
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 7a50975f25..e1a6b35563 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -24,6 +24,10 @@
 #include "qapi/error.h"
 #include "trace.h"
 
+typedef struct VFIOSpaprContainer {
+    VFIOContainer container;
+} VFIOSpaprContainer;
+
 static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *section)
 {
     if (memory_region_is_iommu(section->mr)) {
@@ -421,6 +425,14 @@ void vfio_container_del_section_window(VFIOContainer *container,
     }
 }
 
+static VFIOIOMMUOps vfio_iommu_spapr_ops;
+
+static void setup_spapr_ops(VFIOContainerBase *bcontainer)
+{
+    vfio_iommu_spapr_ops = *bcontainer->ops;
+    bcontainer->ops = &vfio_iommu_spapr_ops;
+}
+
 int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
 {
     VFIOContainerBase *bcontainer = &container->bcontainer;
@@ -486,6 +498,8 @@ int vfio_spapr_container_init(VFIOContainer *container, Error **errp)
                           0x1000);
     }
 
+    setup_spapr_ops(bcontainer);
+
     return 0;
 
 listener_unregister_exit:
-- 
2.34.1


