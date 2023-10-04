Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8597B8416
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 17:47:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo44e-00070T-9t; Wed, 04 Oct 2023 11:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qo44b-0006zc-H6
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:46:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qo44N-0006iP-5G
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696434348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=850XWWEcM6vFOOAJCQ78JgSWAMqdDK6wLWc6c6eWiIY=;
 b=YdUrI/w2ks6UEBvjLeEFZcP+rXuFeB0wZkptmR4xdjjxQJ0mmFQw2FW+xm9RDaClQMtFNe
 ue/pFMo4Y17FglfFrsUuqgWAoPXybhhoKs7iMehGST3j4GzVqDDtMMfXwtCgVl6G+uV7pZ
 GG2yLz1RCNGrtlXu9TSyPPkRXba2Od8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-_WG3yoY2P-uuipIUdvvAVA-1; Wed, 04 Oct 2023 11:45:44 -0400
X-MC-Unique: _WG3yoY2P-uuipIUdvvAVA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BC1318175A0;
 Wed,  4 Oct 2023 15:45:43 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A3AF40C6EA8;
 Wed,  4 Oct 2023 15:45:40 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com, clg@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 peterx@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, mjrosato@linux.ibm.com,
 aik@ozlabs.ru
Subject: [PATCH v4 05/15] vfio/common: Introduce
 vfio_container_add|del_section_window()
Date: Wed,  4 Oct 2023 17:43:52 +0200
Message-ID: <20231004154518.334760-6-eric.auger@redhat.com>
In-Reply-To: <20231004154518.334760-1-eric.auger@redhat.com>
References: <20231004154518.334760-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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

Introduce helper functions that isolate the code used for
VFIO_SPAPR_TCE_v2_IOMMU.

Those helpers hide implementation details beneath the container object
and make the vfio_listener_region_add/del() implementations more
readable. No code change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 156 +++++++++++++++++++++++++++--------------------
 1 file changed, 89 insertions(+), 67 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index c54a72ec80..0397788aa5 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -807,6 +807,92 @@ static bool vfio_get_section_iova_range(VFIOContainer *container,
     return true;
 }
 
