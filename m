Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48199AF020F
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Jul 2025 19:40:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWepM-0006X7-MU; Tue, 01 Jul 2025 13:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uWeoh-0006OJ-8q
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:30:47 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uWeoY-0007Hg-Gy
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:30:44 -0400
Received: from localhost.localdomain (unknown [167.220.208.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id 65D49211223E;
 Tue,  1 Jul 2025 10:30:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 65D49211223E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1751391026;
 bh=0Vv7Y0Pmj311UbJKfroCFrvii350KiVQ+/9R//QZAT4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CTlDmBkLU0JeOMrMAlzjnZMjvv4kEeQt1eULuRmDWt8xt/GnPrVKziCPeJ6r6vA5N
 D1Sr9C0khOmGyB1eDpNIi01JRJ41NcqbWLTm9bYt6OxPF8to2syUseqSb+CJpGvFsV
 jOBf4U3JVcb3E41nMjRBDuKJ/kVxRLzXFngTYTX0=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Thomas Huth <thuth@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 21/27] target/i386/mshv: Register MSRs with MSHV
Date: Tue,  1 Jul 2025 19:28:28 +0200
Message-Id: <20250701172834.44849-22-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250701172834.44849-1-magnuskulke@linux.microsoft.com>
References: <20250701172834.44849-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Build and register the guest vCPU's model-specific registers using
the MSHV interface.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/meson.build      |   1 +
 accel/mshv/msr.c            | 372 ++++++++++++++++++++++++++++++++++++
 include/system/mshv.h       |  23 +++
 target/i386/cpu.h           |   2 +
 target/i386/mshv/mshv-cpu.c |  33 ++++
 5 files changed, 431 insertions(+)
 create mode 100644 accel/mshv/msr.c

diff --git a/accel/mshv/meson.build b/accel/mshv/meson.build
index f88fc8678c..d3a2b32581 100644
--- a/accel/mshv/meson.build
+++ b/accel/mshv/meson.build
@@ -2,6 +2,7 @@ mshv_ss = ss.source_set()
 mshv_ss.add(if_true: files(
   'irq.c',
   'mem.c',
+  'msr.c',
   'mshv-all.c'
 ))
 
diff --git a/accel/mshv/msr.c b/accel/mshv/msr.c
new file mode 100644
index 0000000000..b4aecd68ed
--- /dev/null
+++ b/accel/mshv/msr.c
@@ -0,0 +1,372 @@
+/*
+ * QEMU MSHV support
+ *
+ * Copyright Microsoft, Corp. 2025
+ *
+ * Authors: Magnus Kulke  <magnuskulke@microsoft.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/mshv.h"
+#include "linux/mshv.h"
+#include "qemu/error-report.h"
+
+static uint32_t supported_msrs[64] = {
+    IA32_MSR_TSC,
+    IA32_MSR_EFER,
+    IA32_MSR_KERNEL_GS_BASE,
+    IA32_MSR_APIC_BASE,
+    IA32_MSR_PAT,
+    IA32_MSR_SYSENTER_CS,
+    IA32_MSR_SYSENTER_ESP,
+    IA32_MSR_SYSENTER_EIP,
+    IA32_MSR_STAR,
+    IA32_MSR_LSTAR,
+    IA32_MSR_CSTAR,
+    IA32_MSR_SFMASK,
+    IA32_MSR_MTRR_DEF_TYPE,
+    IA32_MSR_MTRR_PHYSBASE0,
+    IA32_MSR_MTRR_PHYSMASK0,
+    IA32_MSR_MTRR_PHYSBASE1,
+    IA32_MSR_MTRR_PHYSMASK1,
+    IA32_MSR_MTRR_PHYSBASE2,
+    IA32_MSR_MTRR_PHYSMASK2,
+    IA32_MSR_MTRR_PHYSBASE3,
+    IA32_MSR_MTRR_PHYSMASK3,
+    IA32_MSR_MTRR_PHYSBASE4,
+    IA32_MSR_MTRR_PHYSMASK4,
+    IA32_MSR_MTRR_PHYSBASE5,
+    IA32_MSR_MTRR_PHYSMASK5,
+    IA32_MSR_MTRR_PHYSBASE6,
+    IA32_MSR_MTRR_PHYSMASK6,
+    IA32_MSR_MTRR_PHYSBASE7,
+    IA32_MSR_MTRR_PHYSMASK7,
+    IA32_MSR_MTRR_FIX64K_00000,
+    IA32_MSR_MTRR_FIX16K_80000,
+    IA32_MSR_MTRR_FIX16K_A0000,
+    IA32_MSR_MTRR_FIX4K_C0000,
+    IA32_MSR_MTRR_FIX4K_C8000,
+    IA32_MSR_MTRR_FIX4K_D0000,
+    IA32_MSR_MTRR_FIX4K_D8000,
+    IA32_MSR_MTRR_FIX4K_E0000,
+    IA32_MSR_MTRR_FIX4K_E8000,
+    IA32_MSR_MTRR_FIX4K_F0000,
+    IA32_MSR_MTRR_FIX4K_F8000,
+    IA32_MSR_TSC_AUX,
+    IA32_MSR_DEBUG_CTL,
+    HV_X64_MSR_GUEST_OS_ID,
+    HV_X64_MSR_SINT0,
+    HV_X64_MSR_SINT1,
+    HV_X64_MSR_SINT2,
+    HV_X64_MSR_SINT3,
+    HV_X64_MSR_SINT4,
+    HV_X64_MSR_SINT5,
+    HV_X64_MSR_SINT6,
+    HV_X64_MSR_SINT7,
+    HV_X64_MSR_SINT8,
+    HV_X64_MSR_SINT9,
+    HV_X64_MSR_SINT10,
+    HV_X64_MSR_SINT11,
+    HV_X64_MSR_SINT12,
+    HV_X64_MSR_SINT13,
+    HV_X64_MSR_SINT14,
+    HV_X64_MSR_SINT15,
+    HV_X64_MSR_SCONTROL,
+    HV_X64_MSR_SIEFP,
+    HV_X64_MSR_SIMP,
+    HV_X64_MSR_REFERENCE_TSC,
+    HV_X64_MSR_EOM,
+};
+static const size_t msr_count = ARRAY_SIZE(supported_msrs);
+
+static int compare_msr_index(const void *a, const void *b)
+{
+    return *(uint32_t *)a - *(uint32_t *)b;
+}
+
+__attribute__((constructor))
+static void init_sorted_msr_map(void)
+{
+    qsort(supported_msrs, msr_count, sizeof(uint32_t), compare_msr_index);
+}
+
+static int mshv_is_supported_msr(uint32_t msr)
+{
+    return bsearch(&msr, supported_msrs, msr_count, sizeof(uint32_t),
+                   compare_msr_index) != NULL;
+}
+
+static int mshv_msr_to_hv_reg_name(uint32_t msr, uint32_t *hv_reg)
+{
+    switch (msr) {
+    case IA32_MSR_TSC:
+        *hv_reg = HV_X64_REGISTER_TSC;
+        return 0;
+    case IA32_MSR_EFER:
+        *hv_reg = HV_X64_REGISTER_EFER;
+        return 0;
+    case IA32_MSR_KERNEL_GS_BASE:
+        *hv_reg = HV_X64_REGISTER_KERNEL_GS_BASE;
+        return 0;
+    case IA32_MSR_APIC_BASE:
+        *hv_reg = HV_X64_REGISTER_APIC_BASE;
+        return 0;
+    case IA32_MSR_PAT:
+        *hv_reg = HV_X64_REGISTER_PAT;
+        return 0;
+    case IA32_MSR_SYSENTER_CS:
+        *hv_reg = HV_X64_REGISTER_SYSENTER_CS;
+        return 0;
+    case IA32_MSR_SYSENTER_ESP:
+        *hv_reg = HV_X64_REGISTER_SYSENTER_ESP;
+        return 0;
+    case IA32_MSR_SYSENTER_EIP:
+        *hv_reg = HV_X64_REGISTER_SYSENTER_EIP;
+        return 0;
+    case IA32_MSR_STAR:
+        *hv_reg = HV_X64_REGISTER_STAR;
+        return 0;
+    case IA32_MSR_LSTAR:
+        *hv_reg = HV_X64_REGISTER_LSTAR;
+        return 0;
+    case IA32_MSR_CSTAR:
+        *hv_reg = HV_X64_REGISTER_CSTAR;
+        return 0;
+    case IA32_MSR_SFMASK:
+        *hv_reg = HV_X64_REGISTER_SFMASK;
+        return 0;
+    case IA32_MSR_MTRR_CAP:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_CAP;
+        return 0;
+    case IA32_MSR_MTRR_DEF_TYPE:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_DEF_TYPE;
+        return 0;
+    case IA32_MSR_MTRR_PHYSBASE0:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0;
+        return 0;
+    case IA32_MSR_MTRR_PHYSMASK0:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0;
+        return 0;
+    case IA32_MSR_MTRR_PHYSBASE1:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE1;
+        return 0;
+    case IA32_MSR_MTRR_PHYSMASK1:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK1;
+        return 0;
+    case IA32_MSR_MTRR_PHYSBASE2:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE2;
+        return 0;
+    case IA32_MSR_MTRR_PHYSMASK2:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK2;
+        return 0;
+    case IA32_MSR_MTRR_PHYSBASE3:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE3;
+        return 0;
+    case IA32_MSR_MTRR_PHYSMASK3:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK3;
+        return 0;
+    case IA32_MSR_MTRR_PHYSBASE4:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE4;
+        return 0;
+    case IA32_MSR_MTRR_PHYSMASK4:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK4;
+        return 0;
+    case IA32_MSR_MTRR_PHYSBASE5:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE5;
+        return 0;
+    case IA32_MSR_MTRR_PHYSMASK5:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK5;
+        return 0;
+    case IA32_MSR_MTRR_PHYSBASE6:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE6;
+        return 0;
+    case IA32_MSR_MTRR_PHYSMASK6:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK6;
+        return 0;
+    case IA32_MSR_MTRR_PHYSBASE7:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_BASE7;
+        return 0;
+    case IA32_MSR_MTRR_PHYSMASK7:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_PHYS_MASK7;
+        return 0;
+    case IA32_MSR_MTRR_FIX64K_00000:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX64K00000;
+        return 0;
+    case IA32_MSR_MTRR_FIX16K_80000:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX16K80000;
+        return 0;
+    case IA32_MSR_MTRR_FIX16K_A0000:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX16KA0000;
+        return 0;
+    case IA32_MSR_MTRR_FIX4K_C0000:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KC0000;
+        return 0;
+    case IA32_MSR_MTRR_FIX4K_C8000:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KC8000;
+        return 0;
+    case IA32_MSR_MTRR_FIX4K_D0000:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KD0000;
+        return 0;
+    case IA32_MSR_MTRR_FIX4K_D8000:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KD8000;
+        return 0;
+    case IA32_MSR_MTRR_FIX4K_E0000:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KE0000;
+        return 0;
+    case IA32_MSR_MTRR_FIX4K_E8000:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KE8000;
+        return 0;
+    case IA32_MSR_MTRR_FIX4K_F0000:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KF0000;
+        return 0;
+    case IA32_MSR_MTRR_FIX4K_F8000:
+        *hv_reg = HV_X64_REGISTER_MSR_MTRR_FIX4KF8000;
+        return 0;
+    case IA32_MSR_TSC_AUX:
+        *hv_reg = HV_X64_REGISTER_TSC_AUX;
+        return 0;
+    case IA32_MSR_BNDCFGS:
+        *hv_reg = HV_X64_REGISTER_BNDCFGS;
+        return 0;
+    case IA32_MSR_DEBUG_CTL:
+        *hv_reg = HV_X64_REGISTER_DEBUG_CTL;
+        return 0;
+    case IA32_MSR_TSC_ADJUST:
+        *hv_reg = HV_X64_REGISTER_TSC_ADJUST;
+        return 0;
+    case IA32_MSR_SPEC_CTRL:
+        *hv_reg = HV_X64_REGISTER_SPEC_CTRL;
+        return 0;
+    case HV_X64_MSR_GUEST_OS_ID:
+        *hv_reg = HV_REGISTER_GUEST_OS_ID;
+        return 0;
+    case HV_X64_MSR_SINT0:
+        *hv_reg = HV_REGISTER_SINT0;
+        return 0;
+    case HV_X64_MSR_SINT1:
+        *hv_reg = HV_REGISTER_SINT1;
+        return 0;
+    case HV_X64_MSR_SINT2:
+        *hv_reg = HV_REGISTER_SINT2;
+        return 0;
+    case HV_X64_MSR_SINT3:
+        *hv_reg = HV_REGISTER_SINT3;
+        return 0;
+    case HV_X64_MSR_SINT4:
+        *hv_reg = HV_REGISTER_SINT4;
+        return 0;
+    case HV_X64_MSR_SINT5:
+        *hv_reg = HV_REGISTER_SINT5;
+        return 0;
+    case HV_X64_MSR_SINT6:
+        *hv_reg = HV_REGISTER_SINT6;
+        return 0;
+    case HV_X64_MSR_SINT7:
+        *hv_reg = HV_REGISTER_SINT7;
+        return 0;
+    case HV_X64_MSR_SINT8:
+        *hv_reg = HV_REGISTER_SINT8;
+        return 0;
+    case HV_X64_MSR_SINT9:
+        *hv_reg = HV_REGISTER_SINT9;
+        return 0;
+    case HV_X64_MSR_SINT10:
+        *hv_reg = HV_REGISTER_SINT10;
+        return 0;
+    case HV_X64_MSR_SINT11:
+        *hv_reg = HV_REGISTER_SINT11;
+        return 0;
+    case HV_X64_MSR_SINT12:
+        *hv_reg = HV_REGISTER_SINT12;
+        return 0;
+    case HV_X64_MSR_SINT13:
+        *hv_reg = HV_REGISTER_SINT13;
+        return 0;
+    case HV_X64_MSR_SINT14:
+        *hv_reg = HV_REGISTER_SINT14;
+        return 0;
+    case HV_X64_MSR_SINT15:
+        *hv_reg = HV_REGISTER_SINT15;
+        return 0;
+    case IA32_MSR_MISC_ENABLE:
+        *hv_reg = HV_X64_REGISTER_MSR_IA32_MISC_ENABLE;
+        return 0;
+    case HV_X64_MSR_SCONTROL:
+        *hv_reg = HV_REGISTER_SCONTROL;
+        return 0;
+    case HV_X64_MSR_SIEFP:
+        *hv_reg = HV_REGISTER_SIEFP;
+        return 0;
+    case HV_X64_MSR_SIMP:
+        *hv_reg = HV_REGISTER_SIMP;
+        return 0;
+    case HV_X64_MSR_REFERENCE_TSC:
+        *hv_reg = HV_REGISTER_REFERENCE_TSC;
+        return 0;
+    case HV_X64_MSR_EOM:
+        *hv_reg = HV_REGISTER_EOM;
+        return 0;
+    default:
+        error_report("failed to map MSR %u to HV register name", msr);
+        return -1;
+    }
+}
+
+static int set_msrs(int cpu_fd, GList *msrs)
+{
+    size_t n_msrs;
+    GList *entries;
+    MshvMsrEntry *entry;
+    enum hv_register_name name;
+    struct hv_register_assoc *assoc;
+    int ret;
+    size_t i = 0;
+
+    n_msrs = g_list_length(msrs);
+    hv_register_assoc *assocs = g_new0(hv_register_assoc, n_msrs);
+
+    entries = msrs;
+    for (const GList *elem = entries; elem != NULL; elem = elem->next) {
+        entry = elem->data;
+        ret = mshv_msr_to_hv_reg_name(entry->index, &name);
+        if (ret < 0) {
+            g_free(assocs);
+            return ret;
+        }
+        assoc = &assocs[i];
+        assoc->name = name;
+        /* the union has been initialized to 0 */
+        assoc->value.reg64 = entry->data;
+        i++;
+    }
+    ret = mshv_set_generic_regs(cpu_fd, assocs, n_msrs);
+    g_free(assocs);
+    if (ret < 0) {
+        error_report("failed to set msrs");
+        return -1;
+    }
+    return 0;
+}
+
+
+int mshv_configure_msr(int cpu_fd, const MshvMsrEntry *msrs, size_t n_msrs)
+{
+    GList *valid_msrs = NULL;
+    uint32_t msr_index;
+    int ret;
+
+    for (size_t i = 0; i < n_msrs; i++) {
+        msr_index = msrs[i].index;
+        /* check whether index of msrs is in SUPPORTED_MSRS */
+        if (mshv_is_supported_msr(msr_index)) {
+            valid_msrs = g_list_append(valid_msrs, (void *) &msrs[i]);
+        }
+    }
+
+    ret = set_msrs(cpu_fd, valid_msrs);
+    g_list_free(valid_msrs);
+
+    return ret;
+}
diff --git a/include/system/mshv.h b/include/system/mshv.h
index 40510d5f80..9e3242d5e6 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -36,6 +36,8 @@ typedef struct hyperv_message hv_message;
 
 #define MSHV_PAGE_SHIFT 12
 
