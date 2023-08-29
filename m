Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E4478CB1E
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 19:22:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb2PK-0006jM-K2; Tue, 29 Aug 2023 13:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qb2PF-0006g7-Np
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:21:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qb2PD-0000gr-8J
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693329689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1DpAi2ckrdFlA3yAeFpMNA0PDfXHZi2XGuPhuKSGOBQ=;
 b=HXOBYSO8XswxxBRiqYQ7gj5SSLNx0VDCfFEbmBXGcAJ4/gpZdPdEdGMV/CPjrMheR0GTTX
 6WZY70aV2xW2aZGeWqq1oO8bdrRdfeUlqrmVqKiykMqbx52F/BQrj7PUkjsYO4EmVjadGI
 yLCWoRjFWMmdDB/HZrH4lLN5ItakKYo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-wVcMGjwYOoKj1XX-NAg_dw-1; Tue, 29 Aug 2023 13:21:25 -0400
X-MC-Unique: wVcMGjwYOoKj1XX-NAg_dw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CAF19803E2E;
 Tue, 29 Aug 2023 17:21:24 +0000 (UTC)
Received: from localhost (unknown [10.39.195.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 082CE5CC01;
 Tue, 29 Aug 2023 17:21:23 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Peter Xu <peterx@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jeuk Kim <jeuk20.kim@samsung.com>, qemu-block@nongnu.org
Subject: [PULL v2 0/8] Block patches
Date: Tue, 29 Aug 2023 13:21:14 -0400
Message-ID: <20230829172122.303592-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
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

The following changes since commit 813bac3d8d70d85cb7835f7945eb9eed84c2d8d0:

  Merge tag '2023q3-bsd-user-pull-request' of https://gitlab.com/bsdimp/qemu into staging (2023-08-29 08:58:00 -0400)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 3f5f2285bfcdd855508a55da7875fb92de1a6ed0:

  tests/qemu-iotests/197: add testcase for CoR with subclusters (2023-08-29 13:19:56 -0400)

----------------------------------------------------------------
Pull request

v2:
- Fix authorship information lost by the mailing list for Andrey Drobyshev

----------------------------------------------------------------

Andrey Drobyshev (3):
  block: add subcluster_size field to BlockDriverInfo
  block/io: align requests to subcluster_size
  tests/qemu-iotests/197: add testcase for CoR with subclusters

Fabiano Rosas (1):
  block-migration: Ensure we don't crash during migration cleanup

Jeuk Kim (4):
  hw/ufs: Initial commit for emulated Universal-Flash-Storage
  hw/ufs: Support for Query Transfer Requests
  hw/ufs: Support for UFS logical unit
  tests/qtest: Introduce tests for UFS

 MAINTAINERS                  |    7 +
 docs/specs/pci-ids.rst       |    2 +
 meson.build                  |    1 +
 hw/ufs/trace.h               |    1 +
 hw/ufs/ufs.h                 |  131 +++
 include/block/block-common.h |    5 +
 include/block/block-io.h     |    8 +-
 include/block/ufs.h          | 1090 +++++++++++++++++++++++++
 include/hw/pci/pci.h         |    1 +
 include/hw/pci/pci_ids.h     |    1 +
 include/scsi/constants.h     |    1 +
 block.c                      |    7 +
 block/io.c                   |   50 +-
 block/mirror.c               |    8 +-
 block/qcow2.c                |    1 +
 hw/ufs/lu.c                  | 1445 ++++++++++++++++++++++++++++++++
 hw/ufs/ufs.c                 | 1494 ++++++++++++++++++++++++++++++++++
 migration/block.c            |   11 +-
 tests/qtest/ufs-test.c       |  584 +++++++++++++
 hw/Kconfig                   |    1 +
 hw/meson.build               |    1 +
 hw/ufs/Kconfig               |    4 +
 hw/ufs/meson.build           |    1 +
 hw/ufs/trace-events          |   58 ++
 tests/qemu-iotests/197       |   29 +
 tests/qemu-iotests/197.out   |   24 +
 tests/qtest/meson.build      |    1 +
 27 files changed, 4932 insertions(+), 35 deletions(-)
 create mode 100644 hw/ufs/trace.h
 create mode 100644 hw/ufs/ufs.h
 create mode 100644 include/block/ufs.h
 create mode 100644 hw/ufs/lu.c
 create mode 100644 hw/ufs/ufs.c
 create mode 100644 tests/qtest/ufs-test.c
 create mode 100644 hw/ufs/Kconfig
 create mode 100644 hw/ufs/meson.build
 create mode 100644 hw/ufs/trace-events

-- 
2.41.0


