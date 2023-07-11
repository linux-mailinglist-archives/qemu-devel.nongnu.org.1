Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7FE74F8FD
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 22:24:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJJtU-0005fz-Lw; Tue, 11 Jul 2023 16:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qJJtS-0005fK-ML
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 16:23:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qJJtR-0005Oz-1c
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 16:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689107007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I/FhIW2HpA8NS8Ym8AcTIRuJ4/1cJPrT7soTueXP+9g=;
 b=D++nCWsqe2Se9O+aPl/u61xsLluSi/ocSoxmu4Oi6Swjy+QxDF22KVdpWMAaEntHM8I8CV
 9MgkabLFhxZYnXmTuFxtV2tVJdqmzE0Fx9enivr8xPIyZFu007CK/CcVNK6KNnYCT5s+gB
 qzWAyzxcV6l601yTv5T6QhYVk9xlPjI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-507-0lnq5CKrOx23nNufuqPlWA-1; Tue, 11 Jul 2023 16:23:24 -0400
X-MC-Unique: 0lnq5CKrOx23nNufuqPlWA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 497B48EBBA6;
 Tue, 11 Jul 2023 20:23:24 +0000 (UTC)
Received: from localhost (unknown [10.39.192.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A3152C09A09;
 Tue, 11 Jul 2023 20:23:23 +0000 (UTC)
Date: Tue, 11 Jul 2023 16:23:21 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] block: Fix pad_request's request restriction
Message-ID: <20230711202321.GB154686@fedora>
References: <20230609083316.24629-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PxMwyC6v7qLLaBSW"
Content-Disposition: inline
In-Reply-To: <20230609083316.24629-1-hreitz@redhat.com>
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


--PxMwyC6v7qLLaBSW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2023 at 10:33:16AM +0200, Hanna Czenczek wrote:
> bdrv_pad_request() relies on requests' lengths not to exceed SIZE_MAX,
> which bdrv_check_qiov_request() does not guarantee.
>=20
> bdrv_check_request32() however will guarantee this, and both of
> bdrv_pad_request()'s callers (bdrv_co_preadv_part() and
> bdrv_co_pwritev_part()) already run it before calling
> bdrv_pad_request().  Therefore, bdrv_pad_request() can safely call
> bdrv_check_request32() without expecting error, too.
>=20
> There is one difference between bdrv_check_qiov_request() and
> bdrv_check_request32(): The former takes an errp, the latter does not,
> so we can no longer just pass &error_abort.  Instead, we need to check
> the returned value.  While we do expect success (because the callers
> have already run this function), an assert(ret =3D=3D 0) is not much simp=
ler
> than just to return an error if it occurs, so let us handle errors by
> returning them up the stack now.

Is this patch intended to silence a Coverity warning or can this be
triggered by a guest?

I find this commit description and patch confusing. Instead of checking
the actual SIZE_MAX value that bdrv_pad_request() relies on, we use a
32-bit offsets/lengths helper because it checks INT_MAX or SIZE_MAX (but
really INT_MAX, because that's always smaller on host architectures that
QEMU supports).

Vladimir: Is this the intended use of bdrv_check_request32()?

>=20
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: 18743311b829cafc1737a5f20bc3248d5f91ee2a
>        ("block: Collapse padded I/O vecs exceeding IOV_MAX")
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/io.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

>=20
> diff --git a/block/io.c b/block/io.c
> index 30748f0b59..e43b4ad09b 100644
> --- a/block/io.c
> +++ b/block/io.c
> @@ -1710,7 +1710,11 @@ static int bdrv_pad_request(BlockDriverState *bs,
>      int sliced_niov;
>      size_t sliced_head, sliced_tail;
> =20
> -    bdrv_check_qiov_request(*offset, *bytes, *qiov, *qiov_offset, &error=
_abort);
> +    /* Should have been checked by the caller already */
> +    ret =3D bdrv_check_request32(*offset, *bytes, *qiov, *qiov_offset);
> +    if (ret < 0) {
> +        return ret;
> +    }
> =20
>      if (!bdrv_init_padding(bs, *offset, *bytes, write, pad)) {
>          if (padded) {
> @@ -1723,7 +1727,7 @@ static int bdrv_pad_request(BlockDriverState *bs,
>                                    &sliced_head, &sliced_tail,
>                                    &sliced_niov);
> =20
> -    /* Guaranteed by bdrv_check_qiov_request() */
> +    /* Guaranteed by bdrv_check_request32() */
>      assert(*bytes <=3D SIZE_MAX);
>      ret =3D bdrv_create_padded_qiov(bs, pad, sliced_iov, sliced_niov,
>                                    sliced_head, *bytes);
> --=20
> 2.40.1
>=20

--PxMwyC6v7qLLaBSW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmStujkACgkQnKSrs4Gr
c8gw4gf+Mi8vgMTx+MfQmr0f2mVXldcX/iXtubCz47wof8GakPxNP2kkT0k2N4H/
CisraqVVkav1ttbexdhG72KPSyfu+Jbr2btkze3XggPDa5/8eN5c7+/2j5BraaI+
DhyXIiitLEi82ulZ4Cjrmd5lyoASsiw4KvN9p0H64UU8yNiUjfD5XvQgmMigwIZv
i15Qxn4RdjPJcm9IdQYEonEQ7venWS+EBxDa+X84S6EyFSzJmbFFIjMfgB1ND78K
tBUphMwkG0R3SpsIzRXXTuHgiKVuEnWWfGtw8FdKq3tUDn6E5aWlWOSTW+oSVx//
7H4G95dfZvonPYE6pLGAprfWL1+/Cw==
=02Z+
-----END PGP SIGNATURE-----

--PxMwyC6v7qLLaBSW--


