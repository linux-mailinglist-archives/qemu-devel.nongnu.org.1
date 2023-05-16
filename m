Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3A27056D5
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:10:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyzwm-0001io-OI; Tue, 16 May 2023 15:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pyzwk-0001hf-TS
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:02:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pyzwi-00017e-IN
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684263770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XSavnLJy34agtHvxXyiVShndCbcr4jJazu6AYV1BQac=;
 b=TyQL9RBAGHXzgu7zC7j7phD1K0+mrRdy+VNiYtVy9so8RdpAMVbMj9n38qnjd2+h0YqfBK
 0jamgNj3Cu/CuwKb2erCf/iiabthqm9draWkDEB8NT1z3FDr9Z+yOnf4Or7Tfny7KknTys
 1crt6SZfDmB4r5sKmIXhupk2JcLJYuc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-nJeA-3YaMay_1Lj1RYmoHw-1; Tue, 16 May 2023 15:02:47 -0400
X-MC-Unique: nJeA-3YaMay_1Lj1RYmoHw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E45586C60F;
 Tue, 16 May 2023 19:02:46 +0000 (UTC)
Received: from localhost (unknown [10.39.192.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B453C4021D9;
 Tue, 16 May 2023 19:02:44 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Coiby Xu <Coiby.Xu@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>, Peter Xu <peterx@redhat.com>,
 xen-devel@lists.xenproject.org, Kevin Wolf <kwolf@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Julia Suvorova <jusual@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 eesposit@redhat.com, Fam Zheng <fam@euphon.net>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Xie Yongji <xieyongji@bytedance.com>,
 Stefano Garzarella <sgarzare@redhat.com>, qemu-block@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, Paul Durrant <paul@xen.org>,
 Stefan Weil <sw@weilnetz.de>, Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Lieven <pl@kamp.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v6 00/20] block: remove aio_disable_external() API
Date: Tue, 16 May 2023 15:02:18 -0400
Message-Id: <20230516190238.8401-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v6:
- Fix scsi_device_unrealize() -> scsi_qdev_unrealize() mistake in Patch 4
  commit description [Kevin]
- Explain why we don't schedule a BH in .drained_begin() in Patch 16 [Kevin]
- Copy the comment explaining why the event notifier is tested and cleared in
  Patch 16 [Kevin]
- Fix EPOLL_ENABLE_THRESHOLD mismerge in util/fdmon-epoll.c [Kevin]

v5:
- Use atomic accesses for in_flight counter in vhost-user-server.c [Kevin]
- Stash SCSIDevice id/lun values for VIRTIO_SCSI_T_TRANSPORT_RESET event
  before unrealizing the SCSIDevice [Kevin]
- Keep vhost-user-blk export .detach() callback so ctx is set to NULL [Kevin]
- Narrow BdrvChildClass and BlockDriver drained_{begin/end/poll} callbacks from
  IO_OR_GS_CODE() to GLOBAL_STATE_CODE() [Kevin]
- Include Kevin's "block: Fix use after free in blockdev_mark_auto_del()" to
  fix a latent bug that was exposed by this series

v4:
- Remove external_disable_cnt variable [Philippe]
- Add Patch 1 to fix assertion failure in .drained_end() -> blk_get_aio_context()
v3:
- Resend full patch series. v2 was sent in the middle of a git rebase and was
  missing patches. [Eric]
- Apply Reviewed-by tags.
v2:
- Do not rely on BlockBackend request queuing, implement .drained_begin/end()
  instead in xen-block, virtio-blk, and virtio-scsi [Paolo]
- Add qdev_is_realized() API [Philippe]
- Add patch to avoid AioContext lock around blk_exp_ref/unref() [Paolo]
- Add patch to call .drained_begin/end() from main loop thread to simplify
  callback implementations

The aio_disable_external() API temporarily suspends file descriptor monitoring
in the event loop. The block layer uses this to prevent new I/O requests being
submitted from the guest and elsewhere between bdrv_drained_begin() and
bdrv_drained_end().

While the block layer still needs to prevent new I/O requests in drained
sections, the aio_disable_external() API can be replaced with
.drained_begin/end/poll() callbacks that have been added to BdrvChildClass and
BlockDevOps.

This newer .bdrained_begin/end/poll() approach is attractive because it works
without specifying a specific AioContext. The block layer is moving towards
multi-queue and that means multiple AioContexts may be processing I/O
simultaneously.

The aio_disable_external() was always somewhat hacky. It suspends all file
descriptors that were registered with is_external=true, even if they have
nothing to do with the BlockDriverState graph nodes that are being drained.
It's better to solve a block layer problem in the block layer than to have an
odd event loop API solution.

The approach in this patch series is to implement BlockDevOps
.drained_begin/end() callbacks that temporarily stop file descriptor handlers.
This ensures that new I/O requests are not submitted in drained sections.

Stefan Hajnoczi (20):
  block-backend: split blk_do_set_aio_context()
  hw/qdev: introduce qdev_is_realized() helper
  virtio-scsi: avoid race between unplug and transport event
  virtio-scsi: stop using aio_disable_external() during unplug
  util/vhost-user-server: rename refcount to in_flight counter
  block/export: wait for vhost-user-blk requests when draining
  block/export: stop using is_external in vhost-user-blk server
  hw/xen: do not use aio_set_fd_handler(is_external=true) in
    xen_xenstore
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

 hw/block/dataplane/xen-block.h              |   2 +
 include/block/aio.h                         |  57 ---------
 include/block/block_int-common.h            |  90 +++++++-------
 include/block/export.h                      |   2 +
 include/hw/qdev-core.h                      |  17 ++-
 include/hw/scsi/scsi.h                      |  14 +++
 include/qemu/vhost-user-server.h            |   8 +-
 include/sysemu/block-backend-common.h       |  25 ++--
 include/sysemu/block-backend-global-state.h |   1 +
 util/aio-posix.h                            |   1 -
 block.c                                     |   7 --
 block/blkio.c                               |  15 +--
 block/block-backend.c                       |  78 ++++++------
 block/curl.c                                |  10 +-
 block/export/export.c                       |  13 +-
 block/export/fuse.c                         |  56 ++++++++-
 block/export/vduse-blk.c                    | 128 ++++++++++++++------
 block/export/vhost-user-blk-server.c        |  52 +++++++-
 block/io.c                                  |  16 ++-
 block/io_uring.c                            |   4 +-
 block/iscsi.c                               |   3 +-
 block/linux-aio.c                           |   4 +-
 block/nfs.c                                 |   5 +-
 block/nvme.c                                |   8 +-
 block/ssh.c                                 |   4 +-
 block/win32-aio.c                           |   6 +-
 hw/block/dataplane/virtio-blk.c             |  23 +++-
 hw/block/dataplane/xen-block.c              |  42 +++++--
 hw/block/virtio-blk.c                       |  38 +++++-
 hw/block/xen-block.c                        |  24 +++-
 hw/i386/kvm/xen_xenstore.c                  |   2 +-
 hw/scsi/scsi-bus.c                          |  46 ++++++-
 hw/scsi/scsi-disk.c                         |  27 ++++-
 hw/scsi/virtio-scsi-dataplane.c             |  32 +++--
 hw/scsi/virtio-scsi.c                       | 127 ++++++++++++++-----
 hw/virtio/virtio.c                          |   9 +-
 hw/xen/xen-bus.c                            |  11 +-
 io/channel-command.c                        |   6 +-
 io/channel-file.c                           |   3 +-
 io/channel-socket.c                         |   3 +-
 migration/rdma.c                            |  16 +--
 tests/unit/test-aio.c                       |  27 +----
 tests/unit/test-bdrv-drain.c                |  15 +--
 tests/unit/test-fdmon-epoll.c               |  73 -----------
 util/aio-posix.c                            |  20 +--
 util/aio-win32.c                            |   8 +-
 util/async.c                                |   3 +-
 util/fdmon-epoll.c                          |  10 --
 util/fdmon-io_uring.c                       |   8 +-
 util/fdmon-poll.c                           |   3 +-
 util/main-loop.c                            |   7 +-
 util/qemu-coroutine-io.c                    |   7 +-
 util/vhost-user-server.c                    |  33 ++---
 hw/scsi/trace-events                        |   2 +
 tests/unit/meson.build                      |   3 -
 55 files changed, 725 insertions(+), 529 deletions(-)
 delete mode 100644 tests/unit/test-fdmon-epoll.c

-- 
2.40.1


