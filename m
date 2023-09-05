Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C467927E4
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 18:40:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdZ5f-0000pK-1H; Tue, 05 Sep 2023 12:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdZ5Y-0000m3-Ib
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:39:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdZ5R-0001N5-5e
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693931972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WBGhnBriQ36G8ALCTEyQoi42LaEUDOui2QudgZ3uB4Q=;
 b=SfT5//KSJfH5BaHrWQwG0aF8wT6Q+8TDiC8kK8Zmr4vWcPCTT2mLbmMkaKPnuFxEsu74C7
 4/i/q2YaWLtRgj3yQrqm+nd86TTQpC70nDxnmvUPldvR7BDpcRWuQP4oCFFyWbVgJ9jy1F
 8W6wc22SURPDyC8Y0gcWOge323l//J0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458--ehHVtNbP56w_U3lt0SjVg-1; Tue, 05 Sep 2023 12:39:30 -0400
X-MC-Unique: -ehHVtNbP56w_U3lt0SjVg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 845209446C9;
 Tue,  5 Sep 2023 16:39:29 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 34FC0140E962;
 Tue,  5 Sep 2023 16:39:28 +0000 (UTC)
Date: Tue, 5 Sep 2023 18:39:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 05/21] block: Introduce bdrv_schedule_unref()
Message-ID: <ZPdZv8sQ9JmaPDk4@redhat.com>
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-6-kwolf@redhat.com>
 <20230822190143.GH727224@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sJupdlSusy+kv/xS"
Content-Disposition: inline
In-Reply-To: <20230822190143.GH727224@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--sJupdlSusy+kv/xS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 22.08.2023 um 21:01 hat Stefan Hajnoczi geschrieben:
> On Thu, Aug 17, 2023 at 02:50:04PM +0200, Kevin Wolf wrote:
> > bdrv_unref() is called by a lot of places that need to hold the graph
> > lock (it naturally happens in the context of operations that change the
> > graph). However, bdrv_unref() takes the graph writer lock internally, so
> > it can't actually be called while already holding a graph lock without
> > causing a deadlock.
> >=20
> > bdrv_unref() also can't just become GRAPH_WRLOCK because it drains the
> > node before closing it, and draining requires that the graph is
> > unlocked.
> >=20
> > The solution is to defer deleting the node until we don't hold the lock
> > any more and draining is possible again.
> >=20
> > Note that keeping images open for longer than necessary can create
> > problems, too: You can't open an image again before it is really closed
> > (if image locking didn't prevent it, it would cause corruption).
> > Reopening an image immediately happens at least during bdrv_open() and
> > bdrv_co_create().
> >=20
> > In order to solve this problem, make sure to run the deferred unref in
> > bdrv_graph_wrunlock(), i.e. the first possible place where we can drain
> > again. This is also why bdrv_schedule_unref() is marked GRAPH_WRLOCK.
> >=20
> > The output of iotest 051 is updated because the additional polling
> > changes the order of HMP output, resulting in a new "(qemu)" prompt in
> > the test output that was previously on a separate line and filtered out.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  include/block/block-global-state.h |  1 +
> >  block.c                            |  9 +++++++++
> >  block/graph-lock.c                 | 23 ++++++++++++++++-------
> >  tests/qemu-iotests/051.pc.out      |  6 +++---
> >  4 files changed, 29 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/include/block/block-global-state.h b/include/block/block-g=
lobal-state.h
> > index f347199bff..e570799f85 100644
> > --- a/include/block/block-global-state.h
> > +++ b/include/block/block-global-state.h
> > @@ -224,6 +224,7 @@ void bdrv_img_create(const char *filename, const ch=
ar *fmt,
> >  void bdrv_ref(BlockDriverState *bs);
> >  void no_coroutine_fn bdrv_unref(BlockDriverState *bs);
> >  void coroutine_fn no_co_wrapper bdrv_co_unref(BlockDriverState *bs);
> > +void GRAPH_WRLOCK bdrv_schedule_unref(BlockDriverState *bs);
> >  void bdrv_unref_child(BlockDriverState *parent, BdrvChild *child);
> >  BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
> >                               BlockDriverState *child_bs,
> > diff --git a/block.c b/block.c
> > index 6376452768..9c4f24f4b9 100644
> > --- a/block.c
> > +++ b/block.c
> > @@ -7033,6 +7033,15 @@ void bdrv_unref(BlockDriverState *bs)
> >      }
> >  }
> > =20
> > +void bdrv_schedule_unref(BlockDriverState *bs)
>=20
> Please add a doc comment explaining when and why this should be used.

Ok.

