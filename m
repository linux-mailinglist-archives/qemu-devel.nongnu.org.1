Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B29077919BD
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:38:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdAhI-00022H-Se; Mon, 04 Sep 2023 10:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdAhF-00020y-2f
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:36:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdAhC-0001hf-6Q
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693838211;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jMxt6vGsfcwGStCZcAjlV9B30rYtad+ngnlRUA9+Kf0=;
 b=iqAuKYc2pAodx/AXmQydpSJq8Pw7pzztGBzIW/KVmCDrLveOgHj6Hfwn/60wA3cg0mve6m
 nbgsoBOCG0Jo86Sk80Heq5fRViBjuuUG7FdxsccMOuakapQsU++6ja2RWCNcwkqju9/qX8
 A5UudqRbbsMnAAbvGygO+90j5/izqqs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-IDZ1U89qN3Ceq-d6yrPX_w-1; Mon, 04 Sep 2023 10:36:50 -0400
X-MC-Unique: IDZ1U89qN3Ceq-d6yrPX_w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F7B8805F05;
 Mon,  4 Sep 2023 14:36:49 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B464A403165;
 Mon,  4 Sep 2023 14:36:48 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 00/14] Block layer patches
Date: Mon,  4 Sep 2023 16:36:29 +0200
Message-ID: <20230904143643.259916-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

The following changes since commit 17780edd81d27fcfdb7a802efc870a99788bd2fc:

  Merge tag 'quick-fix-pull-request' of https://gitlab.com/bsdimp/qemu into staging (2023-08-31 10:06:29 -0400)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to bb86eb45297840c31dbc4df6bac02e50596f2376:

  block: Remove unnecessary variable in bdrv_block_device_info (2023-09-04 11:03:28 +0200)

----------------------------------------------------------------
Block layer patches

- Process I/O in the current AioContext (instead of the BB AioContext)
- Optimise reqs_lock to make multiqueue actually scale
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

Kevin Wolf (1):
      qemu-img: Update documentation for compressed images

Michael Tokarev (1):
      qemu-img: omit errno value in error message

Peter Maydell (1):
      block/iscsi: Document why we use raw malloc()

Philippe Mathieu-Daudé (1):
      block/vpc: Avoid dynamic stack allocation

Stefan Hajnoczi (5):
      block: minimize bs->reqs_lock section in tracked_request_end()
      block: change reqs_lock to QemuMutex
      block: remove AIOCBInfo->get_aio_context()
      block-backend: process I/O in the current AioContext
      block-backend: process zoned requests in the current AioContext

 docs/tools/qemu-img.rst            | 19 ++++++++++++--
 include/block/aio.h                |  1 -
 include/block/block-global-state.h |  2 ++
 include/block/block-io.h           |  1 -
 include/block/block_int-common.h   |  2 +-
 include/block/qapi.h               |  3 ---
 block.c                            | 10 ++++---
 block/block-backend.c              | 35 +++++++------------------
 block/io.c                         | 53 +++++++++++++++++++-------------------
 block/iscsi.c                      |  1 +
 block/qapi.c                       | 32 ++---------------------
 block/vmdk.c                       |  2 +-
 block/vpc.c                        |  4 +--
 hw/nvme/ctrl.c                     |  7 -----
 qemu-img.c                         |  4 +--
 softmmu/dma-helpers.c              |  8 ------
 util/thread-pool.c                 |  8 ------
 tests/qemu-iotests/080.out         |  6 ++---
 tests/qemu-iotests/109.out         | 24 +++++++++++++++++
 tests/qemu-iotests/112.out         |  6 ++---
 tests/qemu-iotests/185             |  2 ++
 tests/qemu-iotests/185.out         |  4 +++
 tests/qemu-iotests/244.out         |  2 +-
 23 files changed, 107 insertions(+), 129 deletions(-)


