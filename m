Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF55710D74
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 15:41:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2BCg-000841-Px; Thu, 25 May 2023 09:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q2BCe-00083l-JR
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:40:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q2BCZ-0008VG-It
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685022023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p3TEsEg1Uyk/qryI/0DgbPNmc12+z7O76PXfVfETWas=;
 b=F3i2LCMoqDac3m52yVOdwd5UEx6SH//eZZHVnyCPH17qAQHu+qOxwgxQOdu8ZDSrP+CATE
 sdihzC+2M7sVvPZBvN7Q2/LkEzbcGj1RmyZLNzUuDoqEuti/gtx0Ac3HzeixZ9oyf6e013
 9JxJjLKtEl/sj0t8eSPgLkBetV9ZuHY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-Gt_WCL3-NHimAoeNgZkAjg-1; Thu, 25 May 2023 09:40:18 -0400
X-MC-Unique: Gt_WCL3-NHimAoeNgZkAjg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f5fc8581a9so2614975e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 06:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685022017; x=1687614017;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p3TEsEg1Uyk/qryI/0DgbPNmc12+z7O76PXfVfETWas=;
 b=Wtkpq9lL5cTsWxZG10kg1Yzz2YHl/hurLQ/vyrqb3hbGNkT7gjtNUv+9R0pixMnStJ
 LGqA7hLD6wuti+gDk8kVGFgyS+j8YD9ZFGdbeHPU01hXMkL0rUJOxXad40KDWQnDnDZm
 sKCFAK28wE8zSc5RrJIP/W76iLO/pyk1B6a8y0lLn4HxCCpoTEanePk5adqvSqArZuW0
 N4e8YdKRPEZNA4hY2RqUFKimTXfostxKQbmBVttBWwd7rGEpwWPUFJDzNgK4nw8YpqYb
 8SSG4i1AXv55yp0rdM8pElVZNTiRYJx5uQReQC91MQloIENeWE/0LgkpcNyrzTGfjnZf
 VHtA==
X-Gm-Message-State: AC+VfDy7mk4au/+aoIZWX3PvRnhJixH2UWnmcp+QbSjRIW45c930zKLD
 n/d1tq6K7uJ13hcyX1NF/iv3QY2EV8qGjKbaJJ7PBcMSjtFLAUhfZVc1Wfm8j9b1O/ojT8eEI2B
 da7Yk6eETYGRNa1A=
X-Received: by 2002:a7b:ce96:0:b0:3f6:7af:8fe7 with SMTP id
 q22-20020a7bce96000000b003f607af8fe7mr2442418wmj.10.1685022016963; 
 Thu, 25 May 2023 06:40:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4/R2X+FHgiLlCU6JYRLC7nL3nUZ/6yGz3q/7rRrvsSYnJyk4az2HBmXTyyEowwd8vzMCNPUg==
X-Received: by 2002:a7b:ce96:0:b0:3f6:7af:8fe7 with SMTP id
 q22-20020a7bce96000000b003f607af8fe7mr2442393wmj.10.1685022016526; 
 Thu, 25 May 2023 06:40:16 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 p26-20020a05600c205a00b003f4f1b884cdsm5653862wmg.36.2023.05.25.06.40.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 06:40:16 -0700 (PDT)
Message-ID: <b2108d2d-3123-def0-a3af-d4de57e7f72e@redhat.com>
Date: Thu, 25 May 2023 15:40:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20230523185144.533592-1-david@redhat.com>
 <20230523185144.533592-3-david@redhat.com>
 <d2b91574-a6cb-32be-2713-ba6bf6b7e565@linaro.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 2/3] memory-device: Factor out device memory
 initialization into memory_devices_init()
In-Reply-To: <d2b91574-a6cb-32be-2713-ba6bf6b7e565@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 25.05.23 15:30, Philippe Mathieu-Daudé wrote:
> Hi David,
> 
> On 23/5/23 20:51, David Hildenbrand wrote:
>> Let's factor the common setup out, to prepare for further changes.
>>
>> On arm64, we'll add the subregion to system RAM now earlier -- which
>> shouldn't matter, because the system RAM memory region should already be
>> alive at that point.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>    hw/arm/virt.c                  |  9 +--------
>>    hw/i386/pc.c                   | 17 ++++++-----------
>>    hw/loongarch/virt.c            | 14 ++++----------
>>    hw/mem/memory-device.c         | 20 ++++++++++++++++++++
>>    hw/ppc/spapr.c                 | 15 ++++++---------
>>    include/hw/mem/memory-device.h |  2 ++
>>    6 files changed, 39 insertions(+), 38 deletions(-)
> 
> Split in boring 'first add method then use it for each arch'
> would be easier to review.

Right, I agree if I'd be touching more code (I consider this fairly 
minimal and straight-forward refactoring).

> 
>> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
>> index 6c025b02c1..d99ceb621a 100644
>> --- a/hw/mem/memory-device.c
>> +++ b/hw/mem/memory-device.c
>> @@ -17,6 +17,7 @@
>>    #include "qemu/range.h"
>>    #include "hw/virtio/vhost.h"
>>    #include "sysemu/kvm.h"
>> +#include "exec/address-spaces.h"
>>    #include "trace.h"
>>    
>>    static gint memory_device_addr_sort(gconstpointer a, gconstpointer b)
>> @@ -333,6 +334,25 @@ uint64_t memory_device_get_region_size(const MemoryDeviceState *md,
>>        return memory_region_size(mr);
>>    }
>>    
>> +void memory_devices_init(MachineState *ms, hwaddr base, uint64_t size)
>> +{
>> +    g_assert(!ms->device_memory);
>> +    ms->device_memory = g_new0(DeviceMemoryState, 1);
>> +    ms->device_memory->base = base;
>> +
>> +    /*
>> +     * See memory_device_get_free_addr(): An empty device memory region
>> +     * means "this machine supports memory devices, but they are not enabled".
>> +     */
>> +    if (size > 0) {
>> +        memory_region_init(&ms->device_memory->mr, OBJECT(ms), "device-memory",
>> +                           size);
>> +        memory_region_add_subregion(get_system_memory(),
>> +                                    ms->device_memory->base,
>> +                                    &ms->device_memory->mr);
> 
> What about always init/register and set if enabled?
> 
>     memory_region_set_enabled(&ms->device_memory->mr, size > 0);
> 
> Otherwise why allocate ms->device_memory?

We have right now:

ms->device_memory not allocated: no support
ms->device_memory->mr with size 0: not enabled
ms->device_memory->mr with size > 0: enabled

Let me see if initializing a memory region with size 0 (and adding a 
subregion with size 0) works.

Thanks!

-- 
Thanks,

David / dhildenb


