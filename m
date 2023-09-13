Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A418079EB79
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 16:46:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgR6o-00063T-Pr; Wed, 13 Sep 2023 10:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qgR6k-000635-V3
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:44:47 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qgR6i-0006d3-3R
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:44:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 24B2621818;
 Wed, 13 Sep 2023 17:44:45 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E3A7027D02;
 Wed, 13 Sep 2023 17:44:38 +0300 (MSK)
Message-ID: <8d2bac35-0b73-bc28-0f22-558e69619462@tls.msk.ru>
Date: Wed, 13 Sep 2023 17:44:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: Various changes "backportability"
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <70f869ab-3e87-92c4-3df3-6aa5a0e9e1f0@tls.msk.ru>
 <CAJSP0QWT9FsGaiTXnionp8FhADxtn1haQ-e1id933HwEcTvgPA@mail.gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CAJSP0QWT9FsGaiTXnionp8FhADxtn1haQ-e1id933HwEcTvgPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

13.09.2023 17:27, Stefan Hajnoczi wrote:
...
>> For example, recent tpm bugfix, which is trivial by its own,
>> uses RETRY_ON_EINTR helper which were introduced recently and
>> which is now used everywhere.  coroutine_fn et al markers is
>> another example, translator_io_start is yet another, and so
>> on and so on.

> The general concept makes sense to me but I'm not sure what the
> specific issue with adding (?) coroutine_fn was. Can you link to the
> patch that caused difficulties so I can review it?

There's nothing really exciting here, and coroutine_fn example isn't
a best one really.  I'm talking about this:

https://gitlab.com/mjt0k/qemu/-/commit/c5034f827726f5876234bf4c6a0fab648fd8b020

which is a current back-port of 92e2e6a867334a990f8d29f07ca34e3162fdd6ec
"virtio: Drop out of coroutine context in virtio_load()":

https://gitlab.com/mjt0k/qemu/-/commit/92e2e6a867334a990f8d29f07ca34e3162fdd6ec

This is a bugfix which I tried to cherry-pick (btw, I dunno yet if it should
go to 8.0 or 7.2 to begin with, asked this in another email, but it still
serves as an example).  Original patch adds coroutine_mixed_fn to some existing
functions and to a newly added function.

The patch introducing coroutine_mixed_fn marker is v7.2.0-909-g0f3de970 .
This is actually a very good example of a way how things are done best,
an excellent example of what I'm talking here, - this 0f3de970 only introduces
the new concept (to be widely used), not converting everything to it
right away.  So it's a good example of how things can be done right.

But this 0f3de970 change is based on earlier change which split things up
and moved stuff from one place to another, and which is too large to
backport.  So even if 0f3de970 did an excellent job, it is still of no
use in this context.

I decided to drop coroutine_mixed_fn markings in the fix for 7.2 in this
context, - again, if this particular fix is needed there to begin with,
which is a question unrelated to this topic.


A better example is a trivial thing with RETRY_ON_EINTR introduction.
A trivial macro which replaced TFR in

commit 37b0b24e933c18269dddbf6b83f91823cacf8105
Author: Nikita Ivanov <nivanov@cloudlinux.com>
Date:   Sun Oct 23 12:04:22 2022 +0300

     error handling: Use RETRY_ON_EINTR() macro where applicable

if this change were split into two, first introducing the new macro
and second converting existing code & removing old macro, it'd be
possible to just cherry-pick the first part and thered' be no need
to modify further cherry-picks which uses RETRY_ON_EINTR.

But once again, this all is definitely not as important as getting
good code into main :)

Thanks,

/mjt

