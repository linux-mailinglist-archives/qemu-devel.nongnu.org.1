Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D49227A06C4
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 16:02:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgmuQ-0007v2-Ep; Thu, 14 Sep 2023 10:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgmu7-0007qC-Df
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:01:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgmu2-00015i-4V
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694700065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BQlmGCjMmXwzEzbzoyWciu+bvyqp8h88hY0oeCJESy0=;
 b=NWEWV3jPghvYtYKCC3tY+zSnL/R5eSfd0uUSwTn0+P8shE9rWLNMjcciavv2Bltf2ioKwX
 zhl16aDJW0wYbKLS+4VsOMVEXL5MSl2+09QQJIykulBt2oDbDf/bNxetZYMVLSmStn8chF
 ME2Y8JDM1HmWEaVFUe67YwKPxfgYSE4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-qXM7NthIO_y6njxoluUT9Q-1; Thu, 14 Sep 2023 10:01:03 -0400
X-MC-Unique: qXM7NthIO_y6njxoluUT9Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 560D188B7AD;
 Thu, 14 Sep 2023 14:01:03 +0000 (UTC)
Received: from localhost (unknown [10.39.194.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB9191054FC0;
 Thu, 14 Sep 2023 14:01:02 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 <qemu-block@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 0/4] virtio-blk: prepare for the multi-queue block layer
Date: Thu, 14 Sep 2023 10:00:57 -0400
Message-ID: <20230914140101.1065008-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

The virtio-blk device will soon be able to assign virtqueues to IOThreads,
eliminating the single IOThread bottleneck. In order to do that, the I/O code
path must support running in multiple threads.

This patch series removes the AioContext lock from the virtio-blk I/O code
path, adds thread-safety where it is required, and ensures that Linux AIO and
io_uring are available regardless of which thread calls into the block driver.
With these changes virtio-blk is ready for the iothread-vq-mapping feature,
which will be introduced in the next patch series.

Based-on: 20230913200045.1024233-1-stefanha@redhat.com ("[PATCH v3 0/4] virtio-blk: use blk_io_plug_call() instead of notification BH")
Based-on: 20230912231037.826804-1-stefanha@redhat.com ("[PATCH v3 0/5] block-backend: process I/O in the current AioContext")

Stefan Hajnoczi (4):
  block/file-posix: set up Linux AIO and io_uring in the current thread
  virtio-blk: add lock to protect s->rq
  virtio-blk: don't lock AioContext in the completion code path
  virtio-blk: don't lock AioContext in the submission code path

 include/hw/virtio/virtio-blk.h |   3 +-
 block/file-posix.c             |  99 +++++++++++++++---------------
 hw/block/virtio-blk.c          | 106 +++++++++++++++------------------
 3 files changed, 98 insertions(+), 110 deletions(-)

-- 
2.41.0


