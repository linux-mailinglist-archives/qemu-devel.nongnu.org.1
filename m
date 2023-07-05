Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 265EB747FC3
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 10:35:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGxy2-0001vZ-AB; Wed, 05 Jul 2023 04:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qGxy1-0001vJ-2l; Wed, 05 Jul 2023 04:34:29 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qGxxz-0002eo-9p; Wed, 05 Jul 2023 04:34:28 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1b0419f758eso288839fac.1; 
 Wed, 05 Jul 2023 01:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688546065; x=1691138065;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YEXMWxr8qSlAK1tCQ2t0O3cbPVz3ic2msoLN6hmD690=;
 b=TW5FVy8HzpcHckBQeNbRCZ0WNjfTNK355gjnmYitx3QzKQM1wJzqg8DG1jjUQVn6Ob
 KN7rAPl1LKkEa6xp3ibF5fBP/JuUf/zzqXJh17REUf6x5MVJD1bRLAVWBIykuoC30Rfa
 ipbhN9aFhRjZV+zJoM9jQbM4MMHbWu0JHMYZqju6Pp65i25aTOJ/7MD355xqA215iEHm
 lOzeUciY749FRs0kceQjKHbhYg/+iQ8UxKAT8rYtsp2jSeXQS3uWNeXoytHrUYY5QQ92
 7UhRjAyfPf+oOnJCDsOdyw331XsoNZSAod9KLT9LP22IoJgUlQ6s/zvmP0Q5C3BHNLKe
 /8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688546065; x=1691138065;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YEXMWxr8qSlAK1tCQ2t0O3cbPVz3ic2msoLN6hmD690=;
 b=UYaNU7smEsQO5mbSO7b+V59cxppVppIOsm9NQKfzlJV9zkC04oM1d+l8StPPr73RtR
 omZwsyhoO+TL6jU6SKMUny+AjRqBvjEN/StTgcn1PxQ4Lz6J1VFp3lDn+CA9+vE5vve7
 asTq3wcnU0DCDEpRkynHxGBIz5vNdg7gDnJ4wOYJamhD/ioqDrzV8I2eC0i+j+BSPWcv
 NYNPgtWCa4xY00rdVk9zC5tcsywilO+/Xa+n/Cx+7y+mkAE6Bty3cEZseMUOwARdXbDI
 ihj5enZpWyF40GbjD2wvYgHkMbta/ePsjevpI5Vwnkg2i9REcSdJZK8kflIoYxqtzPJ7
 SBrw==
X-Gm-Message-State: ABy/qLa31J3uIhBU5p7uDirk2xK1ioAH547kXZe6ExpkyqArOcInz+yZ
 iXxQVM0yfXGAZGfrthPMyPU=
X-Google-Smtp-Source: APBJJlEfNMXcEWdFYeIgXWC9xGCCsB7dmnwmHNOORe9M7VE8kUpLlyXe4k6tGe7Lw11TEMj8P+YyeQ==
X-Received: by 2002:a05:6871:546:b0:1b3:da9d:2208 with SMTP id
 t6-20020a056871054600b001b3da9d2208mr776141oal.26.1688546065279; 
 Wed, 05 Jul 2023 01:34:25 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 d17-20020a056830045100b006b722e466cdsm3653372otc.31.2023.07.05.01.34.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 01:34:24 -0700 (PDT)
Message-ID: <924e1048-9d63-17c2-75aa-982ffeb0e1c0@gmail.com>
Date: Wed, 5 Jul 2023 05:34:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ppc/pegasos2: Add support for -initrd command line option
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20230704181920.27B58746335@zero.eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230704181920.27B58746335@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 7/4/23 15:19, BALATON Zoltan wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

And pushed to ppc-next after amending the commit msg.


Daniel

>   hw/ppc/pegasos2.c | 32 +++++++++++++++++++++++++++++++-
>   1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
> index af5489de26..9c9944188b 100644
> --- a/hw/ppc/pegasos2.c
> +++ b/hw/ppc/pegasos2.c
> @@ -44,6 +44,8 @@
>   #define PROM_ADDR     0xfff00000
>   #define PROM_SIZE     0x80000
>   
> +#define INITRD_MIN_ADDR 0x600000
> +
>   #define KVMPPC_HCALL_BASE    0xf000
>   #define KVMPPC_H_RTAS        (KVMPPC_HCALL_BASE + 0x0)
>   #define KVMPPC_H_VOF_CLIENT  (KVMPPC_HCALL_BASE + 0x5)
> @@ -80,6 +82,8 @@ struct Pegasos2MachineState {
>       uint64_t kernel_addr;
>       uint64_t kernel_entry;
>       uint64_t kernel_size;
> +    uint64_t initrd_addr;
> +    uint64_t initrd_size;
>   };
>   
>   static void *build_fdt(MachineState *machine, int *fdt_size);
> @@ -117,7 +121,8 @@ static void pegasos2_init(MachineState *machine)
>       I2CBus *i2c_bus;
>       const char *fwname = machine->firmware ?: PROM_FILENAME;
>       char *filename;
> -    int i, sz;
> +    int i;
> +    ssize_t sz;
>       uint8_t *spd_data;
>   
>       /* init CPU */
> @@ -213,6 +218,20 @@ static void pegasos2_init(MachineState *machine)
>           warn_report("Using Virtual OpenFirmware but no -kernel option.");
>       }
>   
> +    if (machine->initrd_filename) {
> +        pm->initrd_addr = pm->kernel_addr + pm->kernel_size + 64 * KiB;
> +        pm->initrd_addr = ROUND_UP(pm->initrd_addr, 4);
> +        pm->initrd_addr = MAX(pm->initrd_addr, INITRD_MIN_ADDR);
> +        sz = load_image_targphys(machine->initrd_filename, pm->initrd_addr,
> +                                 machine->ram_size - pm->initrd_addr);
> +        if (sz <= 0) {
> +            error_report("Could not load initrd '%s'",
> +                         machine->initrd_filename);
> +            exit(1);
> +        }
> +        pm->initrd_size = sz;
> +    }
> +
>       if (!pm->vof && machine->kernel_cmdline && machine->kernel_cmdline[0]) {
>           warn_report("Option -append may be ineffective with -bios.");
>       }
> @@ -335,6 +354,11 @@ static void pegasos2_machine_reset(MachineState *machine, ShutdownCause reason)
>           error_report("Memory for kernel is in use");
>           exit(1);
>       }
> +    if (pm->initrd_size &&
> +        vof_claim(pm->vof, pm->initrd_addr, pm->initrd_size, 0) == -1) {
> +        error_report("Memory for initrd is in use");
> +        exit(1);
> +    }
>       fdt = build_fdt(machine, &sz);
>       /* FIXME: VOF assumes entry is same as load address */
>       d[0] = cpu_to_be64(pm->kernel_entry);
> @@ -966,6 +990,12 @@ static void *build_fdt(MachineState *machine, int *fdt_size)
>       qemu_fdt_setprop_string(fdt, "/memory@0", "name", "memory");
>   
>       qemu_fdt_add_subnode(fdt, "/chosen");
> +    if (pm->initrd_addr && pm->initrd_size) {
> +        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
> +                              pm->initrd_addr + pm->initrd_size);
> +        qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-start",
> +                              pm->initrd_addr);
> +    }
>       qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
>                               machine->kernel_cmdline ?: "");
>       qemu_fdt_setprop_string(fdt, "/chosen", "name", "chosen");

