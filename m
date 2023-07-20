Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C67C475AC6C
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 12:53:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMRFx-00085q-7M; Thu, 20 Jul 2023 06:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qMRFu-00085H-2R
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 06:51:34 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qMRFr-00061B-9Z
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 06:51:33 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3144098df56so573953f8f.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 03:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689850289; x=1690455089;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eE30xErk1nLgA4oFLynpssqb3i6CEkxKkfn4xlkSUdg=;
 b=ukZUiqQZT6WJrlvJnr/FtNq0xk8fKhOeJl3g2VZGKl+74YkSpeOB/rhSOiw+E37Swm
 uB9UmXcWTIqcK3imakGrO1F/Qv6hbgl2RKT24KeaAn1ca0n9bi6hMZ2a1i0RWlGeNLVR
 YwWaYVCSbkPYhXqhElxEGJgVj2HT6a8VrYLCqtf58Xpit7l7wAmROrkHfF6ZNVaHJyA+
 3PSxvPrFCdYooCrBDBy/82fO8zrahzyZ31Mo0+rEd/f5HF4sg+lYiCYCzyWYJL53LMDu
 8TTzzUSR4i7nqcri/Pmma1htN9EEeJ1qfcN/WgvDoWIoB+q1dw8oNevCcmODGeTf52Md
 agaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689850289; x=1690455089;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eE30xErk1nLgA4oFLynpssqb3i6CEkxKkfn4xlkSUdg=;
 b=JP31Ya8KLZ62M2K7zA4uhcuIqTxfjVUdb+7wsIm3GtnfstcQDZW2etaCSYwNUkdWRR
 x+qlCJ5SaGJ8nooq/7xg2mthUYPR1e+FPQGi05cRwp3t5bllQHnv3TIE8rg6dJmUf3Lx
 ZPJEzW7j7D+mPrK0BdtD1HCLIisnvNdrGk3bo0E+yb1k3K/DVJc+gsWI8jT1aHckXmxw
 G1JUpqTczWrw17/cIUBHs6766OCBaWVzsanm4aguLxipXCbUZdaiBg18FqbmBiNP5Yrp
 QSjGR38MDWzp8th3RW6ov04l0zgz9//e/Z84YlYfROfIF0ZGcvdt1vNBrgjF3bYhkOTo
 Gwcw==
X-Gm-Message-State: ABy/qLZep6M8u0MfwRXdpPmpMgAYIChPPEMfST4B+7nENy/JM2bzurhI
 eh3Rb43ieso+K+8edl/g/UFkNQ==
X-Google-Smtp-Source: APBJJlFSdppm/FaaIGvqQFsf7r2zJPYURTmuglNrEIQuX5JgMgQk19+o6qjFWvyz9pUvaQ5y5DaKmQ==
X-Received: by 2002:adf:ef4c:0:b0:314:4a15:e557 with SMTP id
 c12-20020adfef4c000000b003144a15e557mr1998802wrp.5.1689850289388; 
 Thu, 20 Jul 2023 03:51:29 -0700 (PDT)
Received: from myrica ([2.219.138.198]) by smtp.gmail.com with ESMTPSA id
 q6-20020adff506000000b003141e629cb6sm972878wro.101.2023.07.20.03.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 03:51:28 -0700 (PDT)
Date: Thu, 20 Jul 2023 11:51:32 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 mst@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH for-8.1] virtio-iommu: Standardize granule extraction and
 formatting
Message-ID: <20230720105132.GA59402@myrica>
References: <20230718182136.40096-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718182136.40096-1-eric.auger@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jul 18, 2023 at 08:21:36PM +0200, Eric Auger wrote:
> At several locations we compute the granule from the config
> page_size_mask using ctz() and then format it in traces using
> BIT(). As the page_size_mask is 64b we should use ctz64 and
> BIT_ULL() for formatting. We failed to be consistent.
> 
> Note the page_size_mask is garanteed to be non null. The spec
> mandates the device to set at least one bit, so ctz64 cannot
> return 64. This is garanteed by the fact the device
> initializes the page_size_mask to qemu_target_page_mask()
> and then the page_size_mask is further constrained by
> virtio_iommu_set_page_size_mask() callback which can't
> result in a new mask being null. So if Coverity complains
> round those ctz64/BIT_ULL with CID 1517772 this is a false
> positive
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Fixes: 94df5b2180 ("virtio-iommu: Fix 64kB host page size VFIO device assignment")

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  hw/virtio/virtio-iommu.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 201127c488..c6ee4d7a3c 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -852,17 +852,19 @@ static IOMMUTLBEntry virtio_iommu_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>      VirtIOIOMMUEndpoint *ep;
>      uint32_t sid, flags;
>      bool bypass_allowed;
> +    int granule;
>      bool found;
>      int i;
>  
>      interval.low = addr;
>      interval.high = addr + 1;
> +    granule = ctz64(s->config.page_size_mask);
>  
>      IOMMUTLBEntry entry = {
>          .target_as = &address_space_memory,
>          .iova = addr,
>          .translated_addr = addr,
> -        .addr_mask = (1 << ctz32(s->config.page_size_mask)) - 1,
> +        .addr_mask = BIT_ULL(granule) - 1,
>          .perm = IOMMU_NONE,
>      };
>  
> @@ -1115,7 +1117,7 @@ static int virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
>      if (s->granule_frozen) {
>          int cur_granule = ctz64(cur_mask);
>  
> -        if (!(BIT(cur_granule) & new_mask)) {
> +        if (!(BIT_ULL(cur_granule) & new_mask)) {
>              error_setg(errp, "virtio-iommu %s does not support frozen granule 0x%llx",
>                         mr->parent_obj.name, BIT_ULL(cur_granule));
>              return -1;
> @@ -1161,7 +1163,7 @@ static void virtio_iommu_freeze_granule(Notifier *notifier, void *data)
>      }
>      s->granule_frozen = true;
>      granule = ctz64(s->config.page_size_mask);
> -    trace_virtio_iommu_freeze_granule(BIT(granule));
> +    trace_virtio_iommu_freeze_granule(BIT_ULL(granule));
>  }
>  
>  static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
> -- 
> 2.38.1
> 

