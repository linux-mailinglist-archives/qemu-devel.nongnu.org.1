Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4260179E17B
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 10:06:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKrc-0000qx-DP; Wed, 13 Sep 2023 04:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qgKrZ-0000pg-VE
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:04:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qgKrX-0004hb-P1
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694592279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0fClSLFNTnj1PBBeNErEhvIOOlv5XDQmnbvHzzG3f0E=;
 b=FaqCHGEQT3939UW4T9dyXbHXjW9sE4o1P6nbdWd8WCnqzfOkdN9Yj2fFafMgyDxKp0ESCR
 gwyAhxGvZ+3v3yBFZcemO8Stw+taNYj8+3yLY7ijxb/VeWaW1je0KBfuUrgEG7wbWyxdNm
 EveBCYg6fUZFkg7wYhwbGoKh/hkFkXc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-xGcOOg28M-C4pSNNPaJOzw-1; Wed, 13 Sep 2023 04:04:36 -0400
X-MC-Unique: xGcOOg28M-C4pSNNPaJOzw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FFE9101FAA0;
 Wed, 13 Sep 2023 08:04:35 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDCB92026D4B;
 Wed, 13 Sep 2023 08:04:32 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org
Subject: [PATCH v2 02/12] memory: Introduce memory_region_iommu_set_iova_ranges
Date: Wed, 13 Sep 2023 10:01:37 +0200
Message-ID: <20230913080423.523953-3-eric.auger@redhat.com>
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
---
 include/exec/memory.h | 26 ++++++++++++++++++++++++++
 softmmu/memory.c      | 15 +++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 184cb3a01b..f6fb99dd3f 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -519,6 +519,27 @@ struct IOMMUMemoryRegionClass {
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
+     * @nr_ranges: number of IOVA ranges
+     *
+     * @iova_ranges: an array of @nr_ranges usable IOVA ranges
+     *
+     * Returns 0 on success, or a negative error. In case of failure, the error
+     * object must be created.
+     */
+     int (*iommu_set_iova_ranges)(IOMMUMemoryRegion *iommu,
+                                  uint32_t nr_ranges,
+                                  struct Range *iova_ranges,
+                                  Error **errp);
 };
 
 typedef struct RamDiscardListener RamDiscardListener;
@@ -1845,6 +1866,11 @@ int memory_region_iommu_set_page_size_mask(IOMMUMemoryRegion *iommu_mr,
                                            uint64_t page_size_mask,
                                            Error **errp);
 
+int memory_region_iommu_set_iova_ranges(IOMMUMemoryRegion *iommu,
+                                        uint32_t nr_ranges,
+                                        struct Range *iova_ranges,
+                                        Error **errp);
+
 /**
  * memory_region_name: get a memory region's name
  *
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 7d9494ce70..07499457aa 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1905,6 +1905,21 @@ int memory_region_iommu_set_page_size_mask(IOMMUMemoryRegion *iommu_mr,
     return ret;
 }
 
+int memory_region_iommu_set_iova_ranges(IOMMUMemoryRegion *iommu_mr,
+                                        uint32_t nr_ranges,
+                                        struct Range *iova_ranges,
+                                        Error **errp)
+{
+    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
+    int ret = 0;
+
+    if (imrc->iommu_set_iova_ranges) {
+        ret = imrc->iommu_set_iova_ranges(iommu_mr, nr_ranges,
+                                          iova_ranges, errp);
+    }
+    return ret;
+}
+
 int memory_region_register_iommu_notifier(MemoryRegion *mr,
                                           IOMMUNotifier *n, Error **errp)
 {
-- 
2.41.0


