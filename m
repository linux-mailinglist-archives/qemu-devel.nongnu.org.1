Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E07D82A02D
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 19:19:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNdA4-0003hy-Bx; Wed, 10 Jan 2024 13:18:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rNdA2-0003gc-Jq
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 13:18:42 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rNd9z-0005ae-Ar
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 13:18:42 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6d99980b2e0so3786991b3a.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 10:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704910717; x=1705515517; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EJ9VZMeaJTqZW0ZuBr64+c6p1gkZ0YZs/W8AZOLQufI=;
 b=BVR3fYVFLVxsk8wUfh10iCAcKMDKeo1ordcjRmTTvDVWs06mMShKv/c//69dvkqrtq
 6iqx+EA/n9hzB4qR1Wpw/GUbduJIAdFg4PqK0UD8Buk85or45WX5xBs1OGW7Y0rKxjKS
 nqy4XGP9YGkAs8Oh55AP2nxFHu/exvjOX6Rxj7UppSIC6AcpOPMxz893CkHz0R6SHN2v
 hGlg7iKle2ovar+wmeTgkvrxy6HJlwZkN28ixeZEiOcH60rijhfKlNz16gYP/o9H5ZFY
 pOL06vYBmBBTDSalrIQA5yXaEqu2vfbCHfsU42kdLI+eknIqEoKPvw6L/hlEW8E9F1mO
 TF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704910717; x=1705515517;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EJ9VZMeaJTqZW0ZuBr64+c6p1gkZ0YZs/W8AZOLQufI=;
 b=Kiv1vD7xF1GqV5y8Pvbvp4lwlx+ThdjAvjIOfi/M2REVQokrGmsjvwRwD1GIm5Uba+
 XXOJZH8xLB5pwaGGHweln4tOMMEf9kIqonboomWIN/gH0P49jhEFHL29nbf7IvQNv+BR
 p9xdaQUCLJ0ihHOlrs6Ialy1g28xpM8SgC2E2XOiCH20/AOHCxyO/mtiuvoInvwyPvMm
 4Y7i+FuzgkZthpNROUBMx3tv8skW3tix8s/y9e2JKA/l7Z1s6yOryIZ0koc1XhldlQ7G
 gHhwKrAKvYsDeOwARnPDe7BG2LyWKhkzKLzOzsoMpPprKePFAYuoOSMaRFOlPYBh/bW0
 9LKA==
X-Gm-Message-State: AOJu0YwV1TcOy/JFDyKFeQu6lo/9awS7593C9Svb7MlX9pUow5IGnp4H
 3YOL3JTZPX63g5OxRH/G3r9nrXSpbJxMcg==
X-Google-Smtp-Source: AGHT+IErg65q8MtO3nVpaVwk+3JCDKExqmbf3uwscCieYaab7O/fci7LRipf996S9CulJ2yf3fUQ5g==
X-Received: by 2002:a62:b502:0:b0:6d9:bbd6:aa7 with SMTP id
 y2-20020a62b502000000b006d9bbd60aa7mr32937pfe.6.1704910717599; 
 Wed, 10 Jan 2024 10:18:37 -0800 (PST)
Received: from [192.168.68.110] ([152.234.123.64])
 by smtp.gmail.com with ESMTPSA id
 d18-20020aa78152000000b006d9a9727a8esm3935679pfn.178.2024.01.10.10.18.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 10:18:37 -0800 (PST)
Message-ID: <46c8faa8-3e70-4a34-a156-91795e9b6825@ventanamicro.com>
Date: Wed, 10 Jan 2024 15:18:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/riscv: Add infrastructure for 'B' MISA
 extension
Content-Language: en-US
To: Rob Bradford <rbradford@rivosinc.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, atishp@rivosinc.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
References: <20240109171848.32237-1-rbradford@rivosinc.com>
 <20240109171848.32237-2-rbradford@rivosinc.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240109171848.32237-2-rbradford@rivosinc.com>
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



On 1/9/24 14:07, Rob Bradford wrote:
> Add the infrastructure for the 'B' extension which is the union of the
> Zba, Zbb and Zbs instructions.
> 
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> ---
>   target/riscv/cpu.c         | 5 +++--
>   target/riscv/cpu.h         | 1 +
>   target/riscv/tcg/tcg-cpu.c | 1 +
>   3 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index b07a76ef6b..22f8e527ff 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -38,9 +38,9 @@
>   #include "tcg/tcg.h"
>   
>   /* RISC-V CPU definitions */
> -static const char riscv_single_letter_exts[] = "IEMAFDQCPVH";
> +static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
>   const uint32_t misa_bits[] = {RVI, RVE, RVM, RVA, RVF, RVD, RVV,
> -                              RVC, RVS, RVU, RVH, RVJ, RVG, 0};
> +                              RVC, RVS, RVU, RVH, RVJ, RVG, RVB, 0};
>   
>   /*
>    * From vector_helper.c
> @@ -1251,6 +1251,7 @@ static const MISAExtInfo misa_ext_info_arr[] = {
>       MISA_EXT_INFO(RVJ, "x-j", "Dynamic translated languages"),
>       MISA_EXT_INFO(RVV, "v", "Vector operations"),
>       MISA_EXT_INFO(RVG, "g", "General purpose (IMAFD_Zicsr_Zifencei)"),
> +    MISA_EXT_INFO(RVB, "x-b", "Bit manipulation (Zba_Zbb_Zbs)")
>   };
>   
>   static int riscv_validate_misa_info_idx(uint32_t bit)
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 2725528bb5..756a345513 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -69,6 +69,7 @@ typedef struct CPUArchState CPURISCVState;
>   #define RVH RV('H')
>   #define RVJ RV('J')
>   #define RVG RV('G')
> +#define RVB RV('B')
>   
>   extern const uint32_t misa_bits[];
>   const char *riscv_get_misa_ext_name(uint32_t bit);
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 8a35683a34..fda54671d5 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -791,6 +791,7 @@ static const RISCVCPUMisaExtConfig misa_ext_cfgs[] = {
>       MISA_CFG(RVJ, false),
>       MISA_CFG(RVV, false),
>       MISA_CFG(RVG, false),
> +    MISA_CFG(RVB, false)

Please add a comma at the end:


> +    MISA_CFG(RVB, false),

This way, when a new bit is added, the change is limited to the new entry.


With this nit fixed:


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>



>   };
>   
>   /*

