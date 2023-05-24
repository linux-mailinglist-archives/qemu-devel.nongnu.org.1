Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCA27111C9
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 19:15:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2EXB-0007hd-N9; Thu, 25 May 2023 13:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2EX9-0007gd-7u
 for qemu-devel@nongnu.org; Thu, 25 May 2023 13:13:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q2EX5-0001eA-H9
 for qemu-devel@nongnu.org; Thu, 25 May 2023 13:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685034826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kfUTaAJEo733QW5IuvHr+XVRLFDwr3N21cdVHYzQ9xs=;
 b=OndTGlcbvLVf73cgOkvfArOW/KyUqv9yqqgEJX6X1057VApS4e8/OdYZAk9l2IsRysBcfC
 +noSrZXIC98KSIWddjudwAjz8XidoDQnrA+vOq8A1kn6+RUoC2dIZ0zUnk0aj1cj0cdGbt
 wTasg5/rg5R+PRW4fysGpW65lUjVgyc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-Bs_8hcV2PqmBIAEr93y5Ow-1; Thu, 25 May 2023 13:13:41 -0400
X-MC-Unique: Bs_8hcV2PqmBIAEr93y5Ow-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2084A185A793;
 Thu, 25 May 2023 17:13:41 +0000 (UTC)
Received: from localhost (unknown [10.39.192.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D512492B00;
 Thu, 25 May 2023 17:13:40 +0000 (UTC)
Date: Wed, 24 May 2023 15:16:28 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Jonathon Jongsma <jjongsma@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v3 1/1] block/blkio: use qemu_open() to support fd
 passing for virtio-blk
Message-ID: <20230524191628.GA17357@fedora>
References: <20230511091527.46620-1-sgarzare@redhat.com>
 <20230511091527.46620-2-sgarzare@redhat.com>
 <1a89ee2e-2368-4051-f9ec-018641721484@redhat.com>
 <q2odwrndg3gt6z25hdxb3t2xxavd64hkp4b23zhzycevhrwx64@25r5r6sidyok>
 <e8fcb4cf-3667-2bdf-a163-d81bdfb71bfa@redhat.com>
 <vcinivshe3tf4iod7ys236fq5ovzhyhei5zvo2uf636fpb2vtr@swcn25px5h5z>
 <20230517143023.GA65838@fedora>
 <CAGxU2F4PV5Cz+d4mG97gETPTg=KiYSDM5FpUM+jRhJJdef1-4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Mr6OFHYXrG4FJnkZ"
Content-Disposition: inline
In-Reply-To: <CAGxU2F4PV5Cz+d4mG97gETPTg=KiYSDM5FpUM+jRhJJdef1-4g@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


--Mr6OFHYXrG4FJnkZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 11:05:38AM +0200, Stefano Garzarella wrote:
> Gentle ping :-)
>=20
> On Wed, May 17, 2023 at 4:30=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.=
com> wrote:
> >
> > On Wed, May 17, 2023 at 09:19:26AM +0200, Stefano Garzarella wrote:
> > > CCing Markus for some advice.
> > >
> > > On Tue, May 16, 2023 at 11:04:21AM -0500, Jonathon Jongsma wrote:
> > > > On 5/15/23 5:10 AM, Stefano Garzarella wrote:
> > > > > On Thu, May 11, 2023 at 11:03:22AM -0500, Jonathon Jongsma wrote:
> > > > > > On 5/11/23 4:15 AM, Stefano Garzarella wrote:
> > > > > > > The virtio-blk-vhost-vdpa driver in libblkio 1.3.0 supports t=
he new
> > > > > > > 'fd' property. Let's expose this to the user, so the manageme=
nt layer
> > > > > > > can pass the file descriptor of an already opened vhost-vdpa =
character
> > > > > > > device. This is useful especially when the device can only be=
 accessed
