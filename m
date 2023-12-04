Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9087B8038D2
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 16:29:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAAsd-0000x8-GA; Mon, 04 Dec 2023 10:29:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAAsW-0000vB-MI
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 10:29:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAAsS-0006xF-Ub
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 10:28:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701703733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IjZQ/pcxJi6moEy2NVEzJM5HAt5V3Rf3SCpNVckP6Fg=;
 b=iFnZFvUFJOG4fwan3cfF4ct2rlJqX1GJ7TGVJ18dFMYHfT+583BkRtkdqrCoxJI6DMYsrN
 2gFlhQY2vsfo/Nb5f1q89E3sXl1+DBEF1O6nGH0ib4Bmzyq6qV7l19JzxeoJWcIUBKLygx
 I1yt0Is3W20KSowM0gAtOAIK3LgCRKw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-0j3kj1VvMKy-e8MFdpknvw-1; Mon,
 04 Dec 2023 10:28:47 -0500
X-MC-Unique: 0j3kj1VvMKy-e8MFdpknvw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E55F929AA3AC;
 Mon,  4 Dec 2023 15:28:44 +0000 (UTC)
Received: from localhost (unknown [10.39.192.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4EDB210F44;
 Mon,  4 Dec 2023 15:28:44 +0000 (UTC)
Date: Mon, 4 Dec 2023 10:28:42 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alberto Garcia <berto@igalia.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, Coiby Xu <Coiby.Xu@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Ari Sundholm <ari@tuxera.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Cleber Rosa <crosa@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhang Chen <chen.zhang@intel.com>, Peter Xu <peterx@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Leonardo Bras <leobras@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Fam Zheng <fam@euphon.net>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 06/12] scsi: remove AioContext locking
Message-ID: <20231204152842.GE1492005@fedora>
References: <20231129195553.942921-1-stefanha@redhat.com>
 <20231129195553.942921-7-stefanha@redhat.com>
 <ZW3ErXZ2ZOo_kX2x@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HT+PqrFVEZkfTlWB"
Content-Disposition: inline
In-Reply-To: <ZW3ErXZ2ZOo_kX2x@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--HT+PqrFVEZkfTlWB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 01:23:09PM +0100, Kevin Wolf wrote:
> Am 29.11.2023 um 20:55 hat Stefan Hajnoczi geschrieben:
> > The AioContext lock no longer has any effect. Remove it.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  include/hw/virtio/virtio-scsi.h | 14 --------------
> >  hw/scsi/scsi-bus.c              |  2 --
> >  hw/scsi/scsi-disk.c             | 28 ++++------------------------
> >  hw/scsi/virtio-scsi.c           | 18 ------------------
> >  4 files changed, 4 insertions(+), 58 deletions(-)
>=20
> > @@ -2531,13 +2527,11 @@ static void scsi_unrealize(SCSIDevice *dev)
> >  static void scsi_hd_realize(SCSIDevice *dev, Error **errp)
> >  {
> >      SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, dev);
> > -    AioContext *ctx =3D NULL;
> > +
> >      /* can happen for devices without drive. The error message for mis=
sing
> >       * backend will be issued in scsi_realize
> >       */
> >      if (s->qdev.conf.blk) {
> > -        ctx =3D blk_get_aio_context(s->qdev.conf.blk);
> > -        aio_context_acquire(ctx);
> >          if (!blkconf_blocksizes(&s->qdev.conf, errp)) {
> >              goto out;
> >          }
> > @@ -2549,15 +2543,11 @@ static void scsi_hd_realize(SCSIDevice *dev, Er=
ror **errp)
> >      }
> >      scsi_realize(&s->qdev, errp);
> >  out:
> > -    if (ctx) {
> > -        aio_context_release(ctx);
> > -    }
> >  }
>=20
> This doesn't build for me:
>=20
> ../hw/scsi/scsi-disk.c:2545:1: error: label at end of compound statement =
is a C2x extension [-Werror,-Wc2x-extensions]
> }
> ^
> 1 error generated.

Will fix in v2. Thanks!

Stefan

--HT+PqrFVEZkfTlWB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVt8CoACgkQnKSrs4Gr
c8jc8wf/ZyGml3wk5T11oOQ1CpoCFpwfa/2Opfc5agssTpQ0CYaFXlM5ArdLiF4K
mMIdqI8vMbqF+Zvg7A67ETjSCE7idXIKcKdpFmG2ee1e8GDx1Piy0I1S48p4aMN4
TXmCfUeYeRf7F2gLPd5kuHQ/dp0tCN4qcghpkH627y3q4J3SykkLdza7elISopVA
z+B/Cvm9kyktQCV3yv5ezFE0bjeQH4c50T08WhpGsHUh2+k96DFMf1+30v0jmTSX
xRXpAFQeGdseABg0If6kZtso29BXOQMoZx4dIWUowTydjeTGDr6rOKtr6zseQFlm
6sC6sMotxD64mB1uyHE2/8Zo/Tlh7A==
=ToER
-----END PGP SIGNATURE-----

--HT+PqrFVEZkfTlWB--


