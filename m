Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96332826569
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 18:57:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMXNU-0006Ri-3h; Sun, 07 Jan 2024 12:56:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rMXNP-0006PM-K7; Sun, 07 Jan 2024 12:55:59 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rMXNN-0002QI-6R; Sun, 07 Jan 2024 12:55:59 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EF8864E60FF;
 Sun,  7 Jan 2024 18:55:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id FTnbWirZ_zr3; Sun,  7 Jan 2024 18:55:51 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0BD4C4E6004; Sun,  7 Jan 2024 18:55:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 09DE174577C;
 Sun,  7 Jan 2024 18:55:51 +0100 (CET)
Date: Sun, 7 Jan 2024 18:55:51 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] target/ppc: Fix crash on machine check caused by
 ifetch
In-Reply-To: <20240107170559.82383-1-npiggin@gmail.com>
Message-ID: <e3273c7b-eb15-c0ed-bdc7-451cbf181da0@eik.bme.hu>
References: <20240107170559.82383-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

On Mon, 8 Jan 2024, Nicholas Piggin wrote:
> is_prefix_insn_excp() loads the first word of the instruction address
> which caused an exception, to determine whether or not it was prefixed
> so the prefix bit can be set in [H]SRR1.
>
> In case it was the instruction fetch itself that caused the exception,
> the [H]SRR1 prefix bit is not required to be set, because it is not the
> instruction itself that causes the interrupt. If the load is attempted,
> t could cause a recursive exception.

Missing 'i' in "it" above. Is the long stack trace really needed to make a 
point here? I don't much care about what's in the commit message, I've 
seen full scientific articles posted there sometimes but this one seems a 
bit extreme without adding much info on the issue.

Regards,
BALATON Zoltan

