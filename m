Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2015E7D3441
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 13:37:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qutFl-0006X6-5I; Mon, 23 Oct 2023 07:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qutFX-00060l-Hw; Mon, 23 Oct 2023 07:37:35 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qutFU-0004vN-2Y; Mon, 23 Oct 2023 07:37:34 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id F2D3C44424;
 Mon, 23 Oct 2023 13:37:28 +0200 (CEST)
Message-ID: <92c65eb0-a069-48ea-9cbb-f8dd27b1f632@proxmox.com>
Date: Mon, 23 Oct 2023 13:37:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] mirror: implement mirror_change method
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
References: <20231013092143.365296-1-f.ebner@proxmox.com>
 <20231013092143.365296-6-f.ebner@proxmox.com> <ZTAO+TJuztCHDsUW@redhat.com>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <ZTAO+TJuztCHDsUW@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Am 18.10.23 um 18:59 schrieb Kevin Wolf:
> Am 13.10.2023 um 11:21 hat Fiona Ebner geschrieben:
>> which allows switching the @copy-mode from 'background' to
>> 'write-blocking'.
>>
>> This is useful for management applications, so they can start out in
>> background mode to avoid limiting guest write speed and switch to
>> active mode when certain criteria are fulfilled.
>>
>> In presence of an iothread, the copy_mode member is now shared between
>> the iothread and the main thread, so turn accesses to it atomic.
>>
>> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
>> ---
>>
>> Changes in v3:
>>     * turn accesses to copy_mode atomic and...
>>     * ...slightly adapt error handling in mirror_change as a
>>       consequence
> 
> It would be good to have a comment at the field declaration that it's
> meant to be accessed with atomics.
> 
> As we don't have further synchonisation, is the idea that during the
> switchover it basically doesn't matter if we read the old or the new
> value?
> 
> After reading the whole patch, it seems that the field is only ever
> written under the BQL, while iothreads only read it, and only once per
> request (after the previous patch). This is why no further
> synchonisation is needed. If other threads could write it, too,
> mirror_change() would probably have to be more careful. As the code
> depends on this, adding that to the comment would be useful, too.
> 

Will do in v4.

>>  block/mirror.c       | 33 ++++++++++++++++++++++++++++++---
>>  qapi/block-core.json | 13 ++++++++++++-
>>  2 files changed, 42 insertions(+), 4 deletions(-)
>>
>> diff --git a/block/mirror.c b/block/mirror.c
>> index 8992c09172..889cce5414 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -1075,7 +1075,7 @@ static int coroutine_fn mirror_run(Job *job, Error **errp)
>>                   */
>>                  job_transition_to_ready(&s->common.job);
>>              }
>> -            if (s->copy_mode != MIRROR_COPY_MODE_BACKGROUND) {
>> +            if (qatomic_read(&s->copy_mode) != MIRROR_COPY_MODE_BACKGROUND) {
>>                  s->actively_synced = true;
>>              }
> 
> What resets s->actively_synced when we switch away from active mode?
> 
>>  
>> @@ -1246,6 +1246,32 @@ static bool commit_active_cancel(Job *job, bool force)
>>      return force || !job_is_ready(job);
>>  }
>>  
>> +static void mirror_change(BlockJob *job, BlockJobChangeOptions *opts,
>> +                          Error **errp)
>> +{
>> +    MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
>> +    BlockJobChangeOptionsMirror *change_opts = &opts->u.mirror;
>> +    MirrorCopyMode current;
> 
> This is GLOBAL_STATE_CODE(), right? Let's be explicit about it.
> 

Maybe it wouldn't need to be if we also set actively_synced to false in
bdrv_mirror_top_do_write() if/when setting the bitmap. Thinking about
it, that change shouldn't hurt in any case. But sure, I'll add the
GLOBAL_STATE_CODE annotation here. If ever required not to be
GLOBAL_STATE_CODE code, it can still be adapted later.

>> +
>> +    if (qatomic_read(&s->copy_mode) == change_opts->copy_mode) {
>> +        return;
>> +    }
>> +
>> +    if (change_opts->copy_mode != MIRROR_COPY_MODE_WRITE_BLOCKING) {
>> +        error_setg(errp, "Change to copy mode '%s' is not implemented",
>> +                   MirrorCopyMode_str(change_opts->copy_mode));
>> +        return;
>> +    }
> 
> Ah, ok, we don't even allow the switch I was wondering about above. What
> would be needed, apart from removing this check, to make it work?
> 

Of course, setting actively_synced to false, as you pointed out above.
But I think it would also require more synchronization, because I think
otherwise the iothread could still read the old value of copy_mode (as
MIRROR_COPY_MODE_WRITE_BLOCKING) right afterwards and might set
actively_synced to true again. Do you want me to think it through in
detail and allow the change in the other direction too? I guess that
would also require using the job mutex instead of atomics. Or should we
wait until somebody actually requires that?

>> +    current = qatomic_cmpxchg(&s->copy_mode, MIRROR_COPY_MODE_BACKGROUND,
>> +                              change_opts->copy_mode);
>> +    if (current != MIRROR_COPY_MODE_BACKGROUND) {
>> +        error_setg(errp, "Expected current copy mode '%s', got '%s'",
>> +                   MirrorCopyMode_str(MIRROR_COPY_MODE_BACKGROUND),
>> +                   MirrorCopyMode_str(current));
>> +    }
> 
> The error path is strange. We return an error, but the new mode is still
> set. On the other hand, this is probably also the old mode unless
> someone added a new value to the enum, so it didn't actually change. And
> because this function is the only place that changes copy_mode and we're
> holding the BQL, the case can't even happen and this could be an
> assertion.
> 

AFAIU and testing seem to confirm this, the new mode is only set when
the current mode is MIRROR_COPY_MODE_BACKGROUND. The error is only set
when the current mode is not MIRROR_COPY_MODE_BACKGROUND and thus when
the mode wasn't changed.

Adding a new copy mode shouldn't cause issues either? It's just not
going to be supported to change away from that mode (or to that mode,
because of the change_opts->copy_mode != MIRROR_COPY_MODE_WRITE_BLOCKING
check above) without adapting the code first.

Of course, if we want to allow switching from active to background mode,
the function needs to be adapted too.

I wanted to make it more future-proof for the case where it might not be
the only place changing the value and based it on what Vladimir
suggested in the review of v2:
https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg03552.html

Best Regards,
Fiona


