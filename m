Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 088F2A711C9
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Mar 2025 08:59:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txLaq-0003cy-Es; Wed, 26 Mar 2025 03:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLZX-0001Ie-1L
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:53:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1txLZS-0006LA-M3
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 03:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742975586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1XlTev6tZHF5I149yzouLAe8a0h8E9Fh+YFNOmeHyuw=;
 b=HKtnW83Yrllhfx5V+nz73KbbrjR8oPOjPjRwgTnRM0E4GUC2wPR2Kr7wzZbjsTo3SrX8h3
 mCvVB332wM9TmnW8stofXCVEwpkC58zGRmm8sM7bZka/LU3gqQDJW7XzVG+DX1/WMNvdrd
 7/ABcO/+swaF/ZFVlBm4owXmHAxFrLQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-U8zDpFLJPYGIKTSasiDxcQ-1; Wed,
 26 Mar 2025 03:52:53 -0400
X-MC-Unique: U8zDpFLJPYGIKTSasiDxcQ-1
X-Mimecast-MFC-AGG-ID: U8zDpFLJPYGIKTSasiDxcQ_1742975570
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01F7218EBE8F; Wed, 26 Mar 2025 07:52:50 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.226.180])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC84419560AB; Wed, 26 Mar 2025 07:52:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	Alex Williamson <alex.williamson@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 John Levon <john.levon@nutanix.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH for-10.1 v2 20/37] vfio: Introduce a new file for VFIODevice
 definitions
