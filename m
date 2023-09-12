Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7580C79DB07
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 23:38:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgB4w-0002ie-Ae; Tue, 12 Sep 2023 17:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgB4u-0002iD-C9
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:37:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgB4r-0001Is-FR
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 17:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694554664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ueqRQH3h6Ju622xATG6pzbAzZByXXl/CaJ8KIP2ukxw=;
 b=L4Qrkk3Q/LwJknRtbgU6eUFJtiLhex9L3JgC+x6PWhutDiM7aTrmvgvUQA1ck/EwJxTnBj
 tNu21RfFVmZ+lbhN99GFrhfMj0LbAizpF+OUk/7JEYjHHzhUudPyzbCJji+fgVIEkRQCOY
 bmcejEetvopqbh7AsqykPj1gS2lrF10=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-qP4u455JO9WNCaTZ0dVuMg-1; Tue, 12 Sep 2023 17:37:38 -0400
X-MC-Unique: qP4u455JO9WNCaTZ0dVuMg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F6D180268A;
 Tue, 12 Sep 2023 21:37:37 +0000 (UTC)
Received: from localhost (unknown [10.39.192.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A801640C200A;
 Tue, 12 Sep 2023 21:37:36 +0000 (UTC)
Date: Tue, 12 Sep 2023 17:37:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Klaus Jensen <its@irrelevant.dk>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v2 4/4] block-coroutine-wrapper: use
 qemu_get_current_aio_context()
Message-ID: <20230912213734.GA495858@fedora>
References: <20230823235938.1398382-1-stefanha@redhat.com>
 <20230823235938.1398382-5-stefanha@redhat.com>
 <ZPIY8UzEeRrpM1rp@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="P+UiO/61XVhMdzQ5"
Content-Disposition: inline
In-Reply-To: <ZPIY8UzEeRrpM1rp@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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


--P+UiO/61XVhMdzQ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 07:01:37PM +0200, Kevin Wolf wrote:
> Am 24.08.2023 um 01:59 hat Stefan Hajnoczi geschrieben:
> > Use qemu_get_current_aio_context() in mixed wrappers and coroutine
> > wrappers so that code runs in the caller's AioContext instead of moving
> > to the BlockDriverState's AioContext. This change is necessary for the
> > multi-queue block layer where any thread can call into the block layer.
> >=20
> > Most wrappers are IO_CODE where it's safe to use the current AioContext
> > nowadays. BlockDrivers and the core block layer use their own locks and
> > no longer depend on the AioContext lock for thread-safety.
> >=20
> > The bdrv_create() wrapper invokes GLOBAL_STATE code. Using the current
> > AioContext is safe because this code is only called with the BQL held
> > from the main loop thread.
> >=20
> > The output of qemu-iotests 051 is sensitive to event loop activity.
> > Update the output because the monitor BH runs at a different time,
> > causing prompts to be printed differently in the output.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> The update for 051 is actually missing from this patch, and so the test
> fails.
>=20
> I missed the dependency on your qio_channel series, so 281 ran into an
> abort() for me (see below for the stack trace). I expect that the other
> series actually fixes this, but this kind of interaction wasn't really
> obvious. How did you make sure that there aren't other places that don't
> like this change?

Only by running qemu-iotests.

Stefan

>=20
> Kevin
>=20
> (gdb) bt
> #0  0x00007f8ef0d2fe5c in __pthread_kill_implementation () at /lib64/libc=
=2Eso.6
> #1  0x00007f8ef0cdfa76 in raise () at /lib64/libc.so.6
> #2  0x00007f8ef0cc97fc in abort () at /lib64/libc.so.6
> #3  0x00007f8ef0cc971b in _nl_load_domain.cold () at /lib64/libc.so.6
> #4  0x00007f8ef0cd8656 in  () at /lib64/libc.so.6
> #5  0x000055fd19da6af3 in qio_channel_yield (ioc=3D0x7f8ee0000b70, condit=
ion=3DG_IO_IN) at ../io/channel.c:583
> #6  0x000055fd19e0382f in nbd_read_eof (bs=3D0x55fd1b681350, ioc=3D0x7f8e=
e0000b70, buffer=3D0x55fd1b680da0, size=3D4, errp=3D0x0) at ../nbd/client.c=
:1454
> #7  0x000055fd19e03612 in nbd_receive_reply (bs=3D0x55fd1b681350, ioc=3D0=
x7f8ee0000b70, reply=3D0x55fd1b680da0, errp=3D0x0) at ../nbd/client.c:1491
> #8  0x000055fd19e40575 in nbd_receive_replies (s=3D0x55fd1b680b00, cookie=
=3D1) at ../block/nbd.c:461
> #9  0x000055fd19e3fec4 in nbd_co_do_receive_one_chunk
>     (s=3D0x55fd1b680b00, cookie=3D1, only_structured=3Dtrue, request_ret=
=3D0x7f8ee8bff91c, qiov=3D0x7f8ee8bfff10, payload=3D0x7f8ee8bff9d0, errp=3D=
0x7f8ee8bff910) at ../block/nbd.c:844
> #10 0x000055fd19e3fd55 in nbd_co_receive_one_chunk
>     (s=3D0x55fd1b680b00, cookie=3D1, only_structured=3Dtrue, request_ret=
=3D0x7f8ee8bff91c, qiov=3D0x7f8ee8bfff10, reply=3D0x7f8ee8bff9f0, payload=
=3D0x7f8ee8bff9d0, errp=3D0x7f8ee8bff910)
>     at ../block/nbd.c:925
> #11 0x000055fd19e3f7b5 in nbd_reply_chunk_iter_receive (s=3D0x55fd1b680b0=
0, iter=3D0x7f8ee8bff9d8, cookie=3D1, qiov=3D0x7f8ee8bfff10, reply=3D0x7f8e=
e8bff9f0, payload=3D0x7f8ee8bff9d0)
>     at ../block/nbd.c:1008
> #12 0x000055fd19e3ecf7 in nbd_co_receive_cmdread_reply (s=3D0x55fd1b680b0=
0, cookie=3D1, offset=3D0, qiov=3D0x7f8ee8bfff10, request_ret=3D0x7f8ee8bff=
ad4, errp=3D0x7f8ee8bffac8) at ../block/nbd.c:1074
> #13 0x000055fd19e3c804 in nbd_client_co_preadv (bs=3D0x55fd1b681350, offs=
et=3D0, bytes=3D131072, qiov=3D0x7f8ee8bfff10, flags=3D0) at ../block/nbd.c=
:1258
> #14 0x000055fd19e33547 in bdrv_driver_preadv (bs=3D0x55fd1b681350, offset=
=3D0, bytes=3D131072, qiov=3D0x7f8ee8bfff10, qiov_offset=3D0, flags=3D0) at=
 ../block/io.c:1005