+#define MSHV_MSR_ENTRIES_COUNT 64
+
 #ifdef CONFIG_MSHV_IS_POSSIBLE
 extern bool mshv_allowed;
 #define mshv_enabled() (mshv_allowed)
@@ -116,8 +118,29 @@ void mshv_arch_amend_proc_features(
     union hv_partition_synthetic_processor_features *features);
 int mshv_arch_post_init_vm(int vm_fd);
 
+/* pio */
+int mshv_pio_write(uint64_t port, const uint8_t *data, uintptr_t size,
+                   bool is_secure_mode);
+void mshv_pio_read(uint64_t port, uint8_t *data, uintptr_t size,
+                   bool is_secure_mode);
+
+/* generic */
 int mshv_hvcall(int mshv_fd, const struct mshv_root_hvcall *args);
 
+/* msr */
+typedef struct MshvMsrEntry {
+  uint32_t index;
+  uint32_t reserved;
+  uint64_t data;
+} MshvMsrEntry;
+
+typedef struct MshvMsrEntries {
+    MshvMsrEntry entries[MSHV_MSR_ENTRIES_COUNT];
+    uint32_t nmsrs;
+} MshvMsrEntries;
+
+int mshv_configure_msr(int cpu_fd, const MshvMsrEntry *msrs, size_t n_msrs);
+
 /* memory */
 typedef struct MshvMemoryRegion {
     uint64_t guest_phys_addr;
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 48979432f6..8c3ddbaae7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -435,9 +435,11 @@ typedef enum X86Seg {
 #define MSR_SMI_COUNT                   0x34
 #define MSR_CORE_THREAD_COUNT           0x35
 #define MSR_MTRRcap                     0xfe
+#define MSR_MTRR_MEM_TYPE_WB            0x06
 #define MSR_MTRRcap_VCNT                8
 #define MSR_MTRRcap_FIXRANGE_SUPPORT    (1 << 8)
 #define MSR_MTRRcap_WC_SUPPORTED        (1 << 10)
+#define MSR_MTRR_ENABLE                 (1 << 11)
 
 #define MSR_IA32_SYSENTER_CS            0x174
 #define MSR_IA32_SYSENTER_ESP           0x175
diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 210bd85e11..a17be79a77 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -787,6 +787,33 @@ static int set_lint(int cpu_fd)
     return set_lapic(cpu_fd, &lapic_state);
 }
 
+static int setup_msrs(int cpu_fd)
+{
+    int ret;
+    uint64_t default_type = MSR_MTRR_ENABLE | MSR_MTRR_MEM_TYPE_WB;
+
+    /* boot msr entries */
+    MshvMsrEntry msrs[9] = {
+        { .index = IA32_MSR_SYSENTER_CS, .data = 0x0, },
+        { .index = IA32_MSR_SYSENTER_ESP, .data = 0x0, },
+        { .index = IA32_MSR_SYSENTER_EIP, .data = 0x0, },
+        { .index = IA32_MSR_STAR, .data = 0x0, },
+        { .index = IA32_MSR_CSTAR, .data = 0x0, },
+        { .index = IA32_MSR_LSTAR, .data = 0x0, },
+        { .index = IA32_MSR_KERNEL_GS_BASE, .data = 0x0, },
+        { .index = IA32_MSR_SFMASK, .data = 0x0, },
+        { .index = IA32_MSR_MTRR_DEF_TYPE, .data = default_type, },
+    };
+
+    ret = mshv_configure_msr(cpu_fd, msrs, 9);
+    if (ret < 0) {
+        error_report("failed to setup msrs");
+        return -1;
+    }
+
+    return 0;
+}
+
 /*
  * TODO: populate topology info:
  *
@@ -806,6 +833,12 @@ int mshv_configure_vcpu(const CPUState *cpu, const struct MshvFPU *fpu,
         return -1;
     }
 
+    ret = setup_msrs(cpu_fd);
+    if (ret < 0) {
+        error_report("failed to setup msrs");
+        return -1;
+    }
+
     ret = set_cpu_state(cpu, fpu, xcr0);
     if (ret < 0) {
         error_report("failed to set cpu state");
-- 
2.34.1


