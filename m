Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BC382D792
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:42:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPKPg-0004xQ-By; Mon, 15 Jan 2024 05:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKPF-0004Rz-QS
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:41:26 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKPC-0003K1-1T
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705315282; x=1736851282;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=amPl8s6TQpCYgTRAAM5FeJdm1Fi9iFvRdh4EyUvHCr4=;
 b=GITWOOaPWsTPGWNS5gGWjzN4lMQEUFDDEtVwjZ4bouiZEuDDdvgIQzJI
 ycBn3bJ/TKCnsovAlpb5f1EVy0G43TqlEhXcaXLzoLJu6+9xyW6G8/iUx
 gbFCdoPGsg9vjGXwsfyZ+vre8eAA+USg3aEevjIqK7ZrtupJwrhJoL360
 csyFj5om7KcpjzvzODxYBqye9N3f61LRzDB627ni4sdjU19Ec996RHJZS
 TrCf85GE9ZXYaFn3xSSucBYRYhQdovL1D2F2ztYjDm5KzWInEMJCu1IQC
 RrilLK3e50qtK8NQ6lVgTpvousGz0nI4fztrWh9fZhxTa+WRvqZIbB6fZ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="13067936"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="13067936"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:41:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="874065584"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="874065584"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:41:08 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH rfcv1 20/23] intel_iommu: piotlb invalidation should notify
 unmap
Date: Mon, 15 Jan 2024 18:37:32 +0800
Message-Id: <20240115103735.132209-21-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115103735.132209-1-zhenzhong.duan@intel.com>
References: <20240115103735.132209-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
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

From: Yi Sun <yi.y.sun@linux.intel.com>

This is used by some emulated devices which caches address
translation result. When piotlb invalidation issued in guest,
those caches should be refreshed.

Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 56 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index e9480608a5..6a6478e865 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4176,6 +4176,9 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
     struct iommu_hwpt_vtd_s1_invalidate cache_info = { 0 };
     VTDPIOTLBInvInfo piotlb_info;
     VTDIOTLBPageInvInfo info;
+    VTDAddressSpace *vtd_as;
+    VTDContextEntry ce;
+    int ret;
 
     cache_info.addr = 0;
     cache_info.npages = (uint64_t)-1;
@@ -4198,6 +4201,33 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
     g_hash_table_foreach_remove(s->p_iotlb, vtd_hash_remove_by_pasid,
                                 &info);
     vtd_iommu_unlock(s);
+
+    QLIST_FOREACH(vtd_as, &(s->vtd_as_with_notifiers), next) {
+        uint32_t rid2pasid = 0;
+        vtd_dev_get_rid2pasid(s, pci_bus_num(vtd_as->bus), vtd_as->devfn,
+                              &rid2pasid);
+        ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
+                                       vtd_as->devfn, &ce);
+        if (!ret && s->root_scalable && likely(s->dmar_enabled) &&
+            domain_id == vtd_get_domain_id(s, &ce, pasid) &&
+            pasid == rid2pasid && !vtd_as_has_map_notifier(vtd_as)) {
+            IOMMUNotifier *notifier;
+
+            IOMMU_NOTIFIER_FOREACH(notifier, &vtd_as->iommu) {
+                IOMMUTLBEvent event;
+
+                event.type = IOMMU_NOTIFIER_UNMAP |
+                             IOMMU_NOTIFIER_DEVIOTLB_UNMAP;
+                event.entry.target_as = &address_space_memory;
+                event.entry.iova = notifier->start;
+                event.entry.perm = IOMMU_NONE;
+                event.entry.addr_mask = notifier->end - notifier->start;
+                event.entry.translated_addr = 0;
+
+                memory_region_notify_iommu_one(notifier, &event);
+            }
+        }
+    }
 }
 
 static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
@@ -4207,6 +4237,10 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
     struct iommu_hwpt_vtd_s1_invalidate cache_info = { 0 };
     VTDPIOTLBInvInfo piotlb_info;
     VTDIOTLBPageInvInfo info;
+    VTDAddressSpace *vtd_as;
+    VTDContextEntry ce;
+    hwaddr size = (1 << am) * VTD_PAGE_SIZE;
+    int ret;
 
     cache_info.addr = addr;
     cache_info.npages = 1 << am;
@@ -4233,6 +4267,28 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
     g_hash_table_foreach_remove(s->p_iotlb,
                                 vtd_hash_remove_by_page, &info);
     vtd_iommu_unlock(s);
+
+    QLIST_FOREACH(vtd_as, &(s->vtd_as_with_notifiers), next) {
+        uint32_t rid2pasid = 0;
+        vtd_dev_get_rid2pasid(s, pci_bus_num(vtd_as->bus), vtd_as->devfn,
+                              &rid2pasid);
+        ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
+                                       vtd_as->devfn, &ce);
+        if (!ret && s->root_scalable && likely(s->dmar_enabled) &&
+            domain_id == vtd_get_domain_id(s, &ce, pasid) &&
+            pasid == rid2pasid && !vtd_as_has_map_notifier(vtd_as)) {
+            IOMMUTLBEvent event;
+
+            event.type = IOMMU_NOTIFIER_UNMAP | IOMMU_NOTIFIER_DEVIOTLB_UNMAP;
+            event.entry.target_as = &address_space_memory;
+            event.entry.iova = addr;
+            event.entry.perm = IOMMU_NONE;
+            event.entry.addr_mask = size - 1;
+            event.entry.translated_addr = 0;
+
+            memory_region_notify_iommu(&vtd_as->iommu, 0, event);
+        }
+    }
 }
 
 static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
-- 
2.34.1


