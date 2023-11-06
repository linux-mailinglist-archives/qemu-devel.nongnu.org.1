Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD1D7E1FC4
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:17:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxTX-0007Oq-L9; Mon, 06 Nov 2023 06:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxTR-00072m-OK
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:08:53 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxTM-0005FO-M0
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:08:53 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32f7abbb8b4so2789749f8f.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699268927; x=1699873727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0yFelocR66jYXowauowrhR0mUeB3U99cidSOqtYw+Cg=;
 b=VMAjPMAS6edt0sctsVploARAsqA0Ru+q2aYkZUJg8afRfE8EWtEuWrDGq26/dzGwFz
 VDUiJtUOoXnBUWlSvPQ87n7RBWM6JiyvZYicIeFVDzkxeC02d+KM6nbmAImbDcPtxW15
 C915m5/KkYkYOyKMnM9k0wrwz9e21qKQ2lUZdIXf56+hS4SUXb8dxatM6ba6ts3HIWbt
 s6Hul5Eg6veHwB0X1UqX3e99NPRxh8W45tTMJS33yp+3NhqUmpe/oY/95Dywhk/FLUct
 Ci/HqLNYfghAa2H3IE8JlfqTGBfesvG++hT/bmF4YyieHKfi0/Jyq5r6/666FbHjxucx
 lAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268927; x=1699873727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0yFelocR66jYXowauowrhR0mUeB3U99cidSOqtYw+Cg=;
 b=ri20xWejzXsPNqkK2QgV6jGmGB+I0J8Gl79z1wOwGXuMkflLixzQqvEMAzl64rmofG
 H9alNNedBuupSA6zdFqMl/mMTkf8jOjBrvKF/KKwfiuJKfZxFHgvs+0CYmO48XwJ2jY+
 iQHsDPc+PsatV71oFO8miT4f2lnM2vRSodS0ir5xAIb6R0Lpbxpu23PDl9FurnAPOabk
 J504SzBnkHDP3fFCPJbEoSoh+ArqXoWkuDjN4LpTu3N7pC24W60YF0wqxFi1/GR9TL3K
 EJ2Sl4EKlo9eXoSn1a3xpzKxw0T8mWTTk8D45dUgx2bDzWp5FsiW3XFxu1cOmFsVCuJz
 JCwA==
X-Gm-Message-State: AOJu0YzfYa0h4Cm5qrF+H1Rtnj4LVXf0fza004o8Uv+oUOnYlu/QxZXB
 udSxQR/7acAsPOZiwoQLHGtlzfXW3FESNKN59kk=
X-Google-Smtp-Source: AGHT+IGgL0F1g9v6gQaqWqalE046qIpD1vXiY6eu81D5A7cfp1tnEC2cOxrnm8DtADlNcX3GEcp3bw==
X-Received: by 2002:a5d:6c6f:0:b0:32f:8085:7411 with SMTP id
 r15-20020a5d6c6f000000b0032f80857411mr21345810wrz.24.1699268927044; 
 Mon, 06 Nov 2023 03:08:47 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 g8-20020a5d4888000000b0032f7cc56509sm1544640wrq.98.2023.11.06.03.08.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:08:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 45/60] system/cpus: Fix CPUState.nr_cores' calculation
Date: Mon,  6 Nov 2023 12:03:17 +0100
Message-ID: <20231106110336.358-46-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
calculation, so that CPUState.nr_cores became wrong and now it
misses to consider numbers of clusters and dies.

At present, only i386 is using CPUState.nr_cores.

But as for i386, which supports die level, the uses of CPUState.nr_cores
are very confusing:

