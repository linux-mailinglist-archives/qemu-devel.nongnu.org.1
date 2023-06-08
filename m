Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D56A727B8A
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 11:35:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7C2M-0008EV-Kr; Thu, 08 Jun 2023 05:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q7C2K-0008E1-BR; Thu, 08 Jun 2023 05:34:32 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q7C2I-0001Oa-1t; Thu, 08 Jun 2023 05:34:32 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 10A93746377;
 Thu,  8 Jun 2023 11:34:23 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CB286746369; Thu,  8 Jun 2023 11:34:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C9101745720;
 Thu,  8 Jun 2023 11:34:22 +0200 (CEST)
Date: Thu, 8 Jun 2023 11:34:22 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH] target/ppc: Implement gathering irq statistics
In-Reply-To: <a274071c-b2c0-8371-b10d-82a883edef1f@kaod.org>
Message-ID: <074e4215-2f3d-2292-4f93-2048233fa33a@eik.bme.hu>
References: <20230606220200.7EBCC74635C@zero.eik.bme.hu>
 <a274071c-b2c0-8371-b10d-82a883edef1f@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1358146602-1686216862=:35520"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1358146602-1686216862=:35520
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 8 Jun 2023, Cédric Le Goater wrote:
> On 6/7/23 00:02, BALATON Zoltan wrote:
>> Count exceptions which can be queried with info irq monitor command.
>
> I don't think the TYPE_INTERRUPT_STATS_PROVIDER interface was designed
> for CPUs. It is more suitable for interrupt controllers.

True but:
- It works and provides useful statistics
- At least older PPC CPUs have embedded interrupt controller as the 
comment in cpu.h shows

so is this just a comment, question or you want something changed in this 
patch?

Regards,
BALATON Zoltan

> C.
>
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   target/ppc/cpu.h         |  1 +
>>   target/ppc/cpu_init.c    | 18 ++++++++++++++++++
>>   target/ppc/excp_helper.c |  1 +
>>   3 files changed, 20 insertions(+)
>> 
>> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
>> index c7c2a5534c..d3a9197e02 100644
>> --- a/target/ppc/cpu.h
>> +++ b/target/ppc/cpu.h
>> @@ -1194,6 +1194,7 @@ struct CPUArchState {
>>       int error_code;
>>       uint32_t pending_interrupts;
>>   #if !defined(CONFIG_USER_ONLY)
>> +    uint64_t excp_stats[POWERPC_EXCP_NB];
>>       /*
>>        * This is the IRQ controller, which is implementation dependent and 
>> only
>>        * relevant when emulating a complete machine. Note that this isn't 
>> used
>> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
>> index 05bf73296b..716f2b5d64 100644
>> --- a/target/ppc/cpu_init.c
>> +++ b/target/ppc/cpu_init.c
>> @@ -48,6 +48,7 @@
>>     #ifndef CONFIG_USER_ONLY
>>   #include "hw/boards.h"
>> +#include "hw/intc/intc.h"
>>   #endif
>>     /* #define PPC_DEBUG_SPR */
>> @@ -7123,6 +7124,16 @@ static bool ppc_cpu_is_big_endian(CPUState *cs)
>>       return !FIELD_EX64(env->msr, MSR, LE);
>>   }
>>   +static bool ppc_get_irq_stats(InterruptStatsProvider *obj,
>> +                              uint64_t **irq_counts, unsigned int 
>> *nb_irqs)
>> +{
>> +    CPUPPCState *env = &POWERPC_CPU(obj)->env;
>> +
>> +    *irq_counts = env->excp_stats;
>> +    *nb_irqs = ARRAY_SIZE(env->excp_stats);
>> +    return true;
>> +}
>> +
>>   #ifdef CONFIG_TCG
>>   static void ppc_cpu_exec_enter(CPUState *cs)
>>   {
>> @@ -7286,6 +7297,7 @@ static void ppc_cpu_class_init(ObjectClass *oc, void 
>> *data)
>>       cc->gdb_write_register = ppc_cpu_gdb_write_register;
>>   #ifndef CONFIG_USER_ONLY
>>       cc->sysemu_ops = &ppc_sysemu_ops;
>> +    INTERRUPT_STATS_PROVIDER_CLASS(oc)->get_statistics = 
>> ppc_get_irq_stats;
>>   #endif
>>         cc->gdb_num_core_regs = 71;
>> @@ -7323,6 +7335,12 @@ static const TypeInfo ppc_cpu_type_info = {
>>       .abstract = true,
>>       .class_size = sizeof(PowerPCCPUClass),
>>       .class_init = ppc_cpu_class_init,
>> +#ifndef CONFIG_USER_ONLY
>> +    .interfaces = (InterfaceInfo[]) {
>> +          { TYPE_INTERRUPT_STATS_PROVIDER },
>> +          { }
>> +    },
>> +#endif
>>   };
>>     #ifndef CONFIG_USER_ONLY
>> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
>> index fea9221501..5480d9d2c7 100644
>> --- a/target/ppc/excp_helper.c
>> +++ b/target/ppc/excp_helper.c
>> @@ -1652,6 +1652,7 @@ static void powerpc_excp(PowerPCCPU *cpu, int excp)
>>       qemu_log_mask(CPU_LOG_INT, "Raise exception at " TARGET_FMT_lx
>>                     " => %s (%d) error=%02x\n", env->nip, 
>> powerpc_excp_name(excp),
>>                     excp, env->error_code);
>> +    env->excp_stats[excp]++;
>>         switch (env->excp_model) {
>>       case POWERPC_EXCP_40x:
>
>
>
--3866299591-1358146602-1686216862=:35520--

