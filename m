Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAD370BFBA
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 15:27:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q15Yy-0007Pn-Jk; Mon, 22 May 2023 09:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q15Ya-00078z-I4
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:26:39 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q15YY-0001gx-Om
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:26:36 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3942c6584f0so2032450b6e.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 06:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1684761993; x=1687353993;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OV62XamewlS6jizbJt1bbbumcE8i5gpEe8aiQ7g/ex4=;
 b=S9mo2s8jw+AqYZat+qDbNXOPq2ixcJsbkSLQfLl8XNdyzDV8fx6WA7EX2Bc6l4XzdZ
 7Wq6PKC80PuJfxFqtvvH2JQ7XMldmoAovTU4Cw5U+BqlTaLn4gj4zsV7JaBwwe7VWdWf
 7BMyay/AQeBkFvZZOmbyRoVKizoZwTmxowbQV9ztnoSn5o7wCy1tDctvj/afzZ1icZvI
 71hbgN1juZcY5aCXkpxTrBIIDmwPnsiVn7dRkua5gXkIWahWZp1Gp9mYY/V1HrkOR4W8
 1ASs7TUCLNwNV8mUFEn9r8vUZssZrKHqh6CV+ZtSgTT8dlf4uJ+9u/LFw+wB+8s8zz8t
 /uQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684761993; x=1687353993;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OV62XamewlS6jizbJt1bbbumcE8i5gpEe8aiQ7g/ex4=;
 b=ZAkUzPYYFRSL3Cfh8GIx8vqC7bXU+VDGDuvaijqG4i2sRYVkvqfANSnu+yTCuKSklp
 6q3UWQ9JvAZkxGjOOHXCeBe5X/fTRPbdUVyO7UO/+Musgh+MXld7j15qd2ktb0dwOEAf
 fZ89jOk8kdO3bFSbw8xUBZlAeKZRSK4RmyeJi4W+zm3wG0qFa5lfCJTGF0hURU8J2MAK
 fg/KUv61c+9UzXvFX9LToIyHBWuqmxMH+2j2cpqvsGXKjlj4mfQeSjrJGvCAds8FRqJa
 VERnPSJcoVKQfiXs9OANremBo4ygVNtzUPNWkl0rYwY6+JsfgnlBCD/VOf2tN0YwRn9H
 Sw+w==
X-Gm-Message-State: AC+VfDxfccozb8aBARKxB/VwClitx9TiM5y1zRX+k2fCvZ5dBsmMxxNf
 ZWbgiCN2lLr5X5MlAlhov4QUyA==
X-Google-Smtp-Source: ACHHUZ6H960Se2rfnSezByfxvmqurr6ityumr7j5QuWGys8Tl9ES/Q4jNtwmUD+kUIMnK1uNjCv93g==
X-Received: by 2002:a54:4799:0:b0:38d:fdf2:962e with SMTP id
 o25-20020a544799000000b0038dfdf2962emr5562205oic.23.1684761993551; 
 Mon, 22 May 2023 06:26:33 -0700 (PDT)
Received: from [192.168.68.107] ([179.111.98.125])
 by smtp.gmail.com with ESMTPSA id
 ay35-20020a056820152300b0052a32a952e9sm2276195oob.48.2023.05.22.06.26.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 06:26:33 -0700 (PDT)
Message-ID: <ceb46277-bd9a-a42f-5396-385b56a8265f@ventanamicro.com>
Date: Mon, 22 May 2023 10:26:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/5] hw/riscv/opentitan: Declare QOM types using
 DEFINE_TYPES() macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org
References: <20230520054510.68822-1-philmd@linaro.org>
 <20230520054510.68822-3-philmd@linaro.org>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230520054510.68822-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oi1-x235.google.com
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
> When multiple QOM types are registered in the same file,
> it is simpler to use the the DEFINE_TYPES() macro. Replace
> the type_init() / type_register_static() combination. This
> is in preparation of adding the OpenTitan machine type to
> this array in a pair of commits.

I wonder whether we should forbid type_init()/type_register_static() and
force everyone to use DEFINE_TYPES(). We need less options when dealing
with QOM.

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/riscv/opentitan.c | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
> index 2d21ee39c5..294955eeea 100644
> --- a/hw/riscv/opentitan.c
> +++ b/hw/riscv/opentitan.c
> @@ -320,17 +320,14 @@ static void lowrisc_ibex_soc_class_init(ObjectClass *oc, void *data)
>       dc->user_creatable = false;
>   }
>   
> -static const TypeInfo lowrisc_ibex_soc_type_info = {
> -    .name = TYPE_RISCV_IBEX_SOC,
> -    .parent = TYPE_DEVICE,
> -    .instance_size = sizeof(LowRISCIbexSoCState),
> -    .instance_init = lowrisc_ibex_soc_init,
> -    .class_init = lowrisc_ibex_soc_class_init,
> +static const TypeInfo open_titan_types[] = {
> +    {
> +        .name           = TYPE_RISCV_IBEX_SOC,
> +        .parent         = TYPE_DEVICE,
> +        .instance_size  = sizeof(LowRISCIbexSoCState),
> +        .instance_init  = lowrisc_ibex_soc_init,
> +        .class_init     = lowrisc_ibex_soc_class_init,
> +    }
>   };
>   
> -static void lowrisc_ibex_soc_register_types(void)
> -{
> -    type_register_static(&lowrisc_ibex_soc_type_info);
> -}
> -
> -type_init(lowrisc_ibex_soc_register_types)
> +DEFINE_TYPES(open_titan_types)

