Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09021819056
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:06:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfLc-0000Na-EY; Tue, 19 Dec 2023 14:01:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfLF-0007t3-Q9
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:01:25 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=7/MV=H6=redhat.com=clg@ozlabs.org>)
 id 1rFfKm-0007ux-6w
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:00:54 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SvmHQ11CMz4x2V;
 Wed, 20 Dec 2023 06:00:50 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SvmHK3fhsz4xS7;
 Wed, 20 Dec 2023 06:00:45 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: [PULL 46/47] docs/devel: Add VFIO iommufd backend documentation
Date: Tue, 19 Dec 2023 19:56:42 +0100
Message-ID: <20231219185643.725448-47-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219185643.725448-1-clg@redhat.com>
References: <20231219185643.725448-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=7/MV=H6=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 MAINTAINERS                    |   1 +
 docs/devel/index-internals.rst |   1 +
 docs/devel/vfio-iommufd.rst    | 166 +++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+)
 create mode 100644 docs/devel/vfio-iommufd.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index ca70bb4e6415fc3af110cc7fd37ac67be5ab8c9d..0ddb20a35f205dba3b437c33bf489a53ecfc36b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2176,6 +2176,7 @@ F: backends/iommufd.c
 F: include/sysemu/iommufd.h
 F: include/qemu/chardev_open.h
 F: util/chardev_open.c
+F: docs/devel/vfio-iommufd.rst
 
 vhost
 M: Michael S. Tsirkin <mst@redhat.com>
diff --git a/docs/devel/index-internals.rst b/docs/devel/index-internals.rst
index 6f81df92bcaba790477aff1ccb51048409331950..3def4a138bae5eca5b564e0044c1c2e80b5bc07a 100644
--- a/docs/devel/index-internals.rst
+++ b/docs/devel/index-internals.rst
@@ -18,5 +18,6 @@ Details about QEMU's various subsystems including how to add features to them.
    s390-dasd-ipl
    tracing
    vfio-migration
+   vfio-iommufd
    writing-monitor-commands
    virtio-backends
