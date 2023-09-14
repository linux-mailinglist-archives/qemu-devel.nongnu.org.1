Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E977A0640
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 15:40:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgmYR-0001as-Fj; Thu, 14 Sep 2023 09:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qgmYL-0001Wo-EG
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 09:38:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qgmYI-00056u-Q5
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 09:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694698717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8krgu7SjpZQSk8RcsUTkY2dK6xz/Np1YkmMHVnP5aSk=;
 b=L6Gd0ZpIN3x4Ie70/ipnqoh04nGehW6VXVt1McK7lBmIF0CrNK79LO6D7yKddkxeVtq9WJ
 Dv1u31KxtvmcQBaJvtizQkJ/W+2KH7GXK/kjN+exUUJCg5DTDXtAnV02Ty0GyyGrrZg/xW
 I9aQA34VaYLMbwejY0rjhhEbr5u+fsw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-URX8AGwdMu2G_dQTiNMjXw-1; Thu, 14 Sep 2023 09:38:36 -0400
X-MC-Unique: URX8AGwdMu2G_dQTiNMjXw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-401db0c9d3eso7275495e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 06:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694698715; x=1695303515;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8krgu7SjpZQSk8RcsUTkY2dK6xz/Np1YkmMHVnP5aSk=;
 b=kIYNVzhGkf9UGHnMbARiXd2Kl0ir814GCDCUIDpxuadNDL8hHKdyk1SQ7UWHQYUc2K
 wpP/blr87EQkwgZuQu3GbZkHrWd7jW2bxG6kFkSKxd6c3zpYm5/7mRyn0f+TgAjFh2IL
 IlrqpxBjqkMRIISwW9HmOJtZ8xEJh0CyYdT4KGSL9Gcj7jcUwdOK2uhGZuFBi6HYfN90
 jDjg9JxOwcHW0Qr7w+cnLNNiULVaSWhMrO3EXQC9lNiuv1ftHhrbiUAQJHinwBjaLo80
 9yaT6QppmPTUTi9x+z/Wf7iaKhbE8AG++Ug28c0rq6V5n1Y7ruVpyXMVlPgcWdPo7hNm
 Q0dg==
X-Gm-Message-State: AOJu0YywLAVjP4UjUxJ9jXVjqpYr1+ZrNdceVyCulTMxVpW1GPl974xv
 l59kZjcoe2zdAsHrcffNhzZo+nqBx+1HjVfQgB9787Jv8CZoMqwHet8y/spekVpC168Ruim1vuy
 r25qw84weF+wpspU=
X-Received: by 2002:a7b:cd88:0:b0:401:c52c:5ed9 with SMTP id
 y8-20020a7bcd88000000b00401c52c5ed9mr4780324wmj.32.1694698714915; 
 Thu, 14 Sep 2023 06:38:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG933se9itCQP3zdWeEipX5uoWGyiK1FoZj7oJHIV0jbe4trkji+36QvEwF2LQX3oFJXhl9GA==
X-Received: by 2002:a7b:cd88:0:b0:401:c52c:5ed9 with SMTP id
 y8-20020a7bcd88000000b00401c52c5ed9mr4780299wmj.32.1694698714533; 
 Thu, 14 Sep 2023 06:38:34 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 u20-20020a05600c211400b003fe1fe56202sm2004143wml.33.2023.09.14.06.38.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 06:38:34 -0700 (PDT)
Message-ID: <4912d0d7-ea57-9317-43d7-1971d7b0f2e9@redhat.com>
Date: Thu, 14 Sep 2023 15:38:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/13] memory: Introduce
 memory_region_iommu_set_iova_ranges
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.williamson@redhat.com,
 clg@redhat.com, jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, philmd@linaro.org
References: <20230904080451.424731-1-eric.auger@redhat.com>
 <20230904080451.424731-3-eric.auger@redhat.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230904080451.424731-3-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 04.09.23 10:03, Eric Auger wrote:
> This helper will allow to convey information about valid
> IOVA ranges to virtual IOMMUS.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   include/exec/memory.h | 26 ++++++++++++++++++++++++++
>   softmmu/memory.c      | 15 +++++++++++++++
>   2 files changed, 41 insertions(+)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 184cb3a01b..f6fb99dd3f 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -519,6 +519,27 @@ struct IOMMUMemoryRegionClass {
>        int (*iommu_set_page_size_mask)(IOMMUMemoryRegion *iommu,
>                                        uint64_t page_size_mask,
>                                        Error **errp);
> +    /**
> +     * @iommu_set_iova_ranges:
> +     *
> +     * Propagate information about the usable IOVA ranges for a given IOMMU
> +     * memory region. Used for example to propagate host physical device
> +     * reserved memory region constraints to the virtual IOMMU.
> +     *
> +     * Optional method: if this method is not provided, then the default IOVA
> +     * aperture is used.
> +     *
> +     * @nr_ranges: number of IOVA ranges
> +     *
> +     * @iova_ranges: an array of @nr_ranges usable IOVA ranges
> +     *
> +     * Returns 0 on success, or a negative error. In case of failure, the error
> +     * object must be created.
> +     */
> +     int (*iommu_set_iova_ranges)(IOMMUMemoryRegion *iommu,
> +                                  uint32_t nr_ranges,
> +                                  struct Range *iova_ranges,
> +                                  Error **errp);
>   };
>   
>   typedef struct RamDiscardListener RamDiscardListener;
> @@ -1845,6 +1866,11 @@ int memory_region_iommu_set_page_size_mask(IOMMUMemoryRegion *iommu_mr,
>                                              uint64_t page_size_mask,
>                                              Error **errp);
>   
> +int memory_region_iommu_set_iova_ranges(IOMMUMemoryRegion *iommu,
> +                                        uint32_t nr_ranges,
> +                                        struct Range *iova_ranges,
> +                                        Error **errp);
> +
>   /**
>    * memory_region_name: get a memory region's name
>    *
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index 7d9494ce70..07499457aa 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -1905,6 +1905,21 @@ int memory_region_iommu_set_page_size_mask(IOMMUMemoryRegion *iommu_mr,
>       return ret;
>   }
>   
> +int memory_region_iommu_set_iova_ranges(IOMMUMemoryRegion *iommu_mr,
> +                                        uint32_t nr_ranges,
> +                                        struct Range *iova_ranges,
> +                                        Error **errp)
> +{
> +    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
> +    int ret = 0;
> +
> +    if (imrc->iommu_set_iova_ranges) {
> +        ret = imrc->iommu_set_iova_ranges(iommu_mr, nr_ranges,
> +                                          iova_ranges, errp);
> +    }
> +    return ret;
> +}
> +
>   int memory_region_register_iommu_notifier(MemoryRegion *mr,
>                                             IOMMUNotifier *n, Error **errp)
>   {

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


