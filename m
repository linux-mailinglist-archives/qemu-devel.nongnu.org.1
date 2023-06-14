Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F657309DB
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 23:34:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Y7l-0004NO-41; Wed, 14 Jun 2023 17:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9Y7j-0004Mr-BQ; Wed, 14 Jun 2023 17:33:51 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9Y7h-0003iT-NK; Wed, 14 Jun 2023 17:33:51 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 054B974633D;
 Wed, 14 Jun 2023 23:33:43 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8394A746335; Wed, 14 Jun 2023 23:33:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7F46F745720;
 Wed, 14 Jun 2023 23:33:42 +0200 (CEST)
Date: Wed, 14 Jun 2023 23:33:42 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, 
 Greg Kurz <groug@kaod.org>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 09/10] target/ppc: Simplify syscall exception handlers
In-Reply-To: <CTC3156BMOHL.1CSJOLOF48ZK5@wheely>
Message-ID: <0c1ccff0-ae1c-8dd2-2c23-c3670296469b@eik.bme.hu>
References: <cover.1686522199.git.balaton@eik.bme.hu>
 <ddb1379de4b3c20e543b37fb18fde5581191af49.1686522199.git.balaton@eik.bme.hu>
 <CTC3156BMOHL.1CSJOLOF48ZK5@wheely>
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

On Wed, 14 Jun 2023, Nicholas Piggin wrote:
> On Mon Jun 12, 2023 at 8:42 AM AEST, BALATON Zoltan wrote:
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
>> index 4f6a6dfb19..089417894e 100644
>> --- a/target/ppc/excp_helper.c
>> +++ b/target/ppc/excp_helper.c
>> @@ -738,26 +738,23 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
>>          break;
>>      case POWERPC_EXCP_SYSCALL:   /* System call exception                    */
>>      {
>> -        int lev = env->error_code;
>> +        PowerPCCPU *cpu = env_archcpu(env);
>
> I prefer to keep lev. Makes sense to combine the tests though
> I suppose. Although with powernv it's not really clear that we
> want to dump_syscall. dump_hcall is probably better (powernv
> could support a non-PAPR hypervisor with different hcall
> semantics, but also it could support an OS with different
> syscall semantics too). I guess that could be changed back
> when necessary though.

What do you mean changed back? This is not supposed to change when 
dump_hcall and dump_syscall is called. However I've only changed the 
powerpc_excp_7xx() and powerpc_excp_74xx() functions where this is only 
present as a hack for VOF. I've left powerpc_excp_books() where hypercalls 
really exist unchanged because that takes other bits into accound so 
probably we can't combine the tests rhere.

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
>> @@ -882,26 +879,23 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
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

