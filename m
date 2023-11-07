Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B637E48A5
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:48:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0R5m-0003wt-J7; Tue, 07 Nov 2023 13:46:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5d-0003uH-QE
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0R5Z-0001T1-DJ
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:46:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699382770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4N3TAT1bvbVe5FgPyUozFWJLYkD2CPZT8RNYewNTBbM=;
 b=JmCS3RcTZDbr4twSBnYWxI/RF/Lo39cimCm+xexEykQJuZO1q3FDE+qpiLfgb3OczwROZh
 1s55LBUIwe6gYqnWYDUy/pXUbihStrEounqpiYwD93IGdhnF4kgNlzECyRlHA/Jx7z1Jvx
 PHjD9Mm3doqE4a1PsLGkc1p3XfcUvo8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-_pw1LBrzM8WOamn8R0ERrg-1; Tue,
 07 Nov 2023 13:46:08 -0500
X-MC-Unique: _pw1LBrzM8WOamn8R0ERrg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE8333C1CC2D
 for <qemu-devel@nongnu.org>; Tue,  7 Nov 2023 18:46:07 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7906CC1596F;
 Tue,  7 Nov 2023 18:46:07 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com
Subject: [PULL 00/25] Block layer patches
Date: Tue,  7 Nov 2023 19:45:40 +0100
Message-ID: <20231107184605.236540-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

The following changes since commit 462ad017ed76889d46696a3581e1b52343f9b683:

  Merge tag 'pixman-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2023-11-07 19:00:03 +0800)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 5d4a5080e43681b753f922c5c2a7682bc1d67497:

  hw/ide/ahci: trigger either error IRQ or regular IRQ, not both (2023-11-07 19:14:20 +0100)

----------------------------------------------------------------
Block layer patches

- Graph locking part 6 (bs->file/backing)
- ahci: trigger either error IRQ or regular IRQ, not both

----------------------------------------------------------------
Kevin Wolf (24):
      block: Mark bdrv_probe_blocksizes() and callers GRAPH_RDLOCK
      block: Mark bdrv_has_zero_init() and callers GRAPH_RDLOCK
      block: Mark bdrv_filter_bs() and callers GRAPH_RDLOCK
      block: Mark bdrv_root_attach_child() GRAPH_WRLOCK
      block: Mark block_job_add_bdrv() GRAPH_WRLOCK
      block: Mark bdrv_filter_or_cow_bs() and callers GRAPH_RDLOCK
      block: Mark bdrv_skip_implicit_filters() and callers GRAPH_RDLOCK
      block: Mark bdrv_skip_filters() and callers GRAPH_RDLOCK
      block: Mark bdrv_(un)freeze_backing_chain() and callers GRAPH_RDLOCK
      block: Mark bdrv_chain_contains() and callers GRAPH_RDLOCK
      block: Mark bdrv_filter_child() and callers GRAPH_RDLOCK
      block: Mark bdrv_cow_child() and callers GRAPH_RDLOCK
      block: Mark bdrv_set_backing_hd_drained() GRAPH_WRLOCK
      block: Inline bdrv_set_backing_noperm()
      block: Mark bdrv_replace_node_common() GRAPH_WRLOCK
      block: Mark bdrv_replace_node() GRAPH_WRLOCK
      block: Protect bs->backing with graph_lock
      blkverify: Add locking for request_fn
      block: Introduce bdrv_co_change_backing_file()
      block: Add missing GRAPH_RDLOCK annotations
      qcow2: Take locks for accessing bs->file
      vhdx: Take locks for accessing bs->file
      block: Take graph lock for most of .bdrv_open
      block: Protect bs->file with graph_lock

Niklas Cassel (1):
      hw/ide/ahci: trigger either error IRQ or regular IRQ, not both

 block/copy-on-read.h                   |   3 +-
 block/parallels.h                      |   5 +-
 block/qcow2.h                          |  59 +++++-----
 block/qed.h                            |   2 +-
 block/vhdx.h                           |   9 +-
 include/block/block-global-state.h     |  43 ++++----
 include/block/block-io.h               |  10 +-
 include/block/block_int-common.h       |  31 +++---
 include/block/block_int-global-state.h |  16 +--
 include/block/block_int-io.h           |  19 ++--
 include/block/blockjob.h               |   5 +-
 include/block/blockjob_int.h           |   9 +-
 block.c                                | 192 +++++++++++++++++++--------------
 block/backup.c                         |  21 ++--
 block/blkdebug.c                       |  29 ++---
 block/blkreplay.c                      |   8 +-
 block/blkverify.c                      |  18 ++--
 block/block-backend.c                  |   5 +
 block/block-copy.c                     |  11 +-
 block/bochs.c                          |   4 +
 block/cloop.c                          |   4 +
 block/commit.c                         |  32 +++++-
 block/copy-before-write.c              |   6 +-
 block/copy-on-read.c                   |  19 +++-
 block/crypto.c                         |  10 ++
 block/dmg.c                            |  21 ++--
 block/filter-compress.c                |   5 +-
 block/io.c                             |   2 +
 block/mirror.c                         |  85 ++++++++++-----
 block/monitor/block-hmp-cmds.c         |   3 +
 block/parallels-ext.c                  |  21 ++--
 block/parallels.c                      |  22 ++--
 block/preallocate.c                    |  27 +++--
 block/qcow.c                           |  13 ++-
 block/qcow2-bitmap.c                   |  14 +--
 block/qcow2-cluster.c                  |  25 ++---
 block/qcow2.c                          | 148 +++++++++++++------------
 block/qed.c                            |  88 ++++++++-------
 block/raw-format.c                     |  36 ++++---
 block/replication.c                    |  12 ++-
 block/snapshot-access.c                |   5 +-
 block/stream.c                         |  48 ++++++---
 block/throttle.c                       |   3 +
 block/vdi.c                            |  15 ++-
 block/vhdx-log.c                       |  40 +++----
 block/vhdx.c                           |  37 ++++---
 block/vmdk.c                           |  23 ++--
 block/vpc.c                            |   6 +-
 blockdev.c                             |  72 ++++++++-----
 blockjob.c                             |   6 +-
 hw/ide/ahci.c                          |   5 +-
 migration/block-dirty-bitmap.c         |   4 +
 nbd/server.c                           |   6 ++
 qemu-img.c                             |  31 ++++--
 tests/unit/test-bdrv-drain.c           |  39 +++++--
 tests/unit/test-bdrv-graph-mod.c       |  18 +++-
 56 files changed, 923 insertions(+), 527 deletions(-)


