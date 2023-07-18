Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 589F77580A2
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 17:18:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLmQv-0003Or-Uy; Tue, 18 Jul 2023 11:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLmQr-0003Iq-Ov
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 11:16:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLmQo-0000ZG-OL
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 11:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689693360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LcZn1aX9FLb58ICXJRY0Q6fMZQWiv8Dp9jTnFrGKQEY=;
 b=E+CINYe7AABeRVaRNgYznaEPr26mL5TTxXToHRKtwvNcDc/QNlAQlGUxPTzaWkyZJl2924
 0BLxdCAxhtfeHB8MFFw9N8ZNLPYUwluVX1GKObeyBdbW9+G8RsWdzgLayu+Q4419y3zDtY
 9AhJN2m9d6ERxfyg2mnpRARXVjpzQCM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-M2QRy1AZNpmI1yAd-gXj8A-1; Tue, 18 Jul 2023 11:15:55 -0400
X-MC-Unique: M2QRy1AZNpmI1yAd-gXj8A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66E9B1C10537
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 15:10:47 +0000 (UTC)
Received: from localhost (unknown [10.39.193.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10F0C4CD0F5;
 Tue, 18 Jul 2023 15:10:45 +0000 (UTC)
Date: Tue, 18 Jul 2023 11:10:44 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH 6/6] vhost-user: Have reset_status fall back to reset
Message-ID: <20230718151044.GG44841@fedora>
References: <20230711155230.64277-1-hreitz@redhat.com>
 <20230711155230.64277-7-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PGilvqKRvm2B9Ajf"
Content-Disposition: inline
In-Reply-To: <20230711155230.64277-7-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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


--PGilvqKRvm2B9Ajf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 05:52:28PM +0200, Hanna Czenczek wrote:
> The only user of vhost_user_reset_status() is vhost_dev_stop(), which
> only uses it as a fall-back to stop the back-end if it does not support
> SUSPEND.  However, vhost-user's implementation is a no-op unless the
> back-end supports SET_STATUS.
>=20
> vhost-vdpa's implementation instead just calls
> vhost_vdpa_reset_device(), implying that it's OK to fully reset the
> device if SET_STATUS is not supported.
>=20
> To be fair, vhost_vdpa_reset_device() does nothing but to set the status
> to zero.  However, that may well be because vhost-vdpa has no method
> besides this to reset a device.  In contrast, vhost-user has
> RESET_DEVICE and a RESET_OWNER, which can be used instead.
>=20
> While it is not entirely clear from documentation or git logs, from
> discussions and the order of vhost-user protocol features, it appears to
> me as if RESET_OWNER originally had no real meaning for vhost-user, and
> was thus used to signal a device reset to the back-end.  Then,
> RESET_DEVICE was introduced, to have a well-defined dedicated reset
> command.  Finally, vhost-user received full STATUS support, including
> SET_STATUS, so setting the device status to 0 is now the preferred way
> of resetting a device.  Still, RESET_DEVICE and RESET_OWNER should
> remain valid as fall-backs.
>=20
> Therefore, have vhost_user_reset_status() fall back to
> vhost_user_reset_device() if the back-end has no STATUS support.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  hw/virtio/vhost-user.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 4507de5a92..53a881ec2a 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -2833,6 +2833,8 @@ static void vhost_user_reset_status(struct vhost_de=
v *dev)
>      if (virtio_has_feature(dev->protocol_features,
>                             VHOST_USER_PROTOCOL_F_STATUS)) {
>          vhost_user_set_status(dev, 0);
> +    } else {
> +        vhost_user_reset_device(dev);
>      }
>  }

Did you check whether DPDK treats setting the status to 0 as equivalent
to RESET_DEVICE?

My understanding is that SET_STATUS is mostly ignored by vhost-user
back-ends today. Even those that implement it may not treat SET_STATUS 0
as equivalent to RESET_DEVICE.

If you decide it's safe to make this change, please also update
vhost-user.rst to document that front-ends should use SET_STATUS 0,
RESET_DEVICE, and RESET_OWNER in order of preference.

Stefan

--PGilvqKRvm2B9Ajf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS2q3QACgkQnKSrs4Gr
c8hJFwgAts217Nni751XUTjdzSjPeO4byH7GvnpYuXltZU4Bs6i8vBpbF0ziPj6b
BIlCqO5+2ThWmSvLGW4DjCKfQ9+xm+Vlg3IpeTE767sSTng50A3WEVOMwRZAd810
Os5cPNeKyOPFuBIrcrQKZuIo6duIymFjzip2yJWmRI7ypOq9c8wg5L4Zq9gYodne
NI5YWOdaCy9AiYInnFnuLg9x3LmLHRv8+MzfMvIjrReuoF+TgRDNgKTJN143UUeL
D9pw2s6G2TUN0lhMAwraneA6T0IZP+i6YH5k9dBLVAS/WfqguD2IFBnYgAskuqZt
wrCm7/sXfH0hBS6iCIBTMIEJS6wzKQ==
=AAEw
-----END PGP SIGNATURE-----

--PGilvqKRvm2B9Ajf--


