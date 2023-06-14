Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CF472F874
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 10:56:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9MHY-0006zK-KH; Wed, 14 Jun 2023 04:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UREO=CC=kaod.org=clg@ozlabs.org>)
 id 1q9MHQ-0006yw-1d; Wed, 14 Jun 2023 04:55:04 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=UREO=CC=kaod.org=clg@ozlabs.org>)
 id 1q9MHN-0004JJ-PD; Wed, 14 Jun 2023 04:55:03 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qgzl45v59z4x41;
 Wed, 14 Jun 2023 18:54:56 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qgzl2606hz4wg6;
 Wed, 14 Jun 2023 18:54:54 +1000 (AEST)
Message-ID: <e2e88fc1-8099-7eab-b51b-8212063fa6a5@kaod.org>
Date: Wed, 14 Jun 2023 10:54:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/4] ppc/pnv: Add chiptod and core timebase state machine
 models
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Michael Neuling <mikey@neuling.org>
References: <20230603233612.125879-1-npiggin@gmail.com>
 <e3f591df-6569-b396-0cf7-0ea62aee9f0c@kaod.org>
 <CTC47NS1KELC.35U22YEEW26UP@wheely>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CTC47NS1KELC.35U22YEEW26UP@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=UREO=CC=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.098, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 6/14/23 07:14, Nicholas Piggin wrote:
> On Tue Jun 6, 2023 at 11:59 PM AEST, Cédric Le Goater wrote:
>> On 6/4/23 01:36, Nicholas Piggin wrote:
>>> This adds support for chiptod and core timebase state machine models in
>>> the powernv POWER9 and POWER10 models.
>>>
>>> This does not actually change the time or the value in TB registers
>>> (because they are alrady synced in QEMU), but it does go through the
>>> motions. It is enough to be able to run skiboot's chiptod initialisation
>>> code that synchronises core timebases (after a patch to prevent skiboot
>>> skipping chiptod for QEMU, posted to skiboot mailing list).
>>>
>>> Sorry there was some delay since the last posting. There is a bit more
>>> interest in this recently but feedback and comments from RFC was not
>>> forgotten and is much appreciated.
>>>
>>> https://lists.gnu.org/archive/html/qemu-ppc/2022-08/msg00324.html
>>>
>>> I think I accounted for everything except moving register defines to the
>>> .h file. I'm on the fence about that but if they are only used in the .c
>>> file I think it's okay to keep them there for now. I cut out a lot of
>>> unused ones so it's not so cluttered now.
>>>
>>> Lots of other changes and fixes since that RFC. Notably:
>>> - Register names changed to match the workbook names instead of skiboot.
>>> - TFMR moved to timebase_helper.c from misc_helper.c
>>> - More comprehensive model and error checking, particularly of TFMR.
>>> - POWER10 with multi-chip support.
>>> - chiptod and core timebase linked via specific state instead of TFMR.
>>
>>
>> The chiptod units are not exposed to the OS, it is all handled at FW
>> level AFAIK. Could the OPAL people provide some feedback on the low level
>> models ?
> 
> Well, no takers so far. I guess I'm a OPAL people :)
>> I did some of the P10 chiptod addressing in skiboot, at least. This
> patch does work with the skiboot chiptod driver at least.

cool, with 2 chips ?

> I would eventually like to add in the ability to actually change the
> TB with it, and inject errors and generate HMIs because that's an area
> that seem to be a bit lacking (most of such testing seemed to be done
> on real hardware using special time facility corruption injection).

The MCE injection was a nice addon

   https://lore.kernel.org/qemu-devel/20200325144147.221875-1-npiggin@gmail.com/
   https://lore.kernel.org/qemu-devel/20211013214042.618918-1-clg@kaod.org/

I hope it will get more attention if you resend.

> But yes for now it is a bit difficult to verify it does much useful
> aside from booting skiboot (+ patch to enable chiptod on QEMU I posted
> recently).

It's difficult to review PATCH 4 without some good knowledge of HW. I know
you do but you can not review your own patches ! That said, the impact is
limited to PowerNV machines, I guess we are fine.

Thanks,

C.





