Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CC9AE1726
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Jun 2025 11:08:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSXiP-0001tw-SY; Fri, 20 Jun 2025 05:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uSXi7-0001OJ-V4
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 05:07:00 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uSXi5-0004zi-V2
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 05:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750410418; x=1781946418;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eJlhlDHR30yWHTl1SoK1ZyyzmD1JEZ0XqJoW4s0MGiU=;
 b=CP2GHLuAe+r1CrIcZDfm/GXMc9E9EyZlL7VT2aql48aeatuojnf3ghcC
 78m6rpUV2EH7IyeB9bX0LVB+2BkH0L2mDKlLYnHn8dPcOQVIEbx595qra
 YUqtWwv5Umu+MZulqPptwvnSQG8uA1yQSFZ3NSFTeK13V/7/oZk0tPJ9O
 hAYifOq86xURPI4FhlvXPAQUH2CEoeaPcNaY4taWqq2T8QkDmVxzX069L
 2ih/M7BkzF5foFAPnlB9f4DsXWCu7BS+rCOc5LybByvVjLL7tOWOFQpZo
 gZIy3cbC9BCex2Mo1JWRvtFVlGt1Gh/p7jo0w4boDKDQ9xJYJp/tRG+sN Q==;
X-CSE-ConnectionGUID: BtWto6p0SNyPxNaPSDKNPQ==
X-CSE-MsgGUID: WJPTB8aCQDuHY3kKuBPp/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="56466719"
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="56466719"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2025 02:06:57 -0700
X-CSE-ConnectionGUID: EOkMFY+GTGqQ+ZlfL5TuEw==
X-CSE-MsgGUID: Pqutg3pXRd6USNNVHLqz3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,251,1744095600"; d="scan'208";a="156670082"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 20 Jun 2025 02:06:53 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Babu Moger <babu.moger@amd.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Pu Wen <puwen@hygon.cn>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 08/16] i386/cpu: Fix CPUID[0x80000006] for Intel CPU
Date: Fri, 20 Jun 2025 17:27:26 +0800
Message-Id: <20250620092734.1576677-9-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250620092734.1576677-1-zhao1.liu@intel.com>
References: <20250620092734.1576677-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Per SDM, Intel supports CPUID[0x80000006]. But only L2 information is
encoded in ECX (note that L2 associativity field encodings rules
consistent with AMD are used), all other fields are reserved.

Therefore, make the following changes to CPUID[0x80000006]:
 * Rename AMD_ENC_ASSOC to X86_ENC_ASSOC since Intel also uses the same
   rules. (While there are some slight differences between the rules in
   AMD APM v4.07 no.40332 and those in the current QEMU, generally they
   are consistent.)
 * Check the vendor in CPUID[0x80000006] and just encode L2 to ECX for
   Intel.
 * Assert L2's lines_per_tag is not 0 for AMD, and assert it is 0 for
   Intel.
 * Apply the encoding change of Intel for Zhaoxin as well [1].

This fix also resolves the FIXME of legacy_l2_cache_amd:

/*FIXME: CPUID leaf 0x80000006 is inconsistent with leaves 2 & 4 */

In addition, per AMD's APM, update the comment of CPUID[0x80000006].

[1]: https://lore.kernel.org/qemu-devel/c522ebb5-04d5-49c6-9ad8-d755b8998988@zhaoxin.com/
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since RFC:
 * Check vendor_cpuid_only_v2 instead of vendor_cpuid_only.
 * Move lines_per_tag assert check into encode_cache_cpuid80000006().
---
 target/i386/cpu.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index df40d1362566..0b292aa2e07b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -506,8 +506,8 @@ static uint32_t encode_cache_cpuid80000005(CPUCacheInfo *cache)
 
 #define ASSOC_FULL 0xFF
 
-/* AMD associativity encoding used on CPUID Leaf 0x80000006: */
-#define AMD_ENC_ASSOC(a) (a <=   1 ? a   : \
+/* x86 associativity encoding used on CPUID Leaf 0x80000006: */
+#define X86_ENC_ASSOC(a) (a <=   1 ? a   : \
                           a ==   2 ? 0x2 : \
                           a ==   4 ? 0x4 : \
                           a ==   8 ? 0x6 : \
