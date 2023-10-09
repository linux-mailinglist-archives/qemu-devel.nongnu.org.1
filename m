Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC607BE245
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 16:14:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpr1R-0002WD-3I; Mon, 09 Oct 2023 10:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qpr1O-0002VR-Po
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:14:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qpr1N-0007CX-2K
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696860848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h9SaR8WLJqfcT2+oNA6lH0kqikCMQzTxDsyxXSA5XVc=;
 b=iYq55u7jkjApcUldmtZwpi2cHWksqmGIgN5f/uNjkedNynlCglOtvFXFFw1i172/i9oKvz
 VwBoY1rWJkoywmIXPbA6fZMVYSYEQsdDkZbEKwAR2nq9z4vNAjL20xwnni8tDRfN26O6KH
 TV/zAjqX774Yqy22bNvffo1NYLog4EA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-6no6DcNBNKqoEQYxFMYb_A-1; Mon, 09 Oct 2023 10:14:07 -0400
X-MC-Unique: 6no6DcNBNKqoEQYxFMYb_A-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3231fceb811so3346881f8f.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 07:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696860846; x=1697465646;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h9SaR8WLJqfcT2+oNA6lH0kqikCMQzTxDsyxXSA5XVc=;
 b=v1Rw2WF3PecjLOgnjoH9yX3Gh7HOWi5IeyxdUeymxGw2D7n0LhZkk2IT8DdTbSbaW6
 tT9YOZjl05Y7b/DO0LTOGiiQxA3+q6qA8lSVE9YT0wdZEShhDsZos5+UqBLvU0jOqjLg
 ymFqae9lElA1sWwjxblhSlcaCo2FAOIv8MB4foJqVpfpG6Aer33sg+Qk92X75HPLdPNm
 g0TphQ2qEa2LbX62U43jWCDbt0aeoPfdzIFutw8g26Xhy5m3JhYechHBbHGivOqRJIcn
 jXYGdwepHSjIJH4isJQOlV8YrCeACyxbG4pYmEiplxBkPIxYlSCxOVvXw0YkE7vR9Dkf
 hVZg==
X-Gm-Message-State: AOJu0YzuJRCVIssveA+Amr0dNjadUNWuGnBHap2HkNSjmmZXZV8Pb9hv
 0VK0ffaB2oV73+iKlsQoYQlQjl+ZwfkIfz1tSwj28qXDnYp1fKOa9a3KSeS136bPIfRN76EpWuU
 zuXjBeaxrqijUmsM=
X-Received: by 2002:a5d:4990:0:b0:313:e971:53af with SMTP id
 r16-20020a5d4990000000b00313e97153afmr14464681wrq.32.1696860845987; 
 Mon, 09 Oct 2023 07:14:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEJPmJbL/Rnac4+fXTFwCLFHqKn0dkDprekMMBnZEi73yjSndsywH4oQDweabVPEIlA0DaXg==
X-Received: by 2002:a5d:4990:0:b0:313:e971:53af with SMTP id
 r16-20020a5d4990000000b00313e97153afmr14464663wrq.32.1696860845565; 
 Mon, 09 Oct 2023 07:14:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c733:6400:ae10:4bb7:9712:8548?
 (p200300cbc7336400ae104bb797128548.dip0.t-ipconnect.de.
 [2003:cb:c733:6400:ae10:4bb7:9712:8548])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a5d68c4000000b003232f167df5sm9785589wrw.108.2023.10.09.07.14.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 07:14:05 -0700 (PDT)
Message-ID: <11e7cf3f-e733-1109-4b8d-918ba445eeea@redhat.com>
Date: Mon, 9 Oct 2023 16:14:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V3 04/10] hw/acpi: Init GED framework with cpu hotplug
 events
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "gshan@redhat.com" <gshan@redhat.com>, "rafael@kernel.org"
 <rafael@kernel.org>, "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 Linuxarm <linuxarm@huawei.com>
References: <20231009112812.10612-1-salil.mehta@huawei.com>
 <20231009112812.10612-5-salil.mehta@huawei.com>
 <794b07a3-6004-23e2-189a-f76952751112@redhat.com>
 <0e9c23f079ac417687c8261739ea22f2@huawei.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <0e9c23f079ac417687c8261739ea22f2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 09.10.23 16:12, Salil Mehta wrote:
