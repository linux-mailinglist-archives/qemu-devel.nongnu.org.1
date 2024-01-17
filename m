Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAF4830101
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 09:05:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ0uq-0002NJ-4j; Wed, 17 Jan 2024 03:04:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQ0uo-0002MG-BU
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:04:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rQ0um-00039X-7k
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:04:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705478687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xqIsR4i4BO9OGZmzS8WyxkJHNJeLczlReQB/Vcukk1A=;
 b=W3GBuVaYBI6/f9cKIutduWwzRqPgLwbPWJVlqjfnpPt+d7XIWZDTmqLv8nYjBmCplrLill
 LdrM/TlPni8o/aif6+AfkhI+JRXCcN2WWhhkIueONMJicNdEfUWZnSI8z1EdyOZEX2m53J
 He+JkRH0hqr+K7KTg7neLv9NHF2gCF4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-8kzxvro_NzG6YgVOEPRBzw-1; Wed, 17 Jan 2024 03:04:44 -0500
X-MC-Unique: 8kzxvro_NzG6YgVOEPRBzw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C104E85A58B;
 Wed, 17 Jan 2024 08:04:43 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D1A810721;
 Wed, 17 Jan 2024 08:04:41 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, jean-philippe@linaro.org, alex.williamson@redhat.com,
 peter.maydell@linaro.org, zhenzhong.duan@intel.com, peterx@redhat.com,
 yanghliu@redhat.com, pbonzini@redhat.com
Cc: mst@redhat.com,
	clg@redhat.com
Subject: [RFC 7/7] memory: Remove IOMMU MR iommu_set_iova_range API
Date: Wed, 17 Jan 2024 09:02:11 +0100
Message-ID: <20240117080414.316890-8-eric.auger@redhat.com>
In-Reply-To: <20240117080414.316890-1-eric.auger@redhat.com>
References: <20240117080414.316890-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Since the host IOVA ranges are now passed through the
PCIIOMMUOps set_host_resv_regions and we have removed
the only implementation of iommu_set_iova_range() in
the virtio-iommu and the only call site in vfio/common,
let's retire the IOMMU MR API and its memory wrapper.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 include/exec/memory.h | 32 --------------------------------
 system/memory.c       | 13 -------------
 2 files changed, 45 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 177be23db7..7677b572c5 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -527,26 +527,6 @@ struct IOMMUMemoryRegionClass {
      int (*iommu_set_page_size_mask)(IOMMUMemoryRegion *iommu,
                                      uint64_t page_size_mask,
                                      Error **errp);
-    /**
-     * @iommu_set_iova_ranges:
-     *
-     * Propagate information about the usable IOVA ranges for a given IOMMU
-     * memory region. Used for example to propagate host physical device
-     * reserved memory region constraints to the virtual IOMMU.
-     *
-     * Optional method: if this method is not provided, then the default IOVA
-     * aperture is used.
-     *
-     * @iommu: the IOMMUMemoryRegion
-     *
-     * @iova_ranges: list of ordered IOVA ranges (at least one range)
-     *
-     * Returns 0 on success, or a negative error. In case of failure, the error
-     * object must be created.
-     */
-     int (*iommu_set_iova_ranges)(IOMMUMemoryRegion *iommu,
-                                  GList *iova_ranges,
-                                  Error **errp);
 };
 
 typedef struct RamDiscardListener RamDiscardListener;
@@ -1896,18 +1876,6 @@ int memory_region_iommu_set_page_size_mask(IOMMUMemoryRegion *iommu_mr,
                                            uint64_t page_size_mask,
                                            Error **errp);
 
-/**
- * memory_region_iommu_set_iova_ranges - Set the usable IOVA ranges
- * for a given IOMMU MR region
- *
- * @iommu: IOMMU memory region
- * @iova_ranges: list of ordered IOVA ranges (at least one range)
- * @errp: pointer to Error*, to store an error if it happens.
- */
-int memory_region_iommu_set_iova_ranges(IOMMUMemoryRegion *iommu,
-                                        GList *iova_ranges,
-                                        Error **errp);
-
 /**
  * memory_region_name: get a memory region's name
  *
diff --git a/system/memory.c b/system/memory.c
index a229a79988..b2fb12f87f 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1909,19 +1909,6 @@ int memory_region_iommu_set_page_size_mask(IOMMUMemoryRegion *iommu_mr,
     return ret;
 }
 
-int memory_region_iommu_set_iova_ranges(IOMMUMemoryRegion *iommu_mr,
-                                        GList *iova_ranges,
-                                        Error **errp)
-{
-    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
-    int ret = 0;
-
-    if (imrc->iommu_set_iova_ranges) {
-        ret = imrc->iommu_set_iova_ranges(iommu_mr, iova_ranges, errp);
-    }
-    return ret;
-}
-
 int memory_region_register_iommu_notifier(MemoryRegion *mr,
                                           IOMMUNotifier *n, Error **errp)
 {
-- 
2.41.0


