Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA8771610E
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:06:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3z1r-000509-IO; Tue, 30 May 2023 09:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q3z1o-0004y5-Rp
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:04:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q3z1n-00028k-8T
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685451882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7bIXwwVTn5liDKbm32v5gJSdv0HXyW4kTIXwzuyy3Xc=;
 b=DRntSgmM1zHWA2cKu5fqUF4crg7IyCHshQ2g45waASji3GeSHqxdeEhbW8HFVWU6nkBssj
 y9Iab2ihLZO02pvleFTUVx0mMGMOeHRin7PzoQvRr32U/OQTBaGtKoB9xPxjdq/6/SkWvN
 1BMbUqyaGYpQBexzfok8r94LkpwzzVk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-r5QX26bzNbG5aYZTKjSVGQ-1; Tue, 30 May 2023 09:04:40 -0400
X-MC-Unique: r5QX26bzNbG5aYZTKjSVGQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30af6a5b6b0so238394f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685451879; x=1688043879;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :content-language:references:cc:to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7bIXwwVTn5liDKbm32v5gJSdv0HXyW4kTIXwzuyy3Xc=;
 b=iLFRypQ5rQgD0OXb83kQNWkpGt24jfKC3iP3MbkrR0iISIQs73sLp8KK6Y8CiYqEdj
 /peK6qXUpGYwMb1rj6iJUPjkiN2G5BNn7H0jTOyLCfGhD3Sw+ILT0AByFOS64McsNIjl
 p6W31OuFKZLaLsc52gaj68K83/QrET4A8wA8+7woF4WSO7FPntcJTu9tgZZb6HFiGsL3
 ltTl8tB5qHh83FNPnkIPYC+ERfG6zF5NtO1zKQGKwKUkSvpenq2/1rEtF/eoXYydZ8+2
 X2xVv7U1JvYKH76ctltrv3NsKLvrOGcG/h7T/qkOeGDnb+3lCFL5wRvidCbv56XOh+nv
 oRxg==
X-Gm-Message-State: AC+VfDx12y8VwuEhtoJ8kDB+i+4iVBrUfiwM6rKcmBlJz2pYm2db0RnI
 ED1TEyJyS2TLkX2yQlPIPa8PRcFkzWR919Czsv+I3zw1xzGmiNhw7WX9XbZLdJ6yzkd6d2bm6wP
 a6fXczCbmzHyAIac=
X-Received: by 2002:a05:6000:10c8:b0:309:32d1:59d8 with SMTP id
 b8-20020a05600010c800b0030932d159d8mr1618319wrx.64.1685451879458; 
 Tue, 30 May 2023 06:04:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ43b46W4cdOom/gLBkLRyaycuwP+7xKGgrAXHb7UUAEV0gc86SftPgDchzfJP+XkKLCqio/VA==
X-Received: by 2002:a05:6000:10c8:b0:309:32d1:59d8 with SMTP id
 b8-20020a05600010c800b0030932d159d8mr1618284wrx.64.1685451879035; 
 Tue, 30 May 2023 06:04:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73c:d500:78e5:f448:8bef:a30?
 (p200300cbc73cd50078e5f4488bef0a30.dip0.t-ipconnect.de.
 [2003:cb:c73c:d500:78e5:f448:8bef:a30])
 by smtp.gmail.com with ESMTPSA id
 s5-20020adff805000000b00307d58b3da9sm3286188wrp.25.2023.05.30.06.04.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 06:04:36 -0700 (PDT)
Message-ID: <2e51c9e4-3716-5f55-b006-30a40b0ea0da@redhat.com>
Date: Tue, 30 May 2023 15:04:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230530113838.257755-1-david@redhat.com>
 <20230530113838.257755-3-david@redhat.com>
 <7ff1f897-7244-258e-34a5-a4a781f679dc@linaro.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 02/10] memory-device: Introduce memory_devices_init()
In-Reply-To: <7ff1f897-7244-258e-34a5-a4a781f679dc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 30.05.23 14:29, Philippe Mathieu-Daudé wrote:
> Hi David,
> 
> On 30/5/23 13:38, David Hildenbrand wrote:
>> Let's intrduce a new helper that we will use to replace existing memory
>> device setup code during machine initialization. We'll enforce that the
>> size has to be > 0.
>>
>> Once all machines were converted, we'll only allocate ms->device_memory
>> if the size > 0.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>    hw/mem/memory-device.c         | 14 ++++++++++++++
>>    include/hw/mem/memory-device.h |  2 ++
>>    2 files changed, 16 insertions(+)
> 
> 
>> diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
>> index 48d2611fc5..6e8a10e2f5 100644
>> --- a/include/hw/mem/memory-device.h
>> +++ b/include/hw/mem/memory-device.h
>> @@ -16,6 +16,7 @@
>>    #include "hw/qdev-core.h"
>>    #include "qapi/qapi-types-machine.h"
>>    #include "qom/object.h"
>> +#include "exec/hwaddr.h"
>>    
>>    #define TYPE_MEMORY_DEVICE "memory-device"
>>    
>> @@ -113,5 +114,6 @@ void memory_device_plug(MemoryDeviceState *md, MachineState *ms);
>>    void memory_device_unplug(MemoryDeviceState *md, MachineState *ms);
>>    uint64_t memory_device_get_region_size(const MemoryDeviceState *md,
>>                                           Error **errp);
>> +void memory_devices_init(MachineState *ms, hwaddr base, uint64_t size);
> 
> 
> While hw/mem/memory-device.c contains the implementation, all callers
> are expected to be around Machine object, right? Thus maybe this _init()
> could be declared in "hw/boards.h", already included by machines
> (eventually renaming as machine_init_memory_devices() ). Then machines
> implementation don't have to all include "hw/mem/memory-device.h".

Some (arm, i386) want to call the hotplug handle functions either way, 
so they'll still have to include that header.

But sure, we can rename to machine_init_memory_devices() and declare it 
include/hw/boards.h!

> 
> Alternatively, keep memory_devices_init() declared here, but implement
> machine_init_memory_devices() in hw/core/machine.c, declaring it in
> "hw/boards.h", so again machines don't have to include
> "hw/mem/memory-device.h".

I prefer the implementation residing in hw/mem/memory-device.c. I have 
some upcoming patches that add more "meat" to the init function, such 
that makes it looks cleaner to me to just reside hw/mem/memory-device.h.

Thanks!

-- 
Thanks,

David / dhildenb


