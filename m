Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0434F817380
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 15:26:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFEZH-0002E3-7h; Mon, 18 Dec 2023 09:26:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rFEZE-00029N-V7
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 09:26:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rFEZ3-0008FM-VA
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 09:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702909546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bhIHOHqaegyYBy0R82VZcKz+55y1HIC2DFKlGayMpsc=;
 b=fiR7wgFtxm0XPJpZDbnd3ilH9ob99tZwVYl6UBhfPRPBlhR0eq9uG1EtGtfyvVwxgIOxB8
 kKVlSBGxiPjSF1gwnzl0cxJwsjZliZLxWmIjrdLM2DDfsgn/yCDlTC2IGspqQAyzTN2qFD
 fSuc6GO0iy1EEYi7H3JRn5G0chXjh08=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-dfal9ejZN_qk_bsFtD6JWQ-1; Mon,
 18 Dec 2023 09:25:12 -0500
X-MC-Unique: dfal9ejZN_qk_bsFtD6JWQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 81F8E3C29A62;
 Mon, 18 Dec 2023 14:25:12 +0000 (UTC)
Received: from localhost (unknown [10.39.195.94])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0222D1121306;
 Mon, 18 Dec 2023 14:25:11 +0000 (UTC)
Date: Mon, 18 Dec 2023 09:25:10 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, pbonzini@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [RFC 0/3] aio-posix: call ->poll_end() when removing AioHandler
Message-ID: <20231218142510.GA12768@fedora>
References: <20231213211544.1601971-1-stefanha@redhat.com>
 <ba257408-5fb2-41d3-8b43-297ebcd312ea@proxmox.com>
 <20231214195352.GB1645604@fedora>
 <61c149da-ee22-418b-8575-b128b6836e38@proxmox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wFhZYElCkPY8EqsE"
Content-Disposition: inline
In-Reply-To: <61c149da-ee22-418b-8575-b128b6836e38@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.083,
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


--wFhZYElCkPY8EqsE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 01:41:38PM +0100, Fiona Ebner wrote:
> Am 14.12.23 um 20:53 schrieb Stefan Hajnoczi:
> >=20
> > I will still try the other approach that Hanna and Paolo have suggested.
> > It seems more palatable. I will send a v2.
> >=20
>=20
> FYI, what I already tried downstream (for VirtIO SCSI):
>=20
> > diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> > index 9c751bf296..a6449b04d0 100644
> > --- a/hw/scsi/virtio-scsi.c
> > +++ b/hw/scsi/virtio-scsi.c
> > @@ -1166,6 +1166,8 @@ static void virtio_scsi_drained_end(SCSIBus *bus)
> > =20
> >      for (uint32_t i =3D 0; i < total_queues; i++) {
> >          VirtQueue *vq =3D virtio_get_queue(vdev, i);
> > +        virtio_queue_set_notification(vq, 1);
> > +        virtio_queue_notify(vdev, i);
> >          virtio_queue_aio_attach_host_notifier(vq, s->ctx);
> >      }
> >  }
>=20
> But this introduces an issue where e.g. a 'backup' QMP command would put
> the iothread into a bad state. After the command, whenever the guest
> issues IO, the thread will temporarily spike to using 100% CPU. Using
> QMP stop+cont is a way to make it go back to normal.
>=20
> I think it's because of nested drains, because when additionally
> checking that the drain count is zero and only executing the loop then,
> that issue doesn't seem to manifest, i.e.:

Thanks for letting me know about the issue. I'll keep an eye out for it
when playing with the code.

Stefan

>=20
> > diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> > index 9c751bf296..d22c586b38 100644
> > --- a/hw/scsi/virtio-scsi.c
> > +++ b/hw/scsi/virtio-scsi.c
> > @@ -1164,9 +1164,13 @@ static void virtio_scsi_drained_end(SCSIBus *bus)
> >          return;
> >      }
> > =20
> > -    for (uint32_t i =3D 0; i < total_queues; i++) {
> > -        VirtQueue *vq =3D virtio_get_queue(vdev, i);
> > -        virtio_queue_aio_attach_host_notifier(vq, s->ctx);
> > +    if (s->bus.drain_count =3D=3D 0) {
> > +        for (uint32_t i =3D 0; i < total_queues; i++) {
> > +            VirtQueue *vq =3D virtio_get_queue(vdev, i);
> > +            virtio_queue_set_notification(vq, 1);
> > +            virtio_queue_notify(vdev, i);
> > +            virtio_queue_aio_attach_host_notifier(vq, s->ctx);
> > +        }
> >      }
> >  }
> > =20
>=20
> Best Regards,
> Fiona
>=20

--wFhZYElCkPY8EqsE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWAVkUACgkQnKSrs4Gr
c8hsvgf9GflFAzjbK2S6I5WSA9SkH4XEo8igmqR9jwVaFu3wbNqnMXlnJXsb6jx1
PbiTDV5JB9v6wjx9Wr/s54NUii2EiZrfvbFcY55ghCPmpYM+QaChLmiNKGgJ0UsB
0iXkzDotQEFfLJ3KrrTxORRDFmbd3c2lxa1/oJyluAYneKSphf1EQAi+wUnm96Cd
1LbeJpBQb/+z7fi8YNjjUiYuV+prFIs+HbUr8xQLqRMZ2U9LRu7aHA5O0ei3hvvA
G+aqNhM2VyvsHmx4lErajvD8jF+DPeUfEi4YU/Me+ul3hdISrcFeQ3DNqFvtuB0f
04cMNPuDp9tala+gNgFk/jskQmw+qg==
=Duz4
-----END PGP SIGNATURE-----

--wFhZYElCkPY8EqsE--


