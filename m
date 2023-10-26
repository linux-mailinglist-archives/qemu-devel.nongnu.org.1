Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A8A7D812F
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:51:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvxvc-0004kI-Cx; Thu, 26 Oct 2023 06:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxvZ-0004hD-RP; Thu, 26 Oct 2023 06:49:25 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxvX-0001Nv-Vm; Thu, 26 Oct 2023 06:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698317364; x=1729853364;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xAVnyoxQjXc6bTchK6lRpYFZlZKjJeNFs/piATVUzLM=;
 b=E17aznTY05Qed/gwfO9hhVaiSveKKLpEZvZOaZqKN82lLE31dmgBiDZu
 E6q5fDHZCT+EyCuiv5AJ+BHgw3sn1vNSsDYeQZVjXGlfnY8lsdudAV51l
 Nn5xPD0yRULYikAoyx1Vrzs403l9TEGe/klBh0JfqITxdXkYlTZYVGz/t
 OhxurImH996M8cT/MH8wqzi/SK5mD0zXNa+5jvBbLPuvLJuiVfkvo7H5j
 oWx3zKLaMW4dlLMDkUc7uu/Pu+gf0HZCJpjzWjk46jtOf5OJ8nr2pNWZF
 cfuEQScCZqiuweqHqqz0xUnXV66Ej+eU8vRH6O2dLfv9UcM94hl13PiPf w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="372563852"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; d="scan'208";a="372563852"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:48:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="463874"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:48:11 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, Thomas Huth <thuth@redhat.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:S390 general arch...)
Subject: [PATCH v3 34/37] vfio: Allow the selection of a given iommu backend
 for platform ap and ccw
Date: Thu, 26 Oct 2023 18:31:01 +0800
Message-Id: <20231026103104.1686921-35-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Previously we added support to select iommu backend for vfio pci
device. Now we added others, E.g: platform, ap and ccw.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/vfio/vfio-platform.h | 1 +
 hw/vfio/ap.c                    | 5 +++++
 hw/vfio/ccw.c                   | 5 +++++
 hw/vfio/platform.c              | 4 ++++
 4 files changed, 15 insertions(+)

diff --git a/include/hw/vfio/vfio-platform.h b/include/hw/vfio/vfio-platform.h
index c414c3dffc..f57f4276f2 100644
--- a/include/hw/vfio/vfio-platform.h
+++ b/include/hw/vfio/vfio-platform.h
@@ -18,6 +18,7 @@
 
 #include "hw/sysbus.h"
 #include "hw/vfio/vfio-common.h"
+#include "sysemu/iommufd.h"
 #include "qemu/event_notifier.h"
 #include "qemu/queue.h"
 #include "qom/object.h"
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index bbf69ff55a..6a4186ccd3 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -15,6 +15,7 @@
 #include <sys/ioctl.h>
 #include "qapi/error.h"
 #include "hw/vfio/vfio-common.h"
+#include "sysemu/iommufd.h"
 #include "hw/s390x/ap-device.h"
 #include "qemu/error-report.h"
 #include "qemu/event_notifier.h"
@@ -204,6 +205,10 @@ static void vfio_ap_unrealize(DeviceState *dev)
 
 static Property vfio_ap_properties[] = {
     DEFINE_PROP_STRING("sysfsdev", VFIOAPDevice, vdev.sysfsdev),
+#ifdef CONFIG_IOMMUFD
+    DEFINE_PROP_LINK("iommufd", VFIOAPDevice, vdev.iommufd,
+                     TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
+#endif
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index d857bb8d0f..7695ede0fc 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -21,6 +21,7 @@
 
 #include "qapi/error.h"
 #include "hw/vfio/vfio-common.h"
+#include "sysemu/iommufd.h"
 #include "hw/s390x/s390-ccw.h"
 #include "hw/s390x/vfio-ccw.h"
 #include "hw/qdev-properties.h"
@@ -677,6 +678,10 @@ static void vfio_ccw_unrealize(DeviceState *dev)
 static Property vfio_ccw_properties[] = {
     DEFINE_PROP_STRING("sysfsdev", VFIOCCWDevice, vdev.sysfsdev),
     DEFINE_PROP_BOOL("force-orb-pfch", VFIOCCWDevice, force_orb_pfch, false),
+#ifdef CONFIG_IOMMUFD
+    DEFINE_PROP_LINK("iommufd", VFIOCCWDevice, vdev.iommufd,
+                     TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
+#endif
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 8e3d4ac458..a1c25e0337 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -649,6 +649,10 @@ static Property vfio_platform_dev_properties[] = {
     DEFINE_PROP_UINT32("mmap-timeout-ms", VFIOPlatformDevice,
                        mmap_timeout, 1100),
     DEFINE_PROP_BOOL("x-irqfd", VFIOPlatformDevice, irqfd_allowed, true),
+#ifdef CONFIG_IOMMUFD
+    DEFINE_PROP_LINK("iommufd", VFIOPlatformDevice, vbasedev.iommufd,
+                     TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
+#endif
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.34.1


