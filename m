Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B70787169B1
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:34:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42IF-0008CN-FH; Tue, 30 May 2023 12:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42HF-0006NR-H7
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42HD-0008DW-KI
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685464371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/ZVEaORbsfswFMH6Nm45lHBYg9KKsgn1fR1/l8c/vX8=;
 b=UYelmsm1S3/yLrl7lmmEmrKXYuOO5NLcRDSSX9eoAofVmBHAhxTwcSGy6wY7U6TyQInSJR
 CY4Wn6TRS1ZrUO6SYaJ2YTbdiTp9y2lEC+gb6U5aZsvRaDsVUm65gP06YsMiOIv+Bu0l5b
 gQD8gWugFiaPMUmBsjeby9PIKknDlss=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-gKdq8fqHNiSVqvYnG3VwgQ-1; Tue, 30 May 2023 12:32:47 -0400
X-MC-Unique: gKdq8fqHNiSVqvYnG3VwgQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13ED68027F5;
 Tue, 30 May 2023 16:32:47 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B041C154D2;
 Tue, 30 May 2023 16:32:46 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 00/32] Block layer patches
Date: Tue, 30 May 2023 18:32:07 +0200
Message-Id: <20230530163239.576632-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit aa9bbd865502ed517624ab6fe7d4b5d89ca95e43:

  Merge tag 'pull-ppc-20230528' of https://gitlab.com/danielhb/qemu into staging (2023-05-29 14:31:52 -0700)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 60f782b6b78211c125970768be726c9f380dbd61:

  aio: remove aio_disable_external() API (2023-05-30 17:37:26 +0200)

----------------------------------------------------------------
Block layer patches

- Fix blockdev-create with iothreads
- Remove aio_disable_external() API

----------------------------------------------------------------
Kevin Wolf (12):
      block-coroutine-wrapper: Take AioContext lock in no_co_wrappers
      block: Clarify locking rules for bdrv_open(_inherit)()
      block: Take main AioContext lock when calling bdrv_open()
      block-backend: Fix blk_new_open() for iothreads
      mirror: Hold main AioContext lock for calling bdrv_open_backing_file()
      qcow2: Fix open with 'file' in iothread
      raw-format: Fix open with 'file' in iothread
      copy-before-write: Fix open with child in iothread
      block: Take AioContext lock in bdrv_open_driver()
      block: Fix AioContext locking in bdrv_insert_node()
      iotests: Make verify_virtio_scsi_pci_or_ccw() public
      iotests: Test blockdev-create in iothread

