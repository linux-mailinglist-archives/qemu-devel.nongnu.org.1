Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1388B743417
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 07:24:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF6bG-0008Bi-Hw; Fri, 30 Jun 2023 01:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mf8A=CS=redhat.com=clg@ozlabs.org>)
 id 1qF6av-0008A9-ND
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 01:22:57 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=mf8A=CS=redhat.com=clg@ozlabs.org>)
 id 1qF6at-0003B2-FL
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 01:22:57 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QskGq3YW9z4wbg;
 Fri, 30 Jun 2023 15:22:43 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QskGn3qZ3z4wZy;
 Fri, 30 Jun 2023 15:22:41 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/16] vfio queue
Date: Fri, 30 Jun 2023 07:22:19 +0200
Message-ID: <20230630052235.1934154-1-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=mf8A=CS=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The following changes since commit 4d541f63e90c81112c298cbb35ed53e9c79deb00:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-06-29 13:16:06 +0200)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20230630

for you to fetch changes up to 0cc889c8826cefa5b80110d31a62273b56aa1832:

  vfio/pci: Free leaked timer in vfio_realize error path (2023-06-30 06:02:51 +0200)

----------------------------------------------------------------
vfio queue:

* migration: New switchover ack to reduce downtime
* VFIO migration pre-copy support
* Removal of the VFIO migration experimental flag
* Alternate offset for GPUDirect Cliques
* Misc fixes

----------------------------------------------------------------
Alex Williamson (3):
      vfio: Implement a common device info helper
      hw/vfio/pci-quirks: Support alternate offset for GPUDirect Cliques
      MAINTAINERS: Promote Cédric to VFIO co-maintainer

Avihai Horon (10):
      migration: Add switchover ack capability
      migration: Implement switchover ack logic
      migration: Enable switchover ack capability
      tests: Add migration switchover ack capability test
      vfio/migration: Refactor vfio_save_block() to return saved data size
      vfio/migration: Store VFIO migration flags in VFIOMigration
      vfio/migration: Add VFIO migration pre-copy support
      vfio/migration: Add support for switchover ack capability
      vfio/migration: Reset bytes_transferred properly
      vfio/migration: Make VFIO migration non-experimental

Shameer Kolothum (1):
      vfio/pci: Call vfio_prepare_kvm_msi_virq_batch() in MSI retry path

Zhenzhong Duan (2):
      vfio/pci: Fix a segfault in vfio_realize
      vfio/pci: Free leaked timer in vfio_realize error path

 MAINTAINERS                   |   2 +-
 docs/devel/vfio-migration.rst |  45 +++++--
 qapi/migration.json           |  12 +-
 include/hw/vfio/vfio-common.h |  12 +-
 include/migration/register.h  |   2 +
 migration/migration.h         |  15 +++
 migration/options.h           |   1 +
 migration/savevm.h            |   1 +
 hw/s390x/s390-pci-vfio.c      |  37 +----
 hw/vfio/common.c              |  68 +++++++---
 hw/vfio/migration.c           | 305 ++++++++++++++++++++++++++++++++++++------
 hw/vfio/pci-quirks.c          |  41 +++++-
 hw/vfio/pci.c                 |  15 ++-
 migration/migration.c         |  33 ++++-
 migration/options.c           |  17 +++
 migration/savevm.c            |  55 ++++++++
 migration/target.c            |  17 ++-
 tests/qtest/migration-test.c  |  31 +++++
 hw/vfio/trace-events          |   6 +-
 migration/trace-events        |   3 +
 20 files changed, 600 insertions(+), 118 deletions(-)

