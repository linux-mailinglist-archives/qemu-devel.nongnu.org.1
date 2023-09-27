Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E1C7B0D3B
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 22:20:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlb0O-0000bD-DU; Wed, 27 Sep 2023 16:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlb0M-0000b0-Ag
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 16:19:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlb0K-0004DD-NQ
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 16:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695845967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ittPGFfzqVAfLK393MXuxPafk4LXW/EPUgTiil1JfpE=;
 b=jGuXk4D7SgjaOUmTt+9GXorXidg94SCXV4Odb+abhr+5NG2Oo0D1YXWqIt8plyr7CKB6dE
 XMau0FZUBuTDHSMNy4+NvsVZHN0+tuNe65UsISynvrxq2nbvwtOsPXEMxVSIA9N2S1wqJI
 k0pw9r4cunHLJDtSr0MwvGcHNDpgti4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-g09oW9MTMlyI7qyjePj_mw-1; Wed, 27 Sep 2023 16:19:25 -0400
X-MC-Unique: g09oW9MTMlyI7qyjePj_mw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D641A280D584;
 Wed, 27 Sep 2023 20:19:24 +0000 (UTC)
Received: from localhost (unknown [10.39.193.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41012176C3;
 Wed, 27 Sep 2023 20:19:24 +0000 (UTC)
Date: Wed, 27 Sep 2023 16:19:22 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 "open list:virtiofs" <virtio-fs@redhat.com>,
 Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [Virtio-fs] [PATCH v3 0/5] vhost-user: Back-end state migration
Message-ID: <20230927201922.GB529043@fedora>
References: <20230915102531.55894-1-hreitz@redhat.com>
 <20230925204852.GG323580@fedora>
 <fc005d50-03ba-0b8f-d9af-64a5297395a3@redhat.com>
 <CAJSP0QWwo6rqwY7F-OZgXBnRCLbF4C=66zLf35Jy43jKHebjDw@mail.gmail.com>
 <CAJSP0QWC1VsAr6k745cumQ7zehEYWRqY_0+gdj9ZtNuwZDNtAQ@mail.gmail.com>
 <07282c72-7a83-70c5-395d-454281663eb1@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kjMssMK4IWHFEABh"
Content-Disposition: inline
In-Reply-To: <07282c72-7a83-70c5-395d-454281663eb1@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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


--kjMssMK4IWHFEABh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 10:32:14AM +0200, Hanna Czenczek wrote:
> On 26.09.23 22:10, Stefan Hajnoczi wrote:
> > Hi Hanna,
> > I was thinking about how this could work without SUSPEND/RESUME. What
> > do you think of the following?
> >=20
> > 1. The front-end sends VHOST_USER_RESET_DEVICE (or
> > VHOST_USER_RESET_OWNER, when necessary) when the guest driver resets
> > the device but not on vhost_dev_start()/vhost_dev_stop().
>=20
> This is half the work of SUSPEND/RESUME.=C2=A0 It isn=E2=80=99t easy to d=
o.

I sent a patch series to bring VHOST_USER_RESET_DEVICE to all vhost-user
devices:
https://lore.kernel.org/qemu-devel/20230927192737.528280-1-stefanha@redhat.=
com/T/#t

>=20
> > 2. Suspend the device when all virtqueues are stopped via
> > VHOST_USER_GET_VRING_BASE. Resume the device after at least one
> > virtqueue is started and enabled.
> > 3. Ignore VHOST_USER_SET_STATUS.
> >=20
> > Reset would work. The device would suspend and resume without losing
> > state. Existing vhost-user backends already behave like this in
> > practice (they often don't implement RESET_DEVICE).
>=20
> I don=E2=80=99t understand the point, though.=C2=A0 Today, reset in pract=
ice is a no-op
> anyway, precisely because we only send SET_STATUS 0, don=E2=80=99t fall b=
ack to
> RESET_OWNER/RESET_DEVICE, and no back-end implements SET_STATUS 0 as a
> reset.=C2=A0 By sending RESET_* in case of a guest-initiated reset and no=
thing in
> case of stop/cont, we effectively don=E2=80=99t change anything about the=
 latter
> (which is what SUSPEND/RESUME would be for), but only fix the former case=
=2E=C2=A0
> While I agree that it=E2=80=99s wrong that we don=E2=80=99t really reset =
the back-end in
> case of a guest-initiated reset, this is the first time in this whole
> discussion that that part has been presented as a problem that needs fixi=
ng
> now.
>=20
> So the proposal effectively changes nothing for the vhost_dev_stop()/star=
t()
> case where we=E2=80=99d want to make use of SUSPEND/RESUME, but only for =
the case
> where we would not use it.

We discussed this on a call today. 2 & 3 are additions to the spec that
Hanna has agreed to work on.

Stefan

--kjMssMK4IWHFEABh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUUjkoACgkQnKSrs4Gr
c8j1Rwf+P5HoMSLa9EGAF8upIl91VlYs2rf3f1VzRUdwl7cHM4kNim4Xs9uBnwad
DBPJhnzkf6597F91IAaZLPP8JmwKUxt38NtxwSjWM3CCLZd0Ace6NGfTO1qjTU1L
6i5Oib4k1F/4Jjzb868ureKyInfeIFeASRC1gUnlLMT5pKHbDcpO4oVm7HE7x2+i
xROTR/wXZ1pc6GZHUF2WlzdcqJ2HrbtMqpsjvi5JIK09+lwNjzopgscbw2Il4Fia
/W9wMyq8GyPtIf9elWgMzK3HkPyUyrWcSMC8ptnR318pgQnDnYLqSNbiryQplGo6
Gs6XdgB+CM21imIQTtqNJRovF3HeTA==
=VtOc
-----END PGP SIGNATURE-----

--kjMssMK4IWHFEABh--


