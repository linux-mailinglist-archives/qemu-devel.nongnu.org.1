Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3FD8BDE29
	for <lists+qemu-devel@lfdr.de>; Tue,  7 May 2024 11:27:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4H4i-0003Fa-W8; Tue, 07 May 2024 05:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H3F-0000kH-QX
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:24:06 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H3E-0000Bi-4r
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715073836; x=1746609836;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3evy5Fn1NeUvF8A+wdco68VIVay91RZK5fR/tL35KqQ=;
 b=As1bPFT+ETdcUKhtwyHyi5QG3YxcWy8wC0SyhGSKYWD4FSqJdNm7kSYR
 DHkmxuHAFNkNOsh+jrmIOBVTMlNCZYGb/zJ6JjatcaHmA6mxLUXNmlIsw
 zG+qWrPuccxK52LE5WuczwuW3boUjOXsoCGaqnAilQLy2QXSeHN+reL1Y
 AYfyWmuIlncP7soHWrc2Fq+J1+llIucE1Rp82sCFeQB3GACvpJ4laXMHU
 W+msB1ZIZjC4cIW5GkdYLxEQzQrxO+hycp6ABad8UrjA4LFCHMoEtHeXi
 gENyP45p07WU7NVvr6eqXXj7ewNU6RqssOByK2PPVfIyj3rTBBvWlRMEt Q==;
X-CSE-ConnectionGUID: o4NOHKLCQ/+yqJnBeBGz4w==
X-CSE-MsgGUID: vqG+ng9TTI+3BcGpcjwocg==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10785293"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="10785293"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:23:55 -0700
X-CSE-ConnectionGUID: 3gOCzRMxQJySvv78qY+3yw==
X-CSE-MsgGUID: /AFydm/dRJ63KfPBpPeGcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="28553467"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:23:50 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 13/19] vfio: Create host IOMMU device instance
Date: Tue,  7 May 2024 17:20:37 +0800
Message-Id: <20240507092043.1172717-14-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
References: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

Create host IOMMU device instance in vfio_attach_device() and call
.realize() to initialize it further.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/vfio/vfio-common.h |  1 +
 hw/vfio/common.c              | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index affb73f209..94428abcf4 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -126,6 +126,7 @@ typedef struct VFIODevice {
     OnOffAuto pre_copy_dirty_page_tracking;
     bool dirty_pages_supported;
     bool dirty_tracking;
+    HostIOMMUDevice *hiod;
     int devid;
     IOMMUFDBackend *iommufd;
 } VFIODevice;
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 9f1f2e19f7..970c9e3a5f 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -1497,6 +1497,7 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
 {
     const VFIOIOMMUClass *ops =
         VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));
+    HostIOMMUDevice *hiod;
 
     if (vbasedev->iommufd) {
         ops = VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
@@ -1504,7 +1505,19 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
 
     assert(ops);
 
-    return ops->attach_device(name, vbasedev, as, errp);
+    if (!ops->attach_device(name, vbasedev, as, errp)) {
+        return false;
+    }
+
+    hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
+    if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
+        object_unref(hiod);
+        ops->detach_device(vbasedev);
+        return false;
+    }
+    vbasedev->hiod = hiod;
+
+    return true;
 }
 
 void vfio_detach_device(VFIODevice *vbasedev)
@@ -1512,5 +1525,6 @@ void vfio_detach_device(VFIODevice *vbasedev)
     if (!vbasedev->bcontainer) {
         return;
     }
+    object_unref(vbasedev->hiod);
     vbasedev->bcontainer->ops->detach_device(vbasedev);
 }
-- 
2.34.1


