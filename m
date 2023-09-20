Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D81DD7A73CC
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 09:16:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qirR4-0006RF-B4; Wed, 20 Sep 2023 03:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qirR0-0006QV-QG
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 03:15:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qirQy-0000lV-9M
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 03:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695194136;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUEmT96YJjm1KaUK8UiYdCdnjzUzMBpE39yRbPMJIW8=;
 b=EyEOCdbh+4zMGx/z72keydNXDKgsCthYCTH/nMPMm7sA6HSjIp/uKGGMl/epmbtxCB6bJq
 TNNeriSlWKcNKvx97y48i3riLzuuP/0e4leUuPVqCxykprrnrmvoL5awSza+r499R4ESOA
 SXUGmDmYhSuO2QUd2zhtpOAwfBlFbmc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-5aANrHEfNGCXRTpmGf5sTg-1; Wed, 20 Sep 2023 03:15:34 -0400
X-MC-Unique: 5aANrHEfNGCXRTpmGf5sTg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6557c921deeso73626976d6.2
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 00:15:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695194134; x=1695798934;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bUEmT96YJjm1KaUK8UiYdCdnjzUzMBpE39yRbPMJIW8=;
 b=vVGw5Hq3eBilz8fe+dmdWA2TewhxwjIqT1olRWemWlBWrA0rfpLTcLQvfHnhWKH2FT
 D14SmTgm2WrDqZ6zlJhCvTN2d1qjqidEiYNZd0XB8L9t1pG/tod4JP6FBgv04g6YR1Pm
 /7iFkxhhUxA1utpZ1rEH+YFZkLB3JWYnhWvqYFhYT4V8J9QhEPpOiCiqNTcNWOozomh6
 Z7LxlCr9kGYqw6TDwb/B8L4b3VnBnIGysvp8WI6olvDsLfhR56qjoUHIa996ormmubXf
 aUTpsMY2pJJsztY7f+ObBQLeuXoUp2p0Uazos0Rk/40+5rQhIHAU6DNxEGMlcSuA+MVZ
 WIvA==
X-Gm-Message-State: AOJu0Yw24cp0Wop0wvu0B3ocCStMnQiROQ3uyfxY/uNp5V6fYck8oHBM
 kXt5+XZMoczrn8INouWnp1rPtUTsLwcvPku0xADTKRpzKuBb2p5gLX/oTUDj1ly9dIXvQ6bV1Vx
 ozg7xwVijOTvXsgM=
X-Received: by 2002:a0c:f8c9:0:b0:647:4060:1074 with SMTP id
 h9-20020a0cf8c9000000b0064740601074mr1636406qvo.22.1695194134555; 
 Wed, 20 Sep 2023 00:15:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb3PWrJktRWlMLR3lJbDm+q1UHSkNrzqIieRUxVoFH7mSpY4Y45INMQ4augXenej80Ti7hVg==
X-Received: by 2002:a0c:f8c9:0:b0:647:4060:1074 with SMTP id
 h9-20020a0cf8c9000000b0064740601074mr1636392qvo.22.1695194134291; 
 Wed, 20 Sep 2023 00:15:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 l19-20020a0ce513000000b0065651e179bdsm3103965qvm.78.2023.09.20.00.15.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Sep 2023 00:15:32 -0700 (PDT)
Message-ID: <a8759077-a3d9-94a4-eb45-3dc56bd6a081@redhat.com>
Date: Wed, 20 Sep 2023 09:15:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 03/12] vfio: Collect container iova range info
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 clg@redhat.com, jean-philippe@linaro.org, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org
References: <20230913080423.523953-1-eric.auger@redhat.com>
 <20230913080423.523953-4-eric.auger@redhat.com>
 <20230919094428.2cedaa30.alex.williamson@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230919094428.2cedaa30.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Alex,

