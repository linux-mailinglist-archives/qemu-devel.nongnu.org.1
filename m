Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E29E71FA99
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 09:05:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ypj-0004Ws-He; Fri, 02 Jun 2023 03:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=WIde=BW=kaod.org=clg@ozlabs.org>)
 id 1q4yph-0004W4-13; Fri, 02 Jun 2023 03:04:21 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=WIde=BW=kaod.org=clg@ozlabs.org>)
 id 1q4ype-00072S-Lb; Fri, 02 Jun 2023 03:04:20 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QXYrn3Q7zz4x4C;
 Fri,  2 Jun 2023 17:04:09 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QXYrl5MxFz4x1f;
 Fri,  2 Jun 2023 17:04:07 +1000 (AEST)
Message-ID: <d414e7a2-67d6-884d-2d01-0e4dc1d0589d@kaod.org>
Date: Fri, 2 Jun 2023 09:04:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 5/5] spapr: Allow up to 8 threads SMT configuration
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20230531012313.19891-1-npiggin@gmail.com>
 <20230531012313.19891-6-npiggin@gmail.com>
 <ce866fc5-0287-a7ea-a1c3-79d23f5b6447@kaod.org>
 <CT1YXJ6J1W97.3RLRVO5ZNY61F@wheely>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CT1YXJ6J1W97.3RLRVO5ZNY61F@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=WIde=BW=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.1, RCVD_IN_DNSWL_MED=-2.3,
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

On 6/2/23 08:59, Nicholas Piggin wrote:
> On Thu Jun 1, 2023 at 5:20 PM AEST, Cédric Le Goater wrote:
>> On 5/31/23 03:23, Nicholas Piggin wrote:
>>> TCG now supports multi-threaded configuration at least enough for
>>> pseries to be functional enough to boot Linux.
>>>
>>> This requires PIR and TIR be set, because that's how sibling thread
>>> matching is done.
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>>    hw/ppc/spapr.c          | 4 ++--
>>>    hw/ppc/spapr_cpu_core.c | 7 +++++--
>>>    2 files changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
>>> index dcb7f1c70a..11074cefea 100644
>>> --- a/hw/ppc/spapr.c
>>> +++ b/hw/ppc/spapr.c
>>> @@ -2524,8 +2524,8 @@ static void spapr_set_vsmt_mode(SpaprMachineState *spapr, Error **errp)
>>>        int ret;
>>>        unsigned int smp_threads = ms->smp.threads;
>>>    
>>> -    if (!kvm_enabled() && (smp_threads > 1)) {
>>> -        error_setg(errp, "TCG cannot support more than 1 thread/core "
>>> +    if (!kvm_enabled() && (smp_threads > 8)) {
>>> +        error_setg(errp, "TCG cannot support more than 8 threads/core "
>>>                       "on a pseries machine");
>>
>> I think we should add test on the CPU also.
> 
> On the CPU type, POWER7 can have 1/2/4, POWER8 can have 1/2/4/8?
> POWER9 could also switch PVR between big and small core depending
> on whether you select SMT8 I suppose.

What I meant is to limit the support to the CPUs which will be most likely
used : POWER8-10. I don't think we care much about the others P7, P5+, 970.

Thanks,

C.