> > +{
> > +    if (!bs) {
> > +        return;
> > +    }
> > +    aio_bh_schedule_oneshot(qemu_get_aio_context(),
> > +                            (QEMUBHFunc *) bdrv_unref, bs);
> > +}
> > +
> >  struct BdrvOpBlocker {
> >      Error *reason;
> >      QLIST_ENTRY(BdrvOpBlocker) list;
> > diff --git a/block/graph-lock.c b/block/graph-lock.c
> > index 5e66f01ae8..395d387651 100644
> > --- a/block/graph-lock.c
> > +++ b/block/graph-lock.c
> > @@ -163,17 +163,26 @@ void bdrv_graph_wrlock(BlockDriverState *bs)
> >  void bdrv_graph_wrunlock(void)
> >  {
> >      GLOBAL_STATE_CODE();
> > -    QEMU_LOCK_GUARD(&aio_context_list_lock);
> >      assert(qatomic_read(&has_writer));
> > =20
> > +    WITH_QEMU_LOCK_GUARD(&aio_context_list_lock) {
> > +        /*
> > +         * No need for memory barriers, this works in pair with
> > +         * the slow path of rdlock() and both take the lock.
> > +         */
> > +        qatomic_store_release(&has_writer, 0);
> > +
> > +        /* Wake up all coroutine that are waiting to read the graph */
>=20
> s/coroutine/coroutines/

I only changed the indentation, but I guess I can just fix it while I
touch it.

> > +        qemu_co_enter_all(&reader_queue, &aio_context_list_lock);
> > +    }
> > +
> >      /*
> > -     * No need for memory barriers, this works in pair with
> > -     * the slow path of rdlock() and both take the lock.
> > +     * Run any BHs that were scheduled during the wrlock section and t=
hat
> > +     * callers might expect to have finished (e.g. bdrv_unref() calls)=
=2E Do this
>=20
> Referring directly to bdrv_schedule_unref() would help make it clearer
> what you mean.
>=20
> > +     * only after restarting coroutines so that nested event loops in =
BHs don't
> > +     * deadlock if their condition relies on the coroutine making prog=
ress.
> >       */
> > -    qatomic_store_release(&has_writer, 0);
> > -
> > -    /* Wake up all coroutine that are waiting to read the graph */
> > -    qemu_co_enter_all(&reader_queue, &aio_context_list_lock);
> > +    aio_bh_poll(qemu_get_aio_context());
>=20
> Keeping a dedicated list of BDSes pending unref seems cleaner than using
> the aio_bh_poll(). There's a lot of stuff happening in the event loop
> and I wonder if those other BHs might cause issues if they run at the
> end of bdrv_graph_wrunlock(). The change to qemu-iotests 051's output is
> an example of this, but other things could happen too (e.g. monitor
> command processing).

I would argue that it's no worse than the old code: The bdrv_unref()
that we're replacing would already run a nested event loop if it was the
last reference. We only moved this a bit later, making the part of the
code that doesn't run an event loop a bit larger. The difference is that
we're running it unconditionally now, not only in a special case, but I
think that's actually an improvement (in terms of test coverage etc.)

We run nested event loops in all kinds of different places without
thinking much about it. If we're worried about it here, what do we do
about all these other places?

Anyway, if you think that we should process only bdrv_schedule_unref()
here, how would you approach this? Restrict it to bdrv_schedule_unref()
in the hope that this is the only operation we'll need to delay, or
implement another BH mechanism from scratch in graph-lock.c? In theory
we could also add another AioContext where actual BHs can be queued and
that is only polled here, but the iohandler context is already painful
enough that I don't necessarily want to create another thing like it.

Kevin

--sJupdlSusy+kv/xS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmT3Wb8ACgkQfwmycsiP
L9azcg//Q5TAx9LRYbu4FVA13LcA0VQOQIC2ZjwyBYgSppHiuLbj2x+fVghqMDU+
FBbTTEqSOf81D7gurnEaq5+fkHrUKiQnr/vIgZatnFhS54CskRWku8iP15KPQq1n
6znlD1z485op0ygoYm2DDuD9wLD6xAxUzV8oQA6pZSYJqexCSdND17To5Gtmb+T/
T5gMizNeqlBZshhGNGFiRLb0oUyNjjWoq81mdB9qE5HihYdM33Pzw0aiNLxcgkt/
BfM1a/RZC2Kp7UOMzx+i9ZsrTyuq2KPr38O8J6UAKpViG4S5NPljEYk7raSLaJc0
V8y4bCIFSFOa83NTKHMcGTgoCrsd5jek7p/r1huS2gzRT1kz5pCMYsR1zgWmewWz
KT9tUM23ER5a2GeORGivbdhUPgA1gabrzljSUsAJ8w1O8zTJCE2MBnrHcoPQPcCS
hXRMhmp7IoCCBS+s1IfSPNBkPCB3SMitB6zQ9Cj1Du0jJxS1LosiQ9GiKNXMqJzk
cUSz3colY7G0HsRRvnpbUbzrz/k05PBfL+EE5kNFqnLgTDaSvc8dM0kBGxBKZePO
7/bBTp4RJ44h6BnE4oBCDq+uSKG9oM/76iUcu/lQFcCkzlX4zfujFlyIxWQl6Rf3
IVMRbe2g3ggOyWnOeg9u9wp2Y/nfcAoB+rWt4uVdJA4nWLLrgXo=
=W+KF
-----END PGP SIGNATURE-----

--sJupdlSusy+kv/xS--


