Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B127EEF41
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 10:52:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3vVA-000645-74; Fri, 17 Nov 2023 04:51:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3vV8-00062Y-05
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 04:51:02 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r3vV5-0004Xi-31
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 04:51:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700214659; x=1731750659;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=RBaxr8y9Mdf2qOw5U5xI19CvA75is2/21XbaG0DWxbY=;
 b=YCNbyEG35XtF/gGqbfXfColmtbstzpmbHqZx3rwu7HBEXQhabeIij3jw
 9A31Awg318q+xGL0AedMh8DYBwAjRrBzgC/lqWBC7wRqWclhXhLrq2OGt
 SB/93sxYhbeh84QtU27/SNs6updzemdjckplRpprluUgMlL3xCUefNNxp
 w6VPKBmj3u8B/zf35g55gYa1Z5PkHjXss+TVsjnz3IMSfiPGZ9agZkJgy
 y1p+VhenInHVas87wxlH1DA18YDMiu4lBZz1eOMlUpCDfHGdEf6DKP/Xg
 uP024jX2wSc8lHG4mB/G94mRmJHf7zu4rwt1mfvTvLAnNPJNwbPCSIViY w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="4411060"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="4411060"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2023 01:50:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="889188660"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; d="scan'208";a="889188660"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2023 01:50:50 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH] docs/devel: Add VFIO iommufd backend documentation
Date: Fri, 17 Nov 2023 17:35:12 +0800
Message-Id: <20231117093512.1999666-1-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 MAINTAINERS                    |   1 +
 docs/devel/index-internals.rst |   1 +
 docs/devel/vfio-iommufd.rst    | 115 +++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+)
 create mode 100644 docs/devel/vfio-iommufd.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index d86ba56a49..07990456ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2175,6 +2175,7 @@ F: backends/iommufd.c
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
index 0000000000..59804a7f26
--- /dev/null
+++ b/docs/devel/vfio-iommufd.rst
@@ -0,0 +1,115 @@
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
+                    VFIO                           AddressSpace/Memory
+    +-------+  +----------+  +-----+  +-----+
+    |  pci  |  | platform |  |  ap |  | ccw |
+    +---+---+  +----+-----+  +--+--+  +--+--+     +----------------------+
+        |           |           |        |        |   AddressSpace       |
+        |           |           |        |        +------------+---------+
+    +---V-----------V-----------V--------V----+               /
+    |           VFIOAddressSpace              | <------------+
+    |                  |                      |  MemoryListener
+    |        VFIOContainerBase list           |
+    +-------+----------------------------+----+
+            |                            |
+            |                            |
+    +-------V------+            +--------V----------+
+    |   iommufd    |            |    vfio legacy    |
+    |  container   |            |     container     |
+    +-------+------+            +--------+----------+
+            |                            |
+            | /dev/iommu                 | /dev/vfio/vfio
+            | /dev/vfio/devices/vfioX    | /dev/vfio/$group_id
+Userspace   |                            |
+============+============================+===========================
+Kernel      |  device fd                 |
+            +---------------+            | group/container fd
+            | (BIND_IOMMUFD |            | (SET_CONTAINER/SET_IOMMU)
+            |  ATTACH_IOAS) |            | device fd
+            |               |            |
+            |       +-------V------------V-----------------+
+    iommufd |       |                vfio                  |
+(map/unmap  |       +---------+--------------------+-------+
+ioas_copy)  |                 |                    | map/unmap
+            |                 |                    |
+     +------V------+    +-----V------+      +------V--------+
+     | iommfd core |    |  device    |      |  vfio iommu   |
+     +-------------+    +------------+      +---------------+
+
+[Secure Context setup]
+- iommufd BE: uses device fd and iommufd to setup secure context
+              (bind_iommufd, attach_ioas)
+- vfio legacy BE: uses group fd and container fd to setup secure context
+                  (set_container, set_iommu)
+
+[Device access]
+- iommufd BE: device fd is opened through /dev/vfio/devices/vfioX
+- vfio legacy BE: device fd is retrieved from group fd ioctl
+
+[DMA Mapping flow]
+1. VFIOAddressSpace receives MemoryRegion add/del via MemoryListener
+2. VFIO populates DMA map/unmap via the container BEs
+   *) iommufd BE: uses iommufd
+   *) vfio legacy BE: uses container fd
+
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
+Interactions with the /dev/iommu are abstracted by a new
+iommufd object (compiled in with the CONFIG_IOMMUFD option).
+
+Any QEMU device (e.g. VFIO device) wishing to use /dev/iommu must be
+linked with an iommufd object. It gets a new optional property named
+iommufd which allows to pass an iommufd object. Take vfio-pci device
+for example:
+
+    -object iommufd,id=iommufd0
+    -device vfio-pci,host=0000:02:00.0,iommufd=iommufd0
+
+Note the /dev/iommu and VFIO cdev can be externally opened by a
+management layer. In such a case the fd is passed, the fd supports
+a string naming the fd or a number, for example:
+
+    -object iommufd,id=iommufd0,fd=22
+    -device vfio-pci,iommufd=iommufd0,fd=23
+
+If the fd property is not passed, the fd is opened by QEMU.
+
+If no iommufd property is passed to the vfio-pci device, iommufd is
+not used and the user gets the behavior based on the legacy VFIO
+container:
+
+    -device vfio-pci,host=0000:02:00.0
+
+Supported platform
+==================
+
+Supports X86, ARM and S390X currently.
-- 
2.34.1


