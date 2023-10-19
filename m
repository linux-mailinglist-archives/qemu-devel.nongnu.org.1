Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5EF7D0061
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 19:21:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtWiB-0002dI-UG; Thu, 19 Oct 2023 13:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qtWhp-0002W0-Ps
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 13:21:09 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qtWhn-0003bn-Fs
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 13:21:09 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9ada2e6e75fso1404224266b.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 10:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697736063; x=1698340863; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NvqPmdWFyP5NJ2WRRryk/Qk0Cxi5tD/muXIQ1DxwZGQ=;
 b=mJHlIQELO+w7bI/MLmnueGplM6q7P5sE+oa84Njm43K/RJnorAZqv3H15T7WE8NXFP
 UaBcdhh9O8HbRyiIokAZgMh0FThoh1OqeItmuCaGmhrjyrVVSsgzU1k1KpvgB2Jmv47E
 2CZAsRZl4vGzkisvvdfrv4l7ho8tp1s6dDq533azfDYm7Wh7FtkkjfEYE11Ny+ulQRSJ
 s6MaOPtZSshewztR/4G871OW0IlUZZvidV+daJuhYuA/Bb+EPA02EEa+HTItdVxNVO/w
 MQqkQDBb44eCwdu2qIRHm3W50mJf9j4dsJp+TG0w4f+OGMKAKcVNBSnHw29pRfjrwSkQ
 zoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697736063; x=1698340863;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NvqPmdWFyP5NJ2WRRryk/Qk0Cxi5tD/muXIQ1DxwZGQ=;
 b=mlKOWTUBMJtelQRRMFUkgYhboteUwsWjVxXAWrU0XZop/WR8DG5TnbAaMdGROqEK4I
 2wCSIEqmuW2bsF+yVYCxmkCZDyVYYn+q+KVwbYQUJiGp2ijhRzGboeuCOvbFcdqn9O7e
 JxPj9o6TZqf+f3hbAWVAnIKfIjZYJ750TjACSa2WXB2JWkL4NjByPKRcQOiseOYJt4EX
 VRuzpd71E84Vdpe0nm5Dsj+DXDUN1Rqr9OI+k/zGndS32zIWtgF/yul5QDl9AJ6dE8Qy
 RQMfz5dZtGDeNS+0LGbBdbXkVLIsV8Z15eAqh14QwBKWe4dqr1eBRbqb4IWnz6SeQWw/
 spYA==
X-Gm-Message-State: AOJu0YxdIkTYE4thQ4JCOSuQgXNmpIkcYaQh1ZSHj4xL0m8C/QsdBBHP
 CtOqR+KO+QKl22SF1/Zp4IE=
X-Google-Smtp-Source: AGHT+IFRFqxVrOkc7JiLN7cG+wAc9Bs6H8Iz+QJlIKywxc/05t9dpyStlzWdbGtA3hVBT21VIZvwRA==
X-Received: by 2002:a17:907:3687:b0:9bd:abb2:d4e0 with SMTP id
 bi7-20020a170907368700b009bdabb2d4e0mr2006500ejc.22.1697736063157; 
 Thu, 19 Oct 2023 10:21:03 -0700 (PDT)
