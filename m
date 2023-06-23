Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7810D73B6CF
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 13:53:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCfKp-0007SM-MP; Fri, 23 Jun 2023 07:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qCfKn-0007RQ-1z; Fri, 23 Jun 2023 07:52:13 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qCfKk-0002sh-Q5; Fri, 23 Jun 2023 07:52:12 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 6C6F5748A67;
 Fri, 23 Jun 2023 13:51:57 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 36544748A66; Fri, 23 Jun 2023 13:51:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3515B748A65;
 Fri, 23 Jun 2023 13:51:57 +0200 (CEST)
Date: Fri, 23 Jun 2023 13:51:57 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 4/4] target/ppc: Make checkstop stop the system
In-Reply-To: <20230623081953.290875-5-npiggin@gmail.com>
Message-ID: <04636e8a-de3f-d963-b64e-07cc60bc2538@eik.bme.hu>
References: <20230623081953.290875-1-npiggin@gmail.com>
 <20230623081953.290875-5-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

On Fri, 23 Jun 2023, Nicholas Piggin wrote:
> checkstop state does not halt the system, interrupts continue to be
> serviced, and other CPUs run.
>
> Stop the machine with vm_stop(), and print a register dump too.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> target/ppc/excp_helper.c | 35 +++++++++++++++++++++--------------
> 1 file changed, 21 insertions(+), 14 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 4bfcfc3c3d..51e83d7f07 100644
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
> @@ -165,6 +166,24 @@ static void ppc_excp_debug_sw_tlb(CPUPPCState *env, int excp)
>              env->error_code);
> }
>
> +static void powerpc_checkstop(PowerPCCPU *cpu, const char *reason)
> +{
> +    CPUState *cs = CPU(cpu);
> +
> +    vm_stop(RUN_STATE_GUEST_PANICKED);
> +
> +    fprintf(stderr, "Entering checkstop state: %s\n", reason);
> +    cpu_dump_state(cs, stderr, CPU_DUMP_FPU | CPU_DUMP_CCOP);
> +    if (qemu_log_separate()) {
> +        FILE *logfile = qemu_log_trylock();
> +        if (logfile) {
> +            fprintf(logfile, "Entering checkstop state: %s\n", reason);
> +            cpu_dump_state(cs, logfile, CPU_DUMP_FPU | CPU_DUMP_CCOP);
> +            qemu_log_unlock(logfile);
> +        }
> +    }
> +}
> +
> #if defined(TARGET_PPC64)
> static int powerpc_reset_wakeup(CPUState *cs, CPUPPCState *env, int excp,
>                                 target_ulong *msr)
> @@ -406,21 +425,9 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, target_ulong vector,
>
> static void powerpc_mcheck_test_and_checkstop(CPUPPCState *env)
> {
> -    CPUState *cs = env_cpu(env);
> -
> -    if (FIELD_EX64(env->msr, MSR, ME)) {
> -        return;
> -    }
> -
> -    /* Machine check exception is not enabled. Enter checkstop state. */
> -    fprintf(stderr, "Machine check while not allowed. "
> -            "Entering checkstop state\n");
> -    if (qemu_log_separate()) {
> -        qemu_log("Machine check while not allowed. "
> -                 "Entering checkstop state\n");
> +    if (!FIELD_EX64(env->msr, MSR, ME)) {
> +        powerpc_checkstop(env_archcpu(env), "machine check with MSR[ME]=0");

I don't mind you twaeking the patch and renaming the function but now this 
has become another one line function which just clutters code. Either keep 
this together in one function or inline the if at callers, otherwise this 
will start to look like Forth where every simple operation gets a new 
name. :-)

Regards,
BALATON Zoltan

>     }
> -    cs->halted = 1;
> -    cpu_interrupt_exittb(cs);
> }
>
> static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
>

