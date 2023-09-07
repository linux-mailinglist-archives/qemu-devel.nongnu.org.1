Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAAE797CB2
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 21:28:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeKex-00065b-7a; Thu, 07 Sep 2023 15:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeKet-00064X-8y; Thu, 07 Sep 2023 15:27:19 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qeKeq-0006fZ-MB; Thu, 07 Sep 2023 15:27:19 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 830EF1FDFC;
 Thu,  7 Sep 2023 22:28:00 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A9B4B266E4;
 Thu,  7 Sep 2023 22:27:12 +0300 (MSK)
Message-ID: <31abec70-e93d-a504-b084-6e1116e7362a@tls.msk.ru>
Date: Thu, 7 Sep 2023 22:27:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH for-8.2 0/2] ppc: get rid of free() (gitlab #1798)
Content-Language: en-US
To: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org
References: <20230728195646.168997-1-danielhb413@gmail.com>
 <CAFEAcA-79hxq7Uxne1wRx_waWkCy75ObKw5+krtbp-aTbxFkoQ@mail.gmail.com>
 <6dc430f0-07d0-81d6-2639-5d03231f203b@gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <6dc430f0-07d0-81d6-2639-5d03231f203b@gmail.com>
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

30.07.2023 20:13, Daniel Henrique Barboza wrote:
> 
> 
> On 7/29/23 12:35, Peter Maydell wrote:
>> On Fri, 28 Jul 2023 at 21:57, Daniel Henrique Barboza
>> <danielhb413@gmail.com> wrote:
>>> Here's some trivial changes following Peter's call to arms against
>>> free() and friends in gitlab issue #1798 in an attempt to enforce
>>> our memory management guidelines [1].
>>
>> To clarify, this isn't a "call to arms". The issue is marked up as
>> a "bite-sized task", which is to say that it's a potential easy
>> place to start for newcomers to the community who might be making
>> their first contribution to the codebase. The changes it suggests
>> aren't urgent; at most they're a nice-to-have, since glib
>> guarantees that you can mix malloc/free and g_malloc/g_free.
> 
> I failed to realized it was a byte sized task :/ and my Coccinelle comment
> in the bug makes me fell dumb hehe (given that Coccinelle is not newcomer
> friendly).
> 
>>
>> We've had this sitting around as a suggestion on the wiki page
>> for bite-sized-tasks for years, and occasionally people come
>> through and have a go at it. I wanted to clean up and expand
>> on the description of what we had in mind for the change, to
>> give those people a better chance of successfully completing
>> the task.
> 
> What we can do then, since I already sent these, is perhaps link these patches
> as example/template in the gitlab issue later on.

Applied to my trivial-patches branch adding suggested commit comment
fixes while at it, hopefully there's nothing more to do :)

Thanks,

/mjt

