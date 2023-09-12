Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5831479D6BD
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 18:50:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg6Zq-0001WW-Q3; Tue, 12 Sep 2023 12:49:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qg6Zm-0001WF-J5
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:49:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qg6Zk-0008GV-FI
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694537359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CELrit8LQidlldONV5d3vjwjILq7oU6CMUJspBHw9NA=;
 b=BaTEegQy49kaV0aXahSKIHgBzGS+gug5xXCe4s7JuQxHOM1YMG/yAF3/ElwsyN/6f9ewne
 qrZWizjKh3S4S7X60HqDgle8y5zGaUqrY1S6keS76uFTisMXdUZ0NSUVAVA/Uv6030PSty
 hJbaynqjtPHQC2ptxZyfoJb1JaHRCOU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-ERZazKk2N42wGQVuGzwspQ-1; Tue, 12 Sep 2023 12:49:16 -0400
X-MC-Unique: ERZazKk2N42wGQVuGzwspQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD7F929AB44F;
 Tue, 12 Sep 2023 16:49:15 +0000 (UTC)
Received: from localhost (unknown [10.39.193.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCEC564671;
 Tue, 12 Sep 2023 16:49:14 +0000 (UTC)
Date: Tue, 12 Sep 2023 12:49:13 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 05/21] block: Introduce bdrv_schedule_unref()
Message-ID: <20230912164913.GC72318@fedora>
References: <20230911094620.45040-1-kwolf@redhat.com>
 <20230911094620.45040-6-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jJE8va5yBU/dpWzX"
Content-Disposition: inline
In-Reply-To: <20230911094620.45040-6-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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


--jJE8va5yBU/dpWzX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 11:46:04AM +0200, Kevin Wolf wrote:
> bdrv_unref() is called by a lot of places that need to hold the graph
> lock (it naturally happens in the context of operations that change the
> graph). However, bdrv_unref() takes the graph writer lock internally, so
> it can't actually be called while already holding a graph lock without
> causing a deadlock.
>=20
> bdrv_unref() also can't just become GRAPH_WRLOCK because it drains the
> node before closing it, and draining requires that the graph is
> unlocked.
>=20
> The solution is to defer deleting the node until we don't hold the lock
> any more and draining is possible again.
>=20
> Note that keeping images open for longer than necessary can create
> problems, too: You can't open an image again before it is really closed
> (if image locking didn't prevent it, it would cause corruption).
> Reopening an image immediately happens at least during bdrv_open() and
> bdrv_co_create().
>=20
> In order to solve this problem, make sure to run the deferred unref in
> bdrv_graph_wrunlock(), i.e. the first possible place where we can drain
> again. This is also why bdrv_schedule_unref() is marked GRAPH_WRLOCK.
>=20
> The output of iotest 051 is updated because the additional polling
> changes the order of HMP output, resulting in a new "(qemu)" prompt in
> the test output that was previously on a separate line and filtered out.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/block-global-state.h |  1 +
>  block.c                            | 17 +++++++++++++++++
>  block/graph-lock.c                 | 26 +++++++++++++++++++-------
>  tests/qemu-iotests/051.pc.out      |  6 +++---
>  4 files changed, 40 insertions(+), 10 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--jJE8va5yBU/dpWzX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUAlokACgkQnKSrs4Gr
c8j4GAf8Dw/6XtT2OqPzbTfRYNyDCTQFrfR+IqPUstpBhggX8AzIrKpUGtfO6df1
fDRjnsF2Df3QHD0so36zDml8/sVSgkyr3LVKIWE1OE3VD6KYv2pCFLNIGCsXJDzr
fX12CGkNFl6ym2I3angVUEcLALYbPdYwvK0YOWegrHqRjbMTVDlipO4OK+T6YRrS
j5YEyfJ9g8IdTNJJK3I0QzjTviNm8N7rDAvh5alg186Gg6nruxGJvoQU0Js/+E4M
BBVhwqW/WQkVJg7J/URh/q1ptPOPLMGBIAln6v35anYXgv0SdS3oEs4iiJoKEohw
Sx2ktAqiT8L6jqGTQz4NtclGVJUrFQ==
=uYw/
-----END PGP SIGNATURE-----

--jJE8va5yBU/dpWzX--


