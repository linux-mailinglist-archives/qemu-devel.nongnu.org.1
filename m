Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 557E97B8620
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:08:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5MA-0002pP-GP; Wed, 04 Oct 2023 13:08:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qo5M7-0002oD-7U; Wed, 04 Oct 2023 13:08:15 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qo5M3-0007yS-9w; Wed, 04 Oct 2023 13:08:13 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:201e:0:640:d29a:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id E0E25634BC;
 Wed,  4 Oct 2023 20:08:06 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:2::1:1c] (unknown [2a02:6b8:b081:2::1:1c])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id 58b3wk2OmSw0-YFBC0s1E; 
 Wed, 04 Oct 2023 20:08:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696439285;
 bh=ge/u3b03jCsgQwQfGGXuu9nKPYnLPIqX2FiXQv5N8b4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=AUIYxOqIwYxZSJloP1Ep/CfPT4wLlapzEP+wgnS5zw58CjLwKMKrqFJGWWsbfeTCF
 YrK3JCDwxrlbermEvvtdrgRDSeta55L4qxmnijYOHlEyqE1Arnt8y6zQyGCUVxxUhu
 psDnzOOnVcOKaep7D70BQLvA+d/PvcgreSDI4LvI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2ca4eb06-75c3-7bd8-972b-b37af47743dc@yandex-team.ru>
Date: Wed, 4 Oct 2023 20:08:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: deadlock when using iothread during backup_clean()
Content-Language: en-US
To: Fiona Ebner <f.ebner@proxmox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <bcbd48da-e4cc-f9c9-000c-6a9f98ca156f@proxmox.com>
 <dd12f39d-a364-b186-2ad7-04343ea85e3f@redhat.com>
 <44ff810b-8ec6-0f11-420a-6efa2c7c2475@proxmox.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <44ff810b-8ec6-0f11-420a-6efa2c7c2475@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
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

On 28.09.23 11:06, Fiona Ebner wrote:
> Am 05.09.23 um 13:42 schrieb Paolo Bonzini:
>> On 9/5/23 12:01, Fiona Ebner wrote:
>>> Can we assume block_job_remove_all_bdrv() to always hold the job's
>>> AioContext?
>>
>> I think so, see job_unref_locked(), job_prepare_locked() and
>> job_finalize_single_locked().  These call the callbacks that ultimately
>> get to block_job_remove_all_bdrv().
>>      
>>> And if yes, can we just tell bdrv_graph_wrlock() that it
>>> needs to release that before polling to fix the deadlock?
>>
>> No, but I think it should be released and re-acquired in
>> block_job_remove_all_bdrv() itself.
>>
> 
> For fixing the backup cancel deadlock, I tried the following:
> 
>> diff --git a/blockjob.c b/blockjob.c
>> index 58c5d64539..fd6132ebfe 100644
>> --- a/blockjob.c
>> +++ b/blockjob.c
>> @@ -198,7 +198,9 @@ void block_job_remove_all_bdrv(BlockJob *job)
>>        * one to make sure that such a concurrent access does not attempt
>>        * to process an already freed BdrvChild.
>>        */
>> +    aio_context_release(job->job.aio_context);
>>       bdrv_graph_wrlock(NULL);
>> +    aio_context_acquire(job->job.aio_context);
>>       while (job->nodes) {
>>           GSList *l = job->nodes;
>>           BdrvChild *c = l->data;
> 
> but it's not enough unfortunately. And I don't just mean with the later
> deadlock during bdrv_close() (via bdrv_cbw_drop()) as mentioned in the
> other mail.
> 
> Even when I got lucky and that deadlock didn't trigger by chance or with
> an additional change to try and avoid that one
> 
>> diff --git a/block.c b/block.c
>> index e7f349b25c..02d2c4e777 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -5165,7 +5165,7 @@ static void bdrv_close(BlockDriverState *bs)
>>           bs->drv = NULL;
>>       }
>>   
>> -    bdrv_graph_wrlock(NULL);
>> +    bdrv_graph_wrlock(bs);
>>       QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
>>           bdrv_unref_child(bs, child);
>>       }
> 
> often guest IO would get completely stuck after canceling the backup.
> There's nothing obvious to me in the backtraces at that point, but it
> seems the vCPU and main threads running like usual, while the IO thread
> is stuck in aio_poll(), i.e. never returns from the __ppoll() call. This
> would happen with both, a VirtIO SCSI and a VirtIO block disk and with
> both aio=io_uring and aio=threads.

When IO is stuck, it may be helpful to look at bs->tracked_requests list in gdb. If there are requests, each one has field .co, which points to the coroutine of request.

Next step is to look at coroutine stack.

Something like (in gdb):

source scripts/qemu-gdb.py
qemu coroutine <coroutine pointer>

may work. ("may", because it was long ago when I used this last time)

> 
> I should also mention I'm using
> 
>> fio --name=file --size=4k --direct=1 --rw=randwrite --bs=4k --ioengine=psync --numjobs=5 --runtime=6000 --time_based
> 
> inside the guest during canceling of the backup.
> 
> I'd be glad for any pointers what to look for and happy to provide more
> information.
> 
> Best Regards,
> Fiona
> 

-- 
Best regards,
Vladimir


