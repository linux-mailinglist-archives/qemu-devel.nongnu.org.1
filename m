Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EC082D79A
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:42:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPKOq-0003L7-FJ; Mon, 15 Jan 2024 05:41:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKOk-0003I9-14
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:40:54 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKOi-0003GV-7t
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705315252; x=1736851252;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bRmsL7JKNEi6D3ICQa69K5/fS0ztI+ui4r90d6Oeejc=;
 b=NTe6SoirvMtEU8DLGUOv6FeHAGTkMPLc/EbAO+cWDj21TNR/ySRn58aJ
 IsZ4TBzlGSfELA2e90zfAxjB/N0WOrtWhbVLkJ1REuw/IUb/SGX9sL4hI
 6lW/8TqESyNZ8dNJrdUlTNZx/jaKWYILKeS1J0NPqQcutPG+QtRrJwAhz
 B8BBHBY1t2eBjZ/GvGbFIxWNPjQb9FvMOG+INr9LYgEYkQ0qXwcOgQ5Xg
 Hza8oo1B2rSwPnMXpQnzqccOrSpoAxfK+rtyVROvRR4BzY9mIvvZ0FuOm
 hyQV4FmpNbG0cB5hlaGNVDVGv0NPeqkW3vK3Fd+5KebPdlD/EdZrhoPjD g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="13067868"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="13067868"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:40:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="874065442"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="874065442"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:40:45 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH rfcv1 16/23] intel_iommu: rename slpte in iotlb_entry to pte
Date: Mon, 15 Jan 2024 18:37:28 +0800
Message-Id: <20240115103735.132209-17-zhenzhong.duan@intel.com>
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

From: Yi Liu <yi.l.liu@intel.com>

Because we support both FST and SST translation, rename slpte in iotlb_entry
to pte to make it generic.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/i386/intel_iommu.h |  2 +-
 hw/i386/intel_iommu.c         | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 72702e10a2..dedaab5ac9 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -210,7 +210,7 @@ struct VTDIOTLBEntry {
     uint64_t gfn;
     uint16_t domain_id;
     uint32_t pasid;
-    uint64_t slpte;
+    uint64_t pte;
     uint64_t mask;
     uint8_t access_flags;
 };
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 5e7d445d98..7c24f8f677 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -384,7 +384,7 @@ static void vtd_update_iotlb(IntelIOMMUState *s, uint16_t source_id,
 
     entry->gfn = gfn;
     entry->domain_id = domain_id;
-    entry->slpte = slpte;
+    entry->pte = slpte;
     entry->access_flags = access_flags;
     entry->mask = vtd_slpt_level_page_mask(level);
     entry->pasid = pasid;
@@ -1949,9 +1949,9 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     if (!rid2pasid) {
         iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
         if (iotlb_entry) {
-            trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->slpte,
+            trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->pte,
                                      iotlb_entry->domain_id);
-            slpte = iotlb_entry->slpte;
+            slpte = iotlb_entry->pte;
             access_flags = iotlb_entry->access_flags;
             page_mask = iotlb_entry->mask;
             goto out;
@@ -2027,9 +2027,9 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
     if (rid2pasid) {
         iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
         if (iotlb_entry) {
-            trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->slpte,
+            trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->pte,
                                      iotlb_entry->domain_id);
-            slpte = iotlb_entry->slpte;
+            slpte = iotlb_entry->pte;
             access_flags = iotlb_entry->access_flags;
             page_mask = iotlb_entry->mask;
             goto out;
-- 
2.34.1


