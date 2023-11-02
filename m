Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BCD7DED44
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:30:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyS8B-0003D3-Pp; Thu, 02 Nov 2023 03:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS89-0003Bo-8P; Thu, 02 Nov 2023 03:28:41 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS85-0003H2-B7; Thu, 02 Nov 2023 03:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698910117; x=1730446117;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WcudhB5q7MGJ5qgLSh9aRR0eBPwPGEKs8NT4Lk0tffQ=;
 b=b6f4yQG8/9Z52l5Qwdg5ud9mBzIFFRB+VGZaAlpdrQnqFqQ2vAYs/YlM
 DzCK494WgAdV8aaERpWpiFTmliI7prARBFUhXaRT8mYAtpex+bFUsRIJC
 8cnay6odcxhtn4hMg7YFLkzXDfT1XW6DFlz/hWhOwiE4yhGpEIETA6BI5
 rW7MFnGhvyQF6rIindcbkyo34CNHURiW1VOGpgrtSc7Lagysq/MEhoK4Q
 GX6C8ZZ1tOGHSYQCC6A6WVr0S4NcfQeiL/lm02a8/JD+e4tn76hjzBlSG
 M35cx6xcfsJUiXFX6m98aGBTJ5k11bsqr3tzGOMB92inqZ0nyywWIUCVC g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452952956"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="452952956"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:28:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711055087"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="711055087"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:28:19 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Farman <farman@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-ppc@nongnu.org (open list:sPAPR (pseries)),
 qemu-s390x@nongnu.org (open list:vfio-ap)
Subject: [PATCH v4 01/41] vfio/container: Move IBM EEH related functions into
 spapr_pci_vfio.c
Date: Thu,  2 Nov 2023 15:12:22 +0800
Message-Id: <20231102071302.1818071-2-zhenzhong.duan@intel.com>
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

With vfio_eeh_as_ok/vfio_eeh_as_op moved and made static,
vfio.h becomes empty and is deleted.

No functional changes intended.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Acked-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio.h  |   7 ---
 hw/ppc/spapr_pci_vfio.c | 100 +++++++++++++++++++++++++++++++++++++++-
 hw/vfio/ap.c            |   1 -
 hw/vfio/ccw.c           |   1 -
 hw/vfio/common.c        |   1 -
 hw/vfio/container.c     |  98 ---------------------------------------
 hw/vfio/helpers.c       |   1 -
 7 files changed, 99 insertions(+), 110 deletions(-)
 delete mode 100644 include/hw/vfio/vfio.h

diff --git a/include/hw/vfio/vfio.h b/include/hw/vfio/vfio.h
deleted file mode 100644
index 86248f5436..0000000000
--- a/include/hw/vfio/vfio.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef HW_VFIO_H
-#define HW_VFIO_H
-
-bool vfio_eeh_as_ok(AddressSpace *as);
-int vfio_eeh_as_op(AddressSpace *as, uint32_t op);
-
-#endif
diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index 9016720547..f283f7e38d 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -18,14 +18,112 @@
  */
 
 #include "qemu/osdep.h"
+#include <sys/ioctl.h>
 #include <linux/vfio.h>
 #include "hw/ppc/spapr.h"
 #include "hw/pci-host/spapr.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci_device.h"
-#include "hw/vfio/vfio.h"
+#include "hw/vfio/vfio-common.h"
 #include "qemu/error-report.h"
 
