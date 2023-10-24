Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 102DD7D4B2B
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 10:55:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvDAq-0002Px-Up; Tue, 24 Oct 2023 04:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qvDAn-00029H-Mj
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:54:02 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qvDAl-0006Q6-0E
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698137639; x=1729673639;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AFccV9mCBv24gWJhcpymHHVger5rDQQHs89pX7fsvN0=;
 b=S/7mqjZLkBjV0o3YpjqgPBGiqhmThXRYhM2+tIzKeMv10FzU7xZj5Ohi
 4tcw7jwioGn4a5D5si8miRjRdP3Jnn68HFHbkv5sbj5k5XWFbHErq8lO9
 DHpmoJ+oyYsTlSTqlBMrHvjrXmyjXKT3YbNnpzZZYvcpMez5dtkIu6rAW
 bhYbhlNEHQhd2vP0JM+hoF9zfH5tjVftrDd3tOQQqKHf4Uqt9hFLL3Vy8
 hNcUu2M0QRu1QD3tPnFUN8tYXZDBOSv5UjnkULlBrjAQk3ws5HKOG3jos
 Lsf9SdRxHkiBeAyj+MImpOdY/sQmU310lswL40HDNlL3uR3GdGulCb8yK Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="372077440"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; d="scan'208";a="372077440"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2023 01:53:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="793418355"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; d="scan'208";a="793418355"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga001.jf.intel.com with ESMTP; 24 Oct 2023 01:53:54 -0700
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v5 17/20] i386: Add cache topology info in CPUCacheInfo
Date: Tue, 24 Oct 2023 17:03:20 +0800
Message-Id: <20231024090323.1859210-18-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024090323.1859210-1-zhao1.liu@linux.intel.com>
References: <20231024090323.1859210-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.126;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Currently, by default, the cache topology is encoded as:
1. i/d cache is shared in one core.
2. L2 cache is shared in one core.
3. L3 cache is shared in one die.

This default general setting has caused a misunderstanding, that is, the
cache topology is completely equated with a specific cpu topology, such
as the connection between L2 cache and core level, and the connection
between L3 cache and die level.

In fact, the settings of these topologies depend on the specific
platform and are not static. For example, on Alder Lake-P, every
four Atom cores share the same L2 cache.

Thus, we should explicitly define the corresponding cache topology for
different cache models to increase scalability.

Except legacy_l2_cache_cpuid2 (its default topo level is
CPU_TOPO_LEVEL_UNKNOW), explicitly set the corresponding topology level
for all other cache models. In order to be compatible with the existing
cache topology, set the CPU_TOPO_LEVEL_CORE level for the i/d cache, set
the CPU_TOPO_LEVEL_CORE level for L2 cache, and set the
CPU_TOPO_LEVEL_DIE level for L3 cache.

The field for CPUID[4].EAX[bits 25:14] or CPUID[0x8000001D].EAX[bits
25:14] will be set based on CPUCacheInfo.share_level.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
Changes since v3:
 * Fix cache topology uninitialization bugs for some AMD CPUs. (Babu)
 * Move the CPUTopoLevel enumeration definition to the previous 0x1f
   rework patch.

