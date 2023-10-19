Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6A97CFB92
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:48:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTMw-0001IV-Hg; Thu, 19 Oct 2023 09:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qtTMs-0001H0-C6
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:47:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qtTMp-0002rt-Dc
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697723234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r7eTDaV1FpmzV9pK9W2jRFz0sJAK8VoUAbbbjFcDpcA=;
 b=DBI4/zAs0Q/vY3dNxHv6nNFPrKqJvfaY9DEWxTWhF8WLfjOauDDTdRnoExwn3gM0bvsi1c
 pFOK8DzpaKzTkupWPJQcsLQVzF0/5XmSpsRHkKD60LrGa+Yu/rSj5SQpLZJ8l4kcdSHelo
 sLfnr5nQwSZCdBZWNO6oz/FN+IofJtw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-140-wsS1gl1hPMGWMJ4wn2z2JQ-1; Thu, 19 Oct 2023 09:47:10 -0400
X-MC-Unique: wsS1gl1hPMGWMJ4wn2z2JQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13E2638116FA;
 Thu, 19 Oct 2023 13:47:05 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.195.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5FE24492BFA;
 Thu, 19 Oct 2023 13:47:02 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 yanghliu@redhat.com
Subject: [PATCH v4 03/12] vfio: Collect container iova range info
Date: Thu, 19 Oct 2023 15:45:09 +0200
Message-ID: <20231019134651.842175-4-eric.auger@redhat.com>
In-Reply-To: <20231019134651.842175-1-eric.auger@redhat.com>
References: <20231019134651.842175-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Collect iova range information if VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE
capability is supported.

This allows to propagate the information though the IOMMU MR
set_iova_ranges() callback so that virtual IOMMUs
get aware of those aperture constraints. This is only done if
the info is available and the number of iova ranges is greater than
0.

A new vfio_get_info_iova_range helper is introduced matching
the coding style of existing vfio_get_info_dma_avail. The
boolean returned value isn't used though. Code is aligned
between both.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Tested-by: Yanghang Liu <yanghliu@redhat.com>

---

v3 -> v4:
- removed nr_iovas and check iova_ranges before calling
  set_iova_ranges()
- Added Alex' R-b

v2 -> v3:
- Turn nr_iovas into a int initialized to -1
- memory_region_iommu_set_iova_ranges only is called if nr_iovas > 0
- vfio_get_info_iova_range returns a bool to match
  vfio_get_info_dma_avail. Uniformize both code by using !hdr in
  the check
- rebase on top of vfio-next
---
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/common.c              |  9 ++++++++
 hw/vfio/container.c           | 42 ++++++++++++++++++++++++++++++++---
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 7780b9073a..0c3d390e8b 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -99,6 +99,7 @@ typedef struct VFIOContainer {
     QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
     QLIST_ENTRY(VFIOContainer) next;
     QLIST_HEAD(, VFIODevice) device_list;
+    GList *iova_ranges;
 } VFIOContainer;
 
 typedef struct VFIOGuestIOMMU {
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 5ff5acf1d8..d36e02225d 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -699,6 +699,15 @@ static void vfio_listener_region_add(MemoryListener *listener,
             goto fail;
         }
 
+        if (container->iova_ranges) {
+            ret = memory_region_iommu_set_iova_ranges(giommu->iommu_mr,
+                    container->iova_ranges, &err);
+            if (ret) {
+                g_free(giommu);
+                goto fail;
+            }
+        }
+
         ret = memory_region_register_iommu_notifier(section->mr, &giommu->n,
                                                     &err);
         if (ret) {
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index adc467210f..fc88222377 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -382,7 +382,7 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
     /* If the capability cannot be found, assume no DMA limiting */
     hdr = vfio_get_iommu_type1_info_cap(info,
                                         VFIO_IOMMU_TYPE1_INFO_DMA_AVAIL);
-    if (hdr == NULL) {
+    if (!hdr) {
         return false;
     }
 
@@ -394,6 +394,32 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
     return true;
 }
 
+static bool vfio_get_info_iova_range(struct vfio_iommu_type1_info *info,
+                                     VFIOContainer *container)
+{
+    struct vfio_info_cap_header *hdr;
+    struct vfio_iommu_type1_info_cap_iova_range *cap;
+
+    hdr = vfio_get_iommu_type1_info_cap(info,
+                                        VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE);
+    if (!hdr) {
+        return false;
+    }
+
+    cap = (void *)hdr;
+
+    for (int i = 0; i < cap->nr_iovas; i++) {
+        Range *range = g_new(Range, 1);
+
+        range_set_bounds(range, cap->iova_ranges[i].start,
+                         cap->iova_ranges[i].end);
+        container->iova_ranges =
+            range_list_insert(container->iova_ranges, range);
+    }
+
+    return true;
+}
+
 static void vfio_kvm_device_add_group(VFIOGroup *group)
 {
     Error *err = NULL;
@@ -535,6 +561,12 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
     }
 }
 
+static void vfio_free_container(VFIOContainer *container)
+{
+    g_list_free_full(container->iova_ranges, g_free);
+    g_free(container);
+}
+
 static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
                                   Error **errp)
 {
@@ -616,6 +648,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container->error = NULL;
     container->dirty_pages_supported = false;
     container->dma_max_mappings = 0;
+    container->iova_ranges = NULL;
     QLIST_INIT(&container->giommu_list);
     QLIST_INIT(&container->hostwin_list);
     QLIST_INIT(&container->vrdl_list);
@@ -652,6 +685,9 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
         if (!vfio_get_info_dma_avail(info, &container->dma_max_mappings)) {
             container->dma_max_mappings = 65535;
         }
+
+        vfio_get_info_iova_range(info, container);
+
         vfio_get_iommu_info_migration(container, info);
         g_free(info);
 
@@ -765,7 +801,7 @@ enable_discards_exit:
     vfio_ram_block_discard_disable(container, false);
 
 free_container_exit:
-    g_free(container);
+    vfio_free_container(container);
 
 close_fd_exit:
     close(fd);
@@ -819,7 +855,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
 
         trace_vfio_disconnect_container(container->fd);
         close(container->fd);
-        g_free(container);
+        vfio_free_container(container);
 
         vfio_put_address_space(space);
     }
-- 
2.41.0


