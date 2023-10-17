Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6587CC2AE
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 14:13:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsivx-00025B-R5; Tue, 17 Oct 2023 08:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qsivn-0001yk-6q
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:12:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qsivl-0001Um-AY
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697544732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2QDNZ9S+zBFZPfTK/k6TxcU1/1JfwObF3xtZxGwDLPI=;
 b=C3OkKfAaRY6nUu55GH5ucSLuUwwU6aTufxY6EzgSd2CPC/yhm0LMgOFfBeRfqp8f67PMmx
 IKRNE+/3B1dmuhINZpCLGwzqoRrO5XG0URk/FStkcC3jTDDBr7Blh81SKoDrEXDhY4CPZA
 c7croqI8pAwgBxNFd1B/8DlpyVbCjzM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-PeVmCEfrPO6fevs-vBgelQ-1; Tue, 17 Oct 2023 08:12:10 -0400
X-MC-Unique: PeVmCEfrPO6fevs-vBgelQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25BFC85A5BD;
 Tue, 17 Oct 2023 12:12:10 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F4432166B26;
 Tue, 17 Oct 2023 12:12:08 +0000 (UTC)
Date: Tue, 17 Oct 2023 14:12:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: Re: deadlock when using iothread during backup_clean()
Message-ID: <ZS56FzuqZSApXBbc@redhat.com>
References: <bcbd48da-e4cc-f9c9-000c-6a9f98ca156f@proxmox.com>
 <dd12f39d-a364-b186-2ad7-04343ea85e3f@redhat.com>
 <44ff810b-8ec6-0f11-420a-6efa2c7c2475@proxmox.com>
 <2ca4eb06-75c3-7bd8-972b-b37af47743dc@yandex-team.ru>
 <71e3112d-3d3f-fd55-4099-6765d4f22205@proxmox.com>
 <76f9678d-ed92-418e-8d1e-c6dc55f83279@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76f9678d-ed92-418e-8d1e-c6dc55f83279@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 17.10.2023 um 12:18 hat Fiona Ebner geschrieben:
> Am 06.10.23 um 14:18 schrieb Fiona Ebner:
> > Am 04.10.23 um 19:08 schrieb Vladimir Sementsov-Ogievskiy:
> >> On 28.09.23 11:06, Fiona Ebner wrote:
> >>> For fixing the backup cancel deadlock, I tried the following:
> >>>
> >>>> diff --git a/blockjob.c b/blockjob.c
> >>>> index 58c5d64539..fd6132ebfe 100644
> >>>> --- a/blockjob.c
> >>>> +++ b/blockjob.c
> >>>> @@ -198,7 +198,9 @@ void block_job_remove_all_bdrv(BlockJob *job)
> >>>>        * one to make sure that such a concurrent access does not attempt
> >>>>        * to process an already freed BdrvChild.
> >>>>        */
> >>>> +    aio_context_release(job->job.aio_context);
> >>>>       bdrv_graph_wrlock(NULL);
> >>>> +    aio_context_acquire(job->job.aio_context);
> >>>>       while (job->nodes) {
> >>>>           GSList *l = job->nodes;
> >>>>           BdrvChild *c = l->data;
> >>>
> >>> but it's not enough unfortunately. And I don't just mean with the later
> >>> deadlock during bdrv_close() (via bdrv_cbw_drop()) as mentioned in the
> >>> other mail.
> >>>
> >>> Even when I got lucky and that deadlock didn't trigger by chance or with
> >>> an additional change to try and avoid that one
> >>>
> >>>> diff --git a/block.c b/block.c
> >>>> index e7f349b25c..02d2c4e777 100644
> >>>> --- a/block.c
> >>>> +++ b/block.c
> >>>> @@ -5165,7 +5165,7 @@ static void bdrv_close(BlockDriverState *bs)
> >>>>           bs->drv = NULL;
> >>>>       }
> >>>>   -    bdrv_graph_wrlock(NULL);
> >>>> +    bdrv_graph_wrlock(bs);
> >>>>       QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
> >>>>           bdrv_unref_child(bs, child);
> >>>>       }
> >>>
> >>> often guest IO would get completely stuck after canceling the backup.
> >>> There's nothing obvious to me in the backtraces at that point, but it
> >>> seems the vCPU and main threads running like usual, while the IO thread
> >>> is stuck in aio_poll(), i.e. never returns from the __ppoll() call. This
> >>> would happen with both, a VirtIO SCSI and a VirtIO block disk and with
> >>> both aio=io_uring and aio=threads.
> >>
> >> When IO is stuck, it may be helpful to look at bs->tracked_requests list
> >> in gdb. If there are requests, each one has field .co, which points to
> >> the coroutine of request.
> > 
> > After the IO was stuck in the guest, I used bdrv_next_all_states() to
> > iterate over the states and there's only the bdrv_raw and the
> > bdrv_host_device. For both, tracked_requests was empty.
> > 
> > What is also very interesting is that the IO isn't always dead
> > immediately. It can be that the fio command still runs with lower speed
> > for a while (sometimes even up to about a minute, but most often about
> > 10-15 seconds or so). During that time, I still can see calls to
> > virtio_scsi_handle_cmd() and blk_aio_write_entry(). Then they suddenly stop.
> > 
> >>>
> >>> I should also mention I'm using
> >>>
> >>>> fio --name=file --size=4k --direct=1 --rw=randwrite --bs=4k
> >>>> --ioengine=psync --numjobs=5 --runtime=6000 --time_based
> >>>
> >>> inside the guest during canceling of the backup.
> > 
> > One single time, it got stuck polling while canceling [0]. I usually
> > need to do the backup+cancel a few times, because the IO doesn't get
> > stuck each time, so this was a subsequent invocation. The reentrancy to
> > virtio_scsi_handle_cmd()/etc. seems strange at a first glance. Can that
> > be normal?
> > 
> 
> I ran into similar issues now with mirror, (both deadlocks and stuck
> guest IO at other times), and interestingly, also during job start.
> 
> Also had a backtrace similar to [0] once, so I took a closer look.
> Probably was obvious to others already, but for the record:
> 
> 1. the graph is locked by the main thread
> 2. the iothread holds the AioContext lock
> 3. the main thread waits on the AioContext lock
> 4. the iothread waits for coroutine spawned by blk_is_available()

Where does this blk_is_available() in the iothread come from? Having it
wait without dropping the AioContext lock sounds like something that
we'd want to avoid. Ideally, devices using iothreads shouldn't use
synchronous requests at all, but I think scsi-disk might have some of
them.

> As for why it doesn't progress, blk_co_is_available_entry() uses
> bdrv_graph_co_rdlock() and can't get it, because the main thread has the
> write lock. Should be fixed once the AioContext locks are gone, but not
> sure what should be done to avoid it until then.

Then the nested event loop in blk_is_available() would probably be
enough to make progress, yes.

Maybe we could actually drop the lock (and immediately reacquire it) in
AIO_WAIT_WHILE() even if we're in the home thread? That should give the
main thread a chance to make progress.

But I think we're actually not very far from removing the AioContext
lock, so if we can't find an easy fix in the meantime, waiting for that
could be a realistic option.

> I'm still trying to figure out what happens in the cases where the guest
> IO gets stuck. I should mention that I'm not experiencing the issues
> when disabling graph locking. It's rather obvious for the deadlocks, but
> I also can't reproduce the issues with stuck guest IO. Did it on top of
> QEMU 8.1.1, because stuff like bdrv_schedule_unref() came in later and I
> didn't want to mess that up :)

Kevin


