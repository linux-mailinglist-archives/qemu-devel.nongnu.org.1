Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 293D570BFB9
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 15:27:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q15Z1-0007xj-9Q; Mon, 22 May 2023 09:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q15Yw-0007Yo-OZ
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:26:58 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q15Yt-0001iJ-Vf
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:26:57 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3943fdc59f9so3369692b6e.0
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 06:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1684762014; x=1687354014;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=krE1/nBVzTIGQndZnFOFIzEF3RJn41Bt7djmd5K8rWU=;
 b=Jq2FjeiSgt58mkPo+HBl60dwBXqKw0Le513PRyYRXEt8l1h+yX8VtaOr/M1yTLsqaC
 CIMxhCfpYRnU37LFepcup8htQUr7ye0gi6KfZOCnt1jg7WfqrIyzzlNxSyocS+TZd56q
 BOC2ZgaJlB7uQL1zutfqTGMKktk1bAJyfAxFc7sJE5vlKLVnU4zxQeLAuGmooAZN5X9G
 TwXtn6kmSzdifvLISBQn2xAGD0drfMApOn2r8XZdsGpZdw6LcfZkzO8giiwzL+RngSvZ
 Gp+1SCFvQ8CaUc68F6i77jcVJd2a54CyuHxDkKiWL/dgD1+s3ggsAd8YNgPK5W88FXY1
 hW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684762014; x=1687354014;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=krE1/nBVzTIGQndZnFOFIzEF3RJn41Bt7djmd5K8rWU=;
 b=WLK9D30DP0JbLjHBVUhZxxIbd4NcMExkS/A0YjuVVIYFmpGWHDBdMjGgVXHJS9Fy8R
 1PXqOBZYEZ5hj6o3H1iUIr+3lh1qs/xdY8GT/lAGBWo4uM/g0PzRjknhnBvi9mVr5pDD
 j8aUM89mCBV72vxKDK3HQbyWFCy1VeDg7u7WBb3JDg6dZW0sXzXRUpz7bXi7n6W/FCAQ
 hsAGPTq0UJqo3WxAN38FmWkUbkY06U7rhbNH9yIWP7/9VVGFHQwhhlMNLYhWB9Hyk756
 EH6fps6mu94XUgybHGJNaPEerjtNdh1We9LzdPhpCmqOTDhob05fMZq9kQEH5ofF425q
 9aRA==
X-Gm-Message-State: AC+VfDxhMOCIBDrUFD1yl9nsDaqWVC/kIgPEAkWW/WftF7c6TTMA4/tV
 10TpWZKXpNzD6U93qrzG3VvlOg==
X-Google-Smtp-Source: ACHHUZ6KZ66UQBOyVDBYa6rApM/7cYIUaeMj1Lre0F84zpr/2U4CbDHXF5c69m9HGN9dnQJi4B6Byg==
X-Received: by 2002:a05:6808:109:b0:397:f94e:4321 with SMTP id
 b9-20020a056808010900b00397f94e4321mr2559026oie.23.1684762014501; 
 Mon, 22 May 2023 06:26:54 -0700 (PDT)
Received: from [192.168.68.107] ([179.111.98.125])
 by smtp.gmail.com with ESMTPSA id
 l133-20020acabb8b000000b0038dd5bf922bsm2699174oif.22.2023.05.22.06.26.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 06:26:54 -0700 (PDT)
Message-ID: <8254e33d-90c8-17ca-3d6f-2ed6305ad68f@ventanamicro.com>
Date: Mon, 22 May 2023 10:26:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/5] hw/riscv/opentitan: Explicit machine type definition
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org
References: <20230520054510.68822-1-philmd@linaro.org>
 <20230520054510.68822-5-philmd@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230520054510.68822-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x233.google.com
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
> Expand the DEFINE_MACHINE() macro, converting the class_init()
> handler.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   include/hw/riscv/opentitan.h |  3 ++-
>   hw/riscv/opentitan.c         | 10 +++++++---
>   2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/riscv/opentitan.h b/include/hw/riscv/opentitan.h
> index fd70226ed8..806ff73528 100644
> --- a/include/hw/riscv/opentitan.h
> +++ b/include/hw/riscv/opentitan.h
> @@ -24,6 +24,7 @@
>   #include "hw/char/ibex_uart.h"
>   #include "hw/timer/ibex_timer.h"
>   #include "hw/ssi/ibex_spi_host.h"
> +#include "hw/boards.h"
>   #include "qom/object.h"
>   
>   #define TYPE_RISCV_IBEX_SOC "riscv.lowrisc.ibex.soc"
> @@ -53,7 +54,7 @@ struct LowRISCIbexSoCState {
>       MemoryRegion flash_alias;
>   };
>   
> -#define TYPE_OPENTITAN_MACHINE "opentitan"
> +#define TYPE_OPENTITAN_MACHINE MACHINE_TYPE_NAME("opentitan")
>   
>   typedef struct OpenTitanState {
>       /*< private >*/
> diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
> index 7d7159ea30..9535308197 100644
> --- a/hw/riscv/opentitan.c
> +++ b/hw/riscv/opentitan.c
> @@ -108,8 +108,10 @@ static void opentitan_machine_init(MachineState *machine)
>       }
>   }
>   
> -static void opentitan_machine_class_init(MachineClass *mc)
> +static void opentitan_machine_class_init(ObjectClass *oc, void *data)
>   {
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +
>       mc->desc = "RISC-V Board compatible with OpenTitan";
>       mc->init = opentitan_machine_init;
>       mc->max_cpus = 1;
> @@ -118,8 +120,6 @@ static void opentitan_machine_class_init(MachineClass *mc)
>       mc->default_ram_size = ibex_memmap[IBEX_DEV_RAM].size;
>   }
>   
> -DEFINE_MACHINE(TYPE_OPENTITAN_MACHINE, opentitan_machine_class_init)
> -
>   static void lowrisc_ibex_soc_init(Object *obj)
>   {
>       LowRISCIbexSoCState *s = RISCV_IBEX_SOC(obj);
> @@ -327,6 +327,10 @@ static const TypeInfo open_titan_types[] = {
>           .instance_size  = sizeof(LowRISCIbexSoCState),
>           .instance_init  = lowrisc_ibex_soc_init,
>           .class_init     = lowrisc_ibex_soc_class_init,
> +    }, {
> +        .name           = TYPE_OPENTITAN_MACHINE,
> +        .parent         = TYPE_MACHINE,
> +        .class_init     = opentitan_machine_class_init,
>       }
>   };
>   

