Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D34F67322F6
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 01:03:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9vza-0001f2-8f; Thu, 15 Jun 2023 19:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9vzX-0001eJ-Kw; Thu, 15 Jun 2023 19:02:59 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9vzV-0007fz-NM; Thu, 15 Jun 2023 19:02:59 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id D79D1748A5A;
 Fri, 16 Jun 2023 01:02:50 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A0425748A59; Fri, 16 Jun 2023 01:02:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9F172748A5C;
 Fri, 16 Jun 2023 01:02:50 +0200 (CEST)
Date: Fri, 16 Jun 2023 01:02:50 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, 
 Greg Kurz <groug@kaod.org>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 08/10] target/ppc: Fix gen_sc to use correct nip
In-Reply-To: <CTCUCTKOWUT6.111CRYUYBN9HO@wheely>
Message-ID: <06635f48-effe-9c2c-c477-4b565b2493ab@eik.bme.hu>
References: <cover.1686522199.git.balaton@eik.bme.hu>
 <7ae167986e18144bc665bbdd836b49fe723a90a1.1686522199.git.balaton@eik.bme.hu>
 <CTC2DN50X8A2.2UVS9YQ2HNYJ9@wheely>
 <da6086be-ccd8-7cbf-8fbe-e4924d9c230f@eik.bme.hu>
 <CTCUCTKOWUT6.111CRYUYBN9HO@wheely>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 15 Jun 2023, Nicholas Piggin wrote:
