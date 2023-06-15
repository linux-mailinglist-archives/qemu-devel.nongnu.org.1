Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6843D7322ED
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 01:02:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9vxQ-0000ip-Uc; Thu, 15 Jun 2023 19:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9vxN-0000iH-Nz; Thu, 15 Jun 2023 19:00:45 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9vxK-0006ze-Dn; Thu, 15 Jun 2023 19:00:45 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 8D20A746361;
 Fri, 16 Jun 2023 01:00:30 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 26B1F746335; Fri, 16 Jun 2023 01:00:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 250EC745720;
 Fri, 16 Jun 2023 01:00:30 +0200 (CEST)
Date: Fri, 16 Jun 2023 01:00:30 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, 
 Greg Kurz <groug@kaod.org>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 05/10] target/ppc: Change parameter of
 cpu_interrupt_exittb() to an env pointer
In-Reply-To: <CTD723ZCV2NQ.2GYK12U9AFQ2J@wheely>
Message-ID: <16e73ab0-93a1-67c6-6ae4-44c8708bac7d@eik.bme.hu>
References: <cover.1686776990.git.balaton@eik.bme.hu>
 <78ecd505a8b523e236cbeab335aa0621f7834cc5.1686776990.git.balaton@eik.bme.hu>
 <CTCWOA3I3X48.2RZG2THERVO2@wheely>
 <33d841e7-38ab-07d3-4914-a055b029605c@eik.bme.hu>
 <CTD723ZCV2NQ.2GYK12U9AFQ2J@wheely>
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
> On Thu Jun 15, 2023 at 7:19 PM AEST, BALATON Zoltan wrote:
>> On Thu, 15 Jun 2023, Nicholas Piggin wrote:
>>> On Thu Jun 15, 2023 at 7:34 AM AEST, BALATON Zoltan wrote:
>>>> Changing the parameter of cpu_interrupt_exittb() from CPUState to env
>>>> allows removing some more local CPUState variables in callers.
>>>
>>> I think it's more consistent to keep cs, which is same as
>>> cpu_interrupt().
>>
>> But with this patch it's more consistent with the other functions devlared
>> in helper_regs.h and gets rid of the #ifdef in hreg_store_msr() so I'd
>> still like to keep this patch. Callers already have env so it should not
>> matter.
>
> Being consistent with functions of the same file is not important or
> really makes sense. It's important to be consistent with functions
> of similar type. cpu_interrupt_exittb() is a helper to call
> cpu_interrupt() so makes sense to be similar. At best it seems like
> pointless churn.

OK I've revised it in v3 and dropped most of this patch.

Regards,
BALATON Zoltan

