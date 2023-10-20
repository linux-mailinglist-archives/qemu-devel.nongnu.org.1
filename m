Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F00C67D19BE
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 01:56:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtzKd-0002Fy-3E; Fri, 20 Oct 2023 19:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1qtzKb-0002Fl-9V
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 19:55:05 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1qtzKW-0005Hi-OT
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 19:55:05 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32caaa1c493so974874f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 16:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1697846098; x=1698450898; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xz8bWnjdOplbbo/tIACduAuNBNSv3px5fnsiJDBLxFA=;
 b=h6rwJ4dKWdxEBXPis7cgjtCWv9rAzLUCr28+fFyF/VqzAUSaK3mGc42cPYpkWER8I4
 B5KRq/iAeOVNKdMi0azlIST9dyyr/qkjfd0n+ELHkBtAFed/8/DNsOCR3Eiso3Y7mBrx
 ii7zlR/Vxxn1skY9vGj5xtdP6ulbwZ3A9wNToHEpyFDK0x5lLLCiDkllUXaFLv1du2I9
 g0dYUv6+Ayz+1ygp3T2qaA+f4ZXB2GEint7DAiCtwo4MEvWz7kLrvILvlC7Nejm/u2Kt
 G0iRqrePNY4+KDiYaHoeu+91/DrlH+6I8L1V/BeIHpCHmqXx9atMmLeqpkCQ7ETxSRi5
 hNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697846098; x=1698450898;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xz8bWnjdOplbbo/tIACduAuNBNSv3px5fnsiJDBLxFA=;
 b=om9EEiSvPWAP0T/NFZJLuKqAiXrO6LxtV2E1aIt/yNo7cNl+mkgV7aIM8+nB0VM6FA
 MrXWiMS4LKrhxBom5UWfobKiQEDSv+UovRe+0XJIBd4VDZjVWuc7M6sDxa52tbU+xL2+
 DYmdafN0DnnHAsZD2UMU5rmVQB9FP3AyxITCnxv2LbBPyMQPqfuX6AF0IxGpEV5KDn8M
 FQYrfm7p4pelrCVjGCE88XBv7HNoaxfp+khf2xpa/2Scn7AcjBGFsfGEkj7jcy4FFcX6
 7emRbsdfw3eakiomsj93jBoXYTMmOLXbH4JPAf92oUO2jhqA4p6XAFVLskc4BIujgTTc
 eWmw==
X-Gm-Message-State: AOJu0YzZ/HeuD/iwmsXAVbfmDOk59TRtPjHu8/2RJ5DQzz7XLN2PJiWV
 ssXy4XrH3SxOW5gYMm1PZZOn7Q==
X-Google-Smtp-Source: AGHT+IHLOErmRT7ZnKnRgpE65nmUi6JJYT46t/VNEi7uVTDYee3pcxMOuv4q9ll5olJKNGrvYmmbFQ==
X-Received: by 2002:adf:ef8b:0:b0:32d:b8f8:2b1b with SMTP id
 d11-20020adfef8b000000b0032db8f82b1bmr2205690wro.26.1697846097988; 
 Fri, 20 Oct 2023 16:54:57 -0700 (PDT)
Received: from [10.8.0.13] ([185.223.232.243])
 by smtp.gmail.com with ESMTPSA id
 c4-20020a056000104400b003142e438e8csm2616134wrx.26.2023.10.20.16.54.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 16:54:57 -0700 (PDT)
Subject: Re: [PULL v2 29/53] hw/i386: Remove now redundant TYPE_ACPI_GED_X86
To: Bernhard Beschow <shentey@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
 <c9c8ba69d5dbe5c1c6370e1f09ebd7531509d075.1696477105.git.mst@redhat.com>
 <15e70616-6abb-63a4-17d0-820f4a254607@opnsrc.net>
 <BE6564AF-6317-49CB-91AF-C88F1D31DF4E@gmail.com>
From: Salil Mehta <salil.mehta@opnsrc.net>
Message-ID: <7234ffe0-d617-1b0f-b61a-986724ffd20a@opnsrc.net>
Date: Sat, 21 Oct 2023 00:54:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <BE6564AF-6317-49CB-91AF-C88F1D31DF4E@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wr1-x433.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Bernhard,

On 19/10/2023 11:33, Bernhard Beschow wrote:
> 
> 
> Am 18. Oktober 2023 17:38:33 UTC schrieb Salil Mehta <salil.mehta@opnsrc.net>:
>> Hello,
> 
> Hi Salil,
> 
>> Can we assume that every machine type will have all the features which a GED Device can multiplex present together? like will Memory and CPU Hotplug makes sense for all the type of machines?
> 
> I can't really answer these questions -- I'm by no means an ACPI expert. My idea about removing TYPE_ACPI_GED_X86 really was not more than the commit message says: To remove unneeded code.


Sure, cleanup is not an issue.

In fact, question is whether every machine type would be interested in 
initializing other code like hot-plug related initialization in the 
acpi_get_intfn() especially when that machine type does not supports it.

Another question is whether every machine can without breaking other 
architecture or features?


Even in your case as well some unnecessary code legs will get 
initialized so cleanup is not complete either - isn't it?


For now, I will proceed with changing this for ARM and then if x86 needs 
it can either revert this patch or re-implement it as also suggested by 
Michael?


> 
> That said, I wonder myself if the GED device could be uniformly implemented across architectures and if -- in theory -- it could be used in the pc-i440fx machine instead of the Frankenstein hotplug implementation in PIIX4.


I will leave it up to x86 maintainers to answer that.

