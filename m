Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2AF7ADF7D
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 21:16:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkr3Q-0007PK-Oq; Mon, 25 Sep 2023 15:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qkr3H-0007Nz-3k
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:15:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qkr33-0000Cr-W8
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695669313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oYd4cGLTqlek0k+NyrWTKvzBF3R03FkPDQTx0fdOHOg=;
 b=TDgodsJfzvhOOR35kweVEmz0Xa3jo1xe5twzOOzo+vHxUsaWbgI4F++Lvf5B9YlQ5PmM4o
 EbUWmmek912q4S+1lAvPvbNhR+9U8AEIlBj+pyyu/UzZGwMpzpk2AZZ0pScHdXkhK5Y+mf
 D9I7zAcIim07GNPG04UqBvZC8q2N6Y4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-Z1er7K7AMnikWiXi1a_-pQ-1; Mon, 25 Sep 2023 15:15:11 -0400
X-MC-Unique: Z1er7K7AMnikWiXi1a_-pQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6EEE811E88
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 19:15:10 +0000 (UTC)
Received: from localhost (unknown [10.39.194.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3899240C2064;
 Mon, 25 Sep 2023 19:15:10 +0000 (UTC)
Date: Mon, 25 Sep 2023 15:15:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH v3 2/5] vhost-user.rst: Clarify enabling/disabling vrings
Message-ID: <20230925191508.GC323580@fedora>
References: <20230915102531.55894-1-hreitz@redhat.com>
 <20230915102531.55894-3-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BfM2EkcGqH2TU2ew"
Content-Disposition: inline
In-Reply-To: <20230915102531.55894-3-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


--BfM2EkcGqH2TU2ew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 12:25:27PM +0200, Hanna Czenczek wrote:
> Currently, the vhost-user documentation says that rings are to be
> initialized in a disabled state when VHOST_USER_F_PROTOCOL_FEATURES is
> negotiated.  However, by the time of feature negotiation, all rings have
> already been initialized, so it is not entirely clear what this means.
>=20
> At least the vhost-user-backend Rust crate's implementation interpreted
> it to mean that whenever this feature is negotiated, all rings are to
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
> This interpretation does not suffer the problem of unintentionally
> halting the device whenever features are set or cleared, so it seems
> better and more reasonable.
>=20
> We should clarify this in the documentation.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  docs/interop/vhost-user.rst | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
>=20
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index bb4dd0fd60..9b9b802c60 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -409,12 +409,20 @@ and stop ring upon receiving ``VHOST_USER_GET_VRING=
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
> +If ``VHOST_USER_SET_FEATURES`` does not negotiate
> +``VHOST_USER_F_PROTOCOL_FEATURES``, rings are enabled immediately when
> +started.
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

The "Ring states" section starts by saying there are three states:
"stopped", "started but disabled", and "started and enabled". But this
patch talks about a "disabled state". Can you rephrase this patch to use
the exact state names defined earlier in the spec?

> =20
>  While processing the rings (whether they are enabled or not), the back-e=
nd
>  must support changing some configuration aspects on the fly.
> --=20
> 2.41.0
>=20

--BfM2EkcGqH2TU2ew
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUR3DwACgkQnKSrs4Gr
c8g9OQgAw8L3+6/Kc6EjS93xCmyTwcdvnQg8LYZE6adnPD3bVfZml0+/68IeKmnH
10OWY+63EMBWuxXfj1AIleVrF/SX89dsLJ59lfiu2fR7ODldnCHMZ+c1vrg7D7Ve
FBCoo5iSG4UaIEz2EQIkl4kUOs7gXwiIRuzxcuAI3BLxFLdT8j7Q0pxmNn3iQO4O
aksrnhGm6SCcDwcAicxhPPYnyyeEuiAOBumvfypVIgWHk7by31hvsruJ1aHDMUvi
JmOpK8qv7SQwfzJnHNfl2odWMM3GNCSFZRCMMyRzoK7t9iDXwzQoztNZnvQjZ/VX
BrgndZj3zTNo59zfT91lyvdsEMK5Kg==
=minv
-----END PGP SIGNATURE-----

--BfM2EkcGqH2TU2ew--