Stefan Hajnoczi (20):
      block-backend: split blk_do_set_aio_context()
      hw/qdev: introduce qdev_is_realized() helper
      virtio-scsi: avoid race between unplug and transport event
      virtio-scsi: stop using aio_disable_external() during unplug
      util/vhost-user-server: rename refcount to in_flight counter
      block/export: wait for vhost-user-blk requests when draining
      block/export: stop using is_external in vhost-user-blk server
      hw/xen: do not use aio_set_fd_handler(is_external=true) in xen_xenstore
      block: add blk_in_drain() API
      block: drain from main loop thread in bdrv_co_yield_to_drain()
      xen-block: implement BlockDevOps->drained_begin()
      hw/xen: do not set is_external=true on evtchn fds
      block/export: rewrite vduse-blk drain code
      block/export: don't require AioContext lock around blk_exp_ref/unref()
      block/fuse: do not set is_external=true on FUSE fd
      virtio: make it possible to detach host notifier from any thread
      virtio-blk: implement BlockDevOps->drained_begin()
      virtio-scsi: implement BlockDevOps->drained_begin()
      virtio: do not set is_external=true on host notifiers
      aio: remove aio_disable_external() API

 hw/block/dataplane/xen-block.h                |   2 +
 include/block/aio.h                           |  57 ------------
 include/block/block-common.h                  |   3 +
 include/block/block_int-common.h              |  72 +++++++--------
 include/block/export.h                        |   2 +
 include/hw/qdev-core.h                        |  17 +++-
 include/hw/scsi/scsi.h                        |  14 +++
 include/qemu/vhost-user-server.h              |   8 +-
 include/sysemu/block-backend-common.h         |  25 ++---
 include/sysemu/block-backend-global-state.h   |   1 +
 util/aio-posix.h                              |   1 -
 block.c                                       |  46 ++++++---
 block/blkio.c                                 |  15 +--
 block/block-backend.c                         | 104 ++++++++++++---------
 block/copy-before-write.c                     |  21 ++++-
 block/curl.c                                  |  10 +-
 block/export/export.c                         |  13 ++-
 block/export/fuse.c                           |  56 ++++++++++-
 block/export/vduse-blk.c                      | 128 ++++++++++++++++++--------
 block/export/vhost-user-blk-server.c          |  52 +++++++++--
 block/io.c                                    |  16 ++--
 block/io_uring.c                              |   4 +-
 block/iscsi.c                                 |   3 +-
 block/linux-aio.c                             |   4 +-
 block/mirror.c                                |   6 ++
 block/nfs.c                                   |   5 +-
 block/nvme.c                                  |   8 +-
 block/qapi-sysemu.c                           |   3 +
 block/qcow2.c                                 |   8 +-
 block/raw-format.c                            |   5 +
 block/ssh.c                                   |   4 +-
 block/win32-aio.c                             |   6 +-
 blockdev.c                                    |  29 ++++--
 hw/block/dataplane/virtio-blk.c               |  23 +++--
 hw/block/dataplane/xen-block.c                |  42 ++++++---
 hw/block/virtio-blk.c                         |  38 +++++++-
 hw/block/xen-block.c                          |  24 ++++-
 hw/i386/kvm/xen_xenstore.c                    |   2 +-
 hw/scsi/scsi-bus.c                            |  46 ++++++++-
 hw/scsi/scsi-disk.c                           |  27 +++++-
 hw/scsi/virtio-scsi-dataplane.c               |  32 +++++--
 hw/scsi/virtio-scsi.c                         | 127 +++++++++++++++++++------
 hw/virtio/virtio.c                            |   9 +-
 hw/xen/xen-bus.c                              |  11 ++-
 io/channel-command.c                          |   6 +-
 io/channel-file.c                             |   3 +-
 io/channel-socket.c                           |   3 +-
 migration/rdma.c                              |  16 ++--
 qemu-nbd.c                                    |   4 +
 tests/unit/test-aio.c                         |  27 +-----
 tests/unit/test-bdrv-drain.c                  |  15 +--
 tests/unit/test-block-iothread.c              |   4 +-
 tests/unit/test-fdmon-epoll.c                 |  73 ---------------
 tests/unit/test-nested-aio-poll.c             |   9 +-
 util/aio-posix.c                              |  20 +---
 util/aio-win32.c                              |   8 +-
 util/async.c                                  |   3 +-
 util/fdmon-epoll.c                            |  10 --
 util/fdmon-io_uring.c                         |   8 +-
 util/fdmon-poll.c                             |   3 +-
 util/main-loop.c                              |   7 +-
 util/qemu-coroutine-io.c                      |   7 +-
 util/vhost-user-server.c                      |  33 ++++---
 scripts/block-coroutine-wrapper.py            |  25 +++--
 tests/qemu-iotests/iotests.py                 |   2 +-
 hw/scsi/trace-events                          |   2 +
 tests/qemu-iotests/256                        |   2 +-
 tests/qemu-iotests/tests/iothreads-create     |  67 ++++++++++++++
 tests/qemu-iotests/tests/iothreads-create.out |   4 +
 tests/unit/meson.build                        |   3 -
 70 files changed, 931 insertions(+), 562 deletions(-)
 delete mode 100644 tests/unit/test-fdmon-epoll.c
 create mode 100755 tests/qemu-iotests/tests/iothreads-create
 create mode 100644 tests/qemu-iotests/tests/iothreads-create.out


