Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9EA74025C
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 19:39:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qECeC-0006gs-2J; Tue, 27 Jun 2023 13:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qECe8-0006g8-2J; Tue, 27 Jun 2023 13:38:32 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qECe5-0003Ah-9P; Tue, 27 Jun 2023 13:38:31 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id CB5D474635C;
 Tue, 27 Jun 2023 19:38:11 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8D34E74633D; Tue, 27 Jun 2023 19:38:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8B769746335;
 Tue, 27 Jun 2023 19:38:11 +0200 (CEST)
Date: Tue, 27 Jun 2023 19:38:11 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v2 3/4] target/ppc: Make checkstop actually stop the system
In-Reply-To: <20230627134644.260663-4-npiggin@gmail.com>
Message-ID: <5b90ae62-f279-1d07-1098-39a4f450bb99@eik.bme.hu>
References: <20230627134644.260663-1-npiggin@gmail.com>
 <20230627134644.260663-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-Spam-Probability: 9%
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

On Tue, 27 Jun 2023, Nicholas Piggin wrote:
> checkstop state does not halt the system, interrupts continue to be
> serviced, and other CPUs run.
>
> Stop the machine with vm_stop(), and print a register dump too.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Since v1:
> - Fix loop exit so it stops on the attn instruction, rather than
>  after it.
>
> target/ppc/excp_helper.c | 34 ++++++++++++++++++++--------------
> 1 file changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 5beda973ce..28d8a9b212 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -19,6 +19,7 @@
> #include "qemu/osdep.h"
> #include "qemu/main-loop.h"
> #include "qemu/log.h"
> +#include "sysemu/runstate.h"
> #include "cpu.h"
> #include "exec/exec-all.h"
> #include "internal.h"
> @@ -186,19 +187,24 @@ static void ppc_excp_debug_sw_tlb(CPUPPCState *env, int excp)
>              env->error_code);
> }
>
> -static void powerpc_checkstop(CPUPPCState *env)
> +static void powerpc_checkstop(CPUPPCState *env, const char *reason)
> {
>     CPUState *cs = env_cpu(env);
>
> -    /* Machine check exception is not enabled. Enter checkstop state. */
> -    fprintf(stderr, "Machine check while not allowed. "
> -            "Entering checkstop state\n");
> +    vm_stop(RUN_STATE_GUEST_PANICKED);
> +
> +    fprintf(stderr, "Entering checkstop state: %s\n", reason);
> +    cpu_dump_state(cs, stderr, CPU_DUMP_FPU | CPU_DUMP_CCOP);
>     if (qemu_log_separate()) {
> -        qemu_log("Machine check while not allowed. "
> -                 "Entering checkstop state\n");
> +        FILE *logfile = qemu_log_trylock();
> +        if (logfile) {
> +            fprintf(logfile, "Entering checkstop state: %s\n", reason);

I don't think you should have fprintfs here. Is this remnants of debug 
code left here by mistake? The fprintf that was there before may also need 
to be converted to some qemI_log or error_report but I did not know what 
these are for and did not address that. But if you want to add more then 
it may need to be solved first.

> +            cpu_dump_state(cs, logfile, CPU_DUMP_FPU | CPU_DUMP_CCOP);
> +            qemu_log_unlock(logfile);
> +        }
>     }
> -    cs->halted = 1;
> -    cpu_interrupt_exittb(cs);
> +

Excess blank line?

> +    cpu_loop_exit_noexc(cs);
> }
>
> #if defined(TARGET_PPC64)
> @@ -483,7 +489,7 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
>         break;
>     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
>         if (!FIELD_EX64(env->msr, MSR, ME)) {
> -            powerpc_checkstop(env);
> +            powerpc_checkstop(env, "machine check with MSR[ME]=0");

If the message is always the same why pass it from here If the only other 
option not used yet would be MSR[ME]=1 then that could also be checked in 
the func so no need to pass the message. So is there any other possible 
reason here?

Regards,
BALATON Zoltan

>         }
>         /* machine check exceptions don't have ME set */
>         new_msr &= ~((target_ulong)1 << MSR_ME);
> @@ -602,7 +608,7 @@ static void powerpc_excp_6xx(PowerPCCPU *cpu, int excp)
>         break;
>     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
>         if (!FIELD_EX64(env->msr, MSR, ME)) {
> -            powerpc_checkstop(env);
> +            powerpc_checkstop(env, "machine check with MSR[ME]=0");
>         }
>         /* machine check exceptions don't have ME set */
>         new_msr &= ~((target_ulong)1 << MSR_ME);
> @@ -763,7 +769,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
>     switch (excp) {
>     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
>         if (!FIELD_EX64(env->msr, MSR, ME)) {
> -            powerpc_checkstop(env);
> +            powerpc_checkstop(env, "machine check with MSR[ME]=0");
>         }
>         /* machine check exceptions don't have ME set */
>         new_msr &= ~((target_ulong)1 << MSR_ME);
> @@ -936,7 +942,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
>     switch (excp) {
>     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
>         if (!FIELD_EX64(env->msr, MSR, ME)) {
> -            powerpc_checkstop(env);
> +            powerpc_checkstop(env, "machine check with MSR[ME]=0");
>         }
>         /* machine check exceptions don't have ME set */
>         new_msr &= ~((target_ulong)1 << MSR_ME);
> @@ -1119,7 +1125,7 @@ static void powerpc_excp_booke(PowerPCCPU *cpu, int excp)
>         break;
>     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
>         if (!FIELD_EX64(env->msr, MSR, ME)) {
> -            powerpc_checkstop(env);
> +            powerpc_checkstop(env, "machine check with MSR[ME]=0");
>         }
>         /* machine check exceptions don't have ME set */
>         new_msr &= ~((target_ulong)1 << MSR_ME);
> @@ -1424,7 +1430,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
>     switch (excp) {
>     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
>         if (!FIELD_EX64(env->msr, MSR, ME)) {
> -            powerpc_checkstop(env);
> +            powerpc_checkstop(env, "machine check with MSR[ME]=0");
>         }
>         if (env->msr_mask & MSR_HVB) {
>             /*
>

