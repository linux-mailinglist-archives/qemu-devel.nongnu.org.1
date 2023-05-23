Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA4D70E67B
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 22:31:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Yf1-0004Un-Gu; Tue, 23 May 2023 16:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q1Yez-0004RS-Ef
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:31:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q1Yet-0004VS-GC
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684873861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ScQpXDGmDuNPEYEgXrBHD5hIopzkxgtXKDLtTaHTnZY=;
 b=BFUL6J0jD51iypI2oUapaGJe3maj/lfZlv1cNjG1qysy2cZrEXDa4Z4rtZGCW7oC+8pr8S
 +MDukrkhJdNoRewbFyvimESWCMTG66q5CvXpwO6wWpwHi6V37hyGwV1Jx0k9BJ62sJWhmJ
 GJCZdSOcP0WrJEimw77t8L13jvjNxlU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-1i1BgM7TOd6JcFxAweFzSQ-1; Tue, 23 May 2023 16:30:59 -0400
X-MC-Unique: 1i1BgM7TOd6JcFxAweFzSQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01AB9101A52C;
 Tue, 23 May 2023 20:30:58 +0000 (UTC)
Received: from localhost (unknown [10.39.192.61])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06BAC2166B25;
 Tue, 23 May 2023 20:30:51 +0000 (UTC)
Date: Tue, 23 May 2023 16:30:50 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Markus Armbruster <armbru@redhat.com>,
 Erik Schilling <erik.schilling@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, virtio-fs@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 01/13] include: attempt to document
 device_class_set_props
Message-ID: <20230523203050.GA140337@fedora>
References: <20230418162140.373219-1-alex.bennee@linaro.org>
 <20230418162140.373219-2-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PC9Bjrkp6WHWj9an"
Content-Disposition: inline
In-Reply-To: <20230418162140.373219-2-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--PC9Bjrkp6WHWj9an
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2023 at 05:21:28PM +0100, Alex Benn=E9e wrote:
> I'm still not sure how I achieve by use case of the parent class
> defining the following properties:
>=20
>   static Property vud_properties[] =3D {
>       DEFINE_PROP_CHR("chardev", VHostUserDevice, chardev),
>       DEFINE_PROP_UINT16("id", VHostUserDevice, id, 0),
>       DEFINE_PROP_UINT32("num_vqs", VHostUserDevice, num_vqs, 1),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>=20
> But for the specialisation of the class I want the id to default to
> the actual device id, e.g.:
>=20
>   static Property vu_rng_properties[] =3D {
>       DEFINE_PROP_UINT16("id", VHostUserDevice, id, VIRTIO_ID_RNG),
>       DEFINE_PROP_UINT32("num_vqs", VHostUserDevice, num_vqs, 1),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>=20
> And so far the API for doing that isn't super clear.

Does this mean this patch is an RFC and this patch is not intended to be
merged?

>=20
> Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> ---
>  include/hw/qdev-core.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index bd50ad5ee1..d4bbc30c92 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -776,6 +776,15 @@ BusState *sysbus_get_default(void);
>  char *qdev_get_fw_dev_path(DeviceState *dev);
>  char *qdev_get_own_fw_dev_path_from_handler(BusState *bus, DeviceState *=
dev);
> =20
> +/**
> + * device_class_set_props(): add a set of properties to an device
> + * @dc: the parent DeviceClass all devices inherit
> + * @props: an array of properties, terminate by DEFINE_PROP_END_OF_LIST()
> + *
> + * This will add a set of properties to the object. It will fault if
> + * you attempt to add an existing property defined by a parent class.
> + * To modify an inherited property you need to use????
> + */
>  void device_class_set_props(DeviceClass *dc, Property *props);

I don't know the answer. There doesn't seem to be a way for child
classes to override parent DeviceClass properties. The assumption is the
sets of properties are disjoint (no property name collisions).

Here is a workaround in the vhost-user-rng code:

  /* Set our default if the user didn't specify the id */
  if (vud->id =3D=3D 0) {
      vud->id =3D VIRTIO_ID_RNG;
  }

This could be a problem because the value 0 may be valid and there is no
way to distinguish between a user setting 0 and the default 0 value.

Stefan

--PC9Bjrkp6WHWj9an
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRtInkACgkQnKSrs4Gr
c8ideAf/fY7NwL741baRcg8dmKRgnkLPgbeN77W6nL0T1wZOsClqaLyL5W8/O7ay
07mljSqgRitIoelleLtXDwqm7W3g6iaJoR9fa/SV4Hy5IbdZ/bwg3oZh7wHdQJer
fAkklvVfo62j2aAs6fwPCWVW5cTv/QqbpdxNs8wWkBWTG1yaJ8l3EvJHCeAQdJIY
xh5dM7yNszqqzRt71xfrYOG8AykBMhcRpQJjEl5QMRVhmJiAtdNXjr/KXkiecYCH
ijfzs45RliLTF5sWlMZlFrnPrfs4B7PXcy9IysOgyAJeKekUgCSu+GwWgBc85vLy
lzFkKNbhv+7Nv9Kl/UXA8pdtVL8JGA==
=/Ufy
-----END PGP SIGNATURE-----

--PC9Bjrkp6WHWj9an--


