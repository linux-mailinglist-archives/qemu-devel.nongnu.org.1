Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FAF7ECA91
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 19:36:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3KkO-0000Fe-7D; Wed, 15 Nov 2023 13:36:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r3KkL-0000Eq-6t
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 13:36:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r3KkC-0003y9-AH
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 13:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700073367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gbOgFVY5y7gP5SmrFgI51kXH/Uoi8fiZYgEY1FOwYFo=;
 b=FcjfglsWUGsAJwc7blazCKygrMmb5bx7nyKrBAV8HZ9UWgZak1Qi6tX8A2zdjqhOMZkZDR
 1IZowVSRUAsJLObf8yy3fFng1hrJTU6RZOnYumBnxvrJTQvcdhdv+Mv26m+hvw5/sY9J76
 tVFXCtBm+lgbAIEH7nuaB2EKepMoz1Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-6qs7fJSjMrajeau8Vxt4wg-1; Wed,
 15 Nov 2023 13:36:03 -0500
X-MC-Unique: 6qs7fJSjMrajeau8Vxt4wg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 902A33C11C62;
 Wed, 15 Nov 2023 18:36:03 +0000 (UTC)
Received: from localhost (unknown [10.39.192.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF1EA40C6EB9;
 Wed, 15 Nov 2023 18:36:02 +0000 (UTC)
Date: Wed, 15 Nov 2023 13:36:01 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH for-8.2 0/4] block: Fix deadlocks with the stream job
Message-ID: <20231115183601.GC313373@fedora>
References: <20231115172012.112727-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="YARGA3SzUdHYHB0y"
Content-Disposition: inline
In-Reply-To: <20231115172012.112727-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
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


--YARGA3SzUdHYHB0y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 06:20:08PM +0100, Kevin Wolf wrote:
> This series contains three fixes for deadlocks that follow the same
> pattern: A nested event loop in the main thread waits for an iothread to
> make progress, but the AioContext lock of that iothread is still held by
> the main loop, so it can never make progress.
>=20
> We're planning to fully remove the AioContext lock in 9.0, which would
> automatically get rid of this kind of bugs, but it's still there in 8.2,
> so let's fix them individually for this release.
>=20
> Kevin Wolf (4):
>   block: Fix bdrv_graph_wrlock() call in blk_remove_bs()
>   block: Fix deadlocks in bdrv_graph_wrunlock()
>   stream: Fix AioContext locking during bdrv_graph_wrlock()
>   iotests: Test two stream jobs in a single iothread
>=20
>  include/block/graph-lock.h                    | 15 +++-
>  block.c                                       | 26 +++----
>  block/backup.c                                |  2 +-
>  block/blklogwrites.c                          |  4 +-
>  block/blkverify.c                             |  2 +-
>  block/block-backend.c                         | 10 ++-
>  block/commit.c                                | 10 +--
>  block/graph-lock.c                            | 23 +++++-
>  block/mirror.c                                | 14 ++--
>  block/qcow2.c                                 |  2 +-
>  block/quorum.c                                |  4 +-
>  block/replication.c                           | 10 +--
>  block/snapshot.c                              |  2 +-
>  block/stream.c                                | 10 +--
>  block/vmdk.c                                  | 10 +--
>  blockdev.c                                    |  4 +-
>  blockjob.c                                    |  8 +-
>  tests/unit/test-bdrv-drain.c                  | 20 ++---
>  tests/unit/test-bdrv-graph-mod.c              | 10 +--
>  scripts/block-coroutine-wrapper.py            |  2 +-
>  tests/qemu-iotests/tests/iothreads-stream     | 73 +++++++++++++++++++
>  tests/qemu-iotests/tests/iothreads-stream.out | 11 +++
>  22 files changed, 197 insertions(+), 75 deletions(-)
>  create mode 100755 tests/qemu-iotests/tests/iothreads-stream
>  create mode 100644 tests/qemu-iotests/tests/iothreads-stream.out
>=20
> --=20
> 2.41.0
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--YARGA3SzUdHYHB0y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmVVD5EACgkQnKSrs4Gr
c8jSQggAojIfRabvtQnrDf6ISj7bxarwVO/hn/1hLnGYYlB9UmoL9eMhjkODZayK
roiFPJIGu/nI4xIdLf00CRbNYEmyfOYdlwgSIjcz8tpCspg6Xd5uFbfMnSq+cxVi
k2gCYwdtRxOas5w8KIGFhxFhYM+M4AqD/qlpN/f0E5+s+BBPtscgSjaOrwKAW2gV
EwlZZAlVRQ+qSUhg+RblCutdcsEkWbLAW1g716hs5vC2eCt+4SIA0inY1UblXY2i
4DJbwb3ge0mYn1OhsKnzpm/3ywCh/+rm07hZ3CMxUcypWYlqi7lul5NspAE+/WLY
OO+VqnJktzlV3xx3aZuNg97FIsz+IQ==
=K1Ng
-----END PGP SIGNATURE-----

--YARGA3SzUdHYHB0y--


