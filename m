Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B898479D6C4
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 18:50:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg6aI-0001r4-Ui; Tue, 12 Sep 2023 12:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qg6aG-0001nj-Q0
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:49:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qg6aE-0008Jr-Gn
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:49:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694537389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HaZmlLm5W8ju2qmdQ4Obxq2ahpfyY+Cbhq0SN9qs1bA=;
 b=TDIjsw4Cqm+UfDHqdeBmM2cfqPcna8fIIVRR0LDbQldfcqOlTKZyG9/aY+1Ey39xnu3xzP
 5EtkwNTFMwQUFgtN3CU7MAVKm5YDVxb+eDaqLlQAS0Byvv83ZV6g/t3qBikf+ZUcH2E5dB
 YpcGGydo09tGVbb+2ObemTDP0i2Hru4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-_Z0SrTcLP_2jb3xI47mMSw-1; Tue, 12 Sep 2023 12:49:47 -0400
X-MC-Unique: _Z0SrTcLP_2jb3xI47mMSw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E6DC3C0D184;
 Tue, 12 Sep 2023 16:49:47 +0000 (UTC)
Received: from localhost (unknown [10.39.193.246])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D8DA810F1BE7;
 Tue, 12 Sep 2023 16:49:46 +0000 (UTC)
Date: Tue, 12 Sep 2023 12:49:45 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eblake@redhat.com, eesposit@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 00/21] Graph locking part 4 (node management)
Message-ID: <20230912164945.GF72318@fedora>
References: <20230911094620.45040-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Xo+/MSGjQskSPSz2"
Content-Disposition: inline
In-Reply-To: <20230911094620.45040-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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


--Xo+/MSGjQskSPSz2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 11:45:59AM +0200, Kevin Wolf wrote:
> The previous parts of the graph locking changes focussed mostly on the
> BlockDriver side and taking reader locks while performing I/O. This
> series focusses more on the functions managing the graph structure, i.e
> adding, removing and replacing nodes and updating their permissions.
>=20
> Many of these places actually need to take the writer lock to avoid
> readers seeing an inconsistent half-updated graph state. Therefore
> taking the writer lock is now moved from the very low-level function
> bdrv_replace_child_noperm() into its more high level callers.
>=20
> v2:
> - Patch 5: Improved comments, added one for bdrv_schedule_unref()
>=20
> Kevin Wolf (21):
>   block: Remove unused BlockReopenQueueEntry.perms_checked
>   preallocate: Factor out preallocate_truncate_to_real_size()
>   preallocate: Don't poll during permission updates
>   block: Take AioContext lock for bdrv_append() more consistently
>   block: Introduce bdrv_schedule_unref()
>   block-coroutine-wrapper: Add no_co_wrapper_bdrv_wrlock functions
>   block-coroutine-wrapper: Allow arbitrary parameter names
>   block: Mark bdrv_replace_child_noperm() GRAPH_WRLOCK
>   block: Mark bdrv_replace_child_tran() GRAPH_WRLOCK
>   block: Mark bdrv_attach_child_common() GRAPH_WRLOCK
>   block: Call transaction callbacks with lock held
>   block: Mark bdrv_attach_child() GRAPH_WRLOCK
>   block: Mark bdrv_parent_perms_conflict() and callers GRAPH_RDLOCK
>   block: Mark bdrv_get_cumulative_perm() and callers GRAPH_RDLOCK
>   block: Mark bdrv_child_perm() GRAPH_RDLOCK
>   block: Mark bdrv_parent_cb_change_media() GRAPH_RDLOCK
>   block: Take graph rdlock in bdrv_drop_intermediate()
>   block: Take graph rdlock in bdrv_change_aio_context()
>   block: Mark bdrv_root_unref_child() GRAPH_WRLOCK
>   block: Mark bdrv_unref_child() GRAPH_WRLOCK
>   block: Mark bdrv_add/del_child() and caller GRAPH_WRLOCK
>=20
>  include/block/block-common.h                |   4 +
>  include/block/block-global-state.h          |  30 +-
>  include/block/block_int-common.h            |  34 +-
>  include/block/block_int-global-state.h      |  14 +-
>  include/sysemu/block-backend-global-state.h |   4 +-
>  block.c                                     | 348 ++++++++++++++------
>  block/blklogwrites.c                        |   4 +
>  block/blkverify.c                           |   2 +
>  block/block-backend.c                       |  29 +-
>  block/copy-before-write.c                   |  10 +-
>  block/crypto.c                              |   6 +-
>  block/graph-lock.c                          |  26 +-
>  block/mirror.c                              |   8 +
>  block/preallocate.c                         | 133 +++++---
>  block/qcow2.c                               |   4 +-
>  block/quorum.c                              |  23 +-
>  block/replication.c                         |   9 +
>  block/snapshot.c                            |   2 +
>  block/stream.c                              |  20 +-
>  block/vmdk.c                                |  13 +
>  blockdev.c                                  |  23 +-
>  blockjob.c                                  |   2 +
>  tests/unit/test-bdrv-drain.c                |  23 +-
>  tests/unit/test-bdrv-graph-mod.c            |  20 ++
>  tests/unit/test-block-iothread.c            |   3 +
>  scripts/block-coroutine-wrapper.py          |  18 +-
>  tests/qemu-iotests/051.pc.out               |   6 +-
>  27 files changed, 591 insertions(+), 227 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Xo+/MSGjQskSPSz2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUAlqkACgkQnKSrs4Gr
c8h9+AgAwcGxkpBWIPoyJJznm1yw4T0/VSF/oTEHiJD9eC2SLuRUOSCDghnnEHqI
11gMIsiHY+acuD+0anr5TOGRHvEU79OO+Dt9nMr7YcMkpvlT+j6PYGTchtZqPIT1
KYuRAyb17NZvDREY+unwFS+3e7TxLU8kPtMGo9X5t9CWTm+t3fIjixhm6pyhV8NQ
cilDzhHaFzA7OWC90zgarYbJwEk8dkJTBkhzd07lRd2Ot1pPF6jZd0WlOrS3PYpe
r1CpPFl4ghnbmsmQDmWOpgnMwAZukwySaHtUKJp52vqfu9OyTICU+uJuwP8uv5TR
g5JTAuhRrJvN/ePvPJPWdUZPc6emfQ==
=RjO2
-----END PGP SIGNATURE-----

--Xo+/MSGjQskSPSz2--


