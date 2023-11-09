Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8F87E6A44
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 13:03:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r13jQ-00023e-Kb; Thu, 09 Nov 2023 07:01:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r13jF-0001uR-BB
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:01:48 -0500
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r13jA-0001ej-LJ
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699531300; x=1731067300;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZAJ0x/kln1N8GBbunkErVBoWHAzNMD49jesg3OL/jL4=;
 b=NEHAAZIpznzBjvZVGlyxOvafatXGtm45riy19WwA23jA2MW1g0yDliy3
 idaNkRgAzK1nw8n8bvvP4QcGvuA+gZGHWcxn9DO0dxBlMGlroqKGIIeKW
 v0fb1iLfE4uVV8FgUJALnx8wZ+EAqEDsWrzALvNw0jKecnL9vSRlaaK/B
 YpcBrjrzesbdvq6k9vki1H9khgUp6ulL2puyeBNg+Ug3FDdGVv6fxe5Vv
 M372Pts3AYjzjis+35DDlSCgGplj6fOO+W4G/PUJI+OO2HRis9MeJ8r6z
 WaQDbJ3GSEY1WtX0jqwXTxfnVYWxhsKa6wB2UsbvYjH4UzPnO3CLuytXt g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="369305844"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; d="scan'208";a="369305844"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 04:01:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; d="scan'208";a="11516097"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 04:01:34 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 11/20] vfio/platform: Allow the selection of a given iommu
 backend
Date: Thu,  9 Nov 2023 19:45:20 +0800
Message-Id: <20231109114529.1904193-12-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
References: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 include/hw/vfio/vfio-platform.h | 1 +
 hw/vfio/platform.c              | 5 +++++
 2 files changed, 6 insertions(+)

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
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 8e3d4ac458..86e176ee97 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -15,6 +15,7 @@
  */
 
 #include "qemu/osdep.h"
+#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
 #include "qapi/error.h"
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
@@ -649,6 +650,10 @@ static Property vfio_platform_dev_properties[] = {
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


