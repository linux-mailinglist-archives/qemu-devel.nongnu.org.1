Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E99F7CE4C4
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 19:39:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtAVG-0004Px-1w; Wed, 18 Oct 2023 13:38:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1qtAVD-0004Ph-8f
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 13:38:39 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1qtAVA-0002FZ-PV
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 13:38:38 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32daeed7771so3194801f8f.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 10:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1697650715; x=1698255515; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jRvOW4yUE6xSYpPG+TV9fuMMY7NtIhuMQQyc05JKdI8=;
 b=cHaSb4WKzgwkWoWMP3HMFWXPoP7ADpsdcxpO24nj4FqtHnJreUsRT7LuZLKQ3CBa3B
 8TG9NcF9avYB8H5WGP3eEopNem3xH6poXxStjd2SYuPNKIygoNTAuxpvteaf8FSKB4H3
 h99BAlcRAhWjgiZBQi02jtyhS9fyCCbEZQLo/+ExSlgnofAzDQGfJj+EO8yg9zPapYEu
 mcczyA2YNbvQ096Xfg+KxIXWgwbuqNhvsXHuiDtkYD22Two8xDHHU+eiAshqT5UJipIP
 ZOVCrUpv6PPXzzxcWaBkug4tGXr7fl2CIEhqF4yF7JhL7lFvglXrbA20XchreVxx5XH0
 trCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697650715; x=1698255515;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jRvOW4yUE6xSYpPG+TV9fuMMY7NtIhuMQQyc05JKdI8=;
 b=kvRTE6oyyv5w95MkUq2uhuCYPHGCIT0oRtoYxJYFWgUlrFBvmvr1o6wi17gDXiZO1A
 1TeBhoC0QACCIyTvlRk4NqDybQEvLgZG5FilIlneTJ6PvengDfd8BqTqbxrOmdEVdw6r
 geGx1glwhhJOwh1MfDphcv+q293j/D/fh/qSuUSS8Q4eA+4jEOWjiSwzS5i4dSIkTDSV
 DC6X2CEEFF3OScyNI2kGrubPxt7JsEiEx47Pqk5iYRe14GUFazOP4K44ybIEQ2wPjqSG
 FbR6BudH1q8u+vTLDdfzPjebXzstXktWluxgYzv9KciNrPcLdOld04a4nzgWdUq0pDxE
 SYRw==
X-Gm-Message-State: AOJu0YwxuqZpWG20Z3QqzdqZ9qBO4BcVBz4o2ZZX7ZrEYanxo0NWIgc4
 m5i9koTy+eVkzo5Ef8cylNAR7g==
X-Google-Smtp-Source: AGHT+IHZ5w/7pMeO4JRSow8yEXOSltj2Ig9BABTNS33J8zWAfC4MKpkB1UHpRhdsS/pmH741TP9kQg==
X-Received: by 2002:a5d:4690:0:b0:32d:bb4a:525c with SMTP id
 u16-20020a5d4690000000b0032dbb4a525cmr5626297wrq.14.1697650715059; 
 Wed, 18 Oct 2023 10:38:35 -0700 (PDT)
Received: from [10.8.0.13] ([185.223.232.243])
 by smtp.gmail.com with ESMTPSA id
 c12-20020adfe70c000000b0031c6e1ea4c7sm2539970wrm.90.2023.10.18.10.38.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 10:38:34 -0700 (PDT)
Subject: Re: [PULL v2 29/53] hw/i386: Remove now redundant TYPE_ACPI_GED_X86
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
 <c9c8ba69d5dbe5c1c6370e1f09ebd7531509d075.1696477105.git.mst@redhat.com>
From: Salil Mehta <salil.mehta@opnsrc.net>
Message-ID: <15e70616-6abb-63a4-17d0-820f4a254607@opnsrc.net>
Date: Wed, 18 Oct 2023 18:38:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c9c8ba69d5dbe5c1c6370e1f09ebd7531509d075.1696477105.git.mst@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wr1-x42b.google.com
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

Hello,
Can we assume that every machine type will have all the features which a 
GED Device can multiplex present together? like will Memory and CPU 
Hotplug makes sense for all the type of machines?

If answer is no, then shouldn't every machine type override the base GED 
type and define it own versions of instance_init() function? AFAICS, GED 
can multiplex non-hotplug events as well.

To support CPU Htoplug on ARM platforms we are using GED but x86/microvm 
does not supports hot-plugging and while creating TYPE_GED_DEVICE it 
will end up initializing CPU Hotplug regions and code as well. This is 
far from clean.

