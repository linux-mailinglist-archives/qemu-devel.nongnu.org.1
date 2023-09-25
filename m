Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8937ADF6D
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 21:04:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqsw-0007Ki-3V; Mon, 25 Sep 2023 15:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qkqsp-00073Q-ID
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:04:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qkqsl-0006Fc-Sr
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695668674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TpY7LsIzo2Zh2ob1psGzR4n7GX8ELbBC4TE+wnWRrtQ=;
 b=B2HjhPXq1DO33uRLl0Wa5y9KuQuX5aUeUGTzXVC/2CK0VVyMGdmN7VbXmL+Dfdo3iGv6qP
 3fMK6dmbGEXQUCjArESYvZehaojsHXECb7tpFBeZlFp4NXy1rlLgQab3F3zPS+SOirMCzd
 XABy/KnNBv7KkjmvTG7U4uDosGoMKnI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137--ZEHfLZjPemuPD6F1fRb6Q-1; Mon, 25 Sep 2023 15:04:33 -0400
X-MC-Unique: -ZEHfLZjPemuPD6F1fRb6Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFEA829AB411
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 19:04:32 +0000 (UTC)
Received: from localhost (unknown [10.39.194.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61B4F711293;
 Mon, 25 Sep 2023 19:04:32 +0000 (UTC)
Date: Mon, 25 Sep 2023 15:04:31 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH v3 1/5] vhost-user.rst: Migrating back-end-internal state
Message-ID: <20230925190431.GB323580@fedora>
References: <20230915102531.55894-1-hreitz@redhat.com>
 <20230915102531.55894-2-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="G/2yNfBg+jWKHP+w"
Content-Disposition: inline
In-Reply-To: <20230915102531.55894-2-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--G/2yNfBg+jWKHP+w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 12:25:26PM +0200, Hanna Czenczek wrote:
> For vhost-user devices, qemu can migrate the virtio state, but not the
> back-end's internal state.  To do so, we need to be able to transfer
> this internal state between front-end (qemu) and back-end.
>=20
> At this point, this new feature is added for the purpose of virtio-fs
> migration.  Because virtiofsd's internal state will not be too large, we
> believe it is best to transfer it as a single binary blob after the
> streaming phase.
>=20
> These are the additions to the protocol:
> - New vhost-user protocol feature VHOST_USER_PROTOCOL_F_DEVICE_STATE
> - SET_DEVICE_STATE_FD function: Front-end and back-end negotiate a file
>   descriptor over which to transfer the state.
> - CHECK_DEVICE_STATE: After the state has been transferred through the
>   file descriptor, the front-end invokes this function to verify
>   success.  There is no in-band way (through the file descriptor) to
>   indicate failure, so we need to check explicitly.
>=20
> Once the transfer FD has been established via SET_DEVICE_STATE_FD
> (which includes establishing the direction of transfer and migration
> phase), the sending side writes its data into it, and the reading side
> reads it until it sees an EOF.  Then, the front-end will check for
> success via CHECK_DEVICE_STATE, which on the destination side includes
> checking for integrity (i.e. errors during deserialization).
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  docs/interop/vhost-user.rst | 170 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 170 insertions(+)

Great documentation!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--G/2yNfBg+jWKHP+w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUR2b8ACgkQnKSrs4Gr
c8iMLwf/f5GkieEgVbXuahClGPFQAjBdciOmypJvZyRxcTvOhb4fu6UOJRRSe7Sr
+r8lF6GyaMpq3MyT58JgMVL9tKRaNNGNEEzVPVqrB2sugMet2ZHZA7pSaGKa8Y8R
q9dEeSTmBBZyX0DXlFcP64PCjU6GmooJ0evS0kIMdIFgv4wUW12MiDtP3YDgwphD
iALLapDCmcvMOUESc6KSpIeDjwU4qrUmpGzhqdQzoh4FJaKjuLaWZuye+Nlnvens
SXpvgTlMJNzBZrNuqtGJY7bnUPYbQfXvcTVQxMF241mq11IuiUndEi3D5SVLOvlK
+P3n0iB1UF6Jcz+R8mwswUxS91xs6g==
=2EeV
-----END PGP SIGNATURE-----

--G/2yNfBg+jWKHP+w--


