Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BB9750AAD
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 16:18:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJaek-0002Z4-0o; Wed, 12 Jul 2023 10:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qJaeh-0002We-2o
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 10:17:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qJaef-0003ff-Ed
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 10:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689171440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T+2JuoXQ/dY5epWWGbCNiK8tTanuvsVR9w6Lf/XxHs8=;
 b=LCxVYM6b5aXbzczSTJbbe8OmCIumVhllWn11d5fYoLfjQdLTrqKQs3EjwCSEHGiae4yxC/
 2tHAYot9siTrfP45OD2gGlBTIRsIiUJk/pKx2bVMrlrHJyydZKe1UyYfYaI3MuEgnvx+0T
 uf1m4OTql0qjwk42BdbAfodnE9gWfvU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-iREUdi0mP9-bLEMnuBnECw-1; Wed, 12 Jul 2023 10:17:18 -0400
X-MC-Unique: iREUdi0mP9-bLEMnuBnECw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A70C90EAA1;
 Wed, 12 Jul 2023 14:15:37 +0000 (UTC)
Received: from localhost (unknown [10.39.192.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9317E40C2063;
 Wed, 12 Jul 2023 14:15:36 +0000 (UTC)
Date: Wed, 12 Jul 2023 10:15:35 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] block: Fix pad_request's request restriction
Message-ID: <20230712141535.GA215287@fedora>
References: <20230609083316.24629-1-hreitz@redhat.com>
 <20230711202321.GB154686@fedora>
 <d4459ee1-bdea-bff0-ab99-b38de004c2a7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dPUW1oYuH0u0tqS5"
Content-Disposition: inline
In-Reply-To: <d4459ee1-bdea-bff0-ab99-b38de004c2a7@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--dPUW1oYuH0u0tqS5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 09:41:05AM +0200, Hanna Czenczek wrote:
> On 11.07.23 22:23, Stefan Hajnoczi wrote:
> > On Fri, Jun 09, 2023 at 10:33:16AM +0200, Hanna Czenczek wrote:
> > > bdrv_pad_request() relies on requests' lengths not to exceed SIZE_MAX,
> > > which bdrv_check_qiov_request() does not guarantee.
> > >=20
> > > bdrv_check_request32() however will guarantee this, and both of
> > > bdrv_pad_request()'s callers (bdrv_co_preadv_part() and
> > > bdrv_co_pwritev_part()) already run it before calling
> > > bdrv_pad_request().  Therefore, bdrv_pad_request() can safely call
> > > bdrv_check_request32() without expecting error, too.
> > >=20
> > > There is one difference between bdrv_check_qiov_request() and
> > > bdrv_check_request32(): The former takes an errp, the latter does not,
> > > so we can no longer just pass &error_abort.  Instead, we need to check
> > > the returned value.  While we do expect success (because the callers
> > > have already run this function), an assert(ret =3D=3D 0) is not much =
simpler
> > > than just to return an error if it occurs, so let us handle errors by
> > > returning them up the stack now.
> > Is this patch intended to silence a Coverity warning or can this be
> > triggered by a guest?
>=20
> Neither.=C2=A0 There was a Coverity warning about the `assert(*bytes <=3D
> SIZE_MAX)`, which is always true on 32-bit architectures. Regardless of
> Coverity, Peter inquired how bdrv_check_qiov_request() would guarantee th=
is
> condition (as the comments I=E2=80=99ve put above the assertions say).=C2=
=A0 It doesn=E2=80=99t,
> only bdrv_check_request32() does, which I was thinking of, and just confu=
sed
> the two.

It's unclear to me whether this patch silences a Coverity warning or
not? You said "neither", but then you acknowledged there was a Coverity
warning. Maybe "was" (past-tense) means something else already fixed it
but I don't see any relevant commits in the git log.

> As the commit message says, all callers already run bdrv_check_request32(=
),
> so I expect this change to functionally be a no-op.=C2=A0 (That is why the
> pre-patch code runs bdrv_check_qiov_request() with `&error_abort`.)

Okay, this means a guest cannot trigger the assertion failure.

Please mention the intent in the commit description: a code cleanup
requested by Peter and/or a Coverity warning fix, but definitely not
guest triggerable assertion failure.

