Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEE382535A
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 13:29:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLjII-0001db-AH; Fri, 05 Jan 2024 07:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rLjIG-0001cn-9n
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 07:27:20 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rLjIE-000611-8N
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 07:27:19 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6d9cdd0a5e6so959338b3a.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 04:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704457636; x=1705062436; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1fuRmMn2/OEzC2xcyqjGVvOZ+85ANPKX5Ih5OYJKAfU=;
 b=gm2qpv6Qy3Yzt7tCrTYzyr2rHmb28Sd13YGLvDYY5h/W0oOkbwuox5rzgNxqay8Qvj
 GFGlUBb6/f+5PnYUmJYabpfgRgtA8DZgfA/LqVV6Ho/WFjhPNPAvPRhvcz+DD7IJKxNt
 xrfMqkMf0OWSi29IX7kHnjbZq9SD97AarXxbo6WQ/HH4Udi25BRej7cepfuPOFRk09Tk
 PP6/jntAJTVeZxC2T/zLka1Ai6VQqwrFoipyrKpv2ucDoyGUfcxx4ZDyzi/XGxvZ3Jy2
 bHXEvXYjeYDuZPk1UnF+a5d4eOvgIOr7b87gmoQVh0AbNLGrpo6ZA1wCdkaaR+cFGKDb
 rBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704457636; x=1705062436;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1fuRmMn2/OEzC2xcyqjGVvOZ+85ANPKX5Ih5OYJKAfU=;
 b=sbMHRxK/hVLo3w/Bs+tpcWCYlRCEYUjefSfSsbrfdCFJyXqS+fo7jnfUHHUSgM8TAX
 zBgncZrQv1FAxiYt2It2YMpPqJK/ty2moh+FoBnA5rscaQ+ZwL9kGca5ygH2rbzkf7Mt
 3zu3cRsNNZKjI+IiK3QQxmB8Qm90H52ZKq15p6uSqzNQQWL24anU2y0dmHYpkvz577N/
 mRevq//4NJ9NtgkqD1iaOoyKO6QxRu+O7puwXDP7qsayNZEdwDYy6Oe7pSJ8Tjn3ZjAs
 OndvjaFdDfZE8jZ4nOE4Lf0P0JHw8drVe8XPYZxDN/ZOoq+sRM+Cnfq/ui2qq4nKkYsP
 PxOw==
X-Gm-Message-State: AOJu0YwV4erxxhm8vJOY6++Mut+KXbhHjcyJVfK/0lHxssmcd/IhR3Zv
 h8AGMoj6p+xlJK4osZBTP1mx3nBDQk9mbA==
X-Google-Smtp-Source: AGHT+IEe2y+wHcYvW86pk092usDYohPziIZef9eBxpMtlFhRcN6y2N1V38Lw1q3FTOe7/N28qUl8Hg==
X-Received: by 2002:a05:6a20:9150:b0:199:4546:bc0c with SMTP id
 x16-20020a056a20915000b001994546bc0cmr421451pzc.83.1704457636406; 
 Fri, 05 Jan 2024 04:27:16 -0800 (PST)
Received: from [192.168.68.110] ([152.234.127.254])
 by smtp.gmail.com with ESMTPSA id
 r5-20020a62e405000000b006da76842a66sm1292898pfh.85.2024.01.05.04.27.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jan 2024 04:27:15 -0800 (PST)
Message-ID: <e7ee041b-4e71-458c-8a56-f0b91a3ace0f@ventanamicro.com>
Date: Fri, 5 Jan 2024 09:27:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND RFC v1 2/2] hw/riscv/virt-acpi-build.c: Generate SPCR
 table
Content-Language: en-US
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 sunilvl@ventanamicro.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
References: <20240105090608.5745-1-jeeheng.sia@starfivetech.com>
 <20240105090608.5745-3-jeeheng.sia@starfivetech.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240105090608.5745-3-jeeheng.sia@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 1/5/24 06:06, Sia Jee Heng wrote:
> Generate Serial Port Console Redirection Table (SPCR) for RISC-V
> virtual machine.
> 
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> ---
>   hw/riscv/virt-acpi-build.c | 39 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 39 insertions(+)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index d4a02579d6..388b3d1a84 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -174,6 +174,42 @@ acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
>       aml_append(scope, dev);
>   }
>   
> +/*
> + * Serial Port Console Redirection Table (SPCR)
> + * Rev: 1.07

Shouldn't it be "Rev: 2.0"? The function is calling the common build_spcr() that
specifies

+    AcpiTable table = { .sig = "SPCR", .rev = 2, .oem_id = oem_id,
+                        .oem_table_id = oem_table_id };



Code LGTM regardless of the "Rev: " comment value.


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>





> + */
> +
> +static void
> +build_spcr_rev2(GArray *table_data, BIOSLinker *linker, RISCVVirtState *s)
> +{
> +    AcpiSpcrData serial = {
> +        .interface_type = 0,       /* 16550 compatible */
> +        .base_addr.id = AML_AS_SYSTEM_MEMORY,
> +        .base_addr.width = 32,
> +        .base_addr.offset = 0,
> +        .base_addr.size = 1,
> +        .base_addr.addr = s->memmap[VIRT_UART0].base,
> +        .interrupt_type = (1 << 4),/* Bit[4] RISC-V PLIC/APLIC */
> +        .pc_interrupt = 0,
> +        .interrupt = UART0_IRQ,
> +        .baud_rate = 7,            /* 15200 */
> +        .parity = 0,
> +        .stop_bits = 1,
> +        .flow_control = 0,
> +        .terminal_type = 3,        /* ANSI */
> +        .language = 0,             /* Language */
> +        .pci_device_id = 0xffff,   /* not a PCI device*/
> +        .pci_vendor_id = 0xffff,   /* not a PCI device*/
> +        .pci_bus = 0,
> +        .pci_device = 0,
> +        .pci_function = 0,
> +        .pci_flags = 0,
> +        .pci_segment = 0,
> +    };
> +
> +    build_spcr(table_data, linker, &serial, s->oem_id, s->oem_table_id);
> +}
> +
>   /* RHCT Node[N] starts at offset 56 */
>   #define RHCT_NODE_ARRAY_OFFSET 56
>   
> @@ -555,6 +591,9 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
>       acpi_add_table(table_offsets, tables_blob);
>       build_rhct(tables_blob, tables->linker, s);
>   
> +    acpi_add_table(table_offsets, tables_blob);
> +    build_spcr_rev2(tables_blob, tables->linker, s);
> +
>       acpi_add_table(table_offsets, tables_blob);
>       {
>           AcpiMcfgInfo mcfg = {

