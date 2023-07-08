Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9106574BBF4
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 07:16:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI0G7-0006G0-Sn; Sat, 08 Jul 2023 01:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qI0Fs-0006F9-62; Sat, 08 Jul 2023 01:13:12 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qI0Fq-0001gT-1g; Sat, 08 Jul 2023 01:13:11 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 894321267F;
 Sat,  8 Jul 2023 08:12:58 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 04A46139CD;
 Sat,  8 Jul 2023 08:12:54 +0300 (MSK)
Received: (nullmailer pid 3229973 invoked by uid 1000);
 Sat, 08 Jul 2023 05:12:53 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL trival-patches 00/10] trivial-patches for 2023-07-08
Date: Sat,  8 Jul 2023 08:12:40 +0300
Message-Id: <cover.1688793073.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

The following changes since commit 3b08e40b7abfe8be6020c4c27c93ad85590b9213:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-07-07 20:23:01 +0100)

are available in the Git repository at:

  https://gitlab.com/mjt0k/qemu.git tags/trivial-patches-20230708

for you to fetch changes up to 13a637430be13bda3e6726752936321a1955bc93:

  hw/arm/virt-acpi-build.c: Add missing header (2023-07-08 07:24:38 +0300)

----------------------------------------------------------------
qemu trivial patches for 2023-07-08

----------------------------------------------------------------
Daniel Henrique Barboza (1):
      hw/riscv/virt.c: fix typo in 'aia' description

Hawkins Jiawei (2):
      vdpa: Delete duplicated VIRTIO_NET_F_RSS in vdpa_feature_bits
      vdpa: Sort vdpa_feature_bits array alphabetically

Jan Kratochvil (1):
      trivial: man page: document display::gtk::zoom-to-fit

Laszlo Ersek (2):
      migration: factor out "resume_requested" in qmp_migrate()
      migration: unexport migrate_fd_error()

Lucas Dietrich (1):
      target/avr: Fix handling of interrupts above 33.

Peng Liang (1):
      hw/arm/virt-acpi-build.c: Add missing header

Thomas Huth (2):
      hw: Simplify calls to pci_nic_init_nofail()
      qemu-options.hx: Fix indentation of some option descriptions

 hw/arm/sbsa-ref.c        |  8 +-------
 hw/arm/virt-acpi-build.c |  1 +
 hw/arm/virt.c            |  8 +-------
 hw/loongarch/virt.c      |  8 +-------
 hw/mips/loongson3_virt.c |  8 +-------
 hw/riscv/virt.c          |  2 +-
 hw/xtensa/virt.c         |  8 +-------
 migration/migration.c    | 12 +++++++-----
 migration/migration.h    |  1 -
 net/vhost-vdpa.c         | 40 +++++++++++++++++++++++-----------------
 qemu-options.hx          |  9 ++++++---
 target/avr/helper.c      |  4 ++--
 12 files changed, 45 insertions(+), 64 deletions(-)

