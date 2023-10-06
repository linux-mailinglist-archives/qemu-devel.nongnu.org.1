Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 267137BBE78
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 20:12:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qopHh-0001JK-5a; Fri, 06 Oct 2023 14:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qopHe-0001Dt-Ja; Fri, 06 Oct 2023 14:10:42 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qopHc-0007lE-6X; Fri, 06 Oct 2023 14:10:42 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0f:4c13:0:640:3c7:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id 8042E60B9C;
 Fri,  6 Oct 2023 21:10:34 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:a512::1:22] (unknown
 [2a02:6b8:b081:a512::1:22])
 by mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id WAeapP6Or8c0-2tlADJhZ; Fri, 06 Oct 2023 21:10:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696615833;
 bh=Byil5M+tk0imClcoo6eS57TrHmdXqN2HYkci+FILJr0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=ngNCXAtHxccNbuTteiiqjmj1u2189BdLuAErIUkSvZwQmJCfa6NG1kefH6wdGBH+a
 wTSX23ryiRFp2uOFkvW1jniQZOrj/ZjD2bbIbamtozkUOKt5IDlzMYekFOVBPwwM82
 ArDWDlTxq5dDhpQrlHo+6ymp6+/72mU8pTDPGyHw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f210d1fd-5a4e-43a5-b76b-553e74708a5f@yandex-team.ru>
Date: Fri, 6 Oct 2023 21:10:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/21] preallocate: Don't poll during permission updates
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, eblake@redhat.com,
 eesposit@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org,
 "Denis V. Lunev" <den@openvz.org>
References: <20230911094620.45040-1-kwolf@redhat.com>
 <20230911094620.45040-4-kwolf@redhat.com>
 <969ae041-3c17-475c-919c-5b33cb6d21c5@yandex-team.ru>
 <ZR/LoVGIt3BQ45ek@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <ZR/LoVGIt3BQ45ek@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 06.10.23 11:56, Kevin Wolf wrote:
> Am 05.10.2023 um 21:55 hat Vladimir Sementsov-Ogievskiy geschrieben:
>> On 11.09.23 12:46, Kevin Wolf wrote:
>>> When the permission related BlockDriver callbacks are called, we are in
>>> the middle of an operation traversing the block graph. Polling in such a
>>> place is a very bad idea because the graph could change in unexpected
>>> ways. In the future, callers will also hold the graph lock, which is
>>> likely to turn polling into a deadlock.
>>>
>>> So we need to get rid of calls to functions like bdrv_getlength() or
>>> bdrv_truncate() there as these functions poll internally. They are
>>> currently used so that when no parent has write/resize permissions on
>>> the image any more, the preallocate filter drops the extra preallocated
>>> area in the image file and gives up write/resize permissions itself.
>>>
>>> In order to achieve this without polling in .bdrv_check_perm, don't
>>> immediately truncate the image, but only schedule a BH to do so. The
>>> filter keeps the write/resize permissions a bit longer now until the BH
>>> has executed.
>>>
>>> There is one case in which delaying doesn't work: Reopening the image
>>> read-only. In this case, bs->file will likely be reopened read-only,
>>> too, so keeping write permissions a bit longer on it doesn't work. But
>>> we can already cover this case in preallocate_reopen_prepare() and not
>>> rely on the permission updates for it.
>>
>> Hmm, now I found one more "future" case.
>>
>> I now try to rebase my "[PATCH v7 0/7] blockdev-replace"
>> https://patchew.org/QEMU/20230421114102.884457-1-vsementsov@yandex-team.ru/
>>
>> And it breaks after this commit.
>>
>> By accident, blockdev-replace series uses exactly "preallocate" filter
>> to test insertion/removing of filters. And removing is broken now.
>>
>> Removing is done as follows:
>>
>> 1. We have filter inserted: disk0 -file-> filter -file-> file0
>>
>> 2. blockdev-replace, replaces file child of disk0, so we should get the picture*: disk0 -file-> file0 <-file- filter
>>
>> 3. blockdev-del filter
>>
>>
>> But step [2] fails, as now preallocate filter doesn't drop permissions
>> during the operation (postponing this for a while) and the picture* is
>> impossible. Permission check fails.
>>
>> Hmmm... Any idea how blockdev-replace and preallocate filter should
>> work :) ? Maybe, doing truncation in .drain_begin() will help? Will
>> try
> 
> Hm... What preallocate tries to do is really tricky...
> 
> Of course, the error is correct, this is an invalid configuration if
> preallocate can still resize the image. So it would have to truncate the
> file earlier, but the first time that preallocate knows of the change is
> already too late to run requests.
> 
> Truncating on drain_begin feels more like a hack, but as long as it does
> the job... Of course, this will have the preallocation truncated away on
> events that have nothing to do with removing the filter. It's not
> necessarily a disaster because preallocation is only an optimisation,
> but it doesn't feel great.

Hmm, yes, that's not good.

> 
> Maybe let's take a step back: Which scenario is the preallocate driver
> meant for and why do we even need to truncate the image file after
> removing the filter? I suppose the filter doesn't make sense with raw
> images because these are fixed size anyway, and pretty much any other
> image format should be able to tolerate a permanently rounded up file
> size. As long as you don't write to the preallocated area, it shouldn't
> take space either on any sane filesystem.
> 
> Hmm, actually both VHD and VMDK can have footers, better avoid it with
> those... But if truncating the image file on close is critical, what do
> you do on crashes? Maybe preallocate should just not be considered
> compatible with these formats?
> 

Originally preallocate filter was made to be used with qcow2, on some proprietary storage, where:

1. Allocating of big chunk works a lot fater than allocating several smaller chunks
2. Holes are not free and/or file length is not free, so we really want to truncate the file back on close

Den, correct me if I'm wrong.

Good thing is that in this scenario we don't need to remove the filter in runtime, so there is no problem.


Now I think that the generic solution is just add a new handler .bdrv_pre_replace, so blockdev-replace may work as follows:

drain_begin

call .bdrv_pre_replace for all affected nodes

do the replace

drain_end

And prellocate filter would do truncation in this .bdrv_pre_replace handler and set some flag, that we have nothing to trunctate (the flag is automatically cleared on .drained_end handler). Then during permission update if we see that nothing-to-truncate flag, we can drop permissions immediately.

But this difficulty may be postponed, and I can just document that preallocate filter doesn't support removing in runtime (and modify the test to use another filter, or just not to remove preallocate filter).

-- 
Best regards,
Vladimir


