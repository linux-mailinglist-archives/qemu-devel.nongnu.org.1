Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8D7741395
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 16:18:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEVyr-00020p-IG; Wed, 28 Jun 2023 10:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEVyo-0001uB-VJ
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:17:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qEVyn-0005ik-4W
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 10:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687961828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DH6ENqMnoMDqbAuCQos8LO8cdPPbY9SJXzo5XXx2snE=;
 b=XJsAv7zMKW8kjuzmo7k1vpgk24FmT3gJgFeg5BRoyceaxexBbn3hOmjyl7CjlWMpkpxehh
 Y50OAsuMsEsTMIY3vIxDZA473ktzlUUJ2W4DTGUC8r1i5ejswGZDNv3biu+H4IsWYnwEgQ
 bKhhgoKQqAbcqveRa8MqU5deenrmqhI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-GWnryxy3OdibdvIF9gijlQ-1; Wed, 28 Jun 2023 10:15:53 -0400
X-MC-Unique: GWnryxy3OdibdvIF9gijlQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B32088D0F7;
 Wed, 28 Jun 2023 14:15:40 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.195.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78A6240C2063;
 Wed, 28 Jun 2023 14:15:39 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 00/23] Block layer patches
Date: Wed, 28 Jun 2023 16:15:03 +0200
Message-ID: <20230628141526.293104-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 52ed34cbddde1cb89b2ac263e758e349a77f21e1:

  Merge tag 'pull-request-2023-06-26' of https://gitlab.com/thuth/qemu into staging (2023-06-26 10:38:41 +0200)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 17362398ee1a7f04e8006a46333145d8b707fd35:

  block: use bdrv_co_debug_event in coroutine context (2023-06-28 09:46:34 +0200)

----------------------------------------------------------------
Block layer patches

- Re-enable the graph lock
- More fixes to coroutine_fn marking

----------------------------------------------------------------
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

Paolo Bonzini (12):
      file-posix: remove incorrect coroutine_fn calls
      qed: mark more functions as coroutine_fns and GRAPH_RDLOCK
      vpc: mark more functions as coroutine_fns and GRAPH_RDLOCK
      bochs: mark more functions as coroutine_fns and GRAPH_RDLOCK
      block: mark another function as coroutine_fns and GRAPH_UNLOCKED
      cloop: mark more functions as coroutine_fns and GRAPH_RDLOCK
      dmg: mark more functions as coroutine_fns and GRAPH_RDLOCK
      vmdk: mark more functions as coroutine_fns and GRAPH_RDLOCK
      vhdx: mark more functions as coroutine_fns and GRAPH_RDLOCK
      qcow2: mark more functions as coroutine_fns and GRAPH_RDLOCK
      block: use bdrv_co_getlength in coroutine context
      block: use bdrv_co_debug_event in coroutine context

 block/qcow2.h                                      |  33 +++--
 block/vhdx.h                                       |   5 +-
 include/block/block-io.h                           |   7 ++
 include/block/graph-lock.h                         |   6 +-
 block.c                                            | 114 ++++++++++++++++--
 block/bochs.c                                      |   7 +-
 block/cloop.c                                      |   9 +-
 block/dmg.c                                        |  21 ++--
 block/file-posix.c                                 |  29 +++--
 block/graph-lock.c                                 |  43 +++----
 block/io.c                                         |  14 +--
 block/parallels.c                                  |   4 +-
 block/qcow.c                                       |  30 ++---
 block/qcow2-bitmap.c                               |  26 ++--
 block/qcow2-cluster.c                              |  24 ++--
 block/qcow2-refcount.c                             | 134 +++++++++++----------
 block/qcow2.c                                      |  20 +--
 block/qed-check.c                                  |   5 +-
 block/qed-table.c                                  |   6 +-
 block/qed.c                                        |  15 +--
 block/raw-format.c                                 |   4 +-
 block/vhdx-log.c                                   |  36 +++---
 block/vhdx.c                                       |  73 ++++++-----
 block/vmdk.c                                       |  55 ++++-----
 block/vpc.c                                        |  52 ++++----
 blockjob.c                                         |  17 ++-
 hw/core/qdev-properties-system.c                   |   8 +-
 tests/unit/test-block-iothread.c                   |   7 +-
 tests/qemu-iotests/tests/iothreads-commit-active   |  85 +++++++++++++
 .../qemu-iotests/tests/iothreads-commit-active.out |  23 ++++
 30 files changed, 573 insertions(+), 339 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/iothreads-commit-active
 create mode 100644 tests/qemu-iotests/tests/iothreads-commit-active.out