Changes since v1:
 * Add the prefix "CPU_TOPO_LEVEL_*" for CPU topology level names.
   (Yanan)
 * (Revert, pls refer "i386: Decouple CPUID[0x1F] subleaf with specific
   topology level") Rename the "INVALID" level to CPU_TOPO_LEVEL_UNKNOW.
   (Yanan)
---
 target/i386/cpu.c | 36 ++++++++++++++++++++++++++++++++++++
 target/i386/cpu.h |  7 +++++++
 2 files changed, 43 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4b231cdc5005..ec98bc33b0bb 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -558,6 +558,7 @@ static CPUCacheInfo legacy_l1d_cache = {
     .sets = 64,
     .partitions = 1,
     .no_invd_sharing = true,
+    .share_level = CPU_TOPO_LEVEL_CORE,
 };
 
 /*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
@@ -572,6 +573,7 @@ static CPUCacheInfo legacy_l1d_cache_amd = {
     .partitions = 1,
     .lines_per_tag = 1,
     .no_invd_sharing = true,
+    .share_level = CPU_TOPO_LEVEL_CORE,
 };
 
 /* L1 instruction cache: */
@@ -585,6 +587,7 @@ static CPUCacheInfo legacy_l1i_cache = {
     .sets = 64,
     .partitions = 1,
     .no_invd_sharing = true,
+    .share_level = CPU_TOPO_LEVEL_CORE,
 };
 
 /*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
@@ -599,6 +602,7 @@ static CPUCacheInfo legacy_l1i_cache_amd = {
     .partitions = 1,
     .lines_per_tag = 1,
     .no_invd_sharing = true,
+    .share_level = CPU_TOPO_LEVEL_CORE,
 };
 
 /* Level 2 unified cache: */
@@ -612,6 +616,7 @@ static CPUCacheInfo legacy_l2_cache = {
     .sets = 4096,
     .partitions = 1,
     .no_invd_sharing = true,
+    .share_level = CPU_TOPO_LEVEL_CORE,
 };
 
 /*FIXME: CPUID leaf 2 descriptor is inconsistent with CPUID leaf 4 */
@@ -621,6 +626,7 @@ static CPUCacheInfo legacy_l2_cache_cpuid2 = {
     .size = 2 * MiB,
     .line_size = 64,
     .associativity = 8,
+    .share_level = CPU_TOPO_LEVEL_INVALID,
 };
 
 
@@ -634,6 +640,7 @@ static CPUCacheInfo legacy_l2_cache_amd = {
     .associativity = 16,
     .sets = 512,
     .partitions = 1,
+    .share_level = CPU_TOPO_LEVEL_CORE,
 };
 
 /* Level 3 unified cache: */
@@ -649,6 +656,7 @@ static CPUCacheInfo legacy_l3_cache = {
     .self_init = true,
     .inclusive = true,
     .complex_indexing = true,
+    .share_level = CPU_TOPO_LEVEL_DIE,
 };
 
 /* TLB definitions: */
@@ -1947,6 +1955,7 @@ static const CPUCaches epyc_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -1959,6 +1968,7 @@ static const CPUCaches epyc_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -1969,6 +1979,7 @@ static const CPUCaches epyc_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -1982,6 +1993,7 @@ static const CPUCaches epyc_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = true,
+        .share_level = CPU_TOPO_LEVEL_DIE,
     },
 };
 
@@ -1997,6 +2009,7 @@ static CPUCaches epyc_v4_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2009,6 +2022,7 @@ static CPUCaches epyc_v4_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2019,6 +2033,7 @@ static CPUCaches epyc_v4_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2032,6 +2047,7 @@ static CPUCaches epyc_v4_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = false,
+        .share_level = CPU_TOPO_LEVEL_DIE,
     },
 };
 
@@ -2047,6 +2063,7 @@ static const CPUCaches epyc_rome_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2059,6 +2076,7 @@ static const CPUCaches epyc_rome_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2069,6 +2087,7 @@ static const CPUCaches epyc_rome_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2082,6 +2101,7 @@ static const CPUCaches epyc_rome_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = true,
+        .share_level = CPU_TOPO_LEVEL_DIE,
     },
 };
 
@@ -2097,6 +2117,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2109,6 +2130,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2119,6 +2141,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2132,6 +2155,7 @@ static const CPUCaches epyc_rome_v3_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = false,
+        .share_level = CPU_TOPO_LEVEL_DIE,
     },
 };
 
@@ -2147,6 +2171,7 @@ static const CPUCaches epyc_milan_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2159,6 +2184,7 @@ static const CPUCaches epyc_milan_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2169,6 +2195,7 @@ static const CPUCaches epyc_milan_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2182,6 +2209,7 @@ static const CPUCaches epyc_milan_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = true,
+        .share_level = CPU_TOPO_LEVEL_DIE,
     },
 };
 
@@ -2197,6 +2225,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2209,6 +2238,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2219,6 +2249,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2232,6 +2263,7 @@ static const CPUCaches epyc_milan_v2_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = false,
+        .share_level = CPU_TOPO_LEVEL_DIE,
     },
 };
 
@@ -2247,6 +2279,7 @@ static const CPUCaches epyc_genoa_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -2259,6 +2292,7 @@ static const CPUCaches epyc_genoa_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2269,6 +2303,7 @@ static const CPUCaches epyc_genoa_cache_info = {
         .partitions = 1,
         .sets = 2048,
         .lines_per_tag = 1,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -2282,6 +2317,7 @@ static const CPUCaches epyc_genoa_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = false,
+        .share_level = CPU_TOPO_LEVEL_DIE,
     },
 };
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 2496839f2a28..223b3cb35093 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1597,6 +1597,13 @@ typedef struct CPUCacheInfo {
      * address bits.  CPUID[4].EDX[bit 2].
      */
     bool complex_indexing;
+
+    /*
+     * Cache Topology. The level that cache is shared in.
+     * Used to encode CPUID[4].EAX[bits 25:14] or
+     * CPUID[0x8000001D].EAX[bits 25:14].
+     */
+    enum CPUTopoLevel share_level;
 } CPUCacheInfo;
 
 
-- 
2.34.1


