Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B1379E189
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 10:07:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKrx-000179-8r; Wed, 13 Sep 2023 04:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qgKru-00012f-AY
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:05:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qgKrr-0004oR-V3
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694592298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U5sWr5o+25aBDxNZTkf3l7WeDqKVgTxJZrGw9QlW9iM=;
 b=LmEz5i0Xlr+tlWnFhLMDyRUZIRk2SZVI6f994xe7qEeT+FqRJuKWZAG3EOR+Xe83CPelx+
 cssdkak8YpNnIdJK6vw4ClSK93Z3FxDCe5l01LcoEQsHfhSUu+HU0mlV+s3FkkHDRP/nh8
 aCDsCj0ExNRw+l0vB74idYeTOFD/nyE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-Jk825qSrNbOCIPHMRFOq0A-1; Wed, 13 Sep 2023 04:04:57 -0400
X-MC-Unique: Jk825qSrNbOCIPHMRFOq0A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E25E856501;
 Wed, 13 Sep 2023 08:04:56 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 363302026D68;
 Wed, 13 Sep 2023 08:04:54 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org
Subject: [PATCH v2 10/12] virtio-iommu: Consolidate host reserved regions and
 property set ones
Date: Wed, 13 Sep 2023 10:01:45 +0200
Message-ID: <20230913080423.523953-11-eric.auger@redhat.com>
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

Up to now we were exposing to the RESV_MEM probe requests the
reserved memory regions set though the reserved-regions array property.

Combine those with the host reserved memory regions if any. Those
latter are tagged as RESERVED. We don't have more information about
them besides then cannot be mapped. Reserved regions set by
property have higher priority.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/virtio/virtio-iommu.c | 17 ++++++++++++++++-
 hw/virtio/trace-events   |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index ed2df5116f..4b22fe7ff1 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -21,6 +21,7 @@
 #include "qemu/log.h"
 #include "qemu/iov.h"
 #include "qemu/range.h"
+#include "qemu/reserved-region.h"
 #include "exec/target_page.h"
 #include "hw/qdev-properties.h"
 #include "hw/virtio/virtio.h"
@@ -630,11 +631,25 @@ static int consolidate_resv_regions(IOMMUDevice *sdev)
     VirtIOIOMMU *s = sdev->viommu;
     int i;
 
+    /* First add host reserved regions if any, all tagged as RESERVED */
+    for (i = 0; i < sdev->nr_host_resv_regions; i++) {
+        ReservedRegion *reg = g_new0(ReservedRegion, 1);
+        reg->range = sdev->host_resv_regions[i];
+        reg->type = VIRTIO_IOMMU_RESV_MEM_T_RESERVED;
+        sdev->resv_regions = resv_region_list_insert(sdev->resv_regions, reg);
+        trace_virtio_iommu_host_resv_regions(sdev->iommu_mr.parent_obj.name, i,
+                                             range_lob(&reg->range),
+                                             range_upb(&reg->range));
+    }
+    /*
+     * then add higher priority reserved regions set through properties by the
+     * machine
+     */
     for (i = 0; i < s->nr_prop_resv_regions; i++) {
         ReservedRegion *reg = g_new0(ReservedRegion, 1);
 
         *reg = s->prop_resv_regions[i];
-        sdev->resv_regions = g_list_append(sdev->resv_regions, reg);
+        sdev->resv_regions = resv_region_list_insert(sdev->resv_regions, reg);
     }
     return 0;
 }
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 7109cf1a3b..796574b0f3 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -134,6 +134,7 @@ virtio_iommu_notify_flag_add(const char *name) "add notifier to mr %s"
 virtio_iommu_notify_flag_del(const char *name) "del notifier from mr %s"
 virtio_iommu_switch_address_space(uint8_t bus, uint8_t slot, uint8_t fn, bool on) "Device %02x:%02x.%x switching address space (iommu enabled=%d)"
 virtio_iommu_freeze_granule(uint64_t page_size_mask) "granule set to 0x%"PRIx64
+virtio_iommu_host_resv_regions(const char *name, uint32_t index, uint64_t lob, uint64_t upb) "mr=%s host-resv-reg[%d] = [0x%"PRIx64",0x%"PRIx64"]"
 
 # virtio-mem.c
 virtio_mem_send_response(uint16_t type) "type=%" PRIu16
-- 
2.41.0


