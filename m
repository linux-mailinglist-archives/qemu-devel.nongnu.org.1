Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3A2707521
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 00:12:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzPLy-0003XL-V5; Wed, 17 May 2023 18:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pzPLw-0003S7-SB
 for qemu-devel@nongnu.org; Wed, 17 May 2023 18:10:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pzPLs-0002Qu-W6
 for qemu-devel@nongnu.org; Wed, 17 May 2023 18:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684361431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=N/ldJhRh22XDo67uOMsA8dfc78R1BhZ6UygIAszkpiQ=;
 b=VwGNT/N8P1VtmDkLZ4GIScx40H3bKhNrjimBPaLXeNHqU90i5K2avpkFPplyJIsjqpnTDk
 ro4HG73MI13aijix1phk/1xVmTS6eT5uFpRs0zOAwfbyso3Vb1/hvErEh88CZyXoJ6yv2A
 tR7VFKxxscN1T9J2U+kegIKPU4Wmn/0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-59-lSLG9I1HP4uawS9h9gPBxQ-1; Wed, 17 May 2023 18:10:26 -0400
X-MC-Unique: lSLG9I1HP4uawS9h9gPBxQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB521185A78B;
 Wed, 17 May 2023 22:10:25 +0000 (UTC)
Received: from localhost (unknown [10.39.192.14])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DFC2BC15BA0;
 Wed, 17 May 2023 22:10:24 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, Julia Suvorova <jusual@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>, Anthony Perard <anthony.perard@citrix.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 0/6] block: add blk_io_plug_call() API
Date: Wed, 17 May 2023 18:10:16 -0400
Message-Id: <20230517221022.325091-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The existing blk_io_plug() API is not block layer multi-queue friendly because
the plug state is per-BlockDriverState.

Change blk_io_plug()'s implementation so it is thread-local. This is done by
introducing the blk_io_plug_call() function that block drivers use to batch
calls while plugged. It is relatively easy to convert block drivers from
.bdrv_co_io_plug() to blk_io_plug_call().

Random read 4KB performance with virtio-blk on a host NVMe block device:

iodepth   iops   change vs today
1        45612   -4%
2        87967   +2%
4       129872   +0%
8       171096   -3%
16      194508   -4%
32      208947   -1%
64      217647   +0%
128     229629   +0%

The results are within the noise for these benchmarks. This is to be expected
because the plugging behavior for a single thread hasn't changed in this patch
series, only that the state is thread-local now.

The following graph compares several approaches:
https://vmsplice.net/~stefan/blk_io_plug-thread-local.png
- v7.2.0: before most of the multi-queue block layer changes landed.
- with-blk_io_plug: today's post-8.0.0 QEMU.
- blk_io_plug-thread-local: this patch series.
- no-blk_io_plug: what happens when we simply remove plugging?
- call-after-dispatch: what if we integrate plugging into the event loop? I
  decided against this approach in the end because it's more likely to
  introduce performance regressions since I/O submission is deferred until the
  end of the event loop iteration.

Aside from the no-blk_io_plug case, which bottlenecks much earlier than the
others, we see that all plugging approaches are more or less equivalent in this
benchmark. It is also clear that QEMU 8.0.0 has lower performance than 7.2.0.

The Ansible playbook, fio results, and a Jupyter notebook are available here:
https://github.com/stefanha/qemu-perf/tree/remove-blk_io_plug

Stefan Hajnoczi (6):
  block: add blk_io_plug_call() API
  block/nvme: convert to blk_io_plug_call() API
  block/blkio: convert to blk_io_plug_call() API
  block/io_uring: convert to blk_io_plug_call() API
  block/linux-aio: convert to blk_io_plug_call() API
  block: remove bdrv_co_io_plug() API

 MAINTAINERS                       |   1 +
 include/block/block-io.h          |   3 -
 include/block/block_int-common.h  |  11 ---
 include/block/raw-aio.h           |  14 ---
 include/sysemu/block-backend-io.h |  13 +--
 block/blkio.c                     |  40 ++++----
 block/block-backend.c             |  22 -----
 block/file-posix.c                |  38 -------
 block/io.c                        |  37 -------
 block/io_uring.c                  |  45 ++++-----
 block/linux-aio.c                 |  41 +++-----
 block/nvme.c                      |  44 +++------
 block/plug.c                      | 159 ++++++++++++++++++++++++++++++
 hw/block/dataplane/xen-block.c    |   8 +-
 hw/block/virtio-blk.c             |   4 +-
 hw/scsi/virtio-scsi.c             |   6 +-
 block/meson.build                 |   1 +
 block/trace-events                |   5 +-
 18 files changed, 236 insertions(+), 256 deletions(-)
 create mode 100644 block/plug.c

-- 
2.40.1


