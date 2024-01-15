Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D90C82D79C
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:42:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPKOV-0001ym-I8; Mon, 15 Jan 2024 05:40:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKON-0001mQ-K9
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:40:33 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPKOJ-0003Bt-HW
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:40:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705315227; x=1736851227;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Pq4tna4liAgU6SEEAHI54jtuLdPFcBw1b4/wcNEBEC4=;
 b=cc7N4IIykWCyVkj5bpIZosTQslTGUhbsMfKBs4ZskCWmBiBmaCtTDPu6
 dVHjKk0fJTVDrm2A8QtQpwm/PANdgplctu7K/O4JQ12e0C4ITe/wFS70v
 lGfpoo29yMJ8iWpsOKqZlz1bA/buch2aCoHhS6zkfTIJZikhBCtJUYNws
 uHW06IN5lAF6d8abFG7cK7Pbt2c3H/1XL6ifHn9jiO3Ko3wbnFOQZeMbI
 sGG9pfAshEacAW84XJPbajyVuqWaMHzQFeuZxql8o76hypz775n64MO17
 6wSf9A+5Hwt84Glb7FRWFO2bJv48R5GrylStyiD/tWSsFt4Fd6Xg4sBhx g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="13067726"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="13067726"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:40:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="874065360"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="874065360"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:40:19 -0800
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
Subject: [PATCH rfcv1 11/23] intel_iommu: ERRATA_772415 workaround
Date: Mon, 15 Jan 2024 18:37:23 +0800
Message-Id: <20240115103735.132209-12-zhenzhong.duan@intel.com>
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

On a system influenced by ERRATA_772415, IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17
is repored by IOMMU_DEVICE_GET_HW_INFO. Due to this errata, even the readonly
range mapped on stage-2 page table could still be written.

Reference from 4th Gen Intel Xeon Processor Scalable Family Specification
Update, Errata Details, SPR17.

[0] https://edc.intel.com/content/www/us/en/design/products-and-solutions/processors-and-chipsets/eagle-stream/sapphire-rapids-specification-update

We utilize the new added IOMMUFD container/ioas/hwpt management framework in
VTD. Add a check to create new VTDIOASContainer to hold RW-only mappings,
then this VTDIOASContainer can be used as backend for device with
ERRATA_772415. See below diagram for details:

      IntelIOMMUState
             |
             V
    .------------------.    .------------------.    .-------------------.
    | VTDIOASContainer |--->| VTDIOASContainer |--->| VTDIOASContainer  |-->...
    | (iommufd0,RW&RO) |    | (iommufd1,RW&RO) |    | (iommufd0,RW only)|
    .------------------.    .------------------.    .-------------------.
             |                       |                              |
             |                       .-->...                        |
             V                                                      V
      .-------------------.    .-------------------.          .---------------.
      |   VTDS2Hwpt(CC)   |--->| VTDS2Hwpt(non-CC) |-->...    | VTDS2Hwpt(CC) |-->...
      .-------------------.    .-------------------.          .---------------.
          |            |               |                            |
          |            |               |                            |
    .-----------.  .-----------.  .------------.              .------------.
    | IOMMUFD   |  | IOMMUFD   |  | IOMMUFD    |              | IOMMUFD    |
    | Device(CC)|  | Device(CC)|  | Device     |              | Device(CC) |
    | (iommufd0)|  | (iommufd0)|  | (non-CC)   |              | (errata)   |
    |           |  |           |  | (iommufd0) |              | (iommufd0) |
    .-----------.  .-----------.  .------------.              .------------.