> Instruction storage interrupts, HDSIs caused by ifetch are excluded from
> the prefix check. Machine checks caused by ifetch are not, and these
> can cause bugs. For example fetching from an unmapped physical address
> can result in:
>
>  ERROR:../system/cpus.c:504:qemu_mutex_lock_iothread_impl:
>      assertion failed: (!qemu_mutex_iothread_locked())
>  #0  __pthread_kill_implementation
>      (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0)
>      at ./nptl/pthread_kill.c:44
>  #1  0x00007ffff705a15f in __pthread_kill_internal
>      (signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:78
>  #2  0x00007ffff700c472 in __GI_raise (sig=sig@entry=6)
>      at ../sysdeps/posix/raise.c:26
>  #3  0x00007ffff6ff64b2 in __GI_abort () at ./stdlib/abort.c:79
>  #4  0x00007ffff73def08 in  () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
>  #5  0x00007ffff7445e4e in g_assertion_message_expr ()
>      at /lib/x86_64-linux-gnu/libglib-2.0.so.0
>  #6  0x0000555555a833f1 in qemu_mutex_lock_iothread_impl
>      (file=0x555555efda6e "../accel/tcg/cputlb.c", line=2033)
>      at ../system/cpus.c:504
>  #7  qemu_mutex_lock_iothread_impl
>      (file=file@entry=0x555555efda6e "../accel/tcg/cputlb.c", line=line@entry=2033) at ../system/cpus.c:500
>  #8  0x0000555555cbf786 in do_ld_mmio_beN
>      (cpu=cpu@entry=0x555556b72010, full=0x7fff5408e010, ret_be=ret_be@entry=0, addr=2310065133864353792, size=size@entry=4, mmu_idx=7, type=MMU_INST_FETCH, ra=0) at ../accel/tcg/cputlb.c:2033
>  #9  0x0000555555cc2ec6 in do_ld_4
>      (ra=0, memop=MO_BEUL, type=MMU_INST_FETCH, mmu_idx=<optimized out>, p=0x7fff67dfc660, cpu=0x555556b72010) at ../accel/tcg/cputlb.c:2336
>  #10 do_ld4_mmu
>      (cpu=cpu@entry=0x555556b72010, addr=<optimized out>, oi=<optimized out>, ra=ra@entry=0, access_type=access_type@entry=MMU_INST_FETCH)
>      at ../accel/tcg/cputlb.c:2418
>  #11 0x0000555555ccbaf6 in cpu_ldl_code
>      (env=env@entry=0x555556b747d0, addr=<optimized out>)
>      at ../accel/tcg/cputlb.c:2975
>  #12 0x0000555555b7a47c in ppc_ldl_code
>      (addr=<optimized out>, env=0x555556b747d0)
>      at ../target/ppc/excp_helper.c:147
>  #13 is_prefix_insn_excp (excp=1, cpu=0x555556b72010)
>      at ../target/ppc/excp_helper.c:1350
>  #14 powerpc_excp_books (excp=1, cpu=0x555556b72010)
>      at ../target/ppc/excp_helper.c:1415
>  #15 powerpc_excp (cpu=0x555556b72010, excp=<optimized out>)
>      at ../target/ppc/excp_helper.c:1733
>  #16 0x0000555555cb1c74 in cpu_handle_exception
>      (ret=<synthetic pointer>, cpu=<optimized out>)
>
> Fix this by excluding machine checks caused by ifetch from the prefix
> check.
>
> Fixes: 55a7fa34f89 ("target/ppc: Machine check on invalid real address access on POWER9/10")
> Fixes: 5a5d3b23cb2 ("target/ppc: Add SRR1 prefix indication to interrupt handlers")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> target/ppc/excp_helper.c | 32 +++++++++++++++++++++-----------
> 1 file changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index a42743a3e0..34c307b572 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -1322,6 +1322,15 @@ static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
>     }
>
>     switch (excp) {
> +    case POWERPC_EXCP_MCHECK:
> +        if (!(env->error_code & PPC_BIT(42))) {
> +            /*
> +             * Fetch attempt caused a machine check, so attempting to fetch
> +             * again would cause a recursive machine check.
> +             */
> +            return false;
> +        }
> +        break;
>     case POWERPC_EXCP_HDSI:
>         /* HDSI PRTABLE_FAULT has the originating access type in error_code */
>         if ((env->spr[SPR_HDSISR] & DSISR_PRTABLE_FAULT) &&
> @@ -1332,10 +1341,10 @@ static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
>              * instruction at NIP would cause recursive faults with the same
>              * translation).
>              */
> -            break;
> +            return false;
>         }
> -        /* fall through */
> -    case POWERPC_EXCP_MCHECK:
> +        break;
> +
>     case POWERPC_EXCP_DSI:
>     case POWERPC_EXCP_DSEG:
>     case POWERPC_EXCP_ALIGN:
> @@ -1346,17 +1355,14 @@ static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
>     case POWERPC_EXCP_VPU:
>     case POWERPC_EXCP_VSXU:
>     case POWERPC_EXCP_FU:
> -    case POWERPC_EXCP_HV_FU: {
> -        uint32_t insn = ppc_ldl_code(env, env->nip);
> -        if (is_prefix_insn(env, insn)) {
> -            return true;
> -        }
> +    case POWERPC_EXCP_HV_FU:
>         break;
> -    }
>     default:
> -        break;
> +        return false;
>     }
> -    return false;
> +
> +
> +    return is_prefix_insn(env, ppc_ldl_code(env, env->nip));
> }
> #else
> static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
> @@ -3245,6 +3251,10 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
>             env->error_code |= PPC_BIT(42);
>
>         } else { /* Fetch */
> +            /*
> +             * is_prefix_insn_excp() tests !PPC_BIT(42) to avoid fetching
> +             * the instruction, so that must always be clear for fetches.
> +             */
>             env->error_code = PPC_BIT(36) | PPC_BIT(44) | PPC_BIT(45);
>         }
>         break;
>

