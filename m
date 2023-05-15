Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A64CB70321D
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:04:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyaep-00085h-DN; Mon, 15 May 2023 12:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1pyaed-0007kt-8K; Mon, 15 May 2023 12:02:31 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1pyaea-0001FL-Jl; Mon, 15 May 2023 12:02:30 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1aaff9c93a5so88092625ad.2; 
 Mon, 15 May 2023 09:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684166545; x=1686758545;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+IvQk3zi4fPR2sfDnu8m6WfAGfiIpTHhc0f/vLpgrPs=;
 b=BA9TJLpDUHF5ldE3+fdvOLLJdnCY7iQkVWg8agqOtE8Q5zHxa3BmndLxzQuaVeh9Nf
 s0sYu99EGxImZDnU/DjzOxihKj5hGBuFD5AskYYxJs9IFlLQA8DSXaNvVKKqg038y1Pa
 UjZ3ueArDw7JvFc4KFYpL6Y00a3KqMjCf7BolII5ky04qx9wkrpl+DmHCZJ63dSGjk53
 r1wATddkMC+036hPhWBjGi7OxXsmCmkLDxhCj1hiOUdgmJTH5hhd0VfLNLiffF0Q8iwb
 lMscZ981jkhwjKYEJ/TxzDitSkQ4OlQvZvbO+qPFUN9djqopRXi7BCC/JoN77vt6tRvc
 ewFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684166545; x=1686758545;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+IvQk3zi4fPR2sfDnu8m6WfAGfiIpTHhc0f/vLpgrPs=;
 b=TFs+2JDzappmG41PaJOpSATWkYsq7s4zAyrdsJnGt5s4wky+FdgZvLhTM1C8WBp2Oq
 sns8ptprL7n8fxrAKC4+dDDreP0ivik8G7Vl9//sjjX7jjzWE/AVB/IzALVrDD8VUsL0
 IlqBz0t3mA2WvDA/KJn77ir7zeXaBbycD0oavftMnB/W3U6oy2rFogPRwIC7lYwyDrWd
 Rq0YjzrgrPh4m8peoT6Gpvae7XrKJ6aOS2FDW0ofsGNiq8IVmrlK2b3rRX5boOYhyTMR
 k3OpnBbX492/mX++/Xk4uaQY1OfdyZWkRfJ3DOu0onIphn+ofm5Rnf8sgv3S5yitFnO/
 VxRg==
X-Gm-Message-State: AC+VfDwfMhS8DE5V6VqVonc0JfQ6o0ravfz8Z2OW9Qp+NlbWPHsbZmFP
 wUNv7hLffGDaGQxye0GI4ci2y3HAi8o=
X-Google-Smtp-Source: ACHHUZ647maN4ES/Bn7+v4WGduJeOzu31kQqMX2vdN5/mhUebnKS1fcauklhsKknqxxwH8srxN3lCw==
X-Received: by 2002:a17:902:6b03:b0:1a6:a1ec:53a3 with SMTP id
 o3-20020a1709026b0300b001a6a1ec53a3mr33653113plk.3.1684166544598; 
 Mon, 15 May 2023 09:02:24 -0700 (PDT)
Received: from wheely.local0.net ([202.168.30.146])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a170902868700b001a64c4023aesm13720618plo.36.2023.05.15.09.02.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 May 2023 09:02:24 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harsh@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v4] spapr: Add SPAPR_CAP_AIL_MODE_3 for AIL mode 3 support for
 H_SET_MODE hcall
Date: Tue, 16 May 2023 02:02:16 +1000
Message-Id: <20230515160216.394612-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The behaviour of the Address Translation Mode on Interrupt resource is
not consistently supported by all CPU versions or all KVM versions: KVM
HV does not support mode 2, and does not support mode 3 on POWER7 or
early POWER9 processesors. KVM PR only supports mode 0. TCG supports all
modes (0, 2, 3) on CPUs with support for the corresonding LPCR[AIL] mode.
This leads to inconsistencies in guest behaviour and could cause problems
migrating guests.

This was not noticable for Linux guests for a long time because the
kernel only uses modes 0 and 3, and it used to consider AIL-3 to be
advisory in that it would always keep the AIL-0 vectors around, so it
did not matter whether or not interrupts were delivered according to
the AIL mode. Recent Linux guests depend on AIL mode 3 working as
specified in order to support the SCV facility interrupt. If AIL-3 can
not be provided, then H_SET_MODE must return an error to Linux so it can
disable the SCV facility (failure to do so can lead to userspace being
able to crash the guest kernel).

