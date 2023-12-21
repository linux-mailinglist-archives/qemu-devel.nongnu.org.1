Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD1981BFF9
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 22:24:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGQWO-0006QF-Fk; Thu, 21 Dec 2023 16:24:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQWI-0006OH-BF
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:23:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQWG-0007wZ-J0
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:23:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703193831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=qp1f51rWKzEIhO+xL4VcGnC7xCRoL/YiIKqa9ZyNYEs=;
 b=UGZYlhVnymk2Gg6liciC35BBmaf3WLOzkgjzXq5pFrOSL9pLNBe1FMT6SxrTtDUyxhMfTZ
 6Y1NasNyUUDrfIxXZcDnq393mGKgVGkJCVo36Qh9dtowuI8VUCyBqGXwsG23jYPSUoaVgQ
 7kc08TGJt5UtOcG64P/P8nQS9a5HKrE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-Yk0YBQTvOxKx8oTJUara9A-1; Thu,
 21 Dec 2023 16:23:48 -0500
X-MC-Unique: Yk0YBQTvOxKx8oTJUara9A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F77D3806069;
 Thu, 21 Dec 2023 21:23:48 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D55EC15968;
 Thu, 21 Dec 2023 21:23:45 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 00/33] Block layer patches
Date: Thu, 21 Dec 2023 22:23:05 +0100
Message-ID: <20231221212339.164439-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The following changes since commit 191710c221f65b1542f6ea7fa4d30dde6e134fd7:

  Merge tag 'pull-request-2023-12-20' of https://gitlab.com/thuth/qemu into staging (2023-12-20 09:40:16 -0500)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to ec25ed82df474caea009df2ef948bfed4e6d81fd:

  virtio-blk: add iothread-vq-mapping parameter (2023-12-21 22:00:38 +0100)

----------------------------------------------------------------
Block layer patches

- virtio-blk: Multiqueue support (configurable iothread per queue)
- Made NBD export and hw/scsi thread-safe without AioContext lock
- Fix crash when loading snapshot on inactive node

----------------------------------------------------------------
Kevin Wolf (3):
      block: Fix crash when loading snapshot on inactive node
      vl: Improve error message for conflicting -incoming and -loadvm
      iotests: Basic tests for internal snapshots

