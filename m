Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4B47CFB9A
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:49:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTNH-0001S8-Ak; Thu, 19 Oct 2023 09:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qtTMt-0001I1-0y
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:47:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qtTMq-0002s3-Vs
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697723235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SzKEod8q9u4SBAnz56fOS2R5f4u3a2mZM4Pi6wST3c4=;
 b=G40zkROJ+8ceu8b5t9L0MV6a4LDRh4aCoWxsR4+LFZv7TWjF9KW/uCRzFpk0554HMrTslV
 plQ0PbfBAd7P67BzAiQ33UpAsZj54H3kdgsvRwoLvWjIwkqNgMI5FqqjaCk+ZU6K0F4zOC
 w3I1CX2kF3rKnijmDP/sZM2caomyIjk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-kpwCKWRoO3m5XE3_pKrJIw-1; Thu, 19 Oct 2023 09:47:02 -0400
X-MC-Unique: kpwCKWRoO3m5XE3_pKrJIw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C8C387A9F6;
 Thu, 19 Oct 2023 13:47:02 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.195.144])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 658B7492BFA;
 Thu, 19 Oct 2023 13:46:59 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 yanghliu@redhat.com
Subject: [PATCH v4 02/12] memory: Introduce memory_region_iommu_set_iova_ranges
Date: Thu, 19 Oct 2023 15:45:08 +0200
Message-ID: <20231019134651.842175-3-eric.auger@redhat.com>
In-Reply-To: <20231019134651.842175-1-eric.auger@redhat.com>
References: <20231019134651.842175-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This helper will allow to convey information about valid
IOVA ranges to virtual IOMMUS.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

---

v2 -> v3:
- Pass a Glist instead
- Added a comment on memory_region_iommu_set_iova_ranges
- Removed R-b due to that change
---
 include/exec/memory.h | 30 ++++++++++++++++++++++++++++++
 system/memory.c       | 13 +++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index a089ab4555..1b2791145e 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -527,6 +527,24 @@ struct IOMMUMemoryRegionClass {
      int (*iommu_set_page_size_mask)(IOMMUMemoryRegion *iommu,
                                      uint64_t page_size_mask,
                                      Error **errp);
+    /**
+     * @iommu_set_iova_ranges:
+     *
+     * Propagate information about the usable IOVA ranges for a given IOMMU
+     * memory region. Used for example to propagate host physical device
+     * reserved memory region constraints to the virtual IOMMU.
+     *
+     * Optional method: if this method is not provided, then the default IOVA
+     * aperture is used.
+     *
+     * @iova_ranges: list of ordered IOVA ranges (at least one range)
+     *
+     * Returns 0 on success, or a negative error. In case of failure, the error
+     * object must be created.
+     */
+     int (*iommu_set_iova_ranges)(IOMMUMemoryRegion *iommu,
+                                  GList *iova_ranges,
+                                  Error **errp);
 };
 
 typedef struct RamDiscardListener RamDiscardListener;
@@ -1856,6 +1874,18 @@ int memory_region_iommu_set_page_size_mask(IOMMUMemoryRegion *iommu_mr,
                                            uint64_t page_size_mask,
                                            Error **errp);
 
+/**
+ * memory_region_iommu_set_iova_ranges - Set the usable IOVA ranges
+ * for a given IOMMU MR region
+ *
+ * @iommu_mr: IOMMU memory region
+ * @iova_ranges: list of ordered IOVA ranges (at least one range)
+ * @errp: pointer to Error*, to store an error if it happens.
+ */
+int memory_region_iommu_set_iova_ranges(IOMMUMemoryRegion *iommu,
+                                        GList *iova_ranges,
+                                        Error **errp);
+
 /**
  * memory_region_name: get a memory region's name
  *
diff --git a/system/memory.c b/system/memory.c
index a800fbc9e5..1034f136f0 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1916,6 +1916,19 @@ int memory_region_iommu_set_page_size_mask(IOMMUMemoryRegion *iommu_mr,
     return ret;
 }
 
+int memory_region_iommu_set_iova_ranges(IOMMUMemoryRegion *iommu_mr,
+                                        GList *iova_ranges,
+                                        Error **errp)
+{
+    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
+    int ret = 0;
+
+    if (imrc->iommu_set_iova_ranges) {
+        ret = imrc->iommu_set_iova_ranges(iommu_mr, iova_ranges, errp);
+    }
+    return ret;
+}
+
 int memory_region_register_iommu_notifier(MemoryRegion *mr,
                                           IOMMUNotifier *n, Error **errp)
 {
-- 
2.41.0


