Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A6876ED56
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 16:57:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRZlT-0001Qi-IA; Thu, 03 Aug 2023 10:57:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRZlS-0001QK-06
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 10:57:22 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRZlQ-0004Yv-7h
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 10:57:21 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-686f0d66652so925129b3a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 07:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691074638; x=1691679438;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SEUOe9coGbWaHavP+cPtvmiU6Pnq74RPcJhaPzgcFwc=;
 b=tcOxbuXELmdYatLk2rC7rk3TRID7phOjUs9x0QtBxrvO3licD8LYvGsitIDypDPWr3
 c79sr2v3jGwNhbJdcP/+sEFDAhajXTgFlaoJ/xa8CiTQl5/PeqkqwlED7Gdm6vS/t2Fu
 0G9zVzhFLZQV71nN2d2fhCt84a2BUYhnb2yxamjhcXVxxolCejEC6aC3unL6/2gDFg70
 Y5TtNWv0z5ajiz1YdU/zrIU2Y73klp12nXHxHwSGZJ2DhGWsR9MeBhF/qrRDrvKLC9MG
 20lyuQSEVjiW1cYZHKeEbirqkCXx7ozren2pWS8y9HY/Xds7xlXF92WczCNf/9LoIHAu
 VtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691074638; x=1691679438;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SEUOe9coGbWaHavP+cPtvmiU6Pnq74RPcJhaPzgcFwc=;
 b=J5LD9xiyMgQIk/1R8Okk3a+9cni430h+6t3QSLJJ2ODR98GmCfTYFXR7ifEbRZVMbM
 PCYF4yJvGeSb9rI4evJtaxUcLrf9iCJBwtp0qLlta5OoWvsfgDLp/v5ZBQE7IQSFNI+c
 ihn8CmGyXDNHTQB0SGeRASHn6DxFslh9IYnsPDZw+jrbwsksO84qoEBm4ng5Vj4G5ke6
 dTQF/Et3XqsTZIqu2h1jtH3W6gYrpwJeqhw/oM9rnIA/ogojgIKLw1GCbXxDbgRventJ
 XZxfYkxxZw3hRCYxKbWgb3zZbPBLsCVNa1yPVQSho8CYHR6C+83qIiP8czQBXhHtlg66
 EkgQ==
X-Gm-Message-State: ABy/qLY1OsGD9h+xte/mwFOxGVaSOkBZkQQYg2lHBJ1GOETHft0YqLPF
 yTpI2wBMh8wPecTS1+toZPSy6Q==
X-Google-Smtp-Source: APBJJlFmCXy5xFa8GNCBmyG/ABrJXrzVA85Wjy8jKYfX6rxHKACYYupCHO56ddZ4Ttdkh48dEKfHLA==
X-Received: by 2002:a05:6a20:554:b0:13d:5b8f:164e with SMTP id
 20-20020a056a20055400b0013d5b8f164emr13666916pzq.11.1691074638496; 
 Thu, 03 Aug 2023 07:57:18 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.144.105])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62bd12000000b0067acbc74977sm13279884pff.96.2023.08.03.07.57.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 07:57:17 -0700 (PDT)
Message-ID: <7e58cf18-b1c0-c15d-dbf0-8b858dab2d9c@linaro.org>
Date: Thu, 3 Aug 2023 07:57:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] Fix SEGFAULT on getting physical address of MMIO
 region.
Content-Language: en-US
To: Mikhail Tyutin <m.tyutin@yadro.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, alex.bennee@linaro.org,
 Dmitriy Solovev <d.solovev@yadro.com>
References: <20230803105830.8722-1-m.tyutin@yadro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230803105830.8722-1-m.tyutin@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 8/3/23 03:58, Mikhail Tyutin wrote:
> Apply save_iotlb_data() to io_readx() as well as to io_writex().
> 
> Signed-off-by: Dmitriy Solovev <d.solovev@yadro.com>
> Signed-off-by: Mikhail Tyutin <m.tyutin@yadro.com>
> ---
>   accel/tcg/cputlb.c | 36 +++++++++++++++++++++---------------
>   1 file changed, 21 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index ba44501a7c..addce3be38 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1363,6 +1363,21 @@ static inline void cpu_transaction_failed(CPUState *cpu, hwaddr physaddr,
>       }
>   }
>   
> +/*
> + * Save a potentially trashed CPUTLBEntryFull for later lookup by plugin.
> + * This is read by tlb_plugin_lookup if the fulltlb entry doesn't match
> + * because of the side effect of io_writex changing memory layout.
> + */
> +static void save_iotlb_data(CPUState *cs, MemoryRegionSection *section,
> +                            hwaddr mr_offset)
> +{
> +#ifdef CONFIG_PLUGIN
> +    SavedIOTLB *saved = &cs->saved_iotlb;
> +    saved->section = section;
> +    saved->mr_offset = mr_offset;
> +#endif
> +}
> +
>   static uint64_t io_readx(CPUArchState *env, CPUTLBEntryFull *full,
>                            int mmu_idx, vaddr addr, uintptr_t retaddr,
>                            MMUAccessType access_type, MemOp op)
> @@ -1382,6 +1397,12 @@ static uint64_t io_readx(CPUArchState *env, CPUTLBEntryFull *full,
>           cpu_io_recompile(cpu, retaddr);
>       }
>   
> +    /*
> +     * The memory_region_dispatch may trigger a flush/resize
> +     * so for plugins we save the iotlb_data just in case.
> +     */
> +    save_iotlb_data(cpu, section, mr_offset);
> +
>       {
>           QEMU_IOTHREAD_LOCK_GUARD();
>           r = memory_region_dispatch_read(mr, mr_offset, &val, op, full->attrs);
> @@ -1398,21 +1419,6 @@ static uint64_t io_readx(CPUArchState *env, CPUTLBEntryFull *full,
>       return val;
>   }
>   
> -/*
> - * Save a potentially trashed CPUTLBEntryFull for later lookup by plugin.
> - * This is read by tlb_plugin_lookup if the fulltlb entry doesn't match
> - * because of the side effect of io_writex changing memory layout.
> - */
> -static void save_iotlb_data(CPUState *cs, MemoryRegionSection *section,
> -                            hwaddr mr_offset)
> -{
> -#ifdef CONFIG_PLUGIN
> -    SavedIOTLB *saved = &cs->saved_iotlb;
> -    saved->section = section;
> -    saved->mr_offset = mr_offset;
> -#endif
> -}
> -
>   static void io_writex(CPUArchState *env, CPUTLBEntryFull *full,
>                         int mmu_idx, uint64_t val, vaddr addr,
>                         uintptr_t retaddr, MemOp op)