Date: Wed, 26 Mar 2025 08:51:05 +0100
Message-ID: <20250326075122.1299361-21-clg@redhat.com>
In-Reply-To: <20250326075122.1299361-1-clg@redhat.com>
References: <20250326075122.1299361-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Move all VFIODevice related routines of "helpers.c" into a new "device.c"
file.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/device.c     | 330 +++++++++++++++++++++++++++++++++++++++++++
 hw/vfio/helpers.c    | 303 ---------------------------------------
 hw/vfio/meson.build  |   1 +
 hw/vfio/trace-events |   4 +-
 4 files changed, 334 insertions(+), 304 deletions(-)
 create mode 100644 hw/vfio/device.c

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
new file mode 100644
index 0000000000000000000000000000000000000000..21c6824430c49170b8d1b9a69ff51272f48096a4
--- /dev/null
+++ b/hw/vfio/device.c
@@ -0,0 +1,330 @@
+/*
+ * VFIO device
+ *
+ * Copyright Red Hat, Inc. 2012
+ *
+ * Authors:
+ *  Alex Williamson <alex.williamson@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ * Based on qemu-kvm device-assignment:
+ *  Adapted for KVM by Qumranet.
+ *  Copyright (c) 2007, Neocleus, Alex Novik (alex@neocleus.com)
+ *  Copyright (c) 2007, Neocleus, Guy Zana (guy@neocleus.com)
+ *  Copyright (C) 2008, Qumranet, Amit Shah (amit.shah@qumranet.com)
+ *  Copyright (C) 2008, Red Hat, Amit Shah (amit.shah@redhat.com)
+ *  Copyright (C) 2008, IBM, Muli Ben-Yehuda (muli@il.ibm.com)
+ */
+
+#include "qemu/osdep.h"
+#include <sys/ioctl.h>
+
+#include "hw/vfio/vfio-common.h"
+#include "hw/vfio/pci.h"
+#include "hw/hw.h"
+#include "trace.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/units.h"
+#include "monitor/monitor.h"
+#include "vfio-helpers.h"
+
+/*
+ * Common VFIO interrupt disable
+ */
+void vfio_disable_irqindex(VFIODevice *vbasedev, int index)
+{
+    struct vfio_irq_set irq_set = {
+        .argsz = sizeof(irq_set),
+        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_TRIGGER,
+        .index = index,
+        .start = 0,
+        .count = 0,
+    };
+
+    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
+}
+
+void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index)
+{
+    struct vfio_irq_set irq_set = {
+        .argsz = sizeof(irq_set),
+        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_UNMASK,
+        .index = index,
+        .start = 0,
+        .count = 1,
+    };
+
+    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
+}
+
+void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index)
+{
+    struct vfio_irq_set irq_set = {
+        .argsz = sizeof(irq_set),
+        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_MASK,
+        .index = index,
+        .start = 0,
+        .count = 1,
+    };
+
+    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
+}
+
+static inline const char *action_to_str(int action)
+{
+    switch (action) {
+    case VFIO_IRQ_SET_ACTION_MASK:
+        return "MASK";
+    case VFIO_IRQ_SET_ACTION_UNMASK:
+        return "UNMASK";
+    case VFIO_IRQ_SET_ACTION_TRIGGER:
+        return "TRIGGER";
+    default:
+        return "UNKNOWN ACTION";
+    }
+}
+
+static const char *index_to_str(VFIODevice *vbasedev, int index)
+{
+    if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
+        return NULL;
+    }
+
+    switch (index) {
+    case VFIO_PCI_INTX_IRQ_INDEX:
+        return "INTX";
+    case VFIO_PCI_MSI_IRQ_INDEX:
+        return "MSI";
+    case VFIO_PCI_MSIX_IRQ_INDEX:
+        return "MSIX";
+    case VFIO_PCI_ERR_IRQ_INDEX:
+        return "ERR";
+    case VFIO_PCI_REQ_IRQ_INDEX:
+        return "REQ";
+    default:
+        return NULL;
+    }
+}
+
+bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
+                            int action, int fd, Error **errp)
+{
+    ERRP_GUARD();
+    g_autofree struct vfio_irq_set *irq_set = NULL;
+    int argsz;
+    const char *name;
+    int32_t *pfd;
+
+    argsz = sizeof(*irq_set) + sizeof(*pfd);
+
+    irq_set = g_malloc0(argsz);
+    irq_set->argsz = argsz;
+    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD | action;
+    irq_set->index = index;
+    irq_set->start = subindex;
+    irq_set->count = 1;
+    pfd = (int32_t *)&irq_set->data;
+    *pfd = fd;
+
+    if (!ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
+        return true;
+    }
+
+    error_setg_errno(errp, errno, "VFIO_DEVICE_SET_IRQS failure");
+
+    name = index_to_str(vbasedev, index);
+    if (name) {
+        error_prepend(errp, "%s-%d: ", name, subindex);
+    } else {
+        error_prepend(errp, "index %d-%d: ", index, subindex);
+    }
+    error_prepend(errp,
+                  "Failed to %s %s eventfd signaling for interrupt ",
+                  fd < 0 ? "tear down" : "set up", action_to_str(action));
+    return false;
+}
+
+int vfio_get_region_info(VFIODevice *vbasedev, int index,
+                         struct vfio_region_info **info)
+{
+    size_t argsz = sizeof(struct vfio_region_info);
+
+    *info = g_malloc0(argsz);
+
+    (*info)->index = index;
+retry:
+    (*info)->argsz = argsz;
+
+    if (ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, *info)) {
+        g_free(*info);
+        *info = NULL;
+        return -errno;
+    }
+
+    if ((*info)->argsz > argsz) {
+        argsz = (*info)->argsz;
+        *info = g_realloc(*info, argsz);
+
+        goto retry;
+    }
+
+    return 0;
+}
+
+int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
+                             uint32_t subtype, struct vfio_region_info **info)
+{
+    int i;
+
+    for (i = 0; i < vbasedev->num_regions; i++) {
+        struct vfio_info_cap_header *hdr;
+        struct vfio_region_info_cap_type *cap_type;
+
+        if (vfio_get_region_info(vbasedev, i, info)) {
+            continue;
+        }
+
+        hdr = vfio_get_region_info_cap(*info, VFIO_REGION_INFO_CAP_TYPE);
+        if (!hdr) {
+            g_free(*info);
+            continue;
+        }
+
+        cap_type = container_of(hdr, struct vfio_region_info_cap_type, header);
+
+        trace_vfio_get_dev_region(vbasedev->name, i,
+                                  cap_type->type, cap_type->subtype);
+
+        if (cap_type->type == type && cap_type->subtype == subtype) {
+            return 0;
+        }
+
+        g_free(*info);
+    }
+
+    *info = NULL;
+    return -ENODEV;
+}
+
+bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
+{
+    g_autofree struct vfio_region_info *info = NULL;
+    bool ret = false;
+
+    if (!vfio_get_region_info(vbasedev, region, &info)) {
+        if (vfio_get_region_info_cap(info, cap_type)) {
+            ret = true;
+        }
+    }
+
+    return ret;
+}
+
+bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
+{
+    ERRP_GUARD();
+    struct stat st;
+
+    if (vbasedev->fd < 0) {
+        if (stat(vbasedev->sysfsdev, &st) < 0) {
+            error_setg_errno(errp, errno, "no such host device");
+            error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->sysfsdev);
+            return false;
+        }
+        /* User may specify a name, e.g: VFIO platform device */
+        if (!vbasedev->name) {
+            vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
+        }
+    } else {
+        if (!vbasedev->iommufd) {
+            error_setg(errp, "Use FD passing only with iommufd backend");
+            return false;
+        }
+        /*
+         * Give a name with fd so any function printing out vbasedev->name
+         * will not break.
+         */
+        if (!vbasedev->name) {
+            vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
+        }
+    }
+
+    return true;
+}
+
+void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
+{
+    ERRP_GUARD();
+    int fd = monitor_fd_param(monitor_cur(), str, errp);
+
+    if (fd < 0) {
+        error_prepend(errp, "Could not parse remote object fd %s:", str);
+        return;
+    }
+    vbasedev->fd = fd;
+}
+
+void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
+                      DeviceState *dev, bool ram_discard)
+{
+    vbasedev->type = type;
+    vbasedev->ops = ops;
+    vbasedev->dev = dev;
+    vbasedev->fd = -1;
+
+    vbasedev->ram_block_discard_allowed = ram_discard;
+}
+
+int vfio_device_get_aw_bits(VFIODevice *vdev)
+{
+    /*
+     * iova_ranges is a sorted list. For old kernels that support
+     * VFIO but not support query of iova ranges, iova_ranges is NULL,
+     * in this case HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX(64) is returned.
+     */
+    GList *l = g_list_last(vdev->bcontainer->iova_ranges);
+
+    if (l) {
+        Range *range = l->data;
+        return range_get_last_bit(range) + 1;
+    }
+
+    return HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX;
+}
+
+bool vfio_device_is_mdev(VFIODevice *vbasedev)
+{
+    g_autofree char *subsys = NULL;
+    g_autofree char *tmp = NULL;
+
+    if (!vbasedev->sysfsdev) {
+        return false;
+    }
+
+    tmp = g_strdup_printf("%s/subsystem", vbasedev->sysfsdev);
+    subsys = realpath(tmp, NULL);
+    return subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
+}
+
+bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp)
+{
+    HostIOMMUDevice *hiod = vbasedev->hiod;
+
+    if (!hiod) {
+        return true;
+    }
+
+    return HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp);
+}
+
+VFIODevice *vfio_get_vfio_device(Object *obj)
+{
+    if (object_dynamic_cast(obj, TYPE_VFIO_PCI)) {
+        return &VFIO_PCI(obj)->vbasedev;
+    } else {
+        return NULL;
+    }
+}
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index b7f75b47af3a5d066eb518903831214df6c3755a..7ddc9797ef7659035d927e40a3b99a8f74dca2de 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -24,131 +24,10 @@
 
 #include "system/kvm.h"
 #include "hw/vfio/vfio-common.h"
