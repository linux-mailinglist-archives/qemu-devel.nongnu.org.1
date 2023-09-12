Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D172979D9E2
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 22:05:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg9dQ-0005OV-Nj; Tue, 12 Sep 2023 16:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qg9dN-0005Mt-Bj
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 16:05:17 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qg9dG-0000oR-Jv
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 16:05:16 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C4D532138C;
 Tue, 12 Sep 2023 23:05:02 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2A0AD27978;
 Tue, 12 Sep 2023 23:04:58 +0300 (MSK)
Message-ID: <b6aa7a8d-90bd-3211-4091-8ef55c8943b2@tls.msk.ru>
Date: Tue, 12 Sep 2023 23:04:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] tpm: fix crash when FD >= 1024
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20230911132551.1421276-1-marcandre.lureau@redhat.com>
 <dcf26f94-4b0b-e992-1207-a1ee73f21508@linux.ibm.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <dcf26f94-4b0b-e992-1207-a1ee73f21508@linux.ibm.com>
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

12.09.2023 03:08, Stefan Berger wrote:
> 
> On 9/11/23 09:25, marcandre.lureau@redhat.com wrote:
>> From: Marc-Andr޸ Lureau <marcandre.lureau@redhat.com>
>>
>> Replace select() with poll() to fix a crash when QEMU has a large number
>> of FDs.
>>
>> Fixes:
>> https://bugzilla.redhat.com/show_bug.cgi?id=2020133
> 
> For backporting I think we should also add this tag here:
> 
> Fixes:  ca64b08638 ("tpm: Move backend code under the 'backends/' directory")

It's nice to have Fixes tags generally.

Yes, it helps backporting a little bit, but it is mostly about choosing
which changes might be appropriate when there's no to-stable/to-backport
markers/tags whatsoever.  If you already know for sure some change should
be picked up for stable, it's better to add Cc: qemu-stable@.  With Fixes
also in place, besides its usefulness for other purposes, it helps me to
see which older versions needs this, but usually it's relatively easy to
determine even without Fixes: tag.  Many changes picked up for stable do
not have such tag just because there's no single commit which introduced
an issue, or some other situation.
> 
> Though RETRY_ON_EINTR was only introduced in 8.0.0-rc0. What's the right tag for backporting then?

There's no such tag.  If you know already there's possible issue with older
versions (and this is exactly the case), any comment about this might help
for sure.  This your note saved me a compile (which would fail for sure),
after which I would find

commit v7.2.0-538-g8b6aa69365
Author: Nikita Ivanov <nivanov@cloudlinux.com>
Date:   Sun Oct 23 12:04:21 2022 +0300

     Refactoring: refactor TFR() macro to RETRY_ON_EINTR()

the same way I did now.

If you're trying to find a way to make this new fix be "more backportable",
maybe by avoiding using a feature designed especially for this, - I think
this is not productive, the priority is definitely to have better "master",
and think about what to do with earlier versions only after that.

In this case, and in about 5 other examples from today, the thought about
stable releases best be done when introducing wide changes, like this commit
above which replaced TFR with RETRY_ON_EINTR.  Since this new macro will be
used everywhere for sure, the best way would be to split that single patch
into 3: first one introducing the new RETRY_ON_EINTR(), second converting all
users of TFR to RETRY_ON_EINTR, and 3rd (which can be folded into second)
removing TFR which is now unused.  This way I can cherry-pick just the first
patch easily if needed.  But once again, the priority should be master, not
backports.

Thanks,

/mjt

