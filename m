Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A88D774634E
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 21:26:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGPB6-0008NQ-GG; Mon, 03 Jul 2023 15:25:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qGPAp-0008MQ-Hc
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 15:25:23 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qGPAm-0004SE-Vg
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 15:25:22 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6b73c2b6dcfso2846931a34.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 12:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688412319; x=1691004319;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IYA5dKb9ChGJ3CL8eVMgUL5o3Dyx8edws1TMqevH684=;
 b=bqd5s1hYT5kMwBcUn3Dfh3IPuowHd5kRagQPX8KCjVIoXXwYjlL6KVimSKc7YCtmaE
 Mw6KRePmLJwBBv5oeTBQZFkiW27Soy2KrJ6kta1S3hKcBwTsdd08urnX6XZ0B4Tn5SOz
 AmluYfO/fO77Adaa+8Ym+HbkCrY9sU9XYsCFp2hhYBzshsvVSS358FUB69I+0vKptri7
 7utkFbmBncAj+VPwePVskskzS6HPS/gdYy7SEFXMOMlq6BXnnsYy7/c/8ytFYk0cKGlL
 DQ0DI8oX+E8qJoB3irAk/h6lfauEGGBs0sLeZ+Pfjv4MRHKqZp07IDuBLkzC50STkFuh
 oWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688412319; x=1691004319;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IYA5dKb9ChGJ3CL8eVMgUL5o3Dyx8edws1TMqevH684=;
 b=USGlgv71KRO12ThbhW7m5VOJ3CwhtgumL2mD0fb1O08Ci0VtXxEKPcFmJbJNTusteQ
 V8y2m7BRpoqeOoCTBj5LoqWeKMVC2ZsDy6EJWn9ZLACOJL0Zy2GkJeF277jZhH0JvA93
 aya7c46NdwODRV12o36fmQAN6DApNdTl7LbV9jgtD2Qdw2CQhMm2xCtoYIMJLTDC+t+r
 SV5Br9Om3Pu4xFA+YnL2B7m3o2v+lDiiErpQCvg0Ofjw926npX8k49Fhr+KN4EXofyrj
 XI5LIeEUDrqdrm6cCJwK+MvoekII4R2VMYloky4U6iDwbYb9FtJECGJNeX+GedYVTiC2
 y6kg==
X-Gm-Message-State: AC+VfDwx35Erj1U1+i6zpIwV4meA/8y7jC0g2cYv0P6XOyro1Sgs23xD
 Fj/MexeS5hqKDwI5HDOXzShTOvQL4M3B1LYw2c0=
X-Google-Smtp-Source: ACHHUZ5QTXaz4N79elT8MxpMm8A/Z2Z9wVBBLKPciaA8UJb6N9oNS7a2MUGG7k4UTOwvCYwYWF7aEw==
X-Received: by 2002:a05:6830:1be9:b0:6b5:be09:5332 with SMTP id
 k9-20020a0568301be900b006b5be095332mr8981536otb.23.1688412319562; 
 Mon, 03 Jul 2023 12:25:19 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 l25-20020a9d7a99000000b006b71deb7809sm3091800otn.14.2023.07.03.12.25.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 12:25:19 -0700 (PDT)
Message-ID: <399a2293-85c2-c709-91ee-8eef1f59a5e4@ventanamicro.com>
Date: Mon, 3 Jul 2023 16:25:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] riscv: Generate devicetree only after machine
 initialization is complete
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>, Palmer Dabbelt <palmer@dabbelt.com>
Cc: Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Alistair Francis <alistair23@gmail.com>
References: <20230703034614.3909079-1-linux@roeck-us.net>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230703034614.3909079-1-linux@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 7/3/23 00:46, Guenter Roeck wrote:
> If the devicetree is created before machine initialization is complete,
> it misses dynamic devices. Specifically, the tpm device is not added
> to the devicetree file and is therefore not instantiated in Linux.
> Create devicetree in virt_machine_done() to solve the problem.
> 
> Cc: Alistair Francis <alistair23@gmail.com>
> Fixes: 325b7c4e75 hw/riscv: Enable TPM backends
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   hw/riscv/virt.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index ed4c27487e..08876284f5 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1248,6 +1248,11 @@ static void virt_machine_done(Notifier *notifier, void *data)
>       uint64_t kernel_entry = 0;
>       BlockBackend *pflash_blk0;
>   
> +    /* create devicetree if not provided */
> +    if (!machine->dtb) {
> +        create_fdt(s, memmap);
> +    }
> +

I suggest moving the entire load/create DT code from virt_machine_init() to
the start of virt_machine_done():

     /* load/create device tree */
     if (machine->dtb) {
         machine->fdt = load_device_tree(machine->dtb, &s->fdt_size);
         if (!machine->fdt) {
             error_report("load_device_tree() failed");
             exit(1);
         }
     } else {
         create_fdt(s, memmap);
     }

This way we don't have to look in to 2 different functions to wonder what happens
in case machine->dtb is NULL.


Thanks,


Daniel


>       /*
>        * Only direct boot kernel is currently supported for KVM VM,
>        * so the "-bios" parameter is not supported when KVM is enabled.
> @@ -1508,15 +1513,13 @@ static void virt_machine_init(MachineState *machine)
>       }
>       virt_flash_map(s, system_memory);
>   
> -    /* load/create device tree */
> +    /* load device tree */
>       if (machine->dtb) {
>           machine->fdt = load_device_tree(machine->dtb, &s->fdt_size);
>           if (!machine->fdt) {
>               error_report("load_device_tree() failed");
>               exit(1);
>           }
> -    } else {
> -        create_fdt(s, memmap);
>       }
>   
>       s->machine_done.notify = virt_machine_done;

