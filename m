Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 836BD70BFBC
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 15:27:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q15ZA-0008HP-4G; Mon, 22 May 2023 09:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q15Z6-0008FG-8g
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:27:08 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q15Z4-0001j2-JN
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:27:08 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-38e3228d120so3566153b6e.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 06:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1684762025; x=1687354025;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ibL3IjfchAYLIitdIAB+Tn3Vg8b50neNn7IGZQmOjSY=;
 b=a650pEP6a1mWbMTP/5XIe2eUMIUV/g+KWgQgQdErIfpgzqM9alza32KGCdNpoyoip2
 hT1eQ8o7IsIGNMnb+MFPpU+5HgqJT5tjom1B335qntRf3DiCTuxLdCgB1RS65/VgSIQY
 cWCmCbuL6zfQ48pqdFpj32ouhXyCNxWFSl1YRhW7hsdg4gjgj/gA/YGSJyfHJ3Rvybdi
 UEfnUS0YQOq+czAtHLB8e0iNtr8DWSt6WMzqbRLOTxGfcBMnBzrPUIBVoQxV1gvIB671
 mCbLhlUxgnGF6phkPbcZXmYQRhKL7NU/zgxKfvWn2ZrJ6uFtBH2ppcMm5NULJ5Mbam2d
 WQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684762025; x=1687354025;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ibL3IjfchAYLIitdIAB+Tn3Vg8b50neNn7IGZQmOjSY=;
 b=S05kTHDmfNhbpgFo7Kfs7uvgFvx4V6Y75QxQff70biKnRaIsIyj+b1gWdAmPwPc1d1
 kiP1WopMIG98rFwnniRjM3/c5RhhcoO0AC/tyvCtXZRZIlIhNnX/TpvLVTAEnR8r0QdK
 6ZN7JaVEgpiXrDZ6PdkZC4REWfxCpj3NTTgbrnwyO6w5B28YG3wFyNWJJQi6PG/UV5FI
 lBl5GSnbodphXmJTWhe7dgjfl/2gQ6E5+ZEDc03bX/6ylz20MSY013keTIjsav48ubJH
 pr+KTvmPvzR1UfT+6f5eT3NsWuEXE2TqqR0ge3Utxn3F02XEjoojwLTII206NgtqPlgf
 zXPA==
X-Gm-Message-State: AC+VfDyR3s+D9HNzUopdBDI1Wlb/5EInAIOSE8PBKou++u9akJdkkm2d
 glxfYOyvPanBlcKb8aAuGAV3Zg==
X-Google-Smtp-Source: ACHHUZ70vA2GViOl78oHhwfgl6Ws2vxGdFlMqmkjCsA3fTvLT/TI6I8cX1CAoVSjzv4mkqE1PZZo1w==
X-Received: by 2002:a54:4819:0:b0:389:4a00:51b5 with SMTP id
 j25-20020a544819000000b003894a0051b5mr5487657oij.8.1684762025172; 
 Mon, 22 May 2023 06:27:05 -0700 (PDT)
Received: from [192.168.68.107] ([179.111.98.125])
 by smtp.gmail.com with ESMTPSA id
 j8-20020a4adf48000000b0051134f333d3sm2308454oou.16.2023.05.22.06.27.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 06:27:04 -0700 (PDT)
Message-ID: <c95d3fe1-a37b-ae6d-48f1-abca5875e349@ventanamicro.com>
Date: Mon, 22 May 2023 10:27:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5/5] hw/riscv/opentitan: Correct OpenTitanState parent
 type/size
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org
References: <20230520054510.68822-1-philmd@linaro.org>
 <20230520054510.68822-6-philmd@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230520054510.68822-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x22d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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



On 5/20/23 02:45, Philippe Mathieu-Daudé wrote:
> OpenTitanState is the 'machine' (or 'board') state: it isn't
> a SysBus device, but inherits from the MachineState type.
> Correct the instance size.
> Doing so we  avoid leaking an OpenTitanState pointer in
> opentitan_machine_init().
> 
> Fixes: fe0fe4735e ("riscv: Initial commit of OpenTitan machine")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   include/hw/riscv/opentitan.h | 3 ++-
>   hw/riscv/opentitan.c         | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.h
> index 806ff73528..609473d07b 100644
> --- a/include/hw/riscv/opentitan.h
> +++ b/include/hw/riscv/opentitan.h
> @@ -55,10 +55,11 @@ struct LowRISCIbexSoCState {
>   };
>   
>   #define TYPE_OPENTITAN_MACHINE MACHINE_TYPE_NAME("opentitan")
> +OBJECT_DECLARE_SIMPLE_TYPE(OpenTitanState, OPENTITAN_MACHINE)
>   
>   typedef struct OpenTitanState {
>       /*< private >*/
> -    SysBusDevice parent_obj;
> +    MachineState parent_obj;
>   
>       /*< public >*/
>       LowRISCIbexSoCState soc;
> diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
> index 9535308197..6a2fcc4ade 100644
> --- a/hw/riscv/opentitan.c
> +++ b/hw/riscv/opentitan.c
> @@ -78,8 +78,8 @@ static const MemMapEntry ibex_memmap[] = {
>   static void opentitan_machine_init(MachineState *machine)
>   {
>       MachineClass *mc = MACHINE_GET_CLASS(machine);
> +    OpenTitanState *s = OPENTITAN_MACHINE(machine);
>       const MemMapEntry *memmap = ibex_memmap;
> -    OpenTitanState *s = g_new0(OpenTitanState, 1);
>       MemoryRegion *sys_mem = get_system_memory();
>   
>       if (machine->ram_size != mc->default_ram_size) {
> @@ -330,6 +330,7 @@ static const TypeInfo open_titan_types[] = {
>       }, {
>           .name           = TYPE_OPENTITAN_MACHINE,
>           .parent         = TYPE_MACHINE,
> +        .instance_size  = sizeof(OpenTitanState),
>           .class_init     = opentitan_machine_class_init,
>       }
>   };