>> From: David Hildenbrand <david@redhat.com>
>> Sent: Monday, October 9, 2023 1:27 PM
>> To: Salil Mehta <salil.mehta@huawei.com>; qemu-devel@nongnu.org; qemu-
>> arm@nongnu.org
>> Cc: maz@kernel.org; jean-philippe@linaro.org; Jonathan Cameron
>> <jonathan.cameron@huawei.com>; lpieralisi@kernel.org;
>> peter.maydell@linaro.org; richard.henderson@linaro.org;
>> imammedo@redhat.com; andrew.jones@linux.dev; philmd@linaro.org;
>> eric.auger@redhat.com; oliver.upton@linux.dev; pbonzini@redhat.com;
>> mst@redhat.com; will@kernel.org; gshan@redhat.com; rafael@kernel.org;
>> alex.bennee@linaro.org; linux@armlinux.org.uk;
>> darren@os.amperecomputing.com; ilkka@os.amperecomputing.com;
>> vishnu@os.amperecomputing.com; karl.heubaum@oracle.com;
>> miguel.luis@oracle.com; salil.mehta@opnsrc.net; zhukeqian
>> <zhukeqian1@huawei.com>; wangxiongfeng (C) <wangxiongfeng2@huawei.com>;
>> wangyanan (Y) <wangyanan55@huawei.com>; jiakernel2@gmail.com;
>> maobibo@loongson.cn; lixianglai@loongson.cn; Linuxarm <linuxarm@huawei.com>
>> Subject: Re: [PATCH V3 04/10] hw/acpi: Init GED framework with cpu hotplug
>> events
>>
>> On 09.10.23 13:28, Salil Mehta wrote:
>>> ACPI GED(as described in the ACPI 6.2 spec) can be used to generate ACPI
>> events
>>> when OSPM/guest receives an interrupt listed in the _CRS object of GED.
>> OSPM
>>> then maps or demultiplexes the event by evaluating _EVT method.
>>>
>>> This change adds the support of cpu hotplug event initialization in the
>>> existing GED framework.
>>>
>>> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
>>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>>> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>    hw/acpi/generic_event_device.c         | 8 ++++++++
>>>    include/hw/acpi/generic_event_device.h | 5 +++++
>>>    2 files changed, 13 insertions(+)
>>>
>>> diff --git a/hw/acpi/generic_event_device.c
>> b/hw/acpi/generic_event_device.c
>>> index a3d31631fe..d2fa1d0e4a 100644
>>> --- a/hw/acpi/generic_event_device.c
>>> +++ b/hw/acpi/generic_event_device.c
>>> @@ -25,6 +25,7 @@ static const uint32_t ged_supported_events[] = {
>>>        ACPI_GED_MEM_HOTPLUG_EVT,
>>>        ACPI_GED_PWR_DOWN_EVT,
>>>        ACPI_GED_NVDIMM_HOTPLUG_EVT,
>>> +    ACPI_GED_CPU_HOTPLUG_EVT,
>>>    };
>>>
>>>    /*
>>> @@ -400,6 +401,13 @@ static void acpi_ged_initfn(Object *obj)
>>>        memory_region_init_io(&ged_st->regs, obj, &ged_regs_ops, ged_st,
>>>                              TYPE_ACPI_GED "-regs", ACPI_GED_REG_COUNT);
>>>        sysbus_init_mmio(sbd, &ged_st->regs);
>>> +
>>> +    s->cpuhp.device = OBJECT(s);
>>> +    memory_region_init(&s->container_cpuhp, OBJECT(dev), "cpuhp
>> container",
>>> +                       ACPI_CPU_HOTPLUG_REG_LEN);
>>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->container_cpuhp);
>>> +    cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
>>> +                        &s->cpuhp_state, 0);
>>>    }
>>>
>>>    static void acpi_ged_class_init(ObjectClass *class, void *data)
>>> diff --git a/include/hw/acpi/generic_event_device.h
>> b/include/hw/acpi/generic_event_device.h
>>> index d831bbd889..d0a5a43abf 100644
>>> --- a/include/hw/acpi/generic_event_device.h
>>> +++ b/include/hw/acpi/generic_event_device.h
>>> @@ -60,6 +60,7 @@
>>>    #define HW_ACPI_GENERIC_EVENT_DEVICE_H
>>>
>>>    #include "hw/sysbus.h"
>>> +#include "hw/acpi/cpu_hotplug.h"
>>>    #include "hw/acpi/memory_hotplug.h"
>>>    #include "hw/acpi/ghes.h"
>>>    #include "qom/object.h"
>>> @@ -97,6 +98,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>>>    #define ACPI_GED_MEM_HOTPLUG_EVT   0x1
>>>    #define ACPI_GED_PWR_DOWN_EVT      0x2
>>>    #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
>>> +#define ACPI_GED_CPU_HOTPLUG_EVT    0x8
>>>
>>>    typedef struct GEDState {
>>>        MemoryRegion evt;
>>> @@ -108,6 +110,9 @@ struct AcpiGedState {
>>>        SysBusDevice parent_obj;
>>>        MemHotplugState memhp_state;
>>>        MemoryRegion container_memhp;
>>> +    CPUHotplugState cpuhp_state;
>>> +    MemoryRegion container_cpuhp;
>>> +    AcpiCpuHotplug cpuhp;
>>
>> Am I wrong or is that member completely unused/uninitialized?
> 
> No it is not. Please check below change in acpi_ged_initfn()
> 
> +    s->cpuhp.device = OBJECT(s);

Not the best of my mondays, sorry for that.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


