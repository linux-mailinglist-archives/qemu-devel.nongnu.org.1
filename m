Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C3B79A6E4
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 11:48:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfdVC-0005lB-ND; Mon, 11 Sep 2023 05:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qfdV9-0005kQ-Og
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:46:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qfdV5-0004dP-QM
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:46:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694425595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8ezpTq2Ef1vXGLPsjvf7QRHB7/sC3AF6R3eQ0YRwsdE=;
 b=CIrwhVGB6hdRMeh9xaVjrvHvcoYm6FIPW9Lao3PwbTSw5+NCpIRiD43BCUZnlYRfJ715R9
 xuA35hXLDoQEL1tAjsC5Hb8yddu5Rl+oxjPmoV7y5iBchILd4lIbDgOKgm5ga+hW3co1Wa
 CAx02PXO88xP/3l5kLA3u2X1ofjtYgY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-afQeouQMN2CIIhDT-ACCdw-1; Mon, 11 Sep 2023 05:46:31 -0400
X-MC-Unique: afQeouQMN2CIIhDT-ACCdw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DF053C19363;
 Mon, 11 Sep 2023 09:46:31 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.192.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C51240C6EA8;
 Mon, 11 Sep 2023 09:46:29 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, eblake@redhat.com,
 eesposit@redhat.com, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org
Subject: [PATCH v2 00/21] Graph locking part 4 (node management)
Date: Mon, 11 Sep 2023 11:45:59 +0200
Message-ID: <20230911094620.45040-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The previous parts of the graph locking changes focussed mostly on the
BlockDriver side and taking reader locks while performing I/O. This
series focusses more on the functions managing the graph structure, i.e
adding, removing and replacing nodes and updating their permissions.

Many of these places actually need to take the writer lock to avoid
readers seeing an inconsistent half-updated graph state. Therefore
taking the writer lock is now moved from the very low-level function
bdrv_replace_child_noperm() into its more high level callers.

v2:
- Patch 5: Improved comments, added one for bdrv_schedule_unref()

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

 include/block/block-common.h                |   4 +
 include/block/block-global-state.h          |  30 +-
 include/block/block_int-common.h            |  34 +-
 include/block/block_int-global-state.h      |  14 +-
 include/sysemu/block-backend-global-state.h |   4 +-
 block.c                                     | 348 ++++++++++++++------
 block/blklogwrites.c                        |   4 +
 block/blkverify.c                           |   2 +
 block/block-backend.c                       |  29 +-
 block/copy-before-write.c                   |  10 +-
 block/crypto.c                              |   6 +-
 block/graph-lock.c                          |  26 +-
 block/mirror.c                              |   8 +
 block/preallocate.c                         | 133 +++++---
 block/qcow2.c                               |   4 +-
 block/quorum.c                              |  23 +-
 block/replication.c                         |   9 +
 block/snapshot.c                            |   2 +
 block/stream.c                              |  20 +-
 block/vmdk.c                                |  13 +
 blockdev.c                                  |  23 +-
 blockjob.c                                  |   2 +
 tests/unit/test-bdrv-drain.c                |  23 +-
 tests/unit/test-bdrv-graph-mod.c            |  20 ++
 tests/unit/test-block-iothread.c            |   3 +
 scripts/block-coroutine-wrapper.py          |  18 +-
 tests/qemu-iotests/051.pc.out               |   6 +-
 27 files changed, 591 insertions(+), 227 deletions(-)

-- 
2.41.0


