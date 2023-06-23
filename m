Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B08E73B0CD
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 08:34:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCaM6-0004pn-4G; Fri, 23 Jun 2023 02:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Kxto=CL=kaod.org=clg@ozlabs.org>)
 id 1qCaM0-0004oS-Mm; Fri, 23 Jun 2023 02:33:08 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Kxto=CL=kaod.org=clg@ozlabs.org>)
 id 1qCaLy-0004jU-MB; Fri, 23 Jun 2023 02:33:08 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QnS9231CVz4x0G;
 Fri, 23 Jun 2023 16:32:54 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QnS8z2vrkz4wjB;
 Fri, 23 Jun 2023 16:32:51 +1000 (AEST)
Message-ID: <346472c6-443a-7034-efce-36d6a10f2636@kaod.org>
Date: Fri, 23 Jun 2023 08:32:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 5/7] spapr: TCG allow up to 8-thread SMT on POWER8 and
 newer CPUs
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230622093357.255649-1-npiggin@gmail.com>
 <20230622093357.255649-6-npiggin@gmail.com>
 <3bb379ff-62d0-b212-0376-7ff1f8cc61fa@kaod.org>
 <53cf03d5-a339-09be-9739-34327221ff5e@kaod.org>
In-Reply-To: <53cf03d5-a339-09be-9739-34327221ff5e@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Kxto=CL=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/22/23 12:49, Cédric Le Goater wrote:
> On 6/22/23 12:06, Cédric Le Goater wrote:
>> On 6/22/23 11:33, Nicholas Piggin wrote:
>>> PPC TCG supports SMT CPU configurations for non-hypervisor state, so
>>> permit POWER8-10 pseries machines to enable SMT.
>>>
>>> This requires PIR and TIR be set, because that's how sibling thread
>>> matching is done by TCG.
>>>
>>> spapr's nested-HV capability does not currently coexist with SMT, so
>>> that combination is prohibited (interestingly somewhat analogous to
>>> LPAR-per-core mode on real hardware which also does not support KVM).
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>>   hw/ppc/spapr.c          | 16 ++++++++++++----
>>>   hw/ppc/spapr_caps.c     | 14 ++++++++++++++
>>>   hw/ppc/spapr_cpu_core.c |  7 +++++--
>>>   3 files changed, 31 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index 8e7d497f25..677b5eef9d 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -2525,10 +2525,18 @@ static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
>>>       int ret;
>>>       unsigned int smp_threads = ms->smp.threads;
>>> -    if (tcg_enabled() && (smp_threads > 1)) {
>>> -        error_setg(errp, "TCG cannot support more than 1 thread/core "
>>> -                   "on a pseries machine");
>>> -        return;
>>> +    if (tcg_enabled()) {
> 
> I will add :
> 
>              if (smp_threads > 1 &&
> 
> No need to resend for that.

and


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