-#include "hw/vfio/pci.h"
 #include "hw/hw.h"
-#include "trace.h"
 #include "qapi/error.h"
-#include "qemu/error-report.h"
-#include "qemu/units.h"
-#include "monitor/monitor.h"
 #include "vfio-helpers.h"
 
-/*
- * Common VFIO interrupt disable
- */
-void vfio_disable_irqindex(VFIODevice *vbasedev, int index)
-{
-    struct vfio_irq_set irq_set = {
-        .argsz = sizeof(irq_set),
-        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_TRIGGER,
-        .index = index,
-        .start = 0,
-        .count = 0,
-    };
-
-    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
-}
-
-void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index)
-{
-    struct vfio_irq_set irq_set = {
-        .argsz = sizeof(irq_set),
-        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_UNMASK,
-        .index = index,
-        .start = 0,
-        .count = 1,
-    };
-
-    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
-}
-
-void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index)
-{
-    struct vfio_irq_set irq_set = {
-        .argsz = sizeof(irq_set),
-        .flags = VFIO_IRQ_SET_DATA_NONE | VFIO_IRQ_SET_ACTION_MASK,
-        .index = index,
-        .start = 0,
-        .count = 1,
-    };
-
-    ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, &irq_set);
-}
-
-static inline const char *action_to_str(int action)
-{
-    switch (action) {
-    case VFIO_IRQ_SET_ACTION_MASK:
-        return "MASK";
-    case VFIO_IRQ_SET_ACTION_UNMASK:
-        return "UNMASK";
-    case VFIO_IRQ_SET_ACTION_TRIGGER:
-        return "TRIGGER";
-    default:
-        return "UNKNOWN ACTION";
-    }
-}
-
-static const char *index_to_str(VFIODevice *vbasedev, int index)
-{
-    if (vbasedev->type != VFIO_DEVICE_TYPE_PCI) {
-        return NULL;
-    }
-
-    switch (index) {
-    case VFIO_PCI_INTX_IRQ_INDEX:
-        return "INTX";
-    case VFIO_PCI_MSI_IRQ_INDEX:
-        return "MSI";
-    case VFIO_PCI_MSIX_IRQ_INDEX:
-        return "MSIX";
-    case VFIO_PCI_ERR_IRQ_INDEX:
-        return "ERR";
-    case VFIO_PCI_REQ_IRQ_INDEX:
-        return "REQ";
-    default:
-        return NULL;
-    }
-}
-
-bool vfio_set_irq_signaling(VFIODevice *vbasedev, int index, int subindex,
-                            int action, int fd, Error **errp)
-{
-    ERRP_GUARD();
-    g_autofree struct vfio_irq_set *irq_set = NULL;
-    int argsz;
-    const char *name;
-    int32_t *pfd;
-
-    argsz = sizeof(*irq_set) + sizeof(*pfd);
-
-    irq_set = g_malloc0(argsz);
-    irq_set->argsz = argsz;
-    irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD | action;
-    irq_set->index = index;
-    irq_set->start = subindex;
-    irq_set->count = 1;
-    pfd = (int32_t *)&irq_set->data;
-    *pfd = fd;
-
-    if (!ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set)) {
-        return true;
-    }
-
-    error_setg_errno(errp, errno, "VFIO_DEVICE_SET_IRQS failure");
-
-    name = index_to_str(vbasedev, index);
-    if (name) {
-        error_prepend(errp, "%s-%d: ", name, subindex);
-    } else {
-        error_prepend(errp, "index %d-%d: ", index, subindex);
-    }
-    error_prepend(errp,
-                  "Failed to %s %s eventfd signaling for interrupt ",
-                  fd < 0 ? "tear down" : "set up", action_to_str(action));
-    return false;
-}
-
 int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size)
 {
     vbmap->pages = REAL_HOST_PAGE_ALIGN(size) / qemu_real_host_page_size();
@@ -196,33 +75,6 @@ vfio_get_device_info_cap(struct vfio_device_info *info, uint16_t id)
     return vfio_get_cap((void *)info, info->cap_offset, id);
 }
 
