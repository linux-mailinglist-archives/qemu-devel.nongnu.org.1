Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3887F27E4
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 09:48:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5MPf-0006S1-B2; Tue, 21 Nov 2023 03:47:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MPX-0006RV-Dy
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:47:11 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5MPS-0001cK-G6
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 03:47:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700556426; x=1732092426;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QE9y/ZL0Q6TcsW6wcCz4QOTYfnkF+XmxMxjbI4QMbHw=;
 b=WMHebBqldiMRR44hkg6lvqT0VWCYl7lRxey+a4fjV2a0yWMwJreZ18Dm
 O3en278OoQJaj3JCTyb8kf1CeWzoxKwCmhJIfvNItQ/wOQp+AeSz3i4Pc
 9wa1RlLymvyM9lGhFludgFGQjMpT7h0gvPL+N+xJZfLZ/qN1XwlnNByYM
 qXhViaIEQYyQsku0tctNGVB5djLZd2WSfDhdudqZe0oQOkzlHlOe0OomY
 eJgyxWZq3qp5WYvrEJ+L2OYz/v303y27svGnZVjAxlDFU7HT9vZmJwMSc
 LriX40ZMEjtsURxd3a+LigbpIdHpAT22PLUpE7ya6OcKaNE3rXY0po0ZF Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="395722126"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="395722126"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:47:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="884124939"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="884124939"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 00:46:52 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com
Subject: [PATCH v7 10/27] vfio/pci: Allow the selection of a given iommu
 backend
Date: Tue, 21 Nov 2023 16:44:09 +0800
Message-Id: <20231121084426.1286987-11-zhenzhong.duan@intel.com>
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

From: Eric Auger <eric.auger@redhat.com>

Now we support two types of iommu backends, let's add the capability
to select one of them. This depends on whether an iommufd object has
been linked with the vfio-pci device:

If the user wants to use the legacy backend, it shall not
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
---
 hw/vfio/pci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d00c3472c7..c5984b0598 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
 #include <linux/vfio.h>
 #include <sys/ioctl.h>
 
@@ -42,6 +43,7 @@
 #include "qapi/error.h"
 #include "migration/blocker.h"
 #include "migration/qemu-file.h"
+#include "sysemu/iommufd.h"
 
 #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
 
@@ -3386,6 +3388,10 @@ static Property vfio_pci_dev_properties[] = {
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


