Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E58D273DF6C
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:39:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlO4-0007fC-14; Mon, 26 Jun 2023 08:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlMT-0005iA-Cn
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:30:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDlMR-0003aG-Bw
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:30:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687782626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y/mhZ4QWgJNUg3jo6CnB3dDNtW+V95gDB4rMrHURtvQ=;
 b=PWA2nQHqAO0QEIPLm20seSTmZlzfipmZWHHh0WIkoMlkeF04K7isBEFoojS3GsZeXY61c8
 aG1eU2U8N5obBeTYU3seb83gbtNu5Yzrk9grIE/XyBEM8MjTeHXjF3amT8j5opluMxgIQE
 cWJXIssIx3BmnpMZIpHbAQOJ5BR928w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-R4e_EnHsOrGjaCmaOi417g-1; Mon, 26 Jun 2023 08:30:25 -0400
X-MC-Unique: R4e_EnHsOrGjaCmaOi417g-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3128319d532so2450596f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 05:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687782624; x=1690374624;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/mhZ4QWgJNUg3jo6CnB3dDNtW+V95gDB4rMrHURtvQ=;
 b=D7tYjBX6W7AMBgMwk4ntjakZC7Um1QMS+z3uVwpiitGQJE5mBdwvOUR4EfOZDo8MBw
 ZCeG9oTOdBKtgZ8OGP+J1N7DI3lq8Tt87N+yEeZACHOsvgRiyn4OFfnbmcL/WsVvzUcp
 Aor8A5jHwxd3dY3YOx2VPqYQaQnS3216rJzAi/nutmPP9j9Ky8Gpnt5jgZjWRAeVIFN4
 wL8sTt6mROIpd2ZUdUDXjMgqmPCv7+1hSc0kh/5GoxIdhsTuqI+aiiZozoCGR35tPXi1
 pwMnuoTeCzR3mPkKzC3BMJxzpeNvImU6uTElZg1cmEMl/Hpd/GGNlViT7U7gPPhVNusJ
 VZ+g==
X-Gm-Message-State: AC+VfDy9lesbFiohoZXjvzYVb/CBPeIxlQBGpqgLjg0x4s1eQmmdwVm0
 9yXTqSj18ANzXkJT6vh2kk4sAdkQ8krfMBk4RSMPhkaziUL/kbG7ozFUyV3Fzo7fOQ1tk763L6n
 +9zrtq1IvpQb/9bNhSZdSpTQOV49gyo07+zWzKFeNKG8/C2xJKBF1nCqaEhviea/PHaWS
X-Received: by 2002:a05:6000:42:b0:313:e2c4:7bd1 with SMTP id
 k2-20020a056000004200b00313e2c47bd1mr5649805wrx.42.1687782623974; 
 Mon, 26 Jun 2023 05:30:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7TV1EBgns2sFka4Z9o4Hklnhp5jXOiTWmJori+94UHuWt1NGhCKQNiCQ7dz3MQqqZ7zRit2g==
X-Received: by 2002:a05:6000:42:b0:313:e2c4:7bd1 with SMTP id
 k2-20020a056000004200b00313e2c47bd1mr5649787wrx.42.1687782623652; 
 Mon, 26 Jun 2023 05:30:23 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 u14-20020adfdb8e000000b003112ab916cdsm7357579wri.73.2023.06.26.05.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 05:30:23 -0700 (PDT)
Date: Mon, 26 Jun 2023 08:30:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 51/53] intel_iommu: Fix address space unmap
Message-ID: <0dd5bcd98d5a89f833c7d06b28ad92965874bc72.1687782442.git.mst@redhat.com>
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

During address space unmap, corresponding IOVA tree entries are
also removed. But DMAMap is set beyond notifier's scope by 1, so
in theory there is possibility to remove a continuous entry above
the notifier's scope but falling in adjacent notifier's scope.

There is no issue currently as no use cases allocate notifiers
continuously, but let's be robust.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20230615032626.314476-4-zhenzhong.duan@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/intel_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index f046f85913..dcc334060c 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3791,7 +3791,7 @@ static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
                              n->start, size);
 
     map.iova = n->start;
-    map.size = size;
+    map.size = size - 1; /* Inclusive */
     iova_tree_remove(as->iova_tree, map);
 }
 
-- 
MST


