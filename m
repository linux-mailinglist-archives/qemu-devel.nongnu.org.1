Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2053A757F7A
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 16:30:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLlhD-0002QU-SZ; Tue, 18 Jul 2023 10:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLlhC-0002QL-Mo
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 10:28:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLlhA-00058L-Qv
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 10:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689690535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sKRxezIWv9bNAZnULYIkA0HwxtFvM11S9el6zMtQ/SQ=;
 b=S89enlZGSKlQ280l3ET2NTIuNIImM1zwxh9Y1yAcBj2cQt4IhrJbJjiRusoM/1vuzNxGkK
 2mxErE637D9wVsAWag3p0gFzcwKDovuDWH+oCL/LcnaiwwMJcWgPL/gWwbrsINJBal0kDf
 iPGrCt75WRr19U6OJviuqiorcLbJtHo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-hT1N_aRBNvmtJc151LO2iw-1; Tue, 18 Jul 2023 10:28:48 -0400
X-MC-Unique: hT1N_aRBNvmtJc151LO2iw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20E558B0432
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 14:26:00 +0000 (UTC)
Received: from localhost (unknown [10.39.193.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77F502166B26;
 Tue, 18 Jul 2023 14:25:59 +0000 (UTC)
Date: Tue, 18 Jul 2023 10:25:57 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH 1/6] vhost-user.rst: Add suspend/resume
Message-ID: <20230718142557.GB44841@fedora>
References: <20230711155230.64277-1-hreitz@redhat.com>
 <20230711155230.64277-2-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rmnj5HorlSCbRvKy"
Content-Disposition: inline
In-Reply-To: <20230711155230.64277-2-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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


--rmnj5HorlSCbRvKy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 05:52:23PM +0200, Hanna Czenczek wrote:
> When stopping the VM, qemu wants all devices to fully cease any
> operation, too.  Currently, we can only have vhost-user back-ends stop
> processing vrings, but not background operations.  Add the SUSPEND and
> RESUME commands from vDPA, which allow the front-end (qemu) to tell
> back-ends to cease all operations, including those running in the
> background.
>=20
> qemu's current work-around for this is to reset the back-end instead of
> suspending it, which will not work for back-ends that have internal
> state that must be preserved across e.g. stop/cont.
>=20
> Note that the given specification requires the back-end to delay
> processing kicks (i.e. starting vrings) until the device is resumed,
> instead of requiring the front-end not to send kicks while suspended.
> qemu starts devices (and would just resume them) only when the VM is in
> a running state, so it would be difficult to have qemu delay kicks until
> the device is resumed, which is why this patch specifies handling of
> kicks as it does.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  docs/interop/vhost-user.rst | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
>=20
> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> index 5a070adbc1..ac6be34c4c 100644
> --- a/docs/interop/vhost-user.rst
> +++ b/docs/interop/vhost-user.rst
> @@ -381,6 +381,10 @@ readable) on the descriptor specified by ``VHOST_USE=
R_SET_VRING_KICK``
>  or receiving the in-band message ``VHOST_USER_VRING_KICK`` if negotiated,
>  and stop ring upon receiving ``VHOST_USER_GET_VRING_BASE``.
> =20
> +While the back-end is suspended (via ``VHOST_USER_SUSPEND``), it must
> +never process rings, and thus also delay handling kicks until the

If you respin this series, I suggest replacing "never" with "not" to
emphasize that ring processing is only skipped while the device is
suspended (rather than forever). "Never" feels too strong to use when
describing a temporary state.

> +back-end is resumed again.
> +
>  Rings can be enabled or disabled by ``VHOST_USER_SET_VRING_ENABLE``.
> =20
>  If ``VHOST_USER_F_PROTOCOL_FEATURES`` has not been negotiated, the
> @@ -479,8 +483,9 @@ supplied by ``VhostUserLog``.
>  ancillary data, it may be used to inform the front-end that the log has
>  been modified.
> =20
> -Once the source has finished migration, rings will be stopped by the
> -source. No further update must be done before rings are restarted.
> +Once the source has finished migration, the device will be suspended and
> +its rings will be stopped by the source. No further update must be done
> +before the device and its rings are resumed.

