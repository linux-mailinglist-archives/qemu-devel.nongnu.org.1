Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D64832E4D
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 18:43:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQssP-0008Ho-Ml; Fri, 19 Jan 2024 12:41:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQssK-0008H5-O7
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 12:41:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQssI-0006Gz-Q3
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 12:41:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705686109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CyCaLkpTGlIIivlKFsevSuubNtfAJorE8hi2Hf1TMu8=;
 b=OMUgNzki3yx6qWROhb6Hk4xCHRM1yG7JLxC0Ekge7BcNEDQhSgch8IB3jjZdJOAYoD1zsw
 EFXP4XOZR0+/88TKrF7wW0I+zz1o+6qL8X9YBS7brMZdI97MzDw8SdkhqQpPiU6N/cxO6L
 eiO6ILZjuS8g1Ax9UDbXyFojHkhKPqs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-tmonjf9LMMWfHT6mXJR1og-1; Fri,
 19 Jan 2024 12:41:47 -0500
X-MC-Unique: tmonjf9LMMWfHT6mXJR1og-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 935083CBE322;
 Fri, 19 Jan 2024 17:41:47 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B9B621C05E0E;
 Fri, 19 Jan 2024 17:41:46 +0000 (UTC)
Date: Fri, 19 Jan 2024 18:41:45 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Ari Sundholm <ari@tuxera.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v2] block/blklogwrites: Protect mutable driver state with
 a mutex.
Message-ID: <Zaq0WQoqe_Q3Q2Ao@redhat.com>
References: <f1960d8d-352e-4e1b-4d28-7a110e272356@tuxera.com>
 <20240111163238.1346482-1-ari@tuxera.com>
 <Zal5kCm23APYc68D@redhat.com>
 <2a910fa3-47b6-af14-af7d-fb49f0a225d4@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a910fa3-47b6-af14-af7d-fb49f0a225d4@tuxera.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Am 19.01.2024 um 17:55 hat Ari Sundholm geschrieben:
