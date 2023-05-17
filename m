Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 119AF706EB5
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:52:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKN9-0003tj-Et; Wed, 17 May 2023 12:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKN7-0003tT-AR
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKN5-0001Ng-4b
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684342286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=8xJgnLbZuMtkfoCG2pgeuzgh7OlgDjB8T5xKu7skCfI=;
 b=M+JDVRYVduVEiCwMKKab1OlpkGqkZ/vrdlf5TSi+TR7ttarGYVb5zALa5wjuxOZoJN4/2h
 RJ0Q5cIFpKjItGhf9fadew+C46gCwBES53RiTxC+v9At0kj01ioIWt26Kyc3qBgI0gaQBu
 5Sau8v4hPLEYUD2A05gwt9Pv/jJn9aU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-670-5uf0qY2MOX-2IL34gjqnzA-1; Wed, 17 May 2023 12:51:23 -0400
X-MC-Unique: 5uf0qY2MOX-2IL34gjqnzA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D25DC185A78B;
 Wed, 17 May 2023 16:51:22 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25FAC4078908;
 Wed, 17 May 2023 16:51:22 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 00/18] Block layer patches
Date: Wed, 17 May 2023 18:50:58 +0200
Message-Id: <20230517165116.475123-1-kwolf@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

The following changes since commit 6972ef1440a9d685482d78672620a7482f2bd09a:

  Merge tag 'pull-tcg-20230516-3' of https://gitlab.com/rth7680/qemu into staging (2023-05-16 21:30:27 -0700)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 75b2591bbce5dc9f3da89f140b7bdc00e92fa8ec:

  tested: add test for nested aio_poll() in poll handlers (2023-05-17 18:01:22 +0200)

----------------------------------------------------------------
Block layer patches

- qcow2 spec: Rename "zlib" compression to "deflate"
- Honour graph read lock even in the main thread + prerequisite fixes
- aio-posix: do not nest poll handlers (fixes infinite recursion)
- Refactor QMP blockdev transactions
- iotests/245: Check if 'compress' driver is available

----------------------------------------------------------------
Akihiro Suda (1):
      docs/interop/qcow2.txt: fix description about "zlib" clusters

Kevin Wolf (9):
      block: Call .bdrv_co_create(_opts) unlocked
      block/export: Fix null pointer dereference in error path
      qcow2: Unlock the graph in qcow2_do_open() where necessary
      qemu-img: Take graph lock more selectively
      test-bdrv-drain: Take graph lock more selectively
      test-bdrv-drain: Call bdrv_co_unref() in coroutine context
      blockjob: Adhere to rate limit even when reentered early
      graph-lock: Honour read locks even in the main thread
      iotests/245: Check if 'compress' driver is available

Stefan Hajnoczi (2):
      aio-posix: do not nest poll handlers
      tested: add test for nested aio_poll() in poll handlers

Vladimir Sementsov-Ogievskiy (6):
      blockdev: refactor transaction to use Transaction API
      blockdev: transactions: rename some things
      blockdev: qmp_transaction: refactor loop to classic for
      blockdev: transaction: refactor handling transaction properties
      blockdev: use state.bitmap in block-dirty-bitmap-add action
      blockdev: qmp_transaction: drop extra generic layer

 docs/interop/qcow2.txt             |  10 +-
 include/block/block-global-state.h |   8 +-
 include/block/block_int-common.h   |   4 +-
 include/block/blockjob_int.h       |  14 +-
 block.c                            |   1 -
 block/commit.c                     |   7 +-
 block/create.c                     |   1 -
 block/crypto.c                     |  25 +-
 block/export/export.c              |   6 +-
 block/graph-lock.c                 |  10 -
 block/mirror.c                     |  23 +-
 block/parallels.c                  |   6 +-
 block/qcow.c                       |   6 +-
 block/qcow2.c                      |  43 ++-
 block/qed.c                        |   6 +-
 block/raw-format.c                 |   2 +-
 block/stream.c                     |   7 +-
 block/vdi.c                        |  11 +-
 block/vhdx.c                       |   8 +-
 block/vmdk.c                       |  27 +-
 block/vpc.c                        |   6 +-
 blockdev.c                         | 606 +++++++++++++++----------------------
 blockjob.c                         |  22 +-
 qemu-img.c                         |   5 +-
 tests/unit/test-bdrv-drain.c       |   6 +-
 tests/unit/test-nested-aio-poll.c  | 130 ++++++++
 util/aio-posix.c                   |  11 +
 tests/qemu-iotests/245             |   7 +-
 tests/qemu-iotests/245.out         |   9 +-
 tests/unit/meson.build             |   1 +
 30 files changed, 541 insertions(+), 487 deletions(-)
 create mode 100644 tests/unit/test-nested-aio-poll.c


