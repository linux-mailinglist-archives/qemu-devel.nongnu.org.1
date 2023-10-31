Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4406C7DD670
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:01:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtxw-0003zP-Mj; Tue, 31 Oct 2023 14:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxt-0003y4-6p
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxV-000663-Vk
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 14:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698778765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cgcMxxquBmLh+QhHbQZUPUsbA6ZZghvmvLdA9q2MD18=;
 b=Tv+kkJAjn+VIqaa1lNZJuggear5goKA4rNj8l4ucrKEfqMole15OQAxiUOb4MBee0JfWEY
 pzcGNbV1oxNO56mQwRfSalb+mJ7OwLoxQbagw7bMNxMSxE7tTnn8WZ891MCV5L3lUPG5rR
 3tQ1GNGGY3N9fE7gDniFcdtwXObUYXk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-zO5O9Za3MmmtSSd7Xk-OPQ-1; Tue,
 31 Oct 2023 14:59:20 -0400
X-MC-Unique: zO5O9Za3MmmtSSd7Xk-OPQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B6C8299E74D;
 Tue, 31 Oct 2023 18:59:20 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0AE49143;
 Tue, 31 Oct 2023 18:59:19 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 00/27] Block layer patches
Date: Tue, 31 Oct 2023 19:58:51 +0100
Message-ID: <20231031185918.346940-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The following changes since commit 516fffc9933cb21fad41ca8f7bf465d238d4d375:

  Merge tag 'pull-lu-20231030' of https://gitlab.com/rth7680/qemu into staging (2023-10-31 07:12:40 +0900)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 900e7d413d630ebd3f5d64bae0e6249621ec0c7f:

  iotests: add test for changing mirror's copy_mode (2023-10-31 19:46:51 +0100)

----------------------------------------------------------------
Block layer patches

- virtio-blk: use blk_io_plug_call() instead of notification BH
- mirror: allow switching from background to active mode
- qemu-img rebase: add compression support
- Fix locking in media change monitor commands
- Fix a few blockjob-related deadlocks when using iothread

----------------------------------------------------------------
Andrey Drobyshev (8):
      qemu-img: rebase: stop when reaching EOF of old backing file
      qemu-iotests: 024: add rebasing test case for overlay_size > backing_size
      qemu-img: rebase: use backing files' BlockBackend for buffer alignment
      qemu-img: add chunk size parameter to compare_buffers()
      qemu-img: rebase: avoid unnecessary COW operations
      iotests/{024, 271}: add testcases for qemu-img rebase
      qemu-img: add compression option to rebase subcommand
      iotests: add tests for "qemu-img rebase" with compression

Fiona Ebner (13):
      blockjob: drop AioContext lock before calling bdrv_graph_wrlock()
      block: avoid potential deadlock during bdrv_graph_wrlock() in bdrv_close()
      blockdev: mirror: avoid potential deadlock when using iothread
      blockjob: introduce block-job-change QMP command
      block/mirror: set actively_synced even after the job is ready
      block/mirror: move dirty bitmap to filter
      block/mirror: determine copy_to_target only once
      mirror: implement mirror_change method
      qapi/block-core: use JobType for BlockJobInfo's type
      qapi/block-core: turn BlockJobInfo into a union
      blockjob: query driver-specific info via a new 'query' driver method
      mirror: return mirror-specific information upon query
      iotests: add test for changing mirror's copy_mode

Kevin Wolf (2):
      block: Fix locking in media change monitor commands
      iotests: Test media change with iothreads

Stefan Hajnoczi (4):
      block: rename blk_io_plug_call() API to defer_call()
      util/defer-call: move defer_call() to util/
      virtio: use defer_call() in virtio_irqfd_notify()
      virtio-blk: remove batch notification BH

 qapi/block-core.json                               |  59 ++++++-
 qapi/job.json                                      |   4 +-
 docs/tools/qemu-img.rst                            |   6 +-
 include/block/blockjob.h                           |  11 ++
 include/block/blockjob_int.h                       |  12 ++
 include/qemu/defer-call.h                          |  16 ++
 include/sysemu/block-backend-io.h                  |   4 -
 block.c                                            |   2 +-
 block/blkio.c                                      |   9 +-
 block/io_uring.c                                   |  11 +-
 block/linux-aio.c                                  |   9 +-
 block/mirror.c                                     | 131 ++++++++++----
 block/monitor/block-hmp-cmds.c                     |   4 +-
 block/nvme.c                                       |   5 +-
 block/plug.c                                       | 159 -----------------
 block/qapi-sysemu.c                                |   5 +
 blockdev.c                                         |  28 ++-
 blockjob.c                                         |  30 +++-
 hw/block/dataplane/virtio-blk.c                    |  48 +----
 hw/block/dataplane/xen-block.c                     |  11 +-
 hw/block/virtio-blk.c                              |   5 +-
 hw/scsi/virtio-scsi.c                              |   7 +-
 hw/virtio/virtio.c                                 |  13 +-
 job.c                                              |   1 +
 qemu-img.c                                         | 136 +++++++++++----
 util/defer-call.c                                  | 156 +++++++++++++++++
 util/thread-pool.c                                 |   5 +
 MAINTAINERS                                        |   3 +-
 block/meson.build                                  |   1 -
 hw/virtio/trace-events                             |   1 +
 qemu-img-cmds.hx                                   |   4 +-
 tests/qemu-iotests/024                             | 117 +++++++++++++
 tests/qemu-iotests/024.out                         |  73 ++++++++
 tests/qemu-iotests/109.out                         |  24 +--
 tests/qemu-iotests/118                             |   6 +-
 tests/qemu-iotests/271                             | 131 ++++++++++++++
 tests/qemu-iotests/271.out                         |  82 +++++++++
 tests/qemu-iotests/314                             | 165 ++++++++++++++++++
 tests/qemu-iotests/314.out                         |  75 ++++++++
 tests/qemu-iotests/tests/mirror-change-copy-mode   | 193 +++++++++++++++++++++
 .../qemu-iotests/tests/mirror-change-copy-mode.out |   5 +
 util/meson.build                                   |   1 +
 42 files changed, 1437 insertions(+), 331 deletions(-)
 create mode 100644 include/qemu/defer-call.h
 delete mode 100644 block/plug.c
 create mode 100644 util/defer-call.c
 create mode 100755 tests/qemu-iotests/314
 create mode 100644 tests/qemu-iotests/314.out
 create mode 100755 tests/qemu-iotests/tests/mirror-change-copy-mode
 create mode 100644 tests/qemu-iotests/tests/mirror-change-copy-mode.out