+/*
+ * Interfaces for IBM EEH (Enhanced Error Handling)
+ */
+static bool vfio_eeh_container_ok(VFIOContainer *container)
+{
+    /*
+     * As of 2016-03-04 (linux-4.5) the host kernel EEH/VFIO
+     * implementation is broken if there are multiple groups in a
+     * container.  The hardware works in units of Partitionable
+     * Endpoints (== IOMMU groups) and the EEH operations naively
+     * iterate across all groups in the container, without any logic
+     * to make sure the groups have their state synchronized.  For
+     * certain operations (ENABLE) that might be ok, until an error
+     * occurs, but for others (GET_STATE) it's clearly broken.
+     */
+
+    /*
+     * XXX Once fixed kernels exist, test for them here
+     */
+
+    if (QLIST_EMPTY(&container->group_list)) {
+        return false;
+    }
+
+    if (QLIST_NEXT(QLIST_FIRST(&container->group_list), container_next)) {
+        return false;
+    }
+
+    return true;
+}
+
+static int vfio_eeh_container_op(VFIOContainer *container, uint32_t op)
+{
+    struct vfio_eeh_pe_op pe_op = {
+        .argsz = sizeof(pe_op),
+        .op = op,
+    };
+    int ret;
+
+    if (!vfio_eeh_container_ok(container)) {
+        error_report("vfio/eeh: EEH_PE_OP 0x%x: "
+                     "kernel requires a container with exactly one group", op);
+        return -EPERM;
+    }
+
+    ret = ioctl(container->fd, VFIO_EEH_PE_OP, &pe_op);
+    if (ret < 0) {
+        error_report("vfio/eeh: EEH_PE_OP 0x%x failed: %m", op);
+        return -errno;
+    }
+
+    return ret;
+}
+
+static VFIOContainer *vfio_eeh_as_container(AddressSpace *as)
+{
+    VFIOAddressSpace *space = vfio_get_address_space(as);
+    VFIOContainer *container = NULL;
+
+    if (QLIST_EMPTY(&space->containers)) {
+        /* No containers to act on */
+        goto out;
+    }
+
+    container = QLIST_FIRST(&space->containers);
+
+    if (QLIST_NEXT(container, next)) {
+        /*
+         * We don't yet have logic to synchronize EEH state across
+         * multiple containers
+         */
+        container = NULL;
+        goto out;
+    }
+
+out:
+    vfio_put_address_space(space);
+    return container;
+}
+
+static bool vfio_eeh_as_ok(AddressSpace *as)
+{
+    VFIOContainer *container = vfio_eeh_as_container(as);
+
+    return (container != NULL) && vfio_eeh_container_ok(container);
+}
+
+static int vfio_eeh_as_op(AddressSpace *as, uint32_t op)
+{
+    VFIOContainer *container = vfio_eeh_as_container(as);
+
+    if (!container) {
+        return -ENODEV;
+    }
+    return vfio_eeh_container_op(container, op);
+}
+
 bool spapr_phb_eeh_available(SpaprPhbState *sphb)
 {
     return vfio_eeh_as_ok(&sphb->iommu_as);
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 5f257bffb9..bbf69ff55a 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -14,7 +14,6 @@
 #include <linux/vfio.h>
 #include <sys/ioctl.h>
 #include "qapi/error.h"
-#include "hw/vfio/vfio.h"
 #include "hw/vfio/vfio-common.h"
 #include "hw/s390x/ap-device.h"
 #include "qemu/error-report.h"
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 6623ae237b..d857bb8d0f 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -20,7 +20,6 @@
 #include <sys/ioctl.h>
 
 #include "qapi/error.h"
-#include "hw/vfio/vfio.h"
 #include "hw/vfio/vfio-common.h"
 #include "hw/s390x/s390-ccw.h"
 #include "hw/s390x/vfio-ccw.h"
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 9c5c6433f2..e72055e752 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -26,7 +26,6 @@
 #include <linux/vfio.h>
 
 #include "hw/vfio/vfio-common.h"
-#include "hw/vfio/vfio.h"
 #include "hw/vfio/pci.h"
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index fc88222377..83c0f05bba 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -26,7 +26,6 @@
 #include <linux/vfio.h>
 
 #include "hw/vfio/vfio-common.h"
-#include "hw/vfio/vfio.h"
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "exec/ram_addr.h"
@@ -1011,103 +1010,6 @@ static void vfio_put_base_device(VFIODevice *vbasedev)
     close(vbasedev->fd);
 }
 
-/*
- * Interfaces for IBM EEH (Enhanced Error Handling)
- */
-static bool vfio_eeh_container_ok(VFIOContainer *container)
-{
-    /*
-     * As of 2016-03-04 (linux-4.5) the host kernel EEH/VFIO
-     * implementation is broken if there are multiple groups in a
-     * container.  The hardware works in units of Partitionable
-     * Endpoints (== IOMMU groups) and the EEH operations naively
-     * iterate across all groups in the container, without any logic
-     * to make sure the groups have their state synchronized.  For
-     * certain operations (ENABLE) that might be ok, until an error
-     * occurs, but for others (GET_STATE) it's clearly broken.
-     */
-
-    /*
-     * XXX Once fixed kernels exist, test for them here
-     */
-
-    if (QLIST_EMPTY(&container->group_list)) {
-        return false;
-    }
-
-    if (QLIST_NEXT(QLIST_FIRST(&container->group_list), container_next)) {
-        return false;
-    }
-
-    return true;
-}
-
-static int vfio_eeh_container_op(VFIOContainer *container, uint32_t op)
-{
-    struct vfio_eeh_pe_op pe_op = {
-        .argsz = sizeof(pe_op),
-        .op = op,
-    };
-    int ret;
-
-    if (!vfio_eeh_container_ok(container)) {
-        error_report("vfio/eeh: EEH_PE_OP 0x%x: "
-                     "kernel requires a container with exactly one group", op);
-        return -EPERM;
-    }
-
-    ret = ioctl(container->fd, VFIO_EEH_PE_OP, &pe_op);
-    if (ret < 0) {
-        error_report("vfio/eeh: EEH_PE_OP 0x%x failed: %m", op);
-        return -errno;
-    }
-
-    return ret;
-}
-
-static VFIOContainer *vfio_eeh_as_container(AddressSpace *as)
-{
-    VFIOAddressSpace *space = vfio_get_address_space(as);
-    VFIOContainer *container = NULL;
-
-    if (QLIST_EMPTY(&space->containers)) {
-        /* No containers to act on */
-        goto out;
-    }
-
-    container = QLIST_FIRST(&space->containers);
-
-    if (QLIST_NEXT(container, next)) {
-        /*
-         * We don't yet have logic to synchronize EEH state across
-         * multiple containers
-         */
-        container = NULL;
-        goto out;
-    }
-
-out:
-    vfio_put_address_space(space);
-    return container;
-}
-
-bool vfio_eeh_as_ok(AddressSpace *as)
-{
-    VFIOContainer *container = vfio_eeh_as_container(as);
-
-    return (container != NULL) && vfio_eeh_container_ok(container);
-}
-
-int vfio_eeh_as_op(AddressSpace *as, uint32_t op)
-{
-    VFIOContainer *container = vfio_eeh_as_container(as);
-
-    if (!container) {
-        return -ENODEV;
-    }
-    return vfio_eeh_container_op(container, op);
-}
-
 static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
 {
     char *tmp, group_path[PATH_MAX], *group_name;
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 7e5da21b31..168847e7c5 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -23,7 +23,6 @@
 #include <sys/ioctl.h>
 
 #include "hw/vfio/vfio-common.h"
-#include "hw/vfio/vfio.h"
 #include "hw/hw.h"
 #include "trace.h"
 #include "qapi/error.h"
-- 
2.34.1


