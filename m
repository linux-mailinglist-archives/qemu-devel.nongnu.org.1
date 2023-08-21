Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0D4782EF7
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 19:00:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY8FE-0005jO-MF; Mon, 21 Aug 2023 12:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qY8FC-0005iy-3e
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:59:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qY8F9-0004sG-Qe
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692637146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cv1qRu0sDKvYySTQVjCyat5u0G0s51X7vSk2085+L8c=;
 b=YGhq2mTp3XAWoN/d0vGJvSERxLN6zXN78OSEQ5NUCLSDbi0kAViDinWxkMBuP6CxJV4c59
 07rLAyJtyE2YKM3FdlLwwidFe+E+sjstwU9HXHHMlfzhapLEhi/CEI4RAa93IBvgHMVjBN
 FyshPeDxNNW/1GfVRYQi5JEiYYB18XY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-dgsupAyaMzu6120IBF_eLA-1; Mon, 21 Aug 2023 12:59:05 -0400
X-MC-Unique: dgsupAyaMzu6120IBF_eLA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1CC929AA39D;
 Mon, 21 Aug 2023 16:59:04 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.1])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 72141492C13;
 Mon, 21 Aug 2023 16:59:03 +0000 (UTC)
Date: Mon, 21 Aug 2023 18:59:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 05/21] block: Introduce bdrv_schedule_unref()
Message-ID: <ZOOX1pdZL84XAo3u@redhat.com>
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-6-kwolf@redhat.com>
 <hnhpl6wapbiizx655ysygmsgocy7xebvdbtrrwuf55jngjudlz@zg6jxvyb6yo6>
 <cthrktm4jug2g7pexz4h6ocactvatye6cqsqqjwesybvg55anm@3iayrpa3rra2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cthrktm4jug2g7pexz4h6ocactvatye6cqsqqjwesybvg55anm@3iayrpa3rra2>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Am 18.08.2023 um 18:26 hat Eric Blake geschrieben:
> On Fri, Aug 18, 2023 at 11:24:00AM -0500, Eric Blake wrote:
> > > +++ b/block/graph-lock.c
> > > @@ -163,17 +163,26 @@ void bdrv_graph_wrlock(BlockDriverState *bs)
> > >  void bdrv_graph_wrunlock(void)
> > >  {
> > >      GLOBAL_STATE_CODE();
> > > -    QEMU_LOCK_GUARD(&aio_context_list_lock);
> > >      assert(qatomic_read(&has_writer));
> > >  
> > > +    WITH_QEMU_LOCK_GUARD(&aio_context_list_lock) {
> > > +        /*
> > > +         * No need for memory barriers, this works in pair with
> > > +         * the slow path of rdlock() and both take the lock.
> > > +         */
> > > +        qatomic_store_release(&has_writer, 0);
> > > +
> > > +        /* Wake up all coroutine that are waiting to read the graph */
> > > +        qemu_co_enter_all(&reader_queue, &aio_context_list_lock);
> > 
> > So if I understand coroutines correctly, this says all pending
> > coroutines are now scheduled to run (or maybe they do try to run here,
> > but then immediately return control back to this coroutine to await
> > the right lock conditions since we are still in the block guarded by
> > list_lock)...
> > 
> > > +    }
> > > +
> > >      /*
> > > -     * No need for memory barriers, this works in pair with
> > > -     * the slow path of rdlock() and both take the lock.
> > > +     * Run any BHs that were scheduled during the wrlock section and that
> > > +     * callers might expect to have finished (e.g. bdrv_unref() calls). Do this
> > > +     * only after restarting coroutines so that nested event loops in BHs don't
> > > +     * deadlock if their condition relies on the coroutine making progress.
> > >       */
> > > -    qatomic_store_release(&has_writer, 0);
> > > -
> > > -    /* Wake up all coroutine that are waiting to read the graph */
> > > -    qemu_co_enter_all(&reader_queue, &aio_context_list_lock);
> > > +    aio_bh_poll(qemu_get_aio_context());
> > 
> > ...and as long as the other coroutines sharing this thread don't
> > actually get to make progress until the next point at which the
> > current coroutine yields, and as long as our aio_bh_poll() doesn't
> > also include a yield point, then we are ensured that the BH has
> > completed before the next yield point in our caller.
> > 
> > There are times (like today) where I'm still trying to wrap my mind
> > about the subtle differences between true multi-threading
> > vs. cooperative coroutines sharing a single thread via the use of
> > yield points.  coroutines are cool when they can get rid of some of
> > the races that you have to worry about in true multi-threading.
> 
> That said, once we introduce multi-queue, can we ever have a scenario
> where a different iothread might be trying to access the graph and
> perform a reopen in the time while this thread has not completed the
> BH close?  Or is that protected by some other mutual exclusion (where
> the only one we have to worry about is reopen by a coroutine in the
> same thread, because all other threads are locked out of graph
> modifications)?

We don't have to worry about that one because reopen (and taking the
writer lock in general) only happen in the main thread, which is exactly
the thread that this code runs in.

The thing that we need to take into consideration is that aio_bh_poll()
could call something that wants to take the writer lock and modify the
graph again. It's not really a problem, though, because we're already
done at that point. Any readers that we resumed above will just
synchronise with the writer in the usual way and one of them will have
to wait. But there is nothing that is still waiting to be resumed and
could deadlock.

Kevin


