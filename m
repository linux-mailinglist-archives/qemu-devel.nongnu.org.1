Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1087A7471
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 09:40:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qirp9-0002Rh-4z; Wed, 20 Sep 2023 03:40:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qirp2-0002QP-2F
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 03:40:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qirp0-00067W-AC
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 03:40:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695195629;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ydb1qenVnkIUGF33vDEVsn/9fyotkUE+C1z/BOYnQls=;
 b=WDDDJID4dFHQqm+fFC0981jB1O9YRHoadDS0HTNRX/Yn5gknwjqUTamkY/baqfZiMD/+l6
 PuAKjVbqIY6XuKUL7dyfrbvdhCqjETAvO9xnRo+XfFZdiWSPppTr2i1Ie1OBJbDcn+I4ig
 1cmaCuHtcKSJft5ARUvAheARZKSNnqM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-w7w-HhHjM1iJCfhGzcG8EQ-1; Wed, 20 Sep 2023 03:40:27 -0400
X-MC-Unique: w7w-HhHjM1iJCfhGzcG8EQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-76dbe1865c1so847953285a.0
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 00:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695195627; x=1695800427;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ydb1qenVnkIUGF33vDEVsn/9fyotkUE+C1z/BOYnQls=;
 b=MANJ2+cmzDMvtbTE4+ifJPu3ZGFmBZ33tCEGLHuB0q/TDSI5wOg12BdMqeJXRXDaTY
 kMaffmujR+lpapL5jWK9qdbDz1V2ys2KtbFrtdADFTvWYzBGSDL4Ba/3N0+ZOI6u72xn
 Q0vo/7NFA03tc49tsA4zmqm7pYqXHgfxfxo0nQdkMqqX0O4PePHJzJytSvGGhxQ//l4c
 Hpv0PppDYgktwd/25KvkfbEeneWcXH/tljJ9LadfBYVjMvn95n3AgYyE5l3kq4uovnL8
 axGKv0ETY67/p4p7XWkLXOsnmgLXFaJiPq+912kEp2Riob850lwWIn/Y8LZq3dJ13uaF
 4m3w==
X-Gm-Message-State: AOJu0YxWkPj9IJ1exuc3S1MdJxgX7Ci36doprYXsLSwBKv3gf3HJBLQk
 OZLS4G6mSJPycsDMftGe13JbriU4D8cowYaoUHBsRnPWb+toNqXHlLo2sBfLPpJJ1kWV7hUPt1L
 6FtlkoQ505O5X7B8=
X-Received: by 2002:a05:620a:4047:b0:76c:5715:b4a3 with SMTP id
 i7-20020a05620a404700b0076c5715b4a3mr2063252qko.13.1695195627154; 
 Wed, 20 Sep 2023 00:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/Lvp5ZrqWnO3yqxA+TgOVTigHd+/u6JTXZjw78r+abvfCTjajPdKzGdT+bRoAoSk8CLdeqQ==
X-Received: by 2002:a05:620a:4047:b0:76c:5715:b4a3 with SMTP id
 i7-20020a05620a404700b0076c5715b4a3mr2063241qko.13.1695195626883; 
 Wed, 20 Sep 2023 00:40:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 16-20020a05620a06d000b00770f3e5618esm4606139qky.101.2023.09.20.00.40.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Sep 2023 00:40:26 -0700 (PDT)
Message-ID: <734938b2-3550-3d50-0abd-0d3779d74f9c@redhat.com>
Date: Wed, 20 Sep 2023 09:40:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 02/12] memory: Introduce
 memory_region_iommu_set_iova_ranges
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 alex.williamson@redhat.com, jean-philippe@linaro.org, mst@redhat.com,
 pbonzini@redhat.com
Cc: peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org
References: <20230913080423.523953-1-eric.auger@redhat.com>
 <20230913080423.523953-3-eric.auger@redhat.com>
 <b79903b5-1f9c-68ae-0b4b-e4bf94e44281@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <b79903b5-1f9c-68ae-0b4b-e4bf94e44281@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Cedric,

