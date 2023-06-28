Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7741874079A
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 03:30:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEJzU-00061Z-Sm; Tue, 27 Jun 2023 21:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qEJzR-00061F-3l; Tue, 27 Jun 2023 21:29:01 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qEJzO-0001Va-IH; Tue, 27 Jun 2023 21:29:00 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 90284746335;
 Wed, 28 Jun 2023 03:28:41 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 522EE74632B; Wed, 28 Jun 2023 03:28:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4F279745720;
 Wed, 28 Jun 2023 03:28:41 +0200 (CEST)
Date: Wed, 28 Jun 2023 03:28:41 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v2 3/4] target/ppc: Make checkstop actually stop the system
In-Reply-To: <CTNVGY00BO7S.35I04KZ8AFLL4@wheely>
Message-ID: <49c543ba-c068-5481-d2f5-078a8ae01d45@eik.bme.hu>
References: <20230627134644.260663-1-npiggin@gmail.com>
 <20230627134644.260663-4-npiggin@gmail.com>
 <5b90ae62-f279-1d07-1098-39a4f450bb99@eik.bme.hu>
 <CTNVGY00BO7S.35I04KZ8AFLL4@wheely>
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

On Wed, 28 Jun 2023, Nicholas Piggin wrote:
> On Wed Jun 28, 2023 at 3:38 AM AEST, BALATON Zoltan wrote:
>> On Tue, 27 Jun 2023, Nicholas Piggin wrote:
>>> checkstop state does not halt the system, interrupts continue to be
>>> serviced, and other CPUs run.
>>>
>>> Stop the machine with vm_stop(), and print a register dump too.
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>> Since v1:
>>> - Fix loop exit so it stops on the attn instruction, rather than
>>>  after it.
>>>
>>> target/ppc/excp_helper.c | 34 ++++++++++++++++++++--------------
>>> 1 file changed, 20 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
>>> index 5beda973ce..28d8a9b212 100644
>>> --- a/target/ppc/excp_helper.c
>>> +++ b/target/ppc/excp_helper.c
>>> @@ -19,6 +19,7 @@
>>> #include "qemu/osdep.h"
>>> #include "qemu/main-loop.h"
>>> #include "qemu/log.h"
>>> +#include "sysemu/runstate.h"
>>> #include "cpu.h"
>>> #include "exec/exec-all.h"
>>> #include "internal.h"
>>> @@ -186,19 +187,24 @@ static void ppc_excp_debug_sw_tlb(CPUPPCState *env, int excp)
>>>              env->error_code);
>>> }
>>>
>>> -static void powerpc_checkstop(CPUPPCState *env)
>>> +static void powerpc_checkstop(CPUPPCState *env, const char *reason)
>>> {
>>>     CPUState *cs = env_cpu(env);
>>>
>>> -    /* Machine check exception is not enabled. Enter checkstop state. */
>>> -    fprintf(stderr, "Machine check while not allowed. "
>>> -            "Entering checkstop state\n");
>>> +    vm_stop(RUN_STATE_GUEST_PANICKED);
>>> +
>>> +    fprintf(stderr, "Entering checkstop state: %s\n", reason);
>>> +    cpu_dump_state(cs, stderr, CPU_DUMP_FPU | CPU_DUMP_CCOP);
>>>     if (qemu_log_separate()) {
>>> -        qemu_log("Machine check while not allowed. "
>>> -                 "Entering checkstop state\n");
>>> +        FILE *logfile = qemu_log_trylock();
>>> +        if (logfile) {
>>> +            fprintf(logfile, "Entering checkstop state: %s\n", reason);
>>
>> I don't think you should have fprintfs here. Is this remnants of debug
>> code left here by mistake? The fprintf that was there before may also need
>> to be converted to some qemI_log or error_report but I did not know what
>> these are for and did not address that. But if you want to add more then
>> it may need to be solved first.
>
> I just followed existing fprintf use. Changing that should be separate
> patch indeed.

As this is the only printf here maybe cleaning it up should come before 
adding more.

>>> +            cpu_dump_state(cs, logfile, CPU_DUMP_FPU | CPU_DUMP_CCOP);
>>> +            qemu_log_unlock(logfile);
>>> +        }
>>>     }
>>> -    cs->halted = 1;
>>> -    cpu_interrupt_exittb(cs);
>>> +
>>
>> Excess blank line?
>
> No, it separates the logging block from function.
>
>>
>>> +    cpu_loop_exit_noexc(cs);
>>> }
>>>
>>> #if defined(TARGET_PPC64)
>>> @@ -483,7 +489,7 @@ static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
>>>         break;
>>>     case POWERPC_EXCP_MCHECK:    /* Machine check exception                  */
>>>         if (!FIELD_EX64(env->msr, MSR, ME)) {
>>> -            powerpc_checkstop(env);
>>> +            powerpc_checkstop(env, "machine check with MSR[ME]=0");
>>
>> If the message is always the same why pass it from here If the only other
>> option not used yet would be MSR[ME]=1 then that could also be checked in
>> the func so no need to pass the message. So is there any other possible
>> reason here?
>
> To make the checkstop function more general (e.g., used by the next patch).

OK, I did look where it's needed but missed that line in the next patch. 
That's not practical to check in the checkstop function then.

Regards,
BALATON Zoltan

