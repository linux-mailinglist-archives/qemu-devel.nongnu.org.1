Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF937EECE0
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 08:42:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3tSn-0005N1-89; Fri, 17 Nov 2023 02:40:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1r3tSd-00058P-Bl
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 02:40:19 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1r3tSS-00083O-FB
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 02:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700206808; x=1731742808;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GWFIZo16oEJW0awCi3OCH6jG2uNvE3DyTLUXRZBtF4U=;
 b=IIZJETnghQBX3oNEdfneb+6/as2KKORmUk08RSNKmp9tISsdF9fmpKbP
 CUOfY9MgMX4VT8t+SL1xxo6LxTZ/fPn35ttH6XtPP6xCaGNQMD1rl9Mlr
 FS8HYq1W1x6YJqGOSOrnapZSqYyRTsIizkG1lroT7WmwCuqtSkUfCA3NT
 j4A6nQyhvh8rc8sK1oAPZQLcDjnq61XxAJnqr+B2upjxbW9HtzUuxBKfV
 hk2+iFM16Mv2ppk0yjg9YzRfcmYHII9z8Ns6zhDIuky0EDlA1DM20BPgE
 vyhUo/nBeBW1vD/kNejMlwFmX8du8ZYGK7K3bOhPdtvO3Li+8DChtMVZL g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="395180357"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; d="scan'208";a="395180357"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Nov 2023 23:39:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="883042750"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; d="scan'208";a="883042750"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmsmga002.fm.intel.com with ESMTP; 16 Nov 2023 23:39:50 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Babu Moger <babu.moger@amd.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v6 08/16] i386: Expose module level in CPUID[0x1F]
Date: Fri, 17 Nov 2023 15:50:58 +0800
Message-Id: <20231117075106.432499-9-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117075106.432499-1-zhao1.liu@linux.intel.com>
References: <20231117075106.432499-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=134.134.136.65;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Linux kernel (from v6.4, with commit edc0a2b595765 ("x86/topology: Fix
erroneous smp_num_siblings on Intel Hybrid platforms") is able to
handle platforms with Module level enumerated via CPUID.1F.

Expose the module level in CPUID[0x1F] if the machine has more than 1
modules.

(Tested CPU topology in CPUID[0x1F] leaf with various die/cluster
configurations in "-smp".)

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
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
index b4055e4dd62e..0fcdd6f5f349 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -277,6 +277,8 @@ static uint32_t num_cpus_by_topo_level(X86CPUTopoInfo *topo_info,
         return 1;
     case CPU_TOPO_LEVEL_CORE:
         return topo_info->threads_per_core;
+    case CPU_TOPO_LEVEL_MODULE:
+        return topo_info->threads_per_core * topo_info->cores_per_module;
     case CPU_TOPO_LEVEL_DIE:
         return topo_info->threads_per_core * topo_info->cores_per_module *
                topo_info->modules_per_die;
@@ -297,6 +299,8 @@ static uint32_t apicid_offset_by_topo_level(X86CPUTopoInfo *topo_info,
         return 0;
     case CPU_TOPO_LEVEL_CORE:
         return apicid_core_offset(topo_info);
+    case CPU_TOPO_LEVEL_MODULE:
+        return apicid_module_offset(topo_info);
     case CPU_TOPO_LEVEL_DIE:
         return apicid_die_offset(topo_info);
     case CPU_TOPO_LEVEL_PACKAGE:
@@ -316,6 +320,8 @@ static uint32_t cpuid1f_topo_type(enum CPUTopoLevel topo_level)
         return CPUID_1F_ECX_TOPO_LEVEL_SMT;
     case CPU_TOPO_LEVEL_CORE:
         return CPUID_1F_ECX_TOPO_LEVEL_CORE;
+    case CPU_TOPO_LEVEL_MODULE:
+        return CPUID_1F_ECX_TOPO_LEVEL_MODULE;
     case CPU_TOPO_LEVEL_DIE:
         return CPUID_1F_ECX_TOPO_LEVEL_DIE;
     default:
@@ -347,6 +353,10 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
         if (env->nr_dies > 1) {
             set_bit(CPU_TOPO_LEVEL_DIE, topo_bitmap);
         }
+
+        if (env->nr_modules > 1) {
+            set_bit(CPU_TOPO_LEVEL_MODULE, topo_bitmap);
+        }
     }
 
     *ecx = count & 0xff;
@@ -6393,7 +6403,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x1F:
         /* V2 Extended Topology Enumeration Leaf */
-        if (topo_info.dies_per_pkg < 2) {
+        if (topo_info.modules_per_die < 2 && topo_info.dies_per_pkg < 2) {
             *eax = *ebx = *ecx = *edx = 0;
             break;
         }
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index da58d41c9969..95cbbb1de906 100644
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
index 11b8177eff21..b6d297aff730 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1913,7 +1913,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
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


