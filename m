Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7637EBD92
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 08:18:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3A9J-0007GE-DM; Wed, 15 Nov 2023 02:17:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3A8o-0006jX-Pt
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:16:54 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3A8l-0002JU-CF
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700032607; x=1731568607;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bCmG5IUfIwWesh4kdOW1tz+KnTsMRtNuvE/tn0svV/0=;
 b=l7GPAku0SWb4ICGR0ueFplTidn2CcgB7RnBAqbMiOe2LEx3SI+Xjl7vm
 nO9OZ0mILqgTXDbERVi/fpUEBAXmQf5hfZ58P7NKrmUzzdxoozAEhVJZF
 unVi1hCPvlS1piAiyHPHSZhUyNPlYeDttoilkZYrcEftfWgIeGbQgpwsf
 LCldi/GZFgsEeXkhq2gCOCksR+9OJmpX4BbmQP+Lin9rMtkDNUDeXKH6m
 kGpj9IXslmFpIQnCg+e4NKSQ1wbsOd87CIUKQJU2tPq9HI5LuHiwDB8rW
 GL7XweALJ8yEkRAVZeWGq7dO3u4PoTk6oSHRk2IVsp6d5X05roXVEdrrd w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390622270"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="390622270"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 23:16:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="714797262"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="714797262"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orsmga003.jf.intel.com with ESMTP; 14 Nov 2023 23:16:38 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, xiaoyao.li@intel.com,
 Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [PATCH v3 10/70] kvm: handle KVM_EXIT_MEMORY_FAULT
Date: Wed, 15 Nov 2023 02:14:19 -0500
Message-Id: <20231115071519.2864957-11-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115071519.2864957-1-xiaoyao.li@intel.com>
References: <20231115071519.2864957-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.115; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

From: Chao Peng <chao.p.peng@linux.intel.com>

Currently only KVM_MEMORY_EXIT_FLAG_PRIVATE in flags is valid when
KVM_EXIT_MEMORY_FAULT happens. It indicates userspace needs to do
the memory conversion on the RAMBlock to turn the memory into desired
attribute, i.e., private/shared.

Note, KVM_EXIT_MEMORY_FAULT makes sense only when the RAMBlock has
guest_memfd memory backend.

Note, KVM_EXIT_MEMORY_FAULT returns with -EFAULT, so special handling is
added.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 accel/kvm/kvm-all.c | 76 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 66 insertions(+), 10 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 76e2404d54d2..58abbcb6926e 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2902,6 +2902,50 @@ static void kvm_eat_signals(CPUState *cpu)
     } while (sigismember(&chkset, SIG_IPI));
 }
 
+static int kvm_convert_memory(hwaddr start, hwaddr size, bool to_private)
+{
+    MemoryRegionSection section;
+    ram_addr_t offset;
+    RAMBlock *rb;
+    void *addr;
+    int ret = -1;
+
+    section = memory_region_find(get_system_memory(), start, size);
+    if (!section.mr) {
+        return ret;
+    }
+
+    if (memory_region_has_guest_memfd(section.mr)) {
+        if (to_private) {
+            ret = kvm_set_memory_attributes_private(start, size);
+        } else {
+            ret = kvm_set_memory_attributes_shared(start, size);
+        }
+
+        if (ret) {
+            memory_region_unref(section.mr);
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
+        warn_report("Convert non guest_memfd backed memory region "
+                    "(0x%"HWADDR_PRIx" ,+ 0x%"HWADDR_PRIx") to %s",
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
@@ -2969,18 +3013,20 @@ int kvm_cpu_exec(CPUState *cpu)
                 ret = EXCP_INTERRUPT;
                 break;
             }
-            fprintf(stderr, "error: kvm run failed %s\n",
-                    strerror(-run_ret));
+            if (!(run_ret == -EFAULT && run->exit_reason == KVM_EXIT_MEMORY_FAULT)) {
+                fprintf(stderr, "error: kvm run failed %s\n",
+                        strerror(-run_ret));
 #ifdef TARGET_PPC
-            if (run_ret == -EBUSY) {
-                fprintf(stderr,
-                        "This is probably because your SMT is enabled.\n"
-                        "VCPU can only run on primary threads with all "
-                        "secondary threads offline.\n");
-            }
+                if (run_ret == -EBUSY) {
+                    fprintf(stderr,
+                            "This is probably because your SMT is enabled.\n"
+                            "VCPU can only run on primary threads with all "
+                            "secondary threads offline.\n");
+                }
 #endif
-            ret = -1;
-            break;
+                ret = -1;
+                break;
+            }
         }
 
         trace_kvm_run_exit(cpu->cpu_index, run->exit_reason);
@@ -3067,6 +3113,16 @@ int kvm_cpu_exec(CPUState *cpu)
                 break;
             }
             break;
+        case KVM_EXIT_MEMORY_FAULT:
+            if (run->memory_fault.flags & ~KVM_MEMORY_EXIT_FLAG_PRIVATE) {
+                error_report("KVM_EXIT_MEMORY_FAULT: Unknown flag 0x%" PRIx64,
+                             (uint64_t)run->memory_fault.flags);
+                ret = -1;
+                break;
+            }
+            ret = kvm_convert_memory(run->memory_fault.gpa, run->memory_fault.size,
+                                     run->memory_fault.flags & KVM_MEMORY_EXIT_FLAG_PRIVATE);
+            break;
         default:
             DPRINTF("kvm_arch_handle_exit\n");
             ret = kvm_arch_handle_exit(cpu, run);
-- 
2.34.1


