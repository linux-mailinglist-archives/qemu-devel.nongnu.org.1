Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0920A7F1D34
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 20:18:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r59ly-0003io-3q; Mon, 20 Nov 2023 14:17:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r59ls-0003fz-3Q
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 14:17:25 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r59lo-0001ct-6E
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 14:17:22 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6c396ef9a3dso3935188b3a.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 11:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1700507837; x=1701112637; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=phERt2I0QChkIR0lqBCXxCvgPAXalYdszJgVYdI6K7Y=;
 b=ZtibrjTn8qAQMgWRo8I8aIFJcqhC484v8UhgoI0b75ufD+5knNPqajco3XJ74/8v8M
 Ll9/4Zv9ATcthIGicGIH+AxKvFLYw5Y8NPzv6TZDMrD3TyAjhyuRR5pVDH0/8D6s5heC
 ysl1kS/+YG5BvaxuVpbCeM4XGqI5vTStFJYIDdhiwWII+uIfULiBrRlKOL5EyF46vPhV
 6xlVarNGperzkeBUYrsWK9vcyfWne6kPum4HEU36/U6ImcfKcKmnH9nhMzRmtdYIWXfe
 gEGK7uCxEJV4UIaSj0DItlPoiVx9fI07R3PmXNwgcZN5/iNmWFYrRVc6U7u5njxfsaRE
 +cCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700507837; x=1701112637;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=phERt2I0QChkIR0lqBCXxCvgPAXalYdszJgVYdI6K7Y=;
 b=NugPsF7S2/kvTRvHqJkG1TpK5no1SwhmtRBplIwWPMKJsHMBR3VuAKE80+PBeHMdnz
 nlH2lcycnoZsN12TwXpukS3rdU1dbiUx7NGep3EXdXPA9kwzywLe7Iwru4o4NEohvD07
 CXPxgMY4/1X18hTg1tGDo6/9b8CpANF3mqP4ETgPtj3XohfFph6iU++BH8WlWpZZiirI
 t47NlPvnZ+CCaSCJGKlPLxRH31zJtdRg7DOx65/5iQWMhkuGtMe232UjqAbTJ0YQj5jZ
 uOsTTtyyxj0dt98qQzcJ555shgjzp3kzYUglsGqlitS1w8WhNMx9C54XYqGXuXDe/dnH
 JVFw==
X-Gm-Message-State: AOJu0YyvEk8VjNUylFuolxn13jXFxGMNbKz4zGxVZ7uzHTCJ6Q5mMiK0
 HzkbO0sWUFKjOJPQC/VcmBAATrmvhcvVbwnlmMc=
X-Google-Smtp-Source: AGHT+IFh3BbNeYZBbtuLuG5LiS2AF2tzVqX4WLap8BKzEqQqPo4gy2UPKOk26IMc6O946c2abLlKQw==
X-Received: by 2002:a05:6a20:4410:b0:188:865:72fd with SMTP id
 ce16-20020a056a20441000b00188086572fdmr7974728pzb.28.1700507837236; 
 Mon, 20 Nov 2023 11:17:17 -0800 (PST)
Received: from [192.168.68.109] ([152.250.131.119])
 by smtp.gmail.com with ESMTPSA id
 fb26-20020a056a002d9a00b006c2fd6a7fe3sm6404743pfb.22.2023.11.20.11.17.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 11:17:16 -0800 (PST)
Message-ID: <f415b8ed-914c-4090-b13d-12e6b3fc41be@ventanamicro.com>
Date: Mon, 20 Nov 2023 16:17:13 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/riscv/cpu_helper.c: Fix mxr bit behavior
Content-Language: en-US
To: Ivan Klokov <ivan.klokov@syntacore.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
References: <20231120120609.37960-1-ivan.klokov@syntacore.com>
 <20231120120609.37960-3-ivan.klokov@syntacore.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231120120609.37960-3-ivan.klokov@syntacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x431.google.com
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



On 11/20/23 09:06, Ivan Klokov wrote:
> According to RISCV Specification sect 9.5 on two stage translation when
> V=1 the vsstatus(mstatus in QEMU's terms) field MXR, which makes
> execute-only pages readable, only overrides VS-stage page protection.
> Setting MXR at HS-level(mstatus_hs), however, overrides both VS-stage
> and G-stage execute-only permissions.
> 
> The hypervisor extension changes the behavior of MXR\MPV\MPRV bits.
> Due to RISCV Specification sect. 9.4.1 when MPRV=1, explicit memory
> accesses are translated and protected, and endianness is applied, as
> though the current virtualization mode were set to MPV and the current
> nominal privilege mode were set to MPP. vsstatus.MXR makes readable
> those pages marked executable at the VS translation stage.
> 

Please add

Fixes: 36a18664ba ("target/riscv: Implement second stage MMU")

> Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu_helper.c | 24 ++++++++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 9ff0952e46..e7e23b34f4 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1032,13 +1032,29 @@ restart:
>           prot |= PAGE_WRITE;
>       }
>       if (pte & PTE_X) {
> -        bool mxr;
> +        bool mxr = false;
>   
> -        if (first_stage == true) {
> +        /*
> +         * Use mstatus for first stage or for the second stage without
> +         * virt_enabled (MPRV+MPV)
> +         */
> +        if (first_stage || !env->virt_enabled) {
>               mxr = get_field(env->mstatus, MSTATUS_MXR);
> -        } else {
> -            mxr = get_field(env->vsstatus, MSTATUS_MXR);
>           }
> +
> +        /* MPRV+MPV case, check VSSTATUS */
> +        if (first_stage && two_stage && !env->virt_enabled) {
> +            mxr |= get_field(env->vsstatus, MSTATUS_MXR);
> +        }
> +
> +        /*
> +         * Setting MXR at HS-level overrides both VS-stage and G-stage
> +         * execute-only permissions
> +         */
> +        if (env->virt_enabled) {
> +            mxr |= get_field(env->mstatus_hs, MSTATUS_MXR);
> +        }
> +
>           if (mxr) {
>               prot |= PAGE_READ;
>           }

