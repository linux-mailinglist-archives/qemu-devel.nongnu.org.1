Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 276257E268E
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:23:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00Tk-0000pn-Fc; Mon, 06 Nov 2023 09:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1r00Th-0000pO-Do
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:21:21 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1r00Te-0005P1-Er
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:21:20 -0500
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1r00TS-0000d8-0N; Mon, 06 Nov 2023 15:21:06 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>
Subject: [PULL 00/10] Hyper-V Dynamic Memory Protocol driver (hv-balloon) pull
 req fixed
Date: Mon,  6 Nov 2023 15:20:44 +0100
Message-ID: <cover.1699279190.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Hi Stefan,

Fixed the CI pipeline issues with yesterday's pull request, and:
the following changes since commit d762bf97931b58839316b68a570eecc6143c9e3e:

  Merge tag 'pull-target-arm-20231102' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-11-03 10:04:12 +0800)

are available in the Git repository at:

  https://github.com/maciejsszmigiero/qemu.git tags/pull-hv-balloon-20231106

for you to fetch changes up to 00313b517d09c0b141fb32997791f911c28fd3ff:

  MAINTAINERS: Add an entry for Hyper-V Dynamic Memory Protocol (2023-11-06 14:08:10 +0100)

----------------------------------------------------------------
Hyper-V Dynamic Memory protocol driver.

This driver is like virtio-balloon on steroids for Windows guests:
it allows both changing the guest memory allocation via ballooning and
inserting pieces of extra RAM into it on demand from a provided memory
backend via Windows-native Hyper-V Dynamic Memory protocol.

* Preparatory patches to support empty memory devices and ones with
large alignment requirements.

* Revert of recently added "hw/virtio/virtio-pmem: Replace impossible
check by assertion" commit 5960f254dbb4 since this series makes this
situation possible again.

* Protocol definitions.

* Hyper-V DM protocol driver (hv-balloon) base (ballooning only).

* Hyper-V DM protocol driver (hv-balloon) hot-add support.

* qapi query-memory-devices support for the driver.

* qapi HV_BALLOON_STATUS_REPORT event.

* The relevant PC machine plumbing.

* New MAINTAINERS entry for the above.

----------------------------------------------------------------
David Hildenbrand (2):
      memory-device: Support empty memory devices
      memory-device: Drop size alignment check

Maciej S. Szmigiero (8):
      Revert "hw/virtio/virtio-pmem: Replace impossible check by assertion"
      Add Hyper-V Dynamic Memory Protocol definitions
      Add Hyper-V Dynamic Memory Protocol driver (hv-balloon) base
      Add Hyper-V Dynamic Memory Protocol driver (hv-balloon) hot-add support
      qapi: Add query-memory-devices support to hv-balloon
      qapi: Add HV_BALLOON_STATUS_REPORT event and its QMP query command
      hw/i386/pc: Support hv-balloon
      MAINTAINERS: Add an entry for Hyper-V Dynamic Memory Protocol

 Kconfig.host                              |    3 +
 MAINTAINERS                               |    8 +
 hw/core/machine-hmp-cmds.c                |   15 +
 hw/hyperv/Kconfig                         |   10 +
 hw/hyperv/hv-balloon-internal.h           |   33 +
 hw/hyperv/hv-balloon-our_range_memslots.c |  201 ++++
 hw/hyperv/hv-balloon-our_range_memslots.h |  110 ++
 hw/hyperv/hv-balloon-page_range_tree.c    |  228 ++++
 hw/hyperv/hv-balloon-page_range_tree.h    |  118 ++
 hw/hyperv/hv-balloon-stub.c               |   19 +
 hw/hyperv/hv-balloon.c                    | 1769 +++++++++++++++++++++++++++++
 hw/hyperv/meson.build                     |    1 +
 hw/hyperv/trace-events                    |   18 +
 hw/i386/Kconfig                           |    1 +
 hw/i386/pc.c                              |   22 +
 hw/mem/memory-device.c                    |   49 +-
 hw/virtio/virtio-pmem.c                   |    5 +-
 include/hw/hyperv/dynmem-proto.h          |  423 +++++++
 include/hw/hyperv/hv-balloon.h            |   18 +
 include/hw/mem/memory-device.h            |    7 +-
 meson.build                               |   28 +-
 meson_options.txt                         |    2 +
 monitor/monitor.c                         |    1 +
 qapi/machine.json                         |  101 +-
 scripts/meson-buildoptions.sh             |    3 +
 tests/qtest/qmp-cmd-test.c                |    1 +
 26 files changed, 3180 insertions(+), 14 deletions(-)
 create mode 100644 hw/hyperv/hv-balloon-internal.h
 create mode 100644 hw/hyperv/hv-balloon-our_range_memslots.c
 create mode 100644 hw/hyperv/hv-balloon-our_range_memslots.h
 create mode 100644 hw/hyperv/hv-balloon-page_range_tree.c
 create mode 100644 hw/hyperv/hv-balloon-page_range_tree.h
 create mode 100644 hw/hyperv/hv-balloon-stub.c
 create mode 100644 hw/hyperv/hv-balloon.c
 create mode 100644 include/hw/hyperv/dynmem-proto.h
 create mode 100644 include/hw/hyperv/hv-balloon.h

