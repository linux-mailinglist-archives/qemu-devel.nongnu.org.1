Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DB9781040
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 18:25:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX2Gh-000292-Mr; Fri, 18 Aug 2023 12:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qX2Ge-00028f-BA
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 12:24:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qX2Gb-0004NE-W6
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 12:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692375844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AEuI4QlSf6Cs1eLnNZ4IfMpm/JeT3ogvrIQYaimpzG4=;
 b=Y2ZvcOpbhpp4/5A2+VFG8vRNkcrUJV1/8TwZqfA9cbDVWM1/tflgJ9cFEENsS5/Z7dzJVw
 3KAL42ZEV9qU0ritXTKbuplf6kLUcx54F+6XmLmQgi6cNrreJdTNg6OBvVApd739GwAqOR
 rpAY9a7aheEyGzXv3x+pk/VSR9IsXn4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-245-WWIMOBzuNImCMKIVdDwMgg-1; Fri, 18 Aug 2023 12:24:00 -0400
X-MC-Unique: WWIMOBzuNImCMKIVdDwMgg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11DCE3C0F430;
 Fri, 18 Aug 2023 16:24:00 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C0A80C15BAD;
 Fri, 18 Aug 2023 16:23:58 +0000 (UTC)
Date: Fri, 18 Aug 2023 11:23:57 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, stefanha@redhat.com, eesposit@redhat.com, 
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 05/21] block: Introduce bdrv_schedule_unref()
Message-ID: <hnhpl6wapbiizx655ysygmsgocy7xebvdbtrrwuf55jngjudlz@zg6jxvyb6yo6>
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-6-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817125020.208339-6-kwolf@redhat.com>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

On Thu, Aug 17, 2023 at 02:50:04PM +0200, Kevin Wolf wrote:
> bdrv_unref() is called by a lot of places that need to hold the graph
> lock (it naturally happens in the context of operations that change the
> graph). However, bdrv_unref() takes the graph writer lock internally, so
> it can't actually be called while already holding a graph lock without
> causing a deadlock.
> 
> bdrv_unref() also can't just become GRAPH_WRLOCK because it drains the
> node before closing it, and draining requires that the graph is
> unlocked.
> 
> The solution is to defer deleting the node until we don't hold the lock
> any more and draining is possible again.
> 
> Note that keeping images open for longer than necessary can create
> problems, too: You can't open an image again before it is really closed
> (if image locking didn't prevent it, it would cause corruption).
> Reopening an image immediately happens at least during bdrv_open() and
> bdrv_co_create().
> 
> In order to solve this problem, make sure to run the deferred unref in
> bdrv_graph_wrunlock(), i.e. the first possible place where we can drain
> again. This is also why bdrv_schedule_unref() is marked GRAPH_WRLOCK.
> 
> The output of iotest 051 is updated because the additional polling
> changes the order of HMP output, resulting in a new "(qemu)" prompt in
> the test output that was previously on a separate line and filtered out.
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

> +++ b/block/graph-lock.c
> @@ -163,17 +163,26 @@ void bdrv_graph_wrlock(BlockDriverState *bs)
>  void bdrv_graph_wrunlock(void)
>  {
>      GLOBAL_STATE_CODE();
> -    QEMU_LOCK_GUARD(&aio_context_list_lock);
>      assert(qatomic_read(&has_writer));
>  
> +    WITH_QEMU_LOCK_GUARD(&aio_context_list_lock) {
> +        /*
> +         * No need for memory barriers, this works in pair with
> +         * the slow path of rdlock() and both take the lock.
> +         */
> +        qatomic_store_release(&has_writer, 0);
> +
> +        /* Wake up all coroutine that are waiting to read the graph */
> +        qemu_co_enter_all(&reader_queue, &aio_context_list_lock);

So if I understand coroutines correctly, this says all pending
coroutines are now scheduled to run (or maybe they do try to run here,
but then immediately return control back to this coroutine to await
the right lock conditions since we are still in the block guarded by
list_lock)...

> +    }
> +
>      /*
> -     * No need for memory barriers, this works in pair with
> -     * the slow path of rdlock() and both take the lock.
> +     * Run any BHs that were scheduled during the wrlock section and that
> +     * callers might expect to have finished (e.g. bdrv_unref() calls). Do this
> +     * only after restarting coroutines so that nested event loops in BHs don't
> +     * deadlock if their condition relies on the coroutine making progress.
>       */
> -    qatomic_store_release(&has_writer, 0);
> -
> -    /* Wake up all coroutine that are waiting to read the graph */
> -    qemu_co_enter_all(&reader_queue, &aio_context_list_lock);
> +    aio_bh_poll(qemu_get_aio_context());

...and as long as the other coroutines sharing this thread don't
actually get to make progress until the next point at which the
current coroutine yields, and as long as our aio_bh_poll() doesn't
also include a yield point, then we are ensured that the BH has
completed before the next yield point in our caller.

There are times (like today) where I'm still trying to wrap my mind
about the subtle differences between true multi-threading
vs. cooperative coroutines sharing a single thread via the use of
yield points.  coroutines are cool when they can get rid of some of
the races that you have to worry about in true multi-threading.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


