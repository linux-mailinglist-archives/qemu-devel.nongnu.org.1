Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF0682D791
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:41:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPKPJ-0004Ys-E4; Mon, 15 Jan 2024 05:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKPF-0004Ry-Pd
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:41:26 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKPD-0003KJ-8x
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705315283; x=1736851283;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=g43ApeKoVxg8huAGHB51CY/ISeM1g4IzIOpG8KYjKF0=;
 b=ljZfi+kCK8usGI9fGlLypK1xrHidVsfXagKKECyD1jgTWm5MOGRI1hN3
 4SwhZmuNZVkWprAN+0sLUg2T+lPAkWbbelFQtzF/X0grWoHy9avzUjfcm
 RvDZLvCBoXxE098CvjkqUAdk8xHWsRjxHvjM0r80AS5XkVGuE1prw1MGB
 Blg4k7gNz1ABXeah8AEcI5wEmfwXtECgwkgeeda4pY1uSdRRYwXSDIBsC
 XyHwLcxLGKvk2t+swC/xWyyEt88juwb7gOP711/xYcVE+sKjYK7xMizNd
 a6TfsqMh32XSogOHGBNymow/XPRymNXjnBd0aMbjPwy1k0nte+aMkDTe/ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="13067954"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="13067954"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:41:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="874065587"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="874065587"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:41:14 -0800
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
Subject: [PATCH rfcv1 21/23] intel_iommu: invalidate piotlb when flush pasid
Date: Mon, 15 Jan 2024 18:37:33 +0800
Message-Id: <20240115103735.132209-22-zhenzhong.duan@intel.com>
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

When bind/unbind emulated devices, we should invalidate QEMU
piotlb. Host will flush piotlb for passthrough devices so we
don't handle passthrough devices.

Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 6a6478e865..2f3d3a28b0 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -84,6 +84,8 @@ static VTDPASIDAddressSpace *vtd_add_find_pasid_as(IntelIOMMUState *s,
                                                    uint32_t pasid);
 static int vtd_dev_get_rid2pasid(IntelIOMMUState *s, uint8_t bus_num,
                                  uint8_t devfn, uint32_t *rid_pasid);
+static gboolean vtd_hash_remove_by_pasid(gpointer key, gpointer value,
+                                         gpointer user_data);
 
 static void vtd_panic_require_caching_mode(void)
 {
@@ -3667,14 +3669,21 @@ static gboolean vtd_flush_pasid(gpointer key, gpointer value,
     VTDPASIDCacheEntry *pc_entry = &vtd_pasid_as->pasid_cache_entry;
     PCIBus *bus = vtd_pasid_as->bus;
     VTDPASIDEntry pe;
+    VTDIOMMUFDDevice *vtd_idev;
+    VTDIOTLBPageInvInfo info;
     uint16_t did;
     uint32_t pasid;
     uint16_t devfn;
     int ret;
+    struct vtd_as_key as_key = {
+        .bus = vtd_pasid_as->bus,
+        .devfn = vtd_pasid_as->devfn,
+    };
 
     did = vtd_pe_get_domain_id(&pc_entry->pasid_entry);
     pasid = vtd_pasid_as->pasid;
     devfn = vtd_pasid_as->devfn;
+    vtd_idev = g_hash_table_lookup(s->vtd_iommufd_dev, &as_key);
 
     switch (pc_info->type) {
     case VTD_PASID_CACHE_FORCE_RESET:
@@ -3702,6 +3711,13 @@ static gboolean vtd_flush_pasid(gpointer key, gpointer value,
         abort();
     }
 
+    info.domain_id = did;
+    info.pasid = pasid;
+    /* For passthrough device, we don't need invalidate QEMU piotlb */
+    if (s->root_scalable && likely(s->dmar_enabled) && !vtd_idev)
+        g_hash_table_foreach_remove(s->p_iotlb, vtd_hash_remove_by_pasid,
+                                    &info);
+
     /*
      * pasid cache invalidation may indicate a present pasid
      * entry to present pasid entry modification. To cover such
@@ -3725,18 +3741,9 @@ static gboolean vtd_flush_pasid(gpointer key, gpointer value,
         return true;
     }
 
-    /*
-     * TODO:
-     * - when pasid-base-iotlb(piotlb) infrastructure is ready,
-     *   should invalidate QEMU piotlb togehter with this change.
-     */
     return false;
+
 remove:
-    /*
-     * TODO:
-     * - when pasid-base-iotlb(piotlb) infrastructure is ready,
-     *   should invalidate QEMU piotlb togehter with this change.
-     */
     if (vtd_bind_guest_pasid(vtd_pasid_as,
                              NULL, VTD_PASID_UNBIND)) {
         pasid_cache_info_set_error(pc_info);
-- 
2.34.1


