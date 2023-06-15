Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9647313AD
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 11:25:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9jER-0004Aq-0f; Thu, 15 Jun 2023 05:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9jEP-0004AX-E7; Thu, 15 Jun 2023 05:25:29 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9jEN-00039u-8w; Thu, 15 Jun 2023 05:25:28 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 3F7B6746369;
 Thu, 15 Jun 2023 11:25:20 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 098C674633D; Thu, 15 Jun 2023 11:25:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 08655746361;
 Thu, 15 Jun 2023 11:25:20 +0200 (CEST)
Date: Thu, 15 Jun 2023 11:25:20 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, 
 Greg Kurz <groug@kaod.org>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 09/10] target/ppc: Simplify syscall exception handlers
In-Reply-To: <CTCWPOXSQZLU.275T4DDJIY90X@wheely>
Message-ID: <6550e18f-b03d-134b-bc45-a947a25cf5de@eik.bme.hu>
References: <cover.1686776990.git.balaton@eik.bme.hu>
 <ee7c07146e8e2e5a3d1d52aaf5a4eeef695c359d.1686776990.git.balaton@eik.bme.hu>
 <CTCWPOXSQZLU.275T4DDJIY90X@wheely>
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

On Thu, 15 Jun 2023, Nicholas Piggin wrote:
> On Thu Jun 15, 2023 at 7:34 AM AEST, BALATON Zoltan wrote:
>> After previous changes the hypercall handling in 7xx and 74xx
>> exception handlers can be folded into one if statement to simpilfy
>> this code.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  target/ppc/excp_helper.c | 26 ++++++++++----------------
>>  1 file changed, 10 insertions(+), 16 deletions(-)
>>
>> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
>> index 1682b988ba..662457f342 100644
>> --- a/target/ppc/excp_helper.c
>> +++ b/target/ppc/excp_helper.c
>> @@ -740,26 +740,23 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
>>          break;
>>      case POWERPC_EXCP_SYSCALL:   /* System call exception                    */
>>      {
>> -        int lev = env->error_code;
>
> I would still keep lev. Self documenting and consistent with books
> handler.

lev is still there in the books version, but probably not really needed in 
these 7xx versions which does not really have level parameter. This hack 
should likely go away and replaced with something else on the long run as 
this won't work with KVM but that needs some support from VOF or compiling 
a different version for pegasos2 which wasn't considered so far. I can add 
the local back if you really insist but I don't think it really makes much 
sense in these cases for 7xx and 74xx.

>> +        PowerPCCPU *cpu = env_archcpu(env);
>
> Is this necessary?

Yes, for cpu->vhyp below.

Regards,
BALATON Zoltan

> Thanks,
> Nick
>
>>
>> -        if (lev == 1 && cpu->vhyp) {
>> -            dump_hcall(env);
>> -        } else {
>> -            dump_syscall(env);
>> -        }
>>          /*
>>           * The Virtual Open Firmware (VOF) relies on the 'sc 1'
>>           * instruction to communicate with QEMU. The pegasos2 machine
>>           * uses VOF and the 7xx CPUs, so although the 7xx don't have
>>           * HV mode, we need to keep hypercall support.
>>           */
>> -        if (lev == 1 && cpu->vhyp) {
>> +        if (unlikely(env->error_code == 1 && cpu->vhyp)) {
>>              PPCVirtualHypervisorClass *vhc =
>>                  PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
>> +            dump_hcall(env);
>>              vhc->hypercall(cpu->vhyp, cpu);
>>              return;
>> +        } else {
>> +            dump_syscall(env);
>>          }
>> -
>>          break;
>>      }
>>      case POWERPC_EXCP_FPU:       /* Floating-point unavailable exception     */
>> @@ -884,26 +881,23 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
>>          break;
>>      case POWERPC_EXCP_SYSCALL:   /* System call exception                    */
>>      {
>> -        int lev = env->error_code;
>> +        PowerPCCPU *cpu = env_archcpu(env);
>>
>> -        if (lev == 1 && cpu->vhyp) {
>> -            dump_hcall(env);
>> -        } else {
>> -            dump_syscall(env);
>> -        }
>>          /*
>>           * The Virtual Open Firmware (VOF) relies on the 'sc 1'
>>           * instruction to communicate with QEMU. The pegasos2 machine
>>           * uses VOF and the 74xx CPUs, so although the 74xx don't have
>>           * HV mode, we need to keep hypercall support.
>>           */
>> -        if (lev == 1 && cpu->vhyp) {
>> +        if (unlikely(env->error_code == 1 && cpu->vhyp)) {
>>              PPCVirtualHypervisorClass *vhc =
>>                  PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
>> +            dump_hcall(env);
>>              vhc->hypercall(cpu->vhyp, cpu);
>>              return;
>> +        } else {
>> +            dump_syscall(env);
>>          }
>> -
>>          break;
>>      }
>>      case POWERPC_EXCP_FPU:       /* Floating-point unavailable exception     */
>> --
>> 2.30.9
>
>
>

