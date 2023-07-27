Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F907765BE2
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 21:09:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP5uu-00011v-2F; Thu, 27 Jul 2023 14:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qP5ug-0000yn-4P; Thu, 27 Jul 2023 14:40:39 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qP5uc-0002sR-74; Thu, 27 Jul 2023 14:40:36 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:6284:0:640:e19:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 3DD465E7F6;
 Thu, 27 Jul 2023 21:40:20 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b68f::1:38] (unknown
 [2a02:6b8:b081:b68f::1:38])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id IeR0w30OqKo0-89JIeQwz; Thu, 27 Jul 2023 21:40:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1690483219; bh=6Wd6CmyMoIICcUnrGoGqcL+JVe/fBSXReUjMV48J2sQ=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=CzqDuON0DhCCWzby1LF2zA9Cj6HQjYGwKVtTOz6A+RTORew2GbwkKTqwpgW6W6W0W
 zyj4U9EYY3aPumBsVZEzfaStIAO2rFPQH4X/FWp8mjlmTYrhoJ10j1j6NZgQNrNuLH
 ztAQqfRLCn801x2TpJvCjhyFXSa9OnUehumu09oA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0f010ccf-24c5-e9cc-e320-163c09e42504@yandex-team.ru>
Date: Thu, 27 Jul 2023 21:40:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] block-jobs: flush target at the end of .run()
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com,
 den@openvz.org, Evanzhang@archeros.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20230725174008.1147467-1-vsementsov@yandex-team.ru>
 <7cb8aa1d-7f65-cc15-4d9c-b195e464f8c3@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <7cb8aa1d-7f65-cc15-4d9c-b195e464f8c3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 27.07.23 18:27, Hanna Czenczek wrote:
> On 25.07.23 19:40, Vladimir Sementsov-Ogievskiy wrote:
>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> Actually block job is not completed without this final flush. It's
>> rather unexpected to have broken target when job was successfully
>> completed long ago and now we fail to flush or process just
>> crashed/killed.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   block/backup.c               |  7 +++++--
>>   block/commit.c               |  2 +-
>>   block/mirror.c               |  4 ++++
>>   block/stream.c               |  7 ++++++-
>>   blockjob.c                   | 18 ++++++++++++++++++
>>   include/block/blockjob_int.h | 11 +++++++++++
>>   6 files changed, 45 insertions(+), 4 deletions(-)
> 
> Yes, that’s a good change.
> 
> [...]
> 
>> diff --git a/block/stream.c b/block/stream.c
>> index e522bbdec5..f7e8b35e94 100644
>> --- a/block/stream.c
>> +++ b/block/stream.c
> 
> [...]
> 
>> @@ -207,6 +207,11 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
>>           }
>>       }
>> +    ret = block_job_final_target_flush(&s->common, s->target_bs);
>> +    if (error == 0) {
>> +        error = ret;
>> +    }
> 
> In all other jobs, this function is invoked only if the job was successful, but here it’s called unconditionally.  I don’t mind one way or the other, but I think it should be consistent.  (Mainly just because inconsistency makes me wonder whether there’s an undocumented reason for it.)

The inconsistency is preexisting: stream job do return error even when there were ignored errors. I'm not sure do we really need this logic for stream job, but decided to flush anyway. It looks consistent in context of stream_run: it continues copy operations even when error is already < 0. So, let's do flush too.

> 
>> +
>>       /* Do not remove the backing file if an error was there but ignored. */
>>       return error;
>>   }
>> diff --git a/blockjob.c b/blockjob.c
>> index 25fe8e625d..313e586b0d 100644
>> --- a/blockjob.c
>> +++ b/blockjob.c
>> @@ -611,3 +611,21 @@ AioContext *block_job_get_aio_context(BlockJob *job)
>>       GLOBAL_STATE_CODE();
>>       return job->job.aio_context;
>>   }
>> +
>> +int coroutine_fn
>> +block_job_final_target_flush(BlockJob *job, BlockDriverState *target_bs)
>> +{
>> +    int ret;
>> +
> 
> Should we mark this as IO_CODE()?

I'm not sure, but seems that yes.

> 
>> +    WITH_GRAPH_RDLOCK_GUARD() {
>> +        ret = bdrv_co_flush(target_bs);
>> +    }
>> +
>> +    if (ret < 0 && !block_job_is_internal(job)) {
>> +        qapi_event_send_block_job_error(job->job.id,
>> +                                        IO_OPERATION_TYPE_WRITE,
>> +                                        BLOCK_ERROR_ACTION_REPORT);
>> +    }
> 
> Would it make sense to rely on block_job_error_action() instead?  If so, should we use the on-target-error setting?

Hmm. To be honest we should. And handle the returned action appropriately. I'll resend, that's a good caught.

> 
> I have no informed opinion on this, but I think using block_job_error_action() does come to mind, so if we consciously decide against it, that’s probably worth a comment, too.
> 
> Hanna
> 
>> +
>> +    return ret;
>> +}
> 

-- 
Best regards,
Vladimir


