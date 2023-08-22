Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A74784A5C
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 21:24:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYWyV-0005g8-4V; Tue, 22 Aug 2023 15:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYWyT-0005fj-UA
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:23:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYWyR-00023N-UO
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 15:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692732211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jlg5/6DxHfiDO8Sr4dwdvQIwd5ZdFcDDtGbt95LGOaY=;
 b=FnUWDxUIU5NH+GNb2j3YUV/FXL94RoD0YG+BQjoiRXooACa6ntOs1h7qaOjjDWSl8xsg7l
 6szXu4EkkCLaeRue1tUW6TViEJDIt8kDB1Jh57edcpMEv1hCPKJTtp30+N08MvYNPCbJYF
 3WEhIA4RwfQew4udkmC0yeiA3ykkFxE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-280-m7p3yL69M7SC72NsF1rUSQ-1; Tue, 22 Aug 2023 15:23:27 -0400
X-MC-Unique: m7p3yL69M7SC72NsF1rUSQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA8A6101A59C;
 Tue, 22 Aug 2023 19:23:26 +0000 (UTC)
Received: from localhost (unknown [10.39.195.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7FE68140E96E;
 Tue, 22 Aug 2023 19:23:26 +0000 (UTC)
Date: Tue, 22 Aug 2023 15:23:25 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 13/21] block: Mark bdrv_parent_perms_conflict() and
 callers GRAPH_RDLOCK
Message-ID: <20230822192325.GP727224@fedora>
References: <20230817125020.208339-1-kwolf@redhat.com>
 <20230817125020.208339-14-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cB9STJM5vUwXMraG"
Content-Disposition: inline
In-Reply-To: <20230817125020.208339-14-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--cB9STJM5vUwXMraG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 02:50:12PM +0200, Kevin Wolf wrote:
> The function reads the parents list, so it needs to hold the graph lock.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block_int-common.h            |  6 ++---
>  include/block/block_int-global-state.h      |  8 +++---
>  include/sysemu/block-backend-global-state.h |  4 +--
>  block.c                                     | 28 +++++++++++++--------
>  block/block-backend.c                       | 26 ++++++++++++++-----
>  block/crypto.c                              |  6 +++--
>  block/mirror.c                              |  8 ++++++
>  block/vmdk.c                                |  2 ++
>  tests/unit/test-bdrv-graph-mod.c            |  4 +++
>  9 files changed, 66 insertions(+), 26 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--cB9STJM5vUwXMraG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTlCy0ACgkQnKSrs4Gr
c8i7Vgf+Iun8cWPYKJbHHSOa1uDtzvErev8wFHHaiKZQ06lO9flRtCT7/5NW8n6k
UVpiwFsWJYXKrUo3yeYl8vpXjvyJarevzaj9PGlBJbLP6NLcRdkvwmkqXkXeQgZ4
KRq5TCAO3PqCm6JuiqPY7jKuEnPymR/kr5CYEkZEdSmXWJs8jDys3NhlcYNwRJHu
590F2JfnjsLtpgirBJ0Z8vDaTwuolDby+umaHf8ojGb6VwbuEvdh0hvd1ZfY2fg4
bFg0z3NCZLMG74xrJg2zrYd8pi6SJki3ymtvw/eXQplQN6dfmml/WMXIZ+/HSs2V
AkjhK71A/ZMpiAorq4BA1q4/qPNHOw==
=rNm6
-----END PGP SIGNATURE-----

--cB9STJM5vUwXMraG--


