Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2C4835B29
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 07:43:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRo1N-0005He-C1; Mon, 22 Jan 2024 01:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rRo1E-0005AR-OK; Mon, 22 Jan 2024 01:42:53 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rRo1C-0007Hl-B9; Mon, 22 Jan 2024 01:42:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705905770; x=1737441770;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kcYDJ8Ys3vWxL5eMBWnoD+cCsD3TWw3GxiXV9Bfxjss=;
 b=n+SLVSDOETiRaoU9tIDiesiYO56S3C4EhxYi9jD0jgGHzqCbRDVKmNul
 0IKt2yLNUt5ZLodW6GjTew+0Ntzppfc1daFXtaLIyG4Nd5WVXLoY//ytR
 6HLA24EEiYwsPYZ7uSJM/90iTxvutbHaUe5C/FHEvp6/eleNnRbQ9I95l
 AHTaytnoAOa/ewJ1PvOIUshtQu9ujlYPHl7ntdyr1XGHKEOaV4e9rC5ms
 DQjEeEKZtq8AQDs6/u0PQ86SRYXEgl9G7Js8Un89qE+lCaH7q+dA7LSZC
 RSf5z+wO+WNhZ1ymkMCmQfjF5YNi1v1Oc3VF0LcYjVLVXcxj8U+0t8f0t g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="7792107"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="7792107"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2024 22:42:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="761646713"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; d="scan'208";a="761646713"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2024 22:42:44 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: eric.auger@redhat.com, jean-philippe@linaro.org,
 alex.williamson@redhat.com, clg@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 3/3] virtio-iommu: Support PCI device aliases
Date: Mon, 22 Jan 2024 14:40:15 +0800
Message-Id: <20240122064015.94630-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122064015.94630-1-zhenzhong.duan@intel.com>
References: <20240122064015.94630-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Currently virtio-iommu doesn't work well if there are multiple devices
in same iommu group. In below example config, guest virtio-iommu driver
can successfully probe first device but fail on others. Only one device
under the bridge can work normally.

-device virtio-iommu \
-device pcie-pci-bridge,id=root0 \
-device vfio-pci,host=81:11.0,bus=root0 \
-device vfio-pci,host=6f:01.0,bus=root0 \

The reason is virtio-iommu stores AS(address space) in hash table with
aliased BDF and corelates endpoint which is indexed by device's real
BDF, i.e., virtio_iommu_mr() is passed a real BDF to lookup AS hash
table, we either get wrong AS or NULL.

Fix it by storing AS indexed by real BDF. This way also make iova_ranges
from vfio device stored in IOMMUDevice of real BDF successfully.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/virtio/virtio-iommu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index d99c1f0d64..6880d92a44 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -399,27 +399,27 @@ static AddressSpace *virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
                                               int real_devfn)
 {
     VirtIOIOMMU *s = opaque;
-    IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, bus);
+    IOMMUPciBus *sbus = g_hash_table_lookup(s->as_by_busptr, real_bus);
     static uint32_t mr_index;
     IOMMUDevice *sdev;
 
     if (!sbus) {
         sbus = g_malloc0(sizeof(IOMMUPciBus) +
                          sizeof(IOMMUDevice *) * PCI_DEVFN_MAX);
-        sbus->bus = bus;
-        g_hash_table_insert(s->as_by_busptr, bus, sbus);
+        sbus->bus = real_bus;
+        g_hash_table_insert(s->as_by_busptr, real_bus, sbus);
     }
 
-    sdev = sbus->pbdev[devfn];
+    sdev = sbus->pbdev[real_devfn];
     if (!sdev) {
         char *name = g_strdup_printf("%s-%d-%d",
                                      TYPE_VIRTIO_IOMMU_MEMORY_REGION,
-                                     mr_index++, devfn);
-        sdev = sbus->pbdev[devfn] = g_new0(IOMMUDevice, 1);
+                                     mr_index++, real_devfn);
+        sdev = sbus->pbdev[real_devfn] = g_new0(IOMMUDevice, 1);
 
         sdev->viommu = s;
-        sdev->bus = bus;
-        sdev->devfn = devfn;
+        sdev->bus = real_bus;
+        sdev->devfn = real_devfn;
 
         trace_virtio_iommu_init_iommu_mr(name);
 
-- 
2.34.1


