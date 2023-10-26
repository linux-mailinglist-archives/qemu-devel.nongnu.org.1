Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 108317D8141
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:53:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvxt4-0007VF-5p; Thu, 26 Oct 2023 06:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxss-0007ON-Dd
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:46:38 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxsp-0001Hy-D0
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698317195; x=1729853195;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sshorHfi04uXwQnAgCP731sQIeQ8jgd42t56+O1ah78=;
 b=OxKupBQn/q6GG0Uk2nES6V2zHyVpqK5vi68VS5agpP35+xWYXo//DQCG
 zzHEIioGgEzp+JgFLr1sU1B3uc8zC9G3tU4kdyYTRllApfN9dl6UMwDT3
 2DB7lpdvijYovUW4RoTk6+ThKbLchLPEod89DmwObbC8WA1IH3nLqvN66
 JR0sIMvdj3GXsjPCzvLlI7P0/q9L2onpDrw2OLNQRY+6sbzVQKTzcwomC
 MSEDTQJgHqDnnd4uFcrWgVgTg7O7qUI85XHr/Fppjp3N8fuaI5og+89MJ
 TCr/kE31tqviSsBeNpo/1j+JjiGtzGzbARKWhoQGqnwqOJ5O/bLuAkoCo Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="372563243"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; d="scan'208";a="372563243"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:46:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="463597"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:46:20 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH v3 06/37] vfio: Introduce base object for VFIOContainer and
 targetted interface
Date: Thu, 26 Oct 2023 18:30:33 +0800
Message-Id: <20231026103104.1686921-7-zhenzhong.duan@intel.com>
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
 include/hw/vfio/vfio-common.h         |  8 +---
 include/hw/vfio/vfio-container-base.h | 64 +++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 6 deletions(-)
 create mode 100644 include/hw/vfio/vfio-container-base.h

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index b9c7a7e588..d8f293cb57 100644
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
index 0000000000..5becbd51a7
--- /dev/null
+++ b/include/hw/vfio/vfio-container-base.h
@@ -0,0 +1,64 @@
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
+    int (*attach_device)(char *name, VFIODevice *vbasedev,
+                         AddressSpace *as, Error **errp);
+    void (*detach_device)(VFIODevice *vbasedev);
+    /* migration feature */
+    int (*set_dirty_page_tracking)(VFIOContainerBase *bcontainer, bool start);
+    int (*query_dirty_bitmap)(VFIOContainerBase *bcontainer, VFIOBitmap *vbmap,
+                              hwaddr iova, hwaddr size);
+};
+#endif /* HW_VFIO_VFIO_BASE_CONTAINER_H */
-- 
2.34.1


