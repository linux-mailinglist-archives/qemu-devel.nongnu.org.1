Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79268713ABD
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 18:51:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3JaY-0000Xb-Mf; Sun, 28 May 2023 12:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3JaW-0000Wu-Cu; Sun, 28 May 2023 12:49:48 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3JaU-0003ar-Gf; Sun, 28 May 2023 12:49:48 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-397f0bb41a2so760169b6e.0; 
 Sun, 28 May 2023 09:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685292585; x=1687884585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axGG6fTPckiO9vljrrokbP6P6GAUhDfvYythDmoJ4Hw=;
 b=Kane6t6BP0IWvdv7a5zFduSEfYXAQzX7DszZvAFNWTgwhlqCkpHJDMMpxCTHavKlQR
 /uhP8dicIKjJus/VBa0YWImTVQ0TXXOcda8lK+tadw2XPUAqaisacMi19m8vAeIua/R1
 P9carjiVS2/si8uq7uM5dX2J8rkj5mgDTzVQGwRgYP/UvL3l1Yv2lzVFVDrYbjb2UAC5
 rxXrQOGysdZrYHcNLiUI/oOT0Xq0/FrXheyO3Cxy8Xd4u5lQ2ecmw+VGQ9Y+SJwU1UiJ
 SpHZGyzqhwd0FzkZ1rknWhoHEkAlcHsM/WRPqOMxgME9hPrwXB9ZJ53BxGerteibNbMI
 Rjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685292585; x=1687884585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=axGG6fTPckiO9vljrrokbP6P6GAUhDfvYythDmoJ4Hw=;
 b=aiK9mToJntiLzTn9QaRNJq4heD29vv1WF7z45BiIZwF3tMh//yEEDQIzJ/i0iDEdkd
 TaN6eJnPeo1c9rv6WfF2phb2qHJ+sJwNRnfCi9Afix/cmQktITfrI0IXQSr9nJj4ii8U
 nDOfxvgL4Rl01a0+NVba8CIZK0o5c0i51gNPV1N80/4if35g0YnsmTtz0TEq7pH47tYn
 OPyOeYvLf3o+9ZpTpZt4YZCIEtt9a3OTq+gRQOqdb9lwGGyeLYiY18xryXaY7aHiKS/D
 qQIBj/ouXJSq6Fe3yIcpP6CRrDQE8eszhj22y+pHzCeHxvS/akHBCMsY66huWBgySwXi
 miaQ==
X-Gm-Message-State: AC+VfDyP+spjgGMmx1UpRTVlEtzF0U2tF4TCgCsGysUpRY8mELRS1o+u
 F1hMo4nm6bFfaJRyFyRdXSrXuBSY7eg=
X-Google-Smtp-Source: ACHHUZ7I6x1TbtXJyjrgoU+hvzswNB3Xmdh+2dPj+RUzr9b19OOF5mS9Ef2cxzP0RSmmJkpYNU2dBw==
X-Received: by 2002:a05:6808:198b:b0:398:55ff:1fb8 with SMTP id
 bj11-20020a056808198b00b0039855ff1fb8mr4735844oib.37.1685292584856; 
 Sun, 28 May 2023 09:49:44 -0700 (PDT)
Received: from grind.. (200-162-225-121.static-corp.ajato.com.br.
 [200.162.225.121]) by smtp.gmail.com with ESMTPSA id
 w4-20020a4adec4000000b0054f85f67f31sm3378830oou.46.2023.05.28.09.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 May 2023 09:49:44 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PULL 04/10] spapr: Add SPAPR_CAP_AIL_MODE_3 for AIL mode 3 support
 for H_SET_MODE hcall
Date: Sun, 28 May 2023 13:49:16 -0300
Message-Id: <20230528164922.20364-5-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528164922.20364-1-danielhb413@gmail.com>
References: <20230528164922.20364-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x234.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

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
Message-Id: <20230515160216.394612-1-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr.c         |  7 +++++++
 hw/ppc/spapr_caps.c    | 37 +++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_hcall.c   | 24 +++++++++++++-----------
 include/hw/ppc/spapr.h |  4 +++-
 target/ppc/kvm.c       |  7 +++++++
 target/ppc/kvm_ppc.h   |  6 ++++++
 6 files changed, 73 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1baea16c96..b623e23d6c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4673,6 +4673,13 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_FWNMI] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_RPT_INVALIDATE] = SPAPR_CAP_OFF;
+
+    /*
+     * This cap specifies whether the AIL 3 mode for
+     * H_SET_RESOURCE is supported. The default is modified
+     * by default_caps_with_cpu().
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


