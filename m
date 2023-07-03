Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E661745C2F
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 14:27:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGIe1-0007BJ-Iu; Mon, 03 Jul 2023 08:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGIds-0007AW-47; Mon, 03 Jul 2023 08:27:02 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGIdn-00024V-HA; Mon, 03 Jul 2023 08:26:54 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 6E53D746361;
 Mon,  3 Jul 2023 14:26:33 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 36BC574633D; Mon,  3 Jul 2023 14:26:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 34A6E745720;
 Mon,  3 Jul 2023 14:26:33 +0200 (CEST)
Date: Mon, 3 Jul 2023 14:26:33 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3] target/ppc: Make checkstop actually stop the system
In-Reply-To: <20230703120340.45349-1-npiggin@gmail.com>
Message-ID: <68789d6e-5bf8-88d6-2bd5-405339500f44@eik.bme.hu>
References: <20230703120340.45349-1-npiggin@gmail.com>
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

On Mon, 3 Jul 2023, Nicholas Piggin wrote:
> checkstop state does not halt the system, interrupts continue to be
> serviced, and other CPUs run. Stop the machine with
> qemu_system_guest_panicked.
>
> Change the logging not to print separately to stderr because a
> checkstop is a guest error (or perhaps a simulated machine error)
> rather than a QEMU error. CPU registers are dumped.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>
> Since v1:
> - Fix loop exit so it stops on the checkstop-causing instruction, rather than
>  after it.
>
> Since v2:
> - Rebase on ppc-next.

Is this really based on ppc-next or on my series or another patch from 
you? I think the patch from my series that introduces the checksrop 
function that this patch is changing is not yet in ppc-next so this may 
not apply there. I think you've posted an alternative to the patch moving 
checkstop handling to a function and the sc patch which may clash with the 
not yet merged parts in my series but i could not follow all these 
patches. I'm not sure Daniel could so maybe you could send it as a series 
to include all patches you want to add or state what it's based on.

Regards,
BALATON Zoltan

> - Use qemu_system_guest_panicked rather than vm_stop (Richard)
> - Move away from printing to stderr (Zoltan)
> - Reduce changes to log messages.
> - Split out from larger series since it's independent (will skip attn
>  instruction for now).
> ---
> target/ppc/excp_helper.c | 26 ++++++++++++++++++--------
> 1 file changed, 18 insertions(+), 8 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index e49e13a30d..a588285ef1 100644
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
> @@ -427,20 +428,29 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, target_ulong vector,
> static void powerpc_mcheck_checkstop(CPUPPCState *env)
> {
>     CPUState *cs = env_cpu(env);
> +    FILE *f;
>
>     if (FIELD_EX64(env->msr, MSR, ME)) {
>         return;
>     }
>
> -    /* Machine check exception is not enabled. Enter checkstop state. */
> -    fprintf(stderr, "Machine check while not allowed. "
> -            "Entering checkstop state\n");
> -    if (qemu_log_separate()) {
> -        qemu_log("Machine check while not allowed. "
> -                 "Entering checkstop state\n");
> +    /*
> +     * This stops the machine and logs CPU state without killing QEMU
> +     * (like cpu_abort()) so the machine can still be debugged (because
> +     * it is often a guest error).
> +     */
> +
> +    f = qemu_log_trylock();
> +    if (f) {
> +        fprintf(f, "Machine check while not allowed. "
> +                "Entering checkstop state.\n");
> +        cpu_dump_state(cs, f, CPU_DUMP_FPU | CPU_DUMP_CCOP);
> +        qemu_log_unlock(f);
>     }
> -    cs->halted = 1;
> -    cpu_interrupt_exittb(cs);
> +
> +    qemu_system_guest_panicked(NULL);
> +
> +    cpu_loop_exit_noexc(cs);
> }
>
> static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
>

