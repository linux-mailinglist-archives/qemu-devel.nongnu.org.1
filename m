Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 753CC7F27EC
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 09:48:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5MR9-0004oO-U1; Tue, 21 Nov 2023 03:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MR8-0004fM-9m
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:48:50 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MR6-0002Dl-0v
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700556528; x=1732092528;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kQ9IDrP9QE9vNS1P0Ei1YI0Qvu8bWOKghkTr3//VaAQ=;
 b=K3i+22e/4Fo0378hAmF1z72GDxHaqM5nvqC462304ajBQYEXtHze03AQ
 yEa0v0b+TRjftHKX31KuutQfTc/9Z91b+GSsFBK4kTmwNRHLdWMm1b2Lb
 FaBYK/CYW6VhXYi+gYCAFxtmjrUgnxrNGe6sbm4WPyS3dSiPV62W3kb/X
 xybdGDnyzoEBjwupMwecLcEBv5zVJYSafoE3kiRwKaF7V1nwmqHM4NoLI
 jzM0i8vp16IcAbD9nL14fXUZe6uku5Ck2m1XfM8HmZa110ujXOMJLZVNk
 RaVXEKAiDQh/hfwV7bX/aYdAIQLjkcPR8eNd9v821yIa5djjy6Z/gVBVx A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="395722394"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="395722394"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:48:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="884125290"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="884125290"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:48:08 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com
Subject: [PATCH v7 27/27] docs/devel: Add VFIO iommufd backend documentation
Date: Tue, 21 Nov 2023 16:44:26 +0800
Message-Id: <20231121084426.1286987-28-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
References: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 MAINTAINERS                    |   1 +
 docs/devel/index-internals.rst |   1 +
 docs/devel/vfio-iommufd.rst    | 166 +++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+)
 create mode 100644 docs/devel/vfio-iommufd.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index ca70bb4e64..0ddb20a35f 100644
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
index 6f81df92bc..3def4a138b 100644
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
index 0000000000..3d1c11f175
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
2.34.1