On 9/19/23 17:44, Alex Williamson wrote:
> On Wed, 13 Sep 2023 10:01:38 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> Collect iova range information if VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE
>> capability is supported.
>>
>> This allows to propagate the information though the IOMMU MR
>> set_iova_ranges() callback so that virtual IOMMUs
>> get aware of those aperture constraints.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  include/hw/vfio/vfio-common.h |  2 ++
>>  hw/vfio/common.c              | 45 +++++++++++++++++++++++++++++++++--
>>  2 files changed, 45 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index da43d27352..74b9b27270 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -98,6 +98,8 @@ typedef struct VFIOContainer {
>>      QLIST_HEAD(, VFIOGroup) group_list;
>>      QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
>>      QLIST_ENTRY(VFIOContainer) next;
>> +    unsigned nr_iovas;
>> +    struct  vfio_iova_range *iova_ranges;
>>  } VFIOContainer;
>>  
>>  typedef struct VFIOGuestIOMMU {
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 9aac21abb7..26da38de05 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1157,6 +1157,14 @@ static void vfio_listener_region_add(MemoryListener *listener,
>>              goto fail;
>>          }
>>  
>> +        ret = memory_region_iommu_set_iova_ranges(giommu->iommu_mr,
>> +                container->nr_iovas, (struct Range *)container->iova_ranges,
>> +                &err);
> The semantics of calling this with nr_iovas == 0 and the vIOMMU driver
> ignoring that it's being told there are no usable iova ranges is rather
> strange.  Should nr_iovas be initialized to -1 for that or should this
> call be conditional on non-zero nr_iovas?
>
> Also, vfio_get_info_iova_range() is only called in the type1 container
> path and the IOVA range info capability has only existed since kernel
> v5.4.  So we need to do something sane even if we don't have the kernel
> telling us about the IOVA ranges.  I think this precludes the assert in
> the final patch of the series or else new QEMU on an old kernel is
> broken.

Correct. I totally missed that point.

Thanks!

Eric
>
>> +        if (ret) {
>> +            g_free(giommu);
>> +            goto fail;
>> +        }
>> +
>>          ret = memory_region_register_iommu_notifier(section->mr, &giommu->n,
>>                                                      &err);
>>          if (ret) {
>> @@ -1981,6 +1989,29 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
>>      return true;
>>  }
>>  
>> +static void vfio_get_info_iova_range(struct vfio_iommu_type1_info *info,
>> +                                     unsigned int *nr_iovas,
>> +                                     struct  vfio_iova_range **iova_ranges)
> Just pass the VFIOContainer pointer?  Thanks,
>
> Alex
>
>> +{
>> +    struct vfio_info_cap_header *hdr;
>> +    struct vfio_iommu_type1_info_cap_iova_range *cap;
>> +
>> +    hdr = vfio_get_iommu_type1_info_cap(info,
>> +                                        VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE);
>> +    if (hdr == NULL) {
>> +        return;
>> +    }
>> +
>> +    cap = (void *)hdr;
>> +    *nr_iovas = cap->nr_iovas;
>> +
>> +    if (*nr_iovas == 0) {
>> +        return;
>> +    }
>> +    *iova_ranges = g_memdup2(cap->iova_ranges,
>> +                             *nr_iovas * sizeof(struct  vfio_iova_range));
>> +}
>> +
>>  static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
>>                                            struct vfio_region_info *info)
>>  {
>> @@ -2433,6 +2464,12 @@ static void vfio_get_iommu_info_migration(VFIOContainer *container,
>>      }
>>  }
>>  
>> +static void vfio_free_container(VFIOContainer *container)
>> +{
>> +    g_free(container->iova_ranges);
>> +    g_free(container);
>> +}
>> +
>>  static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>>                                    Error **errp)
>>  {
>> @@ -2550,6 +2587,10 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>>          if (!vfio_get_info_dma_avail(info, &container->dma_max_mappings)) {
>>              container->dma_max_mappings = 65535;
>>          }
>> +
>> +        vfio_get_info_iova_range(info, &container->nr_iovas,
>> +                                 &container->iova_ranges);
>> +
>>          vfio_get_iommu_info_migration(container, info);
>>          g_free(info);
>>  
>> @@ -2663,7 +2704,7 @@ enable_discards_exit:
>>      vfio_ram_block_discard_disable(container, false);
>>  
>>  free_container_exit:
>> -    g_free(container);
>> +    vfio_free_container(container);
>>  
>>  close_fd_exit:
>>      close(fd);
>> @@ -2717,7 +2758,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
>>  
>>          trace_vfio_disconnect_container(container->fd);
>>          close(container->fd);
>> -        g_free(container);
>> +        vfio_free_container(container);
>>  
>>          vfio_put_address_space(space);
>>      }


