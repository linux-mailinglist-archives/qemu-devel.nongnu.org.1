Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF2D7BFF6C
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 16:38:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqDqx-0002O9-0A; Tue, 10 Oct 2023 10:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qqDqs-0002Nb-Fa
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 10:36:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qqDqq-0002AA-SA
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 10:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696948607;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bvIcsGUODUn43cCRf5oDlejFHDPXTpLdVGk+xJdfoZ0=;
 b=WKrpsyz03MCZH6jWGBp1/4hNXmxioi0FYl5Gw1Fl2TDmgVnDs0wlt5rTMhSyFu6C7WKOMW
 WuQYEA3rO+5J1kJRmSZXyLULFksFg7ztUh3fhUkNS/RjiB6GiHv67u5sHgRTINfEpp0WBo
 5r+KchQqkOT80f1Q3FkQJANr7yZKF9M=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-rC4Bwn1uOB2vYmpsFOw3Qg-1; Tue, 10 Oct 2023 10:36:44 -0400
X-MC-Unique: rC4Bwn1uOB2vYmpsFOw3Qg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-65b0d19bfd0so68979276d6.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 07:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696948604; x=1697553404;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bvIcsGUODUn43cCRf5oDlejFHDPXTpLdVGk+xJdfoZ0=;
 b=IHxbpo68euAimF8nqI2sfoIpTQl4fTWC9da67YiMxgdS7fBJAEQP/YD16NeZiMG2Lc
 CylFeuoxkIAw39bCOTEzQjFkqDCUdzpNNJ+KSXIoiLNzT0hzC3XBbY2MmBYsUUVFzIJ6
 MZ6b41dLGeZ3oAUWhEk3YLp//i6zh8hhLQt2Uohrd2+1swwZCnv8SP55k43m67K2Gneu
 /nEmuKoNaOw/xUG8LiIX74QHk+WHVip5Tosg3vos/Fydk46INFEal+ScnK+meu+DQVzN
 xKtI0Bh320A0rJM5qfXRaDC8PDDDklQKxAiQ+lLp/YqVZ4M14NUgNHH562x9oOeZe9O7
 +geA==
X-Gm-Message-State: AOJu0YymkVW6GuJ7AmN32Q3iaRs6DAYTL2ommrBXC/kUuPNQFQ2aJLqt
 GGAU6MyoVJL5PvE/0UOhiCMSv4txa+wycDRqzjNHyHXIDuugcHBhP81kpThhPtMZZZ4TwbFq3Zm
 nZKJtP0wVFhxYRvk=
X-Received: by 2002:a0c:f14b:0:b0:65a:fcd1:1d8c with SMTP id
 y11-20020a0cf14b000000b0065afcd11d8cmr17901845qvl.61.1696948603806; 
 Tue, 10 Oct 2023 07:36:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSxh6b75phQ2sy1c5tm+oxJF5915g3b//sxJF1W9T99PkbP9Cpx2EhrYbnEOiTmJa3eB1asg==
X-Received: by 2002:a0c:f14b:0:b0:65a:fcd1:1d8c with SMTP id
 y11-20020a0cf14b000000b0065afcd11d8cmr17901829qvl.61.1696948603491; 
 Tue, 10 Oct 2023 07:36:43 -0700 (PDT)
Received: from [192.168.43.95] ([37.170.189.5])
 by smtp.gmail.com with ESMTPSA id
 i1-20020a0cf381000000b0064f43efc844sm4765123qvk.32.2023.10.10.07.36.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 07:36:42 -0700 (PDT)
Message-ID: <9bc182c6-dd2d-2f00-c7eb-3065f17a05cb@redhat.com>
Date: Tue, 10 Oct 2023 16:36:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 07/12] virtio-iommu: Implement set_iova_ranges()
 callback
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org
References: <20230913080423.523953-1-eric.auger@redhat.com>
 <20230913080423.523953-8-eric.auger@redhat.com>
 <20230929161547.GB2957297@myrica>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230929161547.GB2957297@myrica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

