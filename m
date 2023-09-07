Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88778797C2A
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 20:42:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeJxR-0005gb-6w; Thu, 07 Sep 2023 14:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeJxM-0005bQ-FP
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 14:42:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qeJxK-00008M-Bv
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 14:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694112137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LOt25EnO5qtj39ca67ISqEi98L4xJ4XOy0z+05I9wwI=;
 b=eQs3kF2lDx30jcV37udOsL7IcJdYBbGlfeGrAlGi9/GSshOTc7YIFi+PILR4JIHI0KosT1
 simfYs9nYH6+KDbiGFq3Sz39yuxejwVw+d7/bbacWlSyeT+u89yuzvCxKCkoaz938Pfgv2
 c30x5RS2KxxAWzi64ymIwsgsdNtEryw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-338-KPNWSMX8M1W7MSV-F37fow-1; Thu, 07 Sep 2023 14:42:03 -0400
X-MC-Unique: KPNWSMX8M1W7MSV-F37fow-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D3803C11A11;
 Thu,  7 Sep 2023 18:42:02 +0000 (UTC)
Received: from localhost (unknown [10.39.193.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D461A40C2070;
 Thu,  7 Sep 2023 18:42:01 +0000 (UTC)
Date: Thu, 7 Sep 2023 14:42:00 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, quintela@redhat.com,
 peterx@redhat.com, leobras@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [PATCH 0/2] virtio: Drop out of coroutine context in virtio_load()
Message-ID: <20230907184200.GB1560640@fedora>
References: <20230905145002.46391-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EpRV4qM7D4OA7J/G"
Content-Disposition: inline
In-Reply-To: <20230905145002.46391-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--EpRV4qM7D4OA7J/G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 05, 2023 at 04:50:00PM +0200, Kevin Wolf wrote:
> This fixes a recently introduced assertion failure that was reported to
> happen when migrating virtio-net with a failover. The latent bug that
> we're executing code in coroutine context that was never supposed to run
> there has existed for a long time. However, the new assertion that
> callers of bdrv_graph_rdlock_main_loop() don't run in coroutine context
> makes it very visible because it's now always a crash.
>=20
> Kevin Wolf (2):
>   vmstate: Mark VMStateInfo.get/put() coroutine_mixed_fn
>   virtio: Drop out of coroutine context in virtio_load()
>=20
>  include/migration/vmstate.h |  8 ++++---
>  hw/virtio/virtio.c          | 45 ++++++++++++++++++++++++++++++++-----
>  2 files changed, 45 insertions(+), 8 deletions(-)

This looks like a bandaid for a specific instance of this problem rather
than a solution that takes care of the root cause.

Is it possible to make VMStateInfo.get/put() consistenty coroutine_fn?

Stefan

--EpRV4qM7D4OA7J/G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmT6GXgACgkQnKSrs4Gr
c8gRAQgArU7H3LGMXXEao93mxmwrJehbP/Wmh4GlZyBIKMh/qOnx/KM2Kbq/UYuI
7Yc3e5NBUNARCBs1JJm0o9fz2TKcjMf7ATexCs7Zs2SnZuK1h+l1XFum7BXX2Ljo
Qx1bK6VkN2K/O53n8wadqmDJcjvfnjdOKzWuW0Kh+8OTPT7ENixsi2fJWU9vCzKd
EP157FxacpompWdx8zUP7X6vRS2wLH5gOYiTHjQbxEutjGbIiOxdbEc0XQ/W7XVq
2xjA3ggsaLkQXnWGwmo6Vjb4yn9RVe2RGUWZhGq4dKvaYY1yge4yNe15RZemN92r
qKRr45oHhUiJzZV9DGpKagb5hzmhsA==
=1kDz
-----END PGP SIGNATURE-----

--EpRV4qM7D4OA7J/G--


