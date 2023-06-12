Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D3172BE58
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 12:08:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8eT3-0001Mn-PC; Mon, 12 Jun 2023 06:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q8eT1-0001MT-0N; Mon, 12 Jun 2023 06:08:07 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q8eSy-0007P7-Tt; Mon, 12 Jun 2023 06:08:06 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 4957074633D;
 Mon, 12 Jun 2023 12:07:59 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 13D7C74632B; Mon, 12 Jun 2023 12:07:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1261A745720;
 Mon, 12 Jun 2023 12:07:59 +0200 (CEST)
Date: Mon, 12 Jun 2023 12:07:59 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, 
 Greg Kurz <groug@kaod.org>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 03/10] target/ppc: Move common check in exception handlers
 to a function
In-Reply-To: <c2e2a63d-8cfd-35d2-bce2-7046895d6da9@linaro.org>
Message-ID: <b3ab45b2-639f-0ea1-5495-cb9d52e553f9@eik.bme.hu>
References: <cover.1686522199.git.balaton@eik.bme.hu>
 <e7c1a61de1efdee932b71fada93dd58a3ce951cb.1686522199.git.balaton@eik.bme.hu>
 <c2e2a63d-8cfd-35d2-bce2-7046895d6da9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1725769013-1686564479=:29202"
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

--3866299591-1725769013-1686564479=:29202
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 12 Jun 2023, Philippe Mathieu-Daudé wrote:
> On 12/6/23 00:42, BALATON Zoltan wrote:
>> All powerpc exception handlers share some code when handling machine
>> check exceptions. Move this to a common function.
>> 
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   target/ppc/excp_helper.c | 112 ++++++++-------------------------------
>>   1 file changed, 23 insertions(+), 89 deletions(-)
>> 
>> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
>> index 3783315fdb..e4532f5088 100644
>> --- a/target/ppc/excp_helper.c
>> +++ b/target/ppc/excp_helper.c
>> @@ -403,6 +403,23 @@ static void powerpc_set_excp_state(PowerPCCPU *cpu, 
>> target_ulong vector,
>>       env->reserve_addr = -1;
>>   }
>>   +static void powerpc_checkstop_state(CPUPPCState *env)
>> +{
>> +    if (!FIELD_EX64(env->msr, MSR, ME)) {
>
> Preferably inverting this if() and returning early:

Good idea, will wait for some more review in case any other changes are 
needed before sending a v2 for this.

Regards,
BALATON Zoltan

> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>
>> +        CPUState *cs = env_cpu(env);
>> +
>> +        /* Machine check exception is not enabled. Enter checkstop state. 
>> */
>> +        fprintf(stderr, "Machine check while not allowed. "
>> +                "Entering checkstop state\n");
>> +        if (qemu_log_separate()) {
>> +            qemu_log("Machine check while not allowed. "
>> +                     "Entering checkstop state\n");
>> +        }
>> +        cs->halted = 1;
>> +        cpu_interrupt_exittb(cs);
>> +    }
>> +}
>
>
>
--3866299591-1725769013-1686564479=:29202--

