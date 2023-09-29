Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F2B7B3622
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:56:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmEr0-0005cy-Kt; Fri, 29 Sep 2023 10:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qmEqy-0005bT-3C
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:52:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qmEqk-0004cI-DQ
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695999128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rlwZSF/IsX8Dmf8DnQIb1An6jYKPJZUxx0AJ5Es2na8=;
 b=FAIMfO4nwsmjDT9fGFt6UDJOsZPKb2blVK0vtqoeggs0Artf/SWv1ooC03fXtayYCFHKaS
 cUfs8daVbrm/7uVkddPf6rS22vTEWM1UFSN6p6GwJGcrUEFY/bcTVkmsymUQIr8/Mypvxo
 yQJEYbKu/wXMETLqw0YJcYtRJfmeX4A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-WSIYXwp8M9e0sjZwjP5aYA-1; Fri, 29 Sep 2023 10:52:04 -0400
X-MC-Unique: WSIYXwp8M9e0sjZwjP5aYA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABAE4101B05C;
 Fri, 29 Sep 2023 14:52:03 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 401EA2026D68;
 Fri, 29 Sep 2023 14:52:02 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eesposit@redhat.com,
 eblake@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH 00/22] block: Graph locking part 5 (protect children/parent
 links)
Date: Fri, 29 Sep 2023 16:51:35 +0200
Message-ID: <20230929145157.45443-1-kwolf@redhat.com>
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
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

After all the preparation in previous series, this series reaches an
important milestone for the graph locking work: TSA can now verify that
all accesses to the children and parent lists of nodes happen under the
graph lock.

However, this is not the end of the graph locking work yet. On the one
hand, graph locking annotations aren't consistently present on all
functions and having an unannotated function in the middle of the call
chain means that TSA doesn't check if the locking is consistent (in
fact, we know that functions like bdrv_unref() are still called in
places where they strictly speaking must not be called).

On the other hand, the graph consists of more than just the children and
parent lists. While it might be possible to convince me that the global
node lists (graph_bdrv_states/all_bdrv_states) are safe because
iothreads shouldn't access them, at least BlockDriverState.file/backing
still need proper locking.

There may be other fields in BlockDriverState that need to be covered
by the lock, too. For example, Stefan said that he would look into
annotating BlockLimits accesses to be protected by the graph lock, too.

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

 block/qcow2.h                               | 187 ++++++++++++--------
 block/vhdx.h                                |   5 +-
 include/block/block-common.h                |   7 +-
 include/block/block-global-state.h          |  34 ++--
 include/block/block-io.h                    |  42 +++--
 include/block/block_int-common.h            |  69 ++++----
 include/block/block_int-io.h                |   7 +-
 include/block/graph-lock.h                  |   3 +-
 include/block/qapi.h                        |  23 ++-
 include/block/snapshot.h                    |  24 +--
 include/sysemu/block-backend-global-state.h |   4 +-
 block.c                                     | 120 +++++++++----
 block/backup.c                              |   1 +
 block/block-backend.c                       |   9 +-
 block/bochs.c                               |   2 +
 block/cloop.c                               |   2 +
 block/commit.c                              |   1 +
 block/crypto.c                              |   4 +-
 block/curl.c                                |   2 +
 block/dmg.c                                 |   2 +
 block/export/export.c                       |   4 +
 block/gluster.c                             |   2 +
 block/graph-lock.c                          |   3 +-
 block/io.c                                  |  45 ++++-
 block/iscsi.c                               |   2 +
 block/monitor/block-hmp-cmds.c              |   5 +
 block/nbd.c                                 |   3 +-
 block/nfs.c                                 |   2 +-
 block/parallels.c                           |   3 +
 block/qapi-sysemu.c                         |  11 +-
 block/qapi.c                                |  11 +-
 block/qcow.c                                |   3 +
 block/qcow2-bitmap.c                        |  38 ++--
 block/qcow2-cache.c                         |  11 +-
 block/qcow2-cluster.c                       |  62 +++----
 block/qcow2-refcount.c                      |  80 +++++----
 block/qcow2.c                               |  72 +++++---
 block/quorum.c                              |   4 +-
 block/raw-format.c                          |   2 +
 block/rbd.c                                 |   4 +
 block/replication.c                         |  21 ++-
 block/snapshot.c                            |  54 +++++-
 block/vdi.c                                 |   3 +
 block/vhdx.c                                |   4 +
 block/vmdk.c                                |  53 +++---
 block/vpc.c                                 |   3 +
 block/vvfat.c                               |   2 +
 blockdev.c                                  |  44 +++++
 blockjob.c                                  |   1 +
 migration/block.c                           |   2 +
 migration/migration-hmp-cmds.c              |   2 +
 qemu-img.c                                  |  16 ++
 qemu-io-cmds.c                              |   3 +
 tests/unit/test-bdrv-drain.c                |  15 +-
 tests/unit/test-block-iothread.c            |   8 +
 scripts/block-coroutine-wrapper.py          |  10 +-
 56 files changed, 769 insertions(+), 387 deletions(-)

-- 
2.41.0


