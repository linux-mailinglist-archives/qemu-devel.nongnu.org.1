Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B3893CB64
	for <lists+qemu-devel@lfdr.de>; Fri, 26 Jul 2024 01:49:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Ah-0001C6-30; Thu, 25 Jul 2024 19:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8AY-0000gy-W4
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:47 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8AW-0005Ng-V0
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:46 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7037a208ff5so283185a34.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 16:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721951203; x=1722556003;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TEfM6wszBxNOPAb1bi7YlYVEQlyhfpgNlHnmktCCwL8=;
 b=SUIOkEDPizHl2dbSdTdHKlIahuk9p2CvLaiVy/nTO4ELIGjlMGT+9wu869OAD5nc0s
 utqpmUgOy09J8Ih94GyjeHPsuB0Haemj4WaZCqLThS2FzV9TEPlUL/V8Brr9oqWVTokH
 XuPQccVYSHbF0CEeBA2xHaHlrHD+51A39CT2TJz2IjXJ9o1xvG6Va65En3Vygk8jCj+j
 bgGqZDVcFyoUT42rFN3uzJVlhxyynMCxeq4BTujDQ+apg4pmy5QIIKSRBe8gUWA3HmCr
 hAqvjM5+uxF57yJoGZNzCxpoFJE3QeIK3ynDbqSs0mPA/oVOk0q0b5QOFr8LYSvZQXg2
 S4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951203; x=1722556003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TEfM6wszBxNOPAb1bi7YlYVEQlyhfpgNlHnmktCCwL8=;
 b=xCK+yEI+RtwrYWmwc8XmKXBH8SGoanBZbwukLGxU7FouKN+f38yzTIjstsMmQWYpZJ
 fEa5iwDyjAz8kzcUupVyIqc1YSS7VHiozco7I7weaw+lteAyqBmBpCZyPP5UwnWGHhxa
 C1t3l4U8BW2b51zI7LiHKUMJuCtuyFpRvVq/Y5sNr0wvGRvGXe7nTOtyyofEKJ79vp/+
 nz4JaRxcyOcUTotIBsIWyz0p3NwV6jPDQPTxYySUDxAuv7Z9c9eA3NszqHUdF+vET5D/
 HozC+Fbyzc89STqR9lCfWtpXkFOa/BFDuz3i1HAe1UBKkSKBlL6hsUXhmkzznRou9UAZ
 oM/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2DhBVJDiGFTx1uoet/4xJ8t9vG8tcw2Vrqiurgxv7oIfUToFWg4/vrfSLKtEuWrLMQ8OSJ6toTMx9AfepU2CWiS8F/yg=
X-Gm-Message-State: AOJu0YwznaAxAxrK4C+eT22u7rJ/HIZkkL6KrE/D/mmA+wrrpy6zVOqg
 d9G1/KHw4J/CwZEuMTEFQ2OhHqEwCVfYTHfXynTsMvnvOqrwWy4EDP8uTo9QK9o=
X-Google-Smtp-Source: AGHT+IHjwr/fPfQtXZbxxrHongzM3Re79h+jtXNWHsMnsG/iH9n4njrPYNsFuc6evFSGjGbocGurZQ==
X-Received: by 2002:a05:6830:6489:b0:708:29dc:d2fc with SMTP id
 46e09a7af769-7093223d028mr4086777a34.19.1721951203243; 
 Thu, 25 Jul 2024 16:46:43 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead8128d0sm1647565b3a.118.2024.07.25.16.46.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:46:42 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH 15/24] target/riscv: mmu changes for zicfiss shadow stack
 protection
Date: Thu, 25 Jul 2024 16:46:04 -0700
Message-ID: <20240725234614.3850142-16-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240725234614.3850142-1-debug@rivosinc.com>
References: <20240725234614.3850142-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=debug@rivosinc.com; helo=mail-ot1-x32b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

zicfiss protects shadow stack using new page table encodings PTE.W=0,
PTE.R=0 and PTE.X=0. This encoding is reserved if zicfiss is not
implemented or if shadow stack are not enabled.
Loads on shadow stack memory are allowed while stores to shadow stack
memory leads to access faults. Shadow stack accesses to RO memory
leads to store page fault.

To implement special nature of shadow stack memory where only selected
stores (shadow stack stores from sspush) have to be allowed while rest
of regular stores disallowed, new MMU TLB index is created for shadow
stack.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 target/riscv/cpu_helper.c | 61 +++++++++++++++++++++++++++++++++++++--
 target/riscv/internals.h  |  3 ++
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index ce68f5af72..7942587a56 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -819,6 +819,18 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
     env->load_res = -1;
 }
 
