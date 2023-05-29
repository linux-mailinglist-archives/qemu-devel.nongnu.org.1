Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1BA714971
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 14:24:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3btX-0005Md-6c; Mon, 29 May 2023 08:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q3btP-00054U-4N
 for qemu-devel@nongnu.org; Mon, 29 May 2023 08:22:31 -0400
Received: from mga02.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q3btN-0006Yr-B2
 for qemu-devel@nongnu.org; Mon, 29 May 2023 08:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685362949; x=1716898949;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Rajl7LewH1n+gEEgodml7lsYyKMjzZe+FtiV5uooVDU=;
 b=XgGld29miJULgiu9fD4lukGPMhYkkFCBA80VUbecM7dGSSX+Ui3Ul6ei
 j0wi6jJLPGVI5WKW4QFBxUVE/P2V52QExYg3sCXh4hY8V7C4LTI3X43j+
 nm/W3NHGfjW+54/b0ug4zMjddui2Nv+l7Sw/qZzS1u1bxW42fCgZghCis
 Se5ap3wn1y6yTPOekFk2qSG8/cvgP/Oqy/E3bnhnS09/T8YV2S3stOQpD
 cPHRYS1IqDbdU4DnGKFgnnM4H12QcWkGSdosQvC/ZEIj/zHhEx4FTFvp0
 9RVMyLWc7/hEg6LVmNAgLyOfYIhe+6EVZrDblbjny/Cw/bxMAKDCUrseW A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="344190301"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="344190301"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2023 05:22:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="850388722"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="850388722"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.28])
 by fmsmga001.fm.intel.com with ESMTP; 29 May 2023 05:22:13 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Babu Moger <babu.moger@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 14/17] i386: Use CPUCacheInfo.share_level to encode CPUID[4]
Date: Mon, 29 May 2023 20:30:58 +0800
Message-Id: <20230529123101.411267-15-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529123101.411267-1-zhao1.liu@linux.intel.com>
References: <20230529123101.411267-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.20;
 envelope-from=zhao1.liu@linux.intel.com; helo=mga02.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

CPUID[4].EAX[bits 25:14] is used to represent the cache topology for
intel CPUs.

After cache models have topology information, we can use
CPUCacheInfo.share_level to decide which topology level to be encoded
into CPUID[4].EAX[bits 25:14].

And since maximum_processor_id (original "num_apic_ids") is parsed
based on cpu topology levels, which are verified when parsing smp, it's
no need to check this value by "assert(num_apic_ids > 0)" again, so
remove this assert.

Additionally, wrap the encoding of CPUID[4].EAX[bits 31:26] into a
helper to make the code more clean.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v1:
 * Use "enum CPUTopoLevel share_level" as the parameter in
   max_processor_ids_for_cache().
 * Make cache_into_passthrough case also use
   max_processor_ids_for_cache() and max_core_ids_in_package() to
   encode CPUID[4]. (Yanan)
 * Rename the title of this patch (the original is "i386: Use
   CPUCacheInfo.share_level to encode CPUID[4].EAX[bits 25:14]").
---
 target/i386/cpu.c | 70 +++++++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 27 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d36cea505727..962f7a5c8328 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -234,22 +234,53 @@ static uint8_t cpuid2_cache_descriptor(CPUCacheInfo *cache)
                        ((t) == UNIFIED_CACHE) ? CACHE_TYPE_UNIFIED : \
                        0 /* Invalid value */)
 
