Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB4D746FB0
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 13:16:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGe0l-0002ja-6F; Tue, 04 Jul 2023 07:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qGe0a-0002hj-DQ
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 07:15:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qGe0W-0007yx-Ds
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 07:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688469343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ypEP/NT8IxiszDOugkjgPdfbbvRW0XffouojgQcGeOU=;
 b=TwKZ2NzhvCkl18ztUZuQGxyWc7DVRy/h/q8xg0kjYp7adpdQ1qyJfvu59Q7MdXWzfuEr3n
 TFgUk/8KMfPdGW19mOcjd2ZYLQmzvYhbTDwcUJdZGW3SuKeUKcXbW0PbkVPCnIg2Yus+Xu
 fl/0GqbDAX8WwElX+ZitcqbucyLJNQI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-656-slBKrhTXMGCzju5lEFZr_g-1; Tue, 04 Jul 2023 07:15:40 -0400
X-MC-Unique: slBKrhTXMGCzju5lEFZr_g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F04FA805C3F;
 Tue,  4 Jul 2023 11:15:39 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.194.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0722F492C13;
 Tue,  4 Jul 2023 11:15:37 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org,
 zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, clg@redhap.com, bharat.bhushan@nxp.com,
 peter.maydell@linaro.org
Subject: [PATCH 2/2] virtio-iommu: Rework the trace in
 virtio_iommu_set_page_size_mask()
Date: Tue,  4 Jul 2023 13:15:27 +0200
Message-Id: <20230704111527.3424992-3-eric.auger@redhat.com>
In-Reply-To: <20230704111527.3424992-1-eric.auger@redhat.com>
References: <20230704111527.3424992-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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
by the driver

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/virtio/virtio-iommu.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 1eaf81bab5..0d9f7196fe 100644
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


