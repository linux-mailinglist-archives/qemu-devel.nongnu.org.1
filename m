Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF0973721B
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 18:51:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBeZT-0003Z9-QK; Tue, 20 Jun 2023 12:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1qBeZN-0003Yf-8f
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:51:05 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isaku.yamahata@intel.com>)
 id 1qBeZJ-00054S-BS
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 12:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687279861; x=1718815861;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=p7mCt+GtEic3MbUydVwdYYLTQC2lZqrngfjr58vKJ7U=;
 b=R9PtY16ZEhYHJPkE+yNJRZ18YBAck0luiRL5GLy72HFS4EG+C/cf0bzn
 BsumHHiSDxwFdiT40KfM36KA/f0MfY2do+5s81lSBSL9fAJHFbscR6DKP
 z5WB9/AMLcf8CgY4e9ohx16umes86ELlsieeBrQ3ZtsK676cWayWiZAdp
 zfT8tGNE+DrNxQhJQcxVmcJ5hHaAR86KRngJl5HUtTIkwJq6WlcZM6NFo
 XGop1QbIrXj1qhK0ofa8vHKaY6kYFzLhlARF8imaHitT+7C87Myde5Wca
 3z3VsSl6Vfi1sLGHRf667ZBI6Y4N5YO3SA4726z8aAy/uQrajNhz6RPvG w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="389218032"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; d="scan'208";a="389218032"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2023 09:50:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="691499957"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; d="scan'208";a="691499957"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2023 09:50:55 -0700
From: Isaku Yamahata <isaku.yamahata@intel.com>
To: qemu-devel@nongnu.org
Cc: Isaku Yamahata <isaku.yamahata@intel.com>
Subject: [PATCH 1/3] exec/memory: Add symbolic value for memory listener
 priority for accel
Date: Tue, 20 Jun 2023 09:50:47 -0700
Message-Id: <feebe423becc6e2aa375f59f6abce9a85bc15abb.1687279702.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687279702.git.isaku.yamahata@intel.com>
References: <cover.1687279702.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.88;
 envelope-from=isaku.yamahata@intel.com; helo=mga01.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Add MEMORY_LISTNER_PRIORITY_ACCEL for the symbolic value for the memory
listener to replace the hard-coded value 10 for accel.

No functional change intended.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 accel/hvf/hvf-accel-ops.c   | 2 +-
 accel/kvm/kvm-all.c         | 2 +-
 hw/arm/xen_arm.c            | 2 +-
 hw/i386/xen/xen-hvm.c       | 2 +-
 hw/xen/xen-hvm-common.c     | 2 +-
 hw/xen/xen_pt.c             | 4 ++--
 include/exec/memory.h       | 2 ++
 target/i386/hax/hax-mem.c   | 2 +-
 target/i386/nvmm/nvmm-all.c | 2 +-
 target/i386/whpx/whpx-all.c | 2 +-
 10 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 9c3da03c948f..c0c51841a615 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -304,7 +304,7 @@ static void hvf_region_del(MemoryListener *listener,
 
 static MemoryListener hvf_memory_listener = {
     .name = "hvf",
-    .priority = 10,
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
     .region_add = hvf_region_add,
     .region_del = hvf_region_del,
     .log_start = hvf_log_start,
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 7679f397aec0..36ed4ca246b5 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1775,7 +1775,7 @@ void kvm_memory_listener_register(KVMState *s, KVMMemoryListener *kml,
     kml->listener.commit = kvm_region_commit;
     kml->listener.log_start = kvm_log_start;
     kml->listener.log_stop = kvm_log_stop;
-    kml->listener.priority = 10;
+    kml->listener.priority = MEMORY_LISTENER_PRIORITY_ACCEL;
     kml->listener.name = name;
 
     if (s->kvm_dirty_ring_size) {
diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index 19b1cb81ade9..044093fec75d 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -45,7 +45,7 @@ static MemoryListener xen_memory_listener = {
     .log_sync = NULL,
     .log_global_start = NULL,
     .log_global_stop = NULL,
-    .priority = 10,
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
 };
 
 struct XenArmState {
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 5dc5e805351c..3da5a2b23f7d 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -467,7 +467,7 @@ static MemoryListener xen_memory_listener = {
     .log_sync = xen_log_sync,
     .log_global_start = xen_log_global_start,
     .log_global_stop = xen_log_global_stop,
-    .priority = 10,
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
 };
 
 static void regs_to_cpu(vmware_regs_t *vmport_regs, ioreq_t *req)
diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 42339c96bdba..886c3ee944d3 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -155,7 +155,7 @@ MemoryListener xen_io_listener = {
     .name = "xen-io",
     .region_add = xen_io_add,
     .region_del = xen_io_del,
-    .priority = 10,
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
 };
 
 DeviceListener xen_device_listener = {
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index a5401496399b..36e6f93c372f 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -691,14 +691,14 @@ static const MemoryListener xen_pt_memory_listener = {
     .name = "xen-pt-mem",
     .region_add = xen_pt_region_add,
     .region_del = xen_pt_region_del,
-    .priority = 10,
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
 };
 
 static const MemoryListener xen_pt_io_listener = {
     .name = "xen-pt-io",
     .region_add = xen_pt_io_region_add,
     .region_del = xen_pt_io_region_del,
-    .priority = 10,
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
 };
 
 /* destroy. */
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 47c2e0221c35..6d95d5917544 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -811,6 +811,8 @@ struct IOMMUMemoryRegion {
 #define IOMMU_NOTIFIER_FOREACH(n, mr) \
     QLIST_FOREACH((n), &(mr)->iommu_notify, node)
 
+#define MEMORY_LISTENER_PRIORITY_ACCEL          10
+
 /**
  * struct MemoryListener: callbacks structure for updates to the physical memory map
  *
diff --git a/target/i386/hax/hax-mem.c b/target/i386/hax/hax-mem.c
index 05dbe8cce3ae..bb5ffbc9ac4f 100644
--- a/target/i386/hax/hax-mem.c
+++ b/target/i386/hax/hax-mem.c
@@ -291,7 +291,7 @@ static MemoryListener hax_memory_listener = {
     .region_add = hax_region_add,
     .region_del = hax_region_del,
     .log_sync = hax_log_sync,
-    .priority = 10,
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
 };
 
 static void hax_ram_block_added(RAMBlockNotifier *n, void *host, size_t size,
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index b75738ee9cdf..19d2f7ef09a6 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -1138,7 +1138,7 @@ static MemoryListener nvmm_memory_listener = {
     .region_add = nvmm_region_add,
     .region_del = nvmm_region_del,
     .log_sync = nvmm_log_sync,
-    .priority = 10,
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
 };
 
 static void
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 52af81683c1e..7f94dd438826 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2427,7 +2427,7 @@ static MemoryListener whpx_memory_listener = {
     .region_add = whpx_region_add,
     .region_del = whpx_region_del,
     .log_sync = whpx_log_sync,
-    .priority = 10,
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
 };
 
 static void whpx_memory_init(void)
-- 
2.25.1


