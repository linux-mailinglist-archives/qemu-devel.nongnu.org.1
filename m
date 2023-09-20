Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8331F7A8DF8
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 22:46:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj45O-0003PX-3a; Wed, 20 Sep 2023 16:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qj45H-0003PD-IJ
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:46:07 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qj45C-0003rj-KQ
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 16:46:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B174123BC6;
 Wed, 20 Sep 2023 23:46:19 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D53CB29850;
 Wed, 20 Sep 2023 23:45:57 +0300 (MSK)
Message-ID: <688aae83-b8fb-5867-2451-dc0c67fe9319@tls.msk.ru>
Date: Wed, 20 Sep 2023 23:45:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: stable-8.1.1: which bug do we keep?
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <84f08f14-7911-4cdc-04e6-548287349d00@tls.msk.ru>
 <ZQq4kMVHNtxeVH6o@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <ZQq4kMVHNtxeVH6o@redhat.com>
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

20.09.2023 12:17, Daniel P. Berrangé wrote:
> On Wed, Sep 20, 2023 at 07:46:36AM +0300, Michael Tokarev wrote:
>> Hi!
>>
>> I'm in somewhat doubt what to do with 8.1.1 release.
>>
>> There are 2 compelling issues, fixing one discovers the other.
>>
>> https://gitlab.com/qemu-project/qemu/-/issues/1864
>> "x86 VM with TCG and SMP fails to start on 8.1.0"
>> is fixed by 0d58c660689f "softmmu: Use async_run_on_cpu in tcg_commit"
>>
>> But this brings up
>>
>> https://gitlab.com/qemu-project/qemu/-/issues/1866
>> "mips/mip64 virtio broken on master (and 8.1.0 with tcg fix)"
>> (which is actually more than mips, as I've shown down the line,
>> https://gitlab.com/qemu-project/qemu/-/issues/1866#note_1558221926 )
...

> In the cover letter for the 2nd proposed series Richard says
> 
> [quote]
> I've done a tiny bit of performance testing between the two
> solutions and it seems to be a wash.  So now it's simply a
> matter of cleanliness.
> [/quote]
> 
> Since the 2nd series is shown to still be broken in some cases
> and 1st is thought to solve them all, IMHO it feels like we
> should just press ahead with applying the the 1st series to
> git master, and then stable.
> 
> If we still want a cleaner solution, it can be reverted/replaced
> later once someone figures out an option that addresses all the
> problems. We shouldn't leave such a big regression in TCG unfixed
> for so long while we figure out a cleaner option.

Daniel, you have a very good point here.

I just collected the first version of Richard's fixes (with Phil's
changes and tags), added them to qemu debian package and pushed that
one out, - debian has much wider CI than qemu has, hopefully it will
clear things out.

Also I pushed them to staging-8.1 branch for qemu ci run.  This obviously
should not go to current stable-8.1 since these fixes aren't in master.

The only thing I regret is that his simple thing didn't occur to me
much earlier (and actually didn't occur to me at all).

Let's see..

>> To mee, it *feels* like 0d58c660689f should be there.
>> Note: the scheduled deadline for staging-8.1.1 is gone yesterday.
>> But this stuff seems to be important enough to delay 8.1.1 further.
> 
> On the one hand breaking x86 is a big deal because it is a mainstream
> architecture, on the other hand people have real x86 hardware, so
> using TCG emulation for x86 is less compelling. I agree we need to
> fully address this in 8.1.1.

As it turns out, quite a lot of various CI stuff uses qemu in tcg
mode behind the scenes.

> I guess the other unmentioned option is to revert whatever TCG changes
> went into 8.1 that caused the regression in the first place. I've no
> idea if that is at all practical though.

This does not seem to be practical.  I did find commit which broke (some)
things, but it isn't easy to revert it now.  IIRC anyway.

Thank you for the excellent hint!

/mjt

