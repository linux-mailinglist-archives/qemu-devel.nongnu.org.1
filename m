Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9607C41E3
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 22:50:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqJfE-0003Bk-Dz; Tue, 10 Oct 2023 16:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qqJfB-0003BP-VQ
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 16:49:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qqJfA-0008Hm-0i
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 16:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696970946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z42iQUtHsDbYCHpgwAn2M3ENqXGukdvGbunAPYmKDEI=;
 b=T9GwRbhbbGSxzMaMgj1ZTDLs4mAHdZNQ5khFoM4nKKJEJ3U0n1X9A8mtFMrq8gxdn1UGSd
 98/fm+WDYe7b+xEB/W651tVrs9Vb0RpOklxI/Ru3E4eV9DzRzGtRz5K57YkYP/9P7QZZto
 pttXfwDp2qbKqA77sYb/zMcpsDHR5kM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-4RcxTcpXOBOyyI7tjCNUgA-1; Tue, 10 Oct 2023 16:49:02 -0400
X-MC-Unique: 4RcxTcpXOBOyyI7tjCNUgA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 83728185A7B9;
 Tue, 10 Oct 2023 20:49:01 +0000 (UTC)
Received: from localhost (unknown [10.39.192.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF4ED9A;
 Tue, 10 Oct 2023 20:49:00 +0000 (UTC)
Date: Tue, 10 Oct 2023 16:48:50 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, eesposit@redhat.com, eblake@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 00/22] block: Graph locking part 5 (protect
 children/parent links)
Message-ID: <20231010204850.GA1773699@fedora>
References: <20230929145157.45443-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9AtoWk19vuXkOAYL"
Content-Disposition: inline
In-Reply-To: <20230929145157.45443-1-kwolf@redhat.com>
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


--9AtoWk19vuXkOAYL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2023 at 04:51:35PM +0200, Kevin Wolf wrote:
> After all the preparation in previous series, this series reaches an
> important milestone for the graph locking work: TSA can now verify that
> all accesses to the children and parent lists of nodes happen under the
> graph lock.
>=20
> However, this is not the end of the graph locking work yet. On the one
> hand, graph locking annotations aren't consistently present on all
> functions and having an unannotated function in the middle of the call
> chain means that TSA doesn't check if the locking is consistent (in
> fact, we know that functions like bdrv_unref() are still called in
> places where they strictly speaking must not be called).
>=20
> On the other hand, the graph consists of more than just the children and
> parent lists. While it might be possible to convince me that the global
> node lists (graph_bdrv_states/all_bdrv_states) are safe because
> iothreads shouldn't access them, at least BlockDriverState.file/backing
> still need proper locking.
>=20
> There may be other fields in BlockDriverState that need to be covered
> by the lock, too. For example, Stefan said that he would look into
> annotating BlockLimits accesses to be protected by the graph lock, too.
>=20
> Emanuele Giuseppe Esposito (1):
>   block: Mark drain related functions GRAPH_RDLOCK
>=20
> Kevin Wolf (21):
>   test-bdrv-drain: Don't call bdrv_graph_wrlock() in coroutine context
>   block-coroutine-wrapper: Add no_co_wrapper_bdrv_rdlock functions
>   block: Take graph rdlock in bdrv_inactivate_all()
>   block: Mark bdrv_first_blk() and bdrv_is_root_node() GRAPH_RDLOCK
>   block: Mark bdrv_parent_cb_resize() and callers GRAPH_RDLOCK
>   block: Mark bdrv_snapshot_fallback() and callers GRAPH_RDLOCK
>   block: Take graph rdlock in parts of reopen
>   block: Mark bdrv_get_xdbg_block_graph() and callers GRAPH_RDLOCK
>   block: Mark bdrv_refresh_filename() and callers GRAPH_RDLOCK
>   block: Mark bdrv_primary_child() and callers GRAPH_RDLOCK
>   block: Mark bdrv_get_parent_name() and callers GRAPH_RDLOCK
>   block: Mark bdrv_amend_options() and callers GRAPH_RDLOCK
>   qcow2: Mark qcow2_signal_corruption() and callers GRAPH_RDLOCK
>   qcow2: Mark qcow2_inactivate() and callers GRAPH_RDLOCK
>   qcow2: Mark check_constraints_on_bitmap() GRAPH_RDLOCK
>   block: Mark bdrv_op_is_blocked() and callers GRAPH_RDLOCK
>   block: Mark bdrv_apply_auto_read_only() and callers GRAPH_RDLOCK
>   block: Mark bdrv_get_specific_info() and callers GRAPH_RDLOCK
>   block: Protect bs->parents with graph_lock
>   block: Protect bs->children with graph_lock
>   block: Add assertion for bdrv_graph_wrlock()
>=20
>  block/qcow2.h                               | 187 ++++++++++++--------
>  block/vhdx.h                                |   5 +-
>  include/block/block-common.h                |   7 +-
>  include/block/block-global-state.h          |  34 ++--
>  include/block/block-io.h                    |  42 +++--
>  include/block/block_int-common.h            |  69 ++++----
>  include/block/block_int-io.h                |   7 +-
>  include/block/graph-lock.h                  |   3 +-
>  include/block/qapi.h                        |  23 ++-
>  include/block/snapshot.h                    |  24 +--
>  include/sysemu/block-backend-global-state.h |   4 +-
>  block.c                                     | 120 +++++++++----
>  block/backup.c                              |   1 +
>  block/block-backend.c                       |   9 +-
>  block/bochs.c                               |   2 +
>  block/cloop.c                               |   2 +
>  block/commit.c                              |   1 +
>  block/crypto.c                              |   4 +-
>  block/curl.c                                |   2 +
>  block/dmg.c                                 |   2 +
>  block/export/export.c                       |   4 +
>  block/gluster.c                             |   2 +
>  block/graph-lock.c                          |   3 +-
>  block/io.c                                  |  45 ++++-
>  block/iscsi.c                               |   2 +
>  block/monitor/block-hmp-cmds.c              |   5 +
>  block/nbd.c                                 |   3 +-
>  block/nfs.c                                 |   2 +-
>  block/parallels.c                           |   3 +
>  block/qapi-sysemu.c                         |  11 +-
>  block/qapi.c                                |  11 +-
>  block/qcow.c                                |   3 +
>  block/qcow2-bitmap.c                        |  38 ++--
>  block/qcow2-cache.c                         |  11 +-
>  block/qcow2-cluster.c                       |  62 +++----
>  block/qcow2-refcount.c                      |  80 +++++----
>  block/qcow2.c                               |  72 +++++---
>  block/quorum.c                              |   4 +-
>  block/raw-format.c                          |   2 +
>  block/rbd.c                                 |   4 +
>  block/replication.c                         |  21 ++-
>  block/snapshot.c                            |  54 +++++-
>  block/vdi.c                                 |   3 +
>  block/vhdx.c                                |   4 +
>  block/vmdk.c                                |  53 +++---
>  block/vpc.c                                 |   3 +
>  block/vvfat.c                               |   2 +
>  blockdev.c                                  |  44 +++++
>  blockjob.c                                  |   1 +
>  migration/block.c                           |   2 +
>  migration/migration-hmp-cmds.c              |   2 +
>  qemu-img.c                                  |  16 ++
>  qemu-io-cmds.c                              |   3 +
>  tests/unit/test-bdrv-drain.c                |  15 +-
>  tests/unit/test-block-iothread.c            |   8 +
>  scripts/block-coroutine-wrapper.py          |  10 +-
>  56 files changed, 769 insertions(+), 387 deletions(-)
>=20
> --=20
> 2.41.0
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--9AtoWk19vuXkOAYL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmUluLIACgkQnKSrs4Gr
c8igNggApnAvx7ABXWzDpRXyCU8X600H2No5ju4oox4ta8q6UYdG3e6GyNqa0hT8
4oMoCPFlWgohM46FcZVwRWrw31hEe1qKPEXQqnGIDfueG7ZcYtXqbMFG1ehfngA8
aVh1KEWnEjAgwRIAcgf0O5zcsyVZzOinOi/+4RX92Yb0JcWNXnp1VjL2mXIbfyJb
mF2InulavPerTblRDeRnjYu1nt153nIzXPUh6iSzYy94FlcsW3TgsCSbQbugIeTJ
T4yJHP4TYRrsicUK8N6WOKMIUJxqNLf10fAIQBWZ4rYsU+sE9UE76Vw+SI8EumBR
GElNmQnFwF22uVHfnWl7X6ntD6jPrg==
=+67U
-----END PGP SIGNATURE-----

--9AtoWk19vuXkOAYL--


