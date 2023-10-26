Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5553D7D812D
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:50:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvxvJ-0004C5-9V; Thu, 26 Oct 2023 06:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxvG-000491-Vh
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:49:06 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxvF-0001Q0-A1
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698317345; x=1729853345;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6MR5WCo9v5L0Vdk2+6JvGxis64p5EfrrivNJ1aQxcac=;
 b=UqHnRX8s1sqG16bN6MKRtFvcWir+eLHmvVHNSdIguXMW6uUr/B4OYSAz
 d78JCTkAwqeeobmw7lvUj6/9Q9WOMuF/YS0rsesynHl7UgF2B2Gfau8yd
 LkOzJIoxIl8z6hB3B4vIxmjqLujrnCwvEbqnLuH5R6uWLr+J19MmKI+CK
 cg/wlLUamVEvnYt5iQcspDIE0icVhxNPliiu1ymlbeDDR60S5wwyjsEUM
 Hr+NBWMkYBvY9HpCHXmx6RzIOoepBkZVpVjR3aWKxrsCLSOVYJb/RxUku
 xWLGtXIGdlYraQOsWzzzYaiIEBFFvI/XNd7DLCFoiiFiDDSfnvaeGjmvz w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="372563813"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; d="scan'208";a="372563813"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:48:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="463846"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:48:04 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 32/37] vfio/pci: Allow the selection of a given iommu
 backend
Date: Thu, 26 Oct 2023 18:30:59 +0800
Message-Id: <20231026103104.1686921-33-zhenzhong.duan@intel.com>
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

From: Eric Auger <eric.auger@redhat.com>

Now we support two types of iommu backends, let's add the capability
to select one of them. This depends on whether an iommufd object has
been linked with the vfio-pci device:

if the user wants to use the legacy backend, it shall not
link the vfio-pci device with any iommufd object:

-device vfio-pci,host=0000:02:00.0

This is called the legacy mode/backend.

If the user wants to use the iommufd backend (/dev/iommu) it
shall pass an iommufd object id in the vfio-pci device options:

 -object iommufd,id=iommufd0
 -device vfio-pci,host=0000:02:00.0,iommufd=iommufd0

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d7a41c8def..386c08576a 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -43,6 +43,7 @@
 #include "migration/blocker.h"
 #include "migration/qemu-file.h"
 #include "linux/iommufd.h"
+#include "sysemu/iommufd.h"
 
 #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
 
@@ -3710,6 +3711,10 @@ static Property vfio_pci_dev_properties[] = {
      * DEFINE_PROP_STRING("vfiofd", VFIOPCIDevice, vfiofd_name),
      * DEFINE_PROP_STRING("vfiogroupfd, VFIOPCIDevice, vfiogroupfd_name),
      */
+#ifdef CONFIG_IOMMUFD
+    DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
+                     TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
+#endif
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.34.1


