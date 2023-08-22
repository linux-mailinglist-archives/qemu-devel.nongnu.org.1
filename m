Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C647849D7
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:03:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYWdX-0002hS-7X; Tue, 22 Aug 2023 15:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYWdV-0002h2-3G
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:01:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYWdS-0004mW-LN
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692730909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=73eZf5mv1+mmjHYcxAhXkUlc/AWnthAfLduA8Nvn89A=;
 b=ZL3Aa16bQMN6dfh1qZdiWy8LRVTgTUU2bLwiElkMV+oAH7IhV3c4A1/HM4Lqqh62dVM+0J
 WNbH/Ih5yFNGZJxTbAszsg19J6o+oVpgWvwadFAmIIf4tWV3sdb+kFtl93lD3xT1MHIYlW
 xH+t+uDRPyOtjR15PNqK3tpoPHe3A+g=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-KXUjHQIzPjiYhAuAYKislg-1; Tue, 22 Aug 2023 15:01:46 -0400
X-MC-Unique: KXUjHQIzPjiYhAuAYKislg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C92781C04181;
 Tue, 22 Aug 2023 19:01:45 +0000 (UTC)
Received: from localhost (unknown [10.39.195.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4132040D2843;
 Tue, 22 Aug 2023 19:01:45 +0000 (UTC)
Date: Tue, 22 Aug 2023 15:01:43 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 05/21] block: Introduce bdrv_schedule_unref()
Message-ID: <20230822190143.GH727224@fedora>
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-6-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="L0zuX41W1ra6u8oW"
Content-Disposition: inline
In-Reply-To: <20230817125020.208339-6-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--L0zuX41W1ra6u8oW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 02:50:04PM +0200, Kevin Wolf wrote:
> bdrv_unref() is called by a lot of places that need to hold the graph
> lock (it naturally happens in the context of operations that change the
> graph). However, bdrv_unref() takes the graph writer lock internally, so
> it can't actually be called while already holding a graph lock without
> causing a deadlock.
>=20
> bdrv_unref() also can't just become GRAPH_WRLOCK because it drains the
> node before closing it, and draining requires that the graph is
> unlocked.
>=20
> The solution is to defer deleting the node until we don't hold the lock
> any more and draining is possible again.
>=20
> Note that keeping images open for longer than necessary can create
> problems, too: You can't open an image again before it is really closed
> (if image locking didn't prevent it, it would cause corruption).
> Reopening an image immediately happens at least during bdrv_open() and
> bdrv_co_create().
>=20
> In order to solve this problem, make sure to run the deferred unref in
> bdrv_graph_wrunlock(), i.e. the first possible place where we can drain
> again. This is also why bdrv_schedule_unref() is marked GRAPH_WRLOCK.
>=20
> The output of iotest 051 is updated because the additional polling
> changes the order of HMP output, resulting in a new "(qemu)" prompt in
> the test output that was previously on a separate line and filtered out.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block-global-state.h |  1 +
>  block.c                            |  9 +++++++++
>  block/graph-lock.c                 | 23 ++++++++++++++++-------
>  tests/qemu-iotests/051.pc.out      |  6 +++---
>  4 files changed, 29 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/block/block-global-state.h b/include/block/block-glo=
bal-state.h
> index f347199bff..e570799f85 100644
> --- a/include/block/block-global-state.h
> +++ b/include/block/block-global-state.h
> @@ -224,6 +224,7 @@ void bdrv_img_create(const char *filename, const char=
 *fmt,
>  void bdrv_ref(BlockDriverState *bs);
>  void no_coroutine_fn bdrv_unref(BlockDriverState *bs);
>  void coroutine_fn no_co_wrapper bdrv_co_unref(BlockDriverState *bs);
> +void GRAPH_WRLOCK bdrv_schedule_unref(BlockDriverState *bs);
>  void bdrv_unref_child(BlockDriverState *parent, BdrvChild *child);
>  BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
>                               BlockDriverState *child_bs,
> diff --git a/block.c b/block.c
> index 6376452768..9c4f24f4b9 100644
> --- a/block.c
> +++ b/block.c
> @@ -7033,6 +7033,15 @@ void bdrv_unref(BlockDriverState *bs)
>      }
>  }
> =20
> +void bdrv_schedule_unref(BlockDriverState *bs)

Please add a doc comment explaining when and why this should be used.

> +{
> +    if (!bs) {
> +        return;
> +    }
> +    aio_bh_schedule_oneshot(qemu_get_aio_context(),
> +                            (QEMUBHFunc *) bdrv_unref, bs);
> +}
> +
>  struct BdrvOpBlocker {
>      Error *reason;
>      QLIST_ENTRY(BdrvOpBlocker) list;
> diff --git a/block/graph-lock.c b/block/graph-lock.c
> index 5e66f01ae8..395d387651 100644
> --- a/block/graph-lock.c
> +++ b/block/graph-lock.c
> @@ -163,17 +163,26 @@ void bdrv_graph_wrlock(BlockDriverState *bs)
>  void bdrv_graph_wrunlock(void)
>  {
>      GLOBAL_STATE_CODE();
> -    QEMU_LOCK_GUARD(&aio_context_list_lock);
>      assert(qatomic_read(&has_writer));
> =20
> +    WITH_QEMU_LOCK_GUARD(&aio_context_list_lock) {
> +        /*
> +         * No need for memory barriers, this works in pair with
> +         * the slow path of rdlock() and both take the lock.
> +         */
> +        qatomic_store_release(&has_writer, 0);
> +
> +        /* Wake up all coroutine that are waiting to read the graph */

s/coroutine/coroutines/

> +        qemu_co_enter_all(&reader_queue, &aio_context_list_lock);
> +    }
> +
>      /*
> -     * No need for memory barriers, this works in pair with
> -     * the slow path of rdlock() and both take the lock.
> +     * Run any BHs that were scheduled during the wrlock section and that
> +     * callers might expect to have finished (e.g. bdrv_unref() calls). =
Do this

Referring directly to bdrv_schedule_unref() would help make it clearer
what you mean.

> +     * only after restarting coroutines so that nested event loops in BH=
s don't
> +     * deadlock if their condition relies on the coroutine making progre=
ss.
>       */
> -    qatomic_store_release(&has_writer, 0);
> -
> -    /* Wake up all coroutine that are waiting to read the graph */
> -    qemu_co_enter_all(&reader_queue, &aio_context_list_lock);
> +    aio_bh_poll(qemu_get_aio_context());

Keeping a dedicated list of BDSes pending unref seems cleaner than using
the aio_bh_poll(). There's a lot of stuff happening in the event loop
and I wonder if those other BHs might cause issues if they run at the
end of bdrv_graph_wrunlock(). The change to qemu-iotests 051's output is
an example of this, but other things could happen too (e.g. monitor
command processing).

>  }
> =20
>  void coroutine_fn bdrv_graph_co_rdlock(void)
> diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
> index 4d4af5a486..7e10c5fa1b 100644
> --- a/tests/qemu-iotests/051.pc.out
> +++ b/tests/qemu-iotests/051.pc.out
> @@ -169,11 +169,11 @@ QEMU_PROG: -device scsi-hd,drive=3Ddisk: Device nee=
ds media, but drive is empty
> =20
>  Testing: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,node-name=3Ddisk -obje=
ct iothread,id=3Dthread0 -device virtio-scsi,iothread=3Dthread0,id=3Dvirtio=
-scsi0 -device scsi-hd,bus=3Dvirtio-scsi0.0,drive=3Ddisk,share-rw=3Don -dev=
ice ide-hd,drive=3Ddisk,share-rw=3Don
>  QEMU X.Y.Z monitor - type 'help' for more information
> -QEMU_PROG: -device ide-hd,drive=3Ddisk,share-rw=3Don: Cannot change ioth=
read of active block backend
> +(qemu) QEMU_PROG: -device ide-hd,drive=3Ddisk,share-rw=3Don: Cannot chan=
ge iothread of active block backend
> =20
>  Testing: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,node-name=3Ddisk -obje=
ct iothread,id=3Dthread0 -device virtio-scsi,iothread=3Dthread0,id=3Dvirtio=
-scsi0 -device scsi-hd,bus=3Dvirtio-scsi0.0,drive=3Ddisk,share-rw=3Don -dev=
ice virtio-blk-pci,drive=3Ddisk,share-rw=3Don
>  QEMU X.Y.Z monitor - type 'help' for more information
> -QEMU_PROG: -device virtio-blk-pci,drive=3Ddisk,share-rw=3Don: Cannot cha=
nge iothread of active block backend
> +(qemu) QEMU_PROG: -device virtio-blk-pci,drive=3Ddisk,share-rw=3Don: Can=
not change iothread of active block backend
> =20
>  Testing: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,node-name=3Ddisk -obje=
ct iothread,id=3Dthread0 -device virtio-scsi,iothread=3Dthread0,id=3Dvirtio=
-scsi0 -device scsi-hd,bus=3Dvirtio-scsi0.0,drive=3Ddisk,share-rw=3Don -dev=
ice lsi53c895a,id=3Dlsi0 -device scsi-hd,bus=3Dlsi0.0,drive=3Ddisk,share-rw=
=3Don
>  QEMU X.Y.Z monitor - type 'help' for more information
> @@ -185,7 +185,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
> =20
>  Testing: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,node-name=3Ddisk -obje=
ct iothread,id=3Dthread0 -device virtio-scsi,iothread=3Dthread0,id=3Dvirtio=
-scsi0 -device scsi-hd,bus=3Dvirtio-scsi0.0,drive=3Ddisk,share-rw=3Don -dev=
ice virtio-blk-pci,drive=3Ddisk,iothread=3Dthread0,share-rw=3Don
>  QEMU X.Y.Z monitor - type 'help' for more information
> -QEMU_PROG: -device virtio-blk-pci,drive=3Ddisk,iothread=3Dthread0,share-=
rw=3Don: Cannot change iothread of active block backend
> +(qemu) QEMU_PROG: -device virtio-blk-pci,drive=3Ddisk,iothread=3Dthread0=
,share-rw=3Don: Cannot change iothread of active block backend
> =20
>  Testing: -drive file=3DTEST_DIR/t.qcow2,if=3Dnone,node-name=3Ddisk -obje=
ct iothread,id=3Dthread0 -device virtio-scsi,iothread=3Dthread0,id=3Dvirtio=
-scsi0 -device scsi-hd,bus=3Dvirtio-scsi0.0,drive=3Ddisk,share-rw=3Don -dev=
ice virtio-scsi,id=3Dvirtio-scsi1,iothread=3Dthread0 -device scsi-hd,bus=3D=
virtio-scsi1.0,drive=3Ddisk,share-rw=3Don
>  QEMU X.Y.Z monitor - type 'help' for more information
> --=20
> 2.41.0
>=20

--L0zuX41W1ra6u8oW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTlBhcACgkQnKSrs4Gr
c8j8MwgAqKefCG5xdAIGm7Ea5ISkPVyunOtEi7N2u0QAWb5qbiHoWk0XJ9pf+jQD
rrTqcn3WlUAvFnQk+Jz047GdB/rc4zkRBmfhTQMRiHzYhpdC9k0zn7D61zTA0rms
kBr5nM/cyv85Vp2IcYc7V42KBAMb26tsXCvO2pxrypx4/hB/mC3Va3lMaqbvvVP3
YWtSNjZHLOYqNiXsiqEdH93d+T86iFKdh3yDoJ6UGSnT8CQaVWu4jLZLmzXtnKOm
fPiBzNpZ1ZtzQqXko497ytZw2t7kFt1FLn4bUERvjvnr/d9CBn5vaaRZhVFa2F0T
caf3lAhFxgSKSpZOeaxdsvqZBfwxCg==
=yVL0
-----END PGP SIGNATURE-----

--L0zuX41W1ra6u8oW--


