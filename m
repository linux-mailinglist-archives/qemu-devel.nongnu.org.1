Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EC57511C8
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 22:20:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJgId-0000d7-Ku; Wed, 12 Jul 2023 16:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qJgIY-0000cY-6E
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 16:18:54 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qJgIV-0004Ak-Uk
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 16:18:53 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3a426e70575so610088b6e.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 13:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689193130; x=1691785130;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pCdyffSB1FqsQckbymkIKQDwVd/IodO3mw5qNKITyEA=;
 b=SvqTgI3OgPwXQsxQpvLWKVnEZZP74I4QbfN7BpiXG0zJTpr+6GldvS9lRKv7eUMwer
 dM+gykCI3Iqf/JTGXvMAZ7H4Inv4T6SAaka0iFg6T9y1yVprTe3n0HErOR/ccQ12IZV4
 IqpSvEId4uKHdjodO/q9xREMQUyT5ZJxYyPfCk3T1OUqHVSzWDRLQElqAgwMg2WI+bWk
 AN0Ae6vps04W4SGtMJ0OqRqY2MyToZSKrweC+mtMHMqkkRjMYUB5LMtALkX5OU54mFvR
 ujIvs5LC3dzCKGis3sVDZxmd/sfV9blAKvUB8+amXdoYLtevo+wlKZkwgGKApb+UkLc5
 dv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689193130; x=1691785130;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pCdyffSB1FqsQckbymkIKQDwVd/IodO3mw5qNKITyEA=;
 b=XZ1unM5JxDBgFS6cLibmsHNpQv4AulT3aYYPQ1d+b4HlgCH2/fXn0ncfPt/hbqLF9v
 cWHWEWHFWlwu1eJPg9oqX/0R1292G5nP92l/revojNX+NJ6XKJsB1IsaII8FRXlVqMRb
 pEjXRYZs6jqBuHmMYtiAqPIu7IgSodkmprTbRbkP+niESiL/dMpRq/Hv1DPCtTrHk9JJ
 MOnIsmyrJ6gnJmQ02jXqKyNxcYTtQqXhRrM2csg2ebpP4I7l1RxmIy8onarKxByVb+0m
 HGrR3gcc2+CZAYegbVEtxN5CMXGL+GO1HdJn5hkhWMsiOp9QWuMp30FkkXxnfvpCfHtS
 gwQQ==
X-Gm-Message-State: ABy/qLZLiM2Co2IyDC9p3Ic2ATAJgJjkBQ6MpoCQAiL5kIPyB0hQpUFf
 5T8yMEMuKPjWvjRJtA5ROCAdlw==
X-Google-Smtp-Source: APBJJlFn3ENqy+QsxyqPzio0yWpdkvQ9YWTIFN+NvcbsQfP7SFM+X1i86DM5KqUYE2Md+hmAuGQ1Pg==
X-Received: by 2002:a54:4618:0:b0:3a3:9ae0:efe1 with SMTP id
 p24-20020a544618000000b003a39ae0efe1mr13570297oip.6.1689193130656; 
 Wed, 12 Jul 2023 13:18:50 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-19.dial-up.telesp.net.br.
 [201.69.66.19]) by smtp.gmail.com with ESMTPSA id
 d5-20020a05680813c500b003a409a977c0sm2293519oiw.4.2023.07.12.13.18.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jul 2023 13:18:50 -0700 (PDT)
Message-ID: <d7376261-7af8-aa42-8eb3-6af3f58f32a8@ventanamicro.com>
Date: Wed, 12 Jul 2023 17:18:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 02/10] hw/riscv: virt: Add PCI bus reference in
 RISCVVirtState
Content-Language: en-US
To: Sunil V L <sunilvl@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>, Anup Patel <apatel@ventanamicro.com>
References: <20230712163943.98994-1-sunilvl@ventanamicro.com>
 <20230712163943.98994-3-sunilvl@ventanamicro.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230712163943.98994-3-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x233.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.11,
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



On 7/12/23 13:39, Sunil V L wrote:
> The PCI bus information is needed in RISCVVirtState so that other
> files like virt-acpi-build.c can make use of it. Add new field in
> RISCVVirtState so that ACPI code can use it.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>   hw/riscv/virt.c         | 6 ++++--
>   include/hw/riscv/virt.h | 1 +
>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index d90286dc46..46d3341113 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1073,7 +1073,8 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
>                                             hwaddr high_mmio_base,
>                                             hwaddr high_mmio_size,
>                                             hwaddr pio_base,
> -                                          DeviceState *irqchip)
> +                                          DeviceState *irqchip,
> +                                          RISCVVirtState *s)
>   {
>       DeviceState *dev;
>       MemoryRegion *ecam_alias, *ecam_reg;
> @@ -1113,6 +1114,7 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
>           gpex_set_irq_num(GPEX_HOST(dev), i, PCIE_IRQ + i);
>       }
>   
> +    s->bus = PCI_HOST_BRIDGE(dev)->bus;
>       return dev;
>   }
>   
> @@ -1502,7 +1504,7 @@ static void virt_machine_init(MachineState *machine)
>                      virt_high_pcie_memmap.base,
>                      virt_high_pcie_memmap.size,
>                      memmap[VIRT_PCIE_PIO].base,
> -                   pcie_irqchip);
> +                   pcie_irqchip, s);

I wonder whether we could use 's' inside gpex_pcie_init() to avoid passing all
this memmap stuff to the function. It seems that most, if not all these values,
can be derived from s->memmap[]. A work for another day perhaps.


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


>   
>       create_platform_bus(s, mmio_irqchip);
>   
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index e5c474b26e..4ef1f660ab 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -60,6 +60,7 @@ struct RISCVVirtState {
>       char *oem_table_id;
>       OnOffAuto acpi;
>       const MemMapEntry *memmap;
> +    PCIBus *bus;
>   };
>   
>   enum {

