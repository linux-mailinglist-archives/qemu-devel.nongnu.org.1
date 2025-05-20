Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CCCABD6E0
	for <lists+qemu-devel@lfdr.de>; Tue, 20 May 2025 13:32:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHLCn-0000Q9-R0; Tue, 20 May 2025 07:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uHLCj-0000HY-Qy
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:32:17 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uHLCh-0001MA-Jq
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:32:17 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (unknown [172.201.77.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id A4C182068325;
 Tue, 20 May 2025 04:32:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A4C182068325
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747740723;
 bh=5FQzi6hmC0+9xHPFDjxRzYOdmE42SgLd+SPFLHpqXsI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k4iw4TAAwfFk0/MbyNjk+3AoReKr6PpPl22circ6FO1MfpQg6bDMwl+dNjGnnkA4+
 +5zxbfSO9EE0Nu9sBrsl6Y3qLLGyvobhIQZWX3Hi1NUW/txfD7Lt/UfEtGLhVkdOAC
 rDvhnQ7HAQf+DFTyuSJlxCCfHWpMd6oAiUBQ6gV8=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: magnuskulke@microsoft.com,
	qemu-devel@nongnu.org,
	liuwe@microsoft.com
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 16/25] target/i386/mshv: Implement mshv_get_standard_regs()
Date: Tue, 20 May 2025 13:30:09 +0200
Message-Id: <20250520113018.49569-17-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Fetch standard register state from MSHV vCPUs to support debugging,
migration, and other introspection features in QEMU.

Fetch standard register state from a MHSV vCPU's. A generic get_regs()
function and a mapper to map the different register representations are
introduced.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 include/system/mshv.h       |  1 +
 target/i386/mshv/mshv-cpu.c | 70 +++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/include/system/mshv.h b/include/system/mshv.h
index b2dec5a7ec..9b78b66a24 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -108,6 +108,7 @@ typedef enum MshvVmExit {
 void mshv_init_cpu_logic(void);
 int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd);
 void mshv_remove_vcpu(int vm_fd, int cpu_fd);
+int mshv_get_standard_regs(CPUState *cpu);
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit);
 int mshv_load_regs(CPUState *cpu);
 int mshv_store_regs(CPUState *cpu);
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 83dcdc7b70..41584c3f8e 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -93,6 +93,18 @@ int mshv_set_generic_regs(int cpu_fd, hv_register_assoc *assocs, size_t n_regs)
     return ioctl(cpu_fd, MSHV_SET_VP_REGISTERS, &input);
 }
 
+static int get_generic_regs(int cpu_fd, struct hv_register_assoc *assocs,
+                            size_t n_regs)
+{
+    struct mshv_vp_registers input = {
+        .count = n_regs,
+        .regs = assocs,
+    };
+
+    return ioctl(cpu_fd, MSHV_GET_VP_REGISTERS, &input);
+}
+
+
 static int set_standard_regs(const CPUState *cpu)
 {
     X86CPU *x86cpu = X86_CPU(cpu);
@@ -152,9 +164,67 @@ int mshv_store_regs(CPUState *cpu)
     return 0;
 }
 
+static void populate_standard_regs(const hv_register_assoc *assocs,
+                                   CPUX86State *env)
+{
+    env->regs[R_EAX] = assocs[0].value.reg64;
+    env->regs[R_EBX] = assocs[1].value.reg64;
+    env->regs[R_ECX] = assocs[2].value.reg64;
+    env->regs[R_EDX] = assocs[3].value.reg64;
+    env->regs[R_ESI] = assocs[4].value.reg64;
+    env->regs[R_EDI] = assocs[5].value.reg64;
+    env->regs[R_ESP] = assocs[6].value.reg64;
+    env->regs[R_EBP] = assocs[7].value.reg64;
+    env->regs[R_R8]  = assocs[8].value.reg64;
+    env->regs[R_R9]  = assocs[9].value.reg64;
+    env->regs[R_R10] = assocs[10].value.reg64;
+    env->regs[R_R11] = assocs[11].value.reg64;
+    env->regs[R_R12] = assocs[12].value.reg64;
+    env->regs[R_R13] = assocs[13].value.reg64;
+    env->regs[R_R14] = assocs[14].value.reg64;
+    env->regs[R_R15] = assocs[15].value.reg64;
+
+    env->eip = assocs[16].value.reg64;
+    env->eflags = assocs[17].value.reg64;
+    rflags_to_lflags(env);
+}
+
+int mshv_get_standard_regs(CPUState *cpu)
+{
+    size_t n_regs = sizeof(STANDARD_REGISTER_NAMES) / sizeof(hv_register_name);
+    struct hv_register_assoc *assocs;
+    int ret;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    int cpu_fd = mshv_vcpufd(cpu);
+
+    assocs = g_new0(hv_register_assoc, n_regs);
+    for (size_t i = 0; i < n_regs; i++) {
+        assocs[i].name = STANDARD_REGISTER_NAMES[i];
+    }
+    ret = get_generic_regs(cpu_fd, assocs, n_regs);
+    if (ret < 0) {
+        error_report("failed to get standard registers");
+        g_free(assocs);
+        return -1;
+    }
+
+    populate_standard_regs(assocs, env);
+
+    g_free(assocs);
+    return 0;
+}
 
 int mshv_load_regs(CPUState *cpu)
 {
+    int ret;
+
+    ret = mshv_get_standard_regs(cpu);
+    if (ret < 0) {
+        error_report("Failed to load standard registers");
+        return -1;
+    }
+
 	error_report("unimplemented");
 	abort();
 }
-- 
2.34.1


