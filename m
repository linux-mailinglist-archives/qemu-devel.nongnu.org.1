Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AF87BA86C
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 19:48:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoSSS-0000VK-PI; Thu, 05 Oct 2023 13:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoSSQ-0000Us-N4
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 13:48:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qoSSO-0005qH-E6
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 13:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696528095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ECP7IDOEDTjkevFHFfuJxtdaOfQHpXJehiYmyPZnBdM=;
 b=dh69TEpALVSHh+hX0kumad07CYCh0hGB/e5saDQwrxeL6jc5WlxX8R9Xg6xAFFb26V0PcK
 z4hHFEpM5ehUdvjjaaGsw1cC67W6+XDf9cKIQUansMBfG4e71bpG9X0NLC1bKZOYWXRARL
 1LLRB4rlLl7CDiSRJ4Ym+nV+FNuZzQo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-WNZz_MqgNGaZ2RRm59UHdw-1; Thu, 05 Oct 2023 13:48:13 -0400
X-MC-Unique: WNZz_MqgNGaZ2RRm59UHdw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 139122810D51;
 Thu,  5 Oct 2023 17:48:13 +0000 (UTC)
Received: from localhost (unknown [10.39.192.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 80F4A10F1BE7;
 Thu,  5 Oct 2023 17:48:12 +0000 (UTC)
Date: Thu, 5 Oct 2023 13:48:11 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 German Maglione <gmaglione@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>
Subject: Re: [PATCH v4 0/8] vhost-user: Back-end state migration
Message-ID: <20231005174811.GJ1342722@fedora>
References: <20231004125904.110781-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mNw8fgYOgCi8R7Nz"
Content-Disposition: inline
In-Reply-To: <20231004125904.110781-1-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--mNw8fgYOgCi8R7Nz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2023 at 02:58:56PM +0200, Hanna Czenczek wrote:
> RFC:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-03/msg04263.html
>=20
> v1:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg01575.html
>=20
> v2:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg02604.html
>=20
> v3:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-09/msg03750.html
>=20
>=20
> Based-on: <20231004014532.1228637-1-stefanha@redhat.com>
>           ([PATCH v2 0/3] vhost: clean up device reset)
>=20
>=20
> Hi,
>=20
> This v4 includes largely unchanged patches from v3.  The main
> addition/change is what came out of the discussion between Stefan and me
> around how to proceed without SUSPEND/RESUME, which is that this series
> is now based on his reset fix, and it includes more documentation
> changes.

This looks good. I posted some minor comments on the new patches.

Stefan

>=20
> Changes in detail:
>=20
> - Patch 1: Fall-out from the reset fix: Currently, the status byte is
>   effectively unused (qemu only uses it for resetting, which all
>   back-ends ignore; DPDK uses it to announce potential feature
>   negotiation failure, which qemu ignores).  It is also not defined what
>   exactly front-end or back-end should do with this byte, except
>   pointing at the virtio spec, which however naturally does not say how
>   this integrates with vhost-user=E2=80=99s RESET_DEVICE or [GS]ET_FEATUR=
ES.
>   Furthermore, there does not seem to be a use for this; we have
>   RESET_DEVICE for resetting, and we have [GS]ET_FEATURES (and
>   REPLY_ACK, which can be used on SET_FEATURES) for feature
>   negotation.
>   Therefore, deprecate the status byte, pointing to those other commands
>   instead.
>=20
> - Patch 2: Patch 4 defines a suspended state for the whole back-end if
>   all vrings are stopped.  I think this should be mentioned in
>   GET_VRING_BASE, but upon trying to add it, I found that it does not
>   even mention that it stops the vring (mentioned only in the Ring
>   States section), and remembered that the whole description of both
>   GET_VRING_BASE and SET_VRING_BASE really was not helpful when trying
>   to implement a vhost-user back-end.  Took the opportunity to overhaul
>   both.
>=20
> - Patch 3: This one=E2=80=99s from v3, but quite heavily modified.  Stefan
>   suggested consistently defining the started/stopped and
>   enabled/disabled states to be independent, and indeed doing so
>   simplifies a whole lot of stuff.  Specifically, it makes the magic
>   =E2=80=9Cenabled/disabled when started=E2=80=9D go away.  Basically, I =
found this
>   change alone is enough to remove the confusion I had with the existing
>   documentation.
>=20
> - Patch 4: As suggested by Stefan, just define a suspended state without
>   introducing SUSPEND.  vDPA needs SUSPEND because its GET_VRING_BASE
>   does not stop the vring, but vhost-user=E2=80=99s does, so we can defin=
e the
>   suspended state to be when all vrings are stopped.
>=20
> - Patch 5: Reference the suspended state.
>=20
> - Patches 6 through 8: Unmodified, except for them being rebase on
>   Stefan=E2=80=99s series.
>=20
>=20
> Hanna Czenczek (8):
>   vhost-user.rst: Deprecate [GS]ET_STATUS
>   vhost-user.rst: Improve [GS]ET_VRING_BASE doc
>   vhost-user.rst: Clarify enabling/disabling vrings
>   vhost-user.rst: Introduce suspended state
>   vhost-user.rst: Migrating back-end-internal state
>   vhost-user: Interface for migration state transfer
>   vhost: Add high-level state save/load functions
>   vhost-user-fs: Implement internal migration
>=20
>  docs/interop/vhost-user.rst       | 318 +++++++++++++++++++++++++++---
>  include/hw/virtio/vhost-backend.h |  24 +++
>  include/hw/virtio/vhost.h         | 113 +++++++++++
>  hw/virtio/vhost-user-fs.c         | 101 +++++++++-
>  hw/virtio/vhost-user.c            | 148 ++++++++++++++
>  hw/virtio/vhost.c                 | 241 ++++++++++++++++++++++
>  6 files changed, 917 insertions(+), 28 deletions(-)
>=20
> --=20
> 2.41.0
>=20

--mNw8fgYOgCi8R7Nz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUe9tsACgkQnKSrs4Gr
c8iA0QgAgmWhPPx/hRn39Jsq3bGeI2mdhbYZbtTE18k2ZdrspkyKPMB45nc8Rj2t
zWn/ifLC1tV2UhXYj494uHD4ACPCRv/4KqX16Su1TS3ARcOZcchc9rxmFDN+RrIl
faoh+ybFvmDBFFjmbhP4mf/eQeWRttfWEYz9y2TJTOQKMEbpYy/c3PFX8FQrHaz6
+xXW2UvjQ1S2A1zM7XSLWCiAIYO7cVtu5LNFmCkrUAh0fDzui891BteZZaVpYrqB
3Kdee9cnFLhR4+KZRXTkmH7Q1VHZoJRxWhcyLURlx/9YZ5bkx/1wLUQYo8+m12Qm
iuKHpsTjElpLmFqGG00n1C9uoOYEUQ==
=TZJp
-----END PGP SIGNATURE-----

--mNw8fgYOgCi8R7Nz--


