Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C1F7DED47
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 08:30:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyS8S-0003KG-49; Thu, 02 Nov 2023 03:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS8Q-0003K1-Dl
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:28:58 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qyS8O-0003Iu-QE
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 03:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698910136; x=1730446136;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aqP0d+Qvoe4ddCUwjKIo+Uc/4pcxFrWytxjiZV15aVY=;
 b=Sh6rDlBfpYKw7Z3m/ZDz2myoj7MMw2QNwvUT1JfuadRaX9V6xiSbRoC/
 2c3eZcyH/HPF7JvLEEILe0jHvmc1zzDDPD4iAbie4yjA76ISlP81fnJIB
 9zg/Dgzq+b7G8H+5hPLagwRoVJwUbem0OMp/QrsxEPQOotxChj6cPWzaj
 poOHXrhA41OaNPRANd98i9m2lgAIMKXYzuKXGQYznTlJFxHPVkxSX7PYc
 x1F1NEN4Ue/hETw/9rhUBHVDix5XlogmQGKD66OSz8dTx4ge+YID1CcNd
 xTQep2SXPAnFcUrn06HpSdXAe5DfmbqNFFiB+WZBSQOvcvbm1uBUF04EK g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452953108"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="452953108"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:28:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711055232"
X-IronPort-AV: E=Sophos;i="6.03,270,1694761200"; d="scan'208";a="711055232"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2023 00:28:52 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 07/41] vfio/container: Introduce a empty VFIOIOMMUOps
Date: Thu,  2 Nov 2023 15:12:28 +0800
Message-Id: <20231102071302.1818071-8-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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

This empty VFIOIOMMUOps named vfio_legacy_ops will hold all general
IOMMU ops of legacy container.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h | 2 +-
 hw/vfio/container.c           | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index 586d153c12..678161f207 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -255,7 +255,7 @@ typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
 typedef QLIST_HEAD(VFIODeviceList, VFIODevice) VFIODeviceList;
 extern VFIOGroupList vfio_group_list;
 extern VFIODeviceList vfio_device_list;
-
+extern const VFIOIOMMUOps vfio_legacy_ops;
 extern const MemoryListener vfio_memory_listener;
 extern int vfio_kvm_device_fd;
 
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 242010036a..4bc43ddfa4 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -472,6 +472,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
                                   Error **errp)
 {
     VFIOContainer *container;
+    VFIOContainerBase *bcontainer;
     int ret, fd;
     VFIOAddressSpace *space;
 
@@ -552,6 +553,8 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
     container->iova_ranges = NULL;
     QLIST_INIT(&container->giommu_list);
     QLIST_INIT(&container->vrdl_list);
+    bcontainer = &container->bcontainer;
+    bcontainer->ops = &vfio_legacy_ops;
 
     ret = vfio_init_container(container, group->fd, errp);
     if (ret) {
@@ -933,3 +936,5 @@ void vfio_detach_device(VFIODevice *vbasedev)
     vfio_put_base_device(vbasedev);
     vfio_put_group(group);
 }
+
+const VFIOIOMMUOps vfio_legacy_ops;
-- 
2.34.1


