Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F790710C50
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 14:47:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2ANU-0007v3-2u; Thu, 25 May 2023 08:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q2ANN-0007ug-Ug
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q2ANM-0001xf-C7
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685018846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=l3EbLp4MvEn5fyXqQ92CPB7by2yJkY5PWeTOZsnubm0=;
 b=QzU4obnQu/TleHcLV2Z31AdRK7LiKaNdZna36s7jnkYp/Br/e4nliGpWxC0yLDLBOj+BRd
 1aK0/mnx+M8lFACvOQZhQIuWQ51EqaWoWE2foNdf+WDBbSOw9O+wN3siZC6egHOaXXicW+
 dFp4rB6z5uHyp2Ve4j75n36YO367s5w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-f__xSgLFMMC59rcLxnvnXw-1; Thu, 25 May 2023 08:47:23 -0400
X-MC-Unique: f__xSgLFMMC59rcLxnvnXw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BFB38032E4;
 Thu, 25 May 2023 12:47:23 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DC3857AF5;
 Thu, 25 May 2023 12:47:21 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH 00/12] block: Fix blockdev-create with iothreads
Date: Thu, 25 May 2023 14:47:01 +0200
Message-Id: <20230525124713.401149-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This series started with the last patch, an iotest that tests the fixes
for .bdrv_co_create() that were made in commit b2ab5f545f ('block:
bdrv/blk_co_unref() for calls in coroutine context').

Unfortunately, it turned out that much more is wrong about creating
images in an iothread. In particular, AioContext locking is messy and in
many cases wrong. (Only one more reason to get rid of them.) This series
fixes all the hangs and crashes I saw while making the final test case
pass.

Note that this series isn't fully bisectable. Some of the existing bugs
cancel each other out, so after fixing one, some test cases will break
until the other one is fixed, too.

Kevin Wolf (12):
  block-coroutine-wrapper: Take AioContext lock in no_co_wrappers
  block: Clarify locking rules for bdrv_open(_inherit)()
  block: Take main AioContext lock when calling bdrv_open()
  block-backend: Fix blk_new_open() for iothreads
  mirror: Hold main AioContext lock for calling bdrv_open_backing_file()
  qcow2: Fix open with 'file' in iothread
  raw-format: Fix open with 'file' in iothread
  copy-before-write: Fix open with child in iothread
  block: Take AioContext lock in bdrv_open_driver()
  block: Fix AioContext locking in bdrv_insert_node()
  iotests: Make verify_virtio_scsi_pci_or_ccw() public
  iotests: Test blockdev-create in iothread

 include/block/block-common.h                  |  3 +
 block.c                                       | 33 ++++++---
 block/block-backend.c                         | 36 ++++++++--
 block/copy-before-write.c                     | 21 ++++--
 block/mirror.c                                |  6 ++
 block/qapi-sysemu.c                           |  3 +
 block/qcow2.c                                 |  8 ++-
 block/raw-format.c                            |  5 ++
 blockdev.c                                    | 29 ++++++--
 qemu-nbd.c                                    |  4 ++
 tests/unit/test-block-iothread.c              |  4 +-
 scripts/block-coroutine-wrapper.py            | 25 ++++---
 tests/qemu-iotests/iotests.py                 |  2 +-
 tests/qemu-iotests/256                        |  2 +-
 tests/qemu-iotests/tests/iothreads-create     | 67 +++++++++++++++++++
 tests/qemu-iotests/tests/iothreads-create.out |  4 ++
 16 files changed, 210 insertions(+), 42 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/iothreads-create
 create mode 100644 tests/qemu-iotests/tests/iothreads-create.out

-- 
2.40.1


