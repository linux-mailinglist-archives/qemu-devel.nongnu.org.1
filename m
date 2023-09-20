Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 092867A898A
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 18:34:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj08D-0000kb-Lf; Wed, 20 Sep 2023 12:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qj08B-0000kE-8P
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 12:32:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qj086-0007pU-05
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 12:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695227564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wXeh8T4YZ0yNUdk7U915wSZCN9u1UcH8xm+ctaF6z9Y=;
 b=Yo/19rtYQS5EkB8rpTn73EgrEeazRdYDRW/+4GxL7Bz2VoADnDRs6HGglLwEl15LXuX2pa
 4yuk+cTsl9pPYdVa77mpJM/HKfmRHOwcbDSsnnOCT8zRqZP9pe9UHxs8qAV0QrFnu9j581
 bzstFvrLOthvSXyFd6jsDDYioq+veoo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-ZuwgEBWHP7G9l3k4d4H_OA-1; Wed, 20 Sep 2023 12:32:42 -0400
X-MC-Unique: ZuwgEBWHP7G9l3k4d4H_OA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49A8589C6A5;
 Wed, 20 Sep 2023 16:32:42 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC82040C2064;
 Wed, 20 Sep 2023 16:32:41 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL v2 00/28] Block layer patches
Date: Wed, 20 Sep 2023 18:32:35 +0200
Message-ID: <20230920163235.66983-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 4907644841e3200aea6475c0f72d3d987e9f3d93:

  Merge tag 'mem-2023-09-19' of https://github.com/davidhildenbrand/qemu into staging (2023-09-19 13:22:19 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to c428b392590df6364a025d5841e3e8a589ebfd4a:

  block: mark aio_poll as non-coroutine (2023-09-20 17:46:16 +0200)

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

Paolo Bonzini (1):
      block: mark aio_poll as non-coroutine

Stefan Hajnoczi (4):
      block: remove AIOCBInfo->get_aio_context()
      test-bdrv-drain: avoid race with BH in IOThread drain test
      block-backend: process I/O in the current AioContext
      block-backend: process zoned requests in the current AioContext

 qapi/block-core.json                             |   6 +-
 include/block/aio.h                              |   3 +-
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
 scripts/block-coroutine-wrapper.py               |  18 +-
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
 50 files changed, 1375 insertions(+), 1033 deletions(-)


