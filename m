Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACDB76B1E4
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 12:33:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQmgL-00082o-PA; Tue, 01 Aug 2023 06:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qQmgK-00082c-Ip
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 06:32:48 -0400
Received: from [192.55.52.88] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1qQmgI-00032F-Jj
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 06:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690885966; x=1722421966;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YApcGJwkYKHkGu2hAQNgVYDWtTOGF2sXCux6R+BZPc8=;
 b=mOEh/zYdh5Vdlu6XA2F5W1LrPp5DWXUgB0ROSqTEztMgWJF4LU7db+Dl
 ueKREga0HKUCwV9/ZQt1hVkg+c+qb66+uGH369/9VwTxkPNttisw3h82C
 arK2ANOPzKXHMA8wplz+QK13iEDslZDxfRUT/eXhR/w5zZqmIrP0TzBO+
 uj52mZ9jS44b6XLNaqUkC+nlO9FT1MjpGWVS3w7+XVMmeqlerIVySAX8l
 bw1tzQfYo6l/k4aaIQ9pKcIsLth2L5TFqhNnaQ3NBQAO9gguQ89XG4O2D
 B8DrG/bspDjbTSPbaONphrH+jAW+uKoiITv5QQ3P/ATTaBdHty/L7rBPk Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="400211021"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; d="scan'208";a="400211021"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Aug 2023 03:25:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="731932011"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; d="scan'208";a="731932011"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.28])
 by fmsmga007.fm.intel.com with ESMTP; 01 Aug 2023 03:25:11 -0700
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
 Zhao Liu <zhao1.liu@intel.com>, Zhuocheng Ding <zhuocheng.ding@intel.com>
Subject: [PATCH v3 03/17] softmmu: Fix CPUSTATE.nr_cores' calculation
Date: Tue,  1 Aug 2023 18:35:13 +0800
Message-Id: <20230801103527.397756-4-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
References: <20230801103527.397756-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 192.55.52.88 (failed)
Received-SPF: none client-ip=192.55.52.88;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, RDNS_NONE=0.793,
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

From: Zhuocheng Ding <zhuocheng.ding@intel.com>

From CPUState.nr_cores' comment, it represents "number of cores within
this CPU package".

