Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBE57B626B
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 09:18:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnZfm-0004DB-Ts; Tue, 03 Oct 2023 03:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qnZfh-00049H-VQ; Tue, 03 Oct 2023 03:18:22 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qnZff-0002g3-J3; Tue, 03 Oct 2023 03:18:21 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:d11:0:640:6943:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id DD2ED5FD89;
 Tue,  3 Oct 2023 10:18:10 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b52d::1:13] (unknown
 [2a02:6b8:b081:b52d::1:13])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 9IQSBZ0OkiE0-2HBh8Fk6; Tue, 03 Oct 2023 10:18:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696317490;
 bh=1egp4mHBN+q5/ImumduGJItWiixyXULiVRHfMKgkm+M=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=E7vvgqi11bPoNyehilytpBj8PDene82TssrRVeqvMlaNKgjEHQxktfWMKQ1tURVoK
 OqLkrh2bLIvgabaotbIlTvvhZGRqcyqZHRHlX0H6wyijoaqf5PJwGJ58QT2urfaBZn
 IxJJyfCnIPC+7ihsoUJqBuC6h30jbvU3IRxBkYzc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <5c81072d-1af8-f2b5-0477-342e2e173954@yandex-team.ru>
Date: Tue, 3 Oct 2023 10:18:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] blockdev: qmp_transaction: harden transaction
 properties for bitmaps
To: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, qemu-devel@nongnu.org,
 den@virtuozzo.com
References: <20230904083116.568912-1-andrey.zhadchenko@virtuozzo.com>
 <a8c81f0f-eb3e-0574-e6bb-4fed9005a7e6@yandex-team.ru>
 <867fb4e0-51ad-8572-f6cb-b2ed3791e34f@virtuozzo.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <867fb4e0-51ad-8572-f6cb-b2ed3791e34f@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.321,
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

On 19.09.23 13:02, Andrey Zhadchenko wrote:
> Hi!
> 
> Thanks for the review
> 
> On 9/12/23 21:29, Vladimir Sementsov-Ogievskiy wrote:
>> On 04.09.23 11:31, Andrey Zhadchenko wrote:
>>> Unlike other transaction commands, bitmap operations do not drain target
>>> bds. If we have an IOThread, this may result in some inconsistencies, as
>>> bitmap content may change during transaction command.
>>> Add bdrv_drained_begin()/end() to bitmap operations.
>>>
>>> Signed-off-by: Andrey Zhadchenko<andrey.zhadchenko@virtuozzo.com>
>>
>> Hi!
>>
>> First, please always include cover letter when more than 1 patch.
>>
>> Next. Hmm. Good idea, but I'm afraid that's still not enough.
>>
>> Assume you have two BSs A and B in two different iothreads. So, the sequence may be like this:
>>
>> 1. drain_begin A
>>
>> 2. do operation with bitmap in A
>>
>> 3. guest writes to B, B is modified and bitmap in B is modified as well
>>
>> 4. drain_begin B
>>
>> 5. do operation with bitmap in B
>>
>> 6. drain_end B
>>
>> 7. drain_end A
>>
>> User may expect, that all the operations are done atomically in relation to any guest IO operations. And if operations are dependent, the intermediate write [3] make break the result.
> 
> I see your point, but can the difference really be observed in this case? It is probably only relevant if user can copy/merge bitmaps between block nodes (as far as I know this is not the case for now)

User can (see qmp block-dirty-bitmap-merge). Also consider, for example, starting several backups of all disks, which are in different iothreads. The whole backup should be consistent and should correspond to one point of time, so all backup jobs should be started inside one drained_all section.

> 
>>
>> So, we should drain all participant drives during the whole transactions. The simplest solution is bdrv_drain_all_begin() / bdrv_drain_all_end() pair in qmp_transaction(), could we start with it?
>>
> 
> That would definitely get rig of all problems, but I do not really like the idea of draining unrelated nodes.
> 
> What do you think if I add a new function prototype to the TransactionActionDrv, which will return transaction bds? Then we can get a list of all bds and lock them before prepairing and clean afterwards.

that looks not generic.. Transaction API is not part of block layer, and I'd better not change this. And you add it into TransactionActionDrv, but you'll use it in blockdev.c? You'll have to add somethink like transaction_action() with big switch-case operation. And than no reason to add something to TransactionActionDrv, as that may be just function defined in blockdev.c

-- 
Best regards,
Vladimir


