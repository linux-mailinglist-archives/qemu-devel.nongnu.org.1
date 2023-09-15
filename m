Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B017A2407
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:58:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhC8s-0008It-RF; Fri, 15 Sep 2023 12:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhC8q-0008IO-Vq
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:58:05 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhC8p-0007nM-6B
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:58:04 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2bf78950354so38825831fa.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694797081; x=1695401881; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vZXN12N3RmLett69ijlEiAAv9kErIvXFjkK54J2H7yw=;
 b=D1m0cl56k/AIZ3p9QYQbvjwRh9OtuKzqPrVJbtm0PXfocGrS6ThQXjsRb3dzwXe4DX
 ebPGDncyvGbfXyHnMyy9GW4JuUMjxjBBCAnKkPoDqrFFiyLPG+sU3EhH1R1V5o0rgbUh
 2fj9ZD95qVwgUyPzPofzuGuF57F7v0COW5nm/WkPH1JMXB/C+8qErUVqnSH8WpehfSUq
 lre4FvWEdyRMT+/qfuWJi6cRXE7EZAefEB+jK5dQ4W+zkDiU2pgWr8N5QiEQ5/jyFg2S
 gGh7aWaz3jBy2HvqRGrzPkVWW5JWFTAz5N4sTEp8FOenZsX35AXfMr0tgAmyl+l3EjN8
 2HoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694797081; x=1695401881;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vZXN12N3RmLett69ijlEiAAv9kErIvXFjkK54J2H7yw=;
 b=GTf4PKsoOPEbEucRVEDk4e5T618hNRh8t1WgKc7HgFEgI4CUnVmdbhhbc1u8PmGRp6
 p4bPfVRJLnowg1Kf67ryggF31IQydnfT0hxT47OuDetNhmnFE/9aq1Y3lEPP2+6ddmbx
 Fe9WWKv7NmKOXbJYy0T61vDY1rmgL77CbS9eiImIl9x6r+M1nPabbZ2SXRIE31lNg+18
 cc5ocm6kFL2RymFA4j/Pyvu2yaERXPQOMINfWBLsfjpOpvZp1XsJVygmLnYtw1aI5S6p
 8BGUlwnuNmNT1Ziu7+378EatMCLYx+EAC7Tdhs7n0voQ72S9FgAbBWRI9qkg3OQEjIVw
 69Tw==
X-Gm-Message-State: AOJu0YzTHEUbaVCz2umYhQr8kvXQelgtdPuXW2MErVLPe/DsJU66E+hR
 zHtT2eAYh3OAorJmbk3KCJClsQ==
X-Google-Smtp-Source: AGHT+IGcbTFb77CuiKkLIjqqPxob/x1khnaRcgAOv2hex+7qHL009tlmQyXHrjsWueAHb2gYMX08Ow==
X-Received: by 2002:a2e:8887:0:b0:2bf:7dac:a51 with SMTP id
 k7-20020a2e8887000000b002bf7dac0a51mr2259867lji.51.1694797081077; 
 Fri, 15 Sep 2023 09:58:01 -0700 (PDT)
Received: from [192.168.69.115]
 (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr. [176.171.209.234])
 by smtp.gmail.com with ESMTPSA id
 l21-20020a1709061c5500b009ad89697c86sm2657005ejg.144.2023.09.15.09.58.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 09:58:00 -0700 (PDT)
Message-ID: <fc6589b5-afc7-8fd1-a53b-ca600ab03100@linaro.org>
Date: Fri, 15 Sep 2023 18:57:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/3] softmmu: Introduce cpu_address_space_sync
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230915163254.123338-1-richard.henderson@linaro.org>
 <20230915163254.123338-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230915163254.123338-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 15/9/23 18:32, Richard Henderson wrote:
> Synchronously check and update the address space for the
> current cpu for any slow path access.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1866
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/memory.h |  6 ++++++
>   accel/tcg/cputlb.c    |  2 ++
>   softmmu/physmem.c     | 20 ++++++++++++++++++++
>   3 files changed, 28 insertions(+)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 68284428f8..7ec842076f 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -2780,6 +2780,12 @@ void address_space_cache_destroy(MemoryRegionCache *cache);
>   IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr addr,
>                                               bool is_write, MemTxAttrs attrs);
>   
> +/*
> + * Ensure all cpu address spaces are up-to-date.
> + * Return true if changes made and tlb flushed.

No return value, stale comment?

> + */
> +void cpu_address_space_sync(CPUState *cpu);
> +
>   /* address_space_translate: translate an address range into an address space
>    * into a MemoryRegion and an address range into that section.  Should be
>    * called from an RCU critical section, to avoid that the last reference
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 3270f65c20..91be3f3064 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1827,6 +1827,8 @@ static bool mmu_lookup(CPUArchState *env, vaddr addr, MemOpIdx oi,
>       l->page[1].size = 0;
>       crosspage = (addr ^ l->page[1].addr) & TARGET_PAGE_MASK;
>   
> +    cpu_address_space_sync(env_cpu(env));
> +
>       if (likely(!crosspage)) {
>           mmu_lookup1(env, &l->page[0], l->mmu_idx, type, ra);
>   
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index e1c535380a..5a89caa257 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -2536,6 +2536,26 @@ static void tcg_commit(MemoryListener *listener)
>       }
>   }
>   
> +void cpu_address_space_sync(CPUState *cpu)
> +{
> +    int i, n = cpu->num_ases;
> +    bool need_flush = false;
> +
> +    for (i = 0; i < n; ++i) {
> +        CPUAddressSpace *cpuas = &cpu->cpu_ases[i];
> +        uint32_t gen = qatomic_load_acquire(&cpuas->layout_gen);
> +
> +        if (cpuas->commit_gen != gen) {
> +            cpuas->commit_gen = gen;
> +            cpuas->memory_dispatch = address_space_to_dispatch(cpuas->as);
> +            need_flush = true;
> +        }
> +    }
> +    if (need_flush) {
> +        tlb_flush(cpu);
> +    }
> +}
> +
>   static void memory_map_init(void)
>   {
>       system_memory = g_malloc(sizeof(*system_memory));


