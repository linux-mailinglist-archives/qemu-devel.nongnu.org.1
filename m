Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D747C74341D
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 07:24:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF6bV-0008Iz-5a; Fri, 30 Jun 2023 01:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mf8A=CS=redhat.com=clg@ozlabs.org>)
 id 1qF6bG-0008Du-Jc
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 01:23:18 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mf8A=CS=redhat.com=clg@ozlabs.org>)
 id 1qF6bD-0004LM-AQ
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 01:23:18 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QskHN0wbSz4wpJ;
 Fri, 30 Jun 2023 15:23:12 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QskHJ6hLPz4wZy;
 Fri, 30 Jun 2023 15:23:08 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Robin Voetter <robin@streamhpc.com>
Subject: [PULL 09/16] vfio: Implement a common device info helper
Date: Fri, 30 Jun 2023 07:22:28 +0200
Message-ID: <20230630052235.1934154-10-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630052235.1934154-1-clg@redhat.com>
References: <20230630052235.1934154-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=mf8A=CS=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: Alex Williamson <alex.williamson@redhat.com>

A common helper implementing the realloc algorithm for handling
capabilities.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Robin Voetter <robin@streamhpc.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-common.h |  1 +
 hw/s390x/s390-pci-vfio.c      | 37 ++++------------------------
 hw/vfio/common.c              | 46 ++++++++++++++++++++++++++---------
 3 files changed, 41 insertions(+), 43 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 3dc5f2104c86..6d1b8487c374 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -216,6 +216,7 @@ void vfio_region_finalize(VFIORegion *region);
 void vfio_reset_handler(void *opaque);
 VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp);
 void vfio_put_group(VFIOGroup *group);
+struct vfio_device_info *vfio_get_device_info(int fd);
 int vfio_get_device(VFIOGroup *group, const char *name,
                     VFIODevice *vbasedev, Error **errp);
 
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index f51190d4662f..59a2e03873bd 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -289,38 +289,11 @@ static void s390_pci_read_pfip(S390PCIBusDevice *pbdev,
     memcpy(pbdev->zpci_fn.pfip, cap->pfip, CLP_PFIP_NR_SEGMENTS);
 }
 
-static struct vfio_device_info *get_device_info(S390PCIBusDevice *pbdev,
-                                                uint32_t argsz)
+static struct vfio_device_info *get_device_info(S390PCIBusDevice *pbdev)
 {
-    struct vfio_device_info *info = g_malloc0(argsz);
-    VFIOPCIDevice *vfio_pci;
-    int fd;
+    VFIOPCIDevice *vfio_pci = container_of(pbdev->pdev, VFIOPCIDevice, pdev);
 
-    vfio_pci = container_of(pbdev->pdev, VFIOPCIDevice, pdev);
-    fd = vfio_pci->vbasedev.fd;
-
-    /*
-     * If the specified argsz is not large enough to contain all capabilities
-     * it will be updated upon return from the ioctl.  Retry until we have
-     * a big enough buffer to hold the entire capability chain.  On error,
-     * just exit and rely on CLP defaults.
-     */
-retry:
-    info->argsz = argsz;
-
-    if (ioctl(fd, VFIO_DEVICE_GET_INFO, info)) {
-        trace_s390_pci_clp_dev_info(vfio_pci->vbasedev.name);
-        g_free(info);
-        return NULL;
-    }
-
-    if (info->argsz > argsz) {
-        argsz = info->argsz;
-        info = g_realloc(info, argsz);
-        goto retry;
-    }
-
-    return info;
+    return vfio_get_device_info(vfio_pci->vbasedev.fd);
 }
 
 /*
@@ -335,7 +308,7 @@ bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh)
 
     assert(fh);
 
-    info = get_device_info(pbdev, sizeof(*info));
+    info = get_device_info(pbdev);
     if (!info) {
         return false;
     }
@@ -356,7 +329,7 @@ void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
 {
     g_autofree struct vfio_device_info *info = NULL;
 
-    info = get_device_info(pbdev, sizeof(*info));
+    info = get_device_info(pbdev);
     if (!info) {
         return;
     }
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 25801de173c4..28ec9e999c09 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -2846,11 +2846,35 @@ void vfio_put_group(VFIOGroup *group)
     }
 }
 
+struct vfio_device_info *vfio_get_device_info(int fd)
+{
+    struct vfio_device_info *info;
+    uint32_t argsz = sizeof(*info);
+
+    info = g_malloc0(argsz);
+
+retry:
+    info->argsz = argsz;
+
+    if (ioctl(fd, VFIO_DEVICE_GET_INFO, info)) {
+        g_free(info);
+        return NULL;
+    }
+
+    if (info->argsz > argsz) {
+        argsz = info->argsz;
+        info = g_realloc(info, argsz);
+        goto retry;
+    }
+
+    return info;
+}
+
 int vfio_get_device(VFIOGroup *group, const char *name,
                     VFIODevice *vbasedev, Error **errp)
 {
-    struct vfio_device_info dev_info = { .argsz = sizeof(dev_info) };
-    int ret, fd;
+    g_autofree struct vfio_device_info *info = NULL;
+    int fd;
 
     fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
     if (fd < 0) {
@@ -2862,11 +2886,11 @@ int vfio_get_device(VFIOGroup *group, const char *name,
         return fd;
     }
 
-    ret = ioctl(fd, VFIO_DEVICE_GET_INFO, &dev_info);
-    if (ret) {
+    info = vfio_get_device_info(fd);
+    if (!info) {
         error_setg_errno(errp, errno, "error getting device info");
         close(fd);
-        return ret;
+        return -1;
     }
 
     /*
@@ -2894,14 +2918,14 @@ int vfio_get_device(VFIOGroup *group, const char *name,
     vbasedev->group = group;
     QLIST_INSERT_HEAD(&group->device_list, vbasedev, next);
 
-    vbasedev->num_irqs = dev_info.num_irqs;
-    vbasedev->num_regions = dev_info.num_regions;
-    vbasedev->flags = dev_info.flags;
+    vbasedev->num_irqs = info->num_irqs;
+    vbasedev->num_regions = info->num_regions;
+    vbasedev->flags = info->flags;
+
+    trace_vfio_get_device(name, info->flags, info->num_regions, info->num_irqs);
 
-    trace_vfio_get_device(name, dev_info.flags, dev_info.num_regions,
-                          dev_info.num_irqs);
+    vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
 
-    vbasedev->reset_works = !!(dev_info.flags & VFIO_DEVICE_FLAGS_RESET);
     return 0;
 }
 
-- 
2.41.0


