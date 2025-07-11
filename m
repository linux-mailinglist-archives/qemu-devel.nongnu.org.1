Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9003B01928
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Jul 2025 12:02:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaAZC-0002i6-QX; Fri, 11 Jul 2025 06:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAYi-0001vl-42
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:00:53 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uaAYd-0005H0-7B
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 06:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752228043; x=1783764043;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yG3qiMYa7f3Vg06cEK8SdJIMxpzMK6proPRZfmYy1os=;
 b=SRFoQj9LJogmfP1Z6um4/R/x5bFgrXcE91FLoXFR/RKHkzZbCp7e92p0
 27pbnWzt3Sfp4XXrhTvIQwkAWB3XkNtuhfVOQLMZBcYohP9qF5MEeA1J5
 /tXfuzeofXPFsQe01BjTOlgHI+Ti8sfgVvGOsSr41Oo/BYLlHVM0TGwMG
 HdlHPigZS30jGsgPj4as5woXv1gVIbX9HZ6VX8GP/C8zI910NKCVnVlHj
 9qkB5ma64BPASnk8MLzkbzqEXY7JTDgvZtgC11aFdCe5IT9zjQJC1wrN/
 6nRWH7aOkTeH4jNKGfXRzSEh1+VXBs1fu6FZmlzdWqVRvF6fTk2n3ukND w==;
X-CSE-ConnectionGUID: 8R38wFDeR+CRgDQFCanSuA==
X-CSE-MsgGUID: eu+XRhjeRi+lRgyMvbVmrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54496252"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="54496252"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jul 2025 03:00:40 -0700
X-CSE-ConnectionGUID: RFZxQlyATGagBmo5IyZX9A==
X-CSE-MsgGUID: 54hzDnYpRJqJEGjMYteDSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; d="scan'208";a="160662043"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 11 Jul 2025 03:00:35 -0700
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
 qemu-devel@nongnu.org, kvm@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>,
 Alexander Graf <agraf@csgraf.de>
Subject: [PATCH v2 04/18] i386/cpu: Present same cache model in CPUID 0x2 & 0x4
Date: Fri, 11 Jul 2025 18:21:29 +0800
Message-Id: <20250711102143.1622339-5-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711102143.1622339-1-zhao1.liu@intel.com>
References: <20250711102143.1622339-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

