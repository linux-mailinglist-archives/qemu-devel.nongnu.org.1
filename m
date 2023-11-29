Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A927FE093
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 20:57:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8QfN-0006uR-V1; Wed, 29 Nov 2023 14:56:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r8QfG-0006ta-DS
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 14:56:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1r8QfD-0004Et-Cn
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 14:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701287761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=e7N4tRDtP2IBzVTMaL8yeWW0d5GyesAwh+oFp0HXr5s=;
 b=Gi9RB8Wsnev5AhMm4EMf2Ok1qinUP2NUZ3B8+jl+UvfuQ1n6gKd16N4t2QFhw5wJeNLrT3
 LAPRSwSStS/gMlkLslanfrPWgXSNPal8EXF5SATP5CST67TSgEPnTIPPZtST6iKpQ5YvNu
 jZyNQXI5NDTDrzM0KYwRTJurKWJ+sqw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-lpKhYjwBNRSAJDcVZt1Ezw-1; Wed,
 29 Nov 2023 14:55:59 -0500
X-MC-Unique: lpKhYjwBNRSAJDcVZt1Ezw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 508B03C02B8C;
 Wed, 29 Nov 2023 19:55:58 +0000 (UTC)
Received: from localhost (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 06D9D1C060B1;
 Wed, 29 Nov 2023 19:55:54 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alberto Garcia <berto@igalia.com>,
 Emanuele Giuseppe Esposito <eesposit@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 <qemu-block@nongnu.org>, xen-devel@lists.xenproject.org,
 Coiby Xu <Coiby.Xu@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Xie Changlong <xiechanglong.d@gmail.com>, Ari Sundholm <ari@tuxera.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Cleber Rosa <crosa@redhat.com>,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Zhang Chen <chen.zhang@intel.com>, Peter Xu <peterx@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Leonardo Bras <leobras@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Fam Zheng <fam@euphon.net>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 00/12] aio: remove AioContext lock
Date: Wed, 29 Nov 2023 14:55:41 -0500
Message-ID: <20231129195553.942921-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series removes the AioContext locking APIs from QEMU.
aio_context_acquire() and aio_context_release() are currently only needed to
support the locking discipline required by AIO_POLL_WHILE() (except for a stray
user that I converted in Patch 1). AIO_POLL_WHILE() doesn't really need the
AioContext lock anymore, so it's possible to remove the API. This is a nice
simplification because the AioContext locking rules were sometimes tricky or
underspecified, leading to many bugs of the years.

This patch series removes these APIs across the codebase and cleans up the
documentation/comments that refers to them.

Patch 1 is a AioContext lock user I forgot to convert in my earlier SCSI
conversion series.

Patch 2 removes tests for the AioContext lock because they will no longer be
needed when the lock is gone.

Patches 3-9 remove the AioContext lock. These can be reviewed by categorizing
the call sites into 1. places that take the lock because they call an API that
requires the lock (ultimately AIO_POLL_WHILE()) and 2. places that take the
lock to protect state. There should be no instances of case 2 left. If you see
one, you've found a bug in this patch series!

Patches 10-12 remove comments.

Based-on: 20231123194931.171598-1-stefanha@redhat.com ("[PATCH 0/4] scsi: eliminate AioContext lock")
Since SCSI needs to stop relying on the AioContext lock before we can remove
the lock.

Stefan Hajnoczi (12):
  virtio-scsi: replace AioContext lock with tmf_bh_lock
  tests: remove aio_context_acquire() tests
  aio: make aio_context_acquire()/aio_context_release() a no-op
  graph-lock: remove AioContext locking
  block: remove AioContext locking
  scsi: remove AioContext locking
  aio-wait: draw equivalence between AIO_WAIT_WHILE() and
    AIO_WAIT_WHILE_UNLOCKED()
  aio: remove aio_context_acquire()/aio_context_release() API
  docs: remove AioContext lock from IOThread docs
  scsi: remove outdated AioContext lock comment
  job: remove outdated AioContext locking comments
  block: remove outdated AioContext locking comments

 docs/devel/multiple-iothreads.txt    |  45 ++--
 include/block/aio-wait.h             |  16 +-
 include/block/aio.h                  |  17 --
 include/block/block-common.h         |   3 -
 include/block/block-global-state.h   |   9 +-
 include/block/block-io.h             |  12 +-
 include/block/block_int-common.h     |   2 -
 include/block/graph-lock.h           |  21 +-
 include/block/snapshot.h             |   2 -
 include/hw/virtio/virtio-scsi.h      |  17 +-
 include/qemu/job.h                   |  20 --
 block.c                              | 357 ++++-----------------------
 block/backup.c                       |   4 +-
 block/blklogwrites.c                 |   8 +-
 block/blkverify.c                    |   4 +-
 block/block-backend.c                |  33 +--
 block/commit.c                       |  16 +-
 block/copy-before-write.c            |  22 +-
 block/export/export.c                |  22 +-
 block/export/vhost-user-blk-server.c |   4 -
 block/graph-lock.c                   |  44 +---
 block/io.c                           |  45 +---
 block/mirror.c                       |  41 +--
 block/monitor/bitmap-qmp-cmds.c      |  20 +-
 block/monitor/block-hmp-cmds.c       |  29 ---
 block/qapi-sysemu.c                  |  27 +-
 block/qapi.c                         |  18 +-
 block/qcow2.c                        |   4 +-
 block/quorum.c                       |   8 +-
 block/raw-format.c                   |   5 -
 block/replication.c                  |  72 +-----
 block/snapshot.c                     |  26 +-
 block/stream.c                       |  12 +-
 block/vmdk.c                         |  20 +-
 block/write-threshold.c              |   6 -
 blockdev.c                           | 315 +++++------------------
 blockjob.c                           |  30 +--
 hw/block/dataplane/virtio-blk.c      |  10 -
 hw/block/dataplane/xen-block.c       |  17 +-
 hw/block/virtio-blk.c                |  45 +---
 hw/core/qdev-properties-system.c     |   9 -
 hw/scsi/scsi-bus.c                   |   2 -
 hw/scsi/scsi-disk.c                  |  29 +--
 hw/scsi/virtio-scsi.c                |  80 +++---
 job.c                                |  16 --
 migration/block.c                    |  33 +--
 migration/migration-hmp-cmds.c       |   3 -
 migration/savevm.c                   |  22 --
 net/colo-compare.c                   |   2 -
 qemu-img.c                           |   4 -
 qemu-io.c                            |  10 +-
 qemu-nbd.c                           |   2 -
 replay/replay-debugging.c            |   4 -
 tests/unit/test-aio.c                |  67 +----
 tests/unit/test-bdrv-drain.c         |  91 ++-----
 tests/unit/test-bdrv-graph-mod.c     |  26 +-
 tests/unit/test-block-iothread.c     |  31 ---
 tests/unit/test-blockjob.c           | 137 ----------
 tests/unit/test-replication.c        |  11 -
 util/async.c                         |  14 --
 util/vhost-user-server.c             |   3 -
 scripts/block-coroutine-wrapper.py   |   7 +-
 tests/qemu-iotests/202               |   2 +-
 tests/qemu-iotests/203               |   3 +-
 tests/tsan/suppressions.tsan         |   1 -
 65 files changed, 324 insertions(+), 1713 deletions(-)

-- 
2.42.0