Suggested-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/i386/intel_iommu.h |  2 ++
 hw/i386/intel_iommu.c         | 27 +++++++++++++++++++--------
 2 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index d3122cf699..72702e10a2 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -108,6 +108,7 @@ struct pasid_key {
 struct VTDIOASContainer {
     IOMMUFDBackend *iommufd;
     uint32_t ioas_id;
+    uint32_t errata;
     MemoryListener listener;
     QLIST_HEAD(, VTDS2Hwpt) s2_hwpt_list;
     QLIST_ENTRY(VTDIOASContainer) next;
@@ -200,6 +201,7 @@ struct VTDIOMMUFDDevice {
     PCIBus *bus;
     uint8_t devfn;
     IOMMUFDDevice *idev;
+    uint32_t errata;
     IntelIOMMUState *iommu_state;
     QLIST_ENTRY(VTDIOMMUFDDevice) next;
 };
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index df93fcacd8..8f9a59ae6f 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2121,7 +2121,8 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
     vtd_iommu_replay_all(s);
 }
 
-static bool iommufd_listener_skipped_section(MemoryRegionSection *section)
+static bool iommufd_listener_skipped_section(VTDIOASContainer *container,
+                                             MemoryRegionSection *section)
 {
     return !memory_region_is_ram(section->mr) ||
            memory_region_is_protected(section->mr) ||
@@ -2131,7 +2132,8 @@ static bool iommufd_listener_skipped_section(MemoryRegionSection *section)
             * are never accessed by the CPU and beyond the address width of
             * some IOMMU hardware.  TODO: VFIO should tell us the IOMMU width.
             */
-           section->offset_within_address_space & (1ULL << 63);
+           section->offset_within_address_space & (1ULL << 63) ||
+           (container->errata && section->readonly);
 }
 
 static void iommufd_listener_region_add_s2domain(MemoryListener *listener,
@@ -2147,7 +2149,7 @@ static void iommufd_listener_region_add_s2domain(MemoryListener *listener,
     Error *err = NULL;
     int ret;
 
-    if (iommufd_listener_skipped_section(section)) {
+    if (iommufd_listener_skipped_section(container, section)) {
         return;
     }
     iova = REAL_HOST_PAGE_ALIGN(section->offset_within_address_space);
@@ -2198,7 +2200,7 @@ static void iommufd_listener_region_del_s2domain(MemoryListener *listener,
     Int128 llend, llsize;
     int ret;
 
-    if (iommufd_listener_skipped_section(section)) {
+    if (iommufd_listener_skipped_section(container, section)) {
         return;
     }
     iova = REAL_HOST_PAGE_ALIGN(section->offset_within_address_space);
@@ -2468,7 +2470,8 @@ static int vtd_device_attach_iommufd(VTDIOMMUFDDevice *vtd_idev,
 
     /* try to attach to an existing container in this space */
     QLIST_FOREACH(container, &s->containers, next) {
-        if (container->iommufd != iommufd) {
+        if (container->iommufd != iommufd ||
+            container->errata != vtd_idev->errata) {
             continue;
         }
 
@@ -2495,6 +2498,7 @@ static int vtd_device_attach_iommufd(VTDIOMMUFDDevice *vtd_idev,
     container = g_malloc0(sizeof(*container));
     container->iommufd = iommufd;
     container->ioas_id = ioas_id;
+    container->errata = vtd_idev->errata;
     QLIST_INIT(&container->s2_hwpt_list);
 
     if (vtd_device_attach_container(vtd_idev, container,
@@ -5002,10 +5006,11 @@ static bool vtd_sync_hw_info(IntelIOMMUState *s, struct iommu_hw_info_vtd *vtd,
  * could bind guest page table to host.
  */
 static bool vtd_check_idev(IntelIOMMUState *s, IOMMUFDDevice *idev,
-                           Error **errp)
+                           uint32_t *flags, Error **errp)
 {
     struct iommu_hw_info_vtd vtd;
     enum iommu_hw_info_type type = IOMMU_HW_INFO_TYPE_INTEL_VTD;
+    bool passed;
 
     if (iommufd_device_get_info(idev, &type, sizeof(vtd), &vtd)) {
         error_setg(errp, "Failed to get IOMMU capability!!!");
@@ -5017,7 +5022,11 @@ static bool vtd_check_idev(IntelIOMMUState *s, IOMMUFDDevice *idev,
         return false;
     }
 
-    return vtd_sync_hw_info(s, &vtd, errp);
+    passed = vtd_sync_hw_info(s, &vtd, errp);
+    if (passed) {
+        *flags = vtd.flags;
+    }
+    return passed;
 }
 
 static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int32_t devfn,
@@ -5030,6 +5039,7 @@ static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int32_t devfn,
         .devfn = devfn,
     };
     struct vtd_as_key *new_key;
+    uint32_t flags;
 
     assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
 
@@ -5042,7 +5052,7 @@ static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int32_t devfn,
         return -1;
     }
 
-    if (!vtd_check_idev(s, idev, errp)) {
+    if (!vtd_check_idev(s, idev, &flags, errp)) {
         return -1;
     }
 
@@ -5064,6 +5074,7 @@ static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int32_t devfn,
     vtd_idev->devfn = (uint8_t)devfn;
     vtd_idev->iommu_state = s;
     vtd_idev->idev = idev;
+    vtd_idev->errata = flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17;
     QLIST_INSERT_HEAD(&s->vtd_idev_list, vtd_idev, next);
 
     g_hash_table_insert(s->vtd_iommufd_dev, new_key, vtd_idev);
-- 
2.34.1