This paragraph is abstract and doesn't directly identify the mechanisms
or who does what:
- "the device will be suspended" via VHOST_USER_SUSPEND (or reset when
  VHOST_USER_SUSPEND is not supported?) or automatically by the device
  itself or some other mechanism?
- "before the device and its rings are resumed" via VHOST_USER_RESUME?
  And is this referring to the source device?

Please rephrase the paragraph to identify the vhost-user messages
involved.

> =20
>  In postcopy migration the back-end is started before all the memory has
>  been received from the source host, and care must be taken to avoid
> @@ -885,6 +890,7 @@ Protocol features
>    #define VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS  15
>    #define VHOST_USER_PROTOCOL_F_STATUS               16
>    #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
> +  #define VHOST_USER_PROTOCOL_F_SUSPEND              18
> =20
>  Front-end message types
>  -----------------------
> @@ -1440,6 +1446,31 @@ Front-end message types
>    query the back-end for its device status as defined in the Virtio
>    specification.
> =20
> +``VHOST_USER_SUSPEND``
> +  :id: 41
> +  :equivalent ioctl: VHOST_VDPA_SUSPEND
> +  :request payload: N/A
> +  :reply payload: N/A
> +
> +  When the ``VHOST_USER_PROTOCOL_F_SUSPEND`` protocol feature has been
> +  successfully negotiated, this message is submitted by the front-end to
> +  have the back-end cease all operations except for handling vhost-user
> +  requests.  The back-end must stop processing all virt queues, and it
> +  must not perform any background operations.  It may not resume until a

"background operations" are not defined. What does it mean:
- Anything that writes to memory slots
- Anything that changes the visible state of the device
- Anything that changes the non-visible internal state of the device
- etc
?

> +  subsequent ``VHOST_USER_RESUME`` call.
> +
> +``VHOST_USER_RESUME``
> +  :id: 42
> +  :equivalent ioctl: VHOST_VDPA_RESUME
> +  :request payload: N/A
> +  :reply payload: N/A
> +
> +  When the ``VHOST_USER_PROTOCOL_F_SUSPEND`` protocol feature has been
> +  successfully negotiated, this message is submitted by the front-end to
> +  allow the back-end to resume operations after having been suspended
> +  before.  The back-end must again begin processing rings that are not

This can be made more concrete by referencing the vhost-user message
used to suspend the device:

"suspended before" -> "suspended with VHOST_USER_SUSPEND"

> +  stopped, and it may resume background operations.
> +
> =20
>  Back-end message types
>  ----------------------
> --=20
> 2.41.0
>=20

--rmnj5HorlSCbRvKy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS2oPUACgkQnKSrs4Gr
c8hy7QgAgC9Zzp1AN62Im8q4aPploe14YANs2ZRw48s7WACHGJwgaT3bn+RGmZOV
JNZugkP6i+wVtffr8v3pTCKyWmJ0YG0mkOiKo53I9l/0LAXxGQkn1DpQiK+gS/ZC
CNmRvNnDf9RzqXI7uColzY/7uMeZsHyzEkLmnMXEAESytp/gPHDOIDwGXSuqAYNA
Q9GuvqvFd8Jukj4a4ihs+Ixxr2yzNC5WdfiiTvthWTdEyLhu/RKvklZYYlZRUNaX
3M+1YZeoGtuZY6SDpGvvJzcB/ri0YKNZJOVSvAItltl6HYsrRj6Ex1fk+rYtj5Un
gFoghtRPjSNKybeVyrXgGPlmybiqlA==
=ChLw
-----END PGP SIGNATURE-----

--rmnj5HorlSCbRvKy--


