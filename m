Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A497DBBE5
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 15:36:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxTLz-0007Hx-QT; Mon, 30 Oct 2023 10:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxTLr-0007Hp-DH
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:34:47 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qxTLp-0000Pi-Qe
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:34:47 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1e9c9d181d6so2962058fac.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 07:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698676484; x=1699281284; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IPun/K2D1V/RGkeXLxVA9Yld/QwxiBptJkAqsjBFkhI=;
 b=kzXuyD9WVCrfRNYRfIhCHnK2OLF0eUm9uvHOfth/iGeB04Rkiy4sNk8UoSsCy2KShO
 2mEzxP8gUtcXaPl/LDNyG+b010JzcwvPvT9L3I29NHHzluPP54KRrqJv9W5kk8CyWY0q
 RbjulKX8h+mRRk8EQGlwOfO2CGTFzhe1FlZPnFJxbzJL88jpYVig8/bjcRQYBGWkYJFS
 aFBDd40VjLObFVmbhXLR6sWvtg5dpQE6iZ5eWksEePG18+ZGVtYrBNIQM33ckO63EEAU
 cC85U1WlO9K0MYbov5c7hBuSOAGtwGtLTxJ9XqTnDP1xELg+Dx+k2pn4kKuYgyMFwPPz
 MNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698676484; x=1699281284;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IPun/K2D1V/RGkeXLxVA9Yld/QwxiBptJkAqsjBFkhI=;
 b=kRBW+ScpgqaTMzjtBv3IUtyeTuDITiqY4Yxh0hE4Ku4qhunvpfmgUmA2weYmq3GEZh
 abwVuU6izZxTFocZbvTb1rwSV79zdcKw9qFu7clFxPGGMIEsZrCQFJYKn9SQq7kJFL31
 ksk1KlvlXkiAJihBZ8hQ/NRvZ2p8aBOy7Iok0jHQRj0EtbDq1pVbU2qOGPYe6UHG//CI
 1j8qUYXpALT0n8BkS4glufUhTX292ETKsgLMJ1pN+EmJsBa58aGdFWLlbuWlafD6hIMs
 aKblxVMDgXBdaYQrldLmMXaSc5tGkY9JT8As/vWDApmnuSgzhV/GW7DLj89g22gEifHa
 Oq5Q==
X-Gm-Message-State: AOJu0YwDnL6hRiNnQq6BvrRg9rzftJARZhBu18r0ZBiSdC02GHJgEUp1
 1Fy2Uz6x8rjW3a+8m/GU78e35Q==
X-Google-Smtp-Source: AGHT+IH/yr9qLyMzOaGWEqcWKHgyCR9LtBuwcbJBd/j4o4d8PoY5Mjs6+DisPl8mydT2B5QLNUAJ9A==
X-Received: by 2002:a05:6870:164e:b0:1ea:6a7b:e40a with SMTP id
 c14-20020a056870164e00b001ea6a7be40amr12884211oae.59.1698676484444; 
 Mon, 30 Oct 2023 07:34:44 -0700 (PDT)
Received: from [192.168.68.107] ([179.193.10.161])
 by smtp.gmail.com with ESMTPSA id
 j205-20020a2523d6000000b00da05d771097sm3922150ybj.22.2023.10.30.07.34.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 07:34:44 -0700 (PDT)
Message-ID: <345e6083-206a-4bf2-8522-ee99fedc012d@ventanamicro.com>
Date: Mon, 30 Oct 2023 11:34:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] target/riscv: Add cfg property for Zvkt extension
Content-Language: en-US
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Andrew Jones <ajones@ventanamicro.com>
References: <20231026151828.754279-1-max.chou@sifive.com>
 <20231026151828.754279-2-max.chou@sifive.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20231026151828.754279-2-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x35.google.com
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



On 10/26/23 12:18, Max Chou wrote:
> Vector crypto spec defines the Zvkt extension that included all of the
> instructions of Zvbb & Zvbc extensions and some vector instructions.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu_cfg.h     | 1 +
>   target/riscv/tcg/tcg-cpu.c | 5 +++++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index e7ce977189c..d8d17dedeed 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -94,6 +94,7 @@ struct RISCVCPUConfig {
>       bool ext_zvknhb;
>       bool ext_zvksed;
>       bool ext_zvksh;
> +    bool ext_zvkt;
>       bool ext_zmmul;
>       bool ext_zvfbfmin;
>       bool ext_zvfbfwma;
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index c5ff03efce9..b9eaecb699c 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -499,6 +499,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           return;
>       }
>   
> +    if (cpu->cfg.ext_zvkt) {
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbb), true);
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbc), true);
> +    }
> +
>       /*
>        * In principle Zve*x would also suffice here, were they supported
>        * in qemu