-int vfio_get_region_info(VFIODevice *vbasedev, int index,
-                         struct vfio_region_info **info)
-{
-    size_t argsz = sizeof(struct vfio_region_info);
-
-    *info = g_malloc0(argsz);
-
-    (*info)->index = index;
-retry:
-    (*info)->argsz = argsz;
-
-    if (ioctl(vbasedev->fd, VFIO_DEVICE_GET_REGION_INFO, *info)) {
-        g_free(*info);
-        *info = NULL;
-        return -errno;
-    }
-
-    if ((*info)->argsz > argsz) {
-        argsz = (*info)->argsz;
-        *info = g_realloc(*info, argsz);
-
-        goto retry;
-    }
-
-    return 0;
-}
-
 struct vfio_info_cap_header *
 vfio_get_iommu_type1_info_cap(struct vfio_iommu_type1_info *info, uint16_t id)
 {
@@ -335,158 +187,3 @@ retry:
 
     return info;
 }
-
-int vfio_get_dev_region_info(VFIODevice *vbasedev, uint32_t type,
-                             uint32_t subtype, struct vfio_region_info **info)
-{
-    int i;
-
-    for (i = 0; i < vbasedev->num_regions; i++) {
-        struct vfio_info_cap_header *hdr;
-        struct vfio_region_info_cap_type *cap_type;
-
-        if (vfio_get_region_info(vbasedev, i, info)) {
-            continue;
-        }
-
-        hdr = vfio_get_region_info_cap(*info, VFIO_REGION_INFO_CAP_TYPE);
-        if (!hdr) {
-            g_free(*info);
-            continue;
-        }
-
-        cap_type = container_of(hdr, struct vfio_region_info_cap_type, header);
-
-        trace_vfio_get_dev_region(vbasedev->name, i,
-                                  cap_type->type, cap_type->subtype);
-
-        if (cap_type->type == type && cap_type->subtype == subtype) {
-            return 0;
-        }
-
-        g_free(*info);
-    }
-
-    *info = NULL;
-    return -ENODEV;
-}
-
-bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
-{
-    g_autofree struct vfio_region_info *info = NULL;
-    bool ret = false;
-
-    if (!vfio_get_region_info(vbasedev, region, &info)) {
-        if (vfio_get_region_info_cap(info, cap_type)) {
-            ret = true;
-        }
-    }
-
-    return ret;
-}
-
-bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
-{
-    ERRP_GUARD();
-    struct stat st;
-
-    if (vbasedev->fd < 0) {
-        if (stat(vbasedev->sysfsdev, &st) < 0) {
-            error_setg_errno(errp, errno, "no such host device");
-            error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->sysfsdev);
-            return false;
-        }
-        /* User may specify a name, e.g: VFIO platform device */
-        if (!vbasedev->name) {
-            vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
-        }
-    } else {
-        if (!vbasedev->iommufd) {
-            error_setg(errp, "Use FD passing only with iommufd backend");
-            return false;
-        }
-        /*
-         * Give a name with fd so any function printing out vbasedev->name
-         * will not break.
-         */
-        if (!vbasedev->name) {
-            vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
-        }
-    }
-
-    return true;
-}
-
-void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
-{
-    ERRP_GUARD();
-    int fd = monitor_fd_param(monitor_cur(), str, errp);
-
-    if (fd < 0) {
-        error_prepend(errp, "Could not parse remote object fd %s:", str);
-        return;
-    }
-    vbasedev->fd = fd;
-}
-
-void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
-                      DeviceState *dev, bool ram_discard)
-{
-    vbasedev->type = type;
-    vbasedev->ops = ops;
-    vbasedev->dev = dev;
-    vbasedev->fd = -1;
-
-    vbasedev->ram_block_discard_allowed = ram_discard;
-}
-
-int vfio_device_get_aw_bits(VFIODevice *vdev)
-{
-    /*
-     * iova_ranges is a sorted list. For old kernels that support
-     * VFIO but not support query of iova ranges, iova_ranges is NULL,
-     * in this case HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX(64) is returned.
-     */
-    GList *l = g_list_last(vdev->bcontainer->iova_ranges);
-
-    if (l) {
-        Range *range = l->data;
-        return range_get_last_bit(range) + 1;
-    }
-
-    return HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX;
-}
-
-bool vfio_device_is_mdev(VFIODevice *vbasedev)
-{
-    g_autofree char *subsys = NULL;
-    g_autofree char *tmp = NULL;
-
-    if (!vbasedev->sysfsdev) {
-        return false;
-    }
-
-    tmp = g_strdup_printf("%s/subsystem", vbasedev->sysfsdev);
-    subsys = realpath(tmp, NULL);
-    return subsys && (strcmp(subsys, "/sys/bus/mdev") == 0);
-}
-
-bool vfio_device_hiod_realize(VFIODevice *vbasedev, Error **errp)
-{
-    HostIOMMUDevice *hiod = vbasedev->hiod;
-
-    if (!hiod) {
-        return true;
-    }
-
-    return HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp);
-}
-
-VFIODevice *vfio_get_vfio_device(Object *obj)
-{
-    if (object_dynamic_cast(obj, TYPE_VFIO_PCI)) {
-        return &VFIO_PCI(obj)->vbasedev;
-    } else {
-        return NULL;
-    }
-}
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 21795b3d19e5db0c93993c0cb4a951a70d260f10..60caa366175edee6bc69c0febebaef84e752e346 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -20,6 +20,7 @@ system_ss.add(when: 'CONFIG_VFIO_XGMAC', if_true: files('calxeda-xgmac.c'))
 system_ss.add(when: 'CONFIG_VFIO_AMD_XGBE', if_true: files('amd-xgbe.c'))
 system_ss.add(when: 'CONFIG_VFIO', if_true: files(
   'container-base.c',
+  'device.c',
   'migration.c',
   'migration-multifd.c',
   'cpr.c',
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 81f4130100c48012c15b5b4858446149a7eaf5b6..590d9674cf7bc47171516082abaf398dda72b86d 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -105,7 +105,6 @@ vfio_disconnect_container(int fd) "close container->fd=%d"
 vfio_put_group(int fd) "close group->fd=%d"
 vfio_get_device(const char * name, unsigned int flags, unsigned int num_regions, unsigned int num_irqs) "Device %s flags: %u, regions: %u, irqs: %u"
 vfio_put_base_device(int fd) "close vdev->fd=%d"
-vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%08x"
 vfio_legacy_dma_unmap_overflow_workaround(void) ""
 vfio_get_dirty_bitmap(uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty_pages) "iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty_pages=%"PRIu64
 vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
@@ -194,3 +193,6 @@ iommufd_cdev_fail_attach_existing_container(const char *msg) " %s"
 iommufd_cdev_alloc_ioas(int iommufd, int ioas_id) " [iommufd=%d] new IOMMUFD container with ioasid=%d"
 iommufd_cdev_device_info(char *name, int devfd, int num_irqs, int num_regions, int flags) " %s (%d) num_irqs=%d num_regions=%d flags=%d"
 iommufd_cdev_pci_hot_reset_dep_devices(int domain, int bus, int slot, int function, int dev_id) "\t%04x:%02x:%02x.%x devid %d"
+
+# device.c
+vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%08x"
-- 
2.49.0