On 9/13/23 14:43, Cédric Le Goater wrote:
> On 9/13/23 10:01, Eric Auger wrote:
>> This helper will allow to convey information about valid
>> IOVA ranges to virtual IOMMUS.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
Thanks!

Eric
>
> Thanks,
>
> C.
>
>> ---
>>   include/exec/memory.h | 26 ++++++++++++++++++++++++++
>>   softmmu/memory.c      | 15 +++++++++++++++
>>   2 files changed, 41 insertions(+)
>>
>> diff --git a/include/exec/memory.h b/include/exec/memory.h
>> index 184cb3a01b..f6fb99dd3f 100644
>> --- a/include/exec/memory.h
>> +++ b/include/exec/memory.h
>> @@ -519,6 +519,27 @@ struct IOMMUMemoryRegionClass {
>>        int (*iommu_set_page_size_mask)(IOMMUMemoryRegion *iommu,
>>                                        uint64_t page_size_mask,
>>                                        Error **errp);
>> +    /**
>> +     * @iommu_set_iova_ranges:
>> +     *
>> +     * Propagate information about the usable IOVA ranges for a
>> given IOMMU
>> +     * memory region. Used for example to propagate host physical
>> device
>> +     * reserved memory region constraints to the virtual IOMMU.
>> +     *
>> +     * Optional method: if this method is not provided, then the
>> default IOVA
>> +     * aperture is used.
>> +     *
>> +     * @nr_ranges: number of IOVA ranges
>> +     *
>> +     * @iova_ranges: an array of @nr_ranges usable IOVA ranges
>> +     *
>> +     * Returns 0 on success, or a negative error. In case of
>> failure, the error
>> +     * object must be created.
>> +     */
>> +     int (*iommu_set_iova_ranges)(IOMMUMemoryRegion *iommu,
>> +                                  uint32_t nr_ranges,
>> +                                  struct Range *iova_ranges,
>> +                                  Error **errp);
>>   };
>>     typedef struct RamDiscardListener RamDiscardListener;
>> @@ -1845,6 +1866,11 @@ int
>> memory_region_iommu_set_page_size_mask(IOMMUMemoryRegion *iommu_mr,
>>                                              uint64_t page_size_mask,
>>                                              Error **errp);
>>   +int memory_region_iommu_set_iova_ranges(IOMMUMemoryRegion *iommu,
>> +                                        uint32_t nr_ranges,
>> +                                        struct Range *iova_ranges,
>> +                                        Error **errp);
>> +
>>   /**
>>    * memory_region_name: get a memory region's name
>>    *
>> diff --git a/softmmu/memory.c b/softmmu/memory.c
>> index 7d9494ce70..07499457aa 100644
>> --- a/softmmu/memory.c
>> +++ b/softmmu/memory.c
>> @@ -1905,6 +1905,21 @@ int
>> memory_region_iommu_set_page_size_mask(IOMMUMemoryRegion *iommu_mr,
>>       return ret;
>>   }
>>   +int memory_region_iommu_set_iova_ranges(IOMMUMemoryRegion *iommu_mr,
>> +                                        uint32_t nr_ranges,
>> +                                        struct Range *iova_ranges,
>> +                                        Error **errp)
>> +{
>> +    IOMMUMemoryRegionClass *imrc =
>> IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
>> +    int ret = 0;
>> +
>> +    if (imrc->iommu_set_iova_ranges) {
>> +        ret = imrc->iommu_set_iova_ranges(iommu_mr, nr_ranges,
>> +                                          iova_ranges, errp);
>> +    }
>> +    return ret;
>> +}
>> +
>>   int memory_region_register_iommu_notifier(MemoryRegion *mr,
>>                                             IOMMUNotifier *n, Error
>> **errp)
>>   {
>


