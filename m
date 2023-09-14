Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CFD7A034E
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 14:04:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgl2x-0008Lu-3j; Thu, 14 Sep 2023 08:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgl2e-0008Hl-VL
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:01:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgl2d-0007G2-8Q
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694692910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TSTOTOb5zzkKJQ/TIFjTIGQWgCj4QQEfxJx1HoLf9qk=;
 b=afIZVbr9D1rK1rCg2x0vN2G3Pr0uabPaq9GVuAn9Nf6guFsbyVhpwwdkHsnX4z9Odqosbb
 VRoI21qxChaJoSutx2qTtDfx9eswHM6M0Ob7pTR2FPBKzpizFlLdaSYcAP3YW66gSv29gR
 5KBFsmrc7dCApEuygsNWQNk3BgnIp/Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-h8RN0XYMPeKQPCXlTnRPSw-1; Thu, 14 Sep 2023 08:01:44 -0400
X-MC-Unique: h8RN0XYMPeKQPCXlTnRPSw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AF5180663B;
 Thu, 14 Sep 2023 12:01:44 +0000 (UTC)
Received: from localhost (unknown [10.39.194.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C1C82026D4B;
 Thu, 14 Sep 2023 12:01:43 +0000 (UTC)
Date: Thu, 14 Sep 2023 08:01:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Klaus Jensen <its@irrelevant.dk>,
 kwolf@redhat.com, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-block@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 David Hildenbrand <david@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v3 2/5] test-bdrv-drain: avoid race with BH in IOThread
 drain test
Message-ID: <20230914120141.GA1047741@fedora>
References: <20230912231037.826804-1-stefanha@redhat.com>
 <20230912231037.826804-3-stefanha@redhat.com>
 <wxfg62pyjq2dhh7jfhpng7tgnkaz3o5zkdie426m7tbgopjkhm@gijotjxjzjhf>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rsWJjwQVfkIsIMzw"
Content-Disposition: inline
In-Reply-To: <wxfg62pyjq2dhh7jfhpng7tgnkaz3o5zkdie426m7tbgopjkhm@gijotjxjzjhf>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--rsWJjwQVfkIsIMzw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 11:08:54AM -0500, Eric Blake wrote:
> On Tue, Sep 12, 2023 at 07:10:34PM -0400, Stefan Hajnoczi wrote:
> > This patch fixes a race condition in test-bdrv-drain that is difficult
> > to reproduce. test-bdrv-drain sometimes fails without an error message
> > on the block pull request sent by Kevin Wolf on Sep 4, 2023. I was able
> > to reproduce it locally and found that "block-backend: process I/O in
> > the current AioContext" (in this patch series) is the first commit where
> > it reproduces.
> >=20
> > I do not know why "block-backend: process I/O in the current AioContext"
> > exposes this bug. It might be related to the fact that the test's preadv
> > request runs in the main thread instead of IOThread a after my commit.
>=20
> In reading the commit message before the impacted code, my first
> thought was that you had a typo of an extra word (that is, something
> to fix by s/a //), but reading further, a better fix would be calling
> attention to the fact that you are referencing a specific named
> thread, as in s/IOThread a/IOThread A/...
>=20
> > That might simply change the timing of the test.
> >=20
> > Now on to the race condition in test-bdrv-drain. The main thread
> > schedules a BH in IOThread a and then drains the BDS:
>=20
> ...and another spot with the same parse issue...
>=20
> >=20
> >   aio_bh_schedule_oneshot(ctx_a, test_iothread_main_thread_bh, &data);
> >=20
> >   /* The request is running on the IOThread a. Draining its block device
>=20
> ...but here you were quoting from the existing code base, which is
> where I finally realized it was more than just your commit message.
>=20
> >    * will make sure that it has completed as far as the BDS is concerne=
d,
> >    * but the drain in this thread can continue immediately after
> >    * bdrv_dec_in_flight() and aio_ret might be assigned only slightly
> >    * later. */
> >   do_drain_begin(drain_type, bs);
> >=20
> > If the BH completes before do_drain_begin() then there is nothing to
> > worry about.
> >=20
> > If the BH invokes bdrv_flush() before do_drain_begin(), then
> > do_drain_begin() waits for it to complete.
> >=20
> > The problematic case is when do_drain_begin() runs before the BH enters
> > bdrv_flush(). Then do_drain_begin() misses the BH and the drain
> > mechanism has failed in quiescing I/O.
> >=20
> > Fix this by incrementing the in_flight counter so that do_drain_begin()
> > waits for test_iothread_main_thread_bh().
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  tests/unit/test-bdrv-drain.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/tests/unit/test-bdrv-drain.c b/tests/unit/test-bdrv-drain.c
> > index ccc453c29e..67a79aa3f0 100644
> > --- a/tests/unit/test-bdrv-drain.c
> > +++ b/tests/unit/test-bdrv-drain.c
> > @@ -512,6 +512,7 @@ static void test_iothread_main_thread_bh(void *opaq=
ue)
> >       * executed during drain, otherwise this would deadlock. */
> >      aio_context_acquire(bdrv_get_aio_context(data->bs));
> >      bdrv_flush(data->bs);
> > +    bdrv_dec_in_flight(data->bs); /* incremented by test_iothread_comm=
on() */
> >      aio_context_release(bdrv_get_aio_context(data->bs));
> >  }
> > =20
> > @@ -583,6 +584,13 @@ static void test_iothread_common(enum drain_type d=
rain_type, int drain_thread)
> >              aio_context_acquire(ctx_a);
> >          }
> > =20
> > +        /*
> > +         * Increment in_flight so that do_drain_begin() waits for
> > +         * test_iothread_main_thread_bh(). This prevents the race betw=
een
> > +         * test_iothread_main_thread_bh() in IOThread a and do_drain_b=
egin() in
> > +         * this thread. test_iothread_main_thread_bh() decrements in_f=
light.
> > +         */
> > +        bdrv_inc_in_flight(bs);
> >          aio_bh_schedule_oneshot(ctx_a, test_iothread_main_thread_bh, &=
data);
> > =20
> >          /* The request is running on the IOThread a. Draining its bloc=
k device
>=20
> and indeed, your commit message is consistent with the current code's
> naming convention.  If you have reason to respin, a pre-req patch to
> change the case before adding more references might be nice, but I
> won't insist.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Sorry about that. It is confusing.

Stefan

--rsWJjwQVfkIsIMzw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUC9iUACgkQnKSrs4Gr
c8itogf/RfNGz3pt83PCOgW2z3b4JqPE3k3PQF4TxOF4bcye/y7ldOecOrFlRmV6
HalYqp43Apsm/MWUH9zKV23rUljXXdQ/1lkT9iaEGT/KqFElPE4HGnRwltiBAkJV
uQVwKRsRXEb0Q0ZNDZBrACowV9wFkKQ7JqZsJzZs3xUmbMTVohJWHIY+R3FG++HQ
CDV4tO9Yai2d1WDbjEWGxowESplK0ENV/jXKJThsrNg88TecUl8VC6tO3za2PUqX
pQGQOUHIWEeFanAxoNxA6v2DntPOPcyD8YDPEMXenh0kYabiGVkzLlTx3CTlRVs+
n+PSvEAnJ7WNDwiWD2ZVp7CFo8a6Yw==
=f4sk
-----END PGP SIGNATURE-----

--rsWJjwQVfkIsIMzw--


