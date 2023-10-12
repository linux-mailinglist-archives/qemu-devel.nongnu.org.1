Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA527C7275
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 18:25:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqySm-0003Xu-MY; Thu, 12 Oct 2023 12:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySZ-0003V2-RU
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:22:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qqySO-0000ZB-AC
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 12:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697127758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zI1BdNSDnXLJ+KIo7ZKZF+nLwjkVF36HVd6JtLKzu40=;
 b=AasELvz1dwTZKg9tesaeQoafTqdCZQFEBorNn7j2c0VYa9uFmcxk7//6I5lgkprNctg2O+
 UJJc2XzIt+SC0IkHTe9ERBmZzqR6Vkj9uhYfohr6xUQrYnw6GY3O8PM+E+FuZWWy81bM1t
 UrkXzFTVAwlxZDaXwr9+LZOKf1oiNg4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-eIngYG5yNuS6W-6wobdmjA-1; Thu, 12 Oct 2023 12:22:36 -0400
X-MC-Unique: eIngYG5yNuS6W-6wobdmjA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0BC73C170A2;
 Thu, 12 Oct 2023 16:22:35 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.192.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B47C7202701E;
 Thu, 12 Oct 2023 16:22:34 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 00/26] Block layer patches
Date: Thu, 12 Oct 2023 18:21:58 +0200
Message-ID: <20231012162224.240535-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

The following changes since commit a51e5124a655b3dad80b36b18547cb1eca2c5eb2:

  Merge tag 'pull-omnibus-111023-1' of https://gitlab.com/stsquad/qemu into staging (2023-10-11 09:43:10 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to e6e964b8b021446c8d3d1f91c0208f653e9ec92c:

  block: Add assertion for bdrv_graph_wrlock() (2023-10-12 16:31:33 +0200)

----------------------------------------------------------------
Block layer patches

- Clean up coroutine versions of bdrv_{is_allocated,block_status}*
- Graph locking part 5 (protect children/parent links)

----------------------------------------------------------------
Emanuele Giuseppe Esposito (1):
      block: Mark drain related functions GRAPH_RDLOCK

Kevin Wolf (21):
      test-bdrv-drain: Don't call bdrv_graph_wrlock() in coroutine context
      block-coroutine-wrapper: Add no_co_wrapper_bdrv_rdlock functions
      block: Take graph rdlock in bdrv_inactivate_all()
      block: Mark bdrv_first_blk() and bdrv_is_root_node() GRAPH_RDLOCK
      block: Mark bdrv_parent_cb_resize() and callers GRAPH_RDLOCK
      block: Mark bdrv_snapshot_fallback() and callers GRAPH_RDLOCK
      block: Take graph rdlock in parts of reopen
      block: Mark bdrv_get_xdbg_block_graph() and callers GRAPH_RDLOCK
      block: Mark bdrv_refresh_filename() and callers GRAPH_RDLOCK
      block: Mark bdrv_primary_child() and callers GRAPH_RDLOCK
      block: Mark bdrv_get_parent_name() and callers GRAPH_RDLOCK
      block: Mark bdrv_amend_options() and callers GRAPH_RDLOCK
      qcow2: Mark qcow2_signal_corruption() and callers GRAPH_RDLOCK
      qcow2: Mark qcow2_inactivate() and callers GRAPH_RDLOCK
      qcow2: Mark check_constraints_on_bitmap() GRAPH_RDLOCK
      block: Mark bdrv_op_is_blocked() and callers GRAPH_RDLOCK
      block: Mark bdrv_apply_auto_read_only() and callers GRAPH_RDLOCK
      block: Mark bdrv_get_specific_info() and callers GRAPH_RDLOCK
      block: Protect bs->parents with graph_lock
      block: Protect bs->children with graph_lock
      block: Add assertion for bdrv_graph_wrlock()

Paolo Bonzini (4):
      block: rename the bdrv_co_block_status static function
      block: complete public block status API
      block: switch to co_wrapper for bdrv_is_allocated_*
      block: convert more bdrv_is_allocated* and bdrv_block_status* calls to coroutine versions

 block/qcow2.h                               | 187 ++++++++++++++++------------
 block/vhdx.h                                |   5 +-
 include/block/block-common.h                |   7 +-
 include/block/block-global-state.h          |  34 ++---
 include/block/block-io.h                    |  71 +++++++----
 include/block/block_int-common.h            |  69 +++++-----
 include/block/block_int-io.h                |   7 +-
 include/block/graph-lock.h                  |   3 +-
 include/block/qapi.h                        |  23 ++--
 include/block/snapshot.h                    |  24 ++--
 include/sysemu/block-backend-global-state.h |   4 +-
 block.c                                     | 120 ++++++++++++------
 block/backup.c                              |   1 +
 block/block-backend.c                       |   9 +-
 block/bochs.c                               |   2 +
 block/cloop.c                               |   2 +
 block/commit.c                              |   1 +
 block/copy-before-write.c                   |   2 +-
 block/copy-on-read.c                        |   8 +-
 block/crypto.c                              |   4 +-
 block/curl.c                                |   2 +
 block/dmg.c                                 |   2 +
 block/export/export.c                       |   4 +
 block/gluster.c                             |   2 +
 block/graph-lock.c                          |   3 +-
 block/io.c                                  | 143 ++++++++++-----------
 block/iscsi.c                               |   2 +
 block/mirror.c                              |  10 +-
 block/monitor/block-hmp-cmds.c              |   5 +
 block/nbd.c                                 |   3 +-
 block/nfs.c                                 |   2 +-
 block/parallels.c                           |   3 +
 block/qapi-sysemu.c                         |  11 +-
 block/qapi.c                                |  11 +-
 block/qcow.c                                |   3 +
 block/qcow2-bitmap.c                        |  38 +++---
 block/qcow2-cache.c                         |  11 +-
 block/qcow2-cluster.c                       |  62 ++++-----
 block/qcow2-refcount.c                      |  80 ++++++------
 block/qcow2.c                               |  77 +++++++-----
 block/quorum.c                              |   4 +-
 block/raw-format.c                          |   2 +
 block/rbd.c                                 |   4 +
 block/replication.c                         |  29 +++--
 block/snapshot.c                            |  54 ++++++--
 block/stream.c                              |   8 +-
 block/vdi.c                                 |   3 +
 block/vhdx.c                                |   4 +
 block/vmdk.c                                |  53 +++++---
 block/vpc.c                                 |   3 +
 block/vvfat.c                               |  20 +--
 blockdev.c                                  |  44 +++++++
 blockjob.c                                  |   1 +
 migration/block.c                           |   2 +
 migration/migration-hmp-cmds.c              |   2 +
 qemu-img.c                                  |  16 +++
 qemu-io-cmds.c                              |   3 +
 tests/unit/test-bdrv-drain.c                |  15 ++-
 tests/unit/test-block-iothread.c            |   8 ++
 scripts/block-coroutine-wrapper.py          |  10 +-
 60 files changed, 843 insertions(+), 499 deletions(-)


