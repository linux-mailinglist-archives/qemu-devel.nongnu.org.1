Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EE27EAE0E
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 11:29:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2qco-0003U9-6f; Tue, 14 Nov 2023 05:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2qce-0003O9-Uh
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:26:21 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2qcd-0007jy-AU
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:26:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699957579; x=1731493579;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1AlHdGy5eNf79L0VomzlegbQcv+r71rrv0zOhI6kYCM=;
 b=QW6zAsvOiGzh3ErAyiiJbOfsKbVONWCikdYIMNgt97zoq8Vzh0e9Fis6
 KHiDD9JIgIIzu2eJaDsle0ahOmmOg54bKy6HyDfnD0j0riMuz3HCjAzCO
 5ingKbyA0og/3rf63+8eyeRX5pW+1jlAMe1wUjXHDpgfEHiajJiRvKso4
 h9LnW+9ehW4tGlOfZ0uM+hBDThShUDjjH9+rTZi1Peo5Z/JlqcDqRaGX1
 l56TeytILw0DTUo1YvjR7GBLKXopFRrd9LDnZeHyP96gvlx7a+GXrq06I
 O5hV1ct3iA4pg2obzYfLbum2c+PxYCI/w8aD7XOOB9wE/DpnZ9jj9puhe w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="394543554"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; d="scan'208";a="394543554"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 02:26:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="888213075"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; d="scan'208";a="888213075"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 02:26:14 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 12/21] vfio/platform: Allow the selection of a given iommu
 backend
Date: Tue, 14 Nov 2023 18:09:46 +0800
Message-Id: <20231114100955.1961974-13-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Now we support two types of iommu backends, let's add the capability
to select one of them. This depends on whether an iommufd object has
been linked with the vfio-platform device:

If the user wants to use the legacy backend, it shall not
link the vfio-platform device with any iommufd object:

 -device vfio-platform,host=XXX

This is called the legacy mode/backend.

If the user wants to use the iommufd backend (/dev/iommu) it
shall pass an iommufd object id in the vfio-platform device options:

 -object iommufd,id=iommufd0
 -device vfio-platform,host=XXX,iommufd=iommufd0

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
v6: Move #include "sysemu/iommufd.h" in platform.c

 hw/vfio/platform.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 8e3d4ac458..98ae4bc655 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -15,11 +15,13 @@
  */
 
 #include "qemu/osdep.h"
+#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
 #include "qapi/error.h"
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
 
 #include "hw/vfio/vfio-platform.h"
+#include "sysemu/iommufd.h"
 #include "migration/vmstate.h"
 #include "qemu/error-report.h"
 #include "qemu/lockable.h"
@@ -649,6 +651,10 @@ static Property vfio_platform_dev_properties[] = {
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


