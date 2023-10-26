Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C92F7D8111
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:47:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvxt0-0007SF-PD; Thu, 26 Oct 2023 06:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxsv-0007Qg-Dv
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:46:42 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qvxst-0001Hy-3L
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 06:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698317199; x=1729853199;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Qxw0A9Qxj6KixE8WbPl0VC7CbcnlGe2+ICTzKRPe+3s=;
 b=aNa/M5IeLbq8EC17uZnVjBAyQYkijfugRTQZj3dUanktwB3SGN6Pt+4h
 h6LtNNIztJMzg9DFae0TD6RrsegdomHKgQazbR6m3WLDKrb+5GKIo4vu3
 yIl2D1iLn60zYvBIQWjSzUhWzjOkChBYlfVy3SrhQgRLpuIZjzKmdEtGY
 mGajGHUZCFTH/x5zf+IQ3Yjr1jiksMY2uLGSjAjlPZ8D61dclciZJpgYV
 4frTwl9bnsFgJnVIizpo/2kJrSWAqpm/w+qvJDreeTS6IqYVWO4fAs6io
 BdzM+1CDOufsH6fbQtWNc0TuOKMtYjVVJl0GiXhozUCQ/tJim4RvRuGqk w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="372563250"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; d="scan'208";a="372563250"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:46:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="463603"
Received: from duan-server-s2600bt.bj.intel.com ([10.240.192.147])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 03:46:24 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v3 07/37] vfio/container: Introduce a empty VFIOIOMMUOps
Date: Thu, 26 Oct 2023 18:30:34 +0800
Message-Id: <20231026103104.1686921-8-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
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

This empty VFIOIOMMUOps named vfio_legacy_ops will hold all general
IOMMU ops of legacy container.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h | 2 +-
 hw/vfio/container.c           | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index d8f293cb57..8ded5cd8e4 100644
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


