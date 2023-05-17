Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1C9706B20
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 16:31:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzIAi-0002os-NP; Wed, 17 May 2023 10:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pzIAh-0002ok-9c
 for qemu-devel@nongnu.org; Wed, 17 May 2023 10:30:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pzIAf-0006xu-KC
 for qemu-devel@nongnu.org; Wed, 17 May 2023 10:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684333828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h/JSvZBTwYXFdQqosJsgiQJQOSj/T82ZMrZ7yTs7uXM=;
 b=eLQvLce69T4Tw+Bp+g1HOnKcCOG2+k1f4/BqzBdSUFiQ7evrEnvWtJJvoKnu/bT7McnSXS
 UOL3KjcFLo+PRhh6Npixx349MNJEoUjMAklRT8/l4JjUPRfzM/v4RB1wduwAbTYSe9V4Im
 gV6Y+3FmkyYkLqyOIRil6kbP+5QGEpc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-SdCi8hbYM12F-nMUJ_5Qaw-1; Wed, 17 May 2023 10:30:27 -0400
X-MC-Unique: SdCi8hbYM12F-nMUJ_5Qaw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9E5823C0F384;
 Wed, 17 May 2023 14:30:26 +0000 (UTC)
Received: from localhost (unknown [10.39.195.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B8224078908;
 Wed, 17 May 2023 14:30:25 +0000 (UTC)
Date: Wed, 17 May 2023 10:30:23 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Jonathon Jongsma <jjongsma@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, sgarzare@redhat.com
Subject: Re: [PATCH v3 1/1] block/blkio: use qemu_open() to support fd
 passing for virtio-blk
Message-ID: <20230517143023.GA65838@fedora>
References: <20230511091527.46620-1-sgarzare@redhat.com>
 <20230511091527.46620-2-sgarzare@redhat.com>
 <1a89ee2e-2368-4051-f9ec-018641721484@redhat.com>
 <q2odwrndg3gt6z25hdxb3t2xxavd64hkp4b23zhzycevhrwx64@25r5r6sidyok>
 <e8fcb4cf-3667-2bdf-a163-d81bdfb71bfa@redhat.com>
 <vcinivshe3tf4iod7ys236fq5ovzhyhei5zvo2uf636fpb2vtr@swcn25px5h5z>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="l5BtPLUBOc+wpmLe"
Content-Disposition: inline
In-Reply-To: <vcinivshe3tf4iod7ys236fq5ovzhyhei5zvo2uf636fpb2vtr@swcn25px5h5z>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--l5BtPLUBOc+wpmLe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2023 at 09:19:26AM +0200, Stefano Garzarella wrote:
> CCing Markus for some advice.
>=20
> On Tue, May 16, 2023 at 11:04:21AM -0500, Jonathon Jongsma wrote:
> > On 5/15/23 5:10 AM, Stefano Garzarella wrote:
> > > On Thu, May 11, 2023 at 11:03:22AM -0500, Jonathon Jongsma wrote:
> > > > On 5/11/23 4:15 AM, Stefano Garzarella wrote:
> > > > > The virtio-blk-vhost-vdpa driver in libblkio 1.3.0 supports the n=
ew
> > > > > 'fd' property. Let's expose this to the user, so the management l=
ayer
> > > > > can pass the file descriptor of an already opened vhost-vdpa char=
acter
> > > > > device. This is useful especially when the device can only be acc=
essed
> > > > > with certain privileges.
> > > > >=20
> > > > > If the libblkio virtio-blk driver supports fd passing, let's alwa=
ys
> > > > > use qemu_open() to open the `path`, so we can handle fd passing
> > > > > from the management layer through the "/dev/fdset/N" special path.
> > > > >=20
> > > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > > ---
> > > > >=20
> > > > > Notes:
> > > > > =A0=A0=A0 v3:
> > > > > =A0=A0=A0 - use qemu_open() on `path` to simplify libvirt code [J=
onathon]
> > > >=20
> > > >=20
> > > > Thanks
> > > >=20
> > > > The one drawback now is that it doesn't seem possible for
> > > > libvirt to introspect whether or not qemu supports passing an fd
> > > > to the driver or not.
> > >=20
> > > Yep, this was because the libblkio library did not support this new w=
ay.
> > >=20
> > > > When I was writing my initial patch (before I realized that it
> > > > was missing fd-passing), I just checked for the existence of the
> > > > virtio-blk-vhost-vdpa device. But we actually need to know both
> > > > that this device exists and supports fd passing.
> > >=20
> > > Yep, this was one of the advantages of using the new `fd` parameter.
> > > Can't libvirt handle the later failure?
> >=20
> > Not very well. libvirt tries to provide useful errors to the user. So
> > for example if the qemu executable doesn't support a device, we would
> > want to provide an error indicating that the device is not supported
> > rather than a possibly-inscrutable qemu error.
> >=20
> > For example, in this scenario, we would want an error such as:
> >=20
> > error: unsupported configuration: vhostvdpa disk is not supported with
> > this QEMU binary
> >=20
> > Instead of:
> >=20
> > error: internal error: qemu unexpectedly closed the monitor:
> > 2023-05-16T15:17:36.666129Z qemu-system-x86_64: -blockdev {"driver":"vi=
rtio-blk-vhost-vdpa","path":"/dev/fdset/0","node-name":"libvirt-1-storage",=
"cache":{"direct":true,"no-flush":false},"auto-read-only":true,"discard":"u=
nmap"}:
> > blkio_connect failed: Failed to connect to vDPA device: Input/output
> > error
> >=20
> > And we can only do that if we can determine that the binary has the
> > proper support for fds.
>=20
> I see the problem, thanks for explaining this!
>=20
> >=20
> > >=20
> > > > As far as I can tell, versions 7.2.0 and 8.0.0 include this
> > > > device but won't accept fds.
> > >=20
> > > Right.
> > >=20
> > > How do you suggest to proceed?
> >=20
> > I need some way to determine that the particular qemu binary can accept
> > a /dev/fdset/ path for vdpa block devices. libvirt uses a variety of
> > methods to determine capabilities for a given qemu binary, including
> > querying the qmp schema, commands, object types, specific device/object
> > properties, etc. For example, right now I can determine (via querying
> > the qmp schema) whether virtio-blk-vhost-vdpa is a valid type for the
> > blockdev-add command by querying the qmp schema. I need something more
> > than that but I'm not sure how to do it without introducing a separate
> > 'fd' parameter. Any ideas?
>=20
> The only thing I can think of is to make a mix between v2 and v3. I mean =
add
> both the new `fd` parameter, and support qemu_open() on `path`.
>=20
> That way libvirt (or other users) can check that fd passing is supported =
and
> use `fd` or fdset with `path`.
>=20
> Obviously I would have liked to implement only one of the two methods, but
> if this helps, maybe it makes sense to support both.
>=20
> What do you think?

Markus: Is a preferred way to make this new path handling behavior
introspectable? I vaguely remember a way for QMP clients to query
strings that describe QMP behavior that's not otherwise
introspectable...

Stefan

--l5BtPLUBOc+wpmLe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRk5P8ACgkQnKSrs4Gr
c8jpkggAohG+JkRQpYjRoNhM8BREJVa4SSh7T0v1Jnw7cnER/neC23EcLwfVGq7M
Sr0713TdfK24V0oJ11TFMc6BppI/X/W37tmUv06xlykYLBDJbs50DfWjcSyB/tbl
spJy5IRC6GvtCddbtqIIO9F7MqMeXnllw3o5n1EDPJgTV36W9TqBDpAM1E1hiKKW
MQhzfERZEwnDiHnzmEqEil7VCEAG8EuYy9mhKwyQUiMrviet55wqzN4jrhM0aLKC
tAvIBhTGdKMhm27jpEcsdmWej06Qq+f8IFL214NZy8Fq2xoGuW3TszV8S4XMLjvn
+bTThF2t4nz8Oz3aZk5TzcFqdXSUiA==
=JU8/
-----END PGP SIGNATURE-----

--l5BtPLUBOc+wpmLe--


