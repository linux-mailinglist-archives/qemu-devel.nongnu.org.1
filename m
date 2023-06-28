Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1051D740C87
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 11:21:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qERLy-0003VD-LD; Wed, 28 Jun 2023 05:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qERLw-0003Uw-1e
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 05:20:44 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qERLu-00006I-Cp
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 05:20:43 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-312826ffedbso5986978f8f.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 02:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687944040; x=1690536040;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2s3vJmTXdDG1H0iNLlZaoGFKkCfZTT03Eb6+v+o6p88=;
 b=ZmktTxqBZC/ocv4v7J+JE3x8etXlvLo2K/2dqs5xhu43rU5oX8UNBQz7H0us/RqTsm
 r1RpsppXtaU+JY8yNmkmyAhsP/w0pju2jxaOA3Z9AUjh8pN1goXPfytcapeHSa7XbV3K
 piFPu3gKTcWbPNRKE8e+Fhst/GWsu1j+e5Cs718Lc8fm1DMTy1HazOcv8826Atbb0H99
 GlLC6prAyEXm777MAUAyUMtdHcxWpO5F1H+9Sqv+Aas5ZjNg7bPjYh/RjWn28VNt6QRu
 ZjkG74462/8lEihW31IwS4Eo2YLu4Ir12rzYXClNYAyDWqrx0dUNllOMjFCXJ4UL9UQN
 vBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687944040; x=1690536040;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2s3vJmTXdDG1H0iNLlZaoGFKkCfZTT03Eb6+v+o6p88=;
 b=gxnnVcyGiYJoLnsdJdzPFX1MGfhu+TT82ckkuHuPQeJ+6bDqGoBpdjigSWFQdYk/sC
 XK6MFIJPH9pFvQhvuPFf4P4fVZTuRCbraO8vd8aRsQ14aXoGtufh1B+V5IEzFsxgwBxU
 dc6GfzqL+Ca3Ak/uaa7yziKHBfmvgKi0T9T+xlMHO7akH5VGpqXPUpTE6AHhvXcZkuiT
 l8IyQLAQ1EIV2IuM9lVUTqSnqF6IccIK9LePmRM/QdOuyyoD/Q5h7O2SvI7wWdfTQIgI
 LeWy7V9KnUcFFG2WiVX3fzWxONLd1Kf3ooQqNq2m4ybgU8Ry/s+SfUUygTKPmBg20iA6
 x5+g==
X-Gm-Message-State: AC+VfDxNqG+n0PcOivqQ7ouRxfwGyccSMW65eyB1LAKBEHMs1cPQ8sZX
 vOIcR1LGe1NXfAYfdloI5LMq5A==
X-Google-Smtp-Source: ACHHUZ5COG9dSPw5gw3GQd73Mbzc2IfvgdOoByNhwli01ssyaDGu9InxHJGCdTtTUYeJnqnjnxCDFQ==
X-Received: by 2002:a05:6000:50a:b0:313:eeb3:c57a with SMTP id
 a10-20020a056000050a00b00313eeb3c57amr7077589wrf.15.1687944040557; 
 Wed, 28 Jun 2023 02:20:40 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 a10-20020adfdd0a000000b0030af15d7e41sm12990372wrm.4.2023.06.28.02.20.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 02:20:40 -0700 (PDT)
Message-ID: <78c9de7e-b2ca-fc2c-67e1-b06908de01cc@linaro.org>
Date: Wed, 28 Jun 2023 11:20:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 17/36] plugins: force slow path when plugins instrument
 memory ops
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
 <20230627160943.2956928-18-alex.bennee@linaro.org>
 <832d49b4-4d53-729e-c8aa-004a71bdf99f@linaro.org> <878rc4ymw3.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <878rc4ymw3.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 6/28/23 11:06, Alex Bennée wrote:
>> I thought we dropped this patch until we could do something with TLB
>> accesses.
> 
> I did suggest something like:
> 
> --8<---------------cut here---------------start------------->8---
> modified   include/hw/core/cpu.h
> @@ -80,10 +80,24 @@ DECLARE_CLASS_CHECKERS(CPUClass, CPU,
>       typedef struct ArchCPU CpuInstanceType; \
>       OBJECT_DECLARE_TYPE(ArchCPU, CpuClassType, CPU_MODULE_OBJ_NAME);
>   
> +/**
> + * typedef MMUAccessType - describe the type of access for cputlb
> + *
> + * When handling the access to memory we need to know the type of
> + * access we are doing. Loads and store rely on read and write page
> + * permissions where as the instruction fetch relies on execute
> + * permissions. Additional bits are used for TLB access so we can
> + * suppress instrumentation of memory when the CPU is probing.
> + */
>   typedef enum MMUAccessType {
>       MMU_DATA_LOAD  = 0,
>       MMU_DATA_STORE = 1,
> -    MMU_INST_FETCH = 2
> +    MMU_INST_FETCH = 2,
> +    /* MMU Mask */
> +    MMU_VALID_MASK = (MMU_DATA_LOAD | MMU_DATA_STORE | MMU_INST_FETCH),
> +    /* Represents the CPU walking the page table */
> +    MMU_TLB_ACCESS = 0x4,
> +    MMU_TLB_LOAD = MMU_DATA_LOAD | MMU_TLB_ACCESS
>   } MMUAccessType;
>   
>   typedef struct CPUWatchpoint CPUWatchpoint;
> modified   accel/tcg/cputlb.c
> @@ -1503,11 +1503,12 @@ static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
>   }
>   
>   static int probe_access_internal(CPUArchState *env, target_ulong addr,
> -                                 int fault_size, MMUAccessType access_type,
> +                                 int fault_size, MMUAccessType full_access_type,
>                                    int mmu_idx, bool nonfault,
>                                    void **phost, CPUTLBEntryFull **pfull,
>                                    uintptr_t retaddr)
>   {
> +    MMUAccessType access_type = full_access_type & MMU_VALID_MASK;
>       uintptr_t index = tlb_index(env, mmu_idx, addr);
>       CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
>       target_ulong tlb_addr = tlb_read_idx(entry, access_type);
> @@ -1546,7 +1547,9 @@ static int probe_access_internal(CPUArchState *env, target_ulong addr,
>       /* Fold all "mmio-like" bits into TLB_MMIO.  This is not RAM.  */
>       if (unlikely(flags & ~(TLB_WATCHPOINT | TLB_NOTDIRTY))
>           ||
> -        (access_type != MMU_INST_FETCH && cpu_plugin_mem_cbs_enabled(env_cpu(env)))) {
> +        (access_type != MMU_INST_FETCH &&
> +         !(full_access_type & MMU_TLB_ACCESS) &&
> +         cpu_plugin_mem_cbs_enabled(env_cpu(env)))) {
>           *phost = NULL;
>           return TLB_MMIO;
>       }
> --8<---------------cut here---------------end--------------->8---
> 
> and then we can apply MMU_TLB_LOAD as the type in the page walking code.
> I wanted to know if that was the sort of thing you where thinking off or
> if that is too ugly.

It's not implausible, but probably not ideal.

> The other option is a specific probe_access_* function for TLB type
> operations.

Or that, yes.

I'm confused that you'd simply re-include this patch as-is when it has known errors.


r~

