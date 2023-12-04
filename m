Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D523180377E
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 15:50:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAAGx-00089X-Jl; Mon, 04 Dec 2023 09:50:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAAGt-00089E-4E
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:50:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAAGr-00050u-IN
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:50:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701701404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q15/3BVVyOaihcucEucNKs/jzap+i7xs4+FWf0/CsZk=;
 b=Ost3AWy/dHsq1RQsEKl+UDWP48e3cYiFMOCYJmO/kVxeipKWOo/Lkw5lyJB0XEROYe8m6r
 0Zb7jCnWL2u8CMMTtCzcKd3uIyN/1QpkxzOo6w781FOzVSw0yh19E8f3Ey+ULesqDedV+p
 qvgcGNnoGXlcMx++HIzYKuYizMf6YEg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-5wDKJD6mPs27fxPG3prMrg-1; Mon, 04 Dec 2023 09:49:58 -0500
X-MC-Unique: 5wDKJD6mPs27fxPG3prMrg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B74B811E8F;
 Mon,  4 Dec 2023 14:49:57 +0000 (UTC)
Received: from localhost (unknown [10.39.192.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3903240C6EB9;
 Mon,  4 Dec 2023 14:49:55 +0000 (UTC)
Date: Mon, 4 Dec 2023 09:49:54 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alberto Garcia <berto@igalia.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
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
Subject: Re: [PATCH 01/12] virtio-scsi: replace AioContext lock with
 tmf_bh_lock
Message-ID: <20231204144954.GA1492005@fedora>
References: <20231129195553.942921-1-stefanha@redhat.com>
 <20231129195553.942921-2-stefanha@redhat.com>
 <tng432xox5h3zwi7vkc7nbuu2bckkackqtdifqt2dtsn7t2eti@m2jwhopket2s>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xuVVbWEiWN36eeYa"
Content-Disposition: inline
In-Reply-To: <tng432xox5h3zwi7vkc7nbuu2bckkackqtdifqt2dtsn7t2eti@m2jwhopket2s>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--xuVVbWEiWN36eeYa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 09:25:52AM -0600, Eric Blake wrote:
> On Wed, Nov 29, 2023 at 02:55:42PM -0500, Stefan Hajnoczi wrote:
> > Protect the Task Management Function BH state with a lock. The TMF BH
> > runs in the main loop thread. An IOThread might process a TMF at the
> > same time as the TMF BH is running. Therefore tmf_bh_list and tmf_bh
> > must be protected by a lock.
> >=20
> > Run TMF request completion in the IOThread using aio_wait_bh_oneshot().
> > This avoids more locking to protect the virtqueue and SCSI layer state.
>=20
> Are we trying to get this into 8.2?

No. 8.2 still has the AioContext lock is therefore safe without this
patch.

Stefan

>=20
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  include/hw/virtio/virtio-scsi.h |  3 +-
> >  hw/scsi/virtio-scsi.c           | 62 ++++++++++++++++++++++-----------
> >  2 files changed, 43 insertions(+), 22 deletions(-)
> >
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.
> Virtualization:  qemu.org | libguestfs.org
>=20

--xuVVbWEiWN36eeYa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVt5xIACgkQnKSrs4Gr
c8jrKAgAi9Ez+xTcPA2/0XgPvi0dsAshvngJFgGPGKyor2T6HSiEfY5fZnA+zl/Z
6RqIc79YvldlUyqQVTXHU/H0yF/UW4h9d2gz0nlaCBx/1H0xzbAmLUTMW5bGQ/vT
N5SCBl6RSfDRmU/eZcbrIqHOaphPCeBt4v6mnfrCF5F9XAS/Iarz7MybbHWnZEq3
93KGFY1LBRQIwp/IhNA+lkMxrysBl5fYLCoKaVxj03r5DSP3c/QwSKcy2jyubAG1
SQS2QRmPHmOOK5jyL2mMs6cnUk8spfmqH9BJl/46nXpvYpJ63m/6ujHjfxGbp9EJ
dJdPCfP8N/qcMJGUlSGyGL7UfQp3cQ==
=UZuA
-----END PGP SIGNATURE-----

--xuVVbWEiWN36eeYa--


