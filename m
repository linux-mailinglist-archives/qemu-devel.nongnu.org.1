Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 896EA79FCFE
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 09:14:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qggWk-0003nW-LM; Thu, 14 Sep 2023 03:12:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qggWJ-00039K-Kw
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:12:13 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qggWH-0006Be-V7
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 03:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694675529; x=1726211529;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VHbGIt3anlfDCyYmhipHPo0Zz8e3gGNVqa2VaagmomU=;
 b=AXd4n+MWPcoVenP4UdK7mDYE0MqFQziVuDasiASURA5YGOkJY4xiv3Dk
 jRzJDrT9geQyurYWcgJ/gKb0/VXTGLTz1+fcofUvLkf5ey+myotAb3o12
 xAzXZnVaTK3mHlK4cFL2scOeluG+DGi3PxajspcYwIShE3kRn434Y8uSB
 PyBTr9+qtMKZjcHL+0u9IcQnilOwLLfBQi4cNRk4bZKsutndbYP/BawG3
 myma0K9OBRpGtJnXSDDmuNDXmuJSopOWpbZUYlMZCLuR8bh/mISTqrpz2
 BLuamprEoDrEUsGqvBfTXn9uMJLLSiDy7wtjcXrbkNWKO5sIETasZ1hQg A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="359136364"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; d="scan'208";a="359136364"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2023 00:12:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="779526648"
X-IronPort-AV: E=Sophos;i="6.02,145,1688454000"; d="scan'208";a="779526648"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga001.jf.intel.com with ESMTP; 14 Sep 2023 00:12:01 -0700
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
 Babu Moger <babu.moger@amd.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>
Subject: [PATCH v4 12/21] i386: Expose module level in CPUID[0x1F]
Date: Thu, 14 Sep 2023 15:21:50 +0800
Message-Id: <20230914072159.1177582-13-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914072159.1177582-1-zhao1.liu@linux.intel.com>
References: <20230914072159.1177582-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.55.52.151;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Linux kernel (from v6.4, with commit edc0a2b595765 ("x86/topology: Fix
erroneous smp_num_siblings on Intel Hybrid platforms") is able to
handle platforms with Module level enumerated via CPUID.1F.

Expose the module level in CPUID[0x1F] if the machine has more than 1
modules.

(Tested CPU topology in CPUID[0x1F] leaf with various die/cluster
configurations in "-smp".)

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
---
Changes since v3:
 * New patch to expose module level in 0x1F.
 * Add Tested-by tag from Yongwei.
---
 target/i386/cpu.c     | 12 +++++++++++-
 target/i386/cpu.h     |  2 ++
 target/i386/kvm/kvm.c |  2 +-
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index cef9a4606d89..f0ddb253b6b5 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -276,6 +276,8 @@ static uint32_t num_cpus_by_topo_level(X86CPUTopoInfo *topo_info,
         return 1;
     case CPU_TOPO_LEVEL_CORE:
         return topo_info->threads_per_core;
+    case CPU_TOPO_LEVEL_MODULE:
+        return topo_info->threads_per_core * topo_info->cores_per_module;
     case CPU_TOPO_LEVEL_DIE:
         return topo_info->threads_per_core * topo_info->cores_per_module *
                topo_info->modules_per_die;
@@ -296,6 +298,8 @@ static uint32_t apicid_offset_by_topo_level(X86CPUTopoInfo *topo_info,
         return 0;
     case CPU_TOPO_LEVEL_CORE:
         return apicid_core_offset(topo_info);
+    case CPU_TOPO_LEVEL_MODULE:
+        return apicid_module_offset(topo_info);
     case CPU_TOPO_LEVEL_DIE:
         return apicid_die_offset(topo_info);
     case CPU_TOPO_LEVEL_PACKAGE:
@@ -315,6 +319,8 @@ static uint32_t cpuid1f_topo_type(enum CPUTopoLevel topo_level)
         return CPUID_1F_ECX_TOPO_LEVEL_SMT;
     case CPU_TOPO_LEVEL_CORE:
         return CPUID_1F_ECX_TOPO_LEVEL_CORE;
+    case CPU_TOPO_LEVEL_MODULE:
+        return CPUID_1F_ECX_TOPO_LEVEL_MODULE;
     case CPU_TOPO_LEVEL_DIE:
         return CPUID_1F_ECX_TOPO_LEVEL_DIE;
     default:
@@ -346,6 +352,10 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
         if (env->nr_dies > 1) {
             set_bit(CPU_TOPO_LEVEL_DIE, topo_bitmap);
         }
+
+        if (env->nr_modules > 1) {
+            set_bit(CPU_TOPO_LEVEL_MODULE, topo_bitmap);
+        }
     }
 
     *ecx = count & 0xff;
@@ -6390,7 +6400,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x1F:
         /* V2 Extended Topology Enumeration Leaf */
-        if (topo_info.dies_per_pkg < 2) {
+        if (topo_info.modules_per_die < 2 && topo_info.dies_per_pkg < 2) {
             *eax = *ebx = *ecx = *edx = 0;
             break;
         }
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 556e80f29764..54019e82fdb4 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1018,6 +1018,7 @@ enum CPUTopoLevel {
     CPU_TOPO_LEVEL_INVALID,
     CPU_TOPO_LEVEL_SMT,
     CPU_TOPO_LEVEL_CORE,
+    CPU_TOPO_LEVEL_MODULE,
     CPU_TOPO_LEVEL_DIE,
     CPU_TOPO_LEVEL_PACKAGE,
     CPU_TOPO_LEVEL_MAX,
@@ -1032,6 +1033,7 @@ enum CPUTopoLevel {
 #define CPUID_1F_ECX_TOPO_LEVEL_INVALID  CPUID_B_ECX_TOPO_LEVEL_INVALID
 #define CPUID_1F_ECX_TOPO_LEVEL_SMT      CPUID_B_ECX_TOPO_LEVEL_SMT
 #define CPUID_1F_ECX_TOPO_LEVEL_CORE     CPUID_B_ECX_TOPO_LEVEL_CORE
+#define CPUID_1F_ECX_TOPO_LEVEL_MODULE   3
 #define CPUID_1F_ECX_TOPO_LEVEL_DIE      5
 
 /* MSR Feature Bits */
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e5cd7cc80616..545b2d46221e 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1959,7 +1959,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
             break;
         }
         case 0x1f:
-            if (env->nr_dies < 2) {
+            if (env->nr_modules < 2 && env->nr_dies < 2) {
                 break;
             }
             /* fallthrough */
-- 
2.34.1


