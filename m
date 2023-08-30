Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B6978D540
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 12:54:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbIqR-0007qd-4K; Wed, 30 Aug 2023 06:54:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qbIqC-00077c-RF
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:54:30 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qbIqA-0007jr-JV
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693392866; x=1724928866;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Jtq4e94jA0ux1suwGHaBOKa+ScqEJ7SBkRfAuQrbB4E=;
 b=Y2a299klQS2gt8AmJtEQZ14+uba897Im0jxi+RJ9gB/7LXeYZLpWrdH7
 BfjHOF/dFbJBWq+qPu6Cl7DcPpfInreyfZaLx1AegGWu9K1VTs5pIlOei
 LZeJTrNKNdcS3sfD1IC87+K4+jrs5NtMYjoJHbUQ3vNS89skaTWKM1BHu
 aj5JE9bVntfSSb5h7RMwhNIb9vtrwXP4oN509QowORfpS6GjRDNMD1urd
 0+voJjbgrL6m/Pkudqdx7SrtA0uIjTJTtN6CsMcHVbbTjG77Ti4TRy8d/
 QGQyMbhNQHDrWTnFIGunEGUkzYFI5HMZkdPunlDnyluIwTqViOBD/cmsB w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="373016725"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; d="scan'208";a="373016725"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2023 03:54:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="715866306"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; d="scan'208";a="715866306"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2023 03:54:00 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v1 21/22] vfio/pci: Allow the selection of a given iommu
 backend
Date: Wed, 30 Aug 2023 18:37:53 +0800
Message-Id: <20230830103754.36461-22-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830103754.36461-1-zhenzhong.duan@intel.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.93;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Note the /dev/iommu device may have been pre-opened by a
management tool such as libvirt. This mode is no more considered
for the legacy backend. So let's remove the "TODO" comment.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 3a8fee3c99..99265253f8 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -43,6 +43,7 @@
 #include "migration/blocker.h"
 #include "migration/qemu-file.h"
 #include "linux/iommufd.h"
+#include "sysemu/iommufd.h"
 
 #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
 
@@ -3611,11 +3612,10 @@ static Property vfio_pci_dev_properties[] = {
                                    qdev_prop_nv_gpudirect_clique, uint8_t),
     DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
                                 OFF_AUTOPCIBAR_OFF),
-    /*
-     * TODO - support passed fds... is this necessary?
-     * DEFINE_PROP_STRING("vfiofd", VFIOPCIDevice, vfiofd_name),
-     * DEFINE_PROP_STRING("vfiogroupfd, VFIOPCIDevice, vfiogroupfd_name),
-     */
+#ifdef CONFIG_IOMMUFD
+    DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
+                     TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
+#endif
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.34.1


