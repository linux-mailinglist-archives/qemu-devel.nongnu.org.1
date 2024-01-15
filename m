Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFF082D708
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:18:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPK1D-0007fe-MF; Mon, 15 Jan 2024 05:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPK1B-0007f9-0O
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:16:33 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPK18-0007OP-UM
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705313790; x=1736849790;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=17c0COtBuoW99QpVJLPDdLL1AX5u6nkzdn4+JzBln0w=;
 b=BpX91YLxIHofBHvyETRkLSSLTGYYX0RcZi6ppiHpQLT9KODBG+n/Y6Pi
 efos8Y3Y1IHBXWAA3A/AgmvDdcgUnvVXL7j8CP5mJOS9LqM1JKsuAuQfl
 mcxT3hnHjRZzSP3+ZSIcKVW9zGvSB+gk2kAc3WfTV3okZHNi/1PPpD2rJ
 /9zgRBApsZcGzZaiC6HmRi0PMRUtiSFoiJ3HU1uHDcT4XP8msGHlDGAeD
 T4UDIeU12IFR0w6CeXDG4l7GKLut/dowJkHS4gUe+/guXd6MCYDjvzfr6
 YP/PqJ3sOYHDq6+VTx/lgLaF2eviB+nBCmj2ZBrKbymf8D3TUNsHEZJDX Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="390032452"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="390032452"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:16:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="1030599485"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="1030599485"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:16:24 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>
Subject: [PATCH rfcv1 1/6] backends/iommufd_device: introduce IOMMUFDDevice
Date: Mon, 15 Jan 2024 18:13:08 +0800
Message-Id: <20240115101313.131139-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115101313.131139-1-zhenzhong.duan@intel.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

IOMMUFDDevice represents a device in iommufd and can be used as
a communication interface between devices (i.e., VFIO, VDPA) and
vIOMMU.

Currently it includes iommufd handler and device id information
which could be used by vIOMMU to get hw IOMMU information.

In future nested translation support, vIOMMU is going to have
more iommufd related operations like allocate hwpt for a device,
attach/detach hwpt, etc. So IOMMUFDDevice will be further expanded.

IOMMUFDDevice is willingly not a QOM object because we don't want
it to be visible from the user interface.

Introduce a helper iommufd_device_init to initialize IOMMUFDDevice.

Originally-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 MAINTAINERS                     |  4 +--
 include/sysemu/iommufd_device.h | 31 ++++++++++++++++++++
 backends/iommufd_device.c       | 50 +++++++++++++++++++++++++++++++++
 backends/meson.build            |  2 +-
 4 files changed, 84 insertions(+), 3 deletions(-)
 create mode 100644 include/sysemu/iommufd_device.h
 create mode 100644 backends/iommufd_device.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 00ec1f7eca..606dfeb2b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2171,8 +2171,8 @@ M: Yi Liu <yi.l.liu@intel.com>
 M: Eric Auger <eric.auger@redhat.com>
 M: Zhenzhong Duan <zhenzhong.duan@intel.com>
 S: Supported
-F: backends/iommufd.c
-F: include/sysemu/iommufd.h
+F: backends/iommufd*.c
+F: include/sysemu/iommufd*.h
 F: include/qemu/chardev_open.h
 F: util/chardev_open.c
 F: docs/devel/vfio-iommufd.rst
diff --git a/include/sysemu/iommufd_device.h b/include/sysemu/iommufd_device.h
new file mode 100644
index 0000000000..795630324b
--- /dev/null
+++ b/include/sysemu/iommufd_device.h
@@ -0,0 +1,31 @@
+/*
+ * IOMMUFD Device
+ *
+ * Copyright (C) 2024 Intel Corporation.
+ *
+ * Authors: Yi Liu <yi.l.liu@intel.com>
+ *          Zhenzhong Duan <zhenzhong.duan@intel.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef SYSEMU_IOMMUFD_DEVICE_H
+#define SYSEMU_IOMMUFD_DEVICE_H
+
+#include <linux/iommufd.h>
+#include "sysemu/iommufd.h"
+
+typedef struct IOMMUFDDevice IOMMUFDDevice;
+
+/* This is an abstraction of host IOMMUFD device */
+struct IOMMUFDDevice {
+    IOMMUFDBackend *iommufd;
+    uint32_t dev_id;
+};
+
+int iommufd_device_get_info(IOMMUFDDevice *idev,
+                            enum iommu_hw_info_type *type,
+                            uint32_t len, void *data);
+void iommufd_device_init(void *_idev, size_t instance_size,
+                         IOMMUFDBackend *iommufd, uint32_t dev_id);
+#endif
diff --git a/backends/iommufd_device.c b/backends/iommufd_device.c
new file mode 100644
index 0000000000..f6e7ca1dbf
--- /dev/null
+++ b/backends/iommufd_device.c
@@ -0,0 +1,50 @@
+/*
+ * QEMU abstract of Host IOMMU
+ *
+ * Copyright (C) 2024 Intel Corporation.
+ *
+ * Authors: Yi Liu <yi.l.liu@intel.com>
+ *          Zhenzhong Duan <zhenzhong.duan@intel.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/ioctl.h>
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "sysemu/iommufd_device.h"
+
+int iommufd_device_get_info(IOMMUFDDevice *idev,
+                            enum iommu_hw_info_type *type,
+                            uint32_t len, void *data)
+{
+    struct iommu_hw_info info = {
+        .size = sizeof(info),
+        .flags = 0,
+        .dev_id = idev->dev_id,
+        .data_len = len,
+        .__reserved = 0,
+        .data_uptr = (uintptr_t)data,
+    };
+    int ret;
+
+    ret = ioctl(idev->iommufd->fd, IOMMU_GET_HW_INFO, &info);
+    if (ret) {
+        error_report("Failed to get info %m");
+    } else {
+        *type = info.out_data_type;
+    }
+
+    return ret;
+}
+
+void iommufd_device_init(void *_idev, size_t instance_size,
+                         IOMMUFDBackend *iommufd, uint32_t dev_id)
+{
+    IOMMUFDDevice *idev = (IOMMUFDDevice *)_idev;
+
+    g_assert(sizeof(IOMMUFDDevice) <= instance_size);
+
+    idev->iommufd = iommufd;
+    idev->dev_id = dev_id;
+}
diff --git a/backends/meson.build b/backends/meson.build
index 8b2b111497..c437cdb363 100644
--- a/backends/meson.build
+++ b/backends/meson.build
@@ -24,7 +24,7 @@ if have_vhost_user
   system_ss.add(when: 'CONFIG_VIRTIO', if_true: files('vhost-user.c'))
 endif
 system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost.c'))
-system_ss.add(when: 'CONFIG_IOMMUFD', if_true: files('iommufd.c'))
+system_ss.add(when: 'CONFIG_IOMMUFD', if_true: files('iommufd.c', 'iommufd_device.c'))
 if have_vhost_user_crypto
   system_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('cryptodev-vhost-user.c'))
 endif
-- 
2.34.1