Beside 'qtest' fails for x86/microvm machine type because 
'possible_cpus_arch_ids' is not defined for x86/microvm so we get errors 
like below:

stderr:
qemu-system-x86_64: ../hw/acpi/cpu.c:224: cpu_hotplug_hw_init: Assertion 
`mc->possible_cpu_arch_ids' failed.
Broken pipe
../tests/qtest/libqtest.c:200: kill_qemu() detected QEMU death from 
signal 6 (Aborted) (core dumped)

Above can be avoided if cpu_hotplug_hw_init() does not gets called for 
x86/microvm machine.

ARM can have its own version of generic_event_device_arm64.c with its 
own version of instance_init() having a call to cpu_hotplug_hw_init().

Maybe I have missed something here?


Many thanks
Salil.


On 05/10/2023 04:44, Michael S. Tsirkin wrote:
> From: Bernhard Beschow <shentey@gmail.com>
> 
> Now that TYPE_ACPI_GED_X86 doesn't assign AcpiDeviceIfClass::madt_cpu any more
> it is the same as TYPE_ACPI_GED.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-Id: <20230908084234.17642-6-shentey@gmail.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   include/hw/acpi/generic_event_device.h |  2 --
>   hw/i386/generic_event_device_x86.c     | 27 --------------------------
>   hw/i386/microvm.c                      |  2 +-
>   hw/i386/meson.build                    |  1 -
>   4 files changed, 1 insertion(+), 31 deletions(-)
>   delete mode 100644 hw/i386/generic_event_device_x86.c
> 
> diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> index d831bbd889..ba84ce0214 100644
> --- a/include/hw/acpi/generic_event_device.h
> +++ b/include/hw/acpi/generic_event_device.h
> @@ -69,8 +69,6 @@
>   #define TYPE_ACPI_GED "acpi-ged"
>   OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
>   
> -#define TYPE_ACPI_GED_X86 "acpi-ged-x86"
> -
>   #define ACPI_GED_EVT_SEL_OFFSET    0x0
>   #define ACPI_GED_EVT_SEL_LEN       0x4
>   
> diff --git a/hw/i386/generic_event_device_x86.c b/hw/i386/generic_event_device_x86.c
> deleted file mode 100644
> index 8fc233e1f1..0000000000
> --- a/hw/i386/generic_event_device_x86.c
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -/*
> - * x86 variant of the generic event device for hw reduced acpi
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms and conditions of the GNU General Public License,
> - * version 2 or later, as published by the Free Software Foundation.
> - */
> -
> -#include "qemu/osdep.h"
> -#include "hw/acpi/generic_event_device.h"
> -
> -static const TypeInfo acpi_ged_x86_info = {
> -    .name          = TYPE_ACPI_GED_X86,
> -    .parent        = TYPE_ACPI_GED,
> -    .interfaces = (InterfaceInfo[]) {
> -        { TYPE_HOTPLUG_HANDLER },
> -        { TYPE_ACPI_DEVICE_IF },
> -        { }
> -    }
> -};
> -
> -static void acpi_ged_x86_register_types(void)
> -{
> -    type_register_static(&acpi_ged_x86_info);
> -}
> -
> -type_init(acpi_ged_x86_register_types)
> diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
> index 8deeb62774..b9c93039e2 100644
> --- a/hw/i386/microvm.c
> +++ b/hw/i386/microvm.c
> @@ -204,7 +204,7 @@ static void microvm_devices_init(MicrovmMachineState *mms)
>   
>       /* Optional and legacy devices */
>       if (x86_machine_is_acpi_enabled(x86ms)) {
> -        DeviceState *dev = qdev_new(TYPE_ACPI_GED_X86);
> +        DeviceState *dev = qdev_new(TYPE_ACPI_GED);
>           qdev_prop_set_uint32(dev, "ged-event", ACPI_GED_PWR_DOWN_EVT);
>           sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, GED_MMIO_BASE);
>           /* sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, GED_MMIO_BASE_MEMHP); */
> diff --git a/hw/i386/meson.build b/hw/i386/meson.build
> index cfdbfdcbcb..ff879069c9 100644
> --- a/hw/i386/meson.build
> +++ b/hw/i386/meson.build
> @@ -20,7 +20,6 @@ i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
>                                   if_false: files('sgx-stub.c'))
>   
>   i386_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-common.c'))
> -i386_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_event_device_x86.c'))
>   i386_ss.add(when: 'CONFIG_PC', if_true: files(
>     'pc.c',
>     'pc_sysfw.c',
> 

