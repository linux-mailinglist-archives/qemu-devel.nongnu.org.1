Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E913757F18
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 16:11:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLlOa-0004X2-EI; Tue, 18 Jul 2023 10:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLlOZ-0004Wt-E8
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 10:09:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLlOW-0007C3-Pe
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 10:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689689379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uKanFkMCTgrncbfFJJExJSz71HmUcND3uii0TJ+WHac=;
 b=Oh+bKBUS1F3j9x9tQXu6NC83pkpCJi6we/2PM2nE0IULGoYSc0WfXZNOuuPt/rdkXrjK2T
 FIoDkCcmDXv4KncBGQtkRJoJ/dU69dIOcFekIGZLxyHBHMj5e5XlfzkIY0KoffsQWIAETt
 QYsUdbjRnp76Ue4SYiXKKSJsZTCKwgA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-y-7Q9pDzN6qHJqWnoo71Yw-1; Tue, 18 Jul 2023 10:08:59 -0400
X-MC-Unique: y-7Q9pDzN6qHJqWnoo71Yw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5AE328D1685;
 Tue, 18 Jul 2023 14:08:58 +0000 (UTC)
Received: from localhost (unknown [10.39.193.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5FF5C57985;
 Tue, 18 Jul 2023 14:08:57 +0000 (UTC)
Date: Tue, 18 Jul 2023 10:08:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] thread-pool: signal "request_cond" while locked
Message-ID: <20230718140855.GA44841@fedora>
References: <20230714152720.5077-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2srUdJhd6+YEHw3I"
Content-Disposition: inline
In-Reply-To: <20230714152720.5077-1-anthony.perard@citrix.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


--2srUdJhd6+YEHw3I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 04:27:20PM +0100, Anthony PERARD wrote:
> From: Anthony PERARD <anthony.perard@citrix.com>
>=20
> thread_pool_free() might have been called on the `pool`, which would
> be a reason for worker_thread() to quit. In this case,
> `pool->request_cond` is been destroyed.
>=20
> If worker_thread() didn't managed to signal `request_cond` before it
> been destroyed by thread_pool_free(), we got:
>     util/qemu-thread-posix.c:198: qemu_cond_signal: Assertion `cond->init=
ialized' failed.
>=20
> One backtrace:
>     __GI___assert_fail (assertion=3D0x55555614abcb "cond->initialized", f=
ile=3D0x55555614ab88 "util/qemu-thread-posix.c", line=3D198,
> 	function=3D0x55555614ad80 <__PRETTY_FUNCTION__.17104> "qemu_cond_signal"=
) at assert.c:101
>     qemu_cond_signal (cond=3D0x7fffb800db30) at util/qemu-thread-posix.c:=
198
>     worker_thread (opaque=3D0x7fffb800dab0) at util/thread-pool.c:129
>     qemu_thread_start (args=3D0x7fffb8000b20) at util/qemu-thread-posix.c=
:505
>     start_thread (arg=3D<optimized out>) at pthread_create.c:486
>=20
> Reported here:
>     https://lore.kernel.org/all/ZJwoK50FcnTSfFZ8@MacBook-Air-de-Roger.loc=
al/T/#u
>=20
> To avoid issue, keep lock while sending a signal to `request_cond`.
>=20
> Fixes: 900fa208f506 ("thread-pool: replace semaphore with condition varia=
ble")
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
>=20
> There's maybe an issue in thread_pool_submit_aio() as well with
> signalling `request_cond`, but maybe it's much less likely to be an
> issue?

The caller must not submit work while destroying the pool, so I'm not
sure when this problem could occur with thread_pool_submit_aio()?

> ---
>  util/thread-pool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This is QEMU 8.1 material.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--2srUdJhd6+YEHw3I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS2nPYACgkQnKSrs4Gr
c8gERAgAkAItOJL1Kn5jtVyyIRYGFKdy/Gp4SFUMubkY4nTa1HWwWeWvJH9Ejg4w
ow0qwDAigKlYO0PbTx+Y5IcVM/ciyvWz8PoxjJfmjXlqZMd5VSEUqi8dK0aTACQP
1zVxbyBD0R62asfMmxnB5Q5P+pySccWO+IWOJD3+J1hKjwaAk+qfr8IZmBvGOaXV
HVNQEHaDMyOKW4X9gVpZk+APGKjNS368lPXEp4Y4Pm/xCd4BqnuvAn+Ug59xIfAu
uRyedS58F35DrpFo/sr0mTmrchN6teWL2mmH4Vi+he74MywP4u4Qo8rWA56gQuFl
6K9xT3+iRT1TKsZrp5eW40zIT1HdoQ==
=5HTG
-----END PGP SIGNATURE-----

--2srUdJhd6+YEHw3I--


