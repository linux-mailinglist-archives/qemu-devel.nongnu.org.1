Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 185ABBA6C3B
	for <lists+qemu-devel@lfdr.de>; Sun, 28 Sep 2025 10:56:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2nC7-0006SE-AL; Sun, 28 Sep 2025 04:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v2nC3-0006RN-1z
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 04:55:43 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v2nBo-00044v-4v
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 04:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759049728; x=1790585728;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UIx34YIzlFINwWTFJwGZ4PbgVaTVtQLZb+iSo6vAuUY=;
 b=jmjJ+4NdiCnYhvHkB2beNFA8vl3h3JbRm/4l9RmqiHLgMRCc0pWbneJW
 IXHu74F+Wl33PAugAK1/6CflInHZyxptZ3QIwCwAM0AVEjeoUXWWzUJFM
 m2NDx170In2m7g/5/CX5yg6C7TLwZlaV9heAneiT6nZLWcNDQ3eaNdJGg
 CaTAcn7Sk5Q0d5L9G3fR/TNzQVHOX8asYh9++9Bq2YLzNVqv1kREntPJD
 pskUk/rsSLlsnWymDL3+FMCKyZcovAjlvIY6+U7uz9kyHGqZo7iGoJNVV
 wT36uRwQOL6UfbFeXsUYAJn+94df9HuQreLzznCffXhJITRcVsPkYj4TC A==;
X-CSE-ConnectionGUID: vuQHoRlMRv2/kUXX3cm5BA==
X-CSE-MsgGUID: ULeKB+42Syaq41mh7L2hiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="65167428"
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; d="scan'208";a="65167428"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 01:55:18 -0700
X-CSE-ConnectionGUID: p4czyY+1S12c4QaXq/DZNA==
X-CSE-MsgGUID: nV8iaFQMSkqZGeyH+Vducw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; d="scan'208";a="177810798"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 01:55:17 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 1/6] vfio/container: Remap only populated parts in a section
Date: Sun, 28 Sep 2025 04:54:27 -0400
Message-ID: <20250928085432.40107-2-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250928085432.40107-1-zhenzhong.duan@intel.com>
References: <20250928085432.40107-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

If there are multiple containers and unmap-all fails for some of them, we
need to remap vaddr for the other containers for which unmap-all succeeded.
When ram discard is enabled, we should only remap populated parts in a
section instead of the whole section.

Fixes: eba1f657cbb1 ("vfio/container: recover from unmap-all-vaddr failure")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Steven Sistare <steven.sistare@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 include/hw/vfio/vfio-cpr.h |  2 +-
 hw/vfio/cpr-legacy.c       | 20 +++++++++++++++-----
 hw/vfio/listener.c         |  4 ++--
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 26ee0c4fe1..56fa226f35 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -68,7 +68,7 @@ bool vfio_cpr_container_match(struct VFIOLegacyContainer *container,
 void vfio_cpr_giommu_remap(struct VFIOContainer *bcontainer,
                            MemoryRegionSection *section);
 
-bool vfio_cpr_ram_discard_register_listener(
+bool vfio_cpr_ram_discard_replay_populated(
     struct VFIOContainer *bcontainer, MemoryRegionSection *section);
 
 void vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index bbf7a0d35f..9a37e8c604 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -227,22 +227,32 @@ void vfio_cpr_giommu_remap(VFIOContainer *bcontainer,
     memory_region_iommu_replay(giommu->iommu_mr, &giommu->n);
 }
 
+static int vfio_cpr_rdm_remap(MemoryRegionSection *section, void *opaque)
+{
+    RamDiscardListener *rdl = opaque;
+
+    return rdl->notify_populate(rdl, section);
+}
+
 /*
  * In old QEMU, VFIO_DMA_UNMAP_FLAG_VADDR may fail on some mapping after
  * succeeding for others, so the latter have lost their vaddr.  Call this
- * to restore vaddr for a section with a RamDiscardManager.
+ * to restore vaddr for populated parts in a section with a RamDiscardManager.
  *
- * The ram discard listener already exists.  Call its populate function
+ * The ram discard listener already exists.  Call its replay_populated function
  * directly, which calls vfio_legacy_cpr_dma_map.
  */
-bool vfio_cpr_ram_discard_register_listener(VFIOContainer *bcontainer,
-                                            MemoryRegionSection *section)
+bool vfio_cpr_ram_discard_replay_populated(VFIOContainer *bcontainer,
+                                           MemoryRegionSection *section)
 {
+    RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
     VFIORamDiscardListener *vrdl =
         vfio_find_ram_discard_listener(bcontainer, section);
 
     g_assert(vrdl);
-    return vrdl->listener.notify_populate(&vrdl->listener, section) == 0;
+    return ram_discard_manager_replay_populated(rdm, section,
+                                                vfio_cpr_rdm_remap,
+                                                &vrdl->listener) == 0;
 }
 
 int vfio_cpr_group_get_device_fd(int d, const char *name)
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 3b6f17f0c3..04c64874fa 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -577,8 +577,8 @@ void vfio_container_region_add(VFIOContainer *bcontainer,
             if (!vfio_ram_discard_register_listener(bcontainer, section, &err)) {
                 goto fail;
             }
-        } else if (!vfio_cpr_ram_discard_register_listener(bcontainer,
-                                                           section)) {
+        } else if (!vfio_cpr_ram_discard_replay_populated(bcontainer,
+                                                          section)) {
             error_setg(&err,
                        "vfio_cpr_ram_discard_register_listener for %s failed",
                        memory_region_name(section->mr));
-- 
2.47.1


