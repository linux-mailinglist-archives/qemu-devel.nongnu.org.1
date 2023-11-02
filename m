Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0991F7DED4D
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:30:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyS8Q-0003Jf-JR; Thu, 02 Nov 2023 03:28:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS8M-0003Ij-MV
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:28:54 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS8K-0003Iu-VR
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698910133; x=1730446133;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VW5pFPVjDwvzR62I3j8pzdNJf0iC/PM3XBdsI01VM1Q=;
 b=BihX+ofBWkQL2FSRMPi+vCXrSeUGObcYBbyO5V3ODZj9G6xPFC6Jb4xs
 gPOqRt1sFYJSvYDhjbkHMmptMRz8ZenKvVur6rMcliEYMHc+Kng/rSxt7
 1ZdK1mgIknhcuP2mYgxNuangWKUX1CZ4u0113qIlpIwwB0h4wxSGTFPBD
 saX5Bnwz0XFoCuH1+Wr/89z+V0X8+OfGUuDWrMq1jvLnsZG4hlpv3R3pu
 lX6JF3HnlFiSEnXhPTTKfPLYK1Bfe+CYGgvfVVK+tNebWMwr2dT3jFbyZ
 OBukkjVjS8JAth6j5ff9wU1LXLSp9rv6G7y+mBPS3liNMzi1m6e+F8Wn6 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452953095"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="452953095"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:28:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711055209"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="711055209"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:28:47 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH v4 06/41] vfio: Introduce base object for VFIOContainer and
 targeted interface
Date: Thu,  2 Nov 2023 15:12:27 +0800
Message-Id: <20231102071302.1818071-7-zhenzhong.duan@intel.com>
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

Introduce a dumb VFIOContainerBase object and its targeted interface.
This is willingly not a QOM object because we don't want it to be
visible from the user interface. The VFIOContainerBase will be
smoothly populated in subsequent patches as well as interfaces.

No fucntional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
v4: use SPDX identifier, use const char *name parameter, HW_VFIO_VFIO_CONTAINER_BASE_H

 include/hw/vfio/vfio-common.h         |  8 ++---
 include/hw/vfio/vfio-container-base.h | 50 +++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 6 deletions(-)
 create mode 100644 include/hw/vfio/vfio-container-base.h

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index a4a22accb9..586d153c12 100644
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
 
 typedef struct VFIOContainer {
+    VFIOContainerBase bcontainer;
     VFIOAddressSpace *space;
     int fd; /* /dev/vfio/vfio, empowered by the attached groups */
     MemoryListener listener;
@@ -201,12 +203,6 @@ typedef struct VFIODisplay {
     } dmabuf;
 } VFIODisplay;
 
-typedef struct {
-    unsigned long *bitmap;
-    hwaddr size;
-    hwaddr pages;
-} VFIOBitmap;
-
 VFIOAddressSpace *vfio_get_address_space(AddressSpace *as);
 void vfio_put_address_space(VFIOAddressSpace *space);
 bool vfio_devices_all_running_and_saving(VFIOContainer *container);
diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
new file mode 100644
index 0000000000..1d6daaea5d
--- /dev/null
+++ b/include/hw/vfio/vfio-container-base.h
@@ -0,0 +1,50 @@
+/*
+ * VFIO BASE CONTAINER
+ *
+ * Copyright (C) 2023 Intel Corporation.
+ * Copyright Red Hat, Inc. 2023
+ *
+ * Authors: Yi Liu <yi.l.liu@intel.com>
+ *          Eric Auger <eric.auger@redhat.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_VFIO_VFIO_CONTAINER_BASE_H
+#define HW_VFIO_VFIO_CONTAINER_BASE_H
+
+#include "exec/memory.h"
+
+typedef struct VFIODevice VFIODevice;
+typedef struct VFIOIOMMUOps VFIOIOMMUOps;
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
+typedef struct VFIOContainerBase {
+    const VFIOIOMMUOps *ops;
+} VFIOContainerBase;
+
+struct VFIOIOMMUOps {
+    /* basic feature */
+    int (*dma_map)(VFIOContainerBase *bcontainer,
+                   hwaddr iova, ram_addr_t size,
+                   void *vaddr, bool readonly);
+    int (*dma_unmap)(VFIOContainerBase *bcontainer,
+                     hwaddr iova, ram_addr_t size,
+                     IOMMUTLBEntry *iotlb);
+    int (*attach_device)(const char *name, VFIODevice *vbasedev,
+                         AddressSpace *as, Error **errp);
+    void (*detach_device)(VFIODevice *vbasedev);
+    /* migration feature */
+    int (*set_dirty_page_tracking)(VFIOContainerBase *bcontainer, bool start);
+    int (*query_dirty_bitmap)(VFIOContainerBase *bcontainer, VFIOBitmap *vbmap,
+                              hwaddr iova, hwaddr size);
+};
+#endif /* HW_VFIO_VFIO_CONTAINER_BASE_H */
-- 
2.34.1


