Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFA574E207
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:10:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzwN-0002WZ-TS; Mon, 10 Jul 2023 19:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwJ-00028D-SG
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwI-0004ZQ-3d
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e96k/kxAhOznziHvCn8/Sqiu/LbtoiFGXi8Abmjs3vo=;
 b=UWEWoX/5Wr25a6k6kUroE3Kyv6PYkcmrfp17Tvx0p6MKOg4++3hssNyDdyU9arv4aSnOyM
 3AX5tzm2KH7mjARBqLHlKv70b+kvq0qhcKiHzvVcpA3n3Fy6eFUwbqK4jI6E4n8Zbjhrai
 jUmaBi+gLEIXpT533noG1GrP+RlAN/4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-YwbQb7NUPFq_DKPfoc0_Vg-1; Mon, 10 Jul 2023 19:04:45 -0400
X-MC-Unique: YwbQb7NUPFq_DKPfoc0_Vg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fc0094c1bdso24648925e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030283; x=1691622283;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e96k/kxAhOznziHvCn8/Sqiu/LbtoiFGXi8Abmjs3vo=;
 b=ON/ibZB9QQH1jjyNrQzCCJcr42ptnL7Ac0P41kPnb0ZUv+wpS9Bz/KBPgCjCV223Lp
 aFAlp3svSA7e0g2g1rDuKGkhu3S5JWmETXnrpnHb8HBQkF32q6u/ehKE+XmUj62uTUVJ
 NHs6xwtJp2/M80YPZyZbmmAwKvke75mJ7l4BJf6DpqJmZYJ+LdQcvMV748D+nUMP7mUC
 X7a6w8jpc8SWxvrP5jMs74e3rqZ36H5CTk4GkiFyDkI5Tm7aXb8TvkdwB6N0FsYZ1c6N
 T+Q88MQW1FUVTYlzA4iVIX5b0aBFAQ5Of5sCV3rDkPia0zX10PPSTqLFJ76WICx3FHpc
 M4AA==
X-Gm-Message-State: ABy/qLbFpf3vExs429oMtOwHpEL34cR8TjOfGW+kohjdc99OzgHPkAtD
 Xo49xA0Q2WPJ86SeGOaWoJRaH3QppLB7y4DcpW2i6Amsy/MmoLg8XkK4Tg1cNpTAgVonUZreBY7
 5nWzaU0jMRqgjFGGSDmLX/g0kn9IFBpHUIpSSKI9hKfFeGBmimhB2B8O/WW55O2UaNO6V
X-Received: by 2002:a7b:c389:0:b0:3fc:9f:e75c with SMTP id
 s9-20020a7bc389000000b003fc009fe75cmr10669096wmj.11.1689030283589; 
 Mon, 10 Jul 2023 16:04:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHp/2/TOjUyWiaBJxW3lCs74cD2f3zMrKSwa2zGBp+RcRwKa/QcBxYd7/6Prrlqer69OOVgFg==
X-Received: by 2002:a7b:c389:0:b0:3fc:9f:e75c with SMTP id
 s9-20020a7bc389000000b003fc009fe75cmr10669074wmj.11.1689030283188; 
 Mon, 10 Jul 2023 16:04:43 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 z9-20020a1c4c09000000b003fa74bff02asm932968wmf.26.2023.07.10.16.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:04:42 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:04:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PULL 47/66] virtio-iommu: Rework the traces in
 virtio_iommu_set_page_size_mask()
Message-ID: <587a7641d53055054d68d67d94c9408ef808f127.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

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
Message-Id: <20230705165118.28194-3-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 hw/virtio/virtio-iommu.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 8d0c5e3f32..201127c488 100644
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
+            error_setg(errp, "virtio-iommu %s does not support frozen granule 0x%llx",
+                       mr->parent_obj.name, BIT_ULL(cur_granule));
             return -1;
-        } else if (new_mask != cur_mask) {
-            warn_report("virtio-iommu page mask 0x%"PRIx64
-                        " does not match 0x%"PRIx64, cur_mask, new_mask);
         }
         return 0;
     }
-- 
MST


