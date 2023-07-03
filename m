Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFF8745F75
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 17:08:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGL8m-00042r-Au; Mon, 03 Jul 2023 11:07:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGL8b-000426-Ei; Mon, 03 Jul 2023 11:06:50 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qGL8Z-0004oa-24; Mon, 03 Jul 2023 11:06:49 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id D22C8748A59;
 Mon,  3 Jul 2023 17:06:25 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9B688746369; Mon,  3 Jul 2023 17:06:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 99B9C74633D;
 Mon,  3 Jul 2023 17:06:25 +0200 (CEST)
Date: Mon, 3 Jul 2023 17:06:25 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3] target/ppc: Make checkstop actually stop the system
In-Reply-To: <CTSK657Y1RRB.3919QR3A490A5@wheely>
Message-ID: <93da1b1b-aabc-aba1-0706-16b3513ad0e9@eik.bme.hu>
References: <20230703120340.45349-1-npiggin@gmail.com>
 <68789d6e-5bf8-88d6-2bd5-405339500f44@eik.bme.hu>
 <CTSK657Y1RRB.3919QR3A490A5@wheely>
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

On Mon, 3 Jul 2023, Nicholas Piggin wrote:
> On Mon Jul 3, 2023 at 10:26 PM AEST, BALATON Zoltan wrote:
>> On Mon, 3 Jul 2023, Nicholas Piggin wrote:
>>> checkstop state does not halt the system, interrupts continue to be
>>> serviced, and other CPUs run. Stop the machine with
>>> qemu_system_guest_panicked.
>>>
>>> Change the logging not to print separately to stderr because a
>>> checkstop is a guest error (or perhaps a simulated machine error)
>>> rather than a QEMU error. CPU registers are dumped.
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>>
>>> Since v1:
>>> - Fix loop exit so it stops on the checkstop-causing instruction, rather than
>>>  after it.
>>>
>>> Since v2:
>>> - Rebase on ppc-next.
>>
>> Is this really based on ppc-next or on my series or another patch from
>> you? I think the patch from my series that introduces the checksrop
>> function that this patch is changing is not yet in ppc-next so this may
>> not apply there.
>
> It is based on ppc-next unless I've done something silly. Is this
> the patch you were talking about?
>
> https://gitlab.com/danielhb/qemu/-/commit/26d089ac20080066061ed61fb58a5411e275e191
>
>> I think you've posted an alternative to the patch moving
>> checkstop handling to a function and the sc patch which may clash with the
>> not yet merged parts in my series but i could not follow all these
>> patches. I'm not sure Daniel could so maybe you could send it as a series
>> to include all patches you want to add or state what it's based on.
>
> Things are getting a little confusing, but I think what Daniel has
> is okay. Were were talking about changing checkstop with my patch,
> but no big deal to take yours first, I've reworked things.

Sorry my bad. Yes it's getting confusing to me and missed that Daniel 
already merged that patch on ppc-next, I thought it was one of the patches 
not yet merged. So this can go on top then.

There was another change for fixing sc that may clash that I'm not sure 
if I need to do anything about.

Regards,
BALATON Zoltan