Hi Jean,
On 9/29/23 18:15, Jean-Philippe Brucker wrote:
> On Wed, Sep 13, 2023 at 10:01:42AM +0200, Eric Auger wrote:
>> The implementation populates the array of per IOMMUDevice
>> host reserved regions.
>>
>> It is forbidden to have conflicting sets of host IOVA ranges
>> to be applied onto the same IOMMU MR (implied by different
>> host devices).
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v1 -> v2:
>> - Forbid conflicting sets of host resv regions
>> ---
>>  include/hw/virtio/virtio-iommu.h |  2 ++
>>  hw/virtio/virtio-iommu.c         | 48 ++++++++++++++++++++++++++++++++
>>  2 files changed, 50 insertions(+)
>>
>> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
>> index 70b8ace34d..31b69c8261 100644
>> --- a/include/hw/virtio/virtio-iommu.h
>> +++ b/include/hw/virtio/virtio-iommu.h
>> @@ -40,6 +40,8 @@ typedef struct IOMMUDevice {
>>      MemoryRegion root;          /* The root container of the device */
>>      MemoryRegion bypass_mr;     /* The alias of shared memory MR */
>>      GList *resv_regions;
>> +    Range *host_resv_regions;
>> +    uint32_t nr_host_resv_regions;
>>  } IOMMUDevice;
>>  
>>  typedef struct IOMMUPciBus {
>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> index ea359b586a..ed2df5116f 100644
>> --- a/hw/virtio/virtio-iommu.c
>> +++ b/hw/virtio/virtio-iommu.c
>> @@ -20,6 +20,7 @@
>>  #include "qemu/osdep.h"
>>  #include "qemu/log.h"
>>  #include "qemu/iov.h"
>> +#include "qemu/range.h"
>>  #include "exec/target_page.h"
>>  #include "hw/qdev-properties.h"
>>  #include "hw/virtio/virtio.h"
>> @@ -1158,6 +1159,52 @@ static int virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
>>      return 0;
>>  }
>>  
>> +static int virtio_iommu_set_iova_ranges(IOMMUMemoryRegion *mr,
>> +                                        uint32_t nr_ranges,
>> +                                        struct Range *iova_ranges,
>> +                                        Error **errp)
>> +{
>> +    IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
>> +    uint32_t nr_host_resv_regions;
>> +    Range *host_resv_regions;
>> +    int ret = -EINVAL;
>> +
>> +    if (!nr_ranges) {
>> +        return 0;
>> +    }
>> +
>> +    if (sdev->host_resv_regions) {
>> +        range_inverse_array(nr_ranges, iova_ranges,
>> +                            &nr_host_resv_regions, &host_resv_regions,
>> +                            0, UINT64_MAX);
>> +        if (nr_host_resv_regions != sdev->nr_host_resv_regions) {
>> +            goto error;
>> +        }
>> +        for (int i = 0; i < nr_host_resv_regions; i++) {
>> +            Range *new = &host_resv_regions[i];
>> +            Range *existing = &sdev->host_resv_regions[i];
>> +
>> +            if (!range_contains_range(existing, new)) {
>> +                goto error;
>> +            }
>> +        }
>> +        ret = 0;
>> +        goto out;
>> +    }
>> +
>> +    range_inverse_array(nr_ranges, iova_ranges,
>> +                        &sdev->nr_host_resv_regions, &sdev->host_resv_regions,
>> +                        0, UINT64_MAX);
> Can set_iova_ranges() only be called for the first time before the guest
> has had a chance to issue a probe request?  Maybe we could add a
> sanity-check that the guest hasn't issued a probe request yet, since we
> can't notify about updated reserved regions.

I added a warning if the set_iova is called after the probe

Eric
>
> I'm probably misremembering because I thought Linux set up IOMMU contexts
> (including probe requests) before enabling DMA master in PCI which cause
> QEMU VFIO to issue these calls. I'll double check.
>
> Thanks,
> Jean
>
>> +
>> +    return 0;
>> +error:
>> +    error_setg(errp, "IOMMU mr=%s Conflicting host reserved regions set!",
>> +               mr->parent_obj.name);
>> +out:
>> +    g_free(host_resv_regions);
>> +    return ret;
>> +}
>> +
>>  static void virtio_iommu_system_reset(void *opaque)
>>  {
>>      VirtIOIOMMU *s = opaque;
>> @@ -1453,6 +1500,7 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
>>      imrc->replay = virtio_iommu_replay;
>>      imrc->notify_flag_changed = virtio_iommu_notify_flag_changed;
>>      imrc->iommu_set_page_size_mask = virtio_iommu_set_page_size_mask;
>> +    imrc->iommu_set_iova_ranges = virtio_iommu_set_iova_ranges;
>>  }
>>  
>>  static const TypeInfo virtio_iommu_info = {
>> -- 
>> 2.41.0
>>