>=20
> > I find this commit description and patch confusing. Instead of checking
> > the actual SIZE_MAX value that bdrv_pad_request() relies on, we use a
> > 32-bit offsets/lengths helper because it checks INT_MAX or SIZE_MAX (but
> > really INT_MAX, because that's always smaller on host architectures that
> > QEMU supports).
>=20
> I preferred to use a bounds-checking function that we already use for
> requests, and that happens to be used to limit all I/O that ends up here =
in
> bdrv_pad_request() anyway, instead of adding a new specific limit.
>=20
> It doesn=E2=80=99t matter to me, though.=C2=A0 The callers already ensure=
 that everything
> is in bounds, so I=E2=80=99d be happy with anything, ranging from keeping=
 the bare
> assertions with no checks beforehand, over specifically checking SIZE_MAX
> and returning an error then, to bdrv_check_request32().
>=20
> (I thought repeating the simple bounds check that all callers already did
> for verbosity would be the most robust and obvious way to do it, but now =
I=E2=80=99m
> biting myself for not just using bare assertions annotated with =E2=80=9C=
Caller must
> guarantee this=E2=80=9D from the start...)

Okay. I looked at the code more and don't see a cleanup for the overall
problem of duplicated checks and type mismatches (size_t vs int64_t)
that is appropriate for this patch.

I'm okay with this fix, but please clarify the intent as mentioned above.

>=20
> Hanna
>=20
> > Vladimir: Is this the intended use of bdrv_check_request32()?
> >=20
> > > Reported-by: Peter Maydell <peter.maydell@linaro.org>
> > > Fixes: 18743311b829cafc1737a5f20bc3248d5f91ee2a
> > >         ("block: Collapse padded I/O vecs exceeding IOV_MAX")
> > > Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> > > ---
> > >   block/io.c | 8 ++++++--
> > >   1 file changed, 6 insertions(+), 2 deletions(-)
> > > diff --git a/block/io.c b/block/io.c
> > > index 30748f0b59..e43b4ad09b 100644
> > > --- a/block/io.c
> > > +++ b/block/io.c
> > > @@ -1710,7 +1710,11 @@ static int bdrv_pad_request(BlockDriverState *=
bs,
> > >       int sliced_niov;
> > >       size_t sliced_head, sliced_tail;
> > > -    bdrv_check_qiov_request(*offset, *bytes, *qiov, *qiov_offset, &e=
rror_abort);
> > > +    /* Should have been checked by the caller already */
> > > +    ret =3D bdrv_check_request32(*offset, *bytes, *qiov, *qiov_offse=
t);
> > > +    if (ret < 0) {
> > > +        return ret;
> > > +    }
> > >       if (!bdrv_init_padding(bs, *offset, *bytes, write, pad)) {
> > >           if (padded) {
> > > @@ -1723,7 +1727,7 @@ static int bdrv_pad_request(BlockDriverState *b=
s,
> > >                                     &sliced_head, &sliced_tail,
> > >                                     &sliced_niov);
> > > -    /* Guaranteed by bdrv_check_qiov_request() */
> > > +    /* Guaranteed by bdrv_check_request32() */
> > >       assert(*bytes <=3D SIZE_MAX);
> > >       ret =3D bdrv_create_padded_qiov(bs, pad, sliced_iov, sliced_nio=
v,
> > >                                     sliced_head, *bytes);
> > > --=20
> > > 2.40.1
> > >=20
>=20

--dPUW1oYuH0u0tqS5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmSutYYACgkQnKSrs4Gr
c8gaiAf/YzP/8OoBB+ex0dzig8Vs2+NIk+onBOZDw2VJ6L5ZZGA1KLXgjaKYMnKX
9odDc195hPN8/3bJ/5aAczOAGf7GPMBrtrO4wkiu6Uu583J641MB+kuxbci2vqgJ
ztyFVUd2u6hdKoeolKotwAqcnt5xFowB6AmDcqtnqFXBZBKPvUS4BR8doTdxKT97
w3/6rggJAHCm0tf76A6q0gq3yC/r/WYILQqQc+gBnVVSk0BPbAU3sm9SRXTQaeXv
4CqIIhe18Jsd4+txOSoduRCuMXClux7SYGXVflqxqZkAKpZqU2bqAmD77RR0rkUQ
uBdcdgze1LyJhZe5k9N0/rFBXz45Ug==
=aLlU
-----END PGP SIGNATURE-----

--dPUW1oYuH0u0tqS5--