+static bool legal_sstack_access(int access_type, bool sstack_inst,
+                                bool sstack_attribute)
+{
+    /*
+     * Read/write/execution permissions are checked as usual. Shadow
+     * stack enforcement is just that (1) instruction type must match
+     * the attribute unless (2) a non-SS load to an SS region.
+     */
+    return (sstack_inst == sstack_attribute) ||
+        ((access_type == MMU_DATA_LOAD) && sstack_attribute);
+}
+
 /*
  * get_physical_address_pmp - check PMP permission for this physical address
  *
@@ -896,6 +908,8 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
     hwaddr ppn;
     int napot_bits = 0;
     target_ulong napot_mask;
+    bool is_sstack_insn = ((mmu_idx & MMU_IDX_SS_ACCESS) == MMU_IDX_SS_ACCESS);
+    bool sstack_page = false;
 
     /*
      * Check if we should use the background registers for the two
@@ -1104,15 +1118,45 @@ restart:
         return TRANSLATE_FAIL;
     }
 
+    /*
+     * When backward CFI is enabled, the R=0, W=1, X=0 reserved encoding
+     * is used to mark Shadow Stack (SS) pages. If back CFI enabled, allow
+     * normal loads on SS pages, regular stores raise store access fault
+     * and avoid hitting the reserved-encoding case. Only shadow stack
+     * stores are allowed on SS pages. Shadow stack loads and stores on
+     * regular memory (non-SS) raise load and store/AMO access fault.
+     * Second stage translations don't participate in Shadow Stack.
+     */
+    sstack_page = (cpu_get_bcfien(env) && first_stage &&
+                  ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W));
+
     /* Check for reserved combinations of RWX flags. */
     switch (pte & (PTE_R | PTE_W | PTE_X)) {
-    case PTE_W:
     case PTE_W | PTE_X:
+    case PTE_W:
+        if (sstack_page) { /* if shadow stack page, PTE_W is not reserved */
+            break;
+        }
         return TRANSLATE_FAIL;
     }
 
+    /* Illegal combo of instruction type and page attribute */
+    if (!legal_sstack_access(access_type, is_sstack_insn,
+                            sstack_page)) {
+        /* shadow stack instruction and RO page then it's a page fault */
+        if (is_sstack_insn && ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_R)) {
+                return TRANSLATE_FAIL;
+        }
+        /* In all other cases it's an access fault, so raise PMP_FAIL */
+        return TRANSLATE_PMP_FAIL;
+    }
+
     int prot = 0;
-    if (pte & PTE_R) {
+    /*
+     * If PTE has read bit in it or it's shadow stack page,
+     * then reads allowed
+     */
+    if ((pte & PTE_R) || sstack_page) {
         prot |= PAGE_READ;
     }
     if (pte & PTE_W) {
@@ -1350,9 +1394,17 @@ void riscv_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
         break;
     case MMU_DATA_LOAD:
         cs->exception_index = RISCV_EXCP_LOAD_ADDR_MIS;
+        /* shadow stack mis aligned accesses are access faults */
+        if (mmu_idx & MMU_IDX_SS_ACCESS) {
+            cs->exception_index = RISCV_EXCP_LOAD_ACCESS_FAULT;
+        }
         break;
     case MMU_DATA_STORE:
         cs->exception_index = RISCV_EXCP_STORE_AMO_ADDR_MIS;
+        /* shadow stack mis aligned accesses are access faults */
+        if (mmu_idx & MMU_IDX_SS_ACCESS) {
+            cs->exception_index = RISCV_EXCP_STORE_AMO_ACCESS_FAULT;
+        }
         break;
     default:
         g_assert_not_reached();
@@ -1408,6 +1460,11 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
                   __func__, address, access_type, mmu_idx);
 
+    /* If shadow stack instruction initiated this access, treat it as store */
+    if (mmu_idx & MMU_IDX_SS_ACCESS) {
+        access_type = MMU_DATA_STORE;
+    }
+
     pmu_tlb_fill_incr_ctr(cpu, access_type);
     if (two_stage_lookup) {
         /* Two stage lookup */
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 0ac17bc5ad..dad0657c80 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -30,12 +30,15 @@
  *  - U+2STAGE          0b100
  *  - S+2STAGE          0b101
  *  - S+SUM+2STAGE      0b110
+ *  - Shadow stack+U   0b1000
+ *  - Shadow stack+S   0b1001
  */
 #define MMUIdx_U            0
 #define MMUIdx_S            1
 #define MMUIdx_S_SUM        2
 #define MMUIdx_M            3
 #define MMU_2STAGE_BIT      (1 << 2)
+#define MMU_IDX_SS_ACCESS   (1 << 3)
 
 static inline int mmuidx_priv(int mmu_idx)
 {
-- 
2.44.0


