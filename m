Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D34C70BC5B
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 13:52:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q144E-0005Yb-OL; Mon, 22 May 2023 07:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143U-00059y-0V
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q143Q-0007Rj-F2
 for qemu-devel@nongnu.org; Mon, 22 May 2023 07:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684756218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=maJaOj0P581oW/eLfeohQ1Tvvy7TrCPUnQMOrRTNbfM=;
 b=X0bro3BrOwZuxgllfIT2MCTn2eUNQBMss2m48G4UadFIsbSp2Xrb2N53B5O6jMdE5E7P9H
 P5X35wHCMDwNwszcyduEfjOnkzTGxATFktswsVWLcFxjKiZyVRyVk5t7aWYlOHva5PXrix
 I8bAx3W6FqnJKFA1k67gD2k6+N3CqGw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-T7MHWBSwNTSpQTK5r2eLig-1; Mon, 22 May 2023 07:50:17 -0400
X-MC-Unique: T7MHWBSwNTSpQTK5r2eLig-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B64DD85A5BB;
 Mon, 22 May 2023 11:50:16 +0000 (UTC)
Received: from thuth.com (unknown [10.39.195.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0FD912166B26;
 Mon, 22 May 2023 11:50:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/20] Allow "make check" with "--without-default-devices"
Date: Mon, 22 May 2023 13:49:54 +0200
Message-Id: <20230522115014.1110840-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit aa222a8e4f975284b3f8f131653a4114b3d333b3:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2023-05-19 12:17:16 -0700)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2023-05-22

for you to fetch changes up to 3884bf6468ac6bbb58c2b3feaa74e87f821b52f3:

  memory: stricter checks prior to unsetting engaged_in_io (2023-05-22 10:35:28 +0200)

----------------------------------------------------------------
* First batch of fixes to allow "make check" with "--without-default-devices"
* Enable the "bios bits" avocado test in the gitlab-CI
* Another minor fix for the redundancy DMA blocker code

----------------------------------------------------------------
Alexander Bulekov (1):
      memory: stricter checks prior to unsetting engaged_in_io

Ani Sinha (1):
      acpi/tests/avocado/bits: enable bios bits avocado tests on gitlab CI pipeline

Thomas Huth (18):
      hw/i386/Kconfig: ISAPC works fine without VGA_ISA
      softmmu/vl.c: Check for the availability of the VGA device before using it
      hw: Move the default NIC machine class setting from the x86 to the generic one
      softmmu/vl.c: Disable default NIC if it has not been compiled into the binary
      hw/ppc: Use MachineClass->default_nic in the ppc machines
      hw/s390x: Use MachineClass->default_nic in the s390x machine
      hw/sh4: Use MachineClass->default_nic in the sh4 r2d machine
      hw/char/parallel: Move TYPE_ISA_PARALLEL to the header file
      hw/i386: Ignore the default parallel port if it has not been compiled into QEMU
      hw/sparc64/sun4u: Use MachineClass->default_nic and MachineClass->no_parallel
      tests/qtest/readconfig-test: Check for the availability of USB controllers
      tests/qtest/usb-hcd-uhci-test: Skip test if UHCI controller is not available
      tests/qtest/cdrom-test: Fix the test to also work without optional devices
      tests/qtest/virtio-ccw-test: Remove superfluous tests
      tests/qtest: Check for the availability of virtio-ccw devices before using them
      tests/qtest/meson.build: Run the net filter tests only with default devices
      tests/qemu-iotests/172: Run QEMU with -vga none and -nic none
      .gitlab-ci.d/buildtest.yml: Run full "make check" with --without-default-devices

 include/hw/boards.h             |  1 +
 include/hw/char/parallel.h      |  2 ++
 include/hw/i386/pc.h            |  1 -
 hw/char/parallel-isa.c          |  2 +-
 hw/char/parallel.c              |  1 -
 hw/i386/pc.c                    |  3 ++-
 hw/i386/pc_piix.c               |  7 +++++--
 hw/i386/pc_q35.c                |  8 ++++----
 hw/isa/isa-superio.c            |  3 ++-
 hw/ppc/e500.c                   |  3 ++-
 hw/ppc/e500plat.c               |  1 +
 hw/ppc/mac_newworld.c           |  4 +++-
 hw/ppc/mac_oldworld.c           |  4 +++-
 hw/ppc/mpc8544ds.c              |  1 +
 hw/ppc/ppc440_bamboo.c          |  4 +++-
 hw/ppc/prep.c                   |  4 +++-
 hw/s390x/s390-virtio-ccw.c      |  4 +++-
 hw/sh4/r2d.c                    |  4 +++-
 hw/sparc64/sun4u.c              | 11 ++++++++---
 softmmu/memory.c                |  4 +++-
 softmmu/vl.c                    | 20 ++++++++++++++++++-
 tests/qtest/cdrom-test.c        | 16 ++++++++++++---
 tests/qtest/device-plug-test.c  |  9 ++++++++-
 tests/qtest/readconfig-test.c   |  5 ++++-
 tests/qtest/usb-hcd-uhci-test.c |  5 +++++
 tests/qtest/virtio-ccw-test.c   | 43 +++++++++++++----------------------------
 .gitlab-ci.d/buildtest.yml      |  2 +-
 hw/i386/Kconfig                 |  2 +-
 tests/avocado/acpi-bits.py      |  8 ++++----
 tests/qemu-iotests/172          |  2 +-
 tests/qtest/meson.build         | 12 ++++++------
 31 files changed, 125 insertions(+), 71 deletions(-)


