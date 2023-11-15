Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 529907EBDDC
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 08:22:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3AE0-00068G-0d; Wed, 15 Nov 2023 02:22:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3ADv-0005sj-RT
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:22:07 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1r3ADt-0005ES-V7
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 02:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700032925; x=1731568925;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cbxWEN7AdUzAAcSeAZm3Cpi9cquc6XfjGquydN+R/is=;
 b=AECcPlW88mBcn7E8TA1NV88UP++Q4UBiU4dEpy92rHUTTKSA5kjzukPI
 XLFNSFnObziwhlBZpzO5V53/NUQqx+n4xBRSs4xhxi9eTf1X69ASnyB22
 PV6NElpNEJpjBJAZ/qQq6YpCld/AwAdqyqwt3O6V0f5nDF5To8PfiJ70E
 eZ96TxuNVaZaoU5iaqf8/zE7SraXEjOMnyjdK78+uMQw9aPkUDqRxJ6YJ
 qe6fJH6CdUd0loL+VI1z0j7CCf9itPkFsnsFWOvkGSB3evNOts3tSNeRy
 2pcXOw3SQgZ1NaEsGvmeFZK5zQ5rCU0OHJgCpsgSxxwzFzkIWBbTctXlR g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390623353"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="390623353"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 23:22:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="714800137"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; d="scan'208";a="714800137"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orsmga003.jf.intel.com with ESMTP; 14 Nov 2023 23:21:57 -0800
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
Subject: [PATCH v3 48/70] i386/tdx: register TDVF as private memory
Date: Wed, 15 Nov 2023 02:14:57 -0500
Message-Id: <20231115071519.2864957-49-xiaoyao.li@intel.com>
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

Allocate private guest memfd memory for BIOS if it's TD VM.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Co-developed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/i386/x86.c         | 10 +++++++++-
 target/i386/kvm/tdx.c | 18 ++++++++++++++++++
 target/i386/kvm/tdx.h |  2 ++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 2f299355a5e3..0f69b55c5219 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1146,8 +1146,16 @@ void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
         (bios_size % 65536) != 0) {
         goto bios_error;
     }
+
     bios = g_malloc(sizeof(*bios));
-    memory_region_init_ram(bios, NULL, "pc.bios", bios_size, &error_fatal);
+    if (is_tdx_vm()) {
+        memory_region_init_ram_guest_memfd(bios, NULL, "pc.bios", bios_size,
+                                           &error_fatal);
+        tdx_set_tdvf_region(bios);
+    } else {
+        memory_region_init_ram(bios, NULL, "pc.bios", bios_size, &error_fatal);
+    }
+
     if (sev_enabled() || is_tdx_vm()) {
         /*
          * The concept of a "reset" simply doesn't exist for
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 6bb3249fa610..4b8c13890b11 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -21,6 +21,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
+#include "exec/ramblock.h"
 
 #include "hw/i386/e820_memory_layout.h"
 #include "hw/i386/x86.h"
@@ -461,6 +462,12 @@ static void update_tdx_cpuid_lookup_by_tdx_caps(void)
             (tdx_caps->xfam_fixed1 & CPUID_XSTATE_XSS_MASK) >> 32;
 }
 
+void tdx_set_tdvf_region(MemoryRegion *tdvf_region)
+{
+    assert(!tdx_guest->tdvf_region);
+    tdx_guest->tdvf_region = tdvf_region;
+}
+
 static TdxFirmwareEntry *tdx_get_hob_entry(TdxGuest *tdx)
 {
     TdxFirmwareEntry *entry;
@@ -582,6 +589,7 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
 {
     TdxFirmware *tdvf = &tdx_guest->tdvf;
     TdxFirmwareEntry *entry;
+    RAMBlock *ram_block;
     int r;
 
     tdx_init_ram_entries();
@@ -616,6 +624,12 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
             .nr_pages = entry->size / 4096,
         };
 
+        r = kvm_set_memory_attributes_private(entry->address, entry->size);
+        if (r < 0) {
+             error_report("Reserve initial private memory failed %s", strerror(-r));
+             exit(1);
+        }
+
         __u32 flags = entry->attributes & TDVF_SECTION_ATTRIBUTES_MR_EXTEND ?
                       KVM_TDX_MEASURE_MEMORY_REGION : 0;
 
@@ -631,6 +645,10 @@ static void tdx_finalize_vm(Notifier *notifier, void *unused)
             entry->mem_ptr = NULL;
         }
     }
+
+    /* Tdvf image was copied into private region above. It becomes unnecessary. */
+    ram_block = tdx_guest->tdvf_region->ram_block;
+    ram_block_discard_range(ram_block, 0, ram_block->max_length);
 }
 
 static Notifier tdx_machine_done_notify = {
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index 3a35a2bc0900..5fb20a5f06bb 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -38,6 +38,7 @@ typedef struct TdxGuest {
     char *mrownerconfig;    /* base64 encoded sha348 digest */
 
     TdxFirmware tdvf;
+    MemoryRegion *tdvf_region;
 
     uint32_t nr_ram_entries;
     TdxRamEntry *ram_entries;
@@ -53,6 +54,7 @@ int tdx_kvm_init(MachineState *ms, Error **errp);
 void tdx_get_supported_cpuid(uint32_t function, uint32_t index, int reg,
                              uint32_t *ret);
 int tdx_pre_create_vcpu(CPUState *cpu, Error **errp);
+void tdx_set_tdvf_region(MemoryRegion *tdvf_region);
 int tdx_parse_tdvf(void *flash_ptr, int size);
 
 #endif /* QEMU_I386_TDX_H */
-- 
2.34.1


