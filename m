Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C250D82D7A0
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:43:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPKPn-0005fH-8z; Mon, 15 Jan 2024 05:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKPW-0005Pa-0W
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:41:43 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKPQ-0003Jt-LW
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705315297; x=1736851297;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RIeEMYmqYjbZcXK1QLKu4BKfZLxL2mTh8GqqfO6TNPo=;
 b=nUmglYkKpNfEzJX6Is2l2+C8tJrJHy8IZnCFY5VIJZaGHfGovvpG1UJ3
 liLO0T8qkJIYTooIWmDd9EqnTxd5Ai2GNXl34EAvBdwyYLj3gdtxpjtNn
 BV1Mpm/UDQMhHRpC9Z/hYwt53ovUQb0CBBekSvgwX4RlsmQzbSWAbOKTk
 NmcWaWhy9CAyctQ/5NahzaXUpQZGxQzA7q5KqvqqNOfanBOXJ/nw7v80F
 WVUjwAA5eB2OxHkCEeDleF8dP8/DwwFvkp0pzMGR0sBuBoJut8DAu6GZv
 fhsZcLoOzcvKUmL/znSX/cs7+Uv5ibhn+bQs8gWbien6ZDBDw9fvo76+S Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="13068038"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="13068038"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:41:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="874065594"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="874065594"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:41:19 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH rfcv1 22/23] intel_iommu: refresh pasid bind after pasid cache
 force reset
Date: Mon, 15 Jan 2024 18:37:34 +0800
Message-Id: <20240115103735.132209-23-zhenzhong.duan@intel.com>
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

The force reset clears the vtd_pasid_as and also unbinds the pasid on
host side. This is bad when the reset is triggered after some pasid
binding is setup. e.g. gcmd.TE enabling will reset cache, but wishes
to keep the pasid #0 (gIOVA) binding. So needs to refresh the pasid
bind per guest pasid table accordingly. Without this, issue has been
observed when legacy device passthrough (e.g. NIC without PASID support).

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 2f3d3a28b0..e418305f6e 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -72,6 +72,7 @@ struct vtd_iotlb_key {
 
 static void vtd_address_space_refresh_all(IntelIOMMUState *s);
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
+static void vtd_refresh_pasid_bind(IntelIOMMUState *s);
 
 static void vtd_pasid_cache_reset(IntelIOMMUState *s);
 static void vtd_pasid_cache_sync(IntelIOMMUState *s,
@@ -3292,6 +3293,7 @@ static void vtd_handle_gcmd_srtp(IntelIOMMUState *s)
     vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_RTPS);
     vtd_reset_caches(s);
     vtd_address_space_refresh_all(s);
+    vtd_refresh_pasid_bind(s);
 }
 
 /* Set Interrupt Remap Table Pointer */
@@ -3326,6 +3328,7 @@ static void vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
 
     vtd_reset_caches(s);
     vtd_address_space_refresh_all(s);
+    vtd_refresh_pasid_bind(s);
 }
 
 /* Handle Interrupt Remap Enable/Disable */
@@ -3960,6 +3963,28 @@ static void vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
     }
 }
 
+static void vtd_refresh_pasid_bind(IntelIOMMUState *s)
+{
+    VTDPASIDCacheInfo pc_info = { .error_happened = false,
+                                  .type = VTD_PASID_CACHE_GLOBAL_INV };
+
+    /*
+     * Only when dmar is enabled, should pasid bindings replayed,
+     * otherwise no need to replay.
+     */
+    if (!s->dmar_enabled) {
+        return;
+    }
+
+    if (!s->scalable_modern || !s->root_scalable) {
+        return;
+    }
+
+    vtd_iommu_lock(s);
+    vtd_replay_guest_pasid_bindings(s, &pc_info);
+    vtd_iommu_unlock(s);
+}
+
 /*
  * This function syncs the pasid bindings between guest and host.
  * It includes updating the pasid cache in vIOMMU and updating the
@@ -6051,6 +6076,7 @@ static void vtd_reset(DeviceState *dev)
 
     vtd_init(s);
     vtd_address_space_refresh_all(s);
+    vtd_refresh_pasid_bind(s);
 }
 
 static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
-- 
2.34.1


