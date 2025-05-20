Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D66ABD6E6
	for <lists+qemu-devel@lfdr.de>; Tue, 20 May 2025 13:33:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHLCz-0000tu-KS; Tue, 20 May 2025 07:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uHLCx-0000pq-22
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:32:31 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uHLCu-0001OM-HF
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:32:30 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (unknown [172.201.77.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id 98041206832B;
 Tue, 20 May 2025 04:32:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 98041206832B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1747740737;
 bh=OXqkrf6TCJWy5ECu5bnGsiFIG/qTft8xwDlG3iMFvLo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DYu5bGCGnzksJfVtVjCjs7b5tn341ORIoXP7D0GI8TLp9lbSQ5d7gBS/a32bVp1ca
 dQ4i6H6QyckRuoYggi4xTF0Rxn9sQNau+44zI1y4oZD9No9wHKeWYSSwza+ygHXEZz
 YhoyF7u4NOB/0WeMF4TS41cNc7dw9c7kbjEipgBE=
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
Subject: [RFC PATCH 20/25] target/i386/mshv: Register CPUID entries with MSHV
Date: Tue, 20 May 2025 13:30:13 +0200
Message-Id: <20250520113018.49569-21-magnuskulke@linux.microsoft.com>
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

Convert the guest CPU's CPUID model into MSHV's format and register it
with the hypervisor. This ensures that the guest observes the correct
CPU feature set during CPUID instructions.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 199 ++++++++++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index dd856a2242..4208f498cd 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -377,6 +377,199 @@ int mshv_load_regs(CPUState *cpu)
     return 0;
 }
 
+static void add_cpuid_entry(GList *cpuid_entries,
+                            uint32_t function, uint32_t index,
+                            uint32_t eax, uint32_t ebx,
+                            uint32_t ecx, uint32_t edx)
+{
+    struct hv_cpuid_entry *entry;
+
+    entry = g_malloc0(sizeof(struct hv_cpuid_entry));
+    entry->function = function;
+    entry->index = index;
+    entry->eax = eax;
+    entry->ebx = ebx;
+    entry->ecx = ecx;
+    entry->edx = edx;
+
+    cpuid_entries = g_list_append(cpuid_entries, entry);
+}
+
+static void collect_cpuid_entries(const CPUState *cpu, GList *cpuid_entries)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    uint32_t eax, ebx, ecx, edx;
+    uint32_t leaf, subleaf;
+    size_t max_leaf = 0x1F;
+    size_t max_subleaf = 0x20;
+
+    uint32_t leaves_with_subleaves[] = {0x4, 0x7, 0xD, 0xF, 0x10};
+    int n_subleaf_leaves = ARRAY_SIZE(leaves_with_subleaves);
+
+    /* Regular leaves without subleaves */
+    for (leaf = 0; leaf <= max_leaf; leaf++) {
+        bool has_subleaves = false;
+        for (int i = 0; i < n_subleaf_leaves; i++) {
+            if (leaf == leaves_with_subleaves[i]) {
+                has_subleaves = true;
+                break;
+            }
+        }
+
+        if (!has_subleaves) {
+            cpu_x86_cpuid(env, leaf, 0, &eax, &ebx, &ecx, &edx);
+            if (eax == 0 && ebx == 0 && ecx == 0 && edx == 0) {
+                /* all zeroes indicates no more leaves */
+                continue;
+            }
+
+            add_cpuid_entry(cpuid_entries, leaf, 0, eax, ebx, ecx, edx);
+            continue;
+        }
+
+        subleaf = 0;
+        while (subleaf < max_subleaf) {
+            cpu_x86_cpuid(env, leaf, subleaf, &eax, &ebx, &ecx, &edx);
+
+            if (eax == 0 && ebx == 0 && ecx == 0 && edx == 0) {
+                /* all zeroes indicates no more leaves */
+                break;
+            }
+            add_cpuid_entry(cpuid_entries, leaf, 0, eax, ebx, ecx, edx);
+            subleaf++;
+        }
+    }
+}
+
+static int register_intercept_result_cpuid_entry(int cpu_fd,
+                                                 uint8_t subleaf_specific,
+                                                 uint8_t always_override,
+                                                 struct hv_cpuid_entry *entry)
+{
+    struct hv_register_x64_cpuid_result_parameters cpuid_params = {
+        .input.eax = entry->function,
+        .input.ecx = entry->index,
+        .input.subleaf_specific = subleaf_specific,
+        .input.always_override = always_override,
+        .input.padding = 0,
+        /*
+         * With regard to masks - these are to specify bits to be overwritten
+         * The current CpuidEntry structure wouldn't allow to carry the masks
+         * in addition to the actual register values. For this reason, the
+         * masks are set to the exact values of the corresponding register bits
+         * to be registered for an overwrite. To view resulting values the
+         * hypervisor would return, HvCallGetVpCpuidValues hypercall can be
+         * used.
+         */
+        .result.eax = entry->eax,
+        .result.eax_mask = entry->eax,
+        .result.ebx = entry->ebx,
+        .result.ebx_mask = entry->ebx,
+        .result.ecx = entry->ecx,
+        .result.ecx_mask = entry->ecx,
+        .result.edx = entry->edx,
+        .result.edx_mask = entry->edx,
+    };
+    union hv_register_intercept_result_parameters parameters = {
+        .cpuid = cpuid_params,
+    };
+    struct mshv_register_intercept_result args = {
+        .intercept_type = HV_INTERCEPT_TYPE_X64_CPUID,
+        .parameters = parameters,
+    };
+    int ret;
+
+    ret = ioctl(cpu_fd, MSHV_VP_REGISTER_INTERCEPT_RESULT, &args);
+    if (ret < 0) {
+        error_report("failed to register intercept result for cpuid: %s",
+                     strerror(errno));
+        return -1;
+    }
+
+    return 0;
+}
+
+static int register_intercept_result_cpuid(int cpu_fd, struct hv_cpuid *cpuid)
+{
+    int ret = 0, entry_ret;
+    struct hv_cpuid_entry *entry;
+    uint8_t subleaf_specific, always_override;
+
+    for (size_t i = 0; i < cpuid->nent; i++) {
+        entry = &cpuid->entries[i];
+
+        /* set defaults */
+        subleaf_specific = 0;
+        always_override = 1;
+
+        /* Intel */
+        /* 0xb - Extended Topology Enumeration Leaf */
+        /* 0x1f - V2 Extended Topology Enumeration Leaf */
+        /* AMD */
+        /* 0x8000_001e - Processor Topology Information */
+        /* 0x8000_0026 - Extended CPU Topology */
+        if (entry->function == 0xb
+            || entry->function == 0x1f
+            || entry->function == 0x8000001e
+            || entry->function == 0x80000026) {
+            subleaf_specific = 1;
+            always_override = 1;
+        } else if (entry->function == 0x00000001
+            || entry->function == 0x80000000
+            || entry->function == 0x80000001
+            || entry->function == 0x80000008) {
+            subleaf_specific = 0;
+            always_override = 1;
+        }
+
+        entry_ret = register_intercept_result_cpuid_entry(cpu_fd,
+                                                          subleaf_specific,
+                                                          always_override,
+                                                          entry);
+        if ((entry_ret < 0) && (ret == 0)) {
+            ret = entry_ret;
+        }
+    }
+
+    return ret;
+}
+
+static int set_cpuid2(const CPUState *cpu)
+{
+    int ret;
+    size_t n_entries, cpuid_size;
+    struct hv_cpuid *cpuid;
+    struct hv_cpuid_entry *entry;
+    GList *entries = NULL;
+    int cpu_fd = mshv_vcpufd(cpu);
+
+    collect_cpuid_entries(cpu, entries);
+    n_entries = g_list_length(entries);
+
+    cpuid_size = sizeof(struct hv_cpuid)
+        + n_entries * sizeof(struct hv_cpuid_entry);
+
+    cpuid = g_malloc0(cpuid_size);
+    cpuid->nent = n_entries;
+    cpuid->padding = 0;
+
+    for (size_t i = 0; i < n_entries; i++) {
+        entry = g_list_nth_data(entries, i);
+        cpuid->entries[i] = *entry;
+        g_free(entry);
+    }
+    g_list_free(entries);
+
+    ret = register_intercept_result_cpuid(cpu_fd, cpuid);
+    g_free(cpuid);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return 0;
+}
+
 static void populate_hv_segment_reg(SegmentCache *seg,
                                     hv_x64_segment_register *hv_reg)
 {
@@ -671,6 +864,12 @@ int mshv_configure_vcpu(const CPUState *cpu, const struct MshvFPU *fpu,
     int ret;
     int cpu_fd = mshv_vcpufd(cpu);
 
+    ret = set_cpuid2(cpu);
+    if (ret < 0) {
+        error_report("failed to set cpuid");
+        return -1;
+    }
+
     ret = set_cpu_state(cpu, fpu, xcr0);
     if (ret < 0) {
         error_report("failed to set cpu state");
-- 
2.34.1


