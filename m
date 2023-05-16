Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4C77045BE
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 09:03:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyohf-0005uY-J4; Tue, 16 May 2023 03:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1pyohb-0005u1-EE; Tue, 16 May 2023 03:02:31 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1pyohY-0002JY-CY; Tue, 16 May 2023 03:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sDZ9vxu2XAq7G2xadMysEcfgolzwbgDZrzpP3b+iCkw=; b=cuzNWUcGIvzCzkPX12khAdYdoE
 S4YmYiESKohHVKMzsXBMC1NCCtcrFfBFzh4BA0WxMti53qFZVjx0Hf8ldLjQ1r0FHarp2Bz1VgF+/
 rDHS1ZkN0vb3QK44mM0/RrIEJ9caZiLZ3KsbSth6zCSUyKcRmfE7gxESzbsFx9aZagvOg1feIDP5r
 5boi9q0gAepKY/sxIuWkvjmGEK8GKVS7oh2ce/jANyBZU9PGHuvuIXPNLuaVBWbaRdYVt6/5mSRIr
 twZhOL9wkmIkBo9wPFXLaRTFG0Mgs5y+9RVryNyxWFTvU4NxGByfrCDdo1SHTXTpMZe7g0Ndy+ojw
 VHI1hx8Ohvls7WQYlTMlWWr6mJPdDJ6u7KDr7V3F8tTzpWeCOm/FqzinDk6metulT+iYT7QJWbNZb
 U3FX41fF5rqkei6dOuCXGziR5WpSKwfdd5rrQr+4PxEgxY4zdWe5Wfa2ZCu2iHlqLZ7zPjVW3QLHS
 Umh5/ltCEpRaSaKrBuqAifjZR+tY/vJBWPBxgnQfh7wXhI3mYKcKoU5DgI/r4qMJkw1SM9DhvD2j9
 kTDWlf8LE6optlAqR9SI88RWfPPgiCF7lKa0lTJxCgnvYfGeQcZnMaZ2c+Rwx7CvAcDZsZKzp+WBd
 XTVFknlRRNnRUgH5DsWEJEv+jANGdFwtGwu2d8x30=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1pyogY-0009mH-JI; Tue, 16 May 2023 08:01:27 +0100
Message-ID: <aa23194e-04ca-1ec7-4e4c-d66b40c7358b@ilande.co.uk>
Date: Tue, 16 May 2023 08:02:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, sdicaro@DDCI.com
References: <20230515092655.171206-1-npiggin@gmail.com>
 <20230515092655.171206-2-npiggin@gmail.com>
 <4cefbbd6-6ab2-cd55-4468-4066b464c99c@ilande.co.uk>
 <CSMYAXLT8B9P.1D85SFBUZQ9ZC@wheely>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <CSMYAXLT8B9P.1D85SFBUZQ9ZC@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v3 1/9] target/ppc: Fix width of some 32-bit SPRs
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.811,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 15/05/2023 16:19, Nicholas Piggin wrote:

> On Mon May 15, 2023 at 10:03 PM AEST, Mark Cave-Ayland wrote:
>> On 15/05/2023 10:26, Nicholas Piggin wrote:
>>
>>> Some 32-bit SPRs are incorrectly implemented as 64-bits on 64-bit
>>> targets.
>>>
>>> This changes VRSAVE, DSISR, HDSISR, DAWRX0, PIDR, LPIDR, DEXCR,
>>> HDEXCR, CTRL, TSCR, MMCRH, and PMC[1-6] from to be 32-bit registers.
>>>
>>> This only goes by the 32/64 classification in the architecture, it
>>> does not try to implement finer details of SPR implementation (e.g.,
>>> not all bits implemented as simple read/write storage).
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>> Since v2: no change.
>>>
>>>    target/ppc/cpu_init.c    | 18 +++++++++---------
>>>    target/ppc/helper_regs.c |  2 +-
>>>    target/ppc/misc_helper.c |  4 ++--
>>>    target/ppc/power8-pmu.c  |  2 +-
>>>    target/ppc/translate.c   |  2 +-
>>>    5 files changed, 14 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
>>> index 0ce2e3c91d..5aa0b3f0f1 100644
>>> --- a/target/ppc/cpu_init.c
>>> +++ b/target/ppc/cpu_init.c
>>> @@ -5085,8 +5085,8 @@ static void register_book3s_altivec_sprs(CPUPPCState *env)
>>>        }
>>>    
>>>        spr_register_kvm(env, SPR_VRSAVE, "VRSAVE",
>>> -                     &spr_read_generic, &spr_write_generic,
>>> -                     &spr_read_generic, &spr_write_generic,
>>> +                     &spr_read_generic, &spr_write_generic32,
>>> +                     &spr_read_generic, &spr_write_generic32,
>>>                         KVM_REG_PPC_VRSAVE, 0x00000000);
>>>    
>>>    }
>>> @@ -5120,7 +5120,7 @@ static void register_book3s_207_dbg_sprs(CPUPPCState *env)
>>>        spr_register_kvm_hv(env, SPR_DAWRX0, "DAWRX0",
>>>                            SPR_NOACCESS, SPR_NOACCESS,
>>>                            SPR_NOACCESS, SPR_NOACCESS,
>>> -                        &spr_read_generic, &spr_write_generic,
>>> +                        &spr_read_generic, &spr_write_generic32,
>>>                            KVM_REG_PPC_DAWRX, 0x00000000);
>>>        spr_register_kvm_hv(env, SPR_CIABR, "CIABR",
>>>                            SPR_NOACCESS, SPR_NOACCESS,
>>> @@ -5376,7 +5376,7 @@ static void register_book3s_ids_sprs(CPUPPCState *env)
>>>        spr_register_hv(env, SPR_TSCR, "TSCR",
>>>                     SPR_NOACCESS, SPR_NOACCESS,
>>>                     SPR_NOACCESS, SPR_NOACCESS,
>>> -                 &spr_read_generic, &spr_write_generic,
>>> +                 &spr_read_generic, &spr_write_generic32,
>>>                     0x00000000);
>>>        spr_register_hv(env, SPR_HMER, "HMER",
>>>                     SPR_NOACCESS, SPR_NOACCESS,
>>> @@ -5406,7 +5406,7 @@ static void register_book3s_ids_sprs(CPUPPCState *env)
>>>        spr_register_hv(env, SPR_MMCRC, "MMCRC",
>>>                     SPR_NOACCESS, SPR_NOACCESS,
>>>                     SPR_NOACCESS, SPR_NOACCESS,
>>> -                 &spr_read_generic, &spr_write_generic,
>>> +                 &spr_read_generic, &spr_write_generic32,
>>>                     0x00000000);
>>>        spr_register_hv(env, SPR_MMCRH, "MMCRH",
>>>                     SPR_NOACCESS, SPR_NOACCESS,
>>> @@ -5441,7 +5441,7 @@ static void register_book3s_ids_sprs(CPUPPCState *env)
>>>        spr_register_hv(env, SPR_HDSISR, "HDSISR",
>>>                     SPR_NOACCESS, SPR_NOACCESS,
>>>                     SPR_NOACCESS, SPR_NOACCESS,
>>> -                 &spr_read_generic, &spr_write_generic,
>>> +                 &spr_read_generic, &spr_write_generic32,
>>>                     0x00000000);
>>>        spr_register_hv(env, SPR_HRMOR, "HRMOR",
>>>                     SPR_NOACCESS, SPR_NOACCESS,
>>> @@ -5665,7 +5665,7 @@ static void register_power7_book4_sprs(CPUPPCState *env)
>>>                         KVM_REG_PPC_ACOP, 0);
>>>        spr_register_kvm(env, SPR_BOOKS_PID, "PID",
>>>                         SPR_NOACCESS, SPR_NOACCESS,
>>> -                     &spr_read_generic, &spr_write_generic,
>>> +                     &spr_read_generic, &spr_write_generic32,
>>>                         KVM_REG_PPC_PID, 0);
>>>    #endif
>>>    }
>>> @@ -5730,7 +5730,7 @@ static void register_power10_dexcr_sprs(CPUPPCState *env)
>>>    {
>>>        spr_register(env, SPR_DEXCR, "DEXCR",
>>>                SPR_NOACCESS, SPR_NOACCESS,
>>> -            &spr_read_generic, &spr_write_generic,
>>> +            &spr_read_generic, &spr_write_generic32,
>>>                0);
>>>    
>>>        spr_register(env, SPR_UDEXCR, "DEXCR",
>>> @@ -5741,7 +5741,7 @@ static void register_power10_dexcr_sprs(CPUPPCState *env)
>>>        spr_register_hv(env, SPR_HDEXCR, "HDEXCR",
>>>                SPR_NOACCESS, SPR_NOACCESS,
>>>                SPR_NOACCESS, SPR_NOACCESS,
>>> -            &spr_read_generic, &spr_write_generic,
>>> +            &spr_read_generic, &spr_write_generic32,
>>>                0);
>>>    
>>>        spr_register(env, SPR_UHDEXCR, "HDEXCR",
>>> diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
>>> index 779e7db513..fb351c303f 100644
>>> --- a/target/ppc/helper_regs.c
>>> +++ b/target/ppc/helper_regs.c
>>> @@ -448,7 +448,7 @@ void register_non_embedded_sprs(CPUPPCState *env)
>>>        /* Exception processing */
>>>        spr_register_kvm(env, SPR_DSISR, "DSISR",
>>>                         SPR_NOACCESS, SPR_NOACCESS,
>>> -                     &spr_read_generic, &spr_write_generic,
>>> +                     &spr_read_generic, &spr_write_generic32,
>>>                         KVM_REG_PPC_DSISR, 0x00000000);
>>>        spr_register_kvm(env, SPR_DAR, "DAR",
>>>                         SPR_NOACCESS, SPR_NOACCESS,
>>> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
>>> index a9bc1522e2..40ddc5c08c 100644
>>> --- a/target/ppc/misc_helper.c
>>> +++ b/target/ppc/misc_helper.c
>>> @@ -190,13 +190,13 @@ void helper_store_dpdes(CPUPPCState *env, target_ulong val)
>>>    
>>>    void helper_store_pidr(CPUPPCState *env, target_ulong val)
>>>    {
>>> -    env->spr[SPR_BOOKS_PID] = val;
>>> +    env->spr[SPR_BOOKS_PID] = (uint32_t)val;
>>>        tlb_flush(env_cpu(env));
>>>    }
>>>    
>>>    void helper_store_lpidr(CPUPPCState *env, target_ulong val)
>>>    {
>>> -    env->spr[SPR_LPIDR] = val;
>>> +    env->spr[SPR_LPIDR] = (uint32_t)val;
>>>    
>>>        /*
>>>         * We need to flush the TLB on LPID changes as we only tag HV vs
>>> diff --git a/target/ppc/power8-pmu.c b/target/ppc/power8-pmu.c
>>> index 1381072b9e..64a64865d7 100644
>>> --- a/target/ppc/power8-pmu.c
>>> +++ b/target/ppc/power8-pmu.c
>>> @@ -272,7 +272,7 @@ void helper_store_pmc(CPUPPCState *env, uint32_t sprn, uint64_t value)
>>>    {
>>>        pmu_update_cycles(env);
>>>    
>>> -    env->spr[sprn] = value;
>>> +    env->spr[sprn] = (uint32_t)value;
>>>    
>>>        pmc_update_overflow_timer(env, sprn);
>>>    }
>>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>>> index f603f1a939..c03a6bdc9a 100644
>>> --- a/target/ppc/translate.c
>>> +++ b/target/ppc/translate.c
>>> @@ -413,7 +413,7 @@ void spr_write_generic(DisasContext *ctx, int sprn, int gprn)
>>>    
>>>    void spr_write_CTRL(DisasContext *ctx, int sprn, int gprn)
>>>    {
>>> -    spr_write_generic(ctx, sprn, gprn);
>>> +    spr_write_generic32(ctx, sprn, gprn);
>>>    
>>>        /*
>>>         * SPR_CTRL writes must force a new translation block,
>>
>> Just out of curiosity, is this the same as the problem described at [1] for DECAR?
>>
>>
>> ATB,
>>
>> Mark.
>>
>> [1] https://lists.nongnu.org/archive/html/qemu-ppc/2023-03/msg00451.html
> 
> Oh if it's a 64-bit target running in 32-bit mode, then the compiled
> code might use something like li reg,-1 to set the 0xffffffff value,
> but that gets sign extended to 64-bits. Storing that to DECAR then
> does cause it to get stored to DECR. So DECAR should use
> spr_write_generic32.
> 
> But all the store_decr calculations are unsigned and DECR gets clamped
> to 32-bits, at least when reading it back. The problem seems to be the
> timer ends up getting set for a negative expire time.
> 
> So storing to DECR directly seems like it would have the same problems
> as via DECAR. This should help.
> 
> Thanks,
> Nick
> ---
> 
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index 4e816c68c7..35a1410c4d 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -794,14 +794,18 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
>       CPUPPCState *env = &cpu->env;
>       ppc_tb_t *tb_env = env->tb_env;
>       uint64_t now, next;
> +    uint64_t unsigned_value;
> +    uint64_t unsigned_decr;
>       int64_t signed_value;
>       int64_t signed_decr;
>   
>       /* Truncate value to decr_width and sign extend for simplicity */
> +    unsigned_value = extract64(value, 0, nr_bits);
> +    unsigned_decr = extract64(decr, 0, nr_bits);
>       signed_value = sextract64(value, 0, nr_bits);
>       signed_decr = sextract64(decr, 0, nr_bits);
>   
> -    trace_ppc_decr_store(nr_bits, decr, value);
> +    trace_ppc_decr_store(nr_bits, unsigned_decr, unsigned_value);
>   
>       if (kvm_enabled()) {
>           /* KVM handles decrementer exceptions, we don't need our own timer */
> @@ -821,7 +825,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
>        * On MSB edge based DEC implementations the MSB going from 0 -> 1 triggers
>        * an edge interrupt, so raise it here too.
>        */
> -    if ((value < 3) ||
> +    if ((unsigned_value < 3) ||
>           ((tb_env->flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
>           ((tb_env->flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
>             && signed_decr >= 0)) {
> @@ -836,7 +840,8 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
>   
>       /* Calculate the next timer event */
>       now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -    next = now + muldiv64(value, NANOSECONDS_PER_SECOND, tb_env->decr_freq);
> +    next = now + muldiv64(unsigned_value, NANOSECONDS_PER_SECOND,
> +                          tb_env->decr_freq);
>       *nextp = next;
>   
>       /* Adjust timer */

Thanks Nick! I've added the original reporter on CC to see if they can provide 
testing and feedback.


ATB,

Mark.