+static uint32_t max_processor_ids_for_cache(X86CPUTopoInfo *topo_info,
+                                            enum CPUTopoLevel share_level)
+{
+    uint32_t num_ids = 0;
+
+    switch (share_level) {
+    case CPU_TOPO_LEVEL_CORE:
+        num_ids = 1 << apicid_core_offset(topo_info);
+        break;
+    case CPU_TOPO_LEVEL_DIE:
+        num_ids = 1 << apicid_die_offset(topo_info);
+        break;
+    case CPU_TOPO_LEVEL_PACKAGE:
+        num_ids = 1 << apicid_pkg_offset(topo_info);
+        break;
+    default:
+        /*
+         * Currently there is no use case for SMT and MODULE, so use
+         * assert directly to facilitate debugging.
+         */
+        g_assert_not_reached();
+    }
+
+    return num_ids - 1;
+}
+
+static uint32_t max_core_ids_in_package(X86CPUTopoInfo *topo_info)
+{
+    uint32_t num_cores = 1 << (apicid_pkg_offset(topo_info) -
+                               apicid_core_offset(topo_info));
+    return num_cores - 1;
+}
 
 /* Encode cache info for CPUID[4] */
 static void encode_cache_cpuid4(CPUCacheInfo *cache,
-                                int num_apic_ids, int num_cores,
+                                X86CPUTopoInfo *topo_info,
                                 uint32_t *eax, uint32_t *ebx,
                                 uint32_t *ecx, uint32_t *edx)
 {
     assert(cache->size == cache->line_size * cache->associativity *
                           cache->partitions * cache->sets);
 
-    assert(num_apic_ids > 0);
     *eax = CACHE_TYPE(cache->type) |
            CACHE_LEVEL(cache->level) |
            (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0) |
-           ((num_cores - 1) << 26) |
-           ((num_apic_ids - 1) << 14);
+           (max_core_ids_in_package(topo_info) << 26) |
+           (max_processor_ids_for_cache(topo_info, cache->share_level) << 14);
 
     assert(cache->line_size > 0);
     assert(cache->partitions > 0);
@@ -5853,56 +5884,41 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                 int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
 
                 if (cores_per_pkg > 1) {
-                    int addressable_cores_offset =
-                                                apicid_pkg_offset(&topo_info) -
-                                                apicid_core_offset(&topo_info);
-
                     *eax &= ~0xFC000000;
-                    *eax |= (1 << addressable_cores_offset - 1) << 26;
+                    *eax |= max_core_ids_in_package(&topo_info) << 26;
                 }
                 if (host_vcpus_per_cache > cpus_per_pkg) {
-                    int pkg_offset = apicid_pkg_offset(&topo_info);
-
                     *eax &= ~0x3FFC000;
-                    *eax |= (1 << pkg_offset - 1) << 14;
+                    *eax |=
+                        max_processor_ids_for_cache(&topo_info,
+                                                CPU_TOPO_LEVEL_PACKAGE) << 14;
                 }
             }
         } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
             *eax = *ebx = *ecx = *edx = 0;
         } else {
             *eax = 0;
-            int addressable_cores_offset = apicid_pkg_offset(&topo_info) -
-                                           apicid_core_offset(&topo_info);
-            int core_offset, die_offset;
 
             switch (count) {
             case 0: /* L1 dcache info */
-                core_offset = apicid_core_offset(&topo_info);
                 encode_cache_cpuid4(env->cache_info_cpuid4.l1d_cache,
-                                    (1 << core_offset),
-                                    (1 << addressable_cores_offset),
+                                    &topo_info,
                                     eax, ebx, ecx, edx);
                 break;
             case 1: /* L1 icache info */
-                core_offset = apicid_core_offset(&topo_info);
                 encode_cache_cpuid4(env->cache_info_cpuid4.l1i_cache,
-                                    (1 << core_offset),
-                                    (1 << addressable_cores_offset),
+                                    &topo_info,
                                     eax, ebx, ecx, edx);
                 break;
             case 2: /* L2 cache info */
-                core_offset = apicid_core_offset(&topo_info);
                 encode_cache_cpuid4(env->cache_info_cpuid4.l2_cache,
-                                    (1 << core_offset),
-                                    (1 << addressable_cores_offset),
+                                    &topo_info,
                                     eax, ebx, ecx, edx);
                 break;
             case 3: /* L3 cache info */
-                die_offset = apicid_die_offset(&topo_info);
                 if (cpu->enable_l3_cache) {
                     encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
-                                        (1 << die_offset),
-                                        (1 << addressable_cores_offset),
+                                        &topo_info,
                                         eax, ebx, ecx, edx);
                     break;
                 }
-- 
2.34.1


