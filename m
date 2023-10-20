Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B517D0F1E
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 13:50:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qto13-0001i1-IK; Fri, 20 Oct 2023 07:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qto0R-0001Wb-AZ
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 07:49:32 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qto0P-0006hc-IZ
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 07:49:31 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6ce2ee17cb5so432205a34.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 04:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697802567; x=1698407367; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pj5vVO1o9ClGbMGR1eaFqeit54Yl97Rne7g8J9WfOVA=;
 b=DYsMOMJkleSJHH2pifbL0zgHZKGu7M8WyrYziEB1pHc93e7M9OqhJkruE9XDsw6R/0
 yj0TwsuyGvqmFDdDacHjaNdCL/tWwxELDIvL35fbmQHa0a4Q+FN9gojRdxGxzcnH7OJS
 8f/DG5f4VY/3SjljBBHf1dSBDmkLtpAY7NRx+ZfwO2dqp1qozOW2yXtN4UWZX1D+fUTk
 bBLrlMyC4xeCXbc8pOhsgI0on03lLrIDwNEzn/o+c4webWGEwaBRIIK0564/7cBkMDpn
 jhNGvLHC2X4ZPah5NiRMZl4jyeApnQ08PtR85bTp80ZS6dOlzYpR7DwrXCYgE9agvE41
 KD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697802567; x=1698407367;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pj5vVO1o9ClGbMGR1eaFqeit54Yl97Rne7g8J9WfOVA=;
 b=fq/WxuazB6uBDPblfPk/UTRuP+brh9uW5C9Y6VXAgxIpOmFuJ8bZuaZ4WYVmgHKe8N
 GfCtoo9K/DYVLHEZCC6CDEq7VauoePPO7NdIRz8/p8CrkfsqhuuZrTqAA9wiCZD2K2Kf
 CBKTeyORVVoTv8Hz7ApN4XrFk65vB+aKN4I8azRUXUGFPHgL59I476NM8ODJ+0tLOCFW
 3AXD92fXOaHQq5J4r4rPMC13K7YWhPXhJDaHbhP3e8PlAKpX+Gvr5+/jJS3VDUM0KdfM
 XFYsHuqZ5ml1FqqIINaEXNMpB+p1JrcUjp5sj++tE91zEkfMw5iGnNirQriY1uItkDZA
 CusQ==
X-Gm-Message-State: AOJu0Yzds6eeL79BcwmdEWYa7DtsPhrfUa/ij9Dc0os3/dRqj6CMGTFq
 29t+hH7IDCdKYg55ixi3yqrbFg==
X-Google-Smtp-Source: AGHT+IH0w1uo0gRCkOtbKeu6qbAJa1MOK+EjUbAcG6/IGDO/5DL//6qTW9FyC2DX4iGFWIlkXJut1w==
X-Received: by 2002:a05:6830:440b:b0:6bd:9fa:34ff with SMTP id
 q11-20020a056830440b00b006bd09fa34ffmr1616905otv.9.1697802567672; 
 Fri, 20 Oct 2023 04:49:27 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bdcd:fb00:6501:2693:db52:c621?
 ([2804:7f0:bdcd:fb00:6501:2693:db52:c621])
 by smtp.gmail.com with ESMTPSA id
 22-20020a631256000000b00528db73ed70sm1288984pgs.3.2023.10.20.04.49.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Oct 2023 04:49:27 -0700 (PDT)
Message-ID: <bdaa5804-eff0-4d5e-ba61-c277aa3195cd@ventanamicro.com>
Date: Fri, 20 Oct 2023 08:49:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/12] hw/riscv/virt-acpi-build.c: Add PLIC in MADT
Content-Language: en-US
To: Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Anup Patel <apatel@ventanamicro.com>, Andrew Jones
 <ajones@ventanamicro.com>, Atish Kumar Patra <atishp@rivosinc.com>,
 Haibo Xu <haibo1.xu@intel.com>
References: <20231019132648.23703-1-sunilvl@ventanamicro.com>
 <20231019132648.23703-13-sunilvl@ventanamicro.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231019132648.23703-13-sunilvl@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 10/19/23 10:26, Sunil V L wrote:
> Add PLIC structures for each socket in the MADT when system is configured
> with PLIC as the external interrupt controller.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


>   hw/riscv/virt-acpi-build.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 2f1cc92f75..d1761ddddf 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -85,6 +85,12 @@ static void riscv_acpi_madt_add_rintc(uint32_t uid,
>                                         arch_ids->cpus[uid].props.node_id,
>                                         local_cpu_id),
>                                     4);
> +    } else if (aia_type == VIRT_AIA_TYPE_NONE) {
> +        build_append_int_noprefix(entry,
> +                                  ACPI_BUILD_INTC_ID(
> +                                      arch_ids->cpus[uid].props.node_id,
> +                                      2 * local_cpu_id + 1),
> +                                  4);
>       } else {
>           build_append_int_noprefix(entry, 0, 4);
>       }
> @@ -513,6 +519,29 @@ static void build_madt(GArray *table_data,
>               build_append_int_noprefix(table_data,
>                                         s->memmap[VIRT_APLIC_S].size, 4);
>           }
> +    } else {
> +        /* PLICs */
> +        for (socket = 0; socket < riscv_socket_count(ms); socket++) {
> +            aplic_addr = s->memmap[VIRT_PLIC].base +
> +                         s->memmap[VIRT_PLIC].size * socket;
> +            gsi_base = VIRT_IRQCHIP_NUM_SOURCES * socket;
> +            build_append_int_noprefix(table_data, 0x1B, 1);   /* Type */
> +            build_append_int_noprefix(table_data, 36, 1);     /* Length */
> +            build_append_int_noprefix(table_data, 1, 1);      /* Version */
> +            build_append_int_noprefix(table_data, socket, 1); /* PLIC ID */
> +            build_append_int_noprefix(table_data, 0, 8);      /* Hardware ID */
> +            /* Total External Interrupt Sources Supported */
> +            build_append_int_noprefix(table_data,
> +                                      VIRT_IRQCHIP_NUM_SOURCES - 1, 2);
> +            build_append_int_noprefix(table_data, 0, 2);     /* Max priority */
> +            build_append_int_noprefix(table_data, 0, 4);     /* Flags */
> +            /* PLIC Size */
> +            build_append_int_noprefix(table_data, s->memmap[VIRT_PLIC].size, 4);
> +            /* PLIC Address */
> +            build_append_int_noprefix(table_data, aplic_addr, 8);
> +            /* Global System Interrupt Vector Base */
> +            build_append_int_noprefix(table_data, gsi_base, 4);
> +        }
>       }
>   
>       acpi_table_end(linker, &table);

