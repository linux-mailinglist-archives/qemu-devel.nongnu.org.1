Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB38A7DF3E3
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 14:33:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyXp2-0004ov-9N; Thu, 02 Nov 2023 09:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qyXoy-0004oR-Nb; Thu, 02 Nov 2023 09:33:16 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qyXov-0007Am-0S; Thu, 02 Nov 2023 09:33:16 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0f:4c13:0:640:3c7:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id 7E82B60B2F;
 Thu,  2 Nov 2023 16:33:07 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8005::1:a] (unknown
 [2a02:6b8:b081:8005::1:a])
 by mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 6XX5W30OfiE0-r5TsVIfE; Thu, 02 Nov 2023 16:33:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1698931987;
 bh=GKfgYpiDDm/5hDVGGd3u/NJMwW44sWsNlV3VRAdgjWA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Isp7CGYppyOJXVZJclf+H1RCjOZ2n1KjvK36m6a1QICM8fU8w0TwQnFO6SXYciHi4
 YlSWBOKXVj44FpfUid+rC4K2dWFG5iImakAhijaM1wVaUkzrZhh2ADmv3ZSoJKzZBC
 Xlbus2KXvUkc5A1RckG+xkyG0Av6b74D2z/ZyrEw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <6629ff0a-d0c5-47a8-9894-95a22eadbe2c@yandex-team.ru>
Date: Thu, 2 Nov 2023 16:33:06 +0300
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
 <1ca2a1ea-4a6c-4fa1-9619-bfa160a8fb95@yandex-team.ru>
 <069ba523-344e-46ae-aca3-6b401fc840dd@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <069ba523-344e-46ae-aca3-6b401fc840dd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 02.11.23 15:59, Hanna Czenczek wrote:
> On 01.11.23 20:53, Vladimir Sementsov-Ogievskiy wrote:
>> On 31.10.23 17:05, Hanna Czenczek wrote:
>>> On 04.10.23 15:56, Vladimir Sementsov-Ogievskiy wrote:
>>>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>>
>>>> Actually block job is not completed without the final flush. It's
>>>> rather unexpected to have broken target when job was successfully
>>>> completed long ago and now we fail to flush or process just
>>>> crashed/killed.
>>>>
>>>> Mirror job already has mirror_flush() for this. So, it's OK.
>>>>
>>>> Add similar things for other jobs: backup, stream, commit.
>>>>
>>>> Note, that stream has (documented) different treatment of IGNORE
>>>> action: it don't retry the operation, continue execution and report
>>>> error at last. We keep it for final flush too.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>> ---
>>>>
>>>> Was: [PATCH v4] block-jobs: flush target at the end of .run()
>>>>    But now rewritten.
>>>> Supersedes: <20230725174008.1147467-1-vsementsov@yandex-team.ru>
>>>>
>>>>   block/backup.c             |  2 +-
>>>>   block/block-copy.c         |  7 +++++++
>>>>   block/commit.c             | 16 ++++++++++++----
>>>>   block/stream.c             | 21 +++++++++++++++++----
>>>>   include/block/block-copy.h |  1 +
>>>>   5 files changed, 38 insertions(+), 9 deletions(-)
>>>
>>> [...]
>>>
>>>> diff --git a/block/commit.c b/block/commit.c
>>>> index aa45beb0f0..5205c77ec9 100644
>>>> --- a/block/commit.c
>>>> +++ b/block/commit.c
>>>
>>> [...]
>>>
>>>> @@ -187,7 +187,15 @@ static int coroutine_fn commit_run(Job *job, Error **errp)
>>>>           }
>>>>       }
>>>> -    return 0;
>>>> +    do {
>>>> +        ret = blk_co_flush(s->base);
>>>> +        if (ret < 0) {
>>>> +            action = block_job_error_action(&s->common, s->on_error,
>>>> +                                            false, -ret);
>>>> +        }
>>>> +    } while (ret < 0 && action != BLOCK_ERROR_ACTION_REPORT);
>>>
>>> Do we need to yield in this loop somewhere so that BLOCK_ERROR_ACTION_STOP can pause the job?
>>>
>>
>> block_job_error_action calls job_pause_locked() itself in this case
> 
> But that doesn’t really pause the job, does it?  As far as I understand, it increases job->pause_count, then enters the job, and the job is then supposed to yield at some point so job_pause_point_locked() is called, which sees the increased job->pause_count and will actually pause the job.
> 

Oops right, I missed that (not good for block-jobs maintainer :/)
Will resend, thanks for reviewing

-- 
Best regards,
Vladimir