+static int vfio_container_add_section_window(VFIOContainer *container,
+                                             MemoryRegionSection *section,
+                                             Error **errp)
+{
+    VFIOHostDMAWindow *hostwin;
+    hwaddr pgsize = 0;
+    int ret;
+
+    if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
+        return 0;
+    }
+
+    /* For now intersections are not allowed, we may relax this later */
+    QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
+        if (ranges_overlap(hostwin->min_iova,
+                           hostwin->max_iova - hostwin->min_iova + 1,
+                           section->offset_within_address_space,
+                           int128_get64(section->size))) {
+            error_setg(errp,
+                "region [0x%"PRIx64",0x%"PRIx64"] overlaps with existing"
+                "host DMA window [0x%"PRIx64",0x%"PRIx64"]",
+                section->offset_within_address_space,
+                section->offset_within_address_space +
+                    int128_get64(section->size) - 1,
+                hostwin->min_iova, hostwin->max_iova);
+            return -EINVAL;
+        }
+    }
+
+    ret = vfio_spapr_create_window(container, section, &pgsize);
+    if (ret) {
+        error_setg_errno(errp, -ret, "Failed to create SPAPR window");
+        return ret;
+    }
+
+    vfio_host_win_add(container, section->offset_within_address_space,
+                      section->offset_within_address_space +
+                      int128_get64(section->size) - 1, pgsize);
+#ifdef CONFIG_KVM
+    if (kvm_enabled()) {
+        VFIOGroup *group;
+        IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
+        struct kvm_vfio_spapr_tce param;
+        struct kvm_device_attr attr = {
+            .group = KVM_DEV_VFIO_GROUP,
+            .attr = KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
+            .addr = (uint64_t)(unsigned long)&param,
+        };
+
+        if (!memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_SPAPR_TCE_FD,
+                                          &param.tablefd)) {
+            QLIST_FOREACH(group, &container->group_list, container_next) {
+                param.groupfd = group->fd;
+                if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
+                    error_setg_errno(errp, errno,
+                                     "vfio: failed GROUP_SET_SPAPR_TCE for "
+                                     "KVM VFIO device %d and group fd %d",
+                                     param.tablefd, param.groupfd);
+                    return -errno;
+                }
+                trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
+            }
+        }
+    }
+#endif
+    return 0;
+}
+
+static void vfio_container_del_section_window(VFIOContainer *container,
+                                              MemoryRegionSection *section)
+{
+    if (container->iommu_type != VFIO_SPAPR_TCE_v2_IOMMU) {
+        return;
+    }
+
+    vfio_spapr_remove_window(container,
+                             section->offset_within_address_space);
+    if (vfio_host_win_del(container,
+                          section->offset_within_address_space,
+                          section->offset_within_address_space +
+                          int128_get64(section->size) - 1) < 0) {
+        hw_error("%s: Cannot delete missing window at %"HWADDR_PRIx,
+                 __func__, section->offset_within_address_space);
+    }
+}
+
 static void vfio_listener_region_add(MemoryListener *listener,
                                      MemoryRegionSection *section)
 {
@@ -833,62 +919,8 @@ static void vfio_listener_region_add(MemoryListener *listener,
         return;
     }
 
-    if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
-        hwaddr pgsize = 0;
-
-        /* For now intersections are not allowed, we may relax this later */
-        QLIST_FOREACH(hostwin, &container->hostwin_list, hostwin_next) {
-            if (ranges_overlap(hostwin->min_iova,
-                               hostwin->max_iova - hostwin->min_iova + 1,
-                               section->offset_within_address_space,
-                               int128_get64(section->size))) {
-                error_setg(&err,
-                    "region [0x%"PRIx64",0x%"PRIx64"] overlaps with existing"
-                    "host DMA window [0x%"PRIx64",0x%"PRIx64"]",
-                    section->offset_within_address_space,
-                    section->offset_within_address_space +
-                        int128_get64(section->size) - 1,
-                    hostwin->min_iova, hostwin->max_iova);
-                goto fail;
-            }
-        }
-
-        ret = vfio_spapr_create_window(container, section, &pgsize);
-        if (ret) {
-            error_setg_errno(&err, -ret, "Failed to create SPAPR window");
-            goto fail;
-        }
-
-        vfio_host_win_add(container, section->offset_within_address_space,
-                          section->offset_within_address_space +
-                          int128_get64(section->size) - 1, pgsize);
-#ifdef CONFIG_KVM
-        if (kvm_enabled()) {
-            VFIOGroup *group;
-            IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
-            struct kvm_vfio_spapr_tce param;
-            struct kvm_device_attr attr = {
-                .group = KVM_DEV_VFIO_GROUP,
-                .attr = KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE,
-                .addr = (uint64_t)(unsigned long)&param,
-            };
-
-            if (!memory_region_iommu_get_attr(iommu_mr, IOMMU_ATTR_SPAPR_TCE_FD,
-                                              &param.tablefd)) {
-                QLIST_FOREACH(group, &container->group_list, container_next) {
-                    param.groupfd = group->fd;
-                    if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
-                        error_setg_errno(&err, errno,
-                                         "vfio: failed GROUP_SET_SPAPR_TCE for "
-                                         "KVM VFIO device %d and group fd %d",
-                                         param.tablefd, param.groupfd);
-                        goto fail;
-                    }
-                    trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
-                }
-            }
-        }
-#endif
+    if (vfio_container_add_section_window(container, section, &err)) {
+        goto fail;
     }
 
     hostwin = vfio_find_hostwin(container, iova, end);
@@ -1105,17 +1137,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
 
     memory_region_unref(section->mr);
 
-    if (container->iommu_type == VFIO_SPAPR_TCE_v2_IOMMU) {
-        vfio_spapr_remove_window(container,
-                                 section->offset_within_address_space);
-        if (vfio_host_win_del(container,
-                              section->offset_within_address_space,
-                              section->offset_within_address_space +
-                              int128_get64(section->size) - 1) < 0) {
-            hw_error("%s: Cannot delete missing window at %"HWADDR_PRIx,
-                     __func__, section->offset_within_address_space);
-        }
-    }
+    vfio_container_del_section_window(container, section);
 }
 
 static int vfio_set_dirty_page_tracking(VFIOContainer *container, bool start)
-- 
2.41.0


