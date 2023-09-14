Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BB979F925
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 05:53:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgdPL-0008Qt-NB; Wed, 13 Sep 2023 23:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qgdPI-00086k-QO
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 23:52:44 -0400
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1qgdPH-0000r7-4V
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 23:52:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694663563; x=1726199563;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HN90WpAcWxivDLGkYoPpDo7sWsy3b6+tOvB3ht8MLBY=;
 b=BTev+agIVvOVzSfM3f690ydEBugotf0WpJZ9+VrDT5fFxmjO9AE+3tPo
 TNfL0jQD+kVCXVoJLvPmHE9HNyX02PT6WeilqQ8J/nQyp6jFwHJ8O5vM9
 PNM5RsbAp5I/DhoWpGn5k2D5Ak69w2ilOxjiaOz3S5RhaNDqiT5+ukzfx
 tHZ7+FzaMkahxZK6G3/KlhikbWvVRHIkdBKgKCzPmKWCvhKt+ZqeBnvf1
 XB4ac0VEhqHNt3N5slcJJWImknXBBojRP+FSjuuKIIZKgHnS2YKpJAP7J
 /3H47nMHiNlAvmFoh5DFwPu/GVGf2PbwTvlCyX58Nx5BvtX2To3AzPwHU g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="381528538"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; d="scan'208";a="381528538"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Sep 2023 20:52:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="814500685"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; d="scan'208";a="814500685"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmsmga004.fm.intel.com with ESMTP; 13 Sep 2023 20:52:36 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, xiaoyao.li@intel.com,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 Sean Christopherson <seanjc@google.com>, Claudio Fontana <cfontana@suse.de>
Subject: [RFC PATCH v2 17/21] kvm: handle KVM_EXIT_MEMORY_FAULT
Date: Wed, 13 Sep 2023 23:51:13 -0400
Message-Id: <20230914035117.3285885-18-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914035117.3285885-1-xiaoyao.li@intel.com>
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.24; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
 accel/kvm/kvm-all.c | 54 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 7e32ee83b258..c67aa66b0559 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3040,6 +3040,50 @@ static void kvm_eat_signals(CPUState *cpu)
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
+    if (memory_region_has_gmem_fd(section.mr)) {
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
+        warn_report("Convert non guest-memfd backed memory region "
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
@@ -3198,6 +3242,16 @@ int kvm_cpu_exec(CPUState *cpu)
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


