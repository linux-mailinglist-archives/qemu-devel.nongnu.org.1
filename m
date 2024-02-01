Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C458451FE
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Feb 2024 08:32:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVRXt-0006ST-FG; Thu, 01 Feb 2024 02:31:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRXp-0006HV-B5
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:31:33 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rVRXl-0001hD-Mo
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 02:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706772689; x=1738308689;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Idmve9hI3M5yptuDUtlLrnV5peWHH6TGUubN6UCkLTk=;
 b=BBYYiSRWEizSLO01xrEc3EKKfUxAenLp46LpDg941Q0bPfMukQYkaFZj
 84XDzm1B6SBLr892ZMZQLLzLHvDeYtnH4hAxg3D5csfV+Q1NF1UeDtnFq
 /Lsut2yX+ttc6dSSQ4ktYiRo/C+z/+mdCASYq6dZBczheIQVnNwcxJklg
 FVKO6yVdXrKGvAY02qz36ZG+apqknoyXoXLTxdxmK6Uc4iRIlHZQ15HWv
 YOwq/8Hj2ScBj5O1EqorZfSQlvtcNxZmh7X0cM0COujuJ++tGwVKV+hzP
 tDpXmN9SC/gx3Q3V0QPQdkFj8LdHVGru4Pzlwjy2K61ttzYIy9Ko+lAVF w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="402676889"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; d="scan'208";a="402676889"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:31:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4443363"
Received: from spr-s2600bt.bj.intel.com ([10.240.192.124])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2024 23:31:23 -0800
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
Subject: [PATCH rfcv2 14/18] intel_iommu: Add a framework to check and sync
 host IOMMU cap/ecap
Date: Thu,  1 Feb 2024 15:28:14 +0800
Message-Id: <20240201072818.327930-15-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201072818.327930-1-zhenzhong.duan@intel.com>
References: <20240201072818.327930-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
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

From: Yi Liu <yi.l.liu@intel.com>

Add a framework to check and synchronize host IOMMU cap/ecap with
vIOMMU cap/ecap.

The sequence will be:

vtd_cap_init() initializes iommu->cap/ecap.
vtd_check_hdev() update iommu->cap/ecap based on host cap/ecap.
iommu->cap_frozen set when machine create done, iommu->cap/ecap become readonly.

Implementation details for different backends will be in following patches.

Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 include/hw/i386/intel_iommu.h |  1 +
 hw/i386/intel_iommu.c         | 41 ++++++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index bbc7b96add..c71a133820 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -283,6 +283,7 @@ struct IntelIOMMUState {
 
     uint64_t cap;                   /* The value of capability reg */
     uint64_t ecap;                  /* The value of extended capability reg */
+    bool cap_frozen;                /* cap/ecap become read-only after frozen */
 
     uint32_t context_cache_gen;     /* Should be in [1,MAX] */
     GHashTable *iotlb;              /* IOTLB */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index ffa1ad6429..7ed2b79669 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3819,6 +3819,31 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUState *s, PCIBus *bus,
     return vtd_dev_as;
 }
 
+static int vtd_check_legacy_hdev(IntelIOMMUState *s,
+                                 IOMMULegacyDevice *ldev,
+                                 Error **errp)
+{
+    return 0;
+}
+
+static int vtd_check_iommufd_hdev(IntelIOMMUState *s,
+                                  IOMMUFDDevice *idev,
+                                  Error **errp)
+{
+    return 0;
+}
+
+static int vtd_check_hdev(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hdev,
+                          Error **errp)
+{
+    HostIOMMUDevice *base_dev = vtd_hdev->dev;
+
+    if (base_dev->type == HID_LEGACY) {
+        return vtd_check_legacy_hdev(s, vtd_hdev->ldev, errp);
+    }
+    return vtd_check_iommufd_hdev(s, vtd_hdev->idev, errp);
+}
+
 static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
                                     HostIOMMUDevice *base_dev, Error **errp)
 {
@@ -3829,6 +3854,7 @@ static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
         .devfn = devfn,
     };
     struct vtd_as_key *new_key;
+    int ret;
 
     assert(base_dev);
 
@@ -3848,6 +3874,13 @@ static int vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
     vtd_hdev->iommu_state = s;
     vtd_hdev->dev = base_dev;
 
+    ret = vtd_check_hdev(s, vtd_hdev, errp);
+    if (ret) {
+        g_free(vtd_hdev);
+        vtd_iommu_unlock(s);
+        return ret;
+    }
+
     new_key = g_malloc(sizeof(*new_key));
     new_key->bus = bus;
     new_key->devfn = devfn;
@@ -4083,7 +4116,9 @@ static void vtd_init(IntelIOMMUState *s)
     s->iq_dw = false;
     s->next_frcd_reg = 0;
 
-    vtd_cap_init(s);
+    if (!s->cap_frozen) {
+        vtd_cap_init(s);
+    }
 
     /*
      * Rsvd field masks for spte
@@ -4254,6 +4289,10 @@ static int vtd_machine_done_notify_one(Object *child, void *unused)
 
 static void vtd_machine_done_hook(Notifier *notifier, void *unused)
 {
+    IntelIOMMUState *iommu = INTEL_IOMMU_DEVICE(x86_iommu_get_default());
+
+    iommu->cap_frozen = true;
+
     object_child_foreach_recursive(object_get_root(),
                                    vtd_machine_done_notify_one, NULL);
 }
-- 
2.34.1


