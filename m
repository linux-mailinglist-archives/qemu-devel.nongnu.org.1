Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F2A7585F4
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 22:11:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLr1c-0005Jb-Ho; Tue, 18 Jul 2023 16:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLr1Y-0005If-N1
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 16:10:21 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLr1V-0006sk-5u
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 16:10:19 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3a40b756eb0so3366360b6e.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 13:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689711016; x=1692303016;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DE50H6X4FV7NQZoR57pqaDB50uyCPC5bpdkH+kGW9s4=;
 b=LAlR/LgyVOje2sRdnRGvOkmf7qH709iGj6QWBa8wRD4TkWn0BVX7DYeG7yQEqieHkS
 K+irauJxbVzbyWbkdYnj5ZFecD/lwXe4DZh2hV4S5xOX6ZKQPkxSsScysGPUYezOfAeG
 pQyXXBm9W5az4vbswL5Ey75suEuel4UBP5EZc0+D/D9hRfUn0OKzgK8UyoBNfhglRQCP
 Vmt044AR2o1U77kIgz+c3yICSN8a05W8POT8Df9mDrjkJDpy+/5JEjf7BoqGrZmMwUCN
 Oyhii8YVgkrUlvRjegnzpezaMeqQl+YTNegzC23NFH3UKGoh+UyTUMVV37h3gGArFCKp
 N9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689711016; x=1692303016;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DE50H6X4FV7NQZoR57pqaDB50uyCPC5bpdkH+kGW9s4=;
 b=KT9r6xrjnGEQyPCbdWId+1UjAJ8Wg5xJV66jlXpGVEsm1FOODx1rdL1k8AU298+QAQ
 8KACxrUAI1/+qyybM0USZAQpC5FL51sVGIvu03tclpLdzvEn+gVAeAQEsbK5TxuZS+cN
 PzKDIshAemnh5DtgRQhlcdtMUDazNHQWAOGz0bE2VEKIUMCLUGYCpYAtexWHGu45L1aO
 At21Gy8VTojHNn0upibrcn6HDI+AnBIPnD9ou/VpNb/XLoCeImrgytpi2yNEIUqJK/o0
 xWhkkmGiCoA8FY0RSlWMIibRX8olEN03gQNasWmCPA+JQkznMU8yjR1sT+Sauvd4omdr
 EKeA==
X-Gm-Message-State: ABy/qLYFlNX7u7fQYsqd/zb5oe9YSM7rNidowOqZ1ZfWfJwzFZIzTJXo
 a08YUN8aCR1oRvhuoaJAs68J1Q==
X-Google-Smtp-Source: APBJJlHPbCSR51tcnMNZC13WqQvK4B2JkpEprKLQ3F0t6SWbDPitfKzHlz7M5tnKok0YhA0oJBjcsw==
X-Received: by 2002:a05:6808:1146:b0:3a1:e59f:7582 with SMTP id
 u6-20020a056808114600b003a1e59f7582mr16538658oiu.49.1689711015821; 
 Tue, 18 Jul 2023 13:10:15 -0700 (PDT)
Received: from [192.168.68.108] (201-69-66-211.dial-up.telesp.net.br.
 [201.69.66.211]) by smtp.gmail.com with ESMTPSA id
 s2-20020a056808208200b003a1f359ba4esm1115976oiw.14.2023.07.18.13.10.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jul 2023 13:10:15 -0700 (PDT)
Message-ID: <9790a6a4-77a5-6120-ac83-76fcb9394705@ventanamicro.com>
Date: Tue, 18 Jul 2023 17:10:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 07/10] hw/riscv/virt-acpi-build.c: Add APLIC in the MADT
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
 <20230712163943.98994-8-sunilvl@ventanamicro.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230712163943.98994-8-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 7/12/23 13:39, Sunil V L wrote:
> Add APLIC structures for each socket in the MADT when
> system is configured with APLIC as the external wired
> interrupt controller.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/virt-acpi-build.c | 36 ++++++++++++++++++++++++++++++++++--
>   1 file changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index ebdc3bffea..9f2d0c92b0 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -276,9 +276,9 @@ static void build_madt(GArray *table_data,
>       MachineClass *mc = MACHINE_GET_CLASS(s);
>       MachineState *ms = MACHINE(s);
>       const CPUArchIdList *arch_ids = mc->possible_cpu_arch_ids(ms);
> -    uint64_t imsic_socket_addr, imsic_addr;
> +    uint64_t imsic_socket_addr, imsic_addr, aplic_addr;
> +    uint32_t imsic_size, gsi_base;
>       uint8_t  guest_index_bits;
> -    uint32_t imsic_size;
>       uint32_t local_cpu_id, socket_id;
>       uint8_t  hart_index_bits, group_index_bits, group_index_shift;
>       uint16_t imsic_max_hart_per_socket = 0;
> @@ -340,6 +340,38 @@ static void build_madt(GArray *table_data,
>           build_append_int_noprefix(table_data, group_index_shift, 1);
>       }
>   
> +    if (s->aia_type != VIRT_AIA_TYPE_NONE) {
> +        /* APLICs */
> +        for (socket = 0; socket < riscv_socket_count(ms); socket++) {
> +            aplic_addr = s->memmap[VIRT_APLIC_S].base +
> +                             s->memmap[VIRT_APLIC_S].size * socket;
> +            gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
> +            build_append_int_noprefix(table_data, 0x1A, 1);    /* Type */
> +            build_append_int_noprefix(table_data, 36, 1);      /* Length */
> +            build_append_int_noprefix(table_data, 1, 1);       /* Version */
> +            build_append_int_noprefix(table_data, socket, 1);  /* APLIC ID */
> +            build_append_int_noprefix(table_data, 0, 4);       /* Flags */
> +            build_append_int_noprefix(table_data, 0, 8);       /* Hardware ID */
> +            /* Number of IDCs */
> +            if (s->aia_type == VIRT_AIA_TYPE_APLIC) {
> +                build_append_int_noprefix(table_data,
> +                                          s->soc[socket].num_harts,
> +                                          2);
> +            } else {
> +                build_append_int_noprefix(table_data, 0, 2);
> +            }
> +            /* Total External Interrupt Sources Supported */
> +            build_append_int_noprefix(table_data, VIRT_IRQCHIP_NUM_SOURCES, 2);
> +            /* Global System Interrupt Base */
> +            build_append_int_noprefix(table_data, gsi_base, 4);
> +            /* APLIC Address */
> +            build_append_int_noprefix(table_data, aplic_addr, 8);
> +            /* APLIC size */
> +            build_append_int_noprefix(table_data,
> +                                      s->memmap[VIRT_APLIC_S].size, 4);
> +        }
> +    }
> +
>       acpi_table_end(linker, &table);
>   }
>   

