Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEDA7D8121
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:49:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvxsm-0007ND-G8; Thu, 26 Oct 2023 06:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxsj-0007Mn-Fz; Thu, 26 Oct 2023 06:46:29 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxsh-0001Hy-Jy; Thu, 26 Oct 2023 06:46:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698317187; x=1729853187;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yuZLpoamk7ehr3AZoYC8ULdgvhr7U0wkHNbZXdurKlo=;
 b=c2/94Af81RdT8DDxuqEwKgMTJvPcfLvRMQckZyOpwj/c1U7ol5uWmIdC
 5iEcNpZseTMQ8tMzU9syUd3Rgd2m1oMPM9PuF3n3aXJV7FhBbquKy/SDe
 qKcur0lWWPvjeSilyYFkFIJb+/1fQJkbxQKODRNjuN+yXoV5mOgbzQ/SG
 DOGKsVXdKJwWEIHTXsSlgLwemXbstdUjpucbNy6ZFVU/PqjCpDpln7THx
 65Mj7v0ljvEvGsacFI9TCsBdylRaFHZaPJ3kJBCh4nzn74cVUKBo+9VLh
 Ct+e6oNnuBPpuPE2aj7aQkUQzFgZYAn5eU3+8c0PVYfWw0qTEbnpxnLDo A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="372563219"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; d="scan'208";a="372563219"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:46:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="463588"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:46:11 -0700
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
Subject: [PATCH v3 04/37] vfio/spapr: Make vfio_spapr_create/remove_window
 static
Date: Thu, 26 Oct 2023 18:30:31 +0800
Message-Id: <20231026103104.1686921-5-zhenzhong.duan@intel.com>
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

vfio_spapr_create_window calls vfio_spapr_remove_window,
With reoder of definition of the two, we can make
vfio_spapr_create/remove_window static.

No functional changes intended.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h |  6 -----
 hw/vfio/spapr.c               | 48 +++++++++++++++++------------------
 2 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 8d1d4f0a89..f3174b3c5c 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -293,12 +293,6 @@ struct vfio_info_cap_header *
 vfio_get_cap(void *ptr, uint32_t cap_offset, uint16_t id);
 #endif
 
-int vfio_spapr_create_window(VFIOContainer *container,
-                             MemoryRegionSection *section,
-                             hwaddr *pgsize);
-int vfio_spapr_remove_window(VFIOContainer *container,
-                             hwaddr offset_within_address_space);
-
 bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
 void vfio_migration_exit(VFIODevice *vbasedev);
 
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index fd0613dfde..43adbdb7b3 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -146,9 +146,30 @@ static const MemoryListener vfio_prereg_listener = {
     .region_del = vfio_prereg_listener_region_del,
 };
 
-int vfio_spapr_create_window(VFIOContainer *container,
-                             MemoryRegionSection *section,
-                             hwaddr *pgsize)
+static int vfio_spapr_remove_window(VFIOContainer *container,
+                                    hwaddr offset_within_address_space)
+{
+    struct vfio_iommu_spapr_tce_remove remove = {
+        .argsz = sizeof(remove),
+        .start_addr = offset_within_address_space,
+    };
+    int ret;
+
+    ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_REMOVE, &remove);
+    if (ret) {
+        error_report("Failed to remove window at %"PRIx64,
+                     (uint64_t)remove.start_addr);
+        return -errno;
+    }
+
+    trace_vfio_spapr_remove_window(offset_within_address_space);
+
+    return 0;
+}
+
+static int vfio_spapr_create_window(VFIOContainer *container,
+                                    MemoryRegionSection *section,
+                                    hwaddr *pgsize)
 {
     int ret = 0;
     IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
@@ -238,27 +259,6 @@ int vfio_spapr_create_window(VFIOContainer *container,
     return 0;
 }
 
-int vfio_spapr_remove_window(VFIOContainer *container,
-                             hwaddr offset_within_address_space)
-{
-    struct vfio_iommu_spapr_tce_remove remove = {
-        .argsz = sizeof(remove),
-        .start_addr = offset_within_address_space,
-    };
-    int ret;
-
-    ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_REMOVE, &remove);
-    if (ret) {
-        error_report("Failed to remove window at %"PRIx64,
-                     (uint64_t)remove.start_addr);
-        return -errno;
-    }
-
-    trace_vfio_spapr_remove_window(offset_within_address_space);
-
-    return 0;
-}
-
 int vfio_container_add_section_window(VFIOContainer *container,
                                       MemoryRegionSection *section,
                                       Error **errp)
-- 
2.34.1


