Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E992379E868
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 14:55:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgPOv-0001fo-B5; Wed, 13 Sep 2023 08:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qgPOk-0001fB-8P
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:55:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qgPOh-0003wb-UF
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 08:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694609709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HFmosRU45U7X5JgXGpquJG++AfnEPsHh5itCSA00MBw=;
 b=i6OuodMdBhsDG072SS7o5PxNdB3c6KrKmHMvVF3h50nSmQlhkX6Hnqx0hG+QS7OABv1lXH
 4wktwPZqAIcBqES6PViPsbcO4UmS0Ds2AYFHM+1+N7OUm3TNDGn3qo0X9Td8Sq+SmSBidi
 8+Yf38kvbJZlUpyCl2uPTLOv4WoAJEI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-5_vBD07iNEyLjSrgzB3OPg-1; Wed, 13 Sep 2023 08:55:07 -0400
X-MC-Unique: 5_vBD07iNEyLjSrgzB3OPg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-770eae0b631so615493285a.3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 05:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694609706; x=1695214506;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HFmosRU45U7X5JgXGpquJG++AfnEPsHh5itCSA00MBw=;
 b=Vo0HlXXbishbH1yI0UNdAG/ji8NXTLcqLJmxBqWihX2WZV3dNLPuyKyOIxb58NREio
 uiWjcChWj+MwQVVFAMWMqOTDPF+Jr/82YshpoUejkOmHZYekxRD6K/7Wa1leC42HDtDT
 M3X+nqLocWNs721Ak6ROtA4V7i+zUHDXmOvJcHqAFbCN9K3LPlV9Gu3tprVzeiU5Etw6
 4DoVhjdgLXUMwNOmaW9vqyjF6QjryyrCZqVH0d+1i8OjR9dFgc0AeVUELkMOg22SKgi6
 daS/ZuNNQo2XDVzCZP+hAH/1Yt0dqbwanT9l/IezYGFSGXg/JpUkIjj2+3SD2tZ9f/Qu
 a6oQ==
X-Gm-Message-State: AOJu0Yz1OgxGFhf7w/UXmpX7gtYQPHA8ccTi2+3EUM0CTXhofuaHv6gp
 1IWJFHA9Kxp8z5vl5v8q/9JmS/nlCuUW5P1B37RXBs6XW788dRoV5C/0NAUocUUK8Kw9rLPe0m2
 j15l6xEo8KD7MBVs=
X-Received: by 2002:a05:620a:1a0a:b0:76f:27af:2798 with SMTP id
 bk10-20020a05620a1a0a00b0076f27af2798mr2663777qkb.61.1694609706497; 
 Wed, 13 Sep 2023 05:55:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHs7EqKBcd4QfxaQnnPKJ6yCe470JUSuCq2qulP6DESfBY6/WkUWfmBpmIv9mSLbGzrt0rT/w==
X-Received: by 2002:a05:620a:1a0a:b0:76f:27af:2798 with SMTP id
 bk10-20020a05620a1a0a00b0076f27af2798mr2663745qkb.61.1694609706101; 
 Wed, 13 Sep 2023 05:55:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a05620a158b00b007671cfe8a18sm3869898qkk.13.2023.09.13.05.55.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 05:55:05 -0700 (PDT)
Message-ID: <dd3f27e9-2a4f-5f6b-84d3-13de767024bc@redhat.com>
Date: Wed, 13 Sep 2023 14:55:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 03/12] vfio: Collect container iova range info
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.williamson@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org
References: <20230913080423.523953-1-eric.auger@redhat.com>
 <20230913080423.523953-4-eric.auger@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230913080423.523953-4-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
> Collect iova range information if VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE
> capability is supported.
> 
> This allows to propagate the information though the IOMMU MR
> set_iova_ranges() callback so that virtual IOMMUs
> get aware of those aperture constraints.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   include/hw/vfio/vfio-common.h |  2 ++
>   hw/vfio/common.c              | 45 +++++++++++++++++++++++++++++++++--
>   2 files changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index da43d27352..74b9b27270 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -98,6 +98,8 @@ typedef struct VFIOContainer {
>       QLIST_HEAD(, VFIOGroup) group_list;
>       QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
>       QLIST_ENTRY(VFIOContainer) next;
> +    unsigned nr_iovas;
> +    struct  vfio_iova_range *iova_ranges;
>   } VFIOContainer;
>   
>   typedef struct VFIOGuestIOMMU {
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 9aac21abb7..26da38de05 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1157,6 +1157,14 @@ static void vfio_listener_region_add(MemoryListener *listener,
>               goto fail;
>           }
>   
> +        ret = memory_region_iommu_set_iova_ranges(giommu->iommu_mr,
> +                container->nr_iovas, (struct Range *)container->iova_ranges,
> +                &err);
> +        if (ret) {
> +            g_free(giommu);
> +            goto fail;
> +        }
> +
>           ret = memory_region_register_iommu_notifier(section->mr, &giommu->n,
>                                                       &err);
>           if (ret) {
> @@ -1981,6 +1989,29 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
>       return true;
>   }
>   
> +static void vfio_get_info_iova_range(struct vfio_iommu_type1_info *info,
> +                                     unsigned int *nr_iovas,
> +                                     struct  vfio_iova_range **iova_ranges)

I guess there is no point in returning an error since we can not
assign default values.

> +{
> +    struct vfio_info_cap_header *hdr;
> +    struct vfio_iommu_type1_info_cap_iova_range *cap;
> +
> +    hdr = vfio_get_iommu_type1_info_cap(info,
> +                                        VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE);
> +    if (hdr == NULL) {

May be :

     if (!hdr) {


> +        return;
> +    }
> +
> +    cap = (void *)hdr;
> +    *nr_iovas = cap->nr_iovas;
> +

I would add a trace event with the #iovas.

Thanks,

C.


> +    if (*nr_iovas == 0) {
> +        return;
> +    }
> +    *iova_ranges = g_memdup2(cap->iova_ranges,
> +                             *nr_iovas * sizeof(struct  vfio_iova_range));
> +}
> +
>   static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
>                                             struct vfio_region_info *info)
>   {
> @@ -2433,6 +2464,12 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
>       }
>   }
>   
> +static void vfio_free_container(VFIOContainer *container)
> +{
> +    g_free(container->iova_ranges);
> +    g_free(container);
> +}
> +
>   static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>                                     Error **errp)
>   {
> @@ -2550,6 +2587,10 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>           if (!vfio_get_info_dma_avail(info, &container->dma_max_mappings)) {
>               container->dma_max_mappings = 65535;
>           }
> +
> +        vfio_get_info_iova_range(info, &container->nr_iovas,
> +                                 &container->iova_ranges);
> +
>           vfio_get_iommu_info_migration(container, info);
>           g_free(info);
>   
> @@ -2663,7 +2704,7 @@ enable_discards_exit:
>       vfio_ram_block_discard_disable(container, false);
>   
>   free_container_exit:
> -    g_free(container);
> +    vfio_free_container(container);
>   
>   close_fd_exit:
>       close(fd);
> @@ -2717,7 +2758,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
>   
>           trace_vfio_disconnect_container(container->fd);
>           close(container->fd);
> -        g_free(container);
> +        vfio_free_container(container);
>   
>           vfio_put_address_space(space);
>       }


