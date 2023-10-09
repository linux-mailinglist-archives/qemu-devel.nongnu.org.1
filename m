Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DE07BE1EA
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 15:55:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpqjY-0003fh-AS; Mon, 09 Oct 2023 09:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qpqjT-0003fK-05
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:55:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qpqjI-0003P3-Je
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696859727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N6twfO3yqRgTzT5YQZu6+KoQxXtSnswIhfjKrGDya4o=;
 b=PvUy9rLjDMAcAhtFuu9zvhGpeD3wfLaBagsTEvWP0taAXdrFs49OSTvlxWlOaAw5cMVvql
 0Yy+LdDdE/bXIssl8O2WhB0DLCB41TLProiog6wN9bD5/BlSeg1azaVaZBOdMwo8iNZucd
 3ZwZa+4Oi9G+XHg5OnXCfJ08jMRei/4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-XUd7-pTUO5mtbRn52CKk9w-1; Mon, 09 Oct 2023 09:55:25 -0400
X-MC-Unique: XUd7-pTUO5mtbRn52CKk9w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f5df65fa35so29096905e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 06:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696859724; x=1697464524;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N6twfO3yqRgTzT5YQZu6+KoQxXtSnswIhfjKrGDya4o=;
 b=gNqZDLAfIcacgskuOgNEz6ThIteEV5hcev7Y6/Xa5VSM8pI6XZbCHzj1ldHHOSW9oK
 +v6IK3DnCPaV16rzwxWyTsvIWmkRA+PqebB6t9/KEKn8yIhBWtPCV+3nVplM+xkThUNA
 kOjZDefYkazwdriKrY/UbUbUfNwg1VYYtbNMCxsK0rUz9o9dYnI/YWE/HpnN+/0gGqJW
 lvXuppDHt6e6tVfdtGRxUKUKzAp3TJoaavYjXCX0m47TtDkM/HkiojWnDGy9YcIS4oGQ
 FRd16K1AggHCLpoRQ9zjUQhcTtd11S9LGvEhuYYTcyKD/5o8S5TNElXY7WtsFTxPnDYL
 xNMw==
X-Gm-Message-State: AOJu0YyWY9HcCruVBSfbRPrxcO4GFnnOImY1i+2XrWTz+GW47PV6rOP5
 kt4JClXUnAC+HLR4K+6i50rvVvsS3fdSN6Lsdt5RZXI7skUwk9YVHRfujMgvxDBbmEA1bJIzDla
 +6a/dUE6kAlMfJs0=
X-Received: by 2002:a7b:cd0a:0:b0:405:3ae6:2400 with SMTP id
 f10-20020a7bcd0a000000b004053ae62400mr13924597wmj.23.1696859724334; 
 Mon, 09 Oct 2023 06:55:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO+3d3CFoj/QLUfXveEwtSADGsDs2xIoiwsrE0KXDxlCyyyGlMt9g4zBfKNQv5xyfcwKqocA==
X-Received: by 2002:a7b:cd0a:0:b0:405:3ae6:2400 with SMTP id
 f10-20020a7bcd0a000000b004053ae62400mr13924566wmj.23.1696859723919; 
 Mon, 09 Oct 2023 06:55:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c733:6400:ae10:4bb7:9712:8548?
 (p200300cbc7336400ae104bb797128548.dip0.t-ipconnect.de.
 [2003:cb:c733:6400:ae10:4bb7:9712:8548])
 by smtp.gmail.com with ESMTPSA id
 l17-20020a1ced11000000b0040588d85b3asm13447466wmh.15.2023.10.09.06.55.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 06:55:23 -0700 (PDT)
Message-ID: <be019441-793f-bbf1-2b7e-aa32005ead80@redhat.com>
Date: Mon, 9 Oct 2023 15:55:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V3 03/10] hw/acpi: Add ACPI CPU hotplug init stub
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
 <20231009112812.10612-4-salil.mehta@huawei.com>
 <8a80612f-07d3-6302-31f9-232d9ce393a1@redhat.com>
 <08840ea0a68e46b1a9d98d1e3544f43b@huawei.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <08840ea0a68e46b1a9d98d1e3544f43b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 09.10.23 15:49, Salil Mehta wrote:
>> From: David Hildenbrand <david@redhat.com>
>> Sent: Monday, October 9, 2023 1:23 PM
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
>> Subject: Re: [PATCH V3 03/10] hw/acpi: Add ACPI CPU hotplug init stub
>>
>> On 09.10.23 13:28, Salil Mehta wrote:
>>> ACPI CPU hotplug related initialization should only happen if
>> ACPI_CPU_HOTPLUG
>>> support has been enabled for particular architecture. Add
>> cpu_hotplug_hw_init()
>>> stub to avoid compilation break.
>>>
>>> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>>> ---
>>>    hw/acpi/acpi-cpu-hotplug-stub.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-
>> stub.c
>>> index 3fc4b14c26..c6c61bb9cd 100644
>>> --- a/hw/acpi/acpi-cpu-hotplug-stub.c
>>> +++ b/hw/acpi/acpi-cpu-hotplug-stub.c
>>> @@ -19,6 +19,12 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion
>> *parent, Object *owner,
>>>        return;
>>>    }
>>>
>>> +void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
>>> +                         CPUHotplugState *state, hwaddr base_addr)
>>> +{
>>> +    return;
>>> +}
>>
>> While at it, can we prefix that function with acpi?
> 
> I can do that but it has to be done at other places as well
> such as in hw/acpi/cpu_hotplug.c <acpi_switch_to_modern_cphp()>
> 

$ git grep cpu_hotplug_hw_init
hw/acpi/cpu.c:void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
hw/acpi/cpu_hotplug.c:    cpu_hotplug_hw_init(parent, gpe_cpu->device, cpuhp_state, io_port);
include/hw/acpi/cpu.h:void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,

Might want to do that as a separate patch, agreed.

-- 
Cheers,

David / dhildenb


