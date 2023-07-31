Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 338C7769CCA
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 18:36:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQVph-0003KH-PR; Mon, 31 Jul 2023 12:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQVpe-00034n-RH
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:33:18 -0400
Received: from [134.134.136.126] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQVpc-0001LE-KJ
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690821196; x=1722357196;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2F3BNnQpA+emsmbBfMLeFksuw4ODRYROEr7ulTUvnvs=;
 b=a3Clg1TkpDOdIIpKIffO2pPoAn6B9CcaOdZynKkYb2XeBd3j2ZGLLa+t
 DEg7cb8L7C5yf7BCbGL6UCrsJwE0KPw50iji9LD2l0nDgL48CeE4GDtUG
 b5oXKaG2QwU2UMtw0Psiu8NPxzprAYAqZv07g/DBSql4+sn0wm7uuFvmx
 YD/rbkxU+EtApkaN5DHrGT3hpMBvdfOKZAMkI1bgolbHDHRsA3Y1fsBb0
 DMFQQi2sxRzlMuPAATg+aOar+VcCKBnYjHBDB0/vJI0Q03qitkiEKdquX
 S6K65uiz/vu5hwHhihPWqGwRDNtU1P3bpCQ6ZL8DWNinhVbg4XYcatUJC w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="353993511"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="353993511"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 09:25:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="757984276"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="757984276"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by orsmga008.jf.intel.com with ESMTP; 31 Jul 2023 09:25:38 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 xiaoyao.li@intel.com, qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: [RFC PATCH 11/19] kvm/memory: Introduce the infrastructure to set the
 default shared/private value
Date: Mon, 31 Jul 2023 12:21:53 -0400
Message-Id: <20230731162201.271114-12-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731162201.271114-1-xiaoyao.li@intel.com>
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 134.134.136.126 (failed)
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=xiaoyao.li@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Introduce new flags for MemoryRegion to indicate the default attribute,
private or not. And update the attribute if default private.

Originated-from: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 accel/kvm/kvm-all.c   | 10 ++++++++++
 include/exec/memory.h |  6 ++++++
 softmmu/memory.c      | 13 +++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 6dd22fa4fd6f..f9b5050b8885 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1487,6 +1487,16 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
                     strerror(-err));
             abort();
         }
+
+        if (memory_region_is_default_private(mr)) {
+            err = kvm_set_memory_attributes_private(start_addr, slot_size);
+            if (err) {
+                error_report("%s: failed to set memory attribute private: %s\n",
+                             __func__, strerror(-err));
+                exit(1);
+            }
+        }
+
         start_addr += slot_size;
         ram_start_offset += slot_size;
         ram += slot_size;
diff --git a/include/exec/memory.h b/include/exec/memory.h
index ddf0e14970b0..759f797b6acd 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -235,6 +235,9 @@ typedef struct IOMMUTLBEvent {
 /* RAM is an mmap-ed named file */
 #define RAM_NAMED_FILE (1 << 9)
 
+/* RAM is default private */
+#define RAM_DEFAULT_PRIVATE     (1 << 10)
+
 static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
                                        IOMMUNotifierFlag flags,
                                        hwaddr start, hwaddr end,
@@ -1689,6 +1692,9 @@ bool memory_region_is_protected(MemoryRegion *mr);
  */
 bool memory_region_can_be_private(MemoryRegion *mr);
 
+void memory_region_set_default_private(MemoryRegion *mr);
+bool memory_region_is_default_private(MemoryRegion *mr);
+
 /**
  * memory_region_get_iommu: check whether a memory region is an iommu
  *
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 336c76ede660..af6aa3c1e3c9 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1860,6 +1860,19 @@ bool memory_region_can_be_private(MemoryRegion *mr)
     return mr->ram_block && mr->ram_block->gmem_fd >= 0;
 }
 
+bool memory_region_is_default_private(MemoryRegion *mr)
+{
+    return mr->ram_block && mr->ram_block->gmem_fd >= 0 &&
+        (mr->ram_block->flags & RAM_DEFAULT_PRIVATE);
+}
+
+void memory_region_set_default_private(MemoryRegion *mr)
+{
+    if (mr->ram_block && mr->ram_block->gmem_fd >= 0) {
+        mr->ram_block->flags |= RAM_DEFAULT_PRIVATE;
+    }
+}
+
 uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr)
 {
     uint8_t mask = mr->dirty_log_mask;
-- 
2.34.1


