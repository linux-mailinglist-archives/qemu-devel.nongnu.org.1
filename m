Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DECCB763B39
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 17:37:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOgW6-0004TT-JS; Wed, 26 Jul 2023 11:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qOgUu-0003bH-ER
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 11:32:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qOgUs-0001aQ-Eo
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 11:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690385537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B1Fk9kZqNDUjWkncJB1sqHFQq8WufeRLWeW/HropujY=;
 b=Eb9CYtBrRkLJjEyRb7oc7rD89uan0Y+G2la5Qc8un06tFJpUHaOQpDMz5BK7+gOf8tnh9b
 9zKsZI3aFkamsWo9oUkX5IASlbqopwHk3BgC8pbFdezWp31fqL9F5Pi7Jd5Wj6gTQiOIkV
 41JhcDa5txbVpJrkTV2VI13PUtpLBc4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-lSD23LlaM3uVw45eH0NUbw-1; Wed, 26 Jul 2023 11:32:13 -0400
X-MC-Unique: lSD23LlaM3uVw45eH0NUbw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FE35185A792;
 Wed, 26 Jul 2023 15:32:13 +0000 (UTC)
Received: from localhost (unknown [10.39.195.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B2EB40C2063;
 Wed, 26 Jul 2023 15:32:12 +0000 (UTC)
Date: Wed, 26 Jul 2023 11:32:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Qing Wang <qinwang@redhat.com>
Subject: Re: [PATCH 1/2] block/blkio: fix opening virtio-blk drivers
Message-ID: <20230726153210.GD809650@fedora>
References: <20230724154611.178858-1-sgarzare@redhat.com>
 <20230724154611.178858-2-sgarzare@redhat.com>
 <20230725200038.GB749269@fedora>
 <zba7q3vye5fwm33wkmmoajiya6mq3oesn3isqtf4qb24vdbn6u@ru7fzcovwmow>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="v7F149Za7AQu9RHV"
Content-Disposition: inline
In-Reply-To: <zba7q3vye5fwm33wkmmoajiya6mq3oesn3isqtf4qb24vdbn6u@ru7fzcovwmow>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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


--v7F149Za7AQu9RHV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023 at 09:26:45AM +0200, Stefano Garzarella wrote:
> On Tue, Jul 25, 2023 at 04:00:38PM -0400, Stefan Hajnoczi wrote:
> > On Mon, Jul 24, 2023 at 05:46:10PM +0200, Stefano Garzarella wrote:
> > > libblkio 1.3.0 added support of "fd" property for virtio-blk-vhost-vd=
pa
> > > driver. In QEMU, starting from commit cad2ccc395 ("block/blkio: use
> > > qemu_open() to support fd passing for virtio-blk") we are using
> > > `blkio_get_int(..., "fd")` to check if the "fd" property is supported
> > > for all the virtio-blk-* driver.
> > >=20
> > > Unfortunately that property is also available for those driver that do
> > > not support it, such as virtio-blk-vhost-user. Indeed now QEMU is
> > > failing if used with virtio-blk-vhost-user in this way:
> > >=20
> > >    -blockdev node-name=3Ddrive0,driver=3Dvirtio-blk-vhost-user,path=
=3Dvhost-user-blk.sock,cache.direct=3Don: Could not open 'vhost-user-blk.so=
ck': No such device or address
> > >=20
> > > So, `blkio_get_int()` is not enough to check whether the driver suppo=
rts
> > > the `fd` property or not. This is because the virito-blk common libbl=
kio
> > > driver only checks whether or not `fd` is set during `blkio_connect()`
> > > and fails for those transports that do not support it (all except
> > > vhost-vdpa for now).
> > >=20
> > > So for now let's also check that the driver is virtio-blk-vhost-vdpa,
> > > since that's the only one that supports it.
> >=20
> > What happens when more virtio-blk-* libblkio drivers gain support for
> > `fd`? I think we'll be back to the same problem because QEMU will be
> > unable to distinguish between old and new libraries.
>=20
> If we release a v1.3.1 version of libblkio with
> https://gitlab.com/libblkio/libblkio/-/merge_requests/208
> we can set a minimum requirement in QEMU and use blkio_set_fd() here.
>=20
> >=20
> > How about retrying with `path` if opening with `fd` fails?
>=20
> IIUC the only way is to check if blkio_connect() will fail with -EINVAL,
> that can also be generated by other issues, then retry forcing `path`.
>=20
> Do you see other ways?

No. Checking for -EINVAL and then retrying with `path` is what I had in
mind.

> The code wouldn't be great, but we could do it for now and then when
> we release a new version of libblkio, do the revert and use
> blkio_set_int(fd) to see if it's supported or not.
>=20
> I don't know if it is worth it, or if it is better to merge this,
> release libblkio v1.3.1 and force the minimum requirement.
>=20
> WDYT?

I prefer retrying on -EINVAL because even if libblkio 1.3.1 is released
today, we don't have control over when it becomes available in distros.

Stefan

--v7F149Za7AQu9RHV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTBPHoACgkQnKSrs4Gr
c8jkewf/V9Z+L3rCJ9KuWeTviAG2crT9wa2Py4PtRQ5GmU69ecf0rFXMIrCfHYnU
hfFehXETssDgBd71N0ekVmQq3MwQnFGAnBH5w5KKDWvpEyqMMByoYDIv2C5MwQOz
MTT9+ATekoyYmii42SeqfAichuQPtQgWDolJMPxGQyKKGIgMoG7j9VZc/0/UaB14
5Fr0ElqiaTfLoaqi4LnTgKv5odlTo28FHKUmFDTQvDnwC9Rhx923ilAhgIcR0zwm
//pAVg8aSS5xg9IPoVyhYtM2lvLxp6FxrENPs6XDZlJ1wWfQYNk2a0VfaJSFbfzn
sR3ZR1y1VA7e1cMLHS5Bv7B4FZSSgg==
=G7zl
-----END PGP SIGNATURE-----

--v7F149Za7AQu9RHV--


