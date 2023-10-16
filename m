Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF497CA249
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:48:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJGG-0007Xo-VV; Mon, 16 Oct 2023 04:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJG7-0007Wo-PM
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:47:32 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qsJG5-00018h-5X
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697446049; x=1728982049;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dRKZOMcB1np/FNbBw+R0wRE7DGXaXjC9Dz9CMIH3KBQ=;
 b=cbr0mnwSZp5VfnJEtYo5oLv1e6s5fVfpgWHCaMXd6eaIahiA+QPramwj
 qg8TyugKJeoNBoJZ3BmWDfBhT4TKnawro5qyFe0XzGjhe6+2bt9u5EXNY
 7KG4Ul7boot7g/tpfhqsTsQdBcgckYAkPhKUDwEcZvicPGkPw74HNZzKX
 nrkGBDTJCp0sh5FyOHoD9cFeJqtVt1wnsoOVmSyYvr3uv4PEsKMJcYevc
 TTmGuN6Xy+MpBFOG3mHSGuiSyj6KgvqfoRGFeLrlwAzU17fEY9UWEg0rR
 tHenr/VTJUGteCJ7/k09XaiYr6JTZIUiZdGl4l0XIHO9j17KzcDP5ZyWH w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365737528"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="365737528"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:47:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="749222695"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; d="scan'208";a="749222695"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2023 01:47:24 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 03/27] VFIO/container: Introduce dummy VFIOContainerClass
 implementation
Date: Mon, 16 Oct 2023 16:31:59 +0800
Message-Id: <20231016083223.1519410-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
References: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.151;
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

Let's instantiate a dummy VFIOContainerClass implementation whose
functions are not yet implemented.

No fucntional change intended.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-container-base.h |  1 +
 hw/vfio/container-base.c              | 40 +++++++++++++++++++++++++++
 hw/vfio/container.c                   | 22 +++++++++++++++
 hw/vfio/meson.build                   |  1 +
 4 files changed, 64 insertions(+)
 create mode 100644 hw/vfio/container-base.c

diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
index afc8543d22..226e960fb5 100644
--- a/include/hw/vfio/vfio-container-base.h
+++ b/include/hw/vfio/vfio-container-base.h
@@ -46,6 +46,7 @@ struct VFIOContainer {
     VFIOIOMMUBackendOpsClass *ops;
 };
 
+#define TYPE_VFIO_IOMMU_BACKEND_LEGACY_OPS "vfio-iommu-backend-legacy-ops"
 #define TYPE_VFIO_IOMMU_BACKEND_OPS "vfio-iommu-backend-ops"
 
 DECLARE_CLASS_CHECKERS(VFIOIOMMUBackendOpsClass,
diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
new file mode 100644
index 0000000000..0c21e77039
--- /dev/null
+++ b/hw/vfio/container-base.c
@@ -0,0 +1,40 @@
+/*
+ * VFIO BASE CONTAINER
+ *
+ * Copyright (C) 2023 Intel Corporation.
+ * Copyright Red Hat, Inc. 2023
+ *
+ * Authors: Yi Liu <yi.l.liu@intel.com>
+ *          Eric Auger <eric.auger@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "hw/vfio/vfio-container-base.h"
+
+static const TypeInfo vfio_iommu_backend_ops_type_info = {
+    .name = TYPE_VFIO_IOMMU_BACKEND_OPS,
+    .parent = TYPE_OBJECT,
+    .abstract = true,
+    .class_size = sizeof(VFIOIOMMUBackendOpsClass),
+};
+
+static void vfio_iommu_backend_ops_register_types(void)
+{
+    type_register_static(&vfio_iommu_backend_ops_type_info);
+}
+type_init(vfio_iommu_backend_ops_register_types);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 8fde302ae9..acc4a6bf8a 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -539,6 +539,9 @@ static void vfio_get_iommu_info_migration(VFIOLegacyContainer *container,
 static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
                                   Error **errp)
 {
+    VFIOIOMMUBackendOpsClass *ops = VFIO_IOMMU_BACKEND_OPS_CLASS(
+        object_class_by_name(TYPE_VFIO_IOMMU_BACKEND_LEGACY_OPS));
+    VFIOContainer *bcontainer;
     VFIOLegacyContainer *container;
     int ret, fd;
     VFIOAddressSpace *space;
@@ -620,6 +623,8 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     QLIST_INIT(&container->giommu_list);
     QLIST_INIT(&container->hostwin_list);
     QLIST_INIT(&container->vrdl_list);
+    bcontainer = &container->bcontainer;
+    bcontainer->ops = ops;
 
     ret = vfio_init_container(container, group->fd, errp);
     if (ret) {
@@ -1160,3 +1165,20 @@ void vfio_detach_device(VFIODevice *vbasedev)
     vfio_put_base_device(vbasedev);
     vfio_put_group(group);
 }
+
+static void vfio_iommu_backend_legacy_ops_class_init(ObjectClass *oc,
+                                                     void *data) {
+}
+
+static const TypeInfo vfio_iommu_backend_legacy_ops_type = {
+    .name = TYPE_VFIO_IOMMU_BACKEND_LEGACY_OPS,
+
+    .parent = TYPE_VFIO_IOMMU_BACKEND_OPS,
+    .class_init = vfio_iommu_backend_legacy_ops_class_init,
+    .abstract = true,
+};
+static void vfio_iommu_backend_legacy_ops_register_types(void)
+{
+    type_register_static(&vfio_iommu_backend_legacy_ops_type);
+}
+type_init(vfio_iommu_backend_legacy_ops_register_types);
diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
index 2a6912c940..eb6ce6229d 100644
--- a/hw/vfio/meson.build
+++ b/hw/vfio/meson.build
@@ -2,6 +2,7 @@ vfio_ss = ss.source_set()
 vfio_ss.add(files(
   'helpers.c',
   'common.c',
+  'container-base.c',
   'container.c',
   'spapr.c',
   'migration.c',
-- 
2.34.1


