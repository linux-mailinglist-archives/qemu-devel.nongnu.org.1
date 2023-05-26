Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F15C7123B8
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 11:34:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Tp6-0006k1-NQ; Fri, 26 May 2023 05:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q2Tp4-0006j3-6U
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:33:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q2Tp2-0005fl-In
 for qemu-devel@nongnu.org; Fri, 26 May 2023 05:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685093600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lapu/jDHLbNZjxWGCm3K8M8bmzl2u0jJ1zbVd9PWtS8=;
 b=DSN65c1QlYAiKwEGvvFt3YEMqWAAo4iWVyDw/aB1JUx1SNWz5NgfKMXX+s9UViyLrOIiUK
 CldMWqhcVTegU68/GkohrGYVTRIN9ZQFbii9HUd5rWsI/6255Qo6Q/RdYmpt+/U2qmFd8B
 5sEJVmgjfHkz6VFJ5oVUQzgSqvNdBEU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-N1Qm4Uk5OtKh4fc90UfqKQ-1; Fri, 26 May 2023 05:33:18 -0400
X-MC-Unique: N1Qm4Uk5OtKh4fc90UfqKQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f5fffb828eso7517285e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 02:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685093597; x=1687685597;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lapu/jDHLbNZjxWGCm3K8M8bmzl2u0jJ1zbVd9PWtS8=;
 b=DLFsBy2A7V8KQXblRRzyhsAjw6xwx9LpZL9YkxGMVknD4B/7DsZQMgD+2C28Pu+rGk
 Ae9xugDfBVljOhQ5plq8uNLC7XPPyFTZFhFad7ITR3vH+yKtFShxsgdCbD1XDw8zg+j4
 SO67CsYRFGwWD992pey6suSBtP3EoDUmbSG3aZvfB2aoB0Jzpjg6VPzkjT2+NJvdVFSN
 t2RBzhg3RD5ffmvXc0oiGZxSXi4OMaIYZ/u7yqSKUqHNT1I7fVVaoo6d4ySn2BUCkobM
 crrVZmAcpcwTDrzxGCzHJxStoto3s2GAUuSsekpstfOQbi7i/PJRsg1M4mrZLVkjfbSu
 N1Lg==
X-Gm-Message-State: AC+VfDzCyStoey8NhkXPWCq5yJbmd42z9T3mHso3AMeVtD961R8m9t1u
 l17Jeb+/b/81NxQsBA67pEoSpQ1CJY+R50G4iZx1eJc1WcxKBnI0oaLHTT4vls8y0qJB6a6Yv9h
 yoB0eKoCgLs+CW00=
X-Received: by 2002:a05:600c:19c9:b0:3f6:6f26:7254 with SMTP id
 u9-20020a05600c19c900b003f66f267254mr3694411wmq.3.1685093597374; 
 Fri, 26 May 2023 02:33:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Nv2HyBcF9tiXLE3eYEhAIB8aAzE3YvhI6mKTKhxzGHg5v19oEgQzDwqQCAA+ld9llTKTKog==
X-Received: by 2002:a05:600c:19c9:b0:3f6:6f26:7254 with SMTP id
 u9-20020a05600c19c900b003f66f267254mr3694383wmq.3.1685093596973; 
 Fri, 26 May 2023 02:33:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:9700:7003:7e4d:43dd:7bfd?
 (p200300cbc710970070037e4d43dd7bfd.dip0.t-ipconnect.de.
 [2003:cb:c710:9700:7003:7e4d:43dd:7bfd])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a7bc4d2000000b003f427687ba7sm4523874wmk.41.2023.05.26.02.33.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 02:33:16 -0700 (PDT)
Message-ID: <3c47ef15-05ce-8d46-2beb-4a06731939c2@redhat.com>
Date: Fri, 26 May 2023 11:33:15 +0200
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

With

void memory_devices_init(MachineState *ms, hwaddr base, uint64_t size)
{
     g_assert(!ms->device_memory);
     ms->device_memory = g_new0(DeviceMemoryState, 1);
     ms->device_memory->base = base;

     /*
      * An empty region (size == 0) indicates that memory devices are supported
      * by the machine, but they are not enabled (see memory_device_pre_plug()).
      */
     memory_region_init(&ms->device_memory->mr, OBJECT(ms), "device-memory",
                        size);
     memory_region_set_enabled(&ms->device_memory->mr, !!size);
     memory_region_add_subregion(get_system_memory(), ms->device_memory->base,
                                 &ms->device_memory->mr);
}

"info mtree -D" on x86-64 with only "-m 2G" (no maxmem) will show that the
region is placed at address 0 and disabled:

memory-region: system
   0000000000000000-ffffffffffffffff (prio 0, i/o): system
     0000000000000000-0000000000000000 (prio 0, i/o): device-memory [disabled]
     0000000000000000-000000007fffffff (prio 0, ram): alias ram-below-4g @pc.ram 0000000000000000-000000007fffffff
     0000000000000000-ffffffffffffffff (prio -1, i/o): pci


Good enough for me.

However, I think we could just stop allocating ms->device_memory with size == 0 and
not care about the "not supported" case in memory_device_pre_plug(): this function should
only get called by a machine, and if the machine does not support memory devices, it is
to blame for calling that function after all. (and it will only affect the error message
after all)

-- 
Thanks,

David / dhildenb


