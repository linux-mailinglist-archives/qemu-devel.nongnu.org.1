Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 471C8832EB3
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 19:14:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQtNJ-0001fS-Vz; Fri, 19 Jan 2024 13:13:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQtN7-0001co-5I
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 13:13:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQtN3-0007XV-L2
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 13:13:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705688016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PofK26JdzK5yEmzKST/4dzLzGxSot7WCmxe7ZeSLozg=;
 b=hG5zamysFi38ni1hxFE5YxsCM/8AtUJWQClkNbVfganOj1KUcvCVIsPr1MKwDIw159vo+Y
 ubx+hefBpTqOlhNDLiPR56iMKuknuOyufVmtO/h46z6BEE5ysctfrGmoGDL4LauWg6ByHF
 iDRWwhie5ClHqB/kc9GF0sYz3/iR/dM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-R3s89plzPviB58bn6xO7Gw-1; Fri,
 19 Jan 2024 13:13:33 -0500
X-MC-Unique: R3s89plzPviB58bn6xO7Gw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF29B3C11CE4;
 Fri, 19 Jan 2024 18:13:32 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DCB9494;
 Fri, 19 Jan 2024 18:13:32 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 00/14] Block layer patches
Date: Fri, 19 Jan 2024 19:13:13 +0100
Message-ID: <20240119181327.236745-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 3f2a357b95845ea0bf7463eff6661e43b97d1afc:

  Merge tag 'hw-cpus-20240119' of https://github.com/philmd/qemu into staging (2024-01-19 11:39:38 +0000)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to ced0d71c5270bed828ed2bd4b116ddfb12862bf9:

  block/blklogwrites: Protect mutable driver state with a mutex. (2024-01-19 18:45:44 +0100)

----------------------------------------------------------------
Block layer patches

- virtio-blk: Multiqueue fixes and cleanups
- blklogwrites: Fixes for write_zeroes and superblock update races
- commit/stream: Allow users to request only format driver names in
  backing file format
- monitor: only run coroutine commands in qemu_aio_context

----------------------------------------------------------------
Ari Sundholm (2):
      block/blklogwrites: Fix a bug when logging "write zeroes" operations.
      block/blklogwrites: Protect mutable driver state with a mutex.

Kevin Wolf (1):
      string-output-visitor: Fix (pseudo) struct handling

Peter Krempa (2):
      commit: Allow users to request only format driver names in backing file format
      stream: Allow users to request only format driver names in backing file format

Stefan Hajnoczi (9):
      iotests: add filter_qmp_generated_node_ids()
      iotests: port 141 to Python for reliable QMP testing
      monitor: only run coroutine commands in qemu_aio_context
      virtio-blk: move dataplane code into virtio-blk.c
      virtio-blk: rename dataplane create/destroy functions
      virtio-blk: rename dataplane to ioeventfd
      virtio-blk: restart s->rq reqs in vq AioContexts
      virtio-blk: tolerate failure to set BlockBackend AioContext
      virtio-blk: always set ioeventfd during startup

 qapi/block-core.json                          |  17 +-
 hw/block/dataplane/trace.h                    |   1 -
 hw/block/dataplane/virtio-blk.h               |  34 ---
 include/block/block-global-state.h            |   3 +-
 include/block/block_int-common.h              |   4 +-
 include/block/block_int-global-state.h        |   6 +
 include/hw/virtio/virtio-blk.h                |  16 +-
 block.c                                       |  37 ++-
 block/blklogwrites.c                          | 120 ++++++--
 block/commit.c                                |   6 +-
 block/monitor/block-hmp-cmds.c                |   2 +-
 block/stream.c                                |  10 +-
 blockdev.c                                    |  13 +
 hw/block/dataplane/virtio-blk.c               | 404 -------------------------
 hw/block/virtio-blk.c                         | 412 ++++++++++++++++++++++++--
 monitor/qmp.c                                 |  17 --
 qapi/qmp-dispatch.c                           |  24 +-
 qapi/string-output-visitor.c                  |  46 +++
 tests/unit/test-bdrv-drain.c                  |   3 +-
 tests/qemu-iotests/iotests.py                 |   7 +
 hw/block/dataplane/meson.build                |   1 -
 hw/block/dataplane/trace-events               |   5 -
 meson.build                                   |   1 -
 tests/qemu-iotests/060.out                    |   4 +-
 tests/qemu-iotests/071.out                    |   4 +-
 tests/qemu-iotests/081.out                    |  16 +-
 tests/qemu-iotests/087.out                    |  12 +-
 tests/qemu-iotests/108.out                    |   2 +-
 tests/qemu-iotests/109                        |   4 +-
 tests/qemu-iotests/109.out                    |  78 +++--
 tests/qemu-iotests/117.out                    |   2 +-
 tests/qemu-iotests/120.out                    |   2 +-
 tests/qemu-iotests/127.out                    |   2 +-
 tests/qemu-iotests/140.out                    |   2 +-
 tests/qemu-iotests/141                        | 307 ++++++++-----------
 tests/qemu-iotests/141.out                    | 200 +++----------
 tests/qemu-iotests/143.out                    |   2 +-
 tests/qemu-iotests/156.out                    |   2 +-
 tests/qemu-iotests/176.out                    |  16 +-
 tests/qemu-iotests/182.out                    |   2 +-
 tests/qemu-iotests/183.out                    |   4 +-
 tests/qemu-iotests/184.out                    |  32 +-
 tests/qemu-iotests/185                        |   6 +-
 tests/qemu-iotests/185.out                    |  45 ++-
 tests/qemu-iotests/191.out                    |  16 +-
 tests/qemu-iotests/195.out                    |  16 +-
 tests/qemu-iotests/223.out                    |  12 +-
 tests/qemu-iotests/227.out                    |  32 +-
 tests/qemu-iotests/247.out                    |   2 +-
 tests/qemu-iotests/273.out                    |   8 +-
 tests/qemu-iotests/308                        |   4 +-
 tests/qemu-iotests/308.out                    |   4 +-
 tests/qemu-iotests/tests/file-io-error        |   5 +-
 tests/qemu-iotests/tests/iothreads-resize.out |   2 +-
 tests/qemu-iotests/tests/qsd-jobs.out         |   4 +-
 55 files changed, 1014 insertions(+), 1024 deletions(-)
 delete mode 100644 hw/block/dataplane/trace.h
 delete mode 100644 hw/block/dataplane/virtio-blk.h
 delete mode 100644 hw/block/dataplane/virtio-blk.c
 delete mode 100644 hw/block/dataplane/trace-events


