Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD35717D90
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 13:05:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4JcI-0007Wi-Om; Wed, 31 May 2023 07:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q4Jbu-0007QF-Ox
 for qemu-devel@nongnu.org; Wed, 31 May 2023 07:03:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q4Jbk-0001eV-R5
 for qemu-devel@nongnu.org; Wed, 31 May 2023 07:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685530961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=RK0MmKpMvaAdUazp232/sQso+J1iYatSZb/66pZaBe4=;
 b=YX1TTMzw9ED8bUEe8lP6O1B4GUGlmUxbP3xHGkbirCKZuqcjrEpqNBaELDnBBl1Rdhvm/K
 NmJHrdcBEY940OO8rMH8lQYvWxbRo7rhi8h1Hw9eQH+L335hTeBbgQPIu1ElL1QwOnYpby
 wwlAyO924HrXfKmyASoQk8+1zT/iuXk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-Tno6pqxOP2mewmyyHi53yg-1; Wed, 31 May 2023 07:02:39 -0400
X-MC-Unique: Tno6pqxOP2mewmyyHi53yg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CBF113801FFA;
 Wed, 31 May 2023 11:02:38 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A80CA20296C6;
 Wed, 31 May 2023 11:02:37 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 00/11] block: Re-enable the graph lock
Date: Wed, 31 May 2023 13:02:20 +0200
Message-Id: <20230531110231.262251-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 block/graph-lock.c                            |  40 ++++---
 blockjob.c                                    |  17 ++-
 hw/core/qdev-properties-system.c              |   3 +
 tests/unit/test-block-iothread.c              |   7 +-
 .../tests/iothreads-commit-active             |  85 +++++++++++++++
 .../tests/iothreads-commit-active.out         |  23 ++++
 8 files changed, 247 insertions(+), 37 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/iothreads-commit-active
 create mode 100644 tests/qemu-iotests/tests/iothreads-commit-active.out

-- 
2.40.1