> On Thu Jun 15, 2023 at 7:27 AM AEST, BALATON Zoltan wrote:
>> On Wed, 14 Jun 2023, Nicholas Piggin wrote:
>>> On Mon Jun 12, 2023 at 8:42 AM AEST, BALATON Zoltan wrote:
>>>> Most exceptions are raised with nip pointing to the faulting
>>>> instruction but the sc instruction generating a syscall exception
>>>> leaves nip pointing to next instruction. Fix gen_sc to not use
>>>> gen_exception_err() which sets nip back but correctly set nip to
>>>> pc_next so we don't have to patch this in the exception handlers.
>>>>
>>>> This changes the nip logged in dump_syscall and dump_hcall debug
>>>> functions but now this matches how nip would be on a real CPU.
>>>>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>> ---
>>>>  target/ppc/excp_helper.c | 39 ---------------------------------------
>>>>  target/ppc/translate.c   |  8 +++++---
>>>>  2 files changed, 5 insertions(+), 42 deletions(-)
>>>>
>>>> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
>>>> index 885e479301..4f6a6dfb19 100644
>>>> --- a/target/ppc/excp_helper.c
>>>> +++ b/target/ppc/excp_helper.c
>>>> @@ -493,12 +493,6 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
>>>>          break;
>>>>      case POWERPC_EXCP_SYSCALL:   /* System call exception                    */
>>>>          dump_syscall(env);
>>>> -
>>>> -        /*
>>>> -         * We need to correct the NIP which in this case is supposed
>>>> -         * to point to the next instruction
>>>> -         */
>>>> -        env->nip += 4;
>>>>          break;
>>>>      case POWERPC_EXCP_FIT:       /* Fixed-interval timer interrupt           */
>>>>          trace_ppc_excp_print("FIT");
>>>> @@ -609,12 +603,6 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
>>>>          break;
>>>>      case POWERPC_EXCP_SYSCALL:   /* System call exception                    */
>>>>          dump_syscall(env);
>>>> -
>>>> -        /*
>>>> -         * We need to correct the NIP which in this case is supposed
>>>> -         * to point to the next instruction
>>>> -         */
>>>> -        env->nip += 4;
>>>>          break;
>>>>      case POWERPC_EXCP_FPU:       /* Floating-point unavailable exception     */
>>>>      case POWERPC_EXCP_DECR:      /* Decrementer exception                    */
>>>> @@ -757,13 +745,6 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
>>>>          } else {
>>>>              dump_syscall(env);
>>>>          }
>>>> -
>>>> -        /*
>>>> -         * We need to correct the NIP which in this case is supposed
>>>> -         * to point to the next instruction
>>>> -         */
>>>> -        env->nip += 4;
>>>> -
>>>>          /*
>>>>           * The Virtual Open Firmware (VOF) relies on the 'sc 1'
>>>>           * instruction to communicate with QEMU. The pegasos2 machine
>>>> @@ -908,13 +889,6 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
>>>>          } else {
>>>>              dump_syscall(env);
>>>>          }
>>>> -
>>>> -        /*
>>>> -         * We need to correct the NIP which in this case is supposed
>>>> -         * to point to the next instruction
>>>> -         */
>>>> -        env->nip += 4;
>>>> -
>>>>          /*
>>>>           * The Virtual Open Firmware (VOF) relies on the 'sc 1'
>>>>           * instruction to communicate with QEMU. The pegasos2 machine
>>>> @@ -1073,12 +1047,6 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
>>>>          break;
>>>>      case POWERPC_EXCP_SYSCALL:   /* System call exception                    */
>>>>          dump_syscall(env);
>>>> -
>>>> -        /*
>>>> -         * We need to correct the NIP which in this case is supposed
>>>> -         * to point to the next instruction
>>>> -         */
>>>> -        env->nip += 4;
>>>>          break;
>>>>      case POWERPC_EXCP_FPU:       /* Floating-point unavailable exception     */
>>>>      case POWERPC_EXCP_APU:       /* Auxiliary processor unavailable          */
>>>> @@ -1320,13 +1288,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>>>>          } else {
>>>>              dump_syscall(env);
>>>>          }
>>>> -
>>>> -        /*
>>>> -         * We need to correct the NIP which in this case is supposed
>>>> -         * to point to the next instruction
>>>> -         */
>>>> -        env->nip += 4;
>>>> -
>>>>          /* "PAPR mode" built-in hypercall emulation */
>>>>          if (lev == 1 && books_vhyp_handles_hcall(cpu)) {
>>>>              PPCVirtualHypervisorClass *vhc =
>>>> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
>>>> index a32a9b8a5f..4260d3d66f 100644
>>>> --- a/target/ppc/translate.c
>>>> +++ b/target/ppc/translate.c
>>>> @@ -4419,10 +4419,12 @@ static void gen_hrfid(DisasContext *ctx)
>>>>  #endif
>>>>  static void gen_sc(DisasContext *ctx)
>>>>  {
>>>> -    uint32_t lev;
>>>> +    uint32_t lev = (ctx->opcode >> 5) & 0x7F;
>>>>
>>>> -    lev = (ctx->opcode >> 5) & 0x7F;
>>>> -    gen_exception_err(ctx, POWERPC_SYSCALL, lev);
>>>> +    gen_update_nip(ctx, ctx->base.pc_next);
>>>> +    gen_helper_raise_exception_err(cpu_env, tcg_constant_i32(POWERPC_SYSCALL),
>>>> +                                   tcg_constant_i32(lev));
>>>> +    ctx->base.is_jmp = DISAS_NORETURN;
>>>
>>> Generally for blame and bisect I don't like to mix cleanup with real
>>> change, I guess this is pretty minor though.
>>>
>>> Great cleanup though, sc is certainly defined to set SRR0 to the
>>> instruction past the sc unlike other interrupts so it is more natural
>>> and less hacky feeling do it like this.
>>>
>>> Could you do scv while you are here? It has the same semantics as
>>> sc.
>>
>> I've tried but scv seems to be a bit different as it can sometimes raise
>> POWERPC_EXCP_FU instead of POWERPC_EXCP_SYSCALL_VECTORED according to
>> excp_helper.c::helper_scv() which may need the nip to be different so I'd
>> rather leave this to somebody who knows what they are doing.
>
> Yes and the fscr check requires a helper so no point doing that
> twice, but I think it would still better match the new sc code to
> have something like this (patch is tested, you can squash it in
> yours if you like):
>
> Thanks,
> Nick
> ---
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 12d8a7257b..55c6edfacb 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1507,7 +1507,6 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>     case POWERPC_EXCP_SYSCALL_VECTORED: /* scv exception                     */
>         lev = env->error_code;
>         dump_syscall(env);
> -        env->nip += 4;
>         new_msr |= env->msr & ((target_ulong)1 << MSR_EE);
>         new_msr |= env->msr & ((target_ulong)1 << MSR_RI);
>
> @@ -2623,6 +2622,7 @@ void helper_ppc_maybe_interrupt(CPUPPCState *env)
> void helper_scv(CPUPPCState *env, uint32_t lev)
> {
>     if (env->spr[SPR_FSCR] & (1ull << FSCR_SCV)) {
> +        env->nip += 4;
>         raise_exception_err(env, POWERPC_EXCP_SYSCALL_VECTORED, lev);
>     } else {
>         raise_exception_err(env, POWERPC_EXCP_FU, FSCR_IC_SCV);
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index b591f2e496..90d07a3e56 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4432,7 +4432,11 @@ static void gen_scv(DisasContext *ctx)
> {
>     uint32_t lev = (ctx->opcode >> 5) & 0x7F;
>
> -    /* Set the PC back to the faulting instruction. */
> +    /*
> +     * Set the PC back to the scv instruction (unlike sc), because a facility
> +     * unavailable interrupt must be generated if FSCR[SCV]=0. The helper
> +     * advances nip if the FSCR check passes.
> +     */
>     gen_update_nip(ctx, ctx->cia);
>     gen_helper_scv(cpu_env, tcg_constant_i32(lev));

I've added this to v3 but needs and SoB from you.

Regards,
BALATON Zoltan

