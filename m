Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CA07A0557
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 15:17:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgmDY-00022Q-Hs; Thu, 14 Sep 2023 09:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgmDB-0001wB-Pj; Thu, 14 Sep 2023 09:16:49 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgmD9-00008m-M8; Thu, 14 Sep 2023 09:16:49 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BD52021E7C;
 Thu, 14 Sep 2023 16:16:50 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D2568281AA;
 Thu, 14 Sep 2023 16:16:42 +0300 (MSK)
Message-ID: <76815283-496e-9806-1c26-f659abcf7976@tls.msk.ru>
Date: Thu, 14 Sep 2023 16:16:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] hw/cxl: Fix out of bound array access
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-stable <qemu-stable@nongnu.org>
References: <20230913101055.754709-1-frolov@swemel.ru>
 <fb3f6b07-3310-f008-a512-1d155e21c024@tls.msk.ru>
 <79f03e2f-4cc9-fd44-1101-0dd8a398ff42@tls.msk.ru>
 <15f6d627-b88a-f6a0-abb8-70ec5198fd45@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <15f6d627-b88a-f6a0-abb8-70ec5198fd45@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

14.09.2023 15:59, Philippe Mathieu-Daudé wrote:

>> Cc: qemu-stable@nongnu.org
>> for stable-8.1.
> 
> [not related to this particular patch]
> 
> Maybe this can help if we specify the releases range as a comment
> in the Cc tag, for example here:
> 
> Cc: qemu-stable@nongnu.org # v8.1
> 
> and if it were a range:
> 
> Cc: qemu-stable@nongnu.org # v6.2 to v8.0
> 
> Michael would that help? If so feel free to modify
> docs/devel/stable-process.rst :)

I don't think this is necessary so far.

Or, actually it might help for sure, but it is an extra burden
for regular developers.

For quite some things I can see where it is applicable if there's
a proper Fixes: tag already (that's why I've added this Cc), - it's
trivial to run `git describe' for this commit ID, so it doesn't even
need to have a Cc: stable.

In some cases though it is hard to tell how deep a change needs to
be backported. In such cases some hint can help for sure, but when
in doubt I can ask too.  When you're in context of fixing something,
you usually don't want to think about how to backport it or somesuch,
you concentrate on the fix itself. If you're willing to think about
that too, give a small note in the comment, like some authors do.
If not, and it's entirely okay, and it's unclear if the change should
be applied to earlier versions, I can ask (or notify when picking the
change up for stable), and the author might think about this in another
context.  It's not often - so far anyway - when it's unclear if a
change should be propagated to older releases.

Changing stable-process.rst isn't very useful, as most changes are
changing master, - if anything, regular "contribution" docs should
be changed for that.  But since most stuff is going on through various
subsystem maintainers, they don't usually look there anyway :)

For now, it's basically my own whim to provide stable series for
older qemu releases.  Or an experiment.  I don't know how useful it
is (or will be) and how it will go long-term.  We've never had this
before.

In my view it is much more important to either add the Fixes: tag
(which gives me a hint already, as I check for all Fixes: in patches
being applied, and can automate this further by doing git-desc on
the hashes, alerting me if it is before the current release) or realize
something needs to go to stable at all. Even at the cost of sending
extra stuff to stable which is actually not needed at all - this is
entirely okay.  This is why I'm asking about various changes going
in, reminding about -stable existance, - because some stuff isn't
marked as a fix at all but in fact it is an important thing for
stable (one or another).

Thank you for your support Phil! :)

/mjt