diff --git a/docs/devel/vfio-iommufd.rst b/docs/devel/vfio-iommufd.rst
new file mode 100644
index 0000000000000000000000000000000000000000..3d1c11f175e5968e9f1519da70c9a0a6ced03995
--- /dev/null
+++ b/docs/devel/vfio-iommufd.rst
@@ -0,0 +1,166 @@
+===============================
+IOMMUFD BACKEND usage with VFIO
+===============================
+
+(Same meaning for backend/container/BE)
+
+With the introduction of iommufd, the Linux kernel provides a generic
+interface for user space drivers to propagate their DMA mappings to kernel
+for assigned devices. While the legacy kernel interface is group-centric,
+the new iommufd interface is device-centric, relying on device fd and iommufd.
+
+To support both interfaces in the QEMU VFIO device, introduce a base container
+to abstract the common part of VFIO legacy and iommufd container. So that the
+generic VFIO code can use either container.
+
+The base container implements generic functions such as memory_listener and
+address space management whereas the derived container implements callbacks
+specific to either legacy or iommufd. Each container has its own way to setup
+secure context and dma management interface. The below diagram shows how it
+looks like with both containers.
+
+::
+
+                      VFIO                           AddressSpace/Memory
+      +-------+  +----------+  +-----+  +-----+
+      |  pci  |  | platform |  |  ap |  | ccw |
+      +---+---+  +----+-----+  +--+--+  +--+--+     +----------------------+
+          |           |           |        |        |   AddressSpace       |
+          |           |           |        |        +------------+---------+
+      +---V-----------V-----------V--------V----+               /
+      |           VFIOAddressSpace              | <------------+
+      |                  |                      |  MemoryListener
+      |        VFIOContainerBase list           |
+      +-------+----------------------------+----+
+              |                            |
+              |                            |
+      +-------V------+            +--------V----------+
+      |   iommufd    |            |    vfio legacy    |
+      |  container   |            |     container     |
+      +-------+------+            +--------+----------+
+              |                            |
+              | /dev/iommu                 | /dev/vfio/vfio
+              | /dev/vfio/devices/vfioX    | /dev/vfio/$group_id
+  Userspace   |                            |
+  ============+============================+===========================
+  Kernel      |  device fd                 |
+              +---------------+            | group/container fd
+              | (BIND_IOMMUFD |            | (SET_CONTAINER/SET_IOMMU)
+              |  ATTACH_IOAS) |            | device fd
+              |               |            |
+              |       +-------V------------V-----------------+
+      iommufd |       |                vfio                  |
+  (map/unmap  |       +---------+--------------------+-------+
+  ioas_copy)  |                 |                    | map/unmap
+              |                 |                    |
+       +------V------+    +-----V------+      +------V--------+
+       | iommfd core |    |  device    |      |  vfio iommu   |
+       +-------------+    +------------+      +---------------+
+
+* Secure Context setup
+
+  - iommufd BE: uses device fd and iommufd to setup secure context
+    (bind_iommufd, attach_ioas)
+  - vfio legacy BE: uses group fd and container fd to setup secure context
+    (set_container, set_iommu)
+
+* Device access
+
+  - iommufd BE: device fd is opened through ``/dev/vfio/devices/vfioX``
+  - vfio legacy BE: device fd is retrieved from group fd ioctl
+
+* DMA Mapping flow
+
+  1. VFIOAddressSpace receives MemoryRegion add/del via MemoryListener
+  2. VFIO populates DMA map/unmap via the container BEs
+     * iommufd BE: uses iommufd
+     * vfio legacy BE: uses container fd
+
+Example configuration
+=====================
+
+Step 1: configure the host device
+---------------------------------
+
+It's exactly same as the VFIO device with legacy VFIO container.
+
+Step 2: configure QEMU
+----------------------
+
+Interactions with the ``/dev/iommu`` are abstracted by a new iommufd
+object (compiled in with the ``CONFIG_IOMMUFD`` option).
+
+Any QEMU device (e.g. VFIO device) wishing to use ``/dev/iommu`` must
+be linked with an iommufd object. It gets a new optional property
+named iommufd which allows to pass an iommufd object. Take ``vfio-pci``
+device for example:
+
+.. code-block:: bash
+
+    -object iommufd,id=iommufd0
+    -device vfio-pci,host=0000:02:00.0,iommufd=iommufd0
+
+Note the ``/dev/iommu`` and VFIO cdev can be externally opened by a
+management layer. In such a case the fd is passed, the fd supports a
+string naming the fd or a number, for example:
+
+.. code-block:: bash
+
+    -object iommufd,id=iommufd0,fd=22
+    -device vfio-pci,iommufd=iommufd0,fd=23
+
+If the ``fd`` property is not passed, the fd is opened by QEMU.
+
+If no ``iommufd`` object is passed to the ``vfio-pci`` device, iommufd
+is not used and the user gets the behavior based on the legacy VFIO
+container:
+
+.. code-block:: bash
+
+    -device vfio-pci,host=0000:02:00.0
+
+Supported platform
+==================
+
+Supports x86, ARM and s390x currently.
+
+Caveats
+=======
+
+Dirty page sync
+---------------
+
+Dirty page sync with iommufd backend is unsupported yet, live migration is
+disabled by default. But it can be force enabled like below, low efficient
+though.
+
+.. code-block:: bash
+
+    -object iommufd,id=iommufd0
+    -device vfio-pci,host=0000:02:00.0,iommufd=iommufd0,enable-migration=on
+
+P2P DMA
+-------
+
+PCI p2p DMA is unsupported as IOMMUFD doesn't support mapping hardware PCI
+BAR region yet. Below warning shows for assigned PCI device, it's not a bug.
+
+.. code-block:: none
+
+    qemu-system-x86_64: warning: IOMMU_IOAS_MAP failed: Bad address, PCI BAR?
+    qemu-system-x86_64: vfio_container_dma_map(0x560cb6cb1620, 0xe000000021000, 0x3000, 0x7f32ed55c000) = -14 (Bad address)
+
+FD passing with mdev
+--------------------
+
+``vfio-pci`` device checks sysfsdev property to decide if backend is a mdev.
+If FD passing is used, there is no way to know that and the mdev is treated
+like a real PCI device. There is an error as below if user wants to enable
+RAM discarding for mdev.
+
+.. code-block:: none
+
+    qemu-system-x86_64: -device vfio-pci,iommufd=iommufd0,x-balloon-allowed=on,fd=9: vfio VFIO_FD9: x-balloon-allowed only potentially compatible with mdev devices
+
+``vfio-ap`` and ``vfio-ccw`` devices don't have same issue as their backend
+devices are always mdev and RAM discarding is force enabled.
-- 
2.43.0


