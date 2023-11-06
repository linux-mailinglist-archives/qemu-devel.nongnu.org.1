Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBCF7E2748
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:43:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00kK-00079e-KX; Mon, 06 Nov 2023 09:38:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00jq-0006qy-6L
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:38:02 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org>)
 id 1r00jn-00010D-Jw
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:38:01 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SPDTy6P06z4xkR;
 Tue,  7 Nov 2023 01:37:58 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SPDTw6t81z4xkM;
 Tue,  7 Nov 2023 01:37:56 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 18/22] vfio/container: Move IBM EEH related functions into
 spapr_pci_vfio.c
Date: Mon,  6 Nov 2023 15:36:49 +0100
Message-ID: <20231106143653.302391-19-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106143653.302391-1-clg@redhat.com>
References: <20231106143653.302391-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Ju2X=GT=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

With vfio_eeh_as_ok/vfio_eeh_as_op moved and made static,
vfio.h becomes empty and is deleted.

No functional changes intended.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Acked-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
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
index 86248f54360a582476334988946d9c61f5932dbc..0000000000000000000000000000000000000000
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
index 90167205470cb418b2e74885bed81588f0571a90..f283f7e38d619fd65985146b5e1572c221f95c53 100644
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
index 5f257bffb9d2bfead9271bf2f4e3e3f610b78696..bbf69ff55ae8a922d0ab6d6f966a9a2283cdd2a3 100644
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
index 6623ae237bbc0729fbcc131c77676dd204b7873e..d857bb8d0fe4ff71b3cf635d6da43eccbe593d5f 100644
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
index 9c5c6433f23416f75c1e5525f880c4339fcfe73f..e72055e752d9cccda8fb6379c0dd3f733cfc3294 100644
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
index fc882223779bb30f31c435e92d0eb04383a9e1ed..83c0f05bbaa3f43d4c56e1718eda8451bb59e9f1 100644
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
index 7e5da21b319120b875359aaa5ec26c556c1df777..168847e7c51ef35afbea276745c1aa7e6cd94ce0 100644
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
2.41.0


