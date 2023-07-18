Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBC87580E5
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 17:30:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLmd9-0006rJ-48; Tue, 18 Jul 2023 11:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLmd6-0006pZ-Bp
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 11:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLmcy-00038W-IZ
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 11:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689694111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sepesA5F9oZlnUfcl0ZwvMVEKRN5pSsT9q/r4njSPGM=;
 b=hy2ro/lIel5aIUdTLVdKEjaVwjtyhjggN7JF6UVlju+Fpg2L/A5qHkAlYXjqncykNgyYX6
 Nno0yvzm4MvnuuitcL2NoOHuUdkEZ6pG7B8mKc7Fv0eTeQ86WZ/5s2s9Yb3N+KxlJMChQg
 RtviGVWmz/AUP/ejmxABGKHMp1aWRXQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-V1TZ_8f4NjOGXOreG6QGFg-1; Tue, 18 Jul 2023 11:28:29 -0400
X-MC-Unique: V1TZ_8f4NjOGXOreG6QGFg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A2E11897B25
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 15:26:09 +0000 (UTC)
Received: from localhost (unknown [10.39.193.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE78B492B03;
 Tue, 18 Jul 2023 15:26:08 +0000 (UTC)
Date: Tue, 18 Jul 2023 11:26:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH] vhost-user.rst: Clarify enabling/disabling vrings
Message-ID: <20230718152607.GI44841@fedora>
References: <20230712091704.15589-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="G2xlurP9FtSwURNn"
Content-Disposition: inline
In-Reply-To: <20230712091704.15589-1-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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


--G2xlurP9FtSwURNn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 11:17:04AM +0200, Hanna Czenczek wrote:
> Currently, the vhost-user documentation says that rings are to be
> initialized in a disabled state when VHOST_USER_F_PROTOCOL_FEATURES is
> negotiated.  However, by the time of feature negotiation, all rings have
> already been initialized, so it is not entirely clear what this means.
>=20
> At least the vhost-user-backend Rust crate's implementation interpreted
> it to mean that whenever this feature is negotiated, all rings are to be
> put into a disabled state, which means that every SET_FEATURES call
> would disable all rings, effectively halting the device.  This is
> problematic because the VHOST_F_LOG_ALL feature is also set or cleared
> this way, which happens during migration.  Doing so should not halt the
> device.
>=20
> Other implementations have interpreted this to mean that the device is
> to be initialized with all rings disabled, and a subsequent SET_FEATURES
> call that does not set VHOST_USER_F_PROTOCOL_FEATURES will enable all of
> them.  Here, SET_FEATURES will never disable any ring.
>=20
> This other interpretation does not suffer the problem of unintentionally
> halting the device whenever features are set or cleared, so it seems
> better and more reasonable.
>=20
> We should clarify this in the documentation.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  docs/interop/vhost-user.rst | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>=20
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 5a070adbc1..ca0e899765 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -383,12 +383,23 @@ and stop ring upon receiving ``VHOST_USER_GET_VRING=
_BASE``.
> =20
>  Rings can be enabled or disabled by ``VHOST_USER_SET_VRING_ENABLE``.
> =20
> -If ``VHOST_USER_F_PROTOCOL_FEATURES`` has not been negotiated, the
> -ring starts directly in the enabled state.
> -
> -If ``VHOST_USER_F_PROTOCOL_FEATURES`` has been negotiated, the ring is
> -initialized in a disabled state and is enabled by
> -``VHOST_USER_SET_VRING_ENABLE`` with parameter 1.
> +Between initialization and the first ``VHOST_USER_SET_FEATURES`` call, it
> +is implementation-defined whether each ring is enabled or disabled.

What is the purpose of this statement? Rings cannot be used before
feature negotiation (with the possible exception of legacy devices that
allowed this to accomodate buggy drivers).

To me this statement complicates things and raises more questions than
it answers.

> +
> +If ``VHOST_USER_SET_FEATURES`` does not negotiate
> +``VHOST_USER_F_PROTOCOL_FEATURES``, each ring, when started, will be
> +enabled immediately.

This sentence can be simplified a little:
"each ring, when started, will be enabled immediately" ->
"rings are enabled immediately when started"

> +
> +If ``VHOST_USER_SET_FEATURES`` does negotiate
> +``VHOST_USER_F_PROTOCOL_FEATURES``, each ring will remain in the disabled
> +state until ``VHOST_USER_SET_VRING_ENABLE`` enables it with parameter 1.
> +
> +Back-end implementations that support ``VHOST_USER_F_PROTOCOL_FEATURES``
> +should implement this by initializing each ring in a disabled state, and
> +enabling them when ``VHOST_USER_SET_FEATURES`` is used without
> +negotiating ``VHOST_USER_F_PROTOCOL_FEATURES``.  Other than that, rings
> +should only be enabled and disabled through
> +``VHOST_USER_SET_VRING_ENABLE``.
> =20
>  While processing the rings (whether they are enabled or not), the back-e=
nd
>  must support changing some configuration aspects on the fly.
> --=20
> 2.41.0
>=20

--G2xlurP9FtSwURNn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS2rw8ACgkQnKSrs4Gr
c8jb4gf+NF3ys9Vcj+sIE7KzHUXWd7RlYlOKmCjcM2oewFOzjrMvMj8NErwvZoJU
mO7+jQUCi3ZZ/yNHxpiZHaKyMG14Kjayx5pGyxVSPlYJ/oF+6x0MFIHz/QyH1U/t
P/s8vi0gIWQomjpfY7uvVWpt6L1tqHyMwm874aKI92KPg+DsUsGKldB9B0W1nECL
3eAnDse4JOojF7RIC2n3zdPrH7Eql3QWH4Pdcb0NlCrAgDx1wPmluNm+fp2CEmSa
wtSw01KBx8urGIhMxK8xQ4vmO7o+wgSkbelpDLJ5u2L6+9zBsz2hiuDj0k/9VeT0
SC+tRszAnXztfhra7nTEy6teed27Yw==
=zI+d
-----END PGP SIGNATURE-----

--G2xlurP9FtSwURNn--


