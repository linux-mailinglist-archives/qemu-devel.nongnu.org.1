Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 353387C729D
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:30:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqyWb-0002NU-1r; Thu, 12 Oct 2023 12:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcx4c70@gmail.com>) id 1qqyWQ-0002NI-Fj
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:26:50 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcx4c70@gmail.com>) id 1qqyWO-0001LR-B2
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:26:50 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-27d1aee5aa1so881541a91.0
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 09:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697128007; x=1697732807; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CZLAXdcwgIY7U0SCqJWbLdXsPH0YegYD5okGxfDIh5Y=;
 b=mjUKMACx+21cSBqMhdg3Htr4UJrFuSzETX/U7JPdT0NbPSrpsvC/ge0XPpw/IOfPWc
 A38wYUY4wZGUv3gveL/ttdcVOWgb2XwYJg4fpE1z7lgyAqf37Tl1tIzOnnamKXhnHpyX
 avXZBAxaebGxpGK5E/sAOFGqaOIRLOq9MvEG7ZLjUPaJZ6S8nbuTcoUBOO5U8sRxKZj0
 lqZ0yiSQbmNl/tYLeEUHaFlivSJp8vokW2R+K+DzLQsrjU2hKRz4z6VRPw+6qQgji43z
 wEL9y0R/Gsahb6ovBMZZ4atAS046/EBvSs3qzuUU/qojn55uGnt22c11cEt1QWRMiTRT
 uH/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697128007; x=1697732807;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CZLAXdcwgIY7U0SCqJWbLdXsPH0YegYD5okGxfDIh5Y=;
 b=SmKlfhINiJq5ry69Ba3LGJoSXu4F1D/spgfs8WJwmQ1hiMtMBfSupr/tXpHxDNk/4h
 nj20qBp4D/MnlEK+OZsWCB00DPGZ3akTHV9aim0LNksG5sm3Tq1rwkWwWWG2qG8ZKRmc
 vAPzn6Ov8Mogui72mmz3VGVgzg3qW+dFroeQxrM1ykds1pJssYYdblFMCMc2l3FT2MWm
 5jPSGjVdOd7g7TEYhG7TZ7TvxUqguag0Oi1dGokR7YAl9EN2HiaTZamcJfI7kgR7UEQ5
 MfDXPZlUCAvUKX4bbe2f69QfkGfu8CZoLT4mU3HenbnFlVoWnRoer3rslMNAbqoeyC64
 Sf9A==
X-Gm-Message-State: AOJu0Yw5GVN3wrHttI9bDzd/ydxI7G5ZhKaLvYQfJww7yeFI/fMYcQXI
 N3Ejl+MoJJJwKgAfQNfoEOw=
X-Google-Smtp-Source: AGHT+IHJNEf0N7YjY2nVGIKjkkPGX5oaz2OQkEwwbnts1UOoXmZyYFcvnp+N2823OLygvronI+yCLA==
X-Received: by 2002:a17:90a:c20d:b0:268:2af6:e48c with SMTP id
 e13-20020a17090ac20d00b002682af6e48cmr34932245pjt.4.1697128006587; 
 Thu, 12 Oct 2023 09:26:46 -0700 (PDT)
Received: from [192.168.2.146] ([2a01:111:f100:6000::4134:a26f])
 by smtp.gmail.com with ESMTPSA id
 5-20020a17090a198500b0027768125e24sm2202207pji.39.2023.10.12.09.26.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 09:26:46 -0700 (PDT)
Message-ID: <af961171-6582-4d1e-b3bc-35d979849ff6@gmail.com>
Date: Fri, 13 Oct 2023 00:26:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QOM crash via soundhw_init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Martin Kletzander <mkletzan@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
References: <bbd3c42b-5069-d5e8-0b97-70ff5135801c@linaro.org>
Content-Language: en-US
From: Peng Liang <tcx4c70@gmail.com>
In-Reply-To: <bbd3c42b-5069-d5e8-0b97-70ff5135801c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=tcx4c70@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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