Stefan Hajnoczi (30):
      nbd/server: avoid per-NBDRequest nbd_client_get/put()
      nbd/server: only traverse NBDExport->clients from main loop thread
      nbd/server: introduce NBDClient->lock to protect fields
      block/file-posix: set up Linux AIO and io_uring in the current thread
      virtio-blk: add lock to protect s->rq
      virtio-blk: don't lock AioContext in the completion code path
      virtio-blk: don't lock AioContext in the submission code path
      scsi: only access SCSIDevice->requests from one thread
      virtio-scsi: don't lock AioContext around virtio_queue_aio_attach_host_notifier()
      scsi: don't lock AioContext in I/O code path
      dma-helpers: don't lock AioContext in dma_blk_cb()
      virtio-scsi: replace AioContext lock with tmf_bh_lock
      scsi: assert that callbacks run in the correct AioContext
      tests: remove aio_context_acquire() tests
      aio: make aio_context_acquire()/aio_context_release() a no-op
      graph-lock: remove AioContext locking
      block: remove AioContext locking
      block: remove bdrv_co_lock()
      scsi: remove AioContext locking
      aio-wait: draw equivalence between AIO_WAIT_WHILE() and AIO_WAIT_WHILE_UNLOCKED()
      aio: remove aio_context_acquire()/aio_context_release() API
      docs: remove AioContext lock from IOThread docs
      scsi: remove outdated AioContext lock comment
      job: remove outdated AioContext locking comments
      block: remove outdated AioContext locking comments
      block-coroutine-wrapper: use qemu_get_current_aio_context()
      string-output-visitor: show structs as "<omitted>"
      qdev-properties: alias all object class properties
      qdev: add IOThreadVirtQueueMappingList property type
      virtio-blk: add iothread-vq-mapping parameter

 qapi/virtio.json                                   |  29 ++
 docs/devel/multiple-iothreads.txt                  |  47 +--
 hw/block/dataplane/virtio-blk.h                    |   3 +
 include/block/aio-wait.h                           |  16 +-
 include/block/aio.h                                |  17 -
 include/block/block-common.h                       |   3 -
 include/block/block-global-state.h                 |  23 +-
 include/block/block-io.h                           |  12 +-
 include/block/block_int-common.h                   |   2 -
 include/block/graph-lock.h                         |  21 +-
 include/block/snapshot.h                           |   2 -
 include/hw/qdev-properties-system.h                |   5 +
 include/hw/qdev-properties.h                       |   4 +-
 include/hw/scsi/scsi.h                             |   7 +-
 include/hw/virtio/virtio-blk.h                     |   5 +-
 include/hw/virtio/virtio-scsi.h                    |  17 +-
 include/qapi/string-output-visitor.h               |   6 +-
 include/qemu/job.h                                 |  20 --
 block.c                                            | 363 +++------------------
 block/backup.c                                     |   4 +-
 block/blklogwrites.c                               |   8 +-
 block/blkverify.c                                  |   4 +-
 block/block-backend.c                              |  33 +-
 block/commit.c                                     |  16 +-
 block/copy-before-write.c                          |  22 +-
 block/export/export.c                              |  22 +-
 block/export/vhost-user-blk-server.c               |   4 -
 block/file-posix.c                                 |  99 +++---
 block/graph-lock.c                                 |  44 +--
 block/io.c                                         |  45 +--
 block/mirror.c                                     |  41 +--
 block/monitor/bitmap-qmp-cmds.c                    |  20 +-
 block/monitor/block-hmp-cmds.c                     |  29 --
 block/qapi-sysemu.c                                |  27 +-
 block/qapi.c                                       |  18 +-
 block/qcow2.c                                      |   4 +-
 block/quorum.c                                     |   8 +-
 block/raw-format.c                                 |   5 -
 block/replication.c                                |  72 +---
 block/snapshot.c                                   |  30 +-
 block/stream.c                                     |  12 +-
 block/vmdk.c                                       |  20 +-
 block/write-threshold.c                            |   6 -
 blockdev.c                                         | 320 ++++--------------
 blockjob.c                                         |  30 +-
 hw/block/dataplane/virtio-blk.c                    | 165 +++++++---
 hw/block/dataplane/xen-block.c                     |  17 +-
 hw/block/virtio-blk.c                              | 209 +++++++-----
 hw/core/qdev-properties-system.c                   |  55 +++-
 hw/core/qdev-properties.c                          |  18 +-
 hw/scsi/scsi-bus.c                                 | 183 +++++++----
 hw/scsi/scsi-disk.c                                |  67 +---
 hw/scsi/scsi-generic.c                             |  20 +-
 hw/scsi/virtio-scsi-dataplane.c                    |   8 +-
 hw/scsi/virtio-scsi.c                              |  80 ++---
 job.c                                              |  16 -
 migration/block.c                                  |  34 +-
 migration/migration-hmp-cmds.c                     |   3 -
 migration/savevm.c                                 |  22 --
 nbd/server.c                                       | 208 +++++++++---
 net/colo-compare.c                                 |   2 -
 qapi/string-output-visitor.c                       |  16 +
 qemu-img.c                                         |   4 -
 qemu-io.c                                          |  10 +-
 qemu-nbd.c                                         |   2 -
 replay/replay-debugging.c                          |   4 -
 system/dma-helpers.c                               |  10 +-
 system/vl.c                                        |   4 +
 tests/unit/test-aio.c                              |  67 +---
 tests/unit/test-bdrv-drain.c                       |  91 ++----
 tests/unit/test-bdrv-graph-mod.c                   |  26 +-
 tests/unit/test-block-iothread.c                   |  31 --
 tests/unit/test-blockjob.c                         | 137 --------
 tests/unit/test-replication.c                      |  11 -
 util/async.c                                       |  14 -
 util/vhost-user-server.c                           |   3 -
 scripts/block-coroutine-wrapper.py                 |  13 +-
 tests/qemu-iotests/202                             |   2 +-
 tests/qemu-iotests/203                             |   3 +-
 tests/qemu-iotests/tests/qcow2-internal-snapshots  | 170 ++++++++++
 .../tests/qcow2-internal-snapshots.out             | 107 ++++++
 tests/tsan/suppressions.tsan                       |   1 -
 82 files changed, 1337 insertions(+), 2041 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/qcow2-internal-snapshots
 create mode 100644 tests/qemu-iotests/tests/qcow2-internal-snapshots.out


