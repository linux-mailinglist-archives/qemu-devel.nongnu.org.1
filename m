Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD237C5109
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 13:07:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqX2C-0002Lu-Ag; Wed, 11 Oct 2023 07:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqX27-0002KP-Dq
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 07:05:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqX25-00058C-OB
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 07:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697022340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S8abfVlov8wHY8ZKfgYHPdfGsMHWiME9xzovES7M68Y=;
 b=EIGaKSNduqqOEl7zcdDcfQsBZACs2KlkiIFDabdp2NQXvIh6e/wtjHEtEQ2j7sLgnHGtEB
 qL9gbbpmysRDjBbirLDemDyhI2MG25ivVTjQtfd5IHu67wKrIWcLS8T8xiKHDAyJAwBjut
 +zm1t/wSU3O/2v+KtzL3yxWx8gC/idg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-vB76b9vOPBWRd5_Z-bmRlA-1; Wed, 11 Oct 2023 07:05:28 -0400
X-MC-Unique: vB76b9vOPBWRd5_Z-bmRlA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 782583C0E670;
 Wed, 11 Oct 2023 11:05:28 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 33B9A170E9;
 Wed, 11 Oct 2023 11:05:27 +0000 (UTC)
Date: Wed, 11 Oct 2023 13:05:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, eesposit@redhat.com, eblake@redhat.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru, qemu-devel@nongnu.org
Subject: Re: [PATCH 00/22] block: Graph locking part 5 (protect
 children/parent links)
Message-ID: <ZSaBdqy2zEZtg+dG@redhat.com>
References: <20230929145157.45443-1-kwolf@redhat.com>
 <20231010204850.GA1773699@fedora>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GSE3+uZmnxRTsuxi"
Content-Disposition: inline
In-Reply-To: <20231010204850.GA1773699@fedora>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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


--GSE3+uZmnxRTsuxi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 10.10.2023 um 22:48 hat Stefan Hajnoczi geschrieben:
> On Fri, Sep 29, 2023 at 04:51:35PM +0200, Kevin Wolf wrote:
> > After all the preparation in previous series, this series reaches an
> > important milestone for the graph locking work: TSA can now verify that
> > all accesses to the children and parent lists of nodes happen under the
> > graph lock.
> >=20
> > However, this is not the end of the graph locking work yet. On the one
> > hand, graph locking annotations aren't consistently present on all
> > functions and having an unannotated function in the middle of the call
> > chain means that TSA doesn't check if the locking is consistent (in
> > fact, we know that functions like bdrv_unref() are still called in
> > places where they strictly speaking must not be called).
> >=20
> > On the other hand, the graph consists of more than just the children and
> > parent lists. While it might be possible to convince me that the global
> > node lists (graph_bdrv_states/all_bdrv_states) are safe because
> > iothreads shouldn't access them, at least BlockDriverState.file/backing
> > still need proper locking.
> >=20
> > There may be other fields in BlockDriverState that need to be covered
> > by the lock, too. For example, Stefan said that he would look into
> > annotating BlockLimits accesses to be protected by the graph lock, too.
> >=20
> > Emanuele Giuseppe Esposito (1):
> >   block: Mark drain related functions GRAPH_RDLOCK
> >=20
> > Kevin Wolf (21):
> >   test-bdrv-drain: Don't call bdrv_graph_wrlock() in coroutine context
> >   block-coroutine-wrapper: Add no_co_wrapper_bdrv_rdlock functions
> >   block: Take graph rdlock in bdrv_inactivate_all()
> >   block: Mark bdrv_first_blk() and bdrv_is_root_node() GRAPH_RDLOCK
> >   block: Mark bdrv_parent_cb_resize() and callers GRAPH_RDLOCK
> >   block: Mark bdrv_snapshot_fallback() and callers GRAPH_RDLOCK
> >   block: Take graph rdlock in parts of reopen
> >   block: Mark bdrv_get_xdbg_block_graph() and callers GRAPH_RDLOCK
> >   block: Mark bdrv_refresh_filename() and callers GRAPH_RDLOCK
> >   block: Mark bdrv_primary_child() and callers GRAPH_RDLOCK
> >   block: Mark bdrv_get_parent_name() and callers GRAPH_RDLOCK
> >   block: Mark bdrv_amend_options() and callers GRAPH_RDLOCK
> >   qcow2: Mark qcow2_signal_corruption() and callers GRAPH_RDLOCK
> >   qcow2: Mark qcow2_inactivate() and callers GRAPH_RDLOCK
> >   qcow2: Mark check_constraints_on_bitmap() GRAPH_RDLOCK
> >   block: Mark bdrv_op_is_blocked() and callers GRAPH_RDLOCK
> >   block: Mark bdrv_apply_auto_read_only() and callers GRAPH_RDLOCK
> >   block: Mark bdrv_get_specific_info() and callers GRAPH_RDLOCK
> >   block: Protect bs->parents with graph_lock
> >   block: Protect bs->children with graph_lock
> >   block: Add assertion for bdrv_graph_wrlock()
> >=20
> >  block/qcow2.h                               | 187 ++++++++++++--------
> >  block/vhdx.h                                |   5 +-
> >  include/block/block-common.h                |   7 +-
> >  include/block/block-global-state.h          |  34 ++--
> >  include/block/block-io.h                    |  42 +++--
> >  include/block/block_int-common.h            |  69 ++++----
> >  include/block/block_int-io.h                |   7 +-
> >  include/block/graph-lock.h                  |   3 +-
> >  include/block/qapi.h                        |  23 ++-
> >  include/block/snapshot.h                    |  24 +--
> >  include/sysemu/block-backend-global-state.h |   4 +-
> >  block.c                                     | 120 +++++++++----
> >  block/backup.c                              |   1 +
> >  block/block-backend.c                       |   9 +-
> >  block/bochs.c                               |   2 +
> >  block/cloop.c                               |   2 +
> >  block/commit.c                              |   1 +
> >  block/crypto.c                              |   4 +-
> >  block/curl.c                                |   2 +
> >  block/dmg.c                                 |   2 +
> >  block/export/export.c                       |   4 +
> >  block/gluster.c                             |   2 +
> >  block/graph-lock.c                          |   3 +-
> >  block/io.c                                  |  45 ++++-
> >  block/iscsi.c                               |   2 +
> >  block/monitor/block-hmp-cmds.c              |   5 +
> >  block/nbd.c                                 |   3 +-
> >  block/nfs.c                                 |   2 +-
> >  block/parallels.c                           |   3 +
> >  block/qapi-sysemu.c                         |  11 +-
> >  block/qapi.c                                |  11 +-
> >  block/qcow.c                                |   3 +
> >  block/qcow2-bitmap.c                        |  38 ++--
> >  block/qcow2-cache.c                         |  11 +-
> >  block/qcow2-cluster.c                       |  62 +++----
> >  block/qcow2-refcount.c                      |  80 +++++----
> >  block/qcow2.c                               |  72 +++++---
> >  block/quorum.c                              |   4 +-
> >  block/raw-format.c                          |   2 +
> >  block/rbd.c                                 |   4 +
> >  block/replication.c                         |  21 ++-
> >  block/snapshot.c                            |  54 +++++-
> >  block/vdi.c                                 |   3 +
> >  block/vhdx.c                                |   4 +
> >  block/vmdk.c                                |  53 +++---
> >  block/vpc.c                                 |   3 +
> >  block/vvfat.c                               |   2 +
> >  blockdev.c                                  |  44 +++++
> >  blockjob.c                                  |   1 +
> >  migration/block.c                           |   2 +
> >  migration/migration-hmp-cmds.c              |   2 +
> >  qemu-img.c                                  |  16 ++
> >  qemu-io-cmds.c                              |   3 +
> >  tests/unit/test-bdrv-drain.c                |  15 +-
> >  tests/unit/test-block-iothread.c            |   8 +
> >  scripts/block-coroutine-wrapper.py          |  10 +-
> >  56 files changed, 769 insertions(+), 387 deletions(-)
> >=20
> > --=20
> > 2.41.0
> >=20
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks, applied to the block branch.