Add the ail-mode-3 capability to specify that AIL-3 is supported. AIL-0
is implied as the baseline, and AIL-2 is no longer supported by spapr.
AIL-2 is not known to be used by any software, but support in TCG could
be restored with an ail-mode-2 capability quite easily if a regression
is reported.

Modify the H_SET_MODE Address Translation Mode on Interrupt resource
handler to check capabilities and correctly return error if not
supported.

KVM has a cap to advertise support for AIL-3.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Since v3:
- Integrated the KVM cap test into this patch since it is in Linux now.
- Removed the KVM fallback heuristic that detects whether AIL-3 might be
  supported if the KVM cap could be missing. This was possibly a bit
  complicated and dangerous because it prevents KVM from revoking the
  cap in future in some cases if it became necessary. Eat the
  performance cost on older KVM for now, and we can consider re-adding
  the heuristic if that becomes a problem.

 hw/ppc/spapr.c         |  5 +++++
 hw/ppc/spapr_caps.c    | 37 +++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_hcall.c   | 24 +++++++++++++-----------
 include/hw/ppc/spapr.h |  4 +++-
 target/ppc/kvm.c       |  7 +++++++
 target/ppc/kvm_ppc.h   |  6 ++++++
 6 files changed, 71 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b58e69afd7..2736233f92 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4673,6 +4673,11 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_FWNMI] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_RPT_INVALIDATE] = SPAPR_CAP_OFF;
+
+    /* This cap specifies whether the AIL 3 mode for H_SET_RESOURCE is
+     * supported. The default is modified by default_caps_with_cpu().
+     */
+    smc->default_caps.caps[SPAPR_CAP_AIL_MODE_3] = SPAPR_CAP_ON;
     spapr_caps_add_properties(smc);
     smc->irq = &spapr_irq_dual;
     smc->dr_phb_enabled = true;
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index b4283055c1..3fd45a6dec 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -614,6 +614,33 @@ static void cap_rpt_invalidate_apply(SpaprMachineState *spapr,
     }
 }
 
+static void cap_ail_mode_3_apply(SpaprMachineState *spapr,
+                                     uint8_t val, Error **errp)
+{
+    ERRP_GUARD();
+    PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
+
+    if (!val) {
+        return;
+    }
+
+    if (tcg_enabled()) {
+        /* AIL-3 is only supported on POWER8 and above CPUs. */
+        if (!(pcc->insns_flags2 & PPC2_ISA207S)) {
+            error_setg(errp, "TCG only supports cap-ail-mode-3 on POWER8 and later CPUs");
+            error_append_hint(errp, "Try appending -machine cap-ail-mode-3=off\n");
+            return;
+        }
+    } else if (kvm_enabled()) {
+        if (!kvmppc_supports_ail_3()) {
+            error_setg(errp, "KVM implementation does not support cap-ail-mode-3");
+            error_append_hint(errp, "Try appending -machine cap-ail-mode-3=off\n");
+            return;
+        }
+    }
+}
+
 SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
     [SPAPR_CAP_HTM] = {
         .name = "htm",
@@ -731,6 +758,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .type = "bool",
         .apply = cap_rpt_invalidate_apply,
     },
+    [SPAPR_CAP_AIL_MODE_3] = {
+        .name = "ail-mode-3",
+        .description = "Alternate Interrupt Location (AIL) mode 3 support",
+        .index = SPAPR_CAP_AIL_MODE_3,
+        .get = spapr_cap_get_bool,
+        .set = spapr_cap_set_bool,
+        .type = "bool",
+        .apply = cap_ail_mode_3_apply,
+    },
 };
 
 static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
