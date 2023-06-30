Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5862A7444FB
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 00:58:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFN3P-0007mk-N9; Fri, 30 Jun 2023 18:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qFN3L-0007mY-JU; Fri, 30 Jun 2023 18:57:23 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qFN3J-0007Xz-G8; Fri, 30 Jun 2023 18:57:23 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 505B374633D;
 Sat,  1 Jul 2023 00:57:02 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 133A474632B; Sat,  1 Jul 2023 00:57:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0E7EA745720;
 Sat,  1 Jul 2023 00:57:02 +0200 (CEST)
Date: Sat, 1 Jul 2023 00:57:02 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, 
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 00/14] Misc clean ups to target/ppc exception handling
In-Reply-To: <92e3591e-cce7-c3e7-7d73-a0bd24de8c2c@gmail.com>
Message-ID: <1726bfcd-0e6e-0a72-bc97-be7a79f95340@eik.bme.hu>
References: <cover.1686868895.git.balaton@eik.bme.hu>
 <92e3591e-cce7-c3e7-7d73-a0bd24de8c2c@gmail.com>
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

On Fri, 30 Jun 2023, Daniel Henrique Barboza wrote:
> Patches 1, 2, 3, 5, 7 and 11 are queued.
>
> If you would be so kind to get the remaining patches, rebase them
> on top of my ppc-next and resend, I believe there's more stuff
> to be queued.

Thanks for taking care of these. I'll do the rebase of remaining patches 
once the current queue is merged, they aren't urgent so I can come back to 
those later. I'm working on some sam460ex patches but don't know yet when 
can I send it so don't wait for me now.

Regards,
BALATON Zoltan

>
>
> Thanks,
>
>
> Daniel
>
> On 6/15/23 20:03, BALATON Zoltan wrote:
>> These are some small clean ups for target/ppc/excp_helper.c trying to
>> make this code a bit simpler. No functional change is intended.
>> 
>> v2: Patch 3 changes according to review, added tags
>> v3: Address more review comments: don't change cpu_interrupt_exittb()
>> parameter, add back lev, add scv patch from Nick + add some more
>> patches to clean up #ifdefs
>> 
>> Regards,
>> BALATON Zoltan
>> 
>> BALATON Zoltan (13):
>>    target/ppc: Remove some superfluous parentheses
>>    target/ppc: Remove unneeded parameter from powerpc_reset_wakeup()
>>    target/ppc: Move common check in exception handlers to a function
>>    target/ppc: Use env_cpu for cpu_abort in excp_helper
>>    target/ppc: Remove some more local CPUState variables only used once
>>    target/ppc: Readability improvements in exception handlers
>>    target/ppd: Remove unused define
>>    target/ppc: Fix gen_sc to use correct nip
>>    target/ppc: Simplify syscall exception handlers
>>    target/ppc: Get CPUState in one step
>>    target/ppc: Clean up ifdefs in excp_helper.c, part 1
>>    target/ppc: Clean up ifdefs in excp_helper.c, part 2
>>    target/ppc: Clean up ifdefs in excp_helper.c, part 3
>> 
>> Nicholas Piggin (1):
>>    target/ppc: Move patching nip from exception handler to helper_scv
>>
>>   target/ppc/cpu.h         |   1 +
>>   target/ppc/excp_helper.c | 570 ++++++++++++---------------------------
>>   target/ppc/translate.c   |  15 +-
>>   3 files changed, 178 insertions(+), 408 deletions(-)
>> 
>
>

