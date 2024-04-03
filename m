Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE05E897AB3
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Apr 2024 23:30:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs8A6-0003id-Dn; Wed, 03 Apr 2024 17:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rs8A3-0003hN-QQ; Wed, 03 Apr 2024 17:28:47 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rs89z-0006PD-Ot; Wed, 03 Apr 2024 17:28:47 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:72a:0:640:b4cc:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 7636660C5B;
 Thu,  4 Apr 2024 00:28:34 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b679::1:22] (unknown
 [2a02:6b8:b081:b679::1:22])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id USbt7I4Ib4Y0-OpJg0myJ; Thu, 04 Apr 2024 00:28:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1712179713;
 bh=H6SlRy/gl+rOOT9vgW89n+seonm7GIR415yoddbTwbw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=EAf6MEgLPP2qml5WNMxTZhOSaxkZpU+sthWwWKAhm89xB3F5bv4xx661OX1SH1Fcf
 98LoWy3EEbAu8Udj7Gs2mNoSgT/DkJQ273d7/cxn9YDLjP2MPv7BoMRCYMSTwPneKX
 R3QyA+1/Ct5VXG4F+65ee7UhNIIE1dpk6KU4OJ80=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <dfaddc5b-c919-4c57-a6f9-69ffdd2a65a2@yandex-team.ru>
Date: Thu, 4 Apr 2024 00:28:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/19] block/stream: fix -Werror=maybe-uninitialized
 false-positives
To: Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Hyman Huang <yong.huang@smartx.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 John Snow <jsnow@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Bin Meng <bin.meng@windriver.com>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jesper Devantier <foss@defmacro.it>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>
References: <20240328102052.3499331-1-marcandre.lureau@redhat.com>
 <20240328102052.3499331-7-marcandre.lureau@redhat.com>
 <65d791e4-6c68-4b6d-b181-bc3886745ce3@yandex-team.ru>
 <CAJ+F1CLbjZG24rMKwA20NFM=6sTE4CRAaGt4Vha+bP8i=+on-A@mail.gmail.com>
 <0d7344c2-b146-44cf-a911-21fa5e556665@yandex-team.ru>
 <mzls26xlctld3fd5fl3h5wdrbh6hb5i3xcakeslwzny5tva7ch@w6wnruxtefkl>
 <3064bc69-3d8e-4d7c-b640-a7ab703f9575@yandex-team.ru>
 <CAJ+F1CLG+7BT8wLFmmJ0t8NvMu2a2Vp1+p6gUuBTch9haYP8LQ@mail.gmail.com>
 <ba76742d-4fa1-4120-98ad-944845a37ad6@yandex-team.ru>
 <CAJ+F1CKAWpeOKe=8YM38_H6xP5cvDJ0RQXcSvm9LUMLpyo4ndw@mail.gmail.com>
 <7qztxyz6yrjir6odtguvfxnzmvpqfevxd3lnhmjldlk4br6cqc@iens4se43kj5>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <7qztxyz6yrjir6odtguvfxnzmvpqfevxd3lnhmjldlk4br6cqc@iens4se43kj5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 03.04.24 20:50, Eric Blake wrote:
> On Wed, Apr 03, 2024 at 01:24:11PM +0400, Marc-André Lureau wrote:
>>>> Unfortunately, it doesn't work in all cases. It seems to have issues
>>>> with some guards:
>>>> ../block/stream.c: In function ‘stream_run’:
>>>> ../block/stream.c:216:12: error: ‘ret’ may be used uninitialized
>>>> [-Werror=maybe-uninitialized]
>>>>     216 |         if (ret < 0) {
>>>>
> 
> That one looks like:
> 
> int ret;
> WITH_GRAPH_RDLOCK_GUARD() {
>    ret = ...;
> }
> if (copy) {
>    ret = ...;
> }
> if (ret < 0)
> 
> I suspect the compiler is seeing the uncertainty possible from the
> second conditional, and letting it take priority over the certainty
> that the tweaked macro provided for the first conditional.
> 
>>>>
>>>
>>> So, updated macro helps in some cases, but doesn't help here? Intersting, why.
>>>
>>>> What should we do? change the macros + cherry-pick the missing
>>>> false-positives, or keep this series as is?
> 
> An uglier macro, with sufficient comments as to why it is ugly (in
> order to let us have fewer false positives where we have to add
> initializers) may be less churn in the code base, but I'm not
> necessarily sold on the ugly macro.  Let's see if anyone else
> expresses an opinion.
> 
> 
>>>>
>>>>
>>>
>>> I think marco + missing is better. No reason to add dead-initializations in cases where new macros helps.
>>
>> Ok
>>
>>> Still, would be good to understand, what's the difference, why it help on some cases and not help in another.
>>
>> I don't know, it's like if the analyzer was lazy for this particular
>> case, although there is nothing much different from other usages.
>>
>> If I replace:
>> for (... *var2 = (void *)true; var2;
>> with:
>> for (... *var2 = (void *)true; var2 || true;
>>
>> then it doesn't warn..
> 
> but it also doesn't work.  We want the body to execute exactly once,
> not infloop.
> 
> 
>>
>> Interestingly as well, if I change:
>>      for (... *var2 = (void *)true; var2; var2 = NULL)
>> for:
>>      for (... *var2 = GML_OBJ_(); var2; var2 = NULL)
>>
>> GML_OBJ_() simply being &(GraphLockable) { }), an empty compound
>> literal, then it doesn't work, in all usages.
> 
> So the compiler is not figuring out that the compound literal is
> sufficient for an unconditional one time through the for loop body.
> 
> What's worse, different compiler versions will change behavior over
> time.  Making the code ugly to pacify a particular compiler, when that
> compiler might improve in the future, is a form of chasing windmills.
> 
>>
>> All in all, I am not sure the trick of using var2 is really reliable either.
> 
> And that's my biggest argument for not making the macro not more
> complex than it already is.
> 

All sounds reasonable, I'm not sure now.

I still don't like an idea to satisfy compiler false-positive warnings by extra initializations.. Interesting that older versions do have unitialized-use warnings, but don't fail here (or nobody check?). Is it necessary to fix them at all? Older versions of compiler don't produce these warnings?  Is it possible that some optimizations in new GCC version somehow breaks our WITH_ hack, so that it really lead to uninitialized behavior? And we just mask real problem with these patches?

Wouldn't it more correct to just drop WITH_ hack, and move to a bit uglier but more gcc-native and fair

{
    QEMU_LOCK_GUARD(lock);
    ...
}

?

-- 
Best regards,
Vladimir


