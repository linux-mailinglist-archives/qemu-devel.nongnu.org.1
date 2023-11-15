Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3807E7EC992
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 18:21:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3JZ2-0007eU-1t; Wed, 15 Nov 2023 12:20:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r3JZ0-0007dh-4t
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 12:20:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r3JYx-0003Be-UI
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 12:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700068826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Fs5CFy7AAhw3zDxVkVe9qC5yEduYxeGxxxWq/U4n+Ig=;
 b=LMScZ4fJHTu4kPqbQa3jWzTNpMjg6adneynQfnuXt74KaDrN5bYUr/d3LxyC7+bxDFxiOF
 3Xs9cyCilaM6kj4hTMAwZhmNBJQKtnNgemJ2qS6JmVLrKb648zm7JkN25+Ggki1awUa6ve
 NZ2d7P0IModUZTtAgYOQH1wvnizwsBk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-hQO0MfOWPUm-WrwOmbpu2w-1; Wed, 15 Nov 2023 12:20:25 -0500
X-MC-Unique: hQO0MfOWPUm-WrwOmbpu2w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE62E104E894;
 Wed, 15 Nov 2023 17:20:18 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 095C6143;
 Wed, 15 Nov 2023 17:20:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH for-8.2 0/4] block: Fix deadlocks with the stream job
Date: Wed, 15 Nov 2023 18:20:08 +0100
Message-ID: <20231115172012.112727-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This series contains three fixes for deadlocks that follow the same
pattern: A nested event loop in the main thread waits for an iothread to
make progress, but the AioContext lock of that iothread is still held by
the main loop, so it can never make progress.

We're planning to fully remove the AioContext lock in 9.0, which would
automatically get rid of this kind of bugs, but it's still there in 8.2,
so let's fix them individually for this release.

Kevin Wolf (4):
  block: Fix bdrv_graph_wrlock() call in blk_remove_bs()
  block: Fix deadlocks in bdrv_graph_wrunlock()
  stream: Fix AioContext locking during bdrv_graph_wrlock()
  iotests: Test two stream jobs in a single iothread

 include/block/graph-lock.h                    | 15 +++-
 block.c                                       | 26 +++----
 block/backup.c                                |  2 +-
 block/blklogwrites.c                          |  4 +-
 block/blkverify.c                             |  2 +-
 block/block-backend.c                         | 10 ++-
 block/commit.c                                | 10 +--
 block/graph-lock.c                            | 23 +++++-
 block/mirror.c                                | 14 ++--
 block/qcow2.c                                 |  2 +-
 block/quorum.c                                |  4 +-
 block/replication.c                           | 10 +--
 block/snapshot.c                              |  2 +-
 block/stream.c                                | 10 +--
 block/vmdk.c                                  | 10 +--
 blockdev.c                                    |  4 +-
 blockjob.c                                    |  8 +-
 tests/unit/test-bdrv-drain.c                  | 20 ++---
 tests/unit/test-bdrv-graph-mod.c              | 10 +--
 scripts/block-coroutine-wrapper.py            |  2 +-
 tests/qemu-iotests/tests/iothreads-stream     | 73 +++++++++++++++++++
 tests/qemu-iotests/tests/iothreads-stream.out | 11 +++
 22 files changed, 197 insertions(+), 75 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/iothreads-stream
 create mode 100644 tests/qemu-iotests/tests/iothreads-stream.out

-- 
2.41.0