Kevin

--GSE3+uZmnxRTsuxi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAmUmgXUACgkQfwmycsiP
L9asyhAAiDTzqI/2qtL5qx6kKTo9GlMIwsDqb1/upLndG1fy0OU5YcYB3ml5yDcm
Us+Z7TNB9UQJxheqO7tMZQiCr/o75h4qHqh/4amcvon5BDB48GWYmZ9GvrKumGxS
HI0PchBcRvsXnRkSxzadZMgrgBOarbc6RckVfQSVdLBORiXBWldM+76xWYW+JarR
6QykxcoiZ9vOs+Zir7TMGjb/rKsr9B3kKAZ7jOPnPk95JUQJVJGL5UFKlCufPqDi
2gVerZO051D2jgpKPH01y+5vVAGoE1hnj5lR7DNqzHXcuyA3JbUzIjwLfX9k6kGc
szNLYQHIC1FBdnTXl2k6KvbQNpY+veQyVgxhksjrXrqcaXEFLT10MlIkrp2ObBo1
YVqKAp6eZvrXnU4vkzFUCAtkEkBszF9YOzvHm5KG0zM2hLdkWfl3mgUTzVdtb71Q
rG3fMXA/v3wwMP/t0InV734ejz1Dvr8nA7ux6ElrhgTYtib7BS3A87WuaXu+DKqA
C9U77Q1+nvjvLw8pi0llNI3HrOOEh9QglgxZyp4Ol7VPbFu+ziThw4YKPta6Rj/W
xlaPwFcpJY2bg2x1CrFegED3E4kQKwJZWfLMNz48beybnIvoPWeJutNZw7x1E7ui
7rRmfZmczED/d3qjXDfiHJ/1aD5XXhCv9kjYX6fx3D1cJrsKawI=
=DFKO
-----END PGP SIGNATURE-----

--GSE3+uZmnxRTsuxi--


