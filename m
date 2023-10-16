Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 708767CA24D
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:48:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJGG-0007Xr-Vr; Mon, 16 Oct 2023 04:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJG5-0007WY-0c
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:47:29 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJG1-00017B-1X
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697446045; x=1728982045;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WT9qSQz4TtbYRvjgBGk6vxxeZVyK82p2m8Y0jyc78SE=;
 b=bRXLWKtFb+pOyUzURjpNgGFUCUSM8jiD86k3Q1nTPpX2bvlRKtc6ZWfJ
 Dnj32fY/tkF1KhbIl+4vccJekGtCFllMjED1gbUhfKHMRH8ZSB+9xtlPu
 eQSIxdm9BbAWxCnUSKWfm0cSu4DIo0t2y/oF0oLKAsVrhQqW3C7zDC3cs
 T7KBxvnb02bEoz62o6aRR4AT9YYav6F1VmY4mH5t1yPEibtpuobwm66ej
 bmNsFI+MAI3C2Oc8G5WxtoZTQ0IzMo9Uz3Ljxo7CwiKXzeY9aHDRIA56F
 7mychE+UsjIEBmDJ/+w3CdvQ7sbpFg8Zda3+ybQ3eI1TTC8Fp7STwsvLE Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365737519"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="365737519"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:47:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="749222692"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="749222692"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:47:20 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 02/27] vfio: Introduce base object for VFIOContainer and
 targetted interface
Date: Mon, 16 Oct 2023 16:31:58 +0800
Message-Id: <20231016083223.1519410-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
References: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.151;
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

From: Eric Auger <eric.auger@redhat.com>

Introduce a dumb VFIOContainer base object and its targetted interface.
This is willingly not a QOM object because we don't want it to be
visible from the user interface.  The VFIOContainer will be smoothly
populated in subsequent patches as well as interfaces.

No fucntional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h         |  8 +--
 include/hw/vfio/vfio-container-base.h | 82 +++++++++++++++++++++++++++
 2 files changed, 84 insertions(+), 6 deletions(-)
 create mode 100644 include/hw/vfio/vfio-container-base.h

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 34648e518e..9651cf921c 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -30,6 +30,7 @@
 #include <linux/vfio.h>
 #endif
 #include "sysemu/sysemu.h"
+#include "hw/vfio/vfio-container-base.h"
 
 #define VFIO_MSG_PREFIX "vfio %s: "
 
@@ -81,6 +82,7 @@ typedef struct VFIOAddressSpace {
 struct VFIOGroup;
 
 typedef struct VFIOLegacyContainer {
+    VFIOContainer bcontainer;
     VFIOAddressSpace *space;
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
     MemoryListener listener;
@@ -200,12 +202,6 @@ typedef struct VFIODisplay {
     } dmabuf;
 } VFIODisplay;
 
-typedef struct {
-    unsigned long *bitmap;
-    hwaddr size;
-    hwaddr pages;
-} VFIOBitmap;
-
 void vfio_host_win_add(VFIOLegacyContainer *container,
                        hwaddr min_iova, hwaddr max_iova,
                        uint64_t iova_pgsizes);
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
new file mode 100644
index 0000000000..afc8543d22
--- /dev/null
+++ b/include/hw/vfio/vfio-container-base.h
@@ -0,0 +1,82 @@
+/*
+ * VFIO BASE CONTAINER
+ *
+ * Copyright (C) 2023 Intel Corporation.
+ * Copyright Red Hat, Inc. 2023
+ *
+ * Authors: Yi Liu <yi.l.liu@intel.com>
+ *          Eric Auger <eric.auger@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_VFIO_VFIO_BASE_CONTAINER_H
+#define HW_VFIO_VFIO_BASE_CONTAINER_H
+
+#include "exec/memory.h"
+#ifndef CONFIG_USER_ONLY
+#include "exec/hwaddr.h"
+#endif
+
+typedef struct VFIOContainer VFIOContainer;
+typedef struct VFIODevice VFIODevice;
+typedef struct VFIOIOMMUBackendOpsClass VFIOIOMMUBackendOpsClass;
+
+typedef struct {
+    unsigned long *bitmap;
+    hwaddr size;
+    hwaddr pages;
+} VFIOBitmap;
+
+/*
+ * This is the base object for vfio container backends
+ */
+struct VFIOContainer {
+    VFIOIOMMUBackendOpsClass *ops;
+};
+
+#define TYPE_VFIO_IOMMU_BACKEND_OPS "vfio-iommu-backend-ops"
+
+DECLARE_CLASS_CHECKERS(VFIOIOMMUBackendOpsClass,
+                       VFIO_IOMMU_BACKEND_OPS, TYPE_VFIO_IOMMU_BACKEND_OPS)
+
+struct VFIOIOMMUBackendOpsClass {
+    /*< private >*/
+    ObjectClass parent_class;
+
+    /*< public >*/
+    /* required */
+    int (*dma_map)(VFIOContainer *bcontainer,
+                   hwaddr iova, ram_addr_t size,
+                   void *vaddr, bool readonly);
+    int (*dma_unmap)(VFIOContainer *bcontainer,
+                     hwaddr iova, ram_addr_t size,
+                     IOMMUTLBEntry *iotlb);
+    int (*attach_device)(char *name, VFIODevice *vbasedev,
+                         AddressSpace *as, Error **errp);
+    void (*detach_device)(VFIODevice *vbasedev);
+    /* migration feature */
+    int (*set_dirty_page_tracking)(VFIOContainer *bcontainer, bool start);
+    int (*query_dirty_bitmap)(VFIOContainer *bcontainer, VFIOBitmap *vbmap,
+                              hwaddr iova, hwaddr size);
+
+    /* SPAPR specific */
+    int (*add_window)(VFIOContainer *bcontainer,
+                      MemoryRegionSection *section,
+                      Error **errp);
+    void (*del_window)(VFIOContainer *bcontainer,
+                       MemoryRegionSection *section);
+};
+
+#endif /* HW_VFIO_VFIO_BASE_CONTAINER_H */
-- 
2.34.1


