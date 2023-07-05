Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91674748981
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 18:52:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH5jR-0002Mh-Rh; Wed, 05 Jul 2023 12:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qH5jC-0002LB-CT
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 12:51:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qH5jA-0006nY-Tg
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 12:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688575900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B+jWD8J30spDME4DbjhwZSLOayYk9MvKNCF70X1UfdM=;
 b=Vr/1S3rr34B7Vh2x3k8+BO/Wib/9ALP3peMHrcaeTbk5VtKGzceFOnr1KDL4bEudrh6kgG
 BOeSun8dkv2Z0PaS22QqKw8DLZVegYIq+WX88NXBfaWCF4bloYL6+zTbgtWT28smWYQ5GR
 rhTQARKkqKf6+yGGzcB1jgXt3dK4dec=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-mtgGoX5TOgKlH4o1dTBOHw-1; Wed, 05 Jul 2023 12:51:36 -0400
X-MC-Unique: mtgGoX5TOgKlH4o1dTBOHw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DFCF38294A5;
 Wed,  5 Jul 2023 16:51:35 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3140C1121314;
 Wed,  5 Jul 2023 16:51:32 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, clg@redhat.com, bharat.bhushan@nxp.com,
 peter.maydell@linaro.org
Subject: [PATCH v2 2/2] virtio-iommu: Rework the traces in
 virtio_iommu_set_page_size_mask()
Date: Wed,  5 Jul 2023 18:51:18 +0200
Message-Id: <20230705165118.28194-3-eric.auger@redhat.com>
In-Reply-To: <20230705165118.28194-1-eric.auger@redhat.com>
References: <20230705165118.28194-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The current error messages in virtio_iommu_set_page_size_mask()
sound quite similar for different situations and miss the IOMMU
memory region that causes the issue.

Clarify them and rework the comment.

Also remove the trace when the new page_size_mask is not applied as
the current frozen granule is kept. This message is rather confusing
for the end user and anyway the current granule would have been used
by the driver.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/virtio/virtio-iommu.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 8d0c5e3f32..4b711ddd09 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -1101,29 +1101,24 @@ static int virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
                                           new_mask);
 
     if ((cur_mask & new_mask) == 0) {
-        error_setg(errp, "virtio-iommu page mask 0x%"PRIx64
-                   " is incompatible with mask 0x%"PRIx64, cur_mask, new_mask);
+        error_setg(errp, "virtio-iommu %s reports a page size mask 0x%"PRIx64
+                   " incompatible with currently supported mask 0x%"PRIx64,
+                   mr->parent_obj.name, new_mask, cur_mask);
         return -1;
     }
 
     /*
      * Once the granule is frozen we can't change the mask anymore. If by
      * chance the hotplugged device supports the same granule, we can still
-     * accept it. Having a different masks is possible but the guest will use
-     * sub-optimal block sizes, so warn about it.
+     * accept it.
      */
     if (s->granule_frozen) {
-        int new_granule = ctz64(new_mask);
         int cur_granule = ctz64(cur_mask);
 
-        if (new_granule != cur_granule) {
-            error_setg(errp, "virtio-iommu page mask 0x%"PRIx64
-                       " is incompatible with mask 0x%"PRIx64, cur_mask,
-                       new_mask);
+        if (!(BIT(cur_granule) & new_mask)) {
+            error_setg(errp, "virtio-iommu %s does not support frozen granule 0x%"PRIx64,
+                       mr->parent_obj.name, BIT(cur_granule));
             return -1;
-        } else if (new_mask != cur_mask) {
-            warn_report("virtio-iommu page mask 0x%"PRIx64
-                        " does not match 0x%"PRIx64, cur_mask, new_mask);
         }
         return 0;
     }
-- 
2.38.1


