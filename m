Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA3270A23E
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 23:58:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q086n-0005yu-Vl; Fri, 19 May 2023 17:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q086l-0005wf-59
 for qemu-devel@nongnu.org; Fri, 19 May 2023 17:57:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q086j-0004FD-Gr
 for qemu-devel@nongnu.org; Fri, 19 May 2023 17:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684533472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZvw6QjxR2MUxzxGaroxNq9sovUgvJA+2KZO2vFMJUE=;
 b=ZRyOYFNhZDtdJMu6Yqs1WTVWn6POasV4mL2rB14x2SDEVoluNwm9dow8pdqs1r4Jb4+pU8
 lichmv2Ye1tiTSkYC6CAYg6O7M/hpopR0BDr5jUNUvqhibMrzWb2Iz272PCMnp8wBdQz8i
 cfFLBWcADbukFWZy1A5ogA1aGkYyQec=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-2kliOwucOyWLTq6lTVPw1g-1; Fri, 19 May 2023 17:57:49 -0400
X-MC-Unique: 2kliOwucOyWLTq6lTVPw1g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39680101A53A;
 Fri, 19 May 2023 21:57:49 +0000 (UTC)
Received: from omen.home.shazbot.org (unknown [10.22.10.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C3EE5C0004B;
 Fri, 19 May 2023 21:57:48 +0000 (UTC)
From: Alex Williamson <alex.williamson@redhat.com>
To: robin@streamhpc.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com
Cc: Alex Williamson <alex.williamson@redhat.com>,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 2/4] vfio: Implement a common device info helper
Date: Fri, 19 May 2023 15:57:37 -0600
Message-Id: <20230519215739.402729-3-alex.williamson@redhat.com>
In-Reply-To: <20230519215739.402729-1-alex.williamson@redhat.com>
References: <20230519215739.402729-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

A common helper implementing the realloc algorithm for handling
capabilities.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/s390x/s390-pci-vfio.c      | 37 ++++------------------------
 hw/vfio/common.c              | 46 ++++++++++++++++++++++++++---------
 include/hw/vfio/vfio-common.h |  1 +
 3 files changed, 41 insertions(+), 43 deletions(-)

diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index f51190d4662f..66e8ec3bdef9 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -289,38 +289,11 @@ static void s390_pci_read_pfip(S390PCIBusDevice *pbdev,
     memcpy(pbdev->zpci_fn.pfip, cap->pfip, CLP_PFIP_NR_SEGMENTS);
 }
 
-static struct vfio_device_info *get_device_info(S390PCIBusDevice *pbdev,
-                                                uint32_t argsz)
+static struct vfio_device_info *get_device_info(S390PCIBusDevice *pbdev);
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
index 78358ede2764..ed142296e9fe 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -2843,11 +2843,35 @@ void vfio_put_group(VFIOGroup *group)
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
@@ -2859,11 +2883,11 @@ int vfio_get_device(VFIOGroup *group, const char *name,
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
@@ -2891,14 +2915,14 @@ int vfio_get_device(VFIOGroup *group, const char *name,
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
 
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index eed244f25f34..a8dcda592c08 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -212,6 +212,7 @@ void vfio_region_finalize(VFIORegion *region);
 void vfio_reset_handler(void *opaque);
 VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp);
 void vfio_put_group(VFIOGroup *group);
+struct vfio_device_info *vfio_get_device_info(int fd);
 int vfio_get_device(VFIOGroup *group, const char *name,
                     VFIODevice *vbasedev, Error **errp);
 
-- 
2.39.2


