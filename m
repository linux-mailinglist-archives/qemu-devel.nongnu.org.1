Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2047F7A217E
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:51:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhA3D-00009f-56; Fri, 15 Sep 2023 10:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA36-0008TI-OE
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:44:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qhA34-0004uD-4b
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694789036;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GK7vGZ6hE4+M+nUxaEVaySyfliBwgonYT6VNkSKJLnM=;
 b=DFzyN4bjsdWb3cYdcht+eO5lIlxQ+zawKye9KF7tjsEyyDH/ZXEKgBs0SBdX0JX6wK13dw
 RBv+Kc1cA9i64Gw4S5fszFt9uagGSefYpqcNr5X3NIJp3XMJC+7a2JUrs1bcTEt8Jz141W
 nSN4FzqSNh7LBbi1uhEPxrlGwSvLix0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-G5Kkyp1sNO-UFBU87NS96w-1; Fri, 15 Sep 2023 10:43:51 -0400
X-MC-Unique: G5Kkyp1sNO-UFBU87NS96w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB8EE955965;
 Fri, 15 Sep 2023 14:43:48 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.146])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 38A672026D76;
 Fri, 15 Sep 2023 14:43:48 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 00/28] Block layer patches
Date: Fri, 15 Sep 2023 16:43:16 +0200
Message-ID: <20230915144344.238596-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

The following changes since commit 005ad32358f12fe9313a4a01918a55e60d4f39e5:

  Merge tag 'pull-tpm-2023-09-12-3' of https://github.com/stefanberger/qemu-tpm into staging (2023-09-13 13:41:57 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 5d96864b73225ee61b0dad7e928f0cddf14270fc:

  block-coroutine-wrapper: use qemu_get_current_aio_context() (2023-09-15 15:49:14 +0200)

----------------------------------------------------------------
Block layer patches

- Graph locking part 4 (node management)
- qemu-img map: report compressed data blocks
- block-backend: process I/O in the current AioContext

----------------------------------------------------------------
Andrey Drobyshev via (2):
      block: add BDRV_BLOCK_COMPRESSED flag for bdrv_block_status()
      qemu-img: map: report compressed data blocks

Kevin Wolf (21):
      block: Remove unused BlockReopenQueueEntry.perms_checked
      preallocate: Factor out preallocate_truncate_to_real_size()
      preallocate: Don't poll during permission updates
      block: Take AioContext lock for bdrv_append() more consistently
      block: Introduce bdrv_schedule_unref()
      block-coroutine-wrapper: Add no_co_wrapper_bdrv_wrlock functions
      block-coroutine-wrapper: Allow arbitrary parameter names
      block: Mark bdrv_replace_child_noperm() GRAPH_WRLOCK
      block: Mark bdrv_replace_child_tran() GRAPH_WRLOCK
      block: Mark bdrv_attach_child_common() GRAPH_WRLOCK
      block: Call transaction callbacks with lock held
      block: Mark bdrv_attach_child() GRAPH_WRLOCK
      block: Mark bdrv_parent_perms_conflict() and callers GRAPH_RDLOCK
      block: Mark bdrv_get_cumulative_perm() and callers GRAPH_RDLOCK
      block: Mark bdrv_child_perm() GRAPH_RDLOCK
      block: Mark bdrv_parent_cb_change_media() GRAPH_RDLOCK
      block: Take graph rdlock in bdrv_drop_intermediate()
      block: Take graph rdlock in bdrv_change_aio_context()
      block: Mark bdrv_root_unref_child() GRAPH_WRLOCK
      block: Mark bdrv_unref_child() GRAPH_WRLOCK
      block: Mark bdrv_add/del_child() and caller GRAPH_WRLOCK

Stefan Hajnoczi (5):
      block: remove AIOCBInfo->get_aio_context()
      test-bdrv-drain: avoid race with BH in IOThread drain test
      block-backend: process I/O in the current AioContext
      block-backend: process zoned requests in the current AioContext
      block-coroutine-wrapper: use qemu_get_current_aio_context()

 qapi/block-core.json                             |   6 +-
 include/block/aio.h                              |   1 -
 include/block/block-common.h                     |   7 +
 include/block/block-global-state.h               |  32 +-
 include/block/block-io.h                         |   1 -
 include/block/block_int-common.h                 |  34 +-
 include/block/block_int-global-state.h           |  14 +-
 include/sysemu/block-backend-global-state.h      |   4 +-
 block.c                                          | 348 +++++++---
 block/blklogwrites.c                             |   4 +
 block/blkverify.c                                |   2 +
 block/block-backend.c                            |  64 +-
 block/copy-before-write.c                        |  10 +-
 block/crypto.c                                   |   6 +-
 block/graph-lock.c                               |  26 +-
 block/io.c                                       |  23 +-
 block/mirror.c                                   |   8 +
 block/preallocate.c                              | 133 ++--
 block/qcow.c                                     |   5 +-
 block/qcow2.c                                    |   7 +-
 block/quorum.c                                   |  23 +-
 block/replication.c                              |   9 +
 block/snapshot.c                                 |   2 +
 block/stream.c                                   |  20 +-
 block/vmdk.c                                     |  15 +
 blockdev.c                                       |  23 +-
 blockjob.c                                       |   2 +
 hw/nvme/ctrl.c                                   |   7 -
 qemu-img.c                                       |   8 +-
 softmmu/dma-helpers.c                            |   8 -
 tests/unit/test-bdrv-drain.c                     |  31 +-
 tests/unit/test-bdrv-graph-mod.c                 |  20 +
 tests/unit/test-block-iothread.c                 |   3 +
 util/thread-pool.c                               |   8 -
 scripts/block-coroutine-wrapper.py               |  24 +-
 tests/qemu-iotests/051.pc.out                    |   6 +-
 tests/qemu-iotests/122.out                       |  84 +--
 tests/qemu-iotests/146.out                       | 780 +++++++++++------------
 tests/qemu-iotests/154.out                       | 194 +++---
 tests/qemu-iotests/179.out                       | 178 +++---
 tests/qemu-iotests/209.out                       |   4 +-
 tests/qemu-iotests/221.out                       |  16 +-
 tests/qemu-iotests/223.out                       |  60 +-
 tests/qemu-iotests/241.out                       |  10 +-
 tests/qemu-iotests/244.out                       |  24 +-
 tests/qemu-iotests/252.out                       |  10 +-
 tests/qemu-iotests/253.out                       |  20 +-
 tests/qemu-iotests/274.out                       |  48 +-
 tests/qemu-iotests/tests/nbd-qemu-allocation.out |  16 +-
 tests/qemu-iotests/tests/qemu-img-bitmaps.out    |  24 +-
 50 files changed, 1376 insertions(+), 1036 deletions(-)


