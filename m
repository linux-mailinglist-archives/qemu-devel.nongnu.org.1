Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DEE787639
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:59:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDfU-0005it-3E; Thu, 24 Aug 2023 12:58:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZDfR-0005fp-Gd
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:58:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qZDfO-0003OU-Ns
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692896321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5Kw6eAjYLbJjOuWDp9YqwJqu5lxN6w36bls8YVo5YG8=;
 b=APCo2S/EA3ZqcS0VCK9d3ULc0QaD8fKt0nlLjpf7PKGTFTjJBO6ArTXRku4SHVj6yjio8M
 UiARq+awg1yXiD6cRDWklv3Y83fBYfVls4FFRCdWUeto2zxZ7ne0Rtjv17iaB0vdimLoqK
 2HGaHG7Ng6vpgXfK3bGXBJHea1axbFA=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-lXDNvqrXMcSG9KMYy4zaZg-1; Thu, 24 Aug 2023 12:58:38 -0400
X-MC-Unique: lXDNvqrXMcSG9KMYy4zaZg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F7FF2A59540;
 Thu, 24 Aug 2023 16:58:38 +0000 (UTC)
Received: from localhost (unknown [10.39.194.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3DACA568FF;
 Thu, 24 Aug 2023 16:58:37 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, Jeuk Kim <jeuk20.kim@samsung.com>,
 Hanna Reitz <hreitz@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 0/8] Block patches
Date: Thu, 24 Aug 2023 12:58:25 -0400
Message-ID: <20230824165833.1689137-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
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

The following changes since commit b0dd9a7d6dd15a6898e9c585b521e6bec79b25aa:

  Open 8.2 development tree (2023-08-22 07:14:07 -0700)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to 892470a8de848a685acb67ba739485424efc3aed:

  tests/qemu-iotests/197: add testcase for CoR with subclusters (2023-08-24 10:28:50 -0400)

----------------------------------------------------------------
Pull request

First block pull request for the QEMU 8.2 release cycle.

----------------------------------------------------------------

Andrey Drobyshev via (3):
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


