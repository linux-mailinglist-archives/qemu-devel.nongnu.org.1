Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BD4B1DA4B
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Aug 2025 16:45:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk1p9-0001oc-JN; Thu, 07 Aug 2025 10:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uk1on-0000cf-UZ
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:42:11 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uk1om-00015c-DE
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:42:09 -0400
Received: from localhost.localdomain (unknown [167.220.208.72])
 by linux.microsoft.com (Postfix) with ESMTPSA id 277A1201BC95;
 Thu,  7 Aug 2025 07:42:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 277A1201BC95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1754577727;
 bh=mMv86KD3V67oVebba8l5rBp4oHWEZhUH0wYWCzvvwqQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jzeKjY3ZAa9blCel46xnxtS0vElu5Lkuna+BVJQa7VJKmNdfmWs8sPXF1WfmlZHDE
 iHuyaR2zE06lddRKuJKo2Ta7Dpjnl71g3AsruQd3a1sv7gpU1iQENzxaFi01xYmbmF
 p195jNR6lwqakKxoywXhGNaQrPqT2zC9u+3xMGIM=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Magnus Kulke <magnus.kulke@microsoft.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 21/26] target/i386/mshv: Write MSRs to the hypervisor
Date: Thu,  7 Aug 2025 16:39:46 +0200
Message-Id: <20250807143951.1154713-22-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
References: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
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

Push current model-specific register (MSR) values to MSHV's vCPUs as
part of setting state to the hypervisor.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 68 +++++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 2 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 673c90f865..431bf83ff9 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -901,6 +901,65 @@ static int put_regs(const CPUState *cpu)
     return 0;
 }
 
+struct MsrPair {
+    uint32_t index;
+    uint64_t value;
+};
+
+static int put_msrs(const CPUState *cpu)
+{
+    int ret = 0;
+    X86CPU *x86cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86cpu->env;
+    MshvMsrEntries *msrs = g_malloc0(sizeof(MshvMsrEntries));
+
+    struct MsrPair pairs[] = {
+        { MSR_IA32_SYSENTER_CS,    env->sysenter_cs },
+        { MSR_IA32_SYSENTER_ESP,   env->sysenter_esp },
+        { MSR_IA32_SYSENTER_EIP,   env->sysenter_eip },
+        { MSR_EFER,                env->efer },
+        { MSR_PAT,                 env->pat },
+        { MSR_STAR,                env->star },
+        { MSR_CSTAR,               env->cstar },
+        { MSR_LSTAR,               env->lstar },
+        { MSR_KERNELGSBASE,        env->kernelgsbase },
+        { MSR_FMASK,               env->fmask },
+        { MSR_MTRRdefType,         env->mtrr_deftype },
+        { MSR_VM_HSAVE_PA,         env->vm_hsave },
+        { MSR_SMI_COUNT,           env->msr_smi_count },
+        { MSR_IA32_PKRS,           env->pkrs },
+        { MSR_IA32_BNDCFGS,        env->msr_bndcfgs },
+        { MSR_IA32_XSS,            env->xss },
+        { MSR_IA32_UMWAIT_CONTROL, env->umwait },
+        { MSR_IA32_TSX_CTRL,       env->tsx_ctrl },
+        { MSR_AMD64_TSC_RATIO,     env->amd_tsc_scale_msr },
+        { MSR_TSC_AUX,             env->tsc_aux },
+        { MSR_TSC_ADJUST,          env->tsc_adjust },
+        { MSR_IA32_SMBASE,         env->smbase },
+        { MSR_IA32_SPEC_CTRL,      env->spec_ctrl },
+        { MSR_VIRT_SSBD,           env->virt_ssbd },
+    };
+
+    if (ARRAY_SIZE(pairs) > MSHV_MSR_ENTRIES_COUNT) {
+        error_report("MSR entries exceed maximum size");
+        g_free(msrs);
+        return -1;
+    }
+
+    for (size_t i = 0; i < ARRAY_SIZE(pairs); i++) {
+        MshvMsrEntry *entry = &msrs->entries[i];
+        entry->index = pairs[i].index;
+        entry->reserved = 0;
+        entry->data = pairs[i].value;
+        msrs->nmsrs++;
+    }
+
+    ret = mshv_configure_msr(mshv_vcpufd(cpu), &msrs->entries[0], msrs->nmsrs);
+    g_free(msrs);
+    return ret;
+}
+
+
 int mshv_arch_put_registers(const CPUState *cpu)
 {
     int ret;
@@ -911,8 +970,13 @@ int mshv_arch_put_registers(const CPUState *cpu)
         return -1;
     }
 
-    error_report("unimplemented");
-    abort();
+    ret = put_msrs(cpu);
+    if (ret < 0) {
+        error_report("Failed to put msrs");
+        return -1;
+    }
+
+    return 0;
 }
 
 void mshv_arch_amend_proc_features(
-- 
2.34.1


