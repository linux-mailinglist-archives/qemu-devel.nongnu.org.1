Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C59C758026
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 16:53:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLm40-0004X5-EQ; Tue, 18 Jul 2023 10:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLm3n-0004Bf-EX
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 10:52:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLm3j-0003Dq-Qx
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 10:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689691934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zTlBhr+8Ng+14aKxIwNLfSwobolMSLxYNxJbkPslmTg=;
 b=SiY1dlFmfLigdtyuZQfutsfQpJmmF1qZmLMq4nTPbzG+AP6u+8OmZSG8Za+ffxOPK3cUka
 uL/825i9gUh0pkz42H/aR2Zt3jqmJc3JCyu5fbhVy85ebFEORXssRIXcqh4rusDcvHBCcA
 /pqX5WeEU4dd7LLFe+0G+hxQeMEhysc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-4_y2x9-ZOyO3zudwGY18-w-1; Tue, 18 Jul 2023 10:52:02 -0400
X-MC-Unique: 4_y2x9-ZOyO3zudwGY18-w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAFAE8841EE
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 14:50:34 +0000 (UTC)
Received: from localhost (unknown [10.39.193.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DBD6200C0C4;
 Tue, 18 Jul 2023 14:50:34 +0000 (UTC)
Date: Tue, 18 Jul 2023 10:50:32 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH 5/6] vhost-vdpa: Match vhost-user's status reset
Message-ID: <20230718145032.GF44841@fedora>
References: <20230711155230.64277-1-hreitz@redhat.com>
 <20230711155230.64277-6-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WeZ/fg98F6VpU2X7"
Content-Disposition: inline
In-Reply-To: <20230711155230.64277-6-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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


--WeZ/fg98F6VpU2X7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 05:52:27PM +0200, Hanna Czenczek wrote:
> vhost-vdpa and vhost-user differ in how they reset the status in their
> respective vhost_reset_status implementations: vhost-vdpa zeroes it,
> then re-adds the S_ACKNOWLEDGE and S_DRIVER config bits.  S_DRIVER_OK is
> then set in vhost_vdpa_dev_start().
>=20
> vhost-user in contrast just zeroes the status, and does no re-add any
> config bits until vhost_user_dev_start() (where it does re-add all of
> S_ACKNOWLEDGE, S_DRIVER, and S_DRIVER_OK).
>=20
> There is no documentation for vhost_reset_status, but its only caller is
> vhost_dev_stop().  So apparently, the device is to be stopped after
> vhost_reset_status, and therefore it makes more sense to keep the status
> field fully cleared until the back-end is re-started, which is how
> vhost-user does it.  Make vhost-vdpa do the same -- if nothing else it's
> confusing to have both vhost implementations handle this differently.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  hw/virtio/vhost-vdpa.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Hi Hanna,
The VIRTIO spec lists the Device Initialization sequence including the
bits set in the Device Status Register here:
https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html=
#x1-1070001

ACKNOWLEDGE and DRIVER must be set before FEATURES_OK. DRIVER_OK is set
after FEATURES_OK.

The driver may read the Device Configuration Space once ACKNOWLEDGE and
DRIVER are set.

QEMU's vhost code should follow this sequence (especially for vDPA where
full VIRTIO devices are implemented).

vhost-user is not faithful to the VIRTIO spec here. That's probably due
to the fact that vhost-user didn't have the concept of the Device Status
Register until recently and back-ends mostly ignore it.

Please do the opposite of this patch: bring vhost-user in line with the
VIRTIO specification so that the Device Initialization sequence is
followed correctly. I think vhost-vdpa already does the right thing.

>=20
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index f7fd19a203..0cde8b40de 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -1294,8 +1294,6 @@ static void vhost_vdpa_reset_status(struct vhost_de=
v *dev)
>      }
> =20
>      vhost_vdpa_reset_device(dev);
> -    vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
> -                               VIRTIO_CONFIG_S_DRIVER);
>      memory_listener_unregister(&v->listener);
>  }
> =20
> @@ -1334,7 +1332,9 @@ static int vhost_vdpa_dev_start(struct vhost_dev *d=
ev, bool started)
>          }
>          memory_listener_register(&v->listener, dev->vdev->dma_as);
> =20
> -        return vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_DRIVER_OK);
> +        return vhost_vdpa_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE |
> +                                          VIRTIO_CONFIG_S_DRIVER |
> +                                          VIRTIO_CONFIG_S_DRIVER_OK);
>      }
> =20
>      return 0;
> --=20
> 2.41.0
>=20

--WeZ/fg98F6VpU2X7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS2prgACgkQnKSrs4Gr
c8jBpQf+KHwajXMz3c/s6KoubKnOG4UPnvKD1Z+yu9qyTau149Mcg0wAfGFMHRSw
vxruiOkmZLRC7RaXv47Ozjq1qSJSc9DrFeyK19TV3YedvCBk+5z4S1vBMAJjSu+D
+0Hn35sLOldMrffpTQp8yvKtS1J8JCNaJ1ISvLm88nuqt3o8XtF9IghL3T+IfErb
p1WytvdCBJCjCJu1e8fOb0jRlUUjdDWTPrBq5c5AwTVqhT7G1bgE7d8u24Lp05qD
xme+rMpbaoq5Scf5SES+rZ4RtXPg/QTGJWG5a8Uek81N9pVyHApkSraPjbKvQ+qa
npHSKdYkYj9QIEYDcSRbyO/RY7ijsA==
=MENE
-----END PGP SIGNATURE-----

--WeZ/fg98F6VpU2X7--


