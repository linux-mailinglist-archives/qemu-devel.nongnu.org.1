Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5560E784A98
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:40:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYXEF-0000e5-Q1; Tue, 22 Aug 2023 15:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYXEE-0000dk-Do
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:39:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYXEB-0006E6-9y
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692733186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TkIdl5ngRKejgpPaw+xZ5d0vkJNiO7godArG8gy24P8=;
 b=MbOGue+pt3RJvQkVbeJZucaZz4brdfgY2kgdxi0lvMKBXeN1GHtuXwqKP+B7BqwXJagAOL
 T8R+vx/QmfEw3qHAgIrbAvbMrOs5bVlus6Nu+jva/9IxJtf5qstCMALjXCwzOFptoJQsne
 o10MhLFpD6JxEat5Lr5JD5W1r2QjNmA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-UVovGhevMfyy4kr-fK_m1g-1; Tue, 22 Aug 2023 15:39:42 -0400
X-MC-Unique: UVovGhevMfyy4kr-fK_m1g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83CA6185A78B;
 Tue, 22 Aug 2023 19:39:42 +0000 (UTC)
Received: from localhost (unknown [10.39.195.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1BC582166B26;
 Tue, 22 Aug 2023 19:39:41 +0000 (UTC)
Date: Tue, 22 Aug 2023 15:39:40 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 20/21] block: Mark bdrv_unref_child() GRAPH_WRLOCK
Message-ID: <20230822193940.GW727224@fedora>
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-21-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+rjzYzOe7HMYU4tw"
Content-Disposition: inline
In-Reply-To: <20230817125020.208339-21-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--+rjzYzOe7HMYU4tw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 02:50:19PM +0200, Kevin Wolf wrote:
> Instead of taking the writer lock internally, require callers to already
> hold it when calling bdrv_unref_child(). These callers will typically
> already hold the graph lock once the locking work is completed, which
> means that they can't call functions that take it internally.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block-global-state.h |  7 ++++++-
>  block.c                            | 11 +++++++----
>  block/blklogwrites.c               |  4 ++++
>  block/blkverify.c                  |  2 ++
>  block/qcow2.c                      |  4 +++-
>  block/quorum.c                     |  6 ++++++
>  block/replication.c                |  3 +++
>  block/snapshot.c                   |  2 ++
>  block/vmdk.c                       | 11 +++++++++++
>  tests/unit/test-bdrv-drain.c       |  8 ++++++--
>  10 files changed, 50 insertions(+), 8 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--+rjzYzOe7HMYU4tw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTlDvwACgkQnKSrs4Gr
c8ia+wgAg9ve1ocI6tnQ2/7wS+lvKN3/zmtKH+bIa/BPjYYNpH/pK4WkL5DNFTp1
BZ/AyInqUaIbO6iHXErEF+kdy6UOS7b0qgB7wKWWoSZv+midgE2MWyfsHY5/xjd6
3VViHw/g9ZKjmtUVCCNr42zFtdaaZ5zvxUWqe+QzY11EEehbnyUaiVV7/P3EnTrL
peHl+IOrJAcjp1KovbIgB8mhGdb6X7EsYbQxt+HjrFvCv9F5kOwgYVkZYvf+clbp
0X7uulK6hn5RuYGiOWtQk7F5lsYRZP6EtNnSLOEVD9fmg06AhnTPSOC/hwVb7rWO
bS86NlZl9QoPoPp5MHtGWIeYB4c5pQ==
=qTz8
-----END PGP SIGNATURE-----

--+rjzYzOe7HMYU4tw--


