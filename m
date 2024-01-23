Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BAE6838CAB
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 11:56:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSERB-0004IH-S7; Tue, 23 Jan 2024 05:55:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9HdW=JB=kaod.org=clg@ozlabs.org>)
 id 1rSER5-0004Hz-GZ; Tue, 23 Jan 2024 05:55:19 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9HdW=JB=kaod.org=clg@ozlabs.org>)
 id 1rSER2-0001nA-JS; Tue, 23 Jan 2024 05:55:19 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TK3rs3nVBz4wdC;
 Tue, 23 Jan 2024 21:55:09 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TK3rq4KhJz4wbv;
 Tue, 23 Jan 2024 21:55:07 +1100 (AEDT)
Message-ID: <b9b198ca-6949-491f-a7aa-d8d6827a5905@kaod.org>
Date: Tue, 23 Jan 2024 11:55:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/ppc: Fix crash on machine check caused by ifetch
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
References: <20240107170559.82383-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240107170559.82383-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=9HdW=JB=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 1/7/24 18:05, Nicholas Piggin wrote:
> is_prefix_insn_excp() loads the first word of the instruction address
> which caused an exception, to determine whether or not it was prefixed
> so the prefix bit can be set in [H]SRR1.
> 
> In case it was the instruction fetch itself that caused the exception,
> the [H]SRR1 prefix bit is not required to be set, because it is not the
> instruction itself that causes the interrupt. If the load is attempted,
> t could cause a recursive exception.
> 
> Instruction storage interrupts, HDSIs caused by ifetch are excluded from
> the prefix check. Machine checks caused by ifetch are not, and these
> can cause bugs. For example fetching from an unmapped physical address
> can result in:
> 
>    ERROR:../system/cpus.c:504:qemu_mutex_lock_iothread_impl:
>        assertion failed: (!qemu_mutex_iothread_locked())
>    #0  __pthread_kill_implementation
>        (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0)
>        at ./nptl/pthread_kill.c:44
>    #1  0x00007ffff705a15f in __pthread_kill_internal
>        (signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:78
>    #2  0x00007ffff700c472 in __GI_raise (sig=sig@entry=6)
>        at ../sysdeps/posix/raise.c:26
>    #3  0x00007ffff6ff64b2 in __GI_abort () at ./stdlib/abort.c:79
>    #4  0x00007ffff73def08 in  () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
>    #5  0x00007ffff7445e4e in g_assertion_message_expr ()
>        at /lib/x86_64-linux-gnu/libglib-2.0.so.0
>    #6  0x0000555555a833f1 in qemu_mutex_lock_iothread_impl
>        (file=0x555555efda6e "../accel/tcg/cputlb.c", line=2033)
>        at ../system/cpus.c:504
>    #7  qemu_mutex_lock_iothread_impl
>        (file=file@entry=0x555555efda6e "../accel/tcg/cputlb.c", line=line@entry=2033) at ../system/cpus.c:500
>    #8  0x0000555555cbf786 in do_ld_mmio_beN
>        (cpu=cpu@entry=0x555556b72010, full=0x7fff5408e010, ret_be=ret_be@entry=0, addr=2310065133864353792, size=size@entry=4, mmu_idx=7, type=MMU_INST_FETCH, ra=0) at ../accel/tcg/cputlb.c:2033
>    #9  0x0000555555cc2ec6 in do_ld_4
>        (ra=0, memop=MO_BEUL, type=MMU_INST_FETCH, mmu_idx=<optimized out>, p=0x7fff67dfc660, cpu=0x555556b72010) at ../accel/tcg/cputlb.c:2336
>    #10 do_ld4_mmu
>        (cpu=cpu@entry=0x555556b72010, addr=<optimized out>, oi=<optimized out>, ra=ra@entry=0, access_type=access_type@entry=MMU_INST_FETCH)
>        at ../accel/tcg/cputlb.c:2418
>    #11 0x0000555555ccbaf6 in cpu_ldl_code
>        (env=env@entry=0x555556b747d0, addr=<optimized out>)
>        at ../accel/tcg/cputlb.c:2975
>    #12 0x0000555555b7a47c in ppc_ldl_code
>        (addr=<optimized out>, env=0x555556b747d0)
>        at ../target/ppc/excp_helper.c:147
>    #13 is_prefix_insn_excp (excp=1, cpu=0x555556b72010)
>        at ../target/ppc/excp_helper.c:1350
>    #14 powerpc_excp_books (excp=1, cpu=0x555556b72010)
>        at ../target/ppc/excp_helper.c:1415
>    #15 powerpc_excp (cpu=0x555556b72010, excp=<optimized out>)
>        at ../target/ppc/excp_helper.c:1733
>    #16 0x0000555555cb1c74 in cpu_handle_exception
>        (ret=<synthetic pointer>, cpu=<optimized out>)
> 
> Fix this by excluding machine checks caused by ifetch from the prefix
> check.
> 
> Fixes: 55a7fa34f89 ("target/ppc: Machine check on invalid real address access on POWER9/10")
> Fixes: 5a5d3b23cb2 ("target/ppc: Add SRR1 prefix indication to interrupt handlers")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Ack-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   target/ppc/excp_helper.c | 32 +++++++++++++++++++++-----------
>   1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index a42743a3e0..34c307b572 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1322,6 +1322,15 @@ static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
>       }
>   
>       switch (excp) {
> +    case POWERPC_EXCP_MCHECK:
> +        if (!(env->error_code & PPC_BIT(42))) {
> +            /*
> +             * Fetch attempt caused a machine check, so attempting to fetch
> +             * again would cause a recursive machine check.
> +             */
> +            return false;
> +        }
> +        break;
>       case POWERPC_EXCP_HDSI:
>           /* HDSI PRTABLE_FAULT has the originating access type in error_code */
>           if ((env->spr[SPR_HDSISR] & DSISR_PRTABLE_FAULT) &&
> @@ -1332,10 +1341,10 @@ static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
>                * instruction at NIP would cause recursive faults with the same
>                * translation).
>                */
> -            break;
> +            return false;
>           }
> -        /* fall through */
> -    case POWERPC_EXCP_MCHECK:
> +        break;
> +
>       case POWERPC_EXCP_DSI:
>       case POWERPC_EXCP_DSEG:
>       case POWERPC_EXCP_ALIGN:
> @@ -1346,17 +1355,14 @@ static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
>       case POWERPC_EXCP_VPU:
>       case POWERPC_EXCP_VSXU:
>       case POWERPC_EXCP_FU:
> -    case POWERPC_EXCP_HV_FU: {
> -        uint32_t insn = ppc_ldl_code(env, env->nip);
> -        if (is_prefix_insn(env, insn)) {
> -            return true;
> -        }
> +    case POWERPC_EXCP_HV_FU:
>           break;
> -    }
>       default:
> -        break;
> +        return false;
>       }
> -    return false;
> +
> +
> +    return is_prefix_insn(env, ppc_ldl_code(env, env->nip));
>   }
>   #else
>   static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
> @@ -3245,6 +3251,10 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
>               env->error_code |= PPC_BIT(42);
>   
>           } else { /* Fetch */
> +            /*
> +             * is_prefix_insn_excp() tests !PPC_BIT(42) to avoid fetching
> +             * the instruction, so that must always be clear for fetches.
> +             */
>               env->error_code = PPC_BIT(36) | PPC_BIT(44) | PPC_BIT(45);
>           }
>           break;


