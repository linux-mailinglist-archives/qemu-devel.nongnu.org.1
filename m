Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2626C7AE072
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 22:50:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qksVr-0000qh-1w; Mon, 25 Sep 2023 16:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qksVn-0000qW-8j
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 16:48:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qksVl-0008Iq-Kg
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 16:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695674936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w0laCva8ewqaj8VSEUV8AI1AzlcgK+Ql7Aop35jA0eM=;
 b=Nt1WFXufA+Gbh3TqgEtebOf5m6m359WZVH83tdmxHXwBEH2gGH6eIxDjBEADWs74bMWIC/
 j423SjC7iwAd/xDDdaDAeHjDOxzD7lBIpARA3aA2DsYy/kNRZp0wHxCJive+gCLmt9mrbO
 BTvu9cyQO9nB7T73AhNGPCht0e3J5is=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-IilV92PfMvGBUsRFjvEzeg-1; Mon, 25 Sep 2023 16:48:54 -0400
X-MC-Unique: IilV92PfMvGBUsRFjvEzeg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13E3C3C0DF6A
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 20:48:54 +0000 (UTC)
Received: from localhost (unknown [10.39.194.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61470711286;
 Mon, 25 Sep 2023 20:48:53 +0000 (UTC)
Date: Mon, 25 Sep 2023 16:48:52 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 German Maglione <gmaglione@redhat.com>
Subject: Re: [PATCH v3 0/5] vhost-user: Back-end state migration
Message-ID: <20230925204852.GG323580@fedora>
References: <20230915102531.55894-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="K/zCvWGQCDPOsVDG"
Content-Disposition: inline
In-Reply-To: <20230915102531.55894-1-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--K/zCvWGQCDPOsVDG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 12:25:25PM +0200, Hanna Czenczek wrote:
> RFC:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-03/msg04263.html
>=20
> v1:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg01575.html
>=20
> v2:
> https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg02604.html
>=20
> Hi,
>=20
> I=E2=80=99ve decided not to work on vhost-user SUSPEND/RESUME for now =E2=
=80=93 it is
> not technically required for virtio-fs migration, which is the actual
> priority for me now.  While we do want to have SUSPEND/RESUME at some
> point, the only practically existing reason for it is to be able to
> implement vhost-level resetting in virtiofsd, but that is not related to
> migration.

QEMU sends VHOST_USER_SET_STATUS 0 in vhost_dev_stop(). Are you assuming
that virtiofs back-ends do not reset the device upon receiving this
message?

> So one of the changes in v3 is that it no longer depends on the
> vhost-user SUSPEND/RESUME series, and describes the migration protocol
> without the device being suspended at any point, but merely that the
> vrings are stopped.
>=20
> Other changes include:
>=20
> - Patch 1:
>   - Rephrased a lot
>   - Added a description for the VHOST_USER_SET_DEVICE_STATE_FD
>     parameters
>   - Renamed VHOST_USER_PROTOCOL_F_MIGRATORY_STATE to
>     VHOST_USER_PROTOCOL_F_DEVICE_STATE
>   - enum variants changed in value due to dropping the SUSPEND/RESUME
>     dependency
>=20
> - Patch 2:
>   - Pulled in, was a stand-alone patch before
>   - Dropped a sentence about ring state before feature negotiations, as
>     the rings are not to be used during that period anyway
>   - Bit of rephrasing
>=20
> - Patch 3:
>   - Renamed =E2=80=9Cmigratory state=E2=80=9D to =E2=80=9Cdevice state=E2=
=80=9D
>   - enum variants changed in value due to dropping the SUSPEND/RESUME
>     dependency
>=20
> - Patch 4:
>   - Changed `f` to @f (referencing parameter =E2=80=9Cf=E2=80=9D) in comm=
ents
>   - Use g_autofree for the transfer buffer
>   - Note SUSPEND state as a future feature, not currently existing
>   - Wrap read() and write() in RETRY_ON_EINTR()
>=20
> - Patch 5:
>   - Renamed =E2=80=9Cmigratory state=E2=80=9D to =E2=80=9Cdevice state=E2=
=80=9D
>   - (kept R-b still)
>=20
>=20
> Hanna Czenczek (5):
>   vhost-user.rst: Migrating back-end-internal state
>   vhost-user.rst: Clarify enabling/disabling vrings
>   vhost-user: Interface for migration state transfer
>   vhost: Add high-level state save/load functions
>   vhost-user-fs: Implement internal migration
>=20
>  docs/interop/vhost-user.rst       | 188 ++++++++++++++++++++++-
>  include/hw/virtio/vhost-backend.h |  24 +++
>  include/hw/virtio/vhost.h         | 114 ++++++++++++++
>  hw/virtio/vhost-user-fs.c         | 101 ++++++++++++-
>  hw/virtio/vhost-user.c            | 148 ++++++++++++++++++
>  hw/virtio/vhost.c                 | 241 ++++++++++++++++++++++++++++++
>  6 files changed, 810 insertions(+), 6 deletions(-)
>=20
> --=20
> 2.41.0
>=20

--K/zCvWGQCDPOsVDG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUR8jMACgkQnKSrs4Gr
c8jKKwf8C5etjvYMEZYDYIJGeOPOVSRiR04zFVZS+/VEolLYYRW0lUzWinu1wjhF
PuPo+jaMNKTbuj/MAFiAhx6agRzKu/M57M1kQxjECSWHYYkKD0CkEz3xOQe0hvVu
hP3MDse57FlX3whkKNnUSE1aTBcwj4l7pMXLljUpM+UwkzjqlnbZq8DI7XdUe2jG
sTp9hYhA0h03V4ACXjd9Ov90QZWWRoOB1BvAawe4PClVdgaQQWM6DiPAsi8ELH6T
9Vyo403dpuek4UvySNWLe7yBDlCT0wv48oXo2NNttzHcJ3G2TfxiFQFma3KlX0Od
nlW5mEYBk8qwOgxXKjQU+dFjvRxKKg==
=qDLO
-----END PGP SIGNATURE-----

--K/zCvWGQCDPOsVDG--