@@ -750,6 +786,7 @@ static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
                                0, spapr->max_compat_pvr)) {
         caps.caps[SPAPR_CAP_HTM] = SPAPR_CAP_OFF;
         caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
+        caps.caps[SPAPR_CAP_AIL_MODE_3] = SPAPR_CAP_OFF;
     }
 
     if (!ppc_type_check_compat(cputype, CPU_POWERPC_LOGICAL_2_06_PLUS,
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 1c102c8c0d..b904755575 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -817,30 +817,32 @@ static target_ulong h_set_mode_resource_le(PowerPCCPU *cpu,
 }
 
 static target_ulong h_set_mode_resource_addr_trans_mode(PowerPCCPU *cpu,
+                                                        SpaprMachineState *spapr,
                                                         target_ulong mflags,
                                                         target_ulong value1,
                                                         target_ulong value2)
 {
-    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
-
-    if (!(pcc->insns_flags2 & PPC2_ISA207S)) {
-        return H_P2;
-    }
     if (value1) {
         return H_P3;
     }
+
     if (value2) {
         return H_P4;
     }
 
-    if (mflags == 1) {
-        /* AIL=1 is reserved in POWER8/POWER9/POWER10 */
+    /*
+     * AIL-1 is not architected, and AIL-2 is not supported by QEMU spapr.
+     * It is supported for faithful emulation of bare metal systems, but for
+     * compatibility concerns we leave it out of the pseries machine.
+     */
+    if (mflags != 0 && mflags != 3) {
         return H_UNSUPPORTED_FLAG;
     }
 
-    if (mflags == 2 && (pcc->insns_flags2 & PPC2_ISA310)) {
-        /* AIL=2 is reserved in POWER10 (ISA v3.1) */
-        return H_UNSUPPORTED_FLAG;
+    if (mflags == 3) {
+        if (!spapr_get_cap(spapr, SPAPR_CAP_AIL_MODE_3)) {
+            return H_UNSUPPORTED_FLAG;
+        }
     }
 
     spapr_set_all_lpcrs(mflags << LPCR_AIL_SHIFT, LPCR_AIL);
@@ -859,7 +861,7 @@ static target_ulong h_set_mode(PowerPCCPU *cpu, SpaprMachineState *spapr,
         ret = h_set_mode_resource_le(cpu, spapr, args[0], args[2], args[3]);
         break;
     case H_SET_MODE_RESOURCE_ADDR_TRANS_MODE:
-        ret = h_set_mode_resource_addr_trans_mode(cpu, args[0],
+        ret = h_set_mode_resource_addr_trans_mode(cpu, spapr, args[0],
                                                   args[2], args[3]);
         break;
     }
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 5c8aabd444..bd5a6c4780 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -78,8 +78,10 @@ typedef enum {
 #define SPAPR_CAP_FWNMI                 0x0A
 /* Support H_RPT_INVALIDATE */
 #define SPAPR_CAP_RPT_INVALIDATE        0x0B
+/* Support for AIL modes */
+#define SPAPR_CAP_AIL_MODE_3            0x0C
 /* Num Caps */
-#define SPAPR_CAP_NUM                   (SPAPR_CAP_RPT_INVALIDATE + 1)
+#define SPAPR_CAP_NUM                   (SPAPR_CAP_AIL_MODE_3 + 1)
 
 /*
  * Capability Values
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 336e663bc3..a7f2de9d10 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -88,6 +88,7 @@ static int cap_ppc_nested_kvm_hv;
 static int cap_large_decr;
 static int cap_fwnmi;
 static int cap_rpt_invalidate;
+static int cap_ail_mode_3;
 
 static uint32_t debug_inst_opcode;
 
@@ -152,6 +153,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     }
 
     cap_rpt_invalidate = kvm_vm_check_extension(s, KVM_CAP_PPC_RPT_INVALIDATE);
+    cap_ail_mode_3 = kvm_vm_check_extension(s, KVM_CAP_PPC_AIL_MODE_3);
     kvm_ppc_register_host_cpu_type();
 
     return 0;
@@ -2560,6 +2562,11 @@ int kvmppc_has_cap_rpt_invalidate(void)
     return cap_rpt_invalidate;
 }
 
+bool kvmppc_supports_ail_3(void)
+{
+    return cap_ail_mode_3;
+}
+
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
 {
     uint32_t host_pvr = mfpvr();
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 5fd9753953..611debc3ce 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -76,6 +76,7 @@ int kvmppc_set_cap_nested_kvm_hv(int enable);
 int kvmppc_get_cap_large_decr(void);
 int kvmppc_enable_cap_large_decr(PowerPCCPU *cpu, int enable);
 int kvmppc_has_cap_rpt_invalidate(void);
+bool kvmppc_supports_ail_3(void);
 int kvmppc_enable_hwrng(void);
 int kvmppc_put_books_sregs(PowerPCCPU *cpu);
 PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void);
@@ -396,6 +397,11 @@ static inline int kvmppc_has_cap_rpt_invalidate(void)
     return false;
 }
 
+static inline bool kvmppc_supports_ail_3(void)
+{
+    return false;
+}
+
 static inline int kvmppc_enable_hwrng(void)
 {
     return -1;
-- 
2.40.1


