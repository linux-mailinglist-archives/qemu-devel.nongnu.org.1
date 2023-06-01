Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAA971F08B
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 19:21:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4kBk-0004RN-RX; Thu, 01 Jun 2023 11:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4kBf-0004Pr-10
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:26:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4kBb-0003MM-Fy
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:26:02 -0400
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-5FE_cTMtMk-QY0HLTJnTJQ-1; Thu, 01 Jun 2023 11:25:56 -0400
X-MC-Unique: 5FE_cTMtMk-QY0HLTJnTJQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D09B806105;
 Thu,  1 Jun 2023 15:25:55 +0000 (UTC)
Received: from localhost (unknown [10.39.194.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A1CB8162;
 Thu,  1 Jun 2023 15:25:54 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>,
 Aarushi Mehta <mehta.aaru20@gmail.com>,
 Anthony Perard <anthony.perard@citrix.com>, Thomas Huth <thuth@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 xen-devel@lists.xenproject.org, Paul Durrant <paul@xen.org>,
 Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, kvm@vger.kernel.org
Subject: [PULL 0/8] Block patches
Date: Thu,  1 Jun 2023 11:25:44 -0400
Message-Id: <20230601152552.1603119-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
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

The following changes since commit c6a5fc2ac76c5ab709896ee1b0edd33685a67ed1:

  decodetree: Add --output-null for meson testing (2023-05-31 19:56:42 -0700)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 98b126f5e3228a346c774e569e26689943b401dd:

  qapi: add '@fdset' feature for BlockdevOptionsVirtioBlkVhostVdpa (2023-06-01 11:08:21 -0400)

----------------------------------------------------------------
Pull request

- Stefano Garzarella's blkio block driver 'fd' parameter
- My thread-local blk_io_plug() series

----------------------------------------------------------------

Stefan Hajnoczi (6):
  block: add blk_io_plug_call() API
  block/nvme: convert to blk_io_plug_call() API
  block/blkio: convert to blk_io_plug_call() API
  block/io_uring: convert to blk_io_plug_call() API
  block/linux-aio: convert to blk_io_plug_call() API
  block: remove bdrv_co_io_plug() API

Stefano Garzarella (2):
  block/blkio: use qemu_open() to support fd passing for virtio-blk
  qapi: add '@fdset' feature for BlockdevOptionsVirtioBlkVhostVdpa

 MAINTAINERS                       |   1 +
 qapi/block-core.json              |   6 ++
 meson.build                       |   4 +
 include/block/block-io.h          |   3 -
 include/block/block_int-common.h  |  11 ---
 include/block/raw-aio.h           |  14 ---
 include/sysemu/block-backend-io.h |  13 +--
 block/blkio.c                     |  96 ++++++++++++------
 block/block-backend.c             |  22 -----
 block/file-posix.c                |  38 -------
 block/io.c                        |  37 -------
 block/io_uring.c                  |  44 ++++-----
 block/linux-aio.c                 |  41 +++-----
 block/nvme.c                      |  44 +++------
 block/plug.c                      | 159 ++++++++++++++++++++++++++++++
 hw/block/dataplane/xen-block.c    |   8 +-
 hw/block/virtio-blk.c             |   4 +-
 hw/scsi/virtio-scsi.c             |   6 +-
 block/meson.build                 |   1 +
 block/trace-events                |   6 +-
 20 files changed, 293 insertions(+), 265 deletions(-)
 create mode 100644 block/plug.c

-- 
2.40.1


