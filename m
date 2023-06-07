Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E6E726867
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 20:21:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6xlB-0005eG-Gp; Wed, 07 Jun 2023 14:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q6xl9-0005dk-8E
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 14:19:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q6xl7-0003hv-My
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 14:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686161988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wGVtEoqBAl8lwptyFmXJk6BJGB0qFKkr4ZFuvw51r0Q=;
 b=AqedxIuQfcyxM5GX6psV3tj+WPmSvpj8PMHb1LJQkK0Hzh8bc33y4i/8XWfu0EH68JvyhW
 qO1nib+vIDm/ui8gdhearcgZ9uyvEIv9N/6pHVM+qLmjMixOOpwxeCLbL1r/zWRjNs0pdH
 SwAS+iPJcCQR4NSaVlkt1oMqrJVzso0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-M9_KrGU4O_etW2pFzX5xUw-1; Wed, 07 Jun 2023 14:19:44 -0400
X-MC-Unique: M9_KrGU4O_etW2pFzX5xUw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED5C33802138;
 Wed,  7 Jun 2023 18:19:43 +0000 (UTC)
Received: from localhost (unknown [10.39.192.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6CBC81121314;
 Wed,  7 Jun 2023 18:19:43 +0000 (UTC)
Date: Wed, 7 Jun 2023 14:19:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 00/11] block: Re-enable the graph lock
Message-ID: <20230607181941.GH2138915@fedora>
References: <20230605085711.21261-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="G0B+TaaRmkzvaMsb"
Content-Disposition: inline
In-Reply-To: <20230605085711.21261-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--G0B+TaaRmkzvaMsb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2023 at 10:57:00AM +0200, Kevin Wolf wrote:
> This series fixes the deadlock that was observed before commit ad128dff
> ('graph-lock: Disable locking for now'), which just disabled the graph
> lock completely as a workaround to get 8.0.1 stable.
>=20
> In theory the problem is simple: We can't poll while still holding the
> lock of a different AioContext. So bdrv_graph_wrlock() just needs to
> drop that lock before it polls. However, there are a number of callers
> that don't even hold the AioContext lock they are supposed to hold, so
> temporarily unlocking tries to unlock a mutex that isn't locked,
> resulting in assertion failures.
>=20
> Therefore, much of this series is just for fixing AioContext locking
> correctness. It is only the last two patches that actually fix the
> deadlock and reenable the graph locking.
>=20
> v2:
> - Fixed patch 2 to actually lock the correct AioContext even if the
>   device doesn't support iothreads
> - Improved the commit message for patch 7 [Eric]
> - Fixed mismerge in patch 11 (v1 incorrectly left an #if 0 around)
>=20
> Kevin Wolf (11):
>   iotests: Test active commit with iothread and background I/O
>   qdev-properties-system: Lock AioContext for blk_insert_bs()
>   test-block-iothread: Lock AioContext for blk_insert_bs()
>   block: Fix AioContext locking in bdrv_open_child()
>   block: Fix AioContext locking in bdrv_attach_child_common()
>   block: Fix AioContext locking in bdrv_reopen_parse_file_or_backing()
>   block: Fix AioContext locking in bdrv_open_inherit()
>   block: Fix AioContext locking in bdrv_open_backing_file()
>   blockjob: Fix AioContext locking in block_job_add_bdrv()
>   graph-lock: Unlock the AioContext while polling
>   Revert "graph-lock: Disable locking for now"
>=20
>  include/block/graph-lock.h                    |   6 +-
>  block.c                                       | 103 ++++++++++++++++--
>  block/graph-lock.c                            |  42 ++++---
>  blockjob.c                                    |  17 ++-
>  hw/core/qdev-properties-system.c              |   8 +-
>  tests/unit/test-block-iothread.c              |   7 +-
>  .../tests/iothreads-commit-active             |  85 +++++++++++++++
>  .../tests/iothreads-commit-active.out         |  23 ++++
>  8 files changed, 250 insertions(+), 41 deletions(-)
>  create mode 100755 tests/qemu-iotests/tests/iothreads-commit-active
>  create mode 100644 tests/qemu-iotests/tests/iothreads-commit-active.out
>=20
> --=20
> 2.40.1
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--G0B+TaaRmkzvaMsb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmSAyj0ACgkQnKSrs4Gr
c8jS0AgAwDBhT+DO0ipY1k/RRdcAohljk2ITacM1aN101RH5nksVvmEaKHE3tJXW
96BTVp/uBzqwQuzRltSLTPjWa6ZpWLNH0TV6nl6iIRXQrJWDEIsfhae/FQ5PYULi
YAYr5Ehz6vUwaLNgG79taFcSK6n+5ZaBaKFp6S9BjaPVtcly9sFtA9Gns3jMw9Rp
vtrA/hYCVGykJ4ykO4jXRx2Q4fxVN5nj0etvoULubWrhoZfTgWuCXN/yX+D2agaw
AZifX7BbCUz+Etf+iqK+h+SfVqsi0qBonGXDFeah3fIo674vulKqHqIPncu8Dcp6
Hx/O9/tuIgB9qkWrOQIYBPtTnJGATw==
=Xzta
-----END PGP SIGNATURE-----

--G0B+TaaRmkzvaMsb--


