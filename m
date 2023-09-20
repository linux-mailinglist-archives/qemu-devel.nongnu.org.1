Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5597A7412
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 09:28:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qirdY-0003fh-0d; Wed, 20 Sep 2023 03:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qirdV-0003fB-7X
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 03:28:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qirdT-0003Lt-No
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 03:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695194914;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JD50fnqSCdxa4RI+t75NkjYqRbcfb8PPD6gAydx4Ynw=;
 b=IlcmLBh9ZOcsO6oTG/exdq2lgz1qnBgUqq0fj+urd4hzipozEnKsmCrjWNvx+8K+Sr8g/A
 qOeQrV3Nw0hsxXzLhm+mnG3yRI7kFo/Bmaz8i+etWSIktwTy73Ll/9RLhK8ppj639nI2L5
 aJqE/Jzsvjfd2r0LtYZSr+6womxGkbg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-zzfklG9wN9GK20QQgsKWnQ-1; Wed, 20 Sep 2023 03:28:32 -0400
X-MC-Unique: zzfklG9wN9GK20QQgsKWnQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-76e015eb1c9so806212285a.3
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 00:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695194912; x=1695799712;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JD50fnqSCdxa4RI+t75NkjYqRbcfb8PPD6gAydx4Ynw=;
 b=LzAMS+VskYbinSGK+ZQexCcrIvNQx1t8o2NoHDtbms/hrNfJI9yIGA0EWWMUfPYIvh
 kNk0kuUgrcOaxan0uQNpy6GzNLsO4k00FV2/sj+hBWN4Yr4m1yl2UWZlOATD8pP31V04
 1dGfDwt5uq4asKPEckZ4nnNUHehX4rPW4CFikaZIBnaqrqlig2jgKx0dokjou/0L+D7H
 dgTd6GW+zwguMo0kQCOTTBsRi/xTSRj+WyjSBesx0ANTMmkc86RMPiI+akqzL2u475D/
 0Hd8uT5/c9UfCqVcKCg1KDJhi3/92VEZxP7XOYHjgx6utN/NFgfquwjJhmsJvE4ZGKWj
 +Bvg==
X-Gm-Message-State: AOJu0YxsdFK0C4rPIZakbtvzCf89OQDLNM0Bypw/YYwP4McyVUYGp+w1
 7rookprbwoMt6G+ZZLT5X0JxJFxKnCwFyN0tlKmGu/ozJrbjX4zCppvnNajuJs1smknUUjGeDpY
 ocYJczpK199RJo9E=
X-Received: by 2002:a05:620a:46a4:b0:770:f29f:d1d9 with SMTP id
 bq36-20020a05620a46a400b00770f29fd1d9mr2305536qkb.2.1695194911750; 
 Wed, 20 Sep 2023 00:28:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYL+iWWnvQWIN8r3jxMNCi4P5ru5m+oLbVo8k3CXvVUHMkTHO8+0NlZ0XttjUMHWuVoH32Lw==
X-Received: by 2002:a05:620a:46a4:b0:770:f29f:d1d9 with SMTP id
 bq36-20020a05620a46a400b00770f29fd1d9mr2305511qkb.2.1695194911417; 
 Wed, 20 Sep 2023 00:28:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 g6-20020ae9e106000000b007726002d69esm4594017qkm.10.2023.09.20.00.28.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Sep 2023 00:28:30 -0700 (PDT)
Message-ID: <bc5bf537-8456-c0d2-c4f0-5cf5f64a9674@redhat.com>
Date: Wed, 20 Sep 2023 09:28:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 12/12] vfio: Remove 64-bit IOVA address space assumption
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 clg@redhat.com, jean-philippe@linaro.org, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org
References: <20230913080423.523953-1-eric.auger@redhat.com>
 <20230913080423.523953-13-eric.auger@redhat.com>
 <20230919112230.5dfe14fa.alex.williamson@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230919112230.5dfe14fa.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 9/19/23 19:22, Alex Williamson wrote:
> On Wed, 13 Sep 2023 10:01:47 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> Now we retrieve the usable IOVA ranges from the host,
>> we now the physical IOMMU aperture and we can remove
>> the assumption of 64b IOVA space when calling
>> vfio_host_win_add().
>>
>> This works fine in general but in case of an IOMMU memory
>> region this becomes more tricky. For instance the virtio-iommu
>> MR has a 64b aperture by default. If the physical IOMMU has a
>> smaller aperture (typically the case for VTD), this means we
>> would need to resize the IOMMU MR when this latter is linked
>> to a container. However this happens on vfio_listener_region_add()
>> when calling the IOMMU MR set_iova_ranges() callback and this
>> would mean we would have a recursive call the
>> vfio_listener_region_add(). This looks like a wrong usage of
>> the memory API causing duplicate IOMMU MR notifier registration
>> for instance.
>>
>> Until we find a better solution, make sure the vfio_find_hostwin()
>> is not called anymore for IOMMU region.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> I have not found any working solution to the IOMMU MR resizing.
>> So I can remove this patch or remove the check for IOMMU MR. Maybe
>> this is an issue which can be handled separately?
>> ---
>>  hw/vfio/common.c | 25 ++++++++++++-------------
>>  1 file changed, 12 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 26da38de05..40cac1ca91 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -1112,13 +1112,6 @@ static void vfio_listener_region_add(MemoryListener *listener,
>>  #endif
>>      }
>>  
>> -    hostwin = vfio_find_hostwin(container, iova, end);
>> -    if (!hostwin) {
>> -        error_setg(&err, "Container %p can't map guest IOVA region"
>> -                   " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx, container, iova, end);
>> -        goto fail;
>> -    }
>> -
>>      memory_region_ref(section->mr);
>>  
>>      if (memory_region_is_iommu(section->mr)) {
>> @@ -1177,6 +1170,14 @@ static void vfio_listener_region_add(MemoryListener *listener,
>>          return;
>>      }
>>  
>> +    hostwin = vfio_find_hostwin(container, iova, end);
>> +    if (!hostwin) {
>> +        error_setg(&err, "Container %p can't map guest IOVA region"
>> +                   " 0x%"HWADDR_PRIx"..0x%"HWADDR_PRIx, container, iova, end);
>> +        goto fail;
>> +    }
>> +
>> +
>>      /* Here we assume that memory_region_is_ram(section->mr)==true */
>>  
>>      /*
>> @@ -2594,12 +2595,10 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>>          vfio_get_iommu_info_migration(container, info);
>>          g_free(info);
>>  
>> -        /*
>> -         * FIXME: We should parse VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE
>> -         * information to get the actual window extent rather than assume
>> -         * a 64-bit IOVA address space.
>> -         */
>> -        vfio_host_win_add(container, 0, (hwaddr)-1, container->pgsizes);
>> +        g_assert(container->nr_iovas);
> This assert is a problem for older kernels.
yes I will fix this.
>
>> +        vfio_host_win_add(container, 0,
>> +                          container->iova_ranges[container->nr_iovas - 1].end,
>> +                          container->pgsizes);
> This doesn't address the assumption about the min_iova and adds an
> assumption that the kernel provided list is sorted.  Thanks,
yup.

Thanks!

Eric
>
> Alex
>


