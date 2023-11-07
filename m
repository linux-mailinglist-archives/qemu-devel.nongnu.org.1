Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E67197E3437
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:31:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CnY-0003tD-1q; Mon, 06 Nov 2023 22:30:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0CnQ-0003qG-1n
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:30:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r0CnA-0005ib-G6
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699327814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3CMTq1PJNTq96yJmvvD5fxMItUB2k4g54v6kGXIA1Lg=;
 b=EJu2wLrDWALXchYxM1MeF82XiHeJoUPkkRyR5cmMQG7gFFSm91tlvu/0jeR417odMLHn/5
 SCQY1T+/qDarX10tukaP0+iLGf+y/fpCrOgRBmnX0ruum9HLazT0o7tTn6ONBdLv9lKLwE
 2FC6zPWFtZYVfvm1O/IrVA7AZ6NQjPs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-E2oZ4DNuNQCEw-Sls8Duvw-1; Mon, 06 Nov 2023 22:29:59 -0500
X-MC-Unique: E2oZ4DNuNQCEw-Sls8Duvw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9FCEB101A590;
 Tue,  7 Nov 2023 03:29:59 +0000 (UTC)
Received: from localhost (unknown [10.39.192.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9057502B;
 Tue,  7 Nov 2023 03:29:58 +0000 (UTC)
Date: Tue, 7 Nov 2023 11:29:55 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michal Privoznik <mprivozn@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 0/2] virtio-blk: add iothread-vq-mapping parameter
Message-ID: <20231107032955.GB949250@fedora>
References: <20230918161604.1400051-1-stefanha@redhat.com>
 <ZUOt7G+xdnLOBR5S@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="bESv9uFRf3ndl4yZ"
Content-Disposition: inline
In-Reply-To: <ZUOt7G+xdnLOBR5S@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


--bESv9uFRf3ndl4yZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 02, 2023 at 03:10:52PM +0100, Kevin Wolf wrote:
> Am 18.09.2023 um 18:16 hat Stefan Hajnoczi geschrieben:
> > virtio-blk and virtio-scsi devices need a way to specify the mapping be=
tween
> > IOThreads and virtqueues. At the moment all virtqueues are assigned to =
a single
> > IOThread or the main loop. This single thread can be a CPU bottleneck, =
so it is
> > necessary to allow finer-grained assignment to spread the load. With th=
is
> > series applied, "pidstat -t 1" shows that guests with -smp 2 or higher =
are able
> > to exploit multiple IOThreads.
> >=20
> > This series introduces command-line syntax for the new iothread-vq-mapp=
ing
> > property is as follows:
> >=20
> >   --device '{"driver":"virtio-blk-pci","iothread-vq-mapping":[{"iothrea=
d":"iothread0","vqs":[0,1,2]},...]},...'
> >=20
> > IOThreads are specified by name and virtqueues are specified by 0-based
> > index.
> >=20
> > It will be common to simply assign virtqueues round-robin across a set
> > of IOThreads. A convenient syntax that does not require specifying
> > individual virtqueue indices is available:
> >=20
> >   --device '{"driver":"virtio-blk-pci","iothread-vq-mapping":[{"iothrea=
d":"iothread0"},{"iothread":"iothread1"},...]},...'
> >=20
> > There is no way to reassign virtqueues at runtime and I expect that to =
be a
> > very rare requirement.
> >=20
> > Note that JSON --device syntax is required for the iothread-vq-mapping
> > parameter because it's non-scalar.
> >=20
> > Based-on: 20230912231037.826804-1-stefanha@redhat.com ("[PATCH v3 0/5] =
block-backend: process I/O in the current AioContext")
>=20
> Does this strictly depend on patch 5/5 of that series, or would it just
> be a missed opportunity for optimisation by unnecessarily running some
> requests from a different thread?

I looked at the issue with PATCH 5/5 more and didn't find a minimal
solution that I can implement today for soft freeze. There are too much
inconsistency between blk_remove_bs() in whether or not the AioContext
is acquired:

block/block-backend.c:        blk_remove_bs(blk); <- blk_unref (can't tell =
if AioContext is acquired)
block/block-backend.c:            blk_remove_bs(blk); (acquired)
block/monitor/block-hmp-cmds.c:        blk_remove_bs(blk); (acquired)
block/qapi-sysemu.c:    blk_remove_bs(blk); (acquired)
block/qapi-sysemu.c:            blk_remove_bs(blk); (not acquired)
qemu-nbd.c:        blk_remove_bs(blk); (not acquired)
tests/unit/test-block-iothread.c:    blk_remove_bs(blk); (acquired)
tests/unit/test-blockjob.c:    blk_remove_bs(blk); (sometimes acquired, som=
etimes not)

They usually get away with it because BDRV_WAIT_WHILE() only unlocks the
AioContext when the BlockDriverState's AioContext is not the current
thread's home context. This means main loop code works when the
AioContext is not acquired as long as the BDS AioContext is the main
loop AioContext.

The solution I have confidence in is to stop using the AioContext lock,
but it will take more time to refactor the SCSI layer (the last real
user of the AioContext).

I'm afraid iothread-vq-mapping can't make it into QEMU 8.2.

Stefan

--bESv9uFRf3ndl4yZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVJrzMACgkQnKSrs4Gr
c8hwfwf/UwAbFw9xsZy3NUekDRcZ1NxB5JfTs2pKCl7xqdasqKyQCcy7RXA7UoOJ
mesFdsM2Q+SPit4PzUsLKh0Rwn44+M2AlIUPMvwdxYz6CPRcti3Q3IvKDK0htaqb
ZZK5mu8usyRq/vxRoTh0q3qlIoEgYIpj5aDSkbXxP9Jz1sQudygeRc4Xhrfm9OEn
rbD6cKS43ckkXyyYq6Ni1wQ1oqzl2BsSEvtk61iktnv3xCY21QWNf+rwlW18idyP
nw8D+Z1w61OqSgCP3fvTWxBN40gw4CAYBAGrMe3nZEKL8UP1E6wUK31WXCmO0HxT
UdxL+0KA4xh2BkrEjANAmm+7sYKUOA==
=Sn57
-----END PGP SIGNATURE-----

--bESv9uFRf3ndl4yZ--


