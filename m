Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B3A756E47
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 22:33:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLUtO-0000OD-PT; Mon, 17 Jul 2023 16:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLUtE-0000J0-12
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 16:32:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLUtB-0002n5-D9
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 16:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689625932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4dQt6PeBorsPiA1WhXvMXdyarmg/h/ueFgzggvKQumw=;
 b=UCk6qggtR4rLrPJ2Fb360cst5qAVlDvJP8cNk9wDIsHJTgGBywtxKunryfiagJNjTMRnkQ
 97EWYkxCqO+DK9NeYNxUyfMizXwcBZT5asXPDcbo/izQJ346jtXl0U7X+KQWYg8mi2l6d3
 amqBk9AmvqOmDg+Rs3cIWWREdYGW2XY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-339-paMAOM57P-SPBJ7aH83vTw-1; Mon, 17 Jul 2023 16:32:09 -0400
X-MC-Unique: paMAOM57P-SPBJ7aH83vTw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9342800B35;
 Mon, 17 Jul 2023 20:32:08 +0000 (UTC)
Received: from localhost (unknown [10.39.194.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 444F640C206F;
 Mon, 17 Jul 2023 20:32:07 +0000 (UTC)
Date: Mon, 17 Jul 2023 16:32:06 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2] block: Fix pad_request's request restriction
Message-ID: <20230717203206.GA461188@fedora>
References: <20230714085938.202730-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="p7qN2C5FPk6RR9tW"
Content-Disposition: inline
In-Reply-To: <20230714085938.202730-1-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--p7qN2C5FPk6RR9tW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2023 at 10:59:38AM +0200, Hanna Czenczek wrote:
> bdrv_pad_request() relies on requests' lengths not to exceed SIZE_MAX,
> which bdrv_check_qiov_request() does not guarantee.
>=20
> bdrv_check_request32() however will guarantee this, and both of
> bdrv_pad_request()'s callers (bdrv_co_preadv_part() and
> bdrv_co_pwritev_part()) already run it before calling
> bdrv_pad_request().  Therefore, bdrv_pad_request() can safely call
> bdrv_check_request32() without expecting error, too.
>=20
> In effect, this patch will not change guest-visible behavior.  It is a
> clean-up to tighten a condition to match what is guaranteed by our
> callers, and which exists purely to show clearly why the subsequent
> assertion (`assert(*bytes <=3D SIZE_MAX)`) is always true.
>=20
> Note there is a difference between the interfaces of
> bdrv_check_qiov_request() and bdrv_check_request32(): The former takes
> an errp, the latter does not, so we can no longer just pass
> &error_abort.  Instead, we need to check the returned value.  While we
> do expect success (because the callers have already run this function),
> an assert(ret =3D=3D 0) is not much simpler than just to return an error =
if
> it occurs, so let us handle errors by returning them up the stack now.
>=20
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: 18743311b829cafc1737a5f20bc3248d5f91ee2a
>        ("block: Collapse padded I/O vecs exceeding IOV_MAX")
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
> v2:
> - Added paragraph to the commit message to express explicitly that this
>   patch will not change guest-visible behavior
> - (No code changes)
> ---
>  block/io.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Thanks, applied to my block-next tree:
https://gitlab.com/stefanha/qemu/commits/block-next

Stefan

--p7qN2C5FPk6RR9tW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS1pUYACgkQnKSrs4Gr
c8jOhAf+K+krLHr6H/tSOgf6NYmHEZPE7xTtrMdcP9XcwrZnG4w69A9z4JZwjrqg
iIwMa/SRG4qtgLuY7nb+Vc6izZp7dVa0YkD0LqUCKEOpyQc6LqL+VGD/1QGyh10o
TpGQClILkwiEiEtMTga06RM5UUp2J2XoEu7eSNKrufRAWU4NHgTQoEXuFYq4+SsT
DKQIPt0WbhGSm2VV5n9FZ0RIAlhRxJSGvk0JU6NPlmHQnQMHR+PtDKHq9DCG0e8L
IJq/i1dmDHFjJzg1Ral/mEzLnrtc1A+m0fOuLjdynrNdjrH9ifrt8A4azNlswAoU
EC9fYqJbKA0ca1MOHfttj8AVblDW8g==
=JBp6
-----END PGP SIGNATURE-----

--p7qN2C5FPk6RR9tW--