After 003f230e37d7 ("machine: Tweak the order of topology members in
struct CpuTopology"), the meaning of smp.cores changed to "the number of
cores in one die", but this commit missed to change CPUState.nr_cores'
caculation, so that CPUState.nr_cores became wrong and now it
misses to consider numbers of clusters and dies.

At present, only i386 is using CPUState.nr_cores.

But as for i386, which supports die level, the uses of CPUState.nr_cores
are very confusing:

Early uses are based on the meaning of "cores per package" (before die
is introduced into i386), and later uses are based on "cores per die"
(after die's introduction).

This difference is due to that commit a94e1428991f ("target/i386: Add
CPUID.1F generation support for multi-dies PCMachine") misunderstood
that CPUState.nr_cores means "cores per die" when caculated
CPUID.1FH.01H:EBX. After that, the changes in i386 all followed this
wrong understanding.

With the influence of 003f230e37d7 and a94e1428991f, for i386 currently
the result of CPUState.nr_cores is "cores per die", thus the original
uses of CPUState.cores based on the meaning of "cores per package" are
wrong when mutiple dies exist:
1. In cpu_x86_cpuid() of target/i386/cpu.c, CPUID.01H:EBX[bits 23:16] is
   incorrect because it expects "cpus per package" but now the
   result is "cpus per die".
2. In cpu_x86_cpuid() of target/i386/cpu.c, for all leaves of CPUID.04H:
   EAX[bits 31:26] is incorrect because they expect "cpus per package"
   but now the result is "cpus per die". The error not only impacts the
   EAX caculation in cache_info_passthrough case, but also impacts other
   cases of setting cache topology for Intel CPU according to cpu
   topology (specifically, the incoming parameter "num_cores" expects
   "cores per package" in encode_cache_cpuid4()).
3. In cpu_x86_cpuid() of target/i386/cpu.c, CPUID.0BH.01H:EBX[bits
   15:00] is incorrect because the EBX of 0BH.01H (core level) expects
   "cpus per package", which may be different with 1FH.01H (The reason
   is 1FH can support more levels. For QEMU, 1FH also supports die,
   1FH.01H:EBX[bits 15:00] expects "cpus per die").
4. In cpu_x86_cpuid() of target/i386/cpu.c, when CPUID.80000001H is
   caculated, here "cpus per package" is expected to be checked, but in
   fact, now it checks "cpus per die". Though "cpus per die" also works
   for this code logic, this isn't consistent with AMD's APM.
5. In cpu_x86_cpuid() of target/i386/cpu.c, CPUID.80000008H:ECX expects
   "cpus per package" but it obtains "cpus per die".
6. In simulate_rdmsr() of target/i386/hvf/x86_emu.c, in
   kvm_rdmsr_core_thread_count() of target/i386/kvm/kvm.c, and in
   helper_rdmsr() of target/i386/tcg/sysemu/misc_helper.c,
   MSR_CORE_THREAD_COUNT expects "cpus per package" and "cores per
   package", but in these functions, it obtains "cpus per die" and
   "cores per die".

On the other hand, these uses are correct now (they are added in/after
a94e1428991f):
1. In cpu_x86_cpuid() of target/i386/cpu.c, topo_info.cores_per_die
   meets the actual meaning of CPUState.nr_cores ("cores per die").
2. In cpu_x86_cpuid() of target/i386/cpu.c, vcpus_per_socket (in CPUID.
   04H's caculation) considers number of dies, so it's correct.
3. In cpu_x86_cpuid() of target/i386/cpu.c, CPUID.1FH.01H:EBX[bits
   15:00] needs "cpus per die" and it gets the correct result, and
   CPUID.1FH.02H:EBX[bits 15:00] gets correct "cpus per package".

When CPUState.nr_cores is correctly changed to "cores per package" again
, the above errors will be fixed without extra work, but the "currently"
correct cases will go wrong and need special handling to pass correct
"cpus/cores per die" they want.

Thus in this patch, we fix CPUState.nr_cores' caculation to fit the
original meaning "cores per package", as well as changing calculation of
topo_info.cores_per_die, vcpus_per_socket and CPUID.1FH.

In addition, in the nr_threads' comment, specify it represents the
number of threads in the "core" to avoid confusion, and also add comment
for nr_dies in CPUX86State.

Fixes: a94e1428991f ("target/i386: Add CPUID.1F generation support for multi-dies PCMachine")
Fixes: 003f230e37d7 ("machine: Tweak the order of topology members in struct CpuTopology")
Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes since v2:
 * Use wrapped helper to get cores per socket in qemu_init_vcpu().
Changes since v1:
 * Add comment for nr_dies in CPUX86State. (Yanan)
---
 include/hw/core/cpu.h | 2 +-
 softmmu/cpus.c        | 2 +-
 target/i386/cpu.c     | 9 ++++-----
 target/i386/cpu.h     | 1 +
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index fdcbe8735258..57f4d50ace72 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -277,7 +277,7 @@ struct qemu_work_item;
  *   See TranslationBlock::TCG CF_CLUSTER_MASK.
  * @tcg_cflags: Pre-computed cflags for this cpu.
  * @nr_cores: Number of cores within this CPU package.
- * @nr_threads: Number of threads within this CPU.
+ * @nr_threads: Number of threads within this CPU core.
  * @running: #true if CPU is currently running (lockless).
  * @has_waiter: #true if a CPU is currently waiting for the cpu_exec_end;
  * valid under cpu_list_lock.
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index fed20ffb5dd2..984558d7b245 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -630,7 +630,7 @@ void qemu_init_vcpu(CPUState *cpu)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
 
-    cpu->nr_cores = ms->smp.cores;
+    cpu->nr_cores = machine_topo_get_cores_per_socket(ms);
     cpu->nr_threads =  ms->smp.threads;
     cpu->stopped = true;
     cpu->random_seed = qemu_guest_random_seed_thread_part1();
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 97ad229d8ba3..50613cd04612 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6011,7 +6011,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     X86CPUTopoInfo topo_info;
 
     topo_info.dies_per_pkg = env->nr_dies;
-    topo_info.cores_per_die = cs->nr_cores;
+    topo_info.cores_per_die = cs->nr_cores / env->nr_dies;
     topo_info.threads_per_core = cs->nr_threads;
 
     /* Calculate & apply limits for different index ranges */
@@ -6087,8 +6087,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              */
             if (*eax & 31) {
                 int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
-                int vcpus_per_socket = env->nr_dies * cs->nr_cores *
-                                       cs->nr_threads;
+                int vcpus_per_socket = cs->nr_cores * cs->nr_threads;
                 if (cs->nr_cores > 1) {
                     *eax &= ~0xFC000000;
                     *eax |= (pow2ceil(cs->nr_cores) - 1) << 26;
@@ -6266,12 +6265,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             break;
         case 1:
             *eax = apicid_die_offset(&topo_info);
-            *ebx = cs->nr_cores * cs->nr_threads;
+            *ebx = topo_info.cores_per_die * topo_info.threads_per_core;
             *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
             break;
         case 2:
             *eax = apicid_pkg_offset(&topo_info);
-            *ebx = env->nr_dies * cs->nr_cores * cs->nr_threads;
+            *ebx = cs->nr_cores * cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_DIE;
             break;
         default:
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e0771a10433b..7638128d59cc 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1878,6 +1878,7 @@ typedef struct CPUArchState {
 
     TPRAccess tpr_access_type;
 
+    /* Number of dies within this CPU package. */
     unsigned nr_dies;
 } CPUX86State;
 
-- 
2.34.1


