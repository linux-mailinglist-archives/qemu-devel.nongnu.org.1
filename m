Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D95817C93
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 22:22:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFL2h-0006Ii-3a; Mon, 18 Dec 2023 16:20:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFL2b-0006IT-8d
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 16:20:45 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rFL2E-0007qV-St
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 16:20:27 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d3ab37d0d1so9100315ad.0
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 13:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1702934421; x=1703539221; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fUnhxCRV7sx9qlEgP71rK1sLH+4Vx787zjLEWm5mnaw=;
 b=Ad6qzoT7yQ3FGjYa+f39VkUbeLP3keEF0y50CX+Y7GmlmZLf/1bQCJCvY4uTgdAro0
 20gQELWFpdsc0QlUYGeDuMLwngqO2xY4NK2Mb5DVWhjCWxZfyUfxY6b78g18XuDPlAx5
 VGiusbe5lAiexyK9kkM6y9GCkvZg/d4qUrhrYX15I4ZsCl7UNJ9PDU76TfYf0VIJJhHt
 LXRAlqOl7nglVnmiTnCmQvPJIrJlpJ7SvgS60PbY5BtZQg/arI1I2WN0Uvr8S2ApQmfW
 gdEe8f5BtcpnXi83DGpz2cC0CwU8Ns1CG0bupcRty/cGNXGjTSW4ELJGspP5smKJOpDy
 qrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702934421; x=1703539221;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fUnhxCRV7sx9qlEgP71rK1sLH+4Vx787zjLEWm5mnaw=;
 b=XFQwBoKm3Ru7g0K1gBI37/HxTCJLFCkWoCIJCB9as5eyNQyNCpvZq5LSdVeqzSn+2b
 foClmjQaPkMhsYYHIYC62+FeQThPRh/UZsF/oDwftce3y9DvDLNl6/CHrLGrA2Me/dG3
 fLdPF76RzeprTRu5MjM47kOsFPjK+UhFnytbkXyq0119aBNhxIsbyHpl0FUc+wop6LKd
 PMK3U4y+Nqxg3xE7CBgkjz/CEjg749z4X4pEIU2rwloInsPjUCLD5ZNNIDUFe4ffhLAH
 V1G0opdrIUHy06WY7SKioxzXmuWeZAikhwlijp0kClIoU/dghIJjYyBuLtp5jbHUFjpE
 D/QQ==
X-Gm-Message-State: AOJu0YzedYJ8K30V9zWdXRtFk3yVsY43Kc5wdQt4Xp9KmGLOlcPqZ+vG
 EEBY5prxWR6JA/AJAQerLMUmfQ==
X-Google-Smtp-Source: AGHT+IEKPRyVtmpXqFW7MQUNBy2d+fduS4rMd2zbe79sS9SEjsMOWtqQal/Tscszu1t3+TS3JH9CJQ==
X-Received: by 2002:a17:903:120c:b0:1d3:581e:9cc9 with SMTP id
 l12-20020a170903120c00b001d3581e9cc9mr5540158plh.88.1702934420909; 
 Mon, 18 Dec 2023 13:20:20 -0800 (PST)
Received: from [192.168.68.110] ([179.93.21.205])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a170902b70400b001cfb971edfasm19484479pls.205.2023.12.18.13.20.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Dec 2023 13:20:20 -0800 (PST)
Message-ID: <6e28881d-a0d7-406e-b477-8740a80d3461@ventanamicro.com>
Date: Mon, 18 Dec 2023 18:20:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hw/riscv/virt.c: fix the interrupts-extended property
 format of PLIC
Content-Language: en-US
To: Yong-Xuan Wang <yongxuan.wang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, frank.chang@sifive.com, 
 jim.shu@sifive.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20231218090543.22353-1-yongxuan.wang@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231218090543.22353-1-yongxuan.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 12/18/23 06:05, Yong-Xuan Wang wrote:
> The interrupts-extended property of PLIC only has 2 * hart number
> fields when KVM enabled, copy 4 * hart number fields to fdt will
> expose some uninitialized value.
> 
> In this patch, I also refactor the code about the setting of
> interrupts-extended property of PLIC for improved readability.
> 
> Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   hw/riscv/virt.c | 47 +++++++++++++++++++++++++++--------------------
>   1 file changed, 27 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index d2eac2415619..e42baf82cab6 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -460,24 +460,6 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
>           "sifive,plic-1.0.0", "riscv,plic0"
>       };
>   
> -    if (kvm_enabled()) {
> -        plic_cells = g_new0(uint32_t, s->soc[socket].num_harts * 2);
> -    } else {
> -        plic_cells = g_new0(uint32_t, s->soc[socket].num_harts * 4);
> -    }
> -
> -    for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
> -        if (kvm_enabled()) {
> -            plic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
> -            plic_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_S_EXT);
> -        } else {
> -            plic_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
> -            plic_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_EXT);
> -            plic_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandles[cpu]);
> -            plic_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_S_EXT);
> -        }
> -    }
> -
>       plic_phandles[socket] = (*phandle)++;
>       plic_addr = memmap[VIRT_PLIC].base + (memmap[VIRT_PLIC].size * socket);
>       plic_name = g_strdup_printf("/soc/plic@%lx", plic_addr);
> @@ -490,8 +472,33 @@ static void create_fdt_socket_plic(RISCVVirtState *s,
>                                     (char **)&plic_compat,
>                                     ARRAY_SIZE(plic_compat));
>       qemu_fdt_setprop(ms->fdt, plic_name, "interrupt-controller", NULL, 0);
> -    qemu_fdt_setprop(ms->fdt, plic_name, "interrupts-extended",
> -        plic_cells, s->soc[socket].num_harts * sizeof(uint32_t) * 4);
> +
> +    if (kvm_enabled()) {
> +        plic_cells = g_new0(uint32_t, s->soc[socket].num_harts * 2);
> +
> +        for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
> +            plic_cells[cpu * 2 + 0] = cpu_to_be32(intc_phandles[cpu]);
> +            plic_cells[cpu * 2 + 1] = cpu_to_be32(IRQ_S_EXT);
> +        }
> +
> +        qemu_fdt_setprop(ms->fdt, plic_name, "interrupts-extended",
> +                         plic_cells,
> +                         s->soc[socket].num_harts * sizeof(uint32_t) * 2);
> +   } else {
> +        plic_cells = g_new0(uint32_t, s->soc[socket].num_harts * 4);
> +
> +        for (cpu = 0; cpu < s->soc[socket].num_harts; cpu++) {
> +            plic_cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
> +            plic_cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_EXT);
> +            plic_cells[cpu * 4 + 2] = cpu_to_be32(intc_phandles[cpu]);
> +            plic_cells[cpu * 4 + 3] = cpu_to_be32(IRQ_S_EXT);
> +        }
> +
> +        qemu_fdt_setprop(ms->fdt, plic_name, "interrupts-extended",
> +                         plic_cells,
> +                         s->soc[socket].num_harts * sizeof(uint32_t) * 4);
> +    }
> +
>       qemu_fdt_setprop_cells(ms->fdt, plic_name, "reg",
>           0x0, plic_addr, 0x0, memmap[VIRT_PLIC].size);
>       qemu_fdt_setprop_cell(ms->fdt, plic_name, "riscv,ndev",

