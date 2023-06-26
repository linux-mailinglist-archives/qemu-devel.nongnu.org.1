Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C090573E0E8
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:43:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlNa-0006Qy-P3; Mon, 26 Jun 2023 08:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlMO-0005CN-OB
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:30:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlML-0003Yb-S5
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+soq26ZepC8faaYCkqmuSnarz0mIzjpYMkOIqTdrGHs=;
 b=MLWPQQupHnpgofXPRcYMZfkELirAh76M4+dQ3Y8CNEPhnQMmdzzbkEHFW/nIQs8Px8pCQG
 ddY9wJFu6NERlSM/teQrdbmDGGxM4pv9/LlbAFYGxL2Xni5Ls2mE5/FFIJOMZ4kwwCBglG
 Io1mfBJ7YUgYdwFfmEMxANa/B4Jur1o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-u9HwtRNAMVy9wwCi3LYC1w-1; Mon, 26 Jun 2023 08:30:19 -0400
X-MC-Unique: u9HwtRNAMVy9wwCi3LYC1w-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3112808cd0cso2052279f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782618; x=1690374618;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+soq26ZepC8faaYCkqmuSnarz0mIzjpYMkOIqTdrGHs=;
 b=MffPbTVIacVx4uynFwWSsOmT7gbDbU/TDcObYXJiYuOWvCj1fI/JrIRkSA2D1w/EMP
 u7UgfB7Ti2OJ+L+++RnjmdEGY4zkwqGtakpzpYkEDjI/Ko/A/Wgo9hVzzYVs3vxdy/X7
 w1sjhpFlbe855TnXVVBvmsP+OFZ/P/KTzk92ASVzgkwDRh0nLL6IZLQgGy1bkjejvhwt
 VLo2pXsuOx1h4dapqZmZkNwI2ZrTz7pV+zoOwUcEpF3L0FwKL8I/pFu5kdmwqqesPrF1
 3QYsuncoldrvlgXpBDZeU/ulL1xrpg36dlcEqfL6oUiWpuFLGnsisoqYudh8I4n/U6XQ
 HZYQ==
X-Gm-Message-State: AC+VfDyoV9fS6PFd7zSGb3p19B9i/3FVoRPftX914GwzG2M/h04MvfpN
 wXHHu2VN1dKzlXG8PSk96OqcbeQ6zOSBkYo61i/u7k/GH18UcmoHkfx77dKf1jbxFEEzwhVhqvm
 7CrrpKP8aZ85qX88NDy0moWGlYcJrv6fzKKFF7iXf9u6lQwgNH5ln9cDUjq024hUocZMi
X-Received: by 2002:adf:e74f:0:b0:313:f7a1:3d8d with SMTP id
 c15-20020adfe74f000000b00313f7a13d8dmr455873wrn.63.1687782618092; 
 Mon, 26 Jun 2023 05:30:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6zSsOySa/hgu19pzZuqG+orkFzEXYHtK7AewnxoMA2dBMyNU3vUNii4lWoH1KPhmWezESXEA==
X-Received: by 2002:adf:e74f:0:b0:313:f7a1:3d8d with SMTP id
 c15-20020adfe74f000000b00313f7a13d8dmr455843wrn.63.1687782617631; 
 Mon, 26 Jun 2023 05:30:17 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 s8-20020adff808000000b00313e23edbd5sm6840751wrp.102.2023.06.26.05.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:30:17 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:30:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 49/53] intel_iommu: Fix a potential issue in VFIO dirty page
 sync
Message-ID: <d9acc3fa87f9e6cbedd6702f6d042ffe81a40b49.1687782442.git.mst@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687782442.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Peter Xu found a potential issue:

"The other thing is when I am looking at the new code I found that we
actually extended the replay() to be used also in dirty tracking of vfio,
in vfio_sync_dirty_bitmap().  For that maybe it's already broken if
unmap_all() because afaiu log_sync() can be called in migration thread
anytime during DMA so I think it means the device is prone to DMA with the
IOMMU pgtable quickly erased and rebuilt here, which means the DMA could
fail unexpectedly.  Copy Alex, Kirti and Neo."

Fix it by replacing the unmap_all() to only evacuate the iova tree
(keeping all host mappings untouched, IOW, don't notify UNMAP), and
do a full resync in page walk which will notify all existing mappings
as MAP. This way we don't interrupt with any existing mapping if there
is (e.g. for the dirty sync case), meanwhile we keep sync too to latest
(for moving a vfio device into an existing iommu group).

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20230615032626.314476-2-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 94d52f4205..34af12f392 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3825,13 +3825,10 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
     IntelIOMMUState *s = vtd_as->iommu_state;
     uint8_t bus_n = pci_bus_num(vtd_as->bus);
     VTDContextEntry ce;
+    DMAMap map = { .iova = 0, .size = HWADDR_MAX };
 
-    /*
-     * The replay can be triggered by either a invalidation or a newly
-     * created entry. No matter what, we release existing mappings
-     * (it means flushing caches for UNMAP-only registers).
-     */
-    vtd_address_space_unmap(vtd_as, n);
+    /* replay is protected by BQL, page walk will re-setup it safely */
+    iova_tree_remove(vtd_as->iova_tree, map);
 
     if (vtd_dev_to_context_entry(s, bus_n, vtd_as->devfn, &ce) == 0) {
         trace_vtd_replay_ce_valid(s->root_scalable ? "scalable mode" :
-- 
MST


