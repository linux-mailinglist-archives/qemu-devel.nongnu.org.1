Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4857221A1
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 10:59:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q661n-0005ZO-El; Mon, 05 Jun 2023 04:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q661k-0005YA-6h
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:57:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q661g-0004q8-4i
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685955439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=IHKbsbl6Us8b0ACsQ2D5oS8tkWxtif3fqPUf5D9w2dA=;
 b=OgZPzfltB4IwFYreNO60chFITIYgjJuCQlMduZVBV61S+Fv9zBgVLgl98ySjXwaiF558nz
 OgIBRk7oH/lQLef2mTxTmOoURmqRBWZGZ0ojUiZF7J0CM4XeImHHEZfIvwR3RnvES2d7jl
 pHKEE/LjivG1mhYoHUhX88gzjb769lY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-DY23Zpa0N768ElTmxVEqXg-1; Mon, 05 Jun 2023 04:57:16 -0400
X-MC-Unique: DY23Zpa0N768ElTmxVEqXg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DFAF801224;
 Mon,  5 Jun 2023 08:57:16 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34D5D40C6EC4;
 Mon,  5 Jun 2023 08:57:15 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v2 00/11] block: Re-enable the graph lock
Date: Mon,  5 Jun 2023 10:57:00 +0200
Message-Id: <20230605085711.21261-1-kwolf@redhat.com>
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

This series fixes the deadlock that was observed before commit ad128dff
('graph-lock: Disable locking for now'), which just disabled the graph
lock completely as a workaround to get 8.0.1 stable.

In theory the problem is simple: We can't poll while still holding the
lock of a different AioContext. So bdrv_graph_wrlock() just needs to
drop that lock before it polls. However, there are a number of callers
that don't even hold the AioContext lock they are supposed to hold, so
temporarily unlocking tries to unlock a mutex that isn't locked,
resulting in assertion failures.

Therefore, much of this series is just for fixing AioContext locking
correctness. It is only the last two patches that actually fix the
deadlock and reenable the graph locking.

v2:
- Fixed patch 2 to actually lock the correct AioContext even if the
  device doesn't support iothreads
- Improved the commit message for patch 7 [Eric]
- Fixed mismerge in patch 11 (v1 incorrectly left an #if 0 around)

Kevin Wolf (11):
  iotests: Test active commit with iothread and background I/O
  qdev-properties-system: Lock AioContext for blk_insert_bs()
  test-block-iothread: Lock AioContext for blk_insert_bs()
  block: Fix AioContext locking in bdrv_open_child()
  block: Fix AioContext locking in bdrv_attach_child_common()
  block: Fix AioContext locking in bdrv_reopen_parse_file_or_backing()
  block: Fix AioContext locking in bdrv_open_inherit()
  block: Fix AioContext locking in bdrv_open_backing_file()
  blockjob: Fix AioContext locking in block_job_add_bdrv()
  graph-lock: Unlock the AioContext while polling
  Revert "graph-lock: Disable locking for now"

 include/block/graph-lock.h                    |   6 +-
 block.c                                       | 103 ++++++++++++++++--
 block/graph-lock.c                            |  42 ++++---
 blockjob.c                                    |  17 ++-
 hw/core/qdev-properties-system.c              |   8 +-
 tests/unit/test-block-iothread.c              |   7 +-
 .../tests/iothreads-commit-active             |  85 +++++++++++++++
 .../tests/iothreads-commit-active.out         |  23 ++++
 8 files changed, 250 insertions(+), 41 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/iothreads-commit-active
 create mode 100644 tests/qemu-iotests/tests/iothreads-commit-active.out

-- 
2.40.1


