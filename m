Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C86D9750041
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 09:41:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJUTF-0007gA-3e; Wed, 12 Jul 2023 03:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJUT3-0006xA-1V
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:40:59 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qJUT0-0006oM-VZ
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 03:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689147654; x=1720683654;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=apMBFuT5bB9quYcKUjAClkvNLolYixzVgGegQnDwoMA=;
 b=LYuzbswIrjB93YxrINzKSQVi7yOL2/wMTsqMo+8/EAUVilf0DJR90UZK
 lJ3JOoKkfaAZ+XMMJg/g/ybgHwQCCA15n9ca6ovsQ0e7xsWkAvjgAaiYh
 xJDaq0jByXTvcusgIGf+RiHaSlZklxmDu6HWNZ+Du9fmAI+hchtcp4bv8
 cxA7IGYCupAZ7/n0Mrrn1VrZaOmnfXuWYXqF5ti44xoBpuFWkX6deoY7G
 UnS8cpMQvg0HIPN0z5nqFxI9EkScCZUTpe8bEALCTRrTBAhboHUmCnbeI
 mVodTT1sPGH/dMpQyeCaaWBh5/QMLtyHssDlSvkzkXRqf/7ViSSrD/246 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="430953877"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="430953877"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:40:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="835024175"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; d="scan'208";a="835024175"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2023 00:40:19 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, eric.auger@redhat.com, peterx@redhat.com,
 jasonwang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [RFC PATCH v4 23/24] vfio/as: Allow the selection of a given iommu
 backend
Date: Wed, 12 Jul 2023 15:25:27 +0800
Message-Id: <20230712072528.275577-24-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712072528.275577-1-zhenzhong.duan@intel.com>
References: <20230712072528.275577-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=zhenzhong.duan@intel.com; helo=mga07.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 hw/vfio/pci.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 6e49ac5ee9..9aa6c21200 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -43,6 +43,7 @@
 #include "migration/blocker.h"
 #include "migration/qemu-file.h"
 #include "linux/iommufd.h"
+#include "sysemu/iommufd.h"
 
 #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
 
@@ -3175,6 +3176,15 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     char uuid[UUID_FMT_LEN];
     char *name;
 
+#ifdef CONFIG_IOMMUFD
+    if (vbasedev->iommufd) {
+        iommufd_backend_connect(vbasedev->iommufd, errp);
+        if (*errp) {
+            return;
+        }
+    }
+#endif
+
     if (!vbasedev->sysfsdev) {
         if (!(~vdev->host.domain || ~vdev->host.bus ||
               ~vdev->host.slot || ~vdev->host.function)) {
@@ -3470,6 +3480,9 @@ error:
 static void vfio_instance_finalize(Object *obj)
 {
     VFIOPCIDevice *vdev = VFIO_PCI(obj);
+#ifdef CONFIG_IOMMUFD
+    VFIODevice *vbasedev = &vdev->vbasedev;
+#endif
 
     vfio_display_finalize(vdev);
     vfio_bars_finalize(vdev);
@@ -3483,6 +3496,11 @@ static void vfio_instance_finalize(Object *obj)
      * g_free(vdev->igd_opregion);
      */
     vfio_put_device(vdev);
+#ifdef CONFIG_IOMMUFD
+    if (vbasedev->iommufd) {
+        iommufd_backend_disconnect(vbasedev->iommufd);
+    }
+#endif
 }
 
 static void vfio_exitfn(PCIDevice *pdev)
@@ -3609,11 +3627,10 @@ static Property vfio_pci_dev_properties[] = {
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


