Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD0B769CA5
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 18:34:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQVqF-0004cf-IZ; Mon, 31 Jul 2023 12:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQVq5-0004RF-Vm
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:33:46 -0400
Received: from [134.134.136.126] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qQVq3-0001Oy-S0
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 12:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690821223; x=1722357223;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GSbcff0w9eBcLKQoepD8WEW33V5SkOKmuZmwcCsYEA0=;
 b=NTlfG4LxaWZX26o/nJ0Ut5/yHPWaViOZxlu9Rtjb1cK2VV2Byb6+J+38
 mQxXcvmHpEjYazh/o1xSwo3yjMHNFU3oQRRnUdE0gKfKT+PPy1IeBHsio
 G0e7QRmF1lND7XFi5HimFhGxbmY+Dg3ReG1jnpCL5g6heL7t7paHEnoIH
 TbU232/Q8Z0PABzS9Ub3qfcLIPvQwbp2NkPQE853ly9Nqj2E0G4stlY8+
 H/zPuH1FKtGABDD0mEXE1/uvVgREro+yRQS+3fXp7H2CQIl/xgDvnyT2l
 3NsQiBoiI0q+pLeqhVZqVBt8yHmtjNgQSketCEmIqWCeM4vMhVJ5enF/e Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="353993572"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="353993572"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2023 09:26:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="757984336"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; d="scan'208";a="757984336"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.46])
 by orsmga008.jf.intel.com with ESMTP; 31 Jul 2023 09:25:56 -0700
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
Subject: [RFC PATCH 15/19] kvm: handle KVM_EXIT_MEMORY_FAULT
Date: Mon, 31 Jul 2023 12:21:57 -0400
Message-Id: <20230731162201.271114-16-xiaoyao.li@intel.com>
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

From: Chao Peng <chao.p.peng@linux.intel.com>

Currently only KVM_MEMORY_EXIT_FLAG_PRIVATE in flags is valid when
KVM_EXIT_MEMORY_FAULT happens. It indicates userspace needs to do
the memory conversion on the RAMBlock to turn the memory into desired
attribute, i.e., private/shared.

Note, KVM_EXIT_MEMORY_FAULT makes sense only when the RAMBlock has
gmem memory backend.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 accel/kvm/kvm-all.c | 52 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f9b5050b8885..72d50b923bf2 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3040,6 +3040,48 @@ static void kvm_eat_signals(CPUState *cpu)
     } while (sigismember(&chkset, SIG_IPI));
 }
 
+static int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
+{
+    MemoryRegionSection section;
+    void *addr;
+    RAMBlock *rb;
+    ram_addr_t offset;
+    int ret = -1;
+
+    section = memory_region_find(get_system_memory(), start, size);
+    if (!section.mr) {
+        return ret;
+    }
+
+    if (memory_region_can_be_private(section.mr)) {
+        if (to_private) {
+            ret = kvm_set_memory_attributes_private(start, size);
+        } else {
+            ret = kvm_set_memory_attributes_shared(start, size);
+        }
+
+        if (ret) {
+            return ret;
+        }
+
+        addr = memory_region_get_ram_ptr(section.mr) +
+               section.offset_within_region;
+        rb = qemu_ram_block_from_host(addr, false, &offset);
+        /*
+         * With KVM_SET_MEMORY_ATTRIBUTES by kvm_set_memory_attributes(),
+         * operation on underlying file descriptor is only for releasing
+         * unnecessary pages.
+         */
+        ram_block_convert_range(rb, offset, size, to_private);
+    } else {
+        warn_report("Convert non guest-memfd backed memory region (0x%"HWADDR_PRIx" ,+ 0x%"HWADDR_PRIx") to %s",
+                    start, size, to_private ? "private" : "shared");
+    }
+
+    memory_region_unref(section.mr);
+    return ret;
+}
+
 int kvm_cpu_exec(CPUState *cpu)
 {
     struct kvm_run *run = cpu->kvm_run;
@@ -3198,6 +3240,16 @@ int kvm_cpu_exec(CPUState *cpu)
                 break;
             }
             break;
+        case KVM_EXIT_MEMORY_FAULT:
+            if (run->memory.flags & ~KVM_MEMORY_EXIT_FLAG_PRIVATE) {
+                error_report("KVM_EXIT_MEMORY_FAULT: Unknown flag 0x%" PRIx64,
+                             (uint64_t)run->memory.flags);
+                ret = -1;
+                break;
+            }
+            ret = kvm_convert_memory(run->memory.gpa, run->memory.size,
+                                     run->memory.flags & KVM_MEMORY_EXIT_FLAG_PRIVATE);
+            break;
         default:
             DPRINTF("kvm_arch_handle_exit\n");
             ret = kvm_arch_handle_exit(cpu, run);
-- 
2.34.1