Received: from [127.0.0.1] ([90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 lc21-20020a170906f91500b009a19701e7b5sm3918168ejb.96.2023.10.19.10.21.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 10:21:02 -0700 (PDT)
Date: Thu, 19 Oct 2023 10:33:08 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Salil Mehta <salil.mehta@opnsrc.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org
CC: Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PULL v2 29/53] hw/i386: Remove now redundant TYPE_ACPI_GED_X86
In-Reply-To: <15e70616-6abb-63a4-17d0-820f4a254607@opnsrc.net>
References: <cover.1696477105.git.mst@redhat.com>
 <c9c8ba69d5dbe5c1c6370e1f09ebd7531509d075.1696477105.git.mst@redhat.com>
 <15e70616-6abb-63a4-17d0-820f4a254607@opnsrc.net>
Message-ID: <BE6564AF-6317-49CB-91AF-C88F1D31DF4E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



Am 18=2E Oktober 2023 17:38:33 UTC schrieb Salil Mehta <salil=2Emehta@opns=
rc=2Enet>:
>Hello,

Hi Salil,

>Can we assume that every machine type will have all the features which a =
GED Device can multiplex present together? like will Memory and CPU Hotplug=
 makes sense for all the type of machines?

I can't really answer these questions -- I'm by no means an ACPI expert=2E=
 My idea about removing TYPE_ACPI_GED_X86 really was not more than the comm=
it message says: To remove unneeded code=2E

That said, I wonder myself if the GED device could be uniformly implemente=
d across architectures and if -- in theory -- it could be used in the pc-i4=
40fx machine instead of the Frankenstein hotplug implementation in PIIX4=2E

Best regards,
Bernhard

>
>If answer is no, then shouldn't every machine type override the base GED =
type and define it own versions of instance_init() function? AFAICS, GED ca=
n multiplex non-hotplug events as well=2E
>
>To support CPU Htoplug on ARM platforms we are using GED but x86/microvm =
does not supports hot-plugging and while creating TYPE_GED_DEVICE it will e=
nd up initializing CPU Hotplug regions and code as well=2E This is far from=
 clean=2E
>
>Beside 'qtest' fails for x86/microvm machine type because 'possible_cpus_=
arch_ids' is not defined for x86/microvm so we get errors like below:
>
>stderr:
>qemu-system-x86_64: =2E=2E/hw/acpi/cpu=2Ec:224: cpu_hotplug_hw_init: Asse=
rtion `mc->possible_cpu_arch_ids' failed=2E
>Broken pipe
>=2E=2E/tests/qtest/libqtest=2Ec:200: kill_qemu() detected QEMU death from=
 signal 6 (Aborted) (core dumped)
>
>Above can be avoided if cpu_hotplug_hw_init() does not gets called for x8=
6/microvm machine=2E
>
>ARM can have its own version of generic_event_device_arm64=2Ec with its o=
wn version of instance_init() having a call to cpu_hotplug_hw_init()=2E
>
>Maybe I have missed something here?
>
>
>Many thanks
>Salil=2E
>
>
>On 05/10/2023 04:44, Michael S=2E Tsirkin wrote:
>> From: Bernhard Beschow <shentey@gmail=2Ecom>
>>=20
>> Now that TYPE_ACPI_GED_X86 doesn't assign AcpiDeviceIfClass::madt_cpu a=
ny more
>> it is the same as TYPE_ACPI_GED=2E
>>=20
>> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>> Message-Id: <20230908084234=2E17642-6-shentey@gmail=2Ecom>
>> Reviewed-by: Michael S=2E Tsirkin <mst@redhat=2Ecom>
>> Signed-off-by: Michael S=2E Tsirkin <mst@redhat=2Ecom>
>> ---
>>   include/hw/acpi/generic_event_device=2Eh |  2 --
>>   hw/i386/generic_event_device_x86=2Ec     | 27 -----------------------=
---
>>   hw/i386/microvm=2Ec                      |  2 +-
>>   hw/i386/meson=2Ebuild                    |  1 -
>>   4 files changed, 1 insertion(+), 31 deletions(-)
>>   delete mode 100644 hw/i386/generic_event_device_x86=2Ec
>>=20
>> diff --git a/include/hw/acpi/generic_event_device=2Eh b/include/hw/acpi=
/generic_event_device=2Eh
>> index d831bbd889=2E=2Eba84ce0214 100644
>> --- a/include/hw/acpi/generic_event_device=2Eh
>> +++ b/include/hw/acpi/generic_event_device=2Eh
>> @@ -69,8 +69,6 @@
>>   #define TYPE_ACPI_GED "acpi-ged"
>>   OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>>   -#define TYPE_ACPI_GED_X86 "acpi-ged-x86"
>> -
>>   #define ACPI_GED_EVT_SEL_OFFSET    0x0
>>   #define ACPI_GED_EVT_SEL_LEN       0x4
>>   diff --git a/hw/i386/generic_event_device_x86=2Ec b/hw/i386/generic_e=
vent_device_x86=2Ec
>> deleted file mode 100644
>> index 8fc233e1f1=2E=2E0000000000
>> --- a/hw/i386/generic_event_device_x86=2Ec
>> +++ /dev/null
>> @@ -1,27 +0,0 @@
>> -/*
>> - * x86 variant of the generic event device for hw reduced acpi
>> - *
>> - * This program is free software; you can redistribute it and/or modif=
y it
>> - * under the terms and conditions of the GNU General Public License,
>> - * version 2 or later, as published by the Free Software Foundation=2E
>> - */
>> -
>> -#include "qemu/osdep=2Eh"
>> -#include "hw/acpi/generic_event_device=2Eh"
>> -
>> -static const TypeInfo acpi_ged_x86_info =3D {
>> -    =2Ename          =3D TYPE_ACPI_GED_X86,
>> -    =2Eparent        =3D TYPE_ACPI_GED,
>> -    =2Einterfaces =3D (InterfaceInfo[]) {
>> -        { TYPE_HOTPLUG_HANDLER },
>> -        { TYPE_ACPI_DEVICE_IF },
>> -        { }
>> -    }
>> -};
>> -
>> -static void acpi_ged_x86_register_types(void)
>> -{
>> -    type_register_static(&acpi_ged_x86_info);
>> -}
>> -
>> -type_init(acpi_ged_x86_register_types)
>> diff --git a/hw/i386/microvm=2Ec b/hw/i386/microvm=2Ec
>> index 8deeb62774=2E=2Eb9c93039e2 100644
>> --- a/hw/i386/microvm=2Ec
>> +++ b/hw/i386/microvm=2Ec
>> @@ -204,7 +204,7 @@ static void microvm_devices_init(MicrovmMachineStat=
e *mms)
>>         /* Optional and legacy devices */
>>       if (x86_machine_is_acpi_enabled(x86ms)) {
>> -        DeviceState *dev =3D qdev_new(TYPE_ACPI_GED_X86);
>> +        DeviceState *dev =3D qdev_new(TYPE_ACPI_GED);
>>           qdev_prop_set_uint32(dev, "ged-event", ACPI_GED_PWR_DOWN_EVT)=
;
>>           sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, GED_MMIO_BASE);
>>           /* sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, GED_MMIO_BASE_MEMH=
P); */
>> diff --git a/hw/i386/meson=2Ebuild b/hw/i386/meson=2Ebuild
>> index cfdbfdcbcb=2E=2Eff879069c9 100644
>> --- a/hw/i386/meson=2Ebuild
>> +++ b/hw/i386/meson=2Ebuild
>> @@ -20,7 +20,6 @@ i386_ss=2Eadd(when: 'CONFIG_SGX', if_true: files('sgx=
-epc=2Ec','sgx=2Ec'),
>>                                   if_false: files('sgx-stub=2Ec'))
>>     i386_ss=2Eadd(when: 'CONFIG_ACPI', if_true: files('acpi-common=2Ec'=
))
>> -i386_ss=2Eadd(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_=
event_device_x86=2Ec'))
>>   i386_ss=2Eadd(when: 'CONFIG_PC', if_true: files(
>>     'pc=2Ec',
>>     'pc_sysfw=2Ec',
>>=20

