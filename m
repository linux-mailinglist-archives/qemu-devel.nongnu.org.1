Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE45757FAB
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 16:34:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLll6-0003sf-3X; Tue, 18 Jul 2023 10:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLll3-0003s9-FG
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 10:32:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLlky-0006ir-V2
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 10:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689690771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sMmkrqtAG49R58078HI15DQCFDC0h0DjezWU9bHHeHk=;
 b=Qky6bPxJa8bEU9SCxMI6rVOrrH7FI/lHdUmB2ORuCKBXY7B2Xymtwt/EtOEKMu/NgHV7K4
 n8vmWpFmHcDixqVXUgqam6GAWGTu0yYtt+WWxhjZgofWhfG0U0Gf7/B2nuO3DsaXlXjRTl
 mGtx30AInBhokNbRgGd7RR6DBrkgueM=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-3jHaSZQeN3e_Fw2JyiYLpg-1; Tue, 18 Jul 2023 10:32:49 -0400
X-MC-Unique: 3jHaSZQeN3e_Fw2JyiYLpg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F0DA1C2E8FD
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 14:29:07 +0000 (UTC)
Received: from localhost (unknown [10.39.193.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 08C9BF6CD8;
 Tue, 18 Jul 2023 14:29:06 +0000 (UTC)
Date: Tue, 18 Jul 2023 10:29:05 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH 2/6] vhost-vdpa: Move vhost_vdpa_reset_status() up
Message-ID: <20230718142905.GC44841@fedora>
References: <20230711155230.64277-1-hreitz@redhat.com>
 <20230711155230.64277-3-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9A/Kaei/Pt4pxnRo"
Content-Disposition: inline
In-Reply-To: <20230711155230.64277-3-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


--9A/Kaei/Pt4pxnRo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 05:52:24PM +0200, Hanna Czenczek wrote:
> The next commit is going to have vhost_vdpa_dev_start() call this, so
> move it up to have the declaration where we are going to need it.
>=20
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  hw/virtio/vhost-vdpa.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--9A/Kaei/Pt4pxnRo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS2obAACgkQnKSrs4Gr
c8jqzwf9HKX0mFgPsHtqB9L5C20s9hIGnXavLjxzo5oEBYFywASS7x5f4T3id65S
HIpbLXyVykiuBp9zLTk/MY0qEbw16xHMQI4nMoj/YUHbI3rwnbr6Ekmv0cIzyYtC
l0bMuqghPDXpvS854eKQXpZgQ0K5zDI11KBomqy5wa5zRHCNMhZMKoNWFL7YGWh5
hkWsmIvnvpGdsOeDLg8flMynt1BuyQhXMVcPWb1I+9GbEYcZp3d4/WPhERhNjtKO
kBFEOLNx+fFeoexHYF2JhGpg9KkoANv03IxmBAQB6hXiuw8IMemnEzmoLuSQ3Lxa
hHXjuZ3kXwOPjNQG45pBldbNq2Vhqg==
=jLuu
-----END PGP SIGNATURE-----

--9A/Kaei/Pt4pxnRo--


