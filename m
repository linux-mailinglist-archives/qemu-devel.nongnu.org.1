Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDDB79E174
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 10:06:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKrp-0000uu-Kg; Wed, 13 Sep 2023 04:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qgKrn-0000uL-Uc
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:04:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qgKrk-0004mG-Nh
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694592292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i2QwRBGoZPbcURD5OqjPuGqJ6kgQRY30b9gmmhDIPjk=;
 b=QiH9FOvWXcqCnMBNNOaFn98EVHyKtxKdAqOQufFqBQyEmdVOwKSgNyE7iNKpvz5CFTzajw
 S2m+2dqvxj/B0MmIsIxIjIHI6qA8Yzi7hv8WRTvyXoxcQMTx8GNsIBjztdc5+/9AH1cxMU
 LZsqFZWJq+8Ck4GrXEqta2KIv1oYZXo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-a8k58wqRMDmEsgOGwKCl6A-1; Wed, 13 Sep 2023 04:04:49 -0400
X-MC-Unique: a8k58wqRMDmEsgOGwKCl6A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0A8981D88A;
 Wed, 13 Sep 2023 08:04:48 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 493FF2027046;
 Wed, 13 Sep 2023 08:04:46 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org
Subject: [PATCH v2 07/12] virtio-iommu: Implement set_iova_ranges() callback
Date: Wed, 13 Sep 2023 10:01:42 +0200
Message-ID: <20230913080423.523953-8-eric.auger@redhat.com>
In-Reply-To: <20230913080423.523953-1-eric.auger@redhat.com>
References: <20230913080423.523953-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

The implementation populates the array of per IOMMUDevice
host reserved regions.

It is forbidden to have conflicting sets of host IOVA ranges
to be applied onto the same IOMMU MR (implied by different
host devices).

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v1 -> v2:
- Forbid conflicting sets of host resv regions
---
 include/hw/virtio/virtio-iommu.h |  2 ++
 hw/virtio/virtio-iommu.c         | 48 ++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
index 70b8ace34d..31b69c8261 100644
--- a/include/hw/virtio/virtio-iommu.h
+++ b/include/hw/virtio/virtio-iommu.h
@@ -40,6 +40,8 @@ typedef struct IOMMUDevice {
     MemoryRegion root;          /* The root container of the device */
     MemoryRegion bypass_mr;     /* The alias of shared memory MR */
     GList *resv_regions;
+    Range *host_resv_regions;
+    uint32_t nr_host_resv_regions;
 } IOMMUDevice;
 
 typedef struct IOMMUPciBus {
diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index ea359b586a..ed2df5116f 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/iov.h"
+#include "qemu/range.h"
 #include "exec/target_page.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio.h"
@@ -1158,6 +1159,52 @@ static int virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
     return 0;
 }
 
+static int virtio_iommu_set_iova_ranges(IOMMUMemoryRegion *mr,
+                                        uint32_t nr_ranges,
+                                        struct Range *iova_ranges,
+                                        Error **errp)
+{
+    IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
+    uint32_t nr_host_resv_regions;
+    Range *host_resv_regions;
+    int ret = -EINVAL;
+
+    if (!nr_ranges) {
+        return 0;
+    }
+
+    if (sdev->host_resv_regions) {
+        range_inverse_array(nr_ranges, iova_ranges,
+                            &nr_host_resv_regions, &host_resv_regions,
+                            0, UINT64_MAX);
+        if (nr_host_resv_regions != sdev->nr_host_resv_regions) {
+            goto error;
+        }
+        for (int i = 0; i < nr_host_resv_regions; i++) {
+            Range *new = &host_resv_regions[i];
+            Range *existing = &sdev->host_resv_regions[i];
+
+            if (!range_contains_range(existing, new)) {
+                goto error;
+            }
+        }
+        ret = 0;
+        goto out;
+    }
+
+    range_inverse_array(nr_ranges, iova_ranges,
+                        &sdev->nr_host_resv_regions, &sdev->host_resv_regions,
+                        0, UINT64_MAX);
+
+    return 0;
+error:
+    error_setg(errp, "IOMMU mr=%s Conflicting host reserved regions set!",
+               mr->parent_obj.name);
+out:
+    g_free(host_resv_regions);
+    return ret;
+}
+
 static void virtio_iommu_system_reset(void *opaque)
 {
     VirtIOIOMMU *s = opaque;
@@ -1453,6 +1500,7 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
     imrc->replay = virtio_iommu_replay;
     imrc->notify_flag_changed = virtio_iommu_notify_flag_changed;
     imrc->iommu_set_page_size_mask = virtio_iommu_set_page_size_mask;
+    imrc->iommu_set_iova_ranges = virtio_iommu_set_iova_ranges;
 }
 
 static const TypeInfo virtio_iommu_info = {
-- 
2.41.0