@@ -526,23 +526,26 @@ static uint32_t encode_cache_cpuid80000005(CPUCacheInfo *cache)
  */
 static void encode_cache_cpuid80000006(CPUCacheInfo *l2,
                                        CPUCacheInfo *l3,
-                                       uint32_t *ecx, uint32_t *edx)
+                                       uint32_t *ecx, uint32_t *edx,
+                                       bool lines_per_tag_supported)
 {
     assert(l2->size % 1024 == 0);
     assert(l2->associativity > 0);
-    assert(l2->lines_per_tag > 0);
-    assert(l2->line_size > 0);
+    assert(lines_per_tag_supported ?
+           l2->lines_per_tag > 0 : l2->lines_per_tag == 0);
     *ecx = ((l2->size / 1024) << 16) |
-           (AMD_ENC_ASSOC(l2->associativity) << 12) |
+           (X86_ENC_ASSOC(l2->associativity) << 12) |
            (l2->lines_per_tag << 8) | (l2->line_size);
 
+    /* For Intel, EDX is reserved. */
     if (l3) {
         assert(l3->size % (512 * 1024) == 0);
         assert(l3->associativity > 0);
-        assert(l3->lines_per_tag > 0);
+        assert(lines_per_tag_supported ?
+               l3->lines_per_tag > 0 : l3->lines_per_tag == 0);
         assert(l3->line_size > 0);
         *edx = ((l3->size / (512 * 1024)) << 18) |
-               (AMD_ENC_ASSOC(l3->associativity) << 12) |
+               (X86_ENC_ASSOC(l3->associativity) << 12) |
                (l3->lines_per_tag << 8) | (l3->line_size);
     } else {
         *edx = 0;
@@ -711,7 +714,6 @@ static CPUCacheInfo legacy_l2_cache = {
     .share_level = CPU_TOPOLOGY_LEVEL_CORE,
 };
 
-/*FIXME: CPUID leaf 0x80000006 is inconsistent with leaves 2 & 4 */
 static CPUCacheInfo legacy_l2_cache_amd = {
     .type = UNIFIED_CACHE,
     .level = 2,
@@ -7906,23 +7908,33 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *edx = encode_cache_cpuid80000005(env->cache_info_amd.l1i_cache);
         break;
     case 0x80000006:
-        /* cache info (L2 cache) */
+        /* cache info (L2 cache/TLB/L3 cache) */
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
             break;
         }
-        *eax = (AMD_ENC_ASSOC(L2_DTLB_2M_ASSOC) << 28) |
+
+        if (cpu->vendor_cpuid_only_v2 &&
+            (IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env))) {
+            *eax = *ebx = 0;
+            encode_cache_cpuid80000006(env->cache_info_cpuid4.l2_cache,
+                                       NULL, ecx, edx, false);
+            break;
+        }
+
+        *eax = (X86_ENC_ASSOC(L2_DTLB_2M_ASSOC) << 28) |
                (L2_DTLB_2M_ENTRIES << 16) |
-               (AMD_ENC_ASSOC(L2_ITLB_2M_ASSOC) << 12) |
+               (X86_ENC_ASSOC(L2_ITLB_2M_ASSOC) << 12) |
                (L2_ITLB_2M_ENTRIES);
-        *ebx = (AMD_ENC_ASSOC(L2_DTLB_4K_ASSOC) << 28) |
+        *ebx = (X86_ENC_ASSOC(L2_DTLB_4K_ASSOC) << 28) |
                (L2_DTLB_4K_ENTRIES << 16) |
-               (AMD_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) |
+               (X86_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) |
                (L2_ITLB_4K_ENTRIES);
+
         encode_cache_cpuid80000006(env->cache_info_amd.l2_cache,
                                    cpu->enable_l3_cache ?
                                    env->cache_info_amd.l3_cache : NULL,
-                                   ecx, edx);
+                                   ecx, edx, true);
         break;
     case 0x80000007:
         *eax = 0;
-- 
2.34.1


