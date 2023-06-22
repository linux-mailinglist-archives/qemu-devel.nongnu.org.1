Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F78739810
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:28:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCEi8-0002xq-RS; Thu, 22 Jun 2023 03:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=yb1G=CK=kaod.org=clg@ozlabs.org>)
 id 1qCEhw-0002xI-Gc; Thu, 22 Jun 2023 03:26:20 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=yb1G=CK=kaod.org=clg@ozlabs.org>)
 id 1qCEhu-0002vw-Hm; Thu, 22 Jun 2023 03:26:20 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QmsNz6bgMz4x09;
 Thu, 22 Jun 2023 17:26:11 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QmsNw4Nccz4wjD;
 Thu, 22 Jun 2023 17:26:08 +1000 (AEST)
Message-ID: <3c31b569-6686-7643-f356-cda19cf06a14@kaod.org>
Date: Thu, 22 Jun 2023 09:26:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/4] target/ppc: TCG SMT support for spapr
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Richard Henderson
 <richard.henderson@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Kautuk Consul <kconsul@linux.vnet.ibm.com>
References: <20230605112323.179259-1-npiggin@gmail.com>
 <43ca9ac8-d383-42fd-ca29-f7cdd18d701d@kaod.org>
 <CTHEBROKN9FJ.33DEPNNJ89JEQ@wheely>
 <2756fa81-9ab8-0b15-a69e-726b47a43d41@kaod.org>
 <CTHF0GSBVRD5.3FZQQ8143ZVWB@wheely>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CTHF0GSBVRD5.3FZQQ8143ZVWB@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=yb1G=CK=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 6/20/23 12:45, Nicholas Piggin wrote:
> On Tue Jun 20, 2023 at 8:27 PM AEST, Cédric Le Goater wrote:
>> On 6/20/23 12:12, Nicholas Piggin wrote:
>>> On Wed Jun 7, 2023 at 12:09 AM AEST, Cédric Le Goater wrote:
>>>> On 6/5/23 13:23, Nicholas Piggin wrote:
>>>>> Previous RFC here
>>>>>
>>>>> https://lists.gnu.org/archive/html/qemu-ppc/2023-05/msg00453.html
>>>>>
>>>>> This series drops patch 1 from the previous, which is more of
>>>>> a standalone bugfix.
>>>>>
>>>>> Also accounted for Cedric's comments, except a nicer way to
>>>>> set cpu_index vs PIR/TIR SPRs, which is not quite trivial.
>>>>>
>>>>> This limits support for SMT to POWER8 and newer. It is also
>>>>> incompatible with nested-HV so that is checked for too.
>>>>>
>>>>> Iterating CPUs to find siblings for now I kept because similar
>>>>> loops exist in a few places, and it is not conceptually
>>>>> difficult for SMT, just fiddly code to improve. For now it
>>>>> should not be much performane concern.
>>>>>
>>>>> I removed hypervisor msgsnd support from patch 3, which is not
>>>>> required for spapr and added significantly to the patch.
>>>>>
>>>>> For now nobody has objected to the way shared SPR access is
>>>>> handled (serialised with TCG atomics support) so we'll keep
>>>>> going with it.
>>>>
>>>> Cc:ing more people for possible feedback.
>>>
>>> Not much feedback so I'll plan to go with this.
>>>
>>> A more performant implementation might try to synchronize
>>> threads at the register level rather than serialize everything,
>>> but SMT shared registers are not too performance critical so
>>> this should do for now.
>>
>> yes. Could you please rebase this series on upstream ?
> 
> Oh yeah I should have said, I will rebase and resend.

Here is a tree to check the rebase on :

   https://github.com/legoater/qemu/commits/ppc-next

>> It would be good to add tests for SMT. May be we could extend :
>>
>>     tests/avocado/ppc_pseries.py
>>
>> with a couple of extra QEMU configs adding 'threads=' (if possible) and
>> check :
>>
>>     "CPU maps initialized for Y threads per core"
>>
>> and
>>
>>     "smp: Brought up 1 node, X*Y CPUs"
>>
>> ?
> 
> Yeah that could be a good idea, I'll try it.

It can come later.

Thanks,

C.


