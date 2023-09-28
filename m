Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8607B15B6
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 10:07:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlm2X-0002wc-AX; Thu, 28 Sep 2023 04:06:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qlm2R-0002tb-SY; Thu, 28 Sep 2023 04:06:25 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1qlm2P-00065B-7A; Thu, 28 Sep 2023 04:06:22 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 055C048D55;
 Thu, 28 Sep 2023 10:06:16 +0200 (CEST)
Message-ID: <44ff810b-8ec6-0f11-420a-6efa2c7c2475@proxmox.com>
Date: Thu, 28 Sep 2023 10:06:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: Fiona Ebner <f.ebner@proxmox.com>
Subject: Re: deadlock when using iothread during backup_clean()
To: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <bcbd48da-e4cc-f9c9-000c-6a9f98ca156f@proxmox.com>
 <dd12f39d-a364-b186-2ad7-04343ea85e3f@redhat.com>
Content-Language: en-US
In-Reply-To: <dd12f39d-a364-b186-2ad7-04343ea85e3f@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
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

Am 05.09.23 um 13:42 schrieb Paolo Bonzini:
> On 9/5/23 12:01, Fiona Ebner wrote:
>> Can we assume block_job_remove_all_bdrv() to always hold the job's
>> AioContext?
> 
> I think so, see job_unref_locked(), job_prepare_locked() and
> job_finalize_single_locked().  These call the callbacks that ultimately
> get to block_job_remove_all_bdrv().
>     
>> And if yes, can we just tell bdrv_graph_wrlock() that it
>> needs to release that before polling to fix the deadlock?
> 
> No, but I think it should be released and re-acquired in
> block_job_remove_all_bdrv() itself.
> 

For fixing the backup cancel deadlock, I tried the following:

> diff --git a/blockjob.c b/blockjob.c
> index 58c5d64539..fd6132ebfe 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -198,7 +198,9 @@ void block_job_remove_all_bdrv(BlockJob *job)
>       * one to make sure that such a concurrent access does not attempt
>       * to process an already freed BdrvChild.
>       */
> +    aio_context_release(job->job.aio_context);
>      bdrv_graph_wrlock(NULL);
> +    aio_context_acquire(job->job.aio_context);
>      while (job->nodes) {
>          GSList *l = job->nodes;
>          BdrvChild *c = l->data;

but it's not enough unfortunately. And I don't just mean with the later
deadlock during bdrv_close() (via bdrv_cbw_drop()) as mentioned in the
other mail.

Even when I got lucky and that deadlock didn't trigger by chance or with
an additional change to try and avoid that one

> diff --git a/block.c b/block.c
> index e7f349b25c..02d2c4e777 100644
> --- a/block.c
> +++ b/block.c
> @@ -5165,7 +5165,7 @@ static void bdrv_close(BlockDriverState *bs)
>          bs->drv = NULL;
>      }
>  
> -    bdrv_graph_wrlock(NULL);
> +    bdrv_graph_wrlock(bs);
>      QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
>          bdrv_unref_child(bs, child);
>      }

often guest IO would get completely stuck after canceling the backup.
There's nothing obvious to me in the backtraces at that point, but it
seems the vCPU and main threads running like usual, while the IO thread
is stuck in aio_poll(), i.e. never returns from the __ppoll() call. This
would happen with both, a VirtIO SCSI and a VirtIO block disk and with
both aio=io_uring and aio=threads.

I should also mention I'm using

> fio --name=file --size=4k --direct=1 --rw=randwrite --bs=4k --ioengine=psync --numjobs=5 --runtime=6000 --time_based

inside the guest during canceling of the backup.

I'd be glad for any pointers what to look for and happy to provide more
information.

Best Regards,
Fiona


