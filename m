Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FA48CDD27
	for <lists+qemu-devel@lfdr.de>; Fri, 24 May 2024 01:09:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHXb-00078p-DU; Thu, 23 May 2024 19:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHXa-00078T-8D; Thu, 23 May 2024 19:08:06 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHXX-0005co-Lj; Thu, 23 May 2024 19:08:05 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6f8e819cf60so312970b3a.0; 
 Thu, 23 May 2024 16:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505681; x=1717110481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F0Reas+/j69JpzteqxlAf90kLbLyZsrf22vrkTo6CI4=;
 b=i2kxQ6t5ZHe/74iV4423fbBFwzbZb3c9oIo+ihHKqGSLCb3v4ZAEvSf0a9VJ/jqeNU
 lEr6P2WZiju/KvUSyVzJDnGmHjCnVr99memck2uJz31MC7lfIkynrj0qWtooJsqk8jGe
 ahARwe+7NhrZgUHm5II+96u0F3YPdI4a7spsQ4qFKweUKwq+axjVIHnPpU3SsgMvud70
 l4/9z0tDV83uHmaxYjTeB2CI3EQNdedMvsNNHJJTEDYrkyLt/+c8RnInPyrJO1qVHYsx
 TIDxlodCcHkCxcHeMfSpdrHrqh2BqZUKNYAQPd34wyu7xaDeJBhqUMm9/ruI0R0dbBtY
 3QIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505681; x=1717110481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F0Reas+/j69JpzteqxlAf90kLbLyZsrf22vrkTo6CI4=;
 b=PK8a9xM6S0JF36wkqMklyFuOLE11AUAi/zuKFc9ceZ+oa5+Ur6PC/nLO3t0L3a6shh
 YKakrU+97VPAsb9oy3MZiQCJKu6a4grAnaa5nySNDjWbpG2zC5qI8vJeesNHFDisJhX4
 HrEfYFHM1oQRirSfZUFtdBPzzdv9zR758JjD1OyfhVjwWuoQPY3FY7Rd55pqRiPR9ssK
 KQ37fEYVS6B6YvOqOOc2YJCnnEph0jbQoNf7mVkICivTekJiodFgHwE0rUAbYgfFbqUf
 mfAXRUk7lhJYYLpeU7fMDARn3WZwZY3GR7tmJveKj/MFBfkD9MbmnGwQasw5al9IFafh
 OIJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWYp1YZs6liAcH23abhiRBSY+zFIbGzLmOg+6QcAd9KdOfhPvQmlstetVJB4eY+bq+i8S15scNu1ztAIeoIn831w67
X-Gm-Message-State: AOJu0YxD+AG9VY7FhRXnailhvVIWEpcIeCqteScIiaJI9KndFKHLauo9
 lXCOQqDVD4mzUxARiUdReNVcJa2t7CTgXyeNwceU1QfnCzXfWd3mZO7WDw==
X-Google-Smtp-Source: AGHT+IEBG+T57MNonlgbSBlI30VYMqKo0fXbqR9gG1esKPsu+RcLxKb7TeDjtsLn2xbMANSY7nbvyw==
X-Received: by 2002:a05:6a20:a106:b0:1af:dae8:5ea2 with SMTP id
 adf61e73a8af0-1b212df06bcmr1293131637.48.1716505681122; 
 Thu, 23 May 2024 16:08:01 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:08:00 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 01/72] spapr: avoid overhead of finding vhyp class in critical
 operations
Date: Fri, 24 May 2024 09:06:34 +1000
Message-ID: <20240523230747.45703-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

PPC_VIRTUAL_HYPERVISOR_GET_CLASS is used in critical operations like
interrupts and TLB misses and is quite costly. Running the
kvm-unit-tests sieve program with radix MMU enabled thrashes the TCG
TLB and spends a lot of time in TLB and page table walking code. The
test takes 67 seconds to complete with a lot of time being spent in
code related to finding the vhyp class:

   12.01%  [.] g_str_hash
    8.94%  [.] g_hash_table_lookup
    8.06%  [.] object_class_dynamic_cast
    6.21%  [.] address_space_ldq
    4.94%  [.] __strcmp_avx2
    4.28%  [.] tlb_set_page_full
    4.08%  [.] address_space_translate_internal
    3.17%  [.] object_class_dynamic_cast_assert
    2.84%  [.] ppc_radix64_xlate

Keep a pointer to the class and avoid this lookup. This reduces the
execution time to 40 seconds.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pegasos2.c          |  1 +
 target/ppc/cpu.h           |  3 ++-
 target/ppc/cpu_init.c      |  9 +++------
 target/ppc/excp_helper.c   | 16 ++++------------
 target/ppc/kvm.c           |  4 +---
 target/ppc/mmu-book3s-v3.h |  4 +---
 target/ppc/mmu-hash64.c    | 16 ++++------------
 target/ppc/mmu-radix64.c   |  4 +---
 8 files changed, 17 insertions(+), 40 deletions(-)

diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 04d6decb2b..c22e8b336d 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -400,6 +400,7 @@ static void pegasos2_machine_reset(MachineState *machine, ShutdownCause reason)
     machine->fdt = fdt;
 
     pm->cpu->vhyp = PPC_VIRTUAL_HYPERVISOR(machine);
+    pm->cpu->vhyp_class = PPC_VIRTUAL_HYPERVISOR_GET_CLASS(pm->cpu->vhyp);
 }
 
 enum pegasos2_rtas_tokens {
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 0ac55d6b25..a5f46d0b10 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1435,6 +1435,7 @@ struct ArchCPU {
     int vcpu_id;
     uint32_t compat_pvr;
     PPCVirtualHypervisor *vhyp;
+    PPCVirtualHypervisorClass *vhyp_class;
     void *machine_data;
     int32_t node_id; /* NUMA node this CPU belongs to */
     PPCHash64Options *hash64_opts;
@@ -1532,7 +1533,7 @@ DECLARE_OBJ_CHECKERS(PPCVirtualHypervisor, PPCVirtualHypervisorClass,
 
 static inline bool vhyp_cpu_in_nested(PowerPCCPU *cpu)
 {
-    return PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp)->cpu_in_nested(cpu);
+    return cpu->vhyp_class->cpu_in_nested(cpu);
 }
 #endif /* CONFIG_USER_ONLY */
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index c11a69fd90..914c6e0f18 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6661,6 +6661,7 @@ void cpu_ppc_set_vhyp(PowerPCCPU *cpu, PPCVirtualHypervisor *vhyp)
     CPUPPCState *env = &cpu->env;
 
     cpu->vhyp = vhyp;
+    cpu->vhyp_class = PPC_VIRTUAL_HYPERVISOR_GET_CLASS(vhyp);
 
     /*
      * With a virtual hypervisor mode we never allow the CPU to go
@@ -7248,9 +7249,7 @@ static void ppc_cpu_exec_enter(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
 
     if (cpu->vhyp) {
-        PPCVirtualHypervisorClass *vhc =
-            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-        vhc->cpu_exec_enter(cpu->vhyp, cpu);
+        cpu->vhyp_class->cpu_exec_enter(cpu->vhyp, cpu);
     }
 }
 
@@ -7259,9 +7258,7 @@ static void ppc_cpu_exec_exit(CPUState *cs)
     PowerPCCPU *cpu = POWERPC_CPU(cs);
 
     if (cpu->vhyp) {
-        PPCVirtualHypervisorClass *vhc =
-            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-        vhc->cpu_exec_exit(cpu->vhyp, cpu);
+        cpu->vhyp_class->cpu_exec_exit(cpu->vhyp, cpu);
     }
 }
 #endif /* CONFIG_TCG */
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 0712098cf7..9df17f93bf 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -794,9 +794,7 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int excp)
          * HV mode, we need to keep hypercall support.
          */
         if (lev == 1 && cpu->vhyp) {
-            PPCVirtualHypervisorClass *vhc =
-                PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-            vhc->hypercall(cpu->vhyp, cpu);
+            cpu->vhyp_class->hypercall(cpu->vhyp, cpu);
             powerpc_reset_excp_state(cpu);
             return;
         }
@@ -946,9 +944,7 @@ static void powerpc_excp_74xx(PowerPCCPU *cpu, int excp)
          * HV mode, we need to keep hypercall support.
          */
         if (lev == 1 && cpu->vhyp) {
-            PPCVirtualHypervisorClass *vhc =
-                PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-            vhc->hypercall(cpu->vhyp, cpu);
+            cpu->vhyp_class->hypercall(cpu->vhyp, cpu);
             powerpc_reset_excp_state(cpu);
             return;
         }
@@ -1437,9 +1433,7 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 
         /* "PAPR mode" built-in hypercall emulation */
         if (lev == 1 && books_vhyp_handles_hcall(cpu)) {
-            PPCVirtualHypervisorClass *vhc =
-                PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-            vhc->hypercall(cpu->vhyp, cpu);
+            cpu->vhyp_class->hypercall(cpu->vhyp, cpu);
             powerpc_reset_excp_state(cpu);
             return;
         }
@@ -1574,10 +1568,8 @@ static void powerpc_excp_books(PowerPCCPU *cpu, int excp)
     }
 
     if ((new_msr & MSR_HVB) && books_vhyp_handles_hv_excp(cpu)) {
-        PPCVirtualHypervisorClass *vhc =
-            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
         /* Deliver interrupt to L1 by returning from the H_ENTER_NESTED call */
-        vhc->deliver_hv_excp(cpu, excp);
+        cpu->vhyp_class->deliver_hv_excp(cpu, excp);
         powerpc_reset_excp_state(cpu);
     } else {
         /* Sanity check */
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 46fccff786..005f2239f3 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -865,9 +865,7 @@ int kvmppc_put_books_sregs(PowerPCCPU *cpu)
     sregs.pvr = env->spr[SPR_PVR];
 
     if (cpu->vhyp) {
-        PPCVirtualHypervisorClass *vhc =
-            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-        sregs.u.s.sdr1 = vhc->encode_hpt_for_kvm_pr(cpu->vhyp);
+        sregs.u.s.sdr1 = cpu->vhyp_class->encode_hpt_for_kvm_pr(cpu->vhyp);
     } else {
         sregs.u.s.sdr1 = env->spr[SPR_SDR1];
     }
diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
index 674377a19e..f3f7993958 100644
--- a/target/ppc/mmu-book3s-v3.h
+++ b/target/ppc/mmu-book3s-v3.h
@@ -108,9 +108,7 @@ static inline hwaddr ppc_hash64_hpt_mask(PowerPCCPU *cpu)
     uint64_t base;
 
     if (cpu->vhyp) {
-        PPCVirtualHypervisorClass *vhc =
-            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-        return vhc->hpt_mask(cpu->vhyp);
+        return cpu->vhyp_class->hpt_mask(cpu->vhyp);
     }
     if (cpu->env.mmu_model == POWERPC_MMU_3_00) {
         ppc_v3_pate_t pate;
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 0966422a55..accbf0b2d8 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -517,9 +517,7 @@ const ppc_hash_pte64_t *ppc_hash64_map_hptes(PowerPCCPU *cpu,
     const ppc_hash_pte64_t *hptes;
 
     if (cpu->vhyp) {
-        PPCVirtualHypervisorClass *vhc =
-            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-        return vhc->map_hptes(cpu->vhyp, ptex, n);
+        return cpu->vhyp_class->map_hptes(cpu->vhyp, ptex, n);
     }
     base = ppc_hash64_hpt_base(cpu);
 
@@ -539,9 +537,7 @@ void ppc_hash64_unmap_hptes(PowerPCCPU *cpu, const ppc_hash_pte64_t *hptes,
                             hwaddr ptex, int n)
 {
     if (cpu->vhyp) {
-        PPCVirtualHypervisorClass *vhc =
-            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-        vhc->unmap_hptes(cpu->vhyp, hptes, ptex, n);
+        cpu->vhyp_class->unmap_hptes(cpu->vhyp, hptes, ptex, n);
         return;
     }
 
@@ -821,9 +817,7 @@ static void ppc_hash64_set_r(PowerPCCPU *cpu, hwaddr ptex, uint64_t pte1)
     hwaddr base, offset = ptex * HASH_PTE_SIZE_64 + HPTE64_DW1_R;
 
     if (cpu->vhyp) {
-        PPCVirtualHypervisorClass *vhc =
-            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-        vhc->hpte_set_r(cpu->vhyp, ptex, pte1);
+        cpu->vhyp_class->hpte_set_r(cpu->vhyp, ptex, pte1);
         return;
     }
     base = ppc_hash64_hpt_base(cpu);
@@ -838,9 +832,7 @@ static void ppc_hash64_set_c(PowerPCCPU *cpu, hwaddr ptex, uint64_t pte1)
     hwaddr base, offset = ptex * HASH_PTE_SIZE_64 + HPTE64_DW1_C;
 
     if (cpu->vhyp) {
-        PPCVirtualHypervisorClass *vhc =
-            PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-        vhc->hpte_set_c(cpu->vhyp, ptex, pte1);
+        cpu->vhyp_class->hpte_set_c(cpu->vhyp, ptex, pte1);
         return;
     }
     base = ppc_hash64_hpt_base(cpu);
diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 8daf71d2db..fefa55a5f1 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -678,9 +678,7 @@ static bool ppc_radix64_xlate_impl(PowerPCCPU *cpu, vaddr eaddr,
 
     /* Get Partition Table */
     if (cpu->vhyp) {
-        PPCVirtualHypervisorClass *vhc;
-        vhc = PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
-        if (!vhc->get_pate(cpu->vhyp, cpu, lpid, &pate)) {
+        if (!cpu->vhyp_class->get_pate(cpu->vhyp, cpu, lpid, &pate)) {
             if (guest_visible) {
                 ppc_radix64_raise_hsi(cpu, access_type, eaddr, eaddr,
                                       DSISR_R_BADCONFIG);
-- 
2.43.0