> > > > > > > with certain privileges.
> > > > > > >
> > > > > > > If the libblkio virtio-blk driver supports fd passing, let's =
always
> > > > > > > use qemu_open() to open the `path`, so we can handle fd passi=
ng
> > > > > > > from the management layer through the "/dev/fdset/N" special =
path.
> > > > > > >
> > > > > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > > > > ---
> > > > > > >
> > > > > > > Notes:
> > > > > > >     v3:
> > > > > > >     - use qemu_open() on `path` to simplify libvirt code [Jon=
athon]
> > > > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > The one drawback now is that it doesn't seem possible for
> > > > > > libvirt to introspect whether or not qemu supports passing an fd
> > > > > > to the driver or not.
> > > > >
> > > > > Yep, this was because the libblkio library did not support this n=
ew way.
> > > > >
> > > > > > When I was writing my initial patch (before I realized that it
> > > > > > was missing fd-passing), I just checked for the existence of the
> > > > > > virtio-blk-vhost-vdpa device. But we actually need to know both
> > > > > > that this device exists and supports fd passing.
> > > > >
> > > > > Yep, this was one of the advantages of using the new `fd` paramet=
er.
> > > > > Can't libvirt handle the later failure?
> > > >
> > > > Not very well. libvirt tries to provide useful errors to the user. =
So
> > > > for example if the qemu executable doesn't support a device, we wou=
ld
> > > > want to provide an error indicating that the device is not supported
> > > > rather than a possibly-inscrutable qemu error.
> > > >
> > > > For example, in this scenario, we would want an error such as:
> > > >
> > > > error: unsupported configuration: vhostvdpa disk is not supported w=
ith
> > > > this QEMU binary
> > > >
> > > > Instead of:
> > > >
> > > > error: internal error: qemu unexpectedly closed the monitor:
> > > > 2023-05-16T15:17:36.666129Z qemu-system-x86_64: -blockdev {"driver"=
:"virtio-blk-vhost-vdpa","path":"/dev/fdset/0","node-name":"libvirt-1-stora=
ge","cache":{"direct":true,"no-flush":false},"auto-read-only":true,"discard=
":"unmap"}:
> > > > blkio_connect failed: Failed to connect to vDPA device: Input/output
> > > > error
> > > >
> > > > And we can only do that if we can determine that the binary has the
> > > > proper support for fds.
> > >
> > > I see the problem, thanks for explaining this!
> > >
> > > >
> > > > >
> > > > > > As far as I can tell, versions 7.2.0 and 8.0.0 include this
> > > > > > device but won't accept fds.
> > > > >
> > > > > Right.
> > > > >
> > > > > How do you suggest to proceed?
> > > >
> > > > I need some way to determine that the particular qemu binary can ac=
cept
> > > > a /dev/fdset/ path for vdpa block devices. libvirt uses a variety of
> > > > methods to determine capabilities for a given qemu binary, including
> > > > querying the qmp schema, commands, object types, specific device/ob=
ject
> > > > properties, etc. For example, right now I can determine (via queryi=
ng
> > > > the qmp schema) whether virtio-blk-vhost-vdpa is a valid type for t=
he
> > > > blockdev-add command by querying the qmp schema. I need something m=
ore
> > > > than that but I'm not sure how to do it without introducing a separ=
ate
> > > > 'fd' parameter. Any ideas?
> > >
> > > The only thing I can think of is to make a mix between v2 and v3. I m=
ean add
> > > both the new `fd` parameter, and support qemu_open() on `path`.
> > >
> > > That way libvirt (or other users) can check that fd passing is suppor=
ted and
> > > use `fd` or fdset with `path`.
> > >
> > > Obviously I would have liked to implement only one of the two methods=
, but
> > > if this helps, maybe it makes sense to support both.
> > >
> > > What do you think?
> >
> > Markus: Is a preferred way to make this new path handling behavior
> > introspectable? I vaguely remember a way for QMP clients to query
> > strings that describe QMP behavior that's not otherwise
> > introspectable...
>=20
> If there is no other way for introspection with QMP, I think adding
> `fd` and supporting `qemu_open()` on `path` is the easiest.

It doesn't hurt to go ahead with that approach. If Markus prefers a
different approach, he'll let us know.

To be clear: the presence of 'fd' indicates that 'path' now supports
qemu_open() semantics and libvirt will still only use 'path'?

Stefan

--Mr6OFHYXrG4FJnkZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmRuYosACgkQnKSrs4Gr
c8jmkAf/WmH8DWyI4wwCKPhNTJoFNaKVBAVan3xrY//CRt9qSzFrD9e+gr5xQTwx
E7QIZVDC1lcAFCfQ4HsBzqbWYDQvNb+zGQPXllu4rV3Hjiey57YXgepHAgACue1G
Kdq/N5xongNsSqrnjYE2YPbMplt3x+ziO36wPLKOSmOXZ2g63YHqatovXOxWG1/9
3A9zKhw1FOyfvSVyPVc8m5R/gN6/OxzUT+iV+xnsqyXyKUmdxe5ivJyDbKu3RmKj
CK9v3ogN1ZvZICW3dl28Ry4Hs9OUYrZmKCFPGQbFYnya4MVyiMM913PuY26zB5Wk
QHHAY4crJKww+nHSqL8GLZ70yNP2lA==
=dKyK
-----END PGP SIGNATURE-----

--Mr6OFHYXrG4FJnkZ--