> On 1/18/24 21:18, Kevin Wolf wrote:
> > Am 11.01.2024 um 17:32 hat Ari Sundholm geschrieben:
> > > During the review of a fix for a concurrency issue in blklogwrites,
> > > it was found that the driver needs an additional fix when enabling
> > > multiqueue, which is a new feature introduced in QEMU 9.0, as the
> > > driver state may be read and written by multiple threads at the same
> > > time, which was not the case when the driver was originally written.
> > > 
> > > Fix the multi-threaded scenario by introducing a mutex to protect the
> > > mutable fields in the driver state, and always having the mutex locked
> > > by the current thread when accessing them. Also use the mutex and a
> > > condition variable to ensure that the super block is not being written
> > > to by multiple threads concurrently.
> > > 
> > > Additionally, add the const qualifier to a few BDRVBlkLogWritesState
> > > pointer targets in contexts where the driver state is not written to.
> > > 
> > > Signed-off-by: Ari Sundholm <ari@tuxera.com>
> > > 
> > > v1->v2: Ensure that the super block is not written to concurrently.
> > > ---
> > >   block/blklogwrites.c | 77 +++++++++++++++++++++++++++++++++++++++-----
> > >   1 file changed, 69 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/block/blklogwrites.c b/block/blklogwrites.c
> > > index ba717dab4d..f8bec7c863 100644
> > > --- a/block/blklogwrites.c
> > > +++ b/block/blklogwrites.c
> > > @@ -3,7 +3,7 @@
> > >    *
> > >    * Copyright (c) 2017 Tuomas Tynkkynen <tuomas@tuxera.com>
> > >    * Copyright (c) 2018 Aapo Vienamo <aapo@tuxera.com>
> > > - * Copyright (c) 2018 Ari Sundholm <ari@tuxera.com>
> > > + * Copyright (c) 2018-2024 Ari Sundholm <ari@tuxera.com>
> > >    *
> > >    * This work is licensed under the terms of the GNU GPL, version 2 or later.
> > >    * See the COPYING file in the top-level directory.
> > > @@ -55,9 +55,34 @@ typedef struct {
> > >       BdrvChild *log_file;
> > >       uint32_t sectorsize;
> > >       uint32_t sectorbits;
> > > +    uint64_t update_interval;
> > > +
> > > +    /*
> > > +     * The mutable state of the driver, consisting of the current log sector
> > > +     * and the number of log entries.
> > > +     *
> > > +     * May be read and/or written from multiple threads, and the mutex must be
> > > +     * held when accessing these fields.
> > > +     */
> > >       uint64_t cur_log_sector;
> > >       uint64_t nr_entries;
> > > -    uint64_t update_interval;
> > > +    QemuMutex mutex;
> > > +
> > > +    /*
> > > +     * The super block sequence number. Non-zero if a super block update is in
> > > +     * progress.
> > > +     *
> > > +     * The mutex must be held when accessing this field.
> > > +     */
> > > +    uint64_t super_update_seq;
> > > +
> > > +    /*
> > > +     * A condition variable to wait for and signal finished superblock updates.
> > > +     *
> > > +     * Used with the mutex to ensure that only one thread be updating the super
> > > +     * block at a time.
> > > +     */
> > > +    QemuCond super_updated;
> > >   } BDRVBlkLogWritesState;
> > >   static QemuOptsList runtime_opts = {
> > > @@ -169,6 +194,9 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
> > >           goto fail;
> > >       }
> > > +    qemu_mutex_init(&s->mutex);
> > > +    qemu_cond_init(&s->super_updated);
> > > +
> > >       log_append = qemu_opt_get_bool(opts, "log-append", false);
> > >       if (log_append) {
> > > @@ -231,6 +259,8 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
> > >           s->nr_entries = 0;
> > >       }
> > > +    s->super_update_seq = 0;
> > > +
> > >       if (!blk_log_writes_sector_size_valid(log_sector_size)) {
> > >           ret = -EINVAL;
> > >           error_setg(errp, "Invalid log sector size %"PRIu64, log_sector_size);
> > > @@ -255,6 +285,8 @@ fail_log:
> > >           bdrv_unref_child(bs, s->log_file);
> > >           bdrv_graph_wrunlock();
> > >           s->log_file = NULL;
> > > +        qemu_cond_destroy(&s->super_updated);
> > > +        qemu_mutex_destroy(&s->mutex);
> > >       }
> > >   fail:
> > >       qemu_opts_del(opts);
> > > @@ -269,6 +301,8 @@ static void blk_log_writes_close(BlockDriverState *bs)
> > >       bdrv_unref_child(bs, s->log_file);
> > >       s->log_file = NULL;
> > >       bdrv_graph_wrunlock();
> > > +    qemu_cond_destroy(&s->super_updated);
> > > +    qemu_mutex_destroy(&s->mutex);
> > >   }
> > >   static int64_t coroutine_fn GRAPH_RDLOCK
> > > @@ -295,7 +329,7 @@ static void blk_log_writes_child_perm(BlockDriverState *bs, BdrvChild *c,
> > >   static void blk_log_writes_refresh_limits(BlockDriverState *bs, Error **errp)
> > >   {
> > > -    BDRVBlkLogWritesState *s = bs->opaque;
> > > +    const BDRVBlkLogWritesState *s = bs->opaque;
> > >       bs->bl.request_alignment = s->sectorsize;
> > >   }
> > > @@ -338,15 +372,18 @@ blk_log_writes_co_do_log(BlkLogWritesLogReq *lr)
> > >        * driver may be modified by other driver operations while waiting for the
> > >        * I/O to complete.
> > >        */
> > > +    qemu_mutex_lock(&s->mutex);
> > >       const uint64_t entry_start_sector = s->cur_log_sector;
> > >       const uint64_t entry_offset = entry_start_sector << s->sectorbits;
> > >       const uint64_t qiov_aligned_size = ROUND_UP(lr->qiov->size, s->sectorsize);
> > >       const uint64_t entry_aligned_size = qiov_aligned_size +
> > >           ROUND_UP(lr->zero_size, s->sectorsize);
> > >       const uint64_t entry_nr_sectors = entry_aligned_size >> s->sectorbits;
> > > +    const uint64_t entry_seq = s->nr_entries + 1;
> > > -    s->nr_entries++;
> > > +    s->nr_entries = entry_seq;
> > >       s->cur_log_sector += entry_nr_sectors;
> > > +    qemu_mutex_unlock(&s->mutex);
> > >       /*
> > >        * Write the log entry. Note that if this is a "write zeroes" operation,
> > > @@ -366,17 +403,34 @@ blk_log_writes_co_do_log(BlkLogWritesLogReq *lr)
> > >       /* Update super block on flush or every update interval */
> > >       if (lr->log_ret == 0 && ((lr->entry.flags & LOG_FLUSH_FLAG)
> > > -        || (s->nr_entries % s->update_interval == 0)))
> > > +        || (entry_seq % s->update_interval == 0)))
> > >       {
> > >           struct log_write_super super = {
> > >               .magic      = cpu_to_le64(WRITE_LOG_MAGIC),
> > >               .version    = cpu_to_le64(WRITE_LOG_VERSION),
> > > -            .nr_entries = cpu_to_le64(s->nr_entries),
> > > +            .nr_entries = const_le64(0),
> > >               .sectorsize = cpu_to_le32(s->sectorsize),
> > >           };
> > > -        void *zeroes = g_malloc0(s->sectorsize - sizeof(super));
> > > +        void *zeroes;
> > >           QEMUIOVector qiov;
> > > +        /*
> > > +         * Wait if a super block update is already in progress.
> > > +         * Bail out if a newer update got its turn before us.
> > > +         */
> > > +        WITH_QEMU_LOCK_GUARD(&s->mutex) {
> > > +            while (s->super_update_seq) {
> > > +                if (entry_seq < s->super_update_seq) {
> > > +                    return;
> > > +                }
> > > +                qemu_cond_wait(&s->super_updated, &s->mutex);
> > 
> > This will block, which is exactly what you want if another thread is
> > writing the super block.
> > 
> > However, in a single-threaded case where it's just the previous request
> > coroutine that is still writing its super block (i.e. bdrv_co_pwritev()
> > below has yielded), this will deadlock because we'll never switch back
> > and actually complete the previous super block write.
> > 
> > So unless I'm missing a reason why this won't happen, I think you need a
> > coroutine aware mechanism here. The obvious options would be using a
> > CoMutex in the first place and holding it across the I/O operation or
> > keeping the cheaper QemuMutex and replacing the condition variable with
> > a CoQueue.
> > 
> 
> Yup. Indeed, you are right. It took me a while to see why. Thanks for
> pointing this out. I had not properly considered the fact that QemuCond does
> not yield on entering a wait in coroutine context.

Yes, exactly.

> Posted v3, where the condition variable has been substituted with a CoQueue.
> Hopefully I did it right this time.

Looks good at the first sight, but I'll properly review it now.

> If I am reading the CoQueue implementation correctly, this should have an
> additional bonus of fairness among the pending super block updates due to
> the execution order imposed

Yes, though I'm not sure how much of a bonus this really is here. If you
process the latest update first, you wouldn't have to do any I/O for the
earlier requests any more. But completely without it, you could indeed
get starvation.

Probably not worth worrying too much about.

> and it also appears that spurious wakeups might not be an issue like
> they would be with pthread condvars? I am not relying on these
> properties in the v3 patch, though.

I think in your case you can get spurious wakeups because you only go
through the queue if someone is already updating the super block.
aio_co_wake() doesn't immediately enter the coroutine that is woken up,
but it just schedules it to run when the current one yields or
terminates. So another thread could start updating the super block in
between. Maybe it can happen even in the single threaded case that
another request coroutine can be scheduled first, I'm not sure about
this.

It would be possible to avoid this by resetting super_update_seq to 0
only in the woken up coroutine or if the queue is empty. Not sure if
this would be any better in practice, though.

Kevin


