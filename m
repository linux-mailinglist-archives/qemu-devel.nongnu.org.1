Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF31E7F2C20
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 12:54:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5PJb-0003Nl-W8; Tue, 21 Nov 2023 06:53:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r5PJZ-0003Mt-JH
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 06:53:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r5PJX-0004GK-4s
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 06:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700567590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TmXLroyA+bMB7kRr7sZjn4/eRaBbsFNuzpv0vXtQnuQ=;
 b=ZObOf4o1LZvSazM8j9G32HrtAhbDYjOHICU5t4xjoySO5tvqsJAxWhXCO7cbXQjPpzVS2f
 s/QvLLBLRX/x7v4seHJTw3C2vOkuYp1wjyKsFCvPUY63taoFCS7MywNGyCwkvZC3LdL88/
 BRz99zcteR0rtoGxtIKyeV5bpPHol/Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-KKTv_IY4MNeoXnCvOEXbhA-1; Tue,
 21 Nov 2023 06:53:07 -0500
X-MC-Unique: KKTv_IY4MNeoXnCvOEXbhA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1200F2825E92;
 Tue, 21 Nov 2023 11:53:07 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76654492BFD;
 Tue, 21 Nov 2023 11:53:06 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 0/9] Block layer fixes for 8.2.0-rc1
Date: Tue, 21 Nov 2023 12:52:53 +0100
Message-ID: <20231121115302.52214-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit af9264da80073435fd78944bc5a46e695897d7e5:

  Merge tag '20231119-xtensa-1' of https://github.com/OSLL/qemu-xtensa into staging (2023-11-20 05:25:19 -0500)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to debb4911667b1f8213ca8760ae83afcf3b3579e0:

  hw/ide/via: implement legacy/native mode switching (2023-11-21 12:45:21 +0100)

----------------------------------------------------------------
Block layer patches

- Fix graph lock related deadlocks with the stream job
- ahci: Fix legacy software reset
- ide/via: Fix switch between compatibility and native mode

----------------------------------------------------------------
Kevin Wolf (4):
      block: Fix bdrv_graph_wrlock() call in blk_remove_bs()
      block: Fix deadlocks in bdrv_graph_wrunlock()
      stream: Fix AioContext locking during bdrv_graph_wrlock()
      iotests: Test two stream jobs in a single iothread

Mark Cave-Ayland (4):
      ide/ioport: move ide_portio_list[] and ide_portio_list2[] definitions to IDE core
      ide/pci: introduce pci_ide_update_mode() function
      ide/via: don't attempt to set default BAR addresses
      hw/ide/via: implement legacy/native mode switching

Niklas Cassel (1):
      hw/ide/ahci: fix legacy software reset

 include/block/graph-lock.h                    | 15 ++++-
 include/hw/ide/internal.h                     |  3 +
 include/hw/ide/pci.h                          |  1 +
 block.c                                       | 39 ++++++++-----
 block/backup.c                                |  2 +-
 block/blklogwrites.c                          |  4 +-
 block/blkverify.c                             |  2 +-
 block/block-backend.c                         | 12 +++-
 block/commit.c                                | 10 ++--
 block/graph-lock.c                            | 23 +++++++-
 block/mirror.c                                | 14 ++---
 block/qcow2.c                                 |  2 +-
 block/quorum.c                                |  4 +-
 block/replication.c                           | 10 ++--
 block/snapshot.c                              |  2 +-
 block/stream.c                                | 10 ++--
 block/vmdk.c                                  | 10 ++--
 blockdev.c                                    |  4 +-
 blockjob.c                                    |  8 +--
 hw/ide/ahci.c                                 | 27 ++++++++-
 hw/ide/core.c                                 | 12 ++++
 hw/ide/ioport.c                               | 12 ----
 hw/ide/pci.c                                  | 84 +++++++++++++++++++++++++++
 hw/ide/via.c                                  | 44 +++++++++++---
 tests/unit/test-bdrv-drain.c                  | 20 +++----
 tests/unit/test-bdrv-graph-mod.c              | 10 ++--
 scripts/block-coroutine-wrapper.py            |  2 +-
 tests/qemu-iotests/tests/iothreads-stream     | 74 +++++++++++++++++++++++
 tests/qemu-iotests/tests/iothreads-stream.out | 11 ++++
 29 files changed, 374 insertions(+), 97 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/iothreads-stream
 create mode 100644 tests/qemu-iotests/tests/iothreads-stream.out


