Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2138A72FA3A
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 12:15:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9NVw-0000K2-JH; Wed, 14 Jun 2023 06:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9NVu-0000Jo-GB; Wed, 14 Jun 2023 06:14:06 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9NVs-0007ml-Sq; Wed, 14 Jun 2023 06:14:06 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id DF47F746361;
 Wed, 14 Jun 2023 12:13:58 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id ABF5074633D; Wed, 14 Jun 2023 12:13:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id AA92C745720;
 Wed, 14 Jun 2023 12:13:58 +0200 (CEST)
Date: Wed, 14 Jun 2023 12:13:58 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, 
 Greg Kurz <groug@kaod.org>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 04/10] target/ppc: Use env_cpu for cpu_abort in excp_helper
In-Reply-To: <CTC24VY5AQCR.2VUJY58072BV9@wheely>
Message-ID: <439d20a4-f436-5007-9fa5-63d4162869a7@eik.bme.hu>
References: <cover.1686522199.git.balaton@eik.bme.hu>
 <2323bc631817a134319fc1978531160986ecbe13.1686522199.git.balaton@eik.bme.hu>
 <CTC24VY5AQCR.2VUJY58072BV9@wheely>
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

On Wed, 14 Jun 2023, Nicholas Piggin wrote:
> On Mon Jun 12, 2023 at 8:42 AM AEST, BALATON Zoltan wrote:
>> Use the env_cpu function to get the CPUState for cpu_abort. These are
>> only needed in case of fatal errors so this allows to avoid casting
>> and storing CPUState in a local variable wnen not needed.
>
> I don't entirely mind keeping cs around as a variable...

What for? This was only needed for error messages so most of the time 
useless and having less locals make the function a bit simpler. If this is 
needed for something else than errors later it could be added back but 
then it will only be in the model specific function that needs it.

What I could change is to use CPU(cpu) instead of env_cpu(env) now that 
I've dropped the rest of the series that also changed the func parameter 
to get env instead of PowerPCCPU which may avoid some line breaks but not 
sure if that's any better.

Regards,
BALATON Zoltan

> Thanks,
> Nick
>
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  target/ppc/excp_helper.c | 118 +++++++++++++++++++++------------------
>>  1 file changed, 63 insertions(+), 55 deletions(-)
>>
>> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
>> index e4532f5088..51202f7028 100644
>> --- a/target/ppc/excp_helper.c
>> +++ b/target/ppc/excp_helper.c
>> @@ -422,7 +422,6 @@ static void powerpc_checkstop_state(CPUPPCState *env)
>>
>>  static void powerpc_excp_40x(PowerPCCPU *cpu, int excp)
>>  {
>> -    CPUState *cs = CPU(cpu);
>>      CPUPPCState *env = &cpu->env;
>>      target_ulong msr, new_msr, vector;
>>      int srr0, srr1;
>
> [snip]
>
>

