Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC69479E17C
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 10:06:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKrk-0000sp-MN; Wed, 13 Sep 2023 04:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qgKri-0000sZ-SI
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:04:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qgKrg-0004ky-Mv
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694592288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IAZop55Ny6Gxc5AQo+TBRznDjzisZRxOxhW8y3kjP5o=;
 b=ItuJpo9PEqiZLGzp2INgfzZKXfceOSUqtqZjpenljyRRBnTQ1ZNieXn766guvEKNpPGje+
 96WabdSfq5Gxt8MEjYxGj7Gg7tUD6//9220jq/j5CjKePncbCDb3d0BvGXoepPe1Gj0CGW
 L5XHyfYb5P0Ft02jlGfkmOYnQY5w+Fg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-wo5xrkbmPuO_5udLIt9oxQ-1; Wed, 13 Sep 2023 04:04:44 -0400
X-MC-Unique: wo5xrkbmPuO_5udLIt9oxQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52C0F800B23;
 Wed, 13 Sep 2023 08:04:43 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9CC72026D4B;
 Wed, 13 Sep 2023 08:04:40 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org
Subject: [PATCH v2 05/12] virtio-iommu: Introduce per IOMMUDevice reserved
 regions
Date: Wed, 13 Sep 2023 10:01:40 +0200
Message-ID: <20230913080423.523953-6-eric.auger@redhat.com>
In-Reply-To: <20230913080423.523953-1-eric.auger@redhat.com>
References: <20230913080423.523953-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

For the time being the per device reserved regions are
just a duplicate of IOMMU wide reserved regions. Subsequent
patches will combine those with host reserved regions, if any.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/hw/virtio/virtio-iommu.h |  1 +
 hw/virtio/virtio-iommu.c         | 42 ++++++++++++++++++++++++++------
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index eea4564782..70b8ace34d 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -39,6 +39,7 @@ typedef struct IOMMUDevice {
     AddressSpace  as;
     MemoryRegion root;          /* The root container of the device */
     MemoryRegion bypass_mr;     /* The alias of shared memory MR */
+    GList *resv_regions;
 } IOMMUDevice;
 
 typedef struct IOMMUPciBus {
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 979cdb5648..ea359b586a 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -624,22 +624,48 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
     return ret;
 }
 
+static int consolidate_resv_regions(IOMMUDevice *sdev)
+{
+    VirtIOIOMMU *s = sdev->viommu;
+    int i;
+
+    for (i = 0; i < s->nr_prop_resv_regions; i++) {
+        ReservedRegion *reg = g_new0(ReservedRegion, 1);
+
+        *reg = s->prop_resv_regions[i];
+        sdev->resv_regions = g_list_append(sdev->resv_regions, reg);
+    }
+    return 0;
+}
+
 static ssize_t virtio_iommu_fill_resv_mem_prop(VirtIOIOMMU *s, uint32_t ep,
                                                uint8_t *buf, size_t free)
 {
     struct virtio_iommu_probe_resv_mem prop = {};
     size_t size = sizeof(prop), length = size - sizeof(prop.head), total;
-    int i;
+    IOMMUDevice *sdev;
+    GList *l;
+    int ret;
 
-    total = size * s->nr_prop_resv_regions;
+    sdev = container_of(virtio_iommu_mr(s, ep), IOMMUDevice, iommu_mr);
+    if (!sdev) {
+        return -EINVAL;
+    }
 
+    ret = consolidate_resv_regions(sdev);
+    if (ret) {
+        return ret;
+    }
+
+    total = size * g_list_length(sdev->resv_regions);
     if (total > free) {
         return -ENOSPC;
     }
 
-    for (i = 0; i < s->nr_prop_resv_regions; i++) {
-        unsigned subtype = s->prop_resv_regions[i].type;
-        Range *range = &s->prop_resv_regions[i].range;
+    for (l = sdev->resv_regions; l; l = l->next) {
+        ReservedRegion *reg = l->data;
+        unsigned subtype = reg->type;
+        Range *range = &reg->range;
 
         assert(subtype == VIRTIO_IOMMU_RESV_MEM_T_RESERVED ||
                subtype == VIRTIO_IOMMU_RESV_MEM_T_MSI);
@@ -857,7 +883,7 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     bool bypass_allowed;
     int granule;
     bool found;
-    int i;
+    GList *l;
 
     interval.low = addr;
     interval.high = addr + 1;
@@ -895,8 +921,8 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         goto unlock;
     }
 
-    for (i = 0; i < s->nr_prop_resv_regions; i++) {
-        ReservedRegion *reg = &s->prop_resv_regions[i];
+    for (l = sdev->resv_regions; l; l = l->next) {
+        ReservedRegion *reg = l->data;
 
         if (range_contains(&reg->range, addr)) {
             switch (reg->type) {
-- 
2.41.0


