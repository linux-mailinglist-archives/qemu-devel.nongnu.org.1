Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B65C7CD88D
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 11:51:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt38C-0000rO-Lf; Wed, 18 Oct 2023 05:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt37j-0000Gf-HB
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:45:55 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=VFJy=GA=redhat.com=clg@ozlabs.org>)
 id 1qt37g-0003Nc-Ch
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 05:45:54 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4S9QvR459jz4xZZ;
 Wed, 18 Oct 2023 20:45:39 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9QvQ1t6tz4wcj;
 Wed, 18 Oct 2023 20:45:38 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/22] vfio queue
Date: Wed, 18 Oct 2023 11:45:09 +0200
Message-ID: <20231018094531.733211-1-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=VFJy=GA=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit ec6f9f135d5e5596ab0258da2ddd048f1fd8c359:

  Merge tag 'migration-20231017-pull-request' of https://gitlab.com/juan.quintela/qemu into staging (2023-10-17 10:06:21 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-vfio-20231018

for you to fetch changes up to 8741781157f09a9f79bb652f8a0210d40f814cd0:

  hw/vfio: add ramfb migration support (2023-10-18 10:10:49 +0200)

----------------------------------------------------------------
vfio queue:

* Support for VFIODisplay migration with ramfb
* Preliminary work for IOMMUFD support

----------------------------------------------------------------
Eric Auger (8):
      scripts/update-linux-headers: Add iommufd.h
      vfio/common: Propagate KVM_SET_DEVICE_ATTR error if any
      vfio/common: Introduce vfio_container_add|del_section_window()
      vfio/pci: Introduce vfio_[attach/detach]_device
      vfio/platform: Use vfio_[attach/detach]_device
      vfio/ap: Use vfio_[attach/detach]_device
      vfio/ccw: Use vfio_[attach/detach]_device
      vfio/pci: Remove vfio_detach_device from vfio_realize error path

Marc-André Lureau (3):
      ramfb: add migration support
      ramfb-standalone: add migration support
      hw/vfio: add ramfb migration support

Yi Liu (2):
      vfio/common: Move IOMMU agnostic helpers to a separate file
      vfio/common: Move legacy VFIO backend code into separate container.c

Zhenzhong Duan (9):
      linux-headers: Add iommufd.h
      vfio/common: Extract out vfio_kvm_device_[add/del]_fd
      vfio/common: Move VFIO reset handler registration to a group agnostic function
      vfio/common: Introduce a per container device list
      vfio/common: Store the parent container in VFIODevice
      vfio/common: Introduce a global VFIODevice list
      vfio/pci: Fix a potential memory leak in vfio_listener_region_add
      vfio/ap: Remove pointless apdev variable
      vfio/ccw: Remove redundant definition of TYPE_VFIO_CCW

 hw/vfio/pci.h                   |    3 +
 include/hw/display/ramfb.h      |    4 +
 include/hw/s390x/vfio-ccw.h     |    2 -
 include/hw/vfio/vfio-common.h   |   60 +-
 linux-headers/linux/iommufd.h   |  444 +++++++++
 hw/core/machine.c               |    2 +
 hw/display/ramfb-standalone.c   |   27 +
 hw/display/ramfb.c              |   19 +
 hw/vfio/ap.c                    |   76 +-
 hw/vfio/ccw.c                   |  117 +--
 hw/vfio/common.c                | 1887 +++------------------------------------
 hw/vfio/container.c             | 1161 ++++++++++++++++++++++++
 hw/vfio/display.c               |   21 +
 hw/vfio/helpers.c               |  612 +++++++++++++
 hw/vfio/pci.c                   |   97 +-
 hw/vfio/platform.c              |   43 +-
 stubs/ramfb.c                   |    2 +
 hw/vfio/meson.build             |    2 +
 hw/vfio/trace-events            |    4 +-
 scripts/update-linux-headers.sh |    3 +-
 20 files changed, 2593 insertions(+), 1993 deletions(-)
 create mode 100644 linux-headers/linux/iommufd.h
 create mode 100644 hw/vfio/container.c
 create mode 100644 hw/vfio/helpers.c

