Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0A27E390A
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:25:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0JDR-0001dv-HO; Tue, 07 Nov 2023 05:21:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0JDK-0001NF-TG
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:21:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0JDI-00051L-L0
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:21:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699352498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=POzexiMU4pchABeYEBsLQAk608F4wPOX/nyP3MWLe64=;
 b=V4SKV8KDHB0Vk7rAZ7u4pceHxPyyTuJAu+wJ0dwsN2rlm1bxX68cqMw/Z4j8XOJp3TXubJ
 6OhTNSw+j71iQlue7029oZxteKCZQZPfFIcZbe0OiAtnIzOZX2nbHix5t5am/V70i0c65N
 MCQ42f7H4SemPwW05d44LUQqP4FtlWg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-cuLp8B3cO7mPuKYxrzN6Wg-1; Tue, 07 Nov 2023 05:20:59 -0500
X-MC-Unique: cuLp8B3cO7mPuKYxrzN6Wg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51CC5101A53B;
 Tue,  7 Nov 2023 10:20:59 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A876BC1596F;
 Tue,  7 Nov 2023 10:20:57 +0000 (UTC)
Date: Tue, 7 Nov 2023 11:20:56 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michal Privoznik <mprivozn@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 0/2] virtio-blk: add iothread-vq-mapping parameter
Message-ID: <ZUoPiFxIIwFq5wMg@redhat.com>
References: <20230918161604.1400051-1-stefanha@redhat.com>
 <ZUOt7G+xdnLOBR5S@redhat.com> <20231107030049.GA949250@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PkZdFK0c9Wpc3JQJ"
Content-Disposition: inline
In-Reply-To: <20231107030049.GA949250@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


--PkZdFK0c9Wpc3JQJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 07.11.2023 um 04:00 hat Stefan Hajnoczi geschrieben:
> On Thu, Nov 02, 2023 at 03:10:52PM +0100, Kevin Wolf wrote:
> > Am 18.09.2023 um 18:16 hat Stefan Hajnoczi geschrieben:
> > > virtio-blk and virtio-scsi devices need a way to specify the mapping =
between
> > > IOThreads and virtqueues. At the moment all virtqueues are assigned t=
o a single
> > > IOThread or the main loop. This single thread can be a CPU bottleneck=
, so it is
> > > necessary to allow finer-grained assignment to spread the load. With =
this
> > > series applied, "pidstat -t 1" shows that guests with -smp 2 or highe=
r are able
> > > to exploit multiple IOThreads.
> > >=20
> > > This series introduces command-line syntax for the new iothread-vq-ma=
pping
> > > property is as follows:
> > >=20
> > >   --device '{"driver":"virtio-blk-pci","iothread-vq-mapping":[{"iothr=
ead":"iothread0","vqs":[0,1,2]},...]},...'
> > >=20
> > > IOThreads are specified by name and virtqueues are specified by 0-bas=
ed
> > > index.
> > >=20
> > > It will be common to simply assign virtqueues round-robin across a set
> > > of IOThreads. A convenient syntax that does not require specifying
> > > individual virtqueue indices is available:
> > >=20
> > >   --device '{"driver":"virtio-blk-pci","iothread-vq-mapping":[{"iothr=
ead":"iothread0"},{"iothread":"iothread1"},...]},...'
> > >=20
> > > There is no way to reassign virtqueues at runtime and I expect that t=
o be a
> > > very rare requirement.
> > >=20
> > > Note that JSON --device syntax is required for the iothread-vq-mapping
> > > parameter because it's non-scalar.
> > >=20
> > > Based-on: 20230912231037.826804-1-stefanha@redhat.com ("[PATCH v3 0/5=
] block-backend: process I/O in the current AioContext")
> >=20
> > Does this strictly depend on patch 5/5 of that series, or would it just
> > be a missed opportunity for optimisation by unnecessarily running some
> > requests from a different thread?
>=20
> "[PATCH v3 5/5] block-coroutine-wrapper: use
> qemu_get_current_aio_context()" is necessary so that
> virtio_blk_sect_range_ok -> blk_get_geometry -> blk_nb_sectors ->
> bdrv_refresh_total_sectors -> bdrv_poll_co can be called without holding
> the AioContext lock.

Ooh, so we only have the whole problem because bdrv_poll_co() wants to
temporarily unlock an AioContext that we don't even hold? That's a real
shame, but I understand now why we need the patch.

> That case only happens when the BlockDriverState is a file-posix host
> CD-ROM or a file-win32 host_device. Most users will never hit this
> problem, but it would be unsafe to proceed merging code without this
> patch.

Yes, I agree.

Kevin

--PkZdFK0c9Wpc3JQJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmVKD4gACgkQfwmycsiP
L9aM0BAAhu6EIRpbZhSy/jHlYveiggoygAeNwlHjs0yntEkGGaGc+aFi0i8lIV7a
0jAf+VVpaOlLhvlItFWKDu3wV56L6IIOl+65ZI621DHtks0ZSqJZIgd5SXG429NP
95D9UDNokZo2gOd+sCXOM6ygrpwa+y9hzBnlndDZ3aAq8lCTk6hAxJBZ2NBLikfP
Su9Rn6duFIdoUd3bHuI/dXhqkNdVoBVGeWxh4adTVbpfwY/sjd2Y7o0EP9WAIJs0
znrpZkOdvFvcgHK1/HxqrjFryEHeppNZRTc0heurzssScnh5FeZAfYi9tEiUHvEE
5PsnfVBW8o4eB9WnqYsUSF/nttyTJVs/lesIfYH7S3ktlk2PL+tbURr/LmK8fEt7
zTbJaJ3w6OeyIVL0OvyRhn4MrgrbqNx1fbD9G3pO4Wev/xhbYdSBh2mlxUwmF3As
CmUIA3ZsHk0P3nXILgaJKytBvdWoCloRU1XA3z+jNukpPjMOaJyS5VOu1rjN8IHR
CwKLVu9NXbw/IkrE3CDGtpK9ZBLU3EkpLpqkSxk0SQouDRay/l6Cij0eoUVNE7ql
kGhT6PMxJ5Sk95ilq17YRyBQKZsWS+sxDixYP+oV+MuoO6DQ7lQ9GWkaBIL9NxeE
0M873C7q2dS2x9zyIONwZFAhKJr1CKsMRW1bjAaupfx/DOC8Aj4=
=GnWE
-----END PGP SIGNATURE-----

--PkZdFK0c9Wpc3JQJ--