For a long time, the default cache models used in CPUID 0x2 and
0x4 were inconsistent and had a FIXME note from Eduardo at commit
5e891bf8fd50 ("target-i386: Use #defines instead of magic numbers for
CPUID cache info"):

"/*FIXME: CPUID leaf 2 descriptor is inconsistent with CPUID leaf 4 */".

This difference is wrong, in principle, both 0x2 and 0x4 are used for
Intel's cache description. 0x2 leaf is used for ancient machines while
0x4 leaf is a subsequent addition, and both should be based on the same
cache model. Furthermore, on real hardware, 0x4 leaf should be used in
preference to 0x2 when it is available.

Revisiting the git history, that difference occurred much earlier.

Current legacy_l2_cache_cpuid2 (hardcode: "0x2c307d"), which is used for
CPUID 0x2 leaf, is introduced in commit d8134d91d9b7 ("Intel cache info,
by Filip Navara."). Its commit message didn't said anything, but its
patch [1] mentioned the cache model chosen is "closest to the ones
reported in the AMD registers". Now it is not possible to check which
AMD generation this cache model is based on (unfortunately, AMD does not
use 0x2 leaf), but at least it is close to the Pentium 4.

In fact, the patch description of commit d8134d91d9b7 is also a bit
wrong, the original cache model in leaf 2 is from Pentium Pro, and its
cache descriptor had specified the cache line size ad 32 byte by default,
while the updated cache model in commit d8134d91d9b7 has 64 byte line
size. But after so many years, such judgments are no longer meaningful.

On the other hand, for legacy_l2_cache, which is used in CPUID 0x4 leaf,
is based on Intel Core Duo (patch [2]) and Core2 Duo (commit e737b32a3688
("Core 2 Duo specification (Alexander Graf).")

The patches of Core Duo and Core 2 Duo add the cache model for CPUID
0x4, but did not update CPUID 0x2 encoding. This is the reason that
Intel Guests use two cache models in 0x2 and 0x4 all the time.

Of course, while no Core Duo or Core 2 Duo machines have been found for
double checking, this still makes no sense to encode different cache
models on a single machine.

Referring to the SDM and the real hardware available, 0x2 leaf can be
directly encoded 0xFF to instruct software to go to 0x4 leaf to get the
cache information, when 0x4 is available.

Therefore, it's time to clean up Intel's default cache models. As the
first step, add "x-consistent-cache" compat option to allow newer
machines (v10.1 and newer) to have the consistent cache model in CPUID
0x2 and 0x4 leaves.

This doesn't affect the CPU models with CPUID level < 4 ("486",
"pentium", "pentium2" and "pentium3"), because they have already had the
special default cache model - legacy_intel_cpuid2_cache_info.

[1]: https://lore.kernel.org/qemu-devel/5b31733c0709081227w3e5f1036odbc649edfdc8c79b@mail.gmail.com/
[2]: https://lore.kernel.org/qemu-devel/478B65C8.2080602@csgraf.de/

Cc: Alexander Graf <agraf@csgraf.de>
Tested-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/i386/pc.c      | 4 +++-
 target/i386/cpu.c | 7 ++++++-
 target/i386/cpu.h | 7 +++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b2116335752d..ad2d6495ebde 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -81,7 +81,9 @@
     { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
     { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
 
-GlobalProperty pc_compat_10_0[] = {};
+GlobalProperty pc_compat_10_0[] = {
+    { TYPE_X86_CPU, "x-consistent-cache", "false" },
+};
 const size_t pc_compat_10_0_len = G_N_ELEMENTS(pc_compat_10_0);
 
 GlobalProperty pc_compat_9_2[] = {};
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index f85e087bf7df..70ac969a9cdc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8935,7 +8935,11 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         /* Build legacy cache information */
         env->cache_info_cpuid2.l1d_cache = &legacy_l1d_cache;
         env->cache_info_cpuid2.l1i_cache = &legacy_l1i_cache;
-        env->cache_info_cpuid2.l2_cache = &legacy_l2_cache_cpuid2;
+        if (!cpu->consistent_cache) {
+            env->cache_info_cpuid2.l2_cache = &legacy_l2_cache_cpuid2;
+        } else {
+            env->cache_info_cpuid2.l2_cache = &legacy_l2_cache;
+        }
         env->cache_info_cpuid2.l3_cache = &legacy_l3_cache;
 
         env->cache_info_cpuid4.l1d_cache = &legacy_l1d_cache;
@@ -9461,6 +9465,7 @@ static const Property x86_cpu_properties[] = {
      * own cache information (see x86_cpu_load_def()).
      */
     DEFINE_PROP_BOOL("legacy-cache", X86CPU, legacy_cache, true),
+    DEFINE_PROP_BOOL("x-consistent-cache", X86CPU, consistent_cache, true),
     DEFINE_PROP_BOOL("legacy-multi-node", X86CPU, legacy_multi_node, false),
     DEFINE_PROP_BOOL("xen-vapic", X86CPU, xen_vapic, false),
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 51e10139dfdf..d7c9a1f91446 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2259,6 +2259,13 @@ struct ArchCPU {
      */
     bool legacy_cache;
 
+    /*
+     * Compatibility bits for old machine types.
+     * If true, use the same cache model in CPUID leaf 0x2
+     * and 0x4.
+     */
+    bool consistent_cache;
+
     /* Compatibility bits for old machine types.
      * If true decode the CPUID Function 0x8000001E_ECX to support multiple
      * nodes per processor
-- 
2.34.1


