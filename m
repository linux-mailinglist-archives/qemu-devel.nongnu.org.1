Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E5380378B
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 15:51:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAAI3-0000jE-4c; Mon, 04 Dec 2023 09:51:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAAHu-0000hn-RL
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:51:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rAAHt-0006I6-At
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701701468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xEOIXWa0DaRIIsxxh+p/yqRV4ny33fxYNbdSCdVwz7E=;
 b=XqUQj7vSk6lft5aZFYCzrVAdrW/HC7cRDhcNEEGpz+phpbgfQxoEh+WpeZmvBsfdUMnaIP
 RpxiVGmN2wvhRrIRDEzB7fcMkQJ3UHxYNXrjkkcFrUOct9YGEr/MUNa0jOo3svzvEYjLhW
 DcbteB0jCIzQAE5yCXFyPDCHJrBPn68=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-7kVZWR21Pym7Nfk5yaUfnQ-1; Mon, 04 Dec 2023 09:51:04 -0500
X-MC-Unique: 7kVZWR21Pym7Nfk5yaUfnQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6976685A59D;
 Mon,  4 Dec 2023 14:51:03 +0000 (UTC)
Received: from localhost (unknown [10.39.192.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C43E440C6EB9;
 Mon,  4 Dec 2023 14:51:02 +0000 (UTC)
Date: Mon, 4 Dec 2023 09:51:01 -0500
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
Subject: Re: [PATCH 01/12] virtio-scsi: replace AioContext lock with
 tmf_bh_lock
Message-ID: <20231204145101.GB1492005@fedora>
References: <20231129195553.942921-1-stefanha@redhat.com>
 <20231129195553.942921-2-stefanha@redhat.com>
 <ZW3KFQ3PsdbVFymi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mjl6rdY6Uz2gkcPm"
Content-Disposition: inline
In-Reply-To: <ZW3KFQ3PsdbVFymi@redhat.com>
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


--mjl6rdY6Uz2gkcPm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 01:46:13PM +0100, Kevin Wolf wrote:
> Am 29.11.2023 um 20:55 hat Stefan Hajnoczi geschrieben:
> > Protect the Task Management Function BH state with a lock. The TMF BH
> > runs in the main loop thread. An IOThread might process a TMF at the
> > same time as the TMF BH is running. Therefore tmf_bh_list and tmf_bh
> > must be protected by a lock.
> >=20
> > Run TMF request completion in the IOThread using aio_wait_bh_oneshot().
> > This avoids more locking to protect the virtqueue and SCSI layer state.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> The second part reminds me that the implicit protection of the virtqueue
> and SCSI data structures by having all accesses in a single thread is
> hard to review and I think we wanted to put some assertions there to
> check that we're really running in the right thread. I don't think we
> have done that so far, so I suppose after this patch would be the place
> in the series to add them, before we remove the protection by the
> AioContext lock?

Thanks for reminding me. I will add assertions in the next revision of
this series.

Stefan

--mjl6rdY6Uz2gkcPm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVt51UACgkQnKSrs4Gr
c8hFWgf+I5YP/4aOTKFaILLn7G6zRxMS0IOYp/agq08hZZX5uuODZdNJUtpvigRH
223SAFBeEWaIbzUlnbaUtw7/jucFuBfA6WsxCM9wwr/iL0AH9pHzDjnfY3XbJIyp
JsKSmTxS18OXWoK+mhrD6avFK8h9UKa+L5VV74gzbnjSmpQIBwXsSVzBjmton24v
c2tQIyRtBQiwZkgRJSa8GgzB4OPrXIQ9u0WfjXx0tOOJAXcIrTOPu6TYFDM/BbWH
6DP0WCKwetByfeC8aMEnU4F1weafWWk5xEeX5cQRWsECNbgyqIgfBTK8PgOSqC0M
bO4Kx4X2LBokyHJOzdsOT29Qh9pNvQ==
=xK/8
-----END PGP SIGNATURE-----

--mjl6rdY6Uz2gkcPm--


