Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C411710B7B
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 13:52:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q29W8-0000pz-KA; Thu, 25 May 2023 07:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q29W6-0000ph-Nu
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:52:26 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q29W5-0005ey-4Q
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:52:26 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-30a892c45c4so1337871f8f.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 04:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685015543; x=1687607543;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0oqRax4MlyMzhzeXFryR9eQyY3DxKwGrC69JW+tBCro=;
 b=EbJWBXH8h2qd79CXLSKXqaSMZqbBGELT4rGCRIiT4BhHOJZzgXWVlUMDA5dJyjVcpP
 GKBDUbSOSXmtPCWhHpt6u3Jne7HgoBkC80p0s4z2ZDZgU1wO0CnpndRYS1aEhXObpXw5
 7XdCb9QGlhkhFdDJ+cTSGYhXC4SISwQ5gQ/ZtRJfXeKumVmMOXbvyX8KxDmfIWtZgbdu
 0DZp4KsWdRm0hmew6UEbfKLS/vw1G1By2J9ruYW37nQLnwM+7VYfku/NPVGF8oyujcCc
 WtjOlTwkoopztj7IzoxJgeXlVhD6rSf8llzZfKmwSP8POYjs3iwzlGx4KCvs5r4izrGf
 gU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685015543; x=1687607543;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0oqRax4MlyMzhzeXFryR9eQyY3DxKwGrC69JW+tBCro=;
 b=W8wI8Xrl5NrY0c4faWrGxcgTbLXLPMi2hpHvzlTW9914CEM8zOshUSWvpUsMTUeKid
 K2G5lHfHfYRk2Bs+TlL7bPefR5go85+VnZfSvEKgfI6HB+c58tDPhL/AdnhHcgv7uXCM
 OC0mhmf76YoyLndSI2ZiEo8uwM3v9Wa++3AhlgDFeu6mXSQppmdjvAkcHkZXb9KEmSIs
 6Guq97n0ifJfGMYkDFY5UsHtiIXlYbA1Y0uAY1TUprKfbPNMch8oh3w7pNUz3TqE73j/
 XeXiwGAvQcVy14yXzfQiGTmst9e0QxpkFMh1hQlVjIsk+F1QJ26I91nfi9F1S/FXf+Hd
 mDGw==
X-Gm-Message-State: AC+VfDzQ3LV0AXxJH/8Pwkn8iO326Xl9tKgpXLcnkCOKUKY3AI54txVK
 KEEzNNvHCd6Z8cQouRWat/M2Vg==
X-Google-Smtp-Source: ACHHUZ7nEnXcAY4Lcqafb6HOwTWWLaKo9KfsbLw9hlyTh7YIE2lVwgyCUEWexMdCRfOtXxO2mlbrJQ==
X-Received: by 2002:a5d:6806:0:b0:306:5149:3aa8 with SMTP id
 w6-20020a5d6806000000b0030651493aa8mr1878387wru.24.1685015543361; 
 Thu, 25 May 2023 04:52:23 -0700 (PDT)
Received: from [192.168.69.115] (cor91-h02-176-184-30-254.dsl.sta.abo.bbox.fr.
 [176.184.30.254]) by smtp.gmail.com with ESMTPSA id
 y3-20020a5d4703000000b002f103ca90cdsm1536311wrq.101.2023.05.25.04.52.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 04:52:22 -0700 (PDT)
Message-ID: <f161aafa-6613-1f4e-4f0e-f426f760787b@linaro.org>
Date: Thu, 25 May 2023 13:52:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] hw/vfio: Add nr of dirty pages to
 vfio_get_dirty_bitmap tracepoint
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20230525114321.71066-1-joao.m.martins@oracle.com>
 <20230525114321.71066-3-joao.m.martins@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230525114321.71066-3-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Joao,

On 25/5/23 13:43, Joao Martins wrote:
> Include the number of dirty pages on the vfio_get_dirty_bitmap tracepoint.
> These are fetched from the newly added return value in
> cpu_physical_memory_set_lebitmap().
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   hw/vfio/common.c     | 7 ++++---
>   hw/vfio/trace-events | 2 +-
>   2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 4d01ea351515..3c9af2fed1b1 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1747,6 +1747,7 @@ static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
>       bool all_device_dirty_tracking =
>           vfio_devices_all_device_dirty_tracking(container);
>       VFIOBitmap vbmap;
> +    uint64_t dirty;

Could we rename this 'dirty_pages'?

>       int ret;
>   
>       if (!container->dirty_pages_supported && !all_device_dirty_tracking) {
> @@ -1771,11 +1772,11 @@ static int vfio_get_dirty_bitmap(VFIOContainer *container, uint64_t iova,
>           goto out;
>       }
>   
> -    cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
> -                                           vbmap.pages);
> +    dirty = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
> +                                                   vbmap.pages);
>   
>       trace_vfio_get_dirty_bitmap(container->fd, iova, size, vbmap.size,
> -                                ram_addr);
> +                                ram_addr, dirty);
>   out:
>       g_free(vbmap.bitmap);
>   
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index 646e42fd27f9..9265a406eda1 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -120,7 +120,7 @@ vfio_region_sparse_mmap_header(const char *name, int index, int nr_areas) "Devic
>   vfio_region_sparse_mmap_entry(int i, unsigned long start, unsigned long end) "sparse entry %d [0x%lx - 0x%lx]"
>   vfio_get_dev_region(const char *name, int index, uint32_t type, uint32_t subtype) "%s index %d, %08x/%08x"
>   vfio_dma_unmap_overflow_workaround(void) ""
> -vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start) "container fd=%d, iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64
> +vfio_get_dirty_bitmap(int fd, uint64_t iova, uint64_t size, uint64_t bitmap_size, uint64_t start, uint64_t dirty) "container fd=%d, iova=0x%"PRIx64" size= 0x%"PRIx64" bitmap_size=0x%"PRIx64" start=0x%"PRIx64" dirty=%"PRIu64

Ditto.

>   vfio_iommu_map_dirty_notify(uint64_t iova_start, uint64_t iova_end) "iommu dirty @ 0x%"PRIx64" - 0x%"PRIx64
>   
>   # platform.c


