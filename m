Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E39A798B4D
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:12:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qef1V-0007OM-Na; Fri, 08 Sep 2023 13:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qef1T-0007NR-AH
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:11:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qef1L-0003Lr-Kl
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 13:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694193110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MgOf0ut0iUr38tL5yOt/OADakbZXeN2cWNXp9kGK3gs=;
 b=HSzszDrXK0kVz84iNjm7XordxR4pAk2e2QXRhDLTcjnwKR2FSBL1btdHHd2wXPcWCphDHh
 Zy5VvQAGAPKpFeKFuJYG24ao6t1LrlBacqMHQ3yT1oV5LMlThoDo+ZZAFJmGCm/+/gJ+Om
 WU/k8y1JIrMXRfy82C3j0P6Yb6jdDzI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-9OpU3j7FPyaz7ToKzHYp3w-1; Fri, 08 Sep 2023 13:11:45 -0400
X-MC-Unique: 9OpU3j7FPyaz7ToKzHYp3w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 122F329AA3BD;
 Fri,  8 Sep 2023 17:11:45 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71C84493112;
 Fri,  8 Sep 2023 17:11:44 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL v2 00/15] Block layer patches
Date: Fri,  8 Sep 2023 19:11:39 +0200
Message-ID: <20230908171139.397473-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 13d9f6dca08a38e9258b6328f3ad61bdb8e19619:

  Merge tag 'ide-pull-request' of https://gitlab.com/jsnow/qemu into staging (2023-09-07 10:28:33 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to 92e2e6a867334a990f8d29f07ca34e3162fdd6ec:

  virtio: Drop out of coroutine context in virtio_load() (2023-09-08 17:03:09 +0200)

----------------------------------------------------------------
Block layer patches

- Optimise reqs_lock to make multiqueue actually scale
- virtio: Drop out of coroutine context in virtio_load()
- iotests: Fix reference output for some tests after recent changes
- vpc: Avoid dynamic stack allocation
- Code cleanup, improved documentation

----------------------------------------------------------------
Dmitry Frolov (1):
      vmdk: Clean up bdrv_open_child() return value check

Fabiano Rosas (2):
      block: Remove bdrv_query_block_node_info
      block: Remove unnecessary variable in bdrv_block_device_info

Fiona Ebner (1):
      iotests: adapt test output for new qemu_cleanup() behavior

Hanna Czenczek (1):
      block: Be more verbose in create fallback

Kevin Wolf (5):
      qemu-img: Update documentation for compressed images
      block/meson.build: Restore alphabetical order of files
      block: Make more BlockDriver definitions static
      vmstate: Mark VMStateInfo.get/put() coroutine_mixed_fn
      virtio: Drop out of coroutine context in virtio_load()

Michael Tokarev (1):
      qemu-img: omit errno value in error message

Peter Maydell (1):
      block/iscsi: Document why we use raw malloc()

Philippe Mathieu-Daudé (1):
      block/vpc: Avoid dynamic stack allocation

Stefan Hajnoczi (2):
      block: minimize bs->reqs_lock section in tracked_request_end()
      block: change reqs_lock to QemuMutex

 docs/tools/qemu-img.rst          | 19 +++++++++++++++--
 include/block/block_int-common.h |  2 +-
 include/block/qapi.h             |  3 ---
 include/migration/vmstate.h      |  8 ++++---
 block.c                          | 10 ++++++---
 block/copy-before-write.c        |  2 +-
 block/io.c                       | 30 ++++++++++++++++-----------
 block/iscsi.c                    |  1 +
 block/preallocate.c              |  2 +-
 block/qapi.c                     | 32 ++--------------------------
 block/snapshot-access.c          |  2 +-
 block/vmdk.c                     |  2 +-
 block/vpc.c                      |  4 ++--
 hw/virtio/virtio.c               | 45 +++++++++++++++++++++++++++++++++++-----
 qemu-img.c                       |  4 ++--
 block/meson.build                | 12 +++++------
 tests/qemu-iotests/080.out       |  6 +++---
 tests/qemu-iotests/109.out       | 24 +++++++++++++++++++++
 tests/qemu-iotests/112.out       |  6 +++---
 tests/qemu-iotests/185           |  2 ++
 tests/qemu-iotests/185.out       |  4 ++++
 tests/qemu-iotests/244.out       |  2 +-
 22 files changed, 142 insertions(+), 80 deletions(-)


