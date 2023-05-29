Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9798B71496B
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 14:23:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3btW-0005M2-Ik; Mon, 29 May 2023 08:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q3btU-0005JU-SM
 for qemu-devel@nongnu.org; Mon, 29 May 2023 08:22:36 -0400
Received: from mga02.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1q3btS-0006RT-DV
 for qemu-devel@nongnu.org; Mon, 29 May 2023 08:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685362954; x=1716898954;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VFnOa0+v+5h+ej3Mz0tEr35h9DW2Qmo/r/G0siQNBCo=;
 b=JfgNYVUfgukGKI1IryTwmz/P5TIjtEJl+3dhHTYlm0RnTG985GSoICk0
 bPJvX1Ssms/KYE66LdOwNql9p1vYqXg8ClZpAIrEy37f4Ug9g6AX6tRh5
 sQ/mRYlQc6YX5XBA7VyxMD2kyFa6BUJKedn26EGr6ADFJnG0TkP3MVA1v
 2wZz61i1dFTz0UDNWRVOiLCPvl45kX3dKGcX3S730s6xUWS7/wdBRkmla
 UwWHnxR5lnGr0lKu74b8EtDFeXCdHh2cQMSqP5N2vLYKXmodaCf5pd4Kt
 DqW/URf1hN5PgqjXQyCI+JQAFlc1DA518AI8dEEkFSoT9QUedIdbxWpfy A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="344190311"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="344190311"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2023 05:22:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="850388717"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="850388717"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.28])
 by fmsmga001.fm.intel.com with ESMTP; 29 May 2023 05:22:10 -0700
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
Subject: [PATCH v2 13/17] i386: Add cache topology info in CPUCacheInfo
Date: Mon, 29 May 2023 20:30:57 +0800
Message-Id: <20230529123101.411267-14-zhao1.liu@linux.intel.com>
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
---
Changes since v1:
 * Add the prefix "CPU_TOPO_LEVEL_*" for CPU topology level names.
   (Yanan)
 * Rename the "INVALID" level to "CPU_TOPO_LEVEL_UNKNOW". (Yanan)
---
 target/i386/cpu.c | 19 +++++++++++++++++++
 target/i386/cpu.h | 16 ++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e8d156428772..d36cea505727 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -436,6 +436,7 @@ static CPUCacheInfo legacy_l1d_cache = {
     .sets = 64,
     .partitions = 1,
     .no_invd_sharing = true,
+    .share_level = CPU_TOPO_LEVEL_CORE,
 };
 
 /*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
@@ -450,6 +451,7 @@ static CPUCacheInfo legacy_l1d_cache_amd = {
     .partitions = 1,
     .lines_per_tag = 1,
     .no_invd_sharing = true,
+    .share_level = CPU_TOPO_LEVEL_CORE,
 };
 
 /* L1 instruction cache: */
@@ -463,6 +465,7 @@ static CPUCacheInfo legacy_l1i_cache = {
     .sets = 64,
     .partitions = 1,
     .no_invd_sharing = true,
+    .share_level = CPU_TOPO_LEVEL_CORE,
 };
 
 /*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
@@ -477,6 +480,7 @@ static CPUCacheInfo legacy_l1i_cache_amd = {
     .partitions = 1,
     .lines_per_tag = 1,
     .no_invd_sharing = true,
+    .share_level = CPU_TOPO_LEVEL_CORE,
 };
 
 /* Level 2 unified cache: */
@@ -490,6 +494,7 @@ static CPUCacheInfo legacy_l2_cache = {
     .sets = 4096,
     .partitions = 1,
     .no_invd_sharing = true,
+    .share_level = CPU_TOPO_LEVEL_CORE,
 };
 
 /*FIXME: CPUID leaf 2 descriptor is inconsistent with CPUID leaf 4 */
@@ -512,6 +517,7 @@ static CPUCacheInfo legacy_l2_cache_amd = {
     .associativity = 16,
     .sets = 512,
     .partitions = 1,
+    .share_level = CPU_TOPO_LEVEL_CORE,
 };
 
 /* Level 3 unified cache: */
@@ -527,6 +533,7 @@ static CPUCacheInfo legacy_l3_cache = {
     .self_init = true,
     .inclusive = true,
     .complex_indexing = true,
+    .share_level = CPU_TOPO_LEVEL_DIE,
 };
 
 /* TLB definitions: */
@@ -1709,6 +1716,7 @@ static const CPUCaches epyc_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -1721,6 +1729,7 @@ static const CPUCaches epyc_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -1731,6 +1740,7 @@ static const CPUCaches epyc_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -1744,6 +1754,7 @@ static const CPUCaches epyc_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = true,
+        .share_level = CPU_TOPO_LEVEL_DIE,
     },
 };
 
@@ -1809,6 +1820,7 @@ static const CPUCaches epyc_rome_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -1821,6 +1833,7 @@ static const CPUCaches epyc_rome_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -1831,6 +1844,7 @@ static const CPUCaches epyc_rome_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -1844,6 +1858,7 @@ static const CPUCaches epyc_rome_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = true,
+        .share_level = CPU_TOPO_LEVEL_DIE,
     },
 };
 
@@ -1909,6 +1924,7 @@ static const CPUCaches epyc_milan_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l1i_cache = &(CPUCacheInfo) {
         .type = INSTRUCTION_CACHE,
@@ -1921,6 +1937,7 @@ static const CPUCaches epyc_milan_cache_info = {
         .lines_per_tag = 1,
         .self_init = 1,
         .no_invd_sharing = true,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l2_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -1931,6 +1948,7 @@ static const CPUCaches epyc_milan_cache_info = {
         .partitions = 1,
         .sets = 1024,
         .lines_per_tag = 1,
+        .share_level = CPU_TOPO_LEVEL_CORE,
     },
     .l3_cache = &(CPUCacheInfo) {
         .type = UNIFIED_CACHE,
@@ -1944,6 +1962,7 @@ static const CPUCaches epyc_milan_cache_info = {
         .self_init = true,
         .inclusive = true,
         .complex_indexing = true,
+        .share_level = CPU_TOPO_LEVEL_DIE,
     },
 };
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 62230b6f7701..5a0b5ba72433 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1522,6 +1522,15 @@ enum CacheType {
     UNIFIED_CACHE
 };
 
+enum CPUTopoLevel {
+    CPU_TOPO_LEVEL_UNKNOW = 0,
+    CPU_TOPO_LEVEL_SMT,
+    CPU_TOPO_LEVEL_CORE,
+    CPU_TOPO_LEVEL_MODULE,
+    CPU_TOPO_LEVEL_DIE,
+    CPU_TOPO_LEVEL_PACKAGE,
+};
+
 typedef struct CPUCacheInfo {
     enum CacheType type;
     uint8_t level;
@@ -1563,6 +1572,13 @@ typedef struct CPUCacheInfo {
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


