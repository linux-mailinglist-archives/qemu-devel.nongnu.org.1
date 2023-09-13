Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7279A79F28B
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 22:03:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgW2v-00028V-5C; Wed, 13 Sep 2023 16:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgW2n-00025L-Jp
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 16:01:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qgW2f-0005NM-Vw
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 16:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694635252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nD7AyJZmmyRxiB9nG0IYAzAL7ZwFQ3Xa6S9su6nyaIc=;
 b=MzYATs5mzyLglNdj4IdQC9rmmOnAxpZqDhLeVCX4pBzW5jMLFUiGli8nRV+/nxixzEM+m1
 O/C+vvLBteiL+20yWv7FJwgynyo5n1oZgCBB/K5SLCUo74fddpwWk5B5ECx1W01DJu7mFz
 QQoOmm6gUJoEBhz7NJiubPMHtFnMFrY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-1gwriteAPry7x7A5OQM54w-1; Wed, 13 Sep 2023 16:00:48 -0400
X-MC-Unique: 1gwriteAPry7x7A5OQM54w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC275805B29;
 Wed, 13 Sep 2023 20:00:47 +0000 (UTC)
Received: from localhost (unknown [10.39.192.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2074A2156721;
 Wed, 13 Sep 2023 20:00:46 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Ilya Maximets <i.maximets@ovn.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, xen-devel@lists.xenproject.org,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 <qemu-block@nongnu.org>, Julia Suvorova <jusual@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefano Garzarella <sgarzare@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v3 0/4] virtio-blk: use blk_io_plug_call() instead of
 notification BH
Date: Wed, 13 Sep 2023 16:00:41 -0400
Message-ID: <20230913200045.1024233-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

v3:
- Add comment pointing to API documentation in .c file [Philippe]
- Add virtio_notify_irqfd_deferred_fn trace event [Ilya]
- Remove outdated #include [Ilya]
v2:
- Rename blk_io_plug() to defer_call() and move it to util/ so the net
  subsystem can use it [Ilya]
- Add defer_call_begin()/end() to thread_pool_completion_bh() to match Linux
  AIO and io_uring completion batching

Replace the seldom-used virtio-blk notification BH mechanism with
blk_io_plug(). This is part of an effort to enable the multi-queue block layer
in virtio-blk. The notification BH was not multi-queue friendly.

The blk_io_plug() mechanism improves fio rw=randread bs=4k iodepth=64 numjobs=8
IOPS by ~9% with a single IOThread and 8 vCPUs (this is not even a multi-queue
block layer configuration) compared to no completion batching. iodepth=1
decreases by ~1% but this could be noise. Benchmark details are available here:
https://gitlab.com/stefanha/virt-playbooks/-/tree/blk_io_plug-irqfd

Stefan Hajnoczi (4):
  block: rename blk_io_plug_call() API to defer_call()
  util/defer-call: move defer_call() to util/
  virtio: use defer_call() in virtio_irqfd_notify()
  virtio-blk: remove batch notification BH

 MAINTAINERS                       |   3 +-
 include/qemu/defer-call.h         |  16 +++
 include/sysemu/block-backend-io.h |   4 -
 block/blkio.c                     |   9 +-
 block/io_uring.c                  |  11 ++-
 block/linux-aio.c                 |   9 +-
 block/nvme.c                      |   5 +-
 block/plug.c                      | 159 ------------------------------
 hw/block/dataplane/virtio-blk.c   |  48 +--------
 hw/block/dataplane/xen-block.c    |  11 ++-
 hw/block/virtio-blk.c             |   5 +-
 hw/scsi/virtio-scsi.c             |   7 +-
 hw/virtio/virtio.c                |  13 ++-
 util/defer-call.c                 | 156 +++++++++++++++++++++++++++++
 util/thread-pool.c                |   5 +
 block/meson.build                 |   1 -
 hw/virtio/trace-events            |   1 +
 util/meson.build                  |   1 +
 18 files changed, 231 insertions(+), 233 deletions(-)
 create mode 100644 include/qemu/defer-call.h
 delete mode 100644 block/plug.c
 create mode 100644 util/defer-call.c

-- 
2.41.0


