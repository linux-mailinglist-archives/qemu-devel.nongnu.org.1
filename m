Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF54819016
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 19:58:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfHH-0001vC-6t; Tue, 19 Dec 2023 13:57:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfHC-0001uL-Sl
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:57:10 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfHB-0006wo-00
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:57:10 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvmC55vGYz4x7q;
 Wed, 20 Dec 2023 05:57:05 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvmC06Ff9z4wcJ;
 Wed, 20 Dec 2023 05:57:00 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Yi Liu <yi.l.liu@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 01/47] vfio: Introduce base object for VFIOContainer and
 targeted interface
Date: Tue, 19 Dec 2023 19:55:57 +0100
Message-ID: <20231219185643.725448-2-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219185643.725448-1-clg@redhat.com>
References: <20231219185643.725448-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=7/MV=H6=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Introduce a dumb VFIOContainerBase object and its targeted interface.
This is willingly not a QOM object because we don't want it to be
visible from the user interface. The VFIOContainerBase will be
smoothly populated in subsequent patches as well as interfaces.

No functional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h         |  8 ++---
 include/hw/vfio/vfio-container-base.h | 50 +++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 6 deletions(-)
 create mode 100644 include/hw/vfio/vfio-container-base.h

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index a4a22accb9434c5d04bef73172a0ccbe182405cb..586d153c12b58f5eaabe8e36ad91fad6abd4af10 100644
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
index 0000000000000000000000000000000000000000..1d6daaea5d54775221d36bff98590472e0cf25e2
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
2.43.0


