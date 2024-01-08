Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 242EE826930
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 09:15:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMkmf-0000cw-5T; Mon, 08 Jan 2024 03:14:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rMkmc-0000WJ-IZ
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 03:14:54 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rMkma-0007pk-ND
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 03:14:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704701693; x=1736237693;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pNzhHK79i2KZqGhGkmIfzT6Zu2ywGd7JncYaLYLok0k=;
 b=k3baxUzUOzhR0NTbAxBvxtYYmZ3r/x7KDcCN748fWJ3813NQQWx3YUvO
 km3dLdc5RwlVDKy3bIl+eXka7AqDuGoTOZh/1M1iFbeeLN2GgqZoJYfwt
 VEUSSe7BK117TPh49Ap9/C1WbbWolxRLFNU2DZP48baDuE5xMdUaRAoId
 ROgDrUcMUWfElXAIdKJYQ1gCw0X1fonJFeXFlBNoYkj5/d+Yk91Fs7KKW
 DsiBsRN6aJS+87DZOLcv9oHa/aLWTBs43aTkiSw6vIKTCOnfuXuMrO68w
 2Y2k4UDMKyHQJeMUJn8lMXJ5u5WYIJAxrYq2zHMys5dzt/YqQxQ6Wg78g Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="16419951"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; d="scan'208";a="16419951"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2024 00:14:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; d="scan'208";a="15850172"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 08 Jan 2024 00:14:48 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>
Subject: [PATCH v7 04/16] i386: Split topology types of CPUID[0x1F] from the
 definitions of CPUID[0xB]
Date: Mon,  8 Jan 2024 16:27:15 +0800
Message-Id: <20240108082727.420817-5-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
References: <20240108082727.420817-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.9;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.098,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

CPUID[0xB] defines SMT, Core and Invalid types, and this leaf is shared
by Intel and AMD CPUs.

But for extended topology levels, Intel CPU (in CPUID[0x1F]) and AMD CPU
(in CPUID[0x80000026]) have the different definitions with different
enumeration values.

Though CPUID[0x80000026] hasn't been implemented in QEMU, to avoid
possible misunderstanding, split topology types of CPUID[0x1F] from the
definitions of CPUID[0xB] and introduce CPUID[0x1F]-specific topology
types.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
Changes since v3:
 * New commit to prepare to refactor CPUID[0x1F] encoding.
---
 target/i386/cpu.c | 14 +++++++-------
 target/i386/cpu.h | 13 +++++++++----
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6f8fa772ecf8..bc440477d13d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6255,17 +6255,17 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         case 0:
             *eax = apicid_core_offset(&topo_info);
             *ebx = topo_info.threads_per_core;
-            *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
+            *ecx |= CPUID_B_ECX_TOPO_LEVEL_SMT << 8;
             break;
         case 1:
             *eax = apicid_pkg_offset(&topo_info);
             *ebx = cpus_per_pkg;
-            *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
+            *ecx |= CPUID_B_ECX_TOPO_LEVEL_CORE << 8;
             break;
         default:
             *eax = 0;
             *ebx = 0;
-            *ecx |= CPUID_TOPOLOGY_LEVEL_INVALID;
+            *ecx |= CPUID_B_ECX_TOPO_LEVEL_INVALID << 8;
         }
 
         assert(!(*eax & ~0x1f));
@@ -6290,22 +6290,22 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         case 0:
             *eax = apicid_core_offset(&topo_info);
             *ebx = topo_info.threads_per_core;
-            *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
+            *ecx |= CPUID_1F_ECX_TOPO_LEVEL_SMT << 8;
             break;
         case 1:
             *eax = apicid_die_offset(&topo_info);
             *ebx = topo_info.cores_per_die * topo_info.threads_per_core;
-            *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
+            *ecx |= CPUID_1F_ECX_TOPO_LEVEL_CORE << 8;
             break;
         case 2:
             *eax = apicid_pkg_offset(&topo_info);
             *ebx = cpus_per_pkg;
-            *ecx |= CPUID_TOPOLOGY_LEVEL_DIE;
+            *ecx |= CPUID_1F_ECX_TOPO_LEVEL_DIE << 8;
             break;
         default:
             *eax = 0;
             *ebx = 0;
-            *ecx |= CPUID_TOPOLOGY_LEVEL_INVALID;
+            *ecx |= CPUID_1F_ECX_TOPO_LEVEL_INVALID << 8;
         }
         assert(!(*eax & ~0x1f));
         *ebx &= 0xffff; /* The count doesn't need to be reliable. */
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index ef987f344cff..f47bad46db5e 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1009,10 +1009,15 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define CPUID_MWAIT_EMX     (1U << 0) /* enumeration supported */
 
 /* CPUID[0xB].ECX level types */
-#define CPUID_TOPOLOGY_LEVEL_INVALID  (0U << 8)
-#define CPUID_TOPOLOGY_LEVEL_SMT      (1U << 8)
-#define CPUID_TOPOLOGY_LEVEL_CORE     (2U << 8)
-#define CPUID_TOPOLOGY_LEVEL_DIE      (5U << 8)
+#define CPUID_B_ECX_TOPO_LEVEL_INVALID  0
+#define CPUID_B_ECX_TOPO_LEVEL_SMT      1
+#define CPUID_B_ECX_TOPO_LEVEL_CORE     2
+
+/* COUID[0x1F].ECX level types */
+#define CPUID_1F_ECX_TOPO_LEVEL_INVALID  CPUID_B_ECX_TOPO_LEVEL_INVALID
+#define CPUID_1F_ECX_TOPO_LEVEL_SMT      CPUID_B_ECX_TOPO_LEVEL_SMT
+#define CPUID_1F_ECX_TOPO_LEVEL_CORE     CPUID_B_ECX_TOPO_LEVEL_CORE
+#define CPUID_1F_ECX_TOPO_LEVEL_DIE      5
 
 /* MSR Feature Bits */
 #define MSR_ARCH_CAP_RDCL_NO            (1U << 0)
-- 
2.34.1


