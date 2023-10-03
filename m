Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1787B65EB
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 11:54:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnc6F-0004Iv-Tb; Tue, 03 Oct 2023 05:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qnc6B-0004IO-CK; Tue, 03 Oct 2023 05:53:51 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qnc69-0000ne-BM; Tue, 03 Oct 2023 05:53:51 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:d11:0:640:6943:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id D6B08607FB;
 Tue,  3 Oct 2023 12:53:44 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b52d::1:13] (unknown
 [2a02:6b8:b081:b52d::1:13])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id grSUxg0OlCg0-mZ5eHZFM; Tue, 03 Oct 2023 12:53:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696326823;
 bh=nrO0hjG5+ysp1vxgk01K30HUfv/9H4Dr7GOwb39OR80=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=nTgCtOT4etL/Cus95/L53nlyC9yP3mcqQYcDuHv60tnR0YAm52ZNjR3mndk7dPVoZ
 zMs5xdTtpB3TXjYwrC4M9VNEDfD0BleQzGPfe+hPBJb8AHLvL8QIi2TkmDkQl3WNF5
 yelQjsW7TaVsWrRm0tJqnDBe0EPkpe2RT7qjsV+k=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <9b93ef58-98c1-82f1-785c-a499f470772a@yandex-team.ru>
Date: Tue, 3 Oct 2023 12:53:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] block-jobs: flush target at the end of .run()
Content-Language: en-US
To: Evanzhang <Evanzhang@archeros.com>
Cc: den@openvz.org, hreitz@redhat.com, jsnow@redhat.com, kwolf@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, vsementsov@virtuozzo.com
References: <20230725174008.1147467-1-vsementsov@yandex-team.ru>
 <20230803024346.1446-1-Evanzhang@archeros.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20230803024346.1446-1-Evanzhang@archeros.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.321,
 RCVD_IN_DNSWL_NONE=-0.0001, SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001,
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

On 03.08.23 05:43, Evanzhang wrote:
> [...]
> 
>> diff --git a/block/mirror.c b/block/mirror.c
>> index d3cacd1708..cd19b49f7f 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -1143,6 +1143,10 @@ immediate_exit:
>>      g_free(s->in_flight_bitmap);
>>      bdrv_dirty_iter_free(s->dbi);
>>
>> +    if (ret >= 0) {
>> +        ret = block_job_final_target_flush(&s->common, blk_bs(s->target));
>> +    }
>> +
>>      if (need_drain) {
>>          s->in_drain = true;
>>          bdrv_drained_begin(bs);
> 
> hi,I use gdb tested drive-mirror，break block_job_final_target_flush,
> mirror_run  was not called it.
> qmp command:
> {"execute": "drive-mirror","arguments": {"device": "drive-virtio1","target":
> "./data1.test","sync": "full"}}

Sorry for long answer. I"m going to resend a new version soon.

I now checked, and I see that block_job_final_target_flush() is called.

But it is called after executing block-job-complete command.

> 
>> --- a/include/block/blockjob_int.h
>> +++ b/include/block/blockjob_int.h
>> @@ -152,4 +152,15 @@ void block_job_ratelimit_sleep(BlockJob *job);
>> BlockErrorAction block_job_error_action(BlockJob *job, BlockdevOnError on_err,
>>                                          int is_read, int error);
>>
>> +/**
>> + * block_job_final_target_flush:
>> + * @job: The job to signal an error for if flush failed.
>> + * @target_bs: The bs to flush.
>> + *
>> + * The function is intended to be called at the end of .run() for any data
>> + * copying job.
>> + */
>> +int coroutine_fn
>> +block_job_final_target_flush(BlockJob *job, BlockDriverState *target_bs);
>> +
>> #endif
>> -- 
>> 2.34.1

-- 
Best regards,
Vladimir