> #15 0x000055fd19e2c8bb in bdrv_aligned_preadv (child=3D0x55fd1c282d90, re=
q=3D0x7f8ee8bffd90, offset=3D0, bytes=3D131072, align=3D1, qiov=3D0x7f8ee8b=
fff10, qiov_offset=3D0, flags=3D0) at ../block/io.c:1398
> #16 0x000055fd19e2bf7d in bdrv_co_preadv_part (child=3D0x55fd1c282d90, of=
fset=3D0, bytes=3D131072, qiov=3D0x7f8ee8bfff10, qiov_offset=3D0, flags=3D0=
) at ../block/io.c:1815
> #17 0x000055fd19e176bd in blk_co_do_preadv_part (blk=3D0x55fd1c269c00, of=
fset=3D0, bytes=3D131072, qiov=3D0x7f8ee8bfff10, qiov_offset=3D0, flags=3D0=
) at ../block/block-backend.c:1344
> #18 0x000055fd19e17588 in blk_co_preadv (blk=3D0x55fd1c269c00, offset=3D0=
, bytes=3D131072, qiov=3D0x7f8ee8bfff10, flags=3D0) at ../block/block-backe=
nd.c:1369
> #19 0x000055fd19e17514 in blk_co_pread (blk=3D0x55fd1c269c00, offset=3D0,=
 bytes=3D131072, buf=3D0x55fd1c16d000, flags=3D0) at ../block/block-backend=
=2Ec:1358
> #20 0x000055fd19ddcc91 in blk_co_pread_entry (opaque=3D0x7ffc4bbdd9a0) at=
 block/block-gen.c:1519
> #21 0x000055fd19feb2a1 in coroutine_trampoline (i0=3D460835072, i1=3D2201=
3) at ../util/coroutine-ucontext.c:177
> #22 0x00007f8ef0cf5c20 in __start_context () at /lib64/libc.so.6
>=20
> io/channel.c:583 is this:
>=20
> 577 void coroutine_fn qio_channel_yield(QIOChannel *ioc,
> 578                                     GIOCondition condition)
> 579 {
> 580     AioContext *ioc_ctx =3D ioc->ctx ?: qemu_get_aio_context();
> 581
> 582     assert(qemu_in_coroutine());
> 583     assert(in_aio_context_home_thread(ioc_ctx));
> 584
>=20

--P+UiO/61XVhMdzQ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUA2h0ACgkQnKSrs4Gr
c8ikKAgAx8KLq/jV+AG23lY/dpQI7haWTM6ZyB42kdsLcAnlmMqV9KJ82djL5kZb
gjHy66Y/Tgg68qpHwgIOrBWKW5qaFJPrZxZ3/2u9RfHCAQdk0jA3/b3Z18o2VAaa
rdYY0auokz9XAdSj90/4IQFVtBu6a2V8tSPPMByA4a7+iKuOToDOuACGRfyZTU7n
ualG9JiDScqK0LsmVVppfYgx410CPOeJYFGEL5Qp0aA7m2u00yiI8wxGo2B3koF6
Z6lhwx5xPNFZWsSUzN7cN6z54ZGpv5YIkpIlfNT+nCQA0rksWSynOM6dwWo7yQmH
TEg2h+UQlwPip3z/Oga2n8fP7e/LFw==
=ANVY
-----END PGP SIGNATURE-----

--P+UiO/61XVhMdzQ5--


