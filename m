Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA7B79A50B
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 09:52:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfbgr-0003vu-Qg; Mon, 11 Sep 2023 03:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org>)
 id 1qfbgh-0003pd-L5
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:50:27 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org>)
 id 1qfbgd-000814-OE
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:50:26 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Rkf5J52Rfz4x5w;
 Mon, 11 Sep 2023 17:50:12 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rkf5H382Jz4x5q;
 Mon, 11 Sep 2023 17:50:11 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/13] vfio queue
Date: Mon, 11 Sep 2023 09:49:55 +0200
Message-ID: <20230911075008.462712-1-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=GLJ6=E3=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit c5ea91da443b458352c1b629b490ee6631775cb4:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2023-09-08 10:06:25 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20230911

for you to fetch changes up to a31fe5daeaa230556145bfc04af1bd4e68f377fa:

  vfio/common: Separate vfio-pci ranges (2023-09-11 08:34:06 +0200)

----------------------------------------------------------------
vfio queue:

* Small downtime optimisation for VFIO migration
* P2P support for VFIO migration
* Introduction of a save_prepare() handler to fail VFIO migration
* Fix on DMA logging ranges calculation for OVMF enabling dynamic window

----------------------------------------------------------------
Avihai Horon (11):
      vfio/migration: Move from STOP_COPY to STOP in vfio_save_cleanup()
      sysemu: Add prepare callback to struct VMChangeStateEntry
      qdev: Add qdev_add_vm_change_state_handler_full()
      vfio/migration: Add P2P support for VFIO migration
      vfio/migration: Allow migration of multiple P2P supporting devices
      migration: Add migration prefix to functions in target.c
      vfio/migration: Fail adding device with enable-migration=on and existing blocker
      migration: Move more initializations to migrate_init()
      migration: Add .save_prepare() handler to struct SaveVMHandlers
      vfio/migration: Block VFIO migration with postcopy migration
      vfio/migration: Block VFIO migration with background snapshot

Joao Martins (2):
      vfio/migration: Refactor PRE_COPY and RUNNING state checks
      vfio/common: Separate vfio-pci ranges

 docs/devel/vfio-migration.rst     |  93 +++++++++++++++++-----------
 include/hw/vfio/vfio-common.h     |   2 +
 include/migration/register.h      |   5 ++
 include/sysemu/runstate.h         |   7 +++
 migration/migration.h             |   6 +-
 migration/savevm.h                |   1 +
 hw/core/vm-change-state-handler.c |  14 ++++-
 hw/vfio/common.c                  | 126 ++++++++++++++++++++++++++++++--------
 hw/vfio/migration.c               | 106 +++++++++++++++++++++++++++-----
 migration/migration.c             |  33 ++++++----
 migration/savevm.c                |  32 ++++++++--
 migration/target.c                |   8 +--
 softmmu/runstate.c                |  40 ++++++++++++
 hw/vfio/trace-events              |   3 +-
 14 files changed, 377 insertions(+), 99 deletions(-)

