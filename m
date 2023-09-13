Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8AD79E841
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 14:44:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgPDn-0001x6-Av; Wed, 13 Sep 2023 08:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qgPDj-0001wb-7R
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:43:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qgPDg-0008Hs-Mi
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694609026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yRRXz5abAmrfuNK69eRoRPCU5vQoBVAknXWz/PNhH2Q=;
 b=akxJ/GfEsSz4ufzh+41mNiVuPImKuj40stD5eFB8xDId5Banv0Y0/doPsboc75DA7HCAs0
 cK8Y9FTbvVpkb6rRIg3Q1lCzhgSAe47ES8jHYbXuIuiGQZYFpNDGYVcyrmQW0t1QDySOPu
 edVoINfZvCWKlVFctDZpKHYQc2uh4jA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507--giDTcYVPq6mNLM4pUErzw-1; Wed, 13 Sep 2023 08:43:45 -0400
X-MC-Unique: -giDTcYVPq6mNLM4pUErzw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-401db2550e0so55379165e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 05:43:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694609024; x=1695213824;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yRRXz5abAmrfuNK69eRoRPCU5vQoBVAknXWz/PNhH2Q=;
 b=V54To7TDlzsFSm7DXqP/TK7ioijZ/T6xDHEKUw781exG4yuCDcq6XaEP3ePV910fr5
 EynHDxsQk/XapMHAFtSY36HFGSaRPYt3hlVDSefMnyvUbkJ1hJ6F9PVm7Q9fivebNT4I
 BaNwj/s1qyOEDfN36C8cOdu+7QAGXMisbmMBE6cukj5EMsKULcDXJmN+Pyu5w/LW4Duf
 vqGEUoxa2GMY5mveTHLnwmnztrgnjrPtJ0CpxF9/4pJXaxUrTEafEA5waQKZV2k3ygWO
 7n6O161ubBnEdP8Nw0/aGJq3GkbcVkTSekdRg12ipjELXDBj5OJk4TN/l0Q135fzjOLE
 2VKQ==
X-Gm-Message-State: AOJu0YyMENijh8NZISvswigDTSxBswGfdeEQHeF+rqx2jRbAAxHQXQ/f
 IicPu+a3k09p99+y8PQNNrV1rZbcrK9g9zM48/HzKVZGVBt+XDF8N24dae4ki7D1ksRTTdMTMgP
 vZjegDoK/vmtnOUY=
X-Received: by 2002:a05:600c:2150:b0:402:95a0:b2ae with SMTP id
 v16-20020a05600c215000b0040295a0b2aemr1933441wml.32.1694609024301; 
 Wed, 13 Sep 2023 05:43:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs2R0x4RBqKKLnGnpljqQ6rrF7NRiPk1j+4As5/wPCf69+v+1XprkKw5DHPn0SDjHF3XgSBA==
X-Received: by 2002:a05:600c:2150:b0:402:95a0:b2ae with SMTP id
 v16-20020a05600c215000b0040295a0b2aemr1933407wml.32.1694609023797; 
 Wed, 13 Sep 2023 05:43:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 q5-20020a7bce85000000b004013797efb6sm1966912wmj.9.2023.09.13.05.43.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 05:43:43 -0700 (PDT)
Message-ID: <b79903b5-1f9c-68ae-0b4b-e4bf94e44281@redhat.com>
Date: Wed, 13 Sep 2023 14:43:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 02/12] memory: Introduce
 memory_region_iommu_set_iova_ranges
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.williamson@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org
References: <20230913080423.523953-1-eric.auger@redhat.com>
 <20230913080423.523953-3-eric.auger@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230913080423.523953-3-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/13/23 10:01, Eric Auger wrote:
> This helper will allow to convey information about valid
> IOVA ranges to virtual IOMMUS.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

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