Early uses are based on the meaning of "cores per package" (before die
is introduced into i386), and later uses are based on "cores per die"
(after die's introduction).

This difference is due to that commit a94e1428991f ("target/i386: Add
CPUID.1F generation support for multi-dies PCMachine") misunderstood
that CPUState.nr_cores means "cores per die" when calculated
CPUID.1FH.01H:EBX. After that, the changes in i386 all followed this
wrong understanding.

With the influence of 003f230e37d7 and a94e1428991f, for i386 currently
the result of CPUState.nr_cores is "cores per die", thus the original
uses of CPUState.cores based on the meaning of "cores per package" are
wrong when multiple dies exist:
1. In cpu_x86_cpuid() of target/i386/cpu.c, CPUID.01H:EBX[bits 23:16] is
   incorrect because it expects "cpus per package" but now the
   result is "cpus per die".
2. In cpu_x86_cpuid() of target/i386/cpu.c, for all leaves of CPUID.04H:
   EAX[bits 31:26] is incorrect because they expect "cpus per package"
   but now the result is "cpus per die". The error not only impacts the
   EAX calculation in cache_info_passthrough case, but also impacts other
   cases of setting cache topology for Intel CPU according to cpu
   topology (specifically, the incoming parameter "num_cores" expects
   "cores per package" in encode_cache_cpuid4()).
3. In cpu_x86_cpuid() of target/i386/cpu.c, CPUID.0BH.01H:EBX[bits
   15:00] is incorrect because the EBX of 0BH.01H (core level) expects
   "cpus per package", which may be different with 1FH.01H (The reason
   is 1FH can support more levels. For QEMU, 1FH also supports die,
   1FH.01H:EBX[bits 15:00] expects "cpus per die").
4. In cpu_x86_cpuid() of target/i386/cpu.c, when CPUID.80000001H is
   calculated, here "cpus per package" is expected to be checked, but in
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
   04H's calculation) considers number of dies, so it's correct.
3. In cpu_x86_cpuid() of target/i386/cpu.c, CPUID.1FH.01H:EBX[bits
   15:00] needs "cpus per die" and it gets the correct result, and
   CPUID.1FH.02H:EBX[bits 15:00] gets correct "cpus per package".

When CPUState.nr_cores is correctly changed to "cores per package" again
, the above errors will be fixed without extra work, but the "currently"
correct cases will go wrong and need special handling to pass correct
"cpus/cores per die" they want.

Fix CPUState.nr_cores' calculation to fit the original meaning "cores
per package", as well as changing calculation of topo_info.cores_per_die,
vcpus_per_socket and CPUID.1FH.

Fixes: a94e1428991f ("target/i386: Add CPUID.1F generation support for multi-dies PCMachine")
Fixes: 003f230e37d7 ("machine: Tweak the order of topology members in struct CpuTopology")
Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Co-developed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20231024090323.1859210-4-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/cpus.c     | 2 +-
 target/i386/cpu.c | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/system/cpus.c b/system/cpus.c
index 952f15868c..a444a747f0 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -631,7 +631,7 @@ void qemu_init_vcpu(CPUState *cpu)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
 
-    cpu->nr_cores = ms->smp.cores;
+    cpu->nr_cores = machine_topo_get_cores_per_socket(ms);
     cpu->nr_threads =  ms->smp.threads;
     cpu->stopped = true;
     cpu->random_seed = qemu_guest_random_seed_thread_part1();
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index fc8484cb5e..358d9c0a65 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6019,7 +6019,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     X86CPUTopoInfo topo_info;
 
     topo_info.dies_per_pkg = env->nr_dies;
-    topo_info.cores_per_die = cs->nr_cores;
+    topo_info.cores_per_die = cs->nr_cores / env->nr_dies;
     topo_info.threads_per_core = cs->nr_threads;
 
     /* Calculate & apply limits for different index ranges */
@@ -6095,8 +6095,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
              */
             if (*eax & 31) {
                 int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
-                int vcpus_per_socket = env->nr_dies * cs->nr_cores *
-                                       cs->nr_threads;
+                int vcpus_per_socket = cs->nr_cores * cs->nr_threads;
                 if (cs->nr_cores > 1) {
                     *eax &= ~0xFC000000;
                     *eax |= (pow2ceil(cs->nr_cores) - 1) << 26;
@@ -6273,12 +6272,12 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
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
-- 
2.41.0