On 10/12/2023 18:53, Philippe Mathieu-Daudé wrote:
> Hi Martin, Paolo, Markus, Marc-André,
> 
> With the following changes:
> 
> -- >8 --
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 137276bcb9..291495f798 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -245,6 +245,7 @@ static void ibm_40p_init(MachineState *machine)
>      uint32_t kernel_base = 0, initrd_base = 0;
>      long kernel_size = 0, initrd_size = 0;
>      char boot_device;
> +    MemoryRegion rom;
> 
>      if (kvm_enabled()) {
>          error_report("machine %s does not support the KVM accelerator",
> @@ -277,6 +278,9 @@ static void ibm_40p_init(MachineState *machine)
>          exit(1);
>      }
> 
> +    memory_region_init_rom_nomigrate(&rom, OBJECT(machine), "test",
> +                                     4 * KiB, &error_fatal);
> +
>      /* PCI -> ISA bridge */
>      i82378_dev = DEVICE(pci_new(PCI_DEVFN(11, 0), "i82378"));
>      qdev_connect_gpio_out(i82378_dev, 0,
> 
> ---

I think it can be fixed by changing the type of rom to MemoryRegion*, such as:
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 137276bcb9..b5c2345ec8 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -245,6 +245,7 @@ static void ibm_40p_init(MachineState *machine)
     uint32_t kernel_base = 0, initrd_base = 0;
     long kernel_size = 0, initrd_size = 0;
     char boot_device;
+    MemoryRegion *rom = g_new0(MemoryRegion, 1);

     if (kvm_enabled()) {
         error_report("machine %s does not support the KVM accelerator",
@@ -277,6 +278,9 @@ static void ibm_40p_init(MachineState *machine)
         exit(1);
     }

+    memory_region_init_rom_nomigrate(rom, OBJECT(machine), "test", 4 * KiB,
+                                     &error_fatal);
+
     /* PCI -> ISA bridge */
     i82378_dev = DEVICE(pci_new(PCI_DEVFN(11, 0), "i82378"));
     qdev_connect_gpio_out(i82378_dev, 0,
---

In the original patch, rom is an object on stack and machine will save a reference
to rom in its properties after memory_region_init_rom_nomigrate. When the function
returns, the stack frame is freed and the data in rom becomes to garbage. After that,
when we call object_resolve_path_type, the properties of machine will be used to
match the specific path and type, then we will use some garbage in rom (which is on
stack).

Thanks,
Peng

> 
> I'm getting:
> 
> $ ./qemu-system-ppc -M 40p -S -nodefaults
> ==3518191==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> qom/object.c:935:13: runtime error: member access within null pointer of type 'struct TypeImpl'
> AddressSanitizer:DEADLYSIGNAL
> =================================================================
> ==3518191==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000000 (pc 0x55f728f5e179 bp 0x7ffd91999220 sp 0x7ffd919991d0 T0)
> ==3518191==The signal is caused by a READ memory access.
> ==3518191==Hint: address points to the zero page.
>     #0 0x55f728f5e179 in object_class_dynamic_cast qom/object.c:935
>     #1 0x55f728f5d9f4 in object_dynamic_cast qom/object.c:876
>     #2 0x55f728f6605a in object_resolve_abs_path qom/object.c:2096
>     #3 0x55f728f662f1 in object_resolve_partial_path qom/object.c:2120
>     #4 0x55f728f6648a in object_resolve_partial_path qom/object.c:2130
>     #5 0x55f728f6648a in object_resolve_partial_path qom/object.c:2130
>     #6 0x55f728f668b7 in object_resolve_path_type qom/object.c:2159
>     #7 0x55f727ab14c8 in soundhw_init hw/audio/soundhw.c:112
>     #8 0x55f72858f27e in qemu_create_cli_devices system/vl.c:2604
>     #9 0x55f72858f8c7 in qmp_x_exit_preconfig system/vl.c:2685
>     #10 0x55f7285955cd in qemu_init system/vl.c:3734
>     #11 0x55f72790620a in main system/main.c:47
>     #12 0x7fd5fec57d8f in __libc_start_call_main
>     #13 0x7fd5fec57e3f in __libc_start_main_impl libc-start.c:392
>     #14 0x55f727906104 in _start (build_asan/qemu-system-ppc+0x2ca4104)
> 
> AddressSanitizer can not provide additional info.
> SUMMARY: AddressSanitizer: SEGV qom/object.c:935 in object_class_dynamic_cast
> ==3518191==ABORTING
> 
> O_o
> 
> Any idea what I'm missing?
> 
> Unified diff running with '-trace obj\* ':
> 
> @@ -1,4 +1,4 @@
> -==3534948==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
> +==3533425==WARNING: ASan doesn't fully support makecontext/swapcontext functions and may produce false positives in some cases!
>  object_class_dynamic_cast_assert authz-pam->user-creatable (include/qom/object_interfaces.h:11:USER_CREATABLE_CLASS)
>  object_class_dynamic_cast_assert authz-pam->authz (include/authz/base.h:30:QAUTHZ_CLASS)
>  object_class_dynamic_cast_assert device->device (include/hw/qdev-core.h:77:DEVICE_CLASS)
> @@ -2481,6 +2481,7 @@
>  object_class_dynamic_cast_assert PCI->bus (include/hw/qdev-core.h:315:BUS_GET_CLASS)
>  object_dynamic_cast_assert PCI->PCI (include/hw/pci/pci.h:270:PCI_BUS)
>  object_dynamic_cast_assert PCI->PCI (include/hw/pci/pci.h:270:PCI_BUS)
> +object_dynamic_cast_assert memory-region->memory-region (include/exec/memory.h:37:MEMORY_REGION)
>  object_dynamic_cast_assert i82378->device (include/hw/qdev-core.h:77:DEVICE)
>  object_dynamic_cast_assert i82378->device (include/hw/qdev-core.h:77:DEVICE)
>  object_dynamic_cast_assert i82378->device (include/hw/qdev-core.h:77:DEVICE)
> @@ -3014,355 +3015,28 @@
>  object_dynamic_cast_assert memory-region->memory-region (include/exec/memory.h:37:MEMORY_REGION)
>  object_dynamic_cast_assert memory-region->memory-region (include/exec/memory.h:37:MEMORY_REGION)
>  object_dynamic_cast_assert memory-region->memory-region (include/exec/memory.h:37:MEMORY_REGION)
> -object_dynamic_cast_assert fw_cfg_mem->fw_cfg (include/hw/nvram/fw_cfg.h:15:FW_CFG)
> -object_dynamic_cast_assert 40p-machine->machine (include/hw/boards.h:23:MACHINE)
> -object_dynamic_cast_assert (null)->device (include/hw/qdev-core.h:77:DEVICE)
> -object_dynamic_cast_assert (null)->device (include/hw/qdev-core.h:77:DEVICE)
> -object_dynamic_cast_assert or-irq->device (include/hw/qdev-core.h:77:DEVICE)
> -object_class_dynamic_cast_assert or-irq->device (include/hw/qdev-core.h:77:DEVICE_GET_CLASS)
> -object_dynamic_cast_assert (null)->device (include/hw/qdev-core.h:77:DEVICE)
> -object_dynamic_cast_assert (null)->device (include/hw/qdev-core.h:77:DEVICE)
> -object_dynamic_cast_assert (null)->device (include/hw/qdev-core.h:77:DEVICE)
> -object_dynamic_cast_assert (null)->device (include/hw/qdev-core.h:77:DEVICE)
> -object_dynamic_cast_assert mc146818rtc->device (include/hw/qdev-core.h:77:DEVICE)
> -object_class_dynamic_cast_assert mc146818rtc->device (include/hw/qdev-core.h:77:DEVICE_GET_CLASS)
> -object_dynamic_cast_assert (null)->device (include/hw/qdev-core.h:77:DEVICE)
> -object_dynamic_cast_assert (null)->device (include/hw/qdev-core.h:77:DEVICE)
> -object_dynamic_cast_assert isa-i8259->device (include/hw/qdev-core.h:77:DEVICE)
> -object_class_dynamic_cast_assert isa-i8259->device (include/hw/qdev-core.h:77:DEVICE_GET_CLASS)
> -object_dynamic_cast_assert (null)->device (include/hw/qdev-core.h:77:DEVICE)
> -object_dynamic_cast_assert (null)->device (include/hw/qdev-core.h:77:DEVICE)
> -object_dynamic_cast_assert (null)->device (include/hw/qdev-core.h:77:DEVICE)
> -object_dynamic_cast_assert (null)->device (include/hw/qdev-core.h:77:DEVICE)
> -object_dynamic_cast_assert (null)->device (include/hw/qdev-core.h:77:DEVICE)
> -object_dynamic_cast_assert (null)->device (include/hw/qdev-core.h:77:DEVICE)
> -object_dynamic_cast_assert (null)->device (include/hw/qdev-core.h:77:DEVICE)
> -object_dynamic_cast_assert (null)->device (include/hw/qdev-core.h:77:DEVICE)
> -object_dynamic_cast_assert (null)->device (include/hw/qdev-core.h:77:DEVICE)
> -object_dynamic_cast_assert (null)->device (include/hw/qdev-core.h:77:DEVICE)
> -object_dynamic_cast_assert rs6000-mc->device (include/hw/qdev-core.h:77:DEVICE)
> -object_class_dynamic_cast_assert rs6000-mc->device (include/hw/qdev-core.h:77:DEVICE_GET_CLASS)
> [...]
> 
> Thanks,
> 
> Phil.
> 

