Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE59A79DC82
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 01:12:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgCWx-0001YJ-Lz; Tue, 12 Sep 2023 19:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgCWv-0001Xh-BN
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 19:10:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgCWr-0003G4-C8
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 19:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694560243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=K7anETkDXXXiRfa8RqDRjycoca48nNZQuJRNAC9X3yE=;
 b=Ljs8eEerDudGSIwyoJJ+om5cHkm67nSfvGLA+MyI7v7eB8PcDn52meMBEv1PaHlCfN0Rre
 gKMYTmVpf0W/K0/s9i7Kpm6iR0rcHa8MXUFyM0oP+pE4XDVolBccDx4I0naw6KpjrtT5Xp
 4zFgDZ6e3sa3Qcul9kw9iFsa79nXcmM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-CP9GICi-O_-8s5gsUtpUDA-1; Tue, 12 Sep 2023 19:10:39 -0400
X-MC-Unique: CP9GICi-O_-8s5gsUtpUDA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3233D1C060DA;
 Tue, 12 Sep 2023 23:10:39 +0000 (UTC)
Received: from localhost (unknown [10.39.192.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E6CD21B20B1;
 Tue, 12 Sep 2023 23:10:38 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Klaus Jensen <its@irrelevant.dk>, kwolf@redhat.com,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, <qemu-block@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 David Hildenbrand <david@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH v3 0/5] block-backend: process I/O in the current AioContext
Date: Tue, 12 Sep 2023 19:10:32 -0400
Message-ID: <20230912231037.826804-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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

v3
- Add Patch 2 to fix a race condition in test-bdrv-drain. This was the CI
  failure that bumped this patch series from Kevin's pull request.
- Add missing 051.pc.out file. I tried qemu-system-aarch64 to see of 051.out
  also needs to be updated, but no changes were necessary. [Kevin]
v2
- Add patch to remove AIOCBInfo->get_aio_context() [Kevin]
- Add patch to use qemu_get_current_aio_context() in block-coroutine-wrapper so
  that the wrappers use the current AioContext instead of
  bdrv_get_aio_context().

Switch blk_aio_*() APIs over to multi-queue by using
qemu_get_current_aio_context() instead of blk_get_aio_context(). This change
will allow devices to process I/O in multiple IOThreads in the future.

The final patch requires my QIOChannel AioContext series to pass
tests/qemu-iotests/check -qcow2 281 because the nbd block driver is now
accessed from the main loop thread in addition to the IOThread:
https://lore.kernel.org/qemu-devel/20230823234504.1387239-1-stefanha@redhat.com/T/#t

Based-on: 20230823234504.1387239-1-stefanha@redhat.com

Stefan Hajnoczi (5):
  block: remove AIOCBInfo->get_aio_context()
  test-bdrv-drain: avoid race with BH in IOThread drain test
  block-backend: process I/O in the current AioContext
  block-backend: process zoned requests in the current AioContext
  block-coroutine-wrapper: use qemu_get_current_aio_context()

 include/block/aio.h                |  1 -
 include/block/block-global-state.h |  2 ++
 include/block/block-io.h           |  1 -
 block/block-backend.c              | 35 ++++++++----------------------
 block/io.c                         | 23 +++++++-------------
 hw/nvme/ctrl.c                     |  7 ------
 softmmu/dma-helpers.c              |  8 -------
 tests/unit/test-bdrv-drain.c       |  8 +++++++
 util/thread-pool.c                 |  8 -------
 scripts/block-coroutine-wrapper.py |  6 ++---
 tests/qemu-iotests/051.pc.out      |  4 ++--
 11 files changed, 31 insertions(+), 72 deletions(-)

-- 
2.41.0


