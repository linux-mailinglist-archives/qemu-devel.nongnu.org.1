Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B487729CA
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 17:51:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT2V8-0003oh-I6; Mon, 07 Aug 2023 11:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT2V4-0003oM-QE
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:50:31 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT2Uz-000124-0T
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:50:27 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bb7b8390e8so28982715ad.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 08:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691423422; x=1692028222;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xj1GJ47ptnk4/s6OIgmU9YJWQzLagDnqS2oiLrsRs2I=;
 b=ZGxrgGoXlXQEr+lrPk2vVPDyfSIF8G8X578WiXakabibeieJwak/E132f3EJzY0LA+
 zF5lst0L800IEbVm8Jij5hmhe/dfEK7TpYhoVAOXkzOCDGziMrTBoqIQ44VnHY2w/0uP
 I8nYIOHY8vyOvL7U0rGGO/a9bY+ccVTtfMyPTs+HrWttwKn/xFs7oZZdNE9Lrk0gVuM0
 dccqIQTitWo3B+0UUgKm+3RZ91OMUnidroiio1JDQT6Q+tgtjVNqMAgT2DguOezszlMm
 wiWP6vXlPxid4rF2e1tsc7dObL7RdyhmhXDITsdkznvzi+4GMcj0i4NcxhDu73gBQAfw
 fC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691423422; x=1692028222;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xj1GJ47ptnk4/s6OIgmU9YJWQzLagDnqS2oiLrsRs2I=;
 b=IN9ckeM/Fxg9wXXLdlP9ORjsBdV1qzsBLycdTdr23wE+xN1xmngrJ0U0nyN+iTwHi3
 0cwXKdAd/Br53kbiJWKcCUAESZKzuEIE1S+b1/2KYmAfRqmc/0scmp/tF/MKH0/8x/Dl
 Pks9ZUR3v6RLUADBhCLUJ0siXF9f8Co9uwI39dZaq8K7C+7+YyJtvKlHjY5Bc0YG3NqD
 GEv18alxiN52X+xMVyJWIuK/gSrN+nrQhf7ElUmNjJwMNd1MH0Sk/YjVUPNXCNpVYsyv
 I10TglxIQrsza5F4AXQudIflRj6mQXTMhJx97aRK8dXq7+2a4DStvT4TZMsk8Hz4Jj6t
 W82g==
X-Gm-Message-State: AOJu0YxeyVW8n/BFGnncin/WtqDXpN9XDJZWdhHOVNpvSnHMOJ8XDNdd
 1A1Ca88DHU3EWQ9ZcDEkiB/sCg==
X-Google-Smtp-Source: AGHT+IGPC+xkvDSgv9ybPISNpT01i4UuXAryA2alZgmrRmT3tUBC2Eim39PB5TBE0esobcjb8Kc7kA==
X-Received: by 2002:a17:903:1cb:b0:1b8:9044:9ede with SMTP id
 e11-20020a17090301cb00b001b890449edemr9903941plh.62.1691423422273; 
 Mon, 07 Aug 2023 08:50:22 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e306:567a:e0a1:341?
 ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a170902744900b001b895a18472sm7062702plt.117.2023.08.07.08.50.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 08:50:21 -0700 (PDT)
Message-ID: <21b780f0-baa1-c006-2e82-b646442d86f2@linaro.org>
Date: Mon, 7 Aug 2023 08:50:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 5/6] target/loongarch: Support LoongArch32 DMW
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, Song Gao
 <gaosong@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230807094505.2030603-1-c@jia.je>
 <20230807094505.2030603-6-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230807094505.2030603-6-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
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

On 8/7/23 02:45, Jiajie Chen wrote:
> LA32 uses a different encoding for CSR.DMW and a new direct mapping
> mechanism.
> 
> Signed-off-by: Jiajie Chen <c@jia.je>
> ---
>   target/loongarch/cpu-csr.h    |  7 +++----
>   target/loongarch/tlb_helper.c | 31 ++++++++++++++++++++++++++++---
>   2 files changed, 31 insertions(+), 7 deletions(-)
> 
> diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
> index 48ed2e0632..b93f99a9ef 100644
> --- a/target/loongarch/cpu-csr.h
> +++ b/target/loongarch/cpu-csr.h
> @@ -188,10 +188,9 @@ FIELD(CSR_DMW, PLV1, 1, 1)
>   FIELD(CSR_DMW, PLV2, 2, 1)
>   FIELD(CSR_DMW, PLV3, 3, 1)
>   FIELD(CSR_DMW, MAT, 4, 2)
> -FIELD(CSR_DMW, VSEG, 60, 4)
> -
> -#define dmw_va2pa(va) \
> -    (va & MAKE_64BIT_MASK(0, TARGET_VIRT_ADDR_SPACE_BITS))
> +FIELD(CSR_DMW_32, PSEG, 25, 3)
> +FIELD(CSR_DMW_32, VSEG, 29, 3)
> +FIELD(CSR_DMW_64, VSEG, 60, 4)
>   
>   /* Debug CSRs */
>   #define LOONGARCH_CSR_DBG            0x500 /* debug config */
> diff --git a/target/loongarch/tlb_helper.c b/target/loongarch/tlb_helper.c
> index 690c6ef25f..cf6f5863f9 100644
> --- a/target/loongarch/tlb_helper.c
> +++ b/target/loongarch/tlb_helper.c
> @@ -173,6 +173,18 @@ static int loongarch_map_address(CPULoongArchState *env, hwaddr *physical,
>       return TLBRET_NOMATCH;
>   }
>   
> +static hwaddr dmw_va2pa(CPULoongArchState *env, target_ulong va,
> +                        target_ulong dmw)
> +{
> +    if (env->mode == LA64) {
> +        return va & TARGET_PHYS_MASK;
> +    } else {
> +        uint32_t pseg = FIELD_EX32(dmw, CSR_DMW_32, PSEG);
> +        return (va & MAKE_64BIT_MASK(0, R_CSR_DMW_32_VSEG_SHIFT)) | \
> +            (pseg << R_CSR_DMW_32_VSEG_SHIFT);
> +    }
> +}
> +
>   static int get_physical_address(CPULoongArchState *env, hwaddr *physical,
>                                   int *prot, target_ulong address,
>                                   MMUAccessType access_type, int mmu_idx)
> @@ -184,6 +196,11 @@ static int get_physical_address(CPULoongArchState *env, hwaddr *physical,
>       uint8_t da = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, DA);
>       uint8_t pg = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG);
>   
> +    /* Truncate high 32 bits for LA32 */
> +    if (env->mode == LA32) {
> +        address = (uint32_t)address;
> +    }

You need to do this in the translator, because this also depends on VA32L* and the current 
priv level.

Otherwise the window manipulation looks correct.


r~

