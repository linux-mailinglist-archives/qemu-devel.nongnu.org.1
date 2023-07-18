Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1A57580A6
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 17:18:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLmSm-0004g7-76; Tue, 18 Jul 2023 11:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLmSj-0004bz-EC
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 11:18:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qLmSf-000128-Ln
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 11:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689693479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P1ZaxOJAiFonTispBCrZs3LM5Qz+lXnYBw2D8pj3NPQ=;
 b=Tbd6I2+od0BeztiQHL5TCZzip+ZOLOkNPNFoRXDOvhZ7ErcyMqhnxhR//XH6HkQPGjjjyh
 A504Xuf6Qda3MMuV/5XDzAnzLl1ld8KrvQ10Bx4YAAY6jJW3GX6Ne7pj3OlXQqNBbMNlvv
 pP64Z7TrmabEvCWtFHDY2WA8S5TY3GM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-srnbRJtdOEy_GhPXh_OjqA-1; Tue, 18 Jul 2023 11:17:43 -0400
X-MC-Unique: srnbRJtdOEy_GhPXh_OjqA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A79C18AE949
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 15:14:15 +0000 (UTC)
Received: from localhost (unknown [10.39.193.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA9BD492B01;
 Tue, 18 Jul 2023 15:14:14 +0000 (UTC)
Date: Tue, 18 Jul 2023 11:14:13 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH 0/6] vhost-user: Add suspend/resume
Message-ID: <20230718151413.GH44841@fedora>
References: <20230711155230.64277-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zEHI1VGc+YYOXpnI"
Content-Disposition: inline
In-Reply-To: <20230711155230.64277-1-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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


--zEHI1VGc+YYOXpnI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 05:52:22PM +0200, Hanna Czenczek wrote:
> Hi,
>=20
> As discussed on the previous version of the virtio-fs migration series
> (https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg01575.html),
> we currently don=E2=80=99t have a good way to have a vhost-user back-end =
fully
> cease all operations, including background operations.  To work around
> this, we reset it, which is not an option for stateful devices like
> virtio-fs.
>=20
> Instead, we want the same SUSPEND/RESUME model that vhost-vdpa already
> has, so that we can suspend back-ends when we want them to stop doing
> anything (i.e. on VM stop), and resume them later (i.e. on VM resume).
> This series adds these vhost-user operations to the protocol and
> implements them in qemu.  Furthermore, it has vhost-user and vhost-vdpa
> do roughly the same thing in their reset paths, as far as possible.
> That path will still remain as a fall-back if SUSPEND/RESUME is not
> implemented, and, given that qemu=E2=80=99s vhost-vdpa code currently doe=
s not
> make use of RESUME, it is actually always used for vhost-vdpa (to take
> the device out of a suspended state).
>=20
>=20
> Hanna Czenczek (6):
>   vhost-user.rst: Add suspend/resume
>   vhost-vdpa: Move vhost_vdpa_reset_status() up
>   vhost: Do not reset suspended devices on stop
>   vhost-user: Implement suspend/resume
>   vhost-vdpa: Match vhost-user's status reset
>   vhost-user: Have reset_status fall back to reset
>=20
>  docs/interop/vhost-user.rst    |  35 +++++++++++-
>  include/hw/virtio/vhost-vdpa.h |   2 -
>  include/hw/virtio/vhost.h      |   8 +++
>  hw/virtio/vhost-user.c         | 101 ++++++++++++++++++++++++++++++++-
>  hw/virtio/vhost-vdpa.c         |  41 ++++++-------
>  hw/virtio/vhost.c              |   8 ++-
>  6 files changed, 169 insertions(+), 26 deletions(-)

Hi Hanna,
I posted comments but wanted to say great job! There was a long and
somewhat messy email discussion to figure out how to proceed and you
came up with a clean patch series that solves the issues.

Stefan

--zEHI1VGc+YYOXpnI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmS2rEQACgkQnKSrs4Gr
c8gXlgf/U3anExBxDOb5fWryK8O0ulRLz7Lm1yjXuAES3Lr7COvxyEeTU3q87Q8+
2tSuZJTycegOciCAsyEVRYYvoS2/pHPZA0LzPQhONTm4Qu6fA6mlfBPXE4ZfdvHr
gfLIJwG93GTGkLB6j89TtTYINExlX6tpzTe6nMPshufk9MKMbyJporck6l6o1tKx
vNellCmJe9Tvc3akmD+GvSErMzE0SEMhaUppvIyftCFSLjWp1KYy4G0EXbrHfhCx
jN7r6cWR1osQRd9bTvJpnh5mQfVh/Sspllq46KpoSIUUOkzhZ6f0g9q19kdqoFM8
aFwjSCEuAFLkCHRBO3bCjb17umTLfw==
=6Z5q
-----END PGP SIGNATURE-----

--zEHI1VGc+YYOXpnI--


