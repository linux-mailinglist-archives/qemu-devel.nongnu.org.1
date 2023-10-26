Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D902E7D8122
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:49:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvxuG-0001cm-Fh; Thu, 26 Oct 2023 06:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxu9-0001Jd-2F; Thu, 26 Oct 2023 06:47:59 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxu6-0001Nv-VE; Thu, 26 Oct 2023 06:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698317274; x=1729853274;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Q4+Rw92ILOH6hUtVhfMsdOHd49usfmzFgq2SDp59M9g=;
 b=RB/r5AvTD1RExQBsRZh+vI3DOVQj8WsS1c075qIlEp4WnfpPyMOZTL7F
 UCpf6Mf7hkwmjAHPwH85a+VAj8z3DGBD4jImEmiBBFO13rmex1ns9I6C8
 xWzYIrcC5M21A2qnNQZaivjJfaALXN/jmfq4kDbgtDQiqqclSo0jAFxvI
 ZcIV6C3TLsximAAVcna5dloEf5+iWxWIVNd0PxaOPr+hoDHjzqrE0J0nQ
 qaUzMZYSczT7Oiv20wccccXI44mSqWD7gmmKqUsaZhQ5pB4I+AsfNvrHs
 slVj7k+ki6kdV2OMQ9FmaOw3V+CoSF/EF4jyf8+BwgNMftGWTRb5q3ftv Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="372563522"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; d="scan'208";a="372563522"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:47:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="463718"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:47:11 -0700
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
Subject: [PATCH v3 19/37] vfio/spapr: Introduce spapr backend and target
 interface
Date: Thu, 26 Oct 2023 18:30:46 +0800
Message-Id: <20231026103104.1686921-20-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Introduce an empry spapr backend which will hold spapr specific
content, currently only prereg_listener and hostwin_list.

Also introduce and instantiate a spapr specific target interface,
currently only has add/del_window callbacks.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h         | 8 ++++++++
 include/hw/vfio/vfio-container-base.h | 2 ++
 hw/vfio/spapr.c                       | 8 ++++++++
 3 files changed, 18 insertions(+)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 938f75e70c..a74e60e677 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -169,6 +169,14 @@ VFIOAddressSpace *vfio_get_address_space(AddressSpace *as);
 void vfio_put_address_space(VFIOAddressSpace *space);
 
 /* SPAPR specific */
+typedef struct VFIOIOMMUSpaprOps {
+    int (*add_window)(VFIOContainerBase *bcontainer,
+                      MemoryRegionSection *section,
+                      Error **errp);
+    void (*del_window)(VFIOContainerBase *bcontainer,
+                       MemoryRegionSection *section);
+} VFIOIOMMUSpaprOps;
+
 int vfio_container_add_section_window(VFIOContainer *container,
                                       MemoryRegionSection *section,
                                       Error **errp);
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index 2ffafb0d58..1e1854d24f 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -31,6 +31,7 @@
 
 typedef struct VFIODevice VFIODevice;
 typedef struct VFIOIOMMUOps VFIOIOMMUOps;
+typedef struct VFIOIOMMUSpaprOps VFIOIOMMUSpaprOps;
 
 typedef struct {
     unsigned long *bitmap;
@@ -49,6 +50,7 @@ typedef struct VFIOAddressSpace {
  */
 typedef struct VFIOContainerBase {
     const VFIOIOMMUOps *ops;
+    const VFIOIOMMUSpaprOps *spapr_ops;
     VFIOAddressSpace *space;
     MemoryListener listener;
     Error *error;
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 5786377317..3739004151 100644
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
@@ -384,6 +388,8 @@ void vfio_container_del_section_window(VFIOContainer *container,
     }
 }
 
+const VFIOIOMMUSpaprOps vfio_iommu_spapr_ops;
+
 bool vfio_spapr_container_init(VFIOContainer *container, Error **errp)
 {
     VFIOContainerBase *bcontainer = &container->bcontainer;
@@ -447,6 +453,8 @@ bool vfio_spapr_container_init(VFIOContainer *container, Error **errp)
                           0x1000);
     }
 
+    bcontainer->spapr_ops = &vfio_iommu_spapr_ops;
+
 listener_unregister_exit:
     if (v2) {
         memory_listener_unregister(&container->prereg_listener);
-- 
2.34.1


