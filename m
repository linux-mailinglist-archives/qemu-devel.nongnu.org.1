Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0FC76F5AC
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 00:23:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRggp-0004KI-Vb; Thu, 03 Aug 2023 18:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRggn-0004IM-5f
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRggl-0000Pc-H4
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691101258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1h7+g+N6hbLN5/8qfmJxQmtr/si4n71Og3ybh5W/K5c=;
 b=fUbJKwkIcKjOCzsaRPfHAhIvPPfOI/A+U0vhX1DboWY0tbwYepNv3blezLtXBTqh2c/LL+
 kZbtGN+qvWxAwiB3pQcbCzIYIgwk7wvFjt5fBgdBMl7bfKHzZlGEuDgGM5/U4zlnLvef9a
 RWyg9G6CLP2WrsQD6x4fn2rdgN5EKv0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-PDwwZdAgOrKCTatdTa6UFg-1; Thu, 03 Aug 2023 18:20:57 -0400
X-MC-Unique: PDwwZdAgOrKCTatdTa6UFg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5230e9ef0e6so814880a12.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 15:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691101256; x=1691706056;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1h7+g+N6hbLN5/8qfmJxQmtr/si4n71Og3ybh5W/K5c=;
 b=hZhB7w0CZ/SMm5HbVrAKdE0Oyvt0nM9BQynzMvkvdQdOxAG5G6IhKeOi136hah5QWx
 z+2UEI3kRBVxi+W/frlumQEE+aaBgZmvqycG7ahFKWKzgbxxxNFRPa8O1EkO+6QI6bKz
 BTeMLeChdNxNjKClU672Ay3R5kcbelzp0IOJ7vgGVce7+dfjI4R+1egKDiCkd4yRnLXm
 Pt+qisyO1J48RHD9uh3nBrDoRSDRvVL/tPOiUz/0HBnjMM4QOVWsp/4pyODPQtOJbdAi
 g4wU/mVyI5/K4Y4AcnQRtmi5iOkANFzBnT+P3kUQ6WCEc8V8Qb3IHQ3g499a+fOasaZ3
 +ttg==
X-Gm-Message-State: AOJu0YzHa+AjtIsXUdl4Ty8L9TJrenn0cogFHUTD3kuy3ZSAxFewMm8L
 +A3GIi4Vbs9O8WJ4tJnveI0Zsyv/iaWKx42B4csal0Qy36bSbHuNdu3kDlb8j5FToVqXGq9ihsR
 GgpZXp0as43KRitr1tkq3yrL7/LoNamXIZHhWUuCldM2TP1nbn6auBs7xvgzcbMaMnKdn
X-Received: by 2002:aa7:db5a:0:b0:522:3ef1:b1d with SMTP id
 n26-20020aa7db5a000000b005223ef10b1dmr84303edt.6.1691101256061; 
 Thu, 03 Aug 2023 15:20:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGOnkIAj/f8xCwB3pt2aL5a10Fxkf8ZpmWBLD111I1CEC6z7o1h7USZr3UF8tNOYt1frBB2A==
X-Received: by 2002:aa7:db5a:0:b0:522:3ef1:b1d with SMTP id
 n26-20020aa7db5a000000b005223ef10b1dmr84291edt.6.1691101255808; 
 Thu, 03 Aug 2023 15:20:55 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 d14-20020aa7d5ce000000b00522b7c5d53esm358083eds.54.2023.08.03.15.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 15:20:55 -0700 (PDT)
Date: Thu, 3 Aug 2023 18:20:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PULL 03/22] virtio-iommu: Standardize granule extraction and
 formatting
Message-ID: <1084feddc6a677cdfdde56936bfb97cf32cc4dee.1691101215.git.mst@redhat.com>
References: <cover.1691101215.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1691101215.git.mst@redhat.com>
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

At several locations we compute the granule from the config
page_size_mask using ctz() and then format it in traces using
BIT(). As the page_size_mask is 64b we should use ctz64 and
BIT_ULL() for formatting. We failed to be consistent.

Note the page_size_mask is garanteed to be non null. The spec
mandates the device to set at least one bit, so ctz64 cannot
return 64. This is garanteed by the fact the device
initializes the page_size_mask to qemu_target_page_mask()
and then the page_size_mask is further constrained by
virtio_iommu_set_page_size_mask() callback which can't
result in a new mask being null. So if Coverity complains
round those ctz64/BIT_ULL with CID 1517772 this is a false
positive

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Fixes: 94df5b2180 ("virtio-iommu: Fix 64kB host page size VFIO device assignment")
Message-Id: <20230718182136.40096-1-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 hw/virtio/virtio-iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 4dcf1d5c62..be51635895 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -854,17 +854,19 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     VirtIOIOMMUEndpoint *ep;
     uint32_t sid, flags;
     bool bypass_allowed;
+    int granule;
     bool found;
     int i;
 
     interval.low = addr;
     interval.high = addr + 1;
+    granule = ctz64(s->config.page_size_mask);
 
     IOMMUTLBEntry entry = {
         .target_as = &address_space_memory,
         .iova = addr,
         .translated_addr = addr,
-        .addr_mask = (1 << ctz32(s->config.page_size_mask)) - 1,
+        .addr_mask = BIT_ULL(granule) - 1,
         .perm = IOMMU_NONE,
     };
 
@@ -1117,7 +1119,7 @@ static int virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
     if (s->granule_frozen) {
         int cur_granule = ctz64(cur_mask);
 
-        if (!(BIT(cur_granule) & new_mask)) {
+        if (!(BIT_ULL(cur_granule) & new_mask)) {
             error_setg(errp, "virtio-iommu %s does not support frozen granule 0x%llx",
                        mr->parent_obj.name, BIT_ULL(cur_granule));
             return -1;
@@ -1163,7 +1165,7 @@ static void virtio_iommu_freeze_granule(Notifier *notifier, void *data)
     }
     s->granule_frozen = true;
     granule = ctz64(s->config.page_size_mask);
-    trace_virtio_iommu_freeze_granule(BIT(granule));
+    trace_virtio_iommu_freeze_granule(BIT_ULL(granule));
 }
 
 static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
-- 
MST


