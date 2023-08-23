Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AE0786432
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 02:01:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYxlO-0000Ox-Ud; Wed, 23 Aug 2023 19:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYxlN-0000OA-1H
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 19:59:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qYxlK-0004wI-KH
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 19:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692835185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pUjzAkneiLqLNa5aHcR+/LrBY+OKTMr5JSu455SGbUI=;
 b=UC7rBZnHoX7eXFms9CkfSBjOi6BIixLhkNvEpx/oyvF6sf+NHsxvh5aJgmkhs/NfVOQMl8
 3/NJvQg9zU7ZscGkbKQkt6Rt6wBnksNXMv/VWu6+LNL5/PKdAQjCf8lMsT09LiFK53YRdg
 tKVWcOetW3ilrFLHYkCRPrrIPkH2k04=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-681-24axrnbtMNSnPvJtuJEEcg-1; Wed, 23 Aug 2023 19:59:41 -0400
X-MC-Unique: 24axrnbtMNSnPvJtuJEEcg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E946B853069;
 Wed, 23 Aug 2023 23:59:40 +0000 (UTC)
Received: from localhost (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0FFE54A9004;
 Wed, 23 Aug 2023 23:59:39 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kwolf@redhat.com, <qemu-block@nongnu.org>,
 Klaus Jensen <its@irrelevant.dk>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH v2 0/4] block-backend: process I/O in the current AioContext
Date: Wed, 23 Aug 2023 19:59:34 -0400
Message-ID: <20230823235938.1398382-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Stefan Hajnoczi (4):
  block: remove AIOCBInfo->get_aio_context()
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
 util/thread-pool.c                 |  8 -------
 scripts/block-coroutine-wrapper.py |  6 ++---
 9 files changed, 21 insertions(+), 70 deletions(-)

-- 
2.41.0


