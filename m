Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E13F8D7B76
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jun 2024 08:16:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0x4-0004rJ-73; Mon, 03 Jun 2024 02:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sE0wy-0004q4-Mk
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:13:45 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sE0wx-0000uQ-0H
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 02:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717395223; x=1748931223;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AknpX//QEXoR/eoy9ob0jTnGeHApPRu1pEWY3rPhxXg=;
 b=FJC7bVapkashx1kBtdnYPPUHeyIV3l/g+Ests/MlEvjnRYvBEawC+nQD
 TNrKzoyxIY9hEmaZ7OPg/Veo1QiFdpHb3vBpx0crnfajjWAooZv3SvA03
 T2hn5dEVXISI+8MX87d/jMUk9o/VdpdgYafktSx9cMjPeEHCqE94ZDG/7
 kEeFQcybgx+iwevZ7IqXw9nPKb4vTilpeHY+ebnUYaJL3GkQ/apL3re5U
 JNhDMQ57HUg7CYnNI+LQYWYOsemFwla+DNHurYjh426SAC0yzhKX6mdoQ
 DQPpBkgMHstor07a+13q4efK6spvMpj5mak4HktMs3Ler0nN5gutxPvnc g==;
X-CSE-ConnectionGUID: DiHgjnhWQw+Wyn32Nm5UTA==
X-CSE-MsgGUID: zRaktsT7Ty+4DrQgAw8zOQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="25277667"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; d="scan'208";a="25277667"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 23:13:41 -0700
X-CSE-ConnectionGUID: 6hqObsIVTt6gRj+TAOnVAA==
X-CSE-MsgGUID: j/6bUBTMRYOvsC4dm8fB3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; d="scan'208";a="36855876"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 23:13:37 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v6 07/19] vfio/container: Implement
 HostIOMMUDeviceClass::realize() handler
Date: Mon,  3 Jun 2024 14:10:11 +0800
Message-Id: <20240603061023.269738-8-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603061023.269738-1-zhenzhong.duan@intel.com>
References: <20240603061023.269738-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

Utilize range_get_last_bit() to get host IOMMU address width and
package it in HostIOMMUDeviceCaps for query with .get_cap().

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/container.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index c4fca2dfca..48800fe92f 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -1136,6 +1136,31 @@ static void vfio_iommu_legacy_class_init(ObjectClass *klass, void *data)
     vioc->pci_hot_reset = vfio_legacy_pci_hot_reset;
 };
 
+static bool hiod_legacy_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
+                                     Error **errp)
+{
+    VFIODevice *vdev = opaque;
+    /* iova_ranges is a sorted list */
+    GList *l = g_list_last(vdev->bcontainer->iova_ranges);
+
+    /* Only support query HOST_IOMMU_DEVICE_CAP_AW_BITS with legacy backend */
+    if (l) {
+        Range *range = l->data;
+        hiod->caps.aw_bits = range_get_last_bit(range) + 1;
+    } else {
+        hiod->caps.aw_bits = 0xff;
+    }
+
+    return true;
+}
+
+static void hiod_legacy_vfio_class_init(ObjectClass *oc, void *data)
+{
+    HostIOMMUDeviceClass *hioc = HOST_IOMMU_DEVICE_CLASS(oc);
+
+    hioc->realize = hiod_legacy_vfio_realize;
+};
+
 static const TypeInfo types[] = {
     {
         .name = TYPE_VFIO_IOMMU_LEGACY,
@@ -1144,6 +1169,7 @@ static const TypeInfo types[] = {
     }, {
         .name = TYPE_HOST_IOMMU_DEVICE_LEGACY_VFIO,
         .parent = TYPE_HOST_IOMMU_DEVICE,
+        .class_init = hiod_legacy_vfio_class_init,
     }
 };
 
-- 
2.34.1


