Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8AA832ADF
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 14:59:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQpOD-0004W9-LS; Fri, 19 Jan 2024 08:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rQpNy-0004Hj-Kh
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:58:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rQpNu-0000X0-KU
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705672693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=unTrNnldBqgn7S//uNsJf5/NLVVUxpDqZKQG52+BAwY=;
 b=GxsBuP+IWBP2VaRijJ0rtGngjHqMFdairXwz527fCUTbKzrK9a5cwb25ramEdhz5wnI4o2
 BsZv4dDk9cpJ9++QHcKUXzLmsPh0Dc1NwTMfjDfdJHgDopYpAjqPHocD1xRpmM2eBInG7n
 3WAHbZqC8A0K2KF5qm+dVVDXZs0hmMI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-XBaEPJ0zMoCVe4QmbL1vWw-1; Fri,
 19 Jan 2024 08:58:08 -0500
X-MC-Unique: XBaEPJ0zMoCVe4QmbL1vWw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87BE91C54031;
 Fri, 19 Jan 2024 13:58:08 +0000 (UTC)
Received: from localhost (unknown [10.39.195.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DDF9200A2F4;
 Fri, 19 Jan 2024 13:58:07 +0000 (UTC)
Date: Fri, 19 Jan 2024 08:41:22 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Michal Privoznik <mprivozn@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eduardo Habkost <eduardo@habkost.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 4/4] virtio-blk: add iothread-vq-mapping parameter
Message-ID: <20240119134122.GA65300@fedora>
References: <20231220134755.814917-1-stefanha@redhat.com>
 <20231220134755.814917-5-stefanha@redhat.com>
 <ZYRAQ3izSH-QWuGp@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NyqjRYAwRBLq+sbL"
Content-Disposition: inline
In-Reply-To: <ZYRAQ3izSH-QWuGp@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--NyqjRYAwRBLq+sbL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 02:40:19PM +0100, Kevin Wolf wrote:
> Am 20.12.2023 um 14:47 hat Stefan Hajnoczi geschrieben:
> > Add the iothread-vq-mapping parameter to assign virtqueues to IOThreads.
> > Store the vq:AioContext mapping in the new struct
> > VirtIOBlockDataPlane->vq_aio_context[] field and refactor the code to
> > use the per-vq AioContext instead of the BlockDriverState's AioContext.
> >=20
> > Reimplement --device virtio-blk-pci,iothread=3D and non-IOThread mode by
> > assigning all virtqueues to the IOThread and main loop's AioContext in
> > vq_aio_context[], respectively.
> >=20
> > The comment in struct VirtIOBlockDataPlane about EventNotifiers is
> > stale. Remove it.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> > @@ -177,19 +238,13 @@ int virtio_blk_data_plane_start(VirtIODevice *vde=
v)
> > =20
> >      trace_virtio_blk_data_plane_start(s);
> > =20
> > -    r =3D blk_set_aio_context(s->conf->conf.blk, s->ctx, &local_err);
> > +    r =3D blk_set_aio_context(s->conf->conf.blk, s->vq_aio_context[0],
> > +                            &local_err);
> >      if (r < 0) {
> >          error_report_err(local_err);
> >          goto fail_aio_context;
> >      }
>=20
> This doesn't really have to be an error any more, we'll just submit I/O
> from any thread we want no matter what the home AioContext of the
> BlockBackend is.
>=20
> So the only effect the blk_set_aio_context() has is that other users of
> the image try to submit their requests from the same iothread as the
> first virtqueue in the hope that this performs a bit better (maybe less
> lock contention or whatever the idea was?)

Yes, I'll change this.

> > -    /* Kick right away to begin processing requests already in vring */
> > -    for (i =3D 0; i < nvqs; i++) {
> > -        VirtQueue *vq =3D virtio_get_queue(s->vdev, i);
> > -
> > -        event_notifier_set(virtio_queue_get_host_notifier(vq));
> > -    }
> > -
> >      /*
> >       * These fields must be visible to the IOThread when it processes =
the
> >       * virtqueue, otherwise it will think dataplane has not started ye=
t.
> > @@ -206,8 +261,12 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
> >      if (!blk_in_drain(s->conf->conf.blk)) {
> >          for (i =3D 0; i < nvqs; i++) {
> >              VirtQueue *vq =3D virtio_get_queue(s->vdev, i);
> > +            AioContext *ctx =3D s->vq_aio_context[i];
> > =20
> > -            virtio_queue_aio_attach_host_notifier(vq, s->ctx);
> > +            /* Kick right away to begin processing requests already in=
 vring */
> > +            event_notifier_set(virtio_queue_get_host_notifier(vq));
>=20
> The old code did this also for blk_in_drain() =3D=3D true. Why don't we n=
eed
> it there any more? Should the 'if' move inside the loop just around
> attaching the notifier?

The answer is I'm not 100% sure. Your suggestion is safer, I'll do that.

Stefan

--NyqjRYAwRBLq+sbL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWqfAIACgkQnKSrs4Gr
c8gUiQf9Gi1nfJUPMTm1r0Vl2JTTfJDY0NUxS16jL65eU+8dze5+cWX/Eo4TozFO
HaVhyArGeBI6MDkt1+vNYwdfLNNUT0cjf1vC/Vb0qDOquA1s858PcuvX5D6/zIr2
AUzodDCnzxUXI/yziE4DTYEt8G635kdM97zY1b6Iurq7GstH0njr8W+p7GwVC+ow
i2fCYMvrz03ko488O4j10a4+Jsi2/bMtHoKITr9HI9RCFlsqwyv1ZeULpOx+vHnf
0F0Z2v+g5wJ7hmvEnwTyCkPc63kbT0RIElHqI+DQMDhaGV7dPf64x2cf54yB3DS1
u66MiEhRrFU5hzKfOg4G/zgeKchJzg==
=0WG/
-----END PGP SIGNATURE-----

--NyqjRYAwRBLq+sbL--


