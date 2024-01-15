Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B30B482D702
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:17:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPK1M-0007gk-2m; Mon, 15 Jan 2024 05:16:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPK1K-0007ga-ER
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:16:42 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rPK1I-0007Q7-Hx
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:16:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705313800; x=1736849800;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hy7O2g1euiVH0MkcYuwEsYWFvU+c66okol0jYpMXu24=;
 b=fZmy1KJUN02Ghs28lohMnJcSfqNGkFjuIf5J+nonGbedVSfjjuMAbvhq
 YZerwZhgk/HaeTIbJkuJ/3WKmYBXBzVxt92F2+qnTt63I6KkeAJiaaP5l
 eEHfvkH6SCWqkzOBEhe+8WaZ1bXsJA2eZcAZ8ZxMyx9nwf4QrTd4WE5Cm
 AGmKl95NhMobPy178IrormwU9UmyiX6XIyJPWxMzEwpOKe6N98/uzABLf
 i8gjEbWBrNSLbov8FdC8KQcSFJ52evtWkOmcREhd4WqJ1We+HUl4HFudb
 yX4M7zJbyBJ43jQ+hXeU0uU0DH4YLcVQ4gHog5fze7M2SEQWDEmE50v0p Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="390032478"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="390032478"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:16:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="1030599499"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; d="scan'208";a="1030599499"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jan 2024 02:16:33 -0800
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
Subject: [PATCH rfcv1 3/6] intel_iommu: add set/unset_iommu_device callback
Date: Mon, 15 Jan 2024 18:13:10 +0800
Message-Id: <20240115101313.131139-4-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115101313.131139-1-zhenzhong.duan@intel.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This adds set/unset_iommu_device() implementation in Intel vIOMMU.
In set call, IOMMUFDDevice is recorded in hash table indexed by
PCI BDF.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/i386/intel_iommu.h | 10 +++++
 hw/i386/intel_iommu.c         | 79 +++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 7fa0a695c8..c65fdde56f 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -62,6 +62,7 @@ typedef union VTD_IR_TableEntry VTD_IR_TableEntry;
 typedef union VTD_IR_MSIAddress VTD_IR_MSIAddress;
 typedef struct VTDPASIDDirEntry VTDPASIDDirEntry;
 typedef struct VTDPASIDEntry VTDPASIDEntry;
+typedef struct VTDIOMMUFDDevice VTDIOMMUFDDevice;
 
 /* Context-Entry */
 struct VTDContextEntry {
@@ -148,6 +149,13 @@ struct VTDAddressSpace {
     IOVATree *iova_tree;
 };
 
+struct VTDIOMMUFDDevice {
+    PCIBus *bus;
+    uint8_t devfn;
+    IOMMUFDDevice *idev;
+    IntelIOMMUState *iommu_state;
+};
+
 struct VTDIOTLBEntry {
     uint64_t gfn;
     uint16_t domain_id;
@@ -292,6 +300,8 @@ struct IntelIOMMUState {
     /* list of registered notifiers */
     QLIST_HEAD(, VTDAddressSpace) vtd_as_with_notifiers;
 
+    GHashTable *vtd_iommufd_dev;             /* VTDIOMMUFDDevice */
+
     /* interrupt remapping */
     bool intr_enabled;              /* Whether guest enabled IR */
     dma_addr_t intr_root;           /* Interrupt remapping table pointer */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index ed5677c0ae..95faf697eb 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -237,6 +237,13 @@ static gboolean vtd_as_equal(gconstpointer v1, gconstpointer v2)
            (key1->pasid == key2->pasid);
 }
 
+static gboolean vtd_as_idev_equal(gconstpointer v1, gconstpointer v2)
+{
+    const struct vtd_as_key *key1 = v1;
+    const struct vtd_as_key *key2 = v2;
+
+    return (key1->bus == key2->bus) && (key1->devfn == key2->devfn);
+}
 /*
  * Note that we use pointer to PCIBus as the key, so hashing/shifting
  * based on the pointer value is intended. Note that we deal with
@@ -3812,6 +3819,74 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
     return vtd_dev_as;
 }
 
+static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int32_t devfn,
+                                    IOMMUFDDevice *idev, Error **errp)
+{
+    IntelIOMMUState *s = opaque;
+    VTDIOMMUFDDevice *vtd_idev;
+    struct vtd_as_key key = {
+        .bus = bus,
+        .devfn = devfn,
+    };
+    struct vtd_as_key *new_key;
+
+    assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
+
+    /* None IOMMUFD case */
+    if (!idev) {
+        return 0;
+    }
+
+    vtd_iommu_lock(s);
+
+    vtd_idev = g_hash_table_lookup(s->vtd_iommufd_dev, &key);
+
+    if (vtd_idev) {
+        error_setg(errp, "IOMMUFD device already exist");
+        return -1;
+    }
+
+    new_key = g_malloc(sizeof(*new_key));
+    new_key->bus = bus;
+    new_key->devfn = devfn;
+
+    vtd_idev = g_malloc0(sizeof(VTDIOMMUFDDevice));
+    vtd_idev->bus = bus;
+    vtd_idev->devfn = (uint8_t)devfn;
+    vtd_idev->iommu_state = s;
+    vtd_idev->idev = idev;
+
+    g_hash_table_insert(s->vtd_iommufd_dev, new_key, vtd_idev);
+
+    vtd_iommu_unlock(s);
+
+    return 0;
+}
+
+static void vtd_dev_unset_iommu_device(PCIBus *bus, void *opaque, int32_t devfn)
+{
+    IntelIOMMUState *s = opaque;
+    VTDIOMMUFDDevice *vtd_idev;
+    struct vtd_as_key key = {
+        .bus = bus,
+        .devfn = devfn,
+    };
+
+    assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
+
+    vtd_iommu_lock(s);
+
+    vtd_idev = g_hash_table_lookup(s->vtd_iommufd_dev, &key);
+    if (!vtd_idev) {
+        vtd_iommu_unlock(s);
+        return;
+    }
+
+    g_hash_table_remove(s->vtd_iommufd_dev, &key);
+
+    vtd_iommu_unlock(s);
+}
+
 /* Unmap the whole range in the notifier's scope. */
 static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
 {
@@ -4107,6 +4182,8 @@ static AddressSpace *vtd_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
 
 static PCIIOMMUOps vtd_iommu_ops = {
     .get_address_space = vtd_host_dma_iommu,
+    .set_iommu_device = vtd_dev_set_iommu_device,
+    .unset_iommu_device = vtd_dev_unset_iommu_device,
 };
 
 static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
@@ -4230,6 +4307,8 @@ static void vtd_realize(DeviceState *dev, Error **errp)
                                      g_free, g_free);
     s->vtd_address_spaces = g_hash_table_new_full(vtd_as_hash, vtd_as_equal,
                                       g_free, g_free);
+    s->vtd_iommufd_dev = g_hash_table_new_full(vtd_as_hash, vtd_as_idev_equal,
+                                               g_free, g_free);
     vtd_init(s);
     pci_setup_iommu(bus, &vtd_iommu_ops, dev);
     /* Pseudo address space under root PCI bus. */
-- 
2.34.1


