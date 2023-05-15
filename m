Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0C970324E
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:08:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyaha-0004y3-P7; Mon, 15 May 2023 12:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pyahO-0004uj-Mw
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:05:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pyahE-0001r1-9G
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684166710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lcQUWH2Bg0LeZN3EAXHkDBBz74AC6jKu2ky3WAA/zwY=;
 b=NyUJA83auE6DJ8lJvwqNNO9OnG4HOYTliU2B2o0oXvuDYRxTv5PZlsHs+VCsnu74eJY0Ub
 vpFj5QqkbVLjdUe+hFZMt5mhoOuysd8RC20MGeq/7EC8tUsQ2b7Z8ovZpglCxLY+UAb8Ur
 OTB6q4EEJQGhY1zYhSeJCx12tNqzUQU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-127-ROeSGZqQOD-a-c7Wpgk-Nw-1; Mon, 15 May 2023 12:05:09 -0400
X-MC-Unique: ROeSGZqQOD-a-c7Wpgk-Nw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80A381C00046;
 Mon, 15 May 2023 16:05:08 +0000 (UTC)
Received: from localhost (unknown [10.39.192.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEAB920268C4;
 Mon, 15 May 2023 16:05:07 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, kvm@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PULL v2 00/16] Block patches
Date: Mon, 15 May 2023 12:04:50 -0400
Message-Id: <20230515160506.1776883-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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

The following changes since commit 8844bb8d896595ee1d25d21c770e6e6f29803097:

  Merge tag 'or1k-pull-request-20230513' of https://github.com/stffrdhrn/qemu into staging (2023-05-13 11:23:14 +0100)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 01562fee5f3ad4506d57dbcf4b1903b565eceec7:

  docs/zoned-storage:add zoned emulation use case (2023-05-15 08:19:04 -0400)

----------------------------------------------------------------
Pull request

This pull request contain's Sam Li's zoned storage support in the QEMU block
layer and virtio-blk emulation.

v2:
- Sam fixed the CI failures. CI passes for me now. [Richard]

----------------------------------------------------------------

Sam Li (16):
  block/block-common: add zoned device structs
  block/file-posix: introduce helper functions for sysfs attributes
  block/block-backend: add block layer APIs resembling Linux
    ZonedBlockDevice ioctls
  block/raw-format: add zone operations to pass through requests
  block: add zoned BlockDriver check to block layer
  iotests: test new zone operations
  block: add some trace events for new block layer APIs
  docs/zoned-storage: add zoned device documentation
  file-posix: add tracking of the zone write pointers
  block: introduce zone append write for zoned devices
  qemu-iotests: test zone append operation
  block: add some trace events for zone append
  virtio-blk: add zoned storage emulation for zoned devices
  block: add accounting for zone append operation
  virtio-blk: add some trace events for zoned emulation
  docs/zoned-storage:add zoned emulation use case

 docs/devel/index-api.rst               |   1 +
 docs/devel/zoned-storage.rst           |  62 +++
 qapi/block-core.json                   |  68 ++-
 qapi/block.json                        |   4 +
 meson.build                            |   5 +
 include/block/accounting.h             |   1 +
 include/block/block-common.h           |  57 ++
 include/block/block-io.h               |  13 +
 include/block/block_int-common.h       |  37 ++
 include/block/raw-aio.h                |   8 +-
 include/sysemu/block-backend-io.h      |  27 +
 block.c                                |  19 +
 block/block-backend.c                  | 198 +++++++
 block/file-posix.c                     | 692 +++++++++++++++++++++++--
 block/io.c                             |  68 +++
 block/io_uring.c                       |   4 +
 block/linux-aio.c                      |   3 +
 block/qapi-sysemu.c                    |  11 +
 block/qapi.c                           |  18 +
 block/raw-format.c                     |  26 +
 hw/block/virtio-blk-common.c           |   2 +
 hw/block/virtio-blk.c                  | 405 +++++++++++++++
 hw/virtio/virtio-qmp.c                 |   2 +
 qemu-io-cmds.c                         | 224 ++++++++
 block/trace-events                     |   4 +
 docs/system/qemu-block-drivers.rst.inc |   6 +
 hw/block/trace-events                  |   7 +
 tests/qemu-iotests/227.out             |  18 +
 tests/qemu-iotests/tests/zoned         | 105 ++++
 tests/qemu-iotests/tests/zoned.out     |  69 +++
 30 files changed, 2106 insertions(+), 58 deletions(-)
 create mode 100644 docs/devel/zoned-storage.rst
 create mode 100755 tests/qemu-iotests/tests/zoned
 create mode 100644 tests/qemu-iotests/tests/zoned.out

-- 
2.40.1


