Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E4497EC32
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Sep 2024 15:23:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssj1T-0002kX-Fo; Mon, 23 Sep 2024 09:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1ssj1M-0002iD-No; Mon, 23 Sep 2024 09:22:32 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1ssj1K-0004eU-UU; Mon, 23 Sep 2024 09:22:32 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 95992A41CDE;
 Mon, 23 Sep 2024 13:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562BBC4CEC4;
 Mon, 23 Sep 2024 13:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727097743;
 bh=Wtc6f2skZb5tnYNkSOitgjzHvVOKfsqbKbsNqiWvi9Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QaMZnWAKarp66s23nRFblKnlZXXhwEN+zED7ZsoxJvzdF69rE0FZPGOXQCqXh6bQ4
 XqIZIJpA9lMDA1p77QmA63VMDwkoDQ/FPQrVVfMHDVTijuiVYs5Vn8xLJV4XN2SoUo
 TyDO2/V2j/DVEBEuaG3Y6tBixlc/78Q8CqNJsXfEa0nsPhZ+cGh0GqaOiSYqrYobJ0
 l7n3DDKZISzcnOL8VqTk7f5WHMlZdVlPPPE0bKCs8M9I5VbQUmwdkG8Guy1GfVvff1
 Zitj1A0OPCppUsVhF2YREbhyDqp0qP8+62k91K+VQw8Hdc8pTk98nZGBI3aUMFSch6
 gWwvmFtzrFdqw==
Message-ID: <bc821290-2003-4795-a5fa-99a7c55e1374@kernel.org>
Date: Mon, 23 Sep 2024 15:22:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/4] qcow2: add zoned emulation capability
To: Sam Li <faithilikerun@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 dmitry.fomichev@wdc.com, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, hare@suse.de, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20240122184830.40094-1-faithilikerun@gmail.com>
 <20240122184830.40094-4-faithilikerun@gmail.com>
 <20240312183010.GB389553@fedora>
 <CAAAx-8LyxDtZra_5TC0CLmq4F4ShYtQqVTF0OCGVZ9tYWP4QMA@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAAAx-8LyxDtZra_5TC0CLmq4F4ShYtQqVTF0OCGVZ9tYWP4QMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=dlemoal@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2024/09/23 13:06, Sam Li wrote:

[...]

>>> @@ -2837,6 +3180,19 @@ qcow2_co_pwritev_part(BlockDriverState *bs, int64_t offset, int64_t bytes,
>>>          qiov_offset += cur_bytes;
>>>          trace_qcow2_writev_done_part(qemu_coroutine_self(), cur_bytes);
>>>      }
>>> +
>>> +    if (bs->bl.zoned == BLK_Z_HM) {
>>> +        index = start_offset / zone_size;
>>> +        wp = &bs->wps->wp[index];
>>> +        if (!QCOW2_ZT_IS_CONV(*wp)) {
>>> +            /* Advance the write pointer when the write completes */
>>
>> Updating the write pointer after I/O does not prevent other write
>> requests from beginning at the same offset as this request. Multiple
>> write request coroutines can run concurrently and only the first one
>> should succeed. The others should fail if they are using the same
>> offset.
>>
>> The comment above says "Real drives change states before it can write to
>> the zone" and I think it's appropriate to update the write pointer
>> before performing the write too. The qcow2 zone emulation code is
>> different from the file-posix.c passthrough code. We are responsible for
>> maintaining zoned metadata state and cannot wait for the result of the
>> I/O to tell us what happened.

Yes, correct. The wp MUST be updated when issuing the IO, with the assumption
that the write IO will succeed (errors are rare !).

> The problem of updating the write pointer before IO completion is the
> failure case.  It can't be predicted in advance if an IO fails or not.
> When write I/O fails, the wp should not be updated.

Correct, if an IO fails, the wp should not be updated. However, that is not
difficult to deal with:
1) under the zone lock, advance the wp position when issuing the write IO
2) When the write IO completes with success, nothing else needs to be done.
3) When *any* write IO completes with error you need to:
	- Lock the zone
	- Do a report zone for the target zone of the failed write to get the current
wp location
	- Update bs->wps->wp[index] using that current wp location
	- Unlock the zone

With that, one may get a few errors if multiple async writes are being issued,
but that behavior is consistent with the same happening with a real drive. So no
issue. And since the report zones gets you the current wp location, the user can
restart writing from that location once it has dealt with all the previous write
failures.

> The alternative way is to hold the wps lock as is also required for wp
> accessing. Therefore only one of multiple concurrent write requests
> will succeed.

That is a very simple solution that avoids the above error recovery, but that
would be very bad for performance (especially for a pure sequential write
workload as we would limit IOs to quue depth 1). So if we can avoid this simple
approach, that would be a lot better.


-- 
Damien Le Moal
Western Digital Research