But superficially, it looks there are some historical reasons (maybe 
related to legacy firmware?) because of which the switch from legacy to 
modern type of CPU Hotplug interface happens.


Thanks
Salil.

> 
> Best regards,
> Bernhard
> 
>>
>> If answer is no, then shouldn't every machine type override the base GED type and define it own versions of instance_init() function? AFAICS, GED can multiplex non-hotplug events as well.
>>
>> To support CPU Htoplug on ARM platforms we are using GED but x86/microvm does not supports hot-plugging and while creating TYPE_GED_DEVICE it will end up initializing CPU Hotplug regions and code as well. This is far from clean.
>>
>> Beside 'qtest' fails for x86/microvm machine type because 'possible_cpus_arch_ids' is not defined for x86/microvm so we get errors like below:
>>
>> stderr:
>> qemu-system-x86_64: ../hw/acpi/cpu.c:224: cpu_hotplug_hw_init: Assertion `mc->possible_cpu_arch_ids' failed.
>> Broken pipe
>> ../tests/qtest/libqtest.c:200: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
>>
>> Above can be avoided if cpu_hotplug_hw_init() does not gets called for x86/microvm machine.
>>
>> ARM can have its own version of generic_event_device_arm64.c with its own version of instance_init() having a call to cpu_hotplug_hw_init().
>>
>> Maybe I have missed something here?
>>
>>
>> Many thanks
>> Salil.
>>
>>
>> On 05/10/2023 04:44, Michael S. Tsirkin wrote:
>>> From: Bernhard Beschow <shentey@gmail.com>
>>>
>>> Now that TYPE_ACPI_GED_X86 doesn't assign AcpiDeviceIfClass::madt_cpu any more
>>> it is the same as TYPE_ACPI_GED.
>>>
>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Message-Id: <20230908084234.17642-6-shentey@gmail.com>
>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> ---
>>>    include/hw/acpi/generic_event_device.h |  2 --
>>>    hw/i386/generic_event_device_x86.c     | 27 --------------------------
>>>    hw/i386/microvm.c                      |  2 +-
>>>    hw/i386/meson.build                    |  1 -
>>>    4 files changed, 1 insertion(+), 31 deletions(-)
>>>    delete mode 100644 hw/i386/generic_event_device_x86.c
>>>
>>> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
>>> index d831bbd889..ba84ce0214 100644
>>> --- a/include/hw/acpi/generic_event_device.h
>>> +++ b/include/hw/acpi/generic_event_device.h
>>> @@ -69,8 +69,6 @@
>>>    #define TYPE_ACPI_GED "acpi-ged"
>>>    OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>>>    -#define TYPE_ACPI_GED_X86 "acpi-ged-x86"
>>> -
>>>    #define ACPI_GED_EVT_SEL_OFFSET    0x0
>>>    #define ACPI_GED_EVT_SEL_LEN       0x4
>>>    diff --git a/hw/i386/generic_event_device_x86.c b/hw/i386/generic_event_device_x86.c
>>> deleted file mode 100644
>>> index 8fc233e1f1..0000000000
>>> --- a/hw/i386/generic_event_device_x86.c
>>> +++ /dev/null
>>> @@ -1,27 +0,0 @@
>>> -/*
>>> - * x86 variant of the generic event device for hw reduced acpi
>>> - *
>>> - * This program is free software; you can redistribute it and/or modify it
>>> - * under the terms and conditions of the GNU General Public License,
>>> - * version 2 or later, as published by the Free Software Foundation.
>>> - */
>>> -
>>> -#include "qemu/osdep.h"
>>> -#include "hw/acpi/generic_event_device.h"
>>> -
>>> -static const TypeInfo acpi_ged_x86_info = {
>>> -    .name          = TYPE_ACPI_GED_X86,
>>> -    .parent        = TYPE_ACPI_GED,
>>> -    .interfaces = (InterfaceInfo[]) {
>>> -        { TYPE_HOTPLUG_HANDLER },
>>> -        { TYPE_ACPI_DEVICE_IF },
>>> -        { }
>>> -    }
>>> -};
>>> -
>>> -static void acpi_ged_x86_register_types(void)
>>> -{
>>> -    type_register_static(&acpi_ged_x86_info);
>>> -}
>>> -
>>> -type_init(acpi_ged_x86_register_types)
>>> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
>>> index 8deeb62774..b9c93039e2 100644
>>> --- a/hw/i386/microvm.c
>>> +++ b/hw/i386/microvm.c
>>> @@ -204,7 +204,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
>>>          /* Optional and legacy devices */
>>>        if (x86_machine_is_acpi_enabled(x86ms)) {
>>> -        DeviceState *dev = qdev_new(TYPE_ACPI_GED_X86);
>>> +        DeviceState *dev = qdev_new(TYPE_ACPI_GED);
>>>            qdev_prop_set_uint32(dev, "ged-event", ACPI_GED_PWR_DOWN_EVT);
>>>            sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, GED_MMIO_BASE);
>>>            /* sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, GED_MMIO_BASE_MEMHP); */
>>> diff --git a/hw/i386/meson.build b/hw/i386/meson.build
>>> index cfdbfdcbcb..ff879069c9 100644
>>> --- a/hw/i386/meson.build
>>> +++ b/hw/i386/meson.build
>>> @@ -20,7 +20,6 @@ i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
>>>                                    if_false: files('sgx-stub.c'))
>>>      i386_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-common.c'))
>>> -i386_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_event_device_x86.c'))
>>>    i386_ss.add(when: 'CONFIG_PC', if_true: files(
>>>      'pc.c',
>>>      'pc_sysfw.c',
>>>

