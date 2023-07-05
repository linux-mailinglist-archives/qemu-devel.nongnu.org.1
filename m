Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6257574810A
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 11:36:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGyvA-0004sZ-0O; Wed, 05 Jul 2023 05:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qGyv8-0004sB-6t
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 05:35:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qGyv2-0007mj-PE
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 05:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688549719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Th5fG/H9t5bN8I2yLD1cy8wBgoU+0ObCdD+AS/ezWCU=;
 b=MYxtJaMbBF4LM4CpDupe68Caq0sovzBTCVxwjsGhkh/8+kh9a7OVZLhL2y/QcgfNH+bInr
 HEoCoEHVPVMRTrej29Sga9hY9BebYoL1dFCl1OwJoNdJER/6cK9xUitWfZSxAbSRnTe6He
 HKLVFjcjl8xxNHBZ4/geVMjh/msTJLM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-nVpmrONlOni3i_ZV3HJpZg-1; Wed, 05 Jul 2023 05:35:18 -0400
X-MC-Unique: nVpmrONlOni3i_ZV3HJpZg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-634dacfa27bso64848536d6.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 02:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688549717; x=1691141717;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Th5fG/H9t5bN8I2yLD1cy8wBgoU+0ObCdD+AS/ezWCU=;
 b=l8nzBRJJnWAoxizi1Dv5Fy0gYsdsE48W7Br9/gZEhaTTnelVAwQQPGE3ARc7nVmxSV
 1qNNZZCG7f+TorQdKvM/qsZZpTXIX6xzrdAluVHVI//k32p/ncq6fENEFZQ9mmhJ2hgU
 VeAD0LdaDpr6NTR6t9Qw4shZFDWVvo2+JKw76VsIPeneRGOEpeGdp8jMfTQn65DbXjxd
 DXxlMksmAoo1fs/xwfJDlLuQbaObiwy0BL+x3SZEM7NhhNcRDpP3yeLYIUzvHQ6h7m8L
 g7uj5Sb+LNta+zzNAFINsujTT0DoU8LqmjZaCMSexVB27OZGFCTejUvetGOeZFJy/Sn9
 uVRQ==
X-Gm-Message-State: ABy/qLZ635GfyDQbibKE/q6RwM9CCVtBhQh+7Rn/tVe6acxw57sg202o
 qqI/OPTQ8CZNKWecG8CDKbQT95KHfZMQcnMRrkERNFfO+OayD8SymhfQP+nz4DQrK9+lo3WtrKY
 9sjnC9Hwrm4Fk0U4=
X-Received: by 2002:a05:6214:258b:b0:625:7c0b:4640 with SMTP id
 fq11-20020a056214258b00b006257c0b4640mr22941093qvb.22.1688549717717; 
 Wed, 05 Jul 2023 02:35:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFAOyMUeqmwwznlf21/3Y+lcm2+Yj/Orw3O6AL/yDNJUCqE23I9opbxyAtcjmFlly5h2Svq4Q==
X-Received: by 2002:a05:6214:258b:b0:625:7c0b:4640 with SMTP id
 fq11-20020a056214258b00b006257c0b4640mr22941081qvb.22.1688549717487; 
 Wed, 05 Jul 2023 02:35:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 q11-20020ad4402b000000b00631ecb1052esm13458836qvp.74.2023.07.05.02.35.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 02:35:17 -0700 (PDT)
Message-ID: <a789088f-c3ca-9f61-66d3-3bddfc0510fa@redhat.com>
Date: Wed, 5 Jul 2023 11:35:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ppc/pegasos2: Add support for -initrd command line option
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20230704181920.27B58746335@zero.eik.bme.hu>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20230704181920.27B58746335@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hello,

On 7/4/23 20:19, BALATON Zoltan wrote:
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
The patch is not a oneliner, it deserves a minimal commit log.

Thanks,

C.

> ---
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


