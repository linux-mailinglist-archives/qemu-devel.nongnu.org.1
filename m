Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BB57DE68C
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 20:54:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyHHF-0005qo-I7; Wed, 01 Nov 2023 15:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qyHHC-0005pn-Q4; Wed, 01 Nov 2023 15:53:19 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qyHHA-0007AM-4m; Wed, 01 Nov 2023 15:53:18 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 16B446263D;
 Wed,  1 Nov 2023 22:53:09 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b504::1:2b] (unknown
 [2a02:6b8:b081:b504::1:2b])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 7rc3xjHOhmI0-Y31dykAd; Wed, 01 Nov 2023 22:53:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1698868388;
 bh=lHv+Kny6YyX6rRw2zcrW2UTaeMhvXcCzctA6lHRqMTY=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=eEu0SwwJ3CTiCSx2ALZO7PxbR8G9Iyr8fSUSh4ULZavVyFyxwNIwO/g2lnrH02SWf
 QYffZLbovo7VMIk12p5wKtSD35Ro4qyQSdD6wrP4hhHL1lZR6d2eJUjsnb/9Du+piY
 +78c5OI4WUEQreF2M+luH4QNQp2Ofx3OVInubVmc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <1ca2a1ea-4a6c-4fa1-9619-bfa160a8fb95@yandex-team.ru>
Date: Wed, 1 Nov 2023 22:53:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block-jobs: add final flush
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com,
 Evanzhang@archeros.com, den@openvz.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20231004135632.18196-1-vsementsov@yandex-team.ru>
 <fd7da9d6-be5a-40f7-9c59-593ac8de41d1@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <fd7da9d6-be5a-40f7-9c59-593ac8de41d1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 31.10.23 17:05, Hanna Czenczek wrote:
> On 04.10.23 15:56, Vladimir Sementsov-Ogievskiy wrote:
>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> Actually block job is not completed without the final flush. It's
>> rather unexpected to have broken target when job was successfully
>> completed long ago and now we fail to flush or process just
>> crashed/killed.
>>
>> Mirror job already has mirror_flush() for this. So, it's OK.
>>
>> Add similar things for other jobs: backup, stream, commit.
>>
>> Note, that stream has (documented) different treatment of IGNORE
>> action: it don't retry the operation, continue execution and report
>> error at last. We keep it for final flush too.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>
>> Was: [PATCH v4] block-jobs: flush target at the end of .run()
>>    But now rewritten.
>> Supersedes: <20230725174008.1147467-1-vsementsov@yandex-team.ru>
>>
>>   block/backup.c             |  2 +-
>>   block/block-copy.c         |  7 +++++++
>>   block/commit.c             | 16 ++++++++++++----
>>   block/stream.c             | 21 +++++++++++++++++----
>>   include/block/block-copy.h |  1 +
>>   5 files changed, 38 insertions(+), 9 deletions(-)
> 
> [...]
> 
>> diff --git a/block/commit.c b/block/commit.c
>> index aa45beb0f0..5205c77ec9 100644
>> --- a/block/commit.c
>> +++ b/block/commit.c
> 
> [...]
> 
>> @@ -187,7 +187,15 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
>>           }
>>       }
>> -    return 0;
>> +    do {
>> +        ret = blk_co_flush(s->base);
>> +        if (ret < 0) {
>> +            action = block_job_error_action(&s->common, s->on_error,
>> +                                            false, -ret);
>> +        }
>> +    } while (ret < 0 && action != BLOCK_ERROR_ACTION_REPORT);
> 
> Do we need to yield in this loop somewhere so that BLOCK_ERROR_ACTION_STOP can pause the job?
> 

block_job_error_action calls job_pause_locked() itself in this case

-- 
Best regards,
Vladimir


