Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFA0714BDE
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 16:17:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3dg0-0003m1-06; Mon, 29 May 2023 10:16:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3dfO-0003lc-AV; Mon, 29 May 2023 10:16:11 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3dfK-00032n-5P; Mon, 29 May 2023 10:16:09 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3E36C92B8;
 Mon, 29 May 2023 17:16:02 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6A84183AD;
 Mon, 29 May 2023 17:16:00 +0300 (MSK)
Message-ID: <7a1a3e90-e036-bff6-0d21-667c4ecaf380@tls.msk.ru>
Date: Mon, 29 May 2023 17:16:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/10] ppc queue
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Bernhard Beschow <shentey@gmail.com>
References: <20230528164922.20364-1-danielhb413@gmail.com>
 <2ccafb44-d09a-e71c-005b-9a36f128b275@tls.msk.ru>
 <CSYEG7TJD7S7.IYIJXRKLWCZA@wheely>
 <c66df357-d647-1335-7a7e-70e602dd44bb@tls.msk.ru>
 <CSYJTOIIC83Z.2KLRXWGXHXCW5@wheely>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CSYJTOIIC83Z.2KLRXWGXHXCW5@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

29.05.2023 09:30, Nicholas Piggin wrote:
> On Mon May 29, 2023 at 4:01 PM AEST, Michael Tokarev wrote:
..
>>> They certainly fix some parts of target emulation, but what is the
>>> guidance for backporting those type of fixes? Most of the patches I sent
>>> including 2,3 were just found from inspection or new test code and not
>>> real software failing.
>>>
>>> Should just simple ones go in? 32-bit SPRs do not fix entirely the
>>> behaviour of all SPRs, just one aspect. In another fix I had (that
>>> didn't make it in this merge), was a bit more complicated and the
>>> first iteration caused a deadlock that didn't show up in basic test
>>> like booting Linux.
>>>
>>> My guess is that fixes that correct an issue with real software running
>>> on the target should be ported to stable. Perhaps "obviously correct"
>>> small fixes as well. But not sure about larger changes.
>>
>> This is exactly why I asked, - because I don't clearly understand how
>> important these to have in -stable. And also to remind that -stable
>> exist, just in case.. ;)
> 
> Ah okay, makes sense. I was just clarifying myself since I wasn't
> too sure.

We do not have strict rules for stuff which should go to -stable.
In the wiki - https://www.qemu.org/docs/master/devel/stable-process.html -
it is stated as vague as

   If you think the patch would be important for users of the current release
   (or for a distribution picking fixes), it is usually a good candidate for stable.

so things are decided on a case-by-case basis.  Sometimes even spelling
fixes gets picked up, sometimes much larger and invasive changes has to
be picked to fix a real bug.  Once again, there's no strict rules.

Myself, I haven't been in this process before, but I see it from a
downstream PoV, as I maintain qemu in debian for quite some years.

A bug might not be reported by actual users, but if it has good potential
for breaking something, - *maybe* like in this case when qemu behaves
differently than an actual HW (once again, I don't know what the impact
of *these* fixes, or lack thereof, are), - and at the same time the
fix is small, self-contained and "obviously correct" (in other words,
has low potential of breaking something else), - I tend to pick it up,
to bring behavior to match the specs like in this case.

We had this numerous times: something is broken, but apparently no one
uses that. And out of the sudden people start hitting it in real life,
like even qemu itself which uses debian-provided packages in its own CI.
Just to discover this bug is known for a long time and is fixed in master
long ago too.

Sure thing there might be changes which fix more serious issues, but which
are based on some subsystem rewrite, - with these, it's more difficult to
decide what to do - to keep bug or to risk breaking other stuff.  I omitted
a few fixes for 7.2 due to this very situation: when the infrastructure
used in new code did not exist in 7.2 and quite a lot of other changes
needs to be back-ported.

There's always a tradeoff: the "importance" of the bug and the amount of
stuff it requires to back-port. Unimportant fixes (eg, a missing free()
in error path in init function) which require other code changes are
obviously not for -stable.  On the other end, small but important changes
(eg a fix for a crash/deadlock which many users are hitting) is obviously
a good fit for -stable.  And anything in-between is, sure thing, grey,
with all its shades.

This is why we're more dependent on the subsystem maintainers or authors
of the particular changes, - since they know much better when any given
fix is important or not, know much better about possible impact and so on.
Maybe it's just cosmetics which can safely be ignored, or maybe it's a
big thing which is worth to backport other stuff for it to work.
It is also much easier to think about this when you have the context
which you just fixed, still in your mind.

And this is why I'm asking.

Thank you!

/mjt

