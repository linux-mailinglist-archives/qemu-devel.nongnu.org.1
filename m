Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F84EB3CE0A
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Aug 2025 19:20:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usOCW-0001fw-C7; Sat, 30 Aug 2025 12:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQE-00079A-9P
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:46:45 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEQB-0004o2-OE
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:46:42 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-327f95f750eso1006640a91.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532798; x=1757137598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IFBxZh+1HwniGEdeDDe31vYX1uAIGDH5PT40d1IKpIM=;
 b=zFf2rbcwBYD74V6rupsquDqmtgN/suFQyZddg1dC7EJQUyhI3QIp0l/Yhdl4gP8CHs
 IYp8LqO3weLTN9K6CmPPH/PZ/wfNaUM8xOyLZ5RElUBzm+r3JeABZJ9vzK3l+yH4BbnM
 ukck++Q0z0T/qQFSK384IbRzkYCY9rI4d+aq8hHqmwwxPbVifRQr0JPJAPmJUdeKFtUF
 BMjSC4GyXzRJbopL5wOm0Rfw4Eq3wVz+Jf8rcgATVMdhOHG6I9yyecPACmTTXuWDbtRB
 G4x28Dkj4IM4OGeUpjejTyP15aewLXRh0j4ICkuV5Wx+sTkx52ZbKJ6zcfIZNlagHpFY
 4leA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532798; x=1757137598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IFBxZh+1HwniGEdeDDe31vYX1uAIGDH5PT40d1IKpIM=;
 b=CPwBYrxKqe61V3J3o+rsD1p/+S38Pj1k+j+DYeckw69Tbh6XLKpw5hdO5i1N5qwSF9
 y3iXxyn64ay6UKoNi0YN5YCAZbBTe60GoX0HNfk00TUMT/wv6zqolqDmdJpMsODblAMt
 bXPyzhY75pdOeH20GiGBPEy/R6BbWSxZXTGO0pQKnktETuYPWQdBZVAb0QLCzcwNOS6E
 WFo29PIlhM0r+X+Q01V3PR8cMS645AKqo+h6N1MgcuhSljoXETDdX0X+UEJVTFhISSUt
 SgGVHGJ41jocr1i6x6MsuvWQyVThZu+e5bgju0e3+ogNbASfUJya74Z0M471g1SO8ufm
 qIxg==
X-Gm-Message-State: AOJu0Yx/X/iJpGbV8nouK3SgNH6TTg/o5Gs+WCltYPWTQPORH3u+Fhf4
 N8t6+RI9YJJSbHLLapUmVFCz68CgUJZk3iUDmtTt6Mu8IGjIFa/Pp1odCkiEIpsWxkpXcV16FYu
 gX38L8B4=
X-Gm-Gg: ASbGncurW4/r1M7lIh51mksUxCNVavA5flWOOwP+DTXqnGJzDm7aGkgVF5b60gR54bf
 7AuXGOAANrXY+dSFAAagJrmvIgdyZew3Yds5TBtFWOiZM9RcGVhRqCNyuixqHF8PKPWhWL4n2zd
 IWgel3rSwzk124rTqoNlHQZTfiL2oLuLVpCSkQAv0YanMSM1fBgK5RsiwLHAPXdk3dKb3Gy+sko
 c+fi28HCHrMUpb3T57C/DBztJ92fCEQp1wDDNquUCbU259jsIHXFqaGXWwHwzmxe/fNsBvN2c2+
 bJWTE4+y1nWl01/hnaf+9qAnuwjQOQ7pJn0jnxN7cPIVac/6Pj1Kf3k3M1LxwSPLM/Gm56GEyuE
 dFhnrk3BSzb0jgQ4p0/kI2O8AVKDeft5NFcwoJtDYjomT3j9Rolgz9fbwLY6KDCQjblP3qxhaPA
 ==
X-Google-Smtp-Source: AGHT+IFQZwgqR34jpNh2rfPggxVygGyNxYEMOrPfB3nRCMZRAPW9J6ubilEjfhoFTp1ZaGCVxt9vww==
X-Received: by 2002:a17:903:1ac6:b0:240:83af:e2e0 with SMTP id
 d9443c01a7336-24944ae7beemr11255005ad.47.1756532798280; 
 Fri, 29 Aug 2025 22:46:38 -0700 (PDT)
Received: from stoup.. (122-150-204-179.dyn.ip.vocus.au. [122.150.204.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2490658999fsm40852715ad.112.2025.08.29.22.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:46:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 43/84] target/arm: Introduce mmu indexes for GCS
Date: Sat, 30 Aug 2025 15:40:47 +1000
Message-ID: <20250830054128.448363-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/core/cpu.h        |  5 ++-
 target/arm/mmuidx-internal.h |  8 ++++
 target/arm/mmuidx.h          | 71 ++++++++++++++++++++++++------------
 target/arm/helper.c          | 15 ++++++--
 target/arm/mmuidx.c          |  9 +++++
 target/arm/ptw.c             | 20 ++++++++++
 target/arm/tcg/tlb-insns.c   | 47 ++++++++++++++++--------
 7 files changed, 132 insertions(+), 43 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index fc9a2291d5..671c4bc6bb 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -198,9 +198,10 @@ struct CPUClass {
 };
 
 /*
- * Fix the number of mmu modes to 16.
+ * Fix the number of mmu modes across all targets.
+ * Current maximum is target/arm/.
  */
-#define NB_MMU_MODES 16
+#define NB_MMU_MODES 22
 typedef uint32_t MMUIdxMap;
 
 /* Use a fully associative victim tlb of 8 entries. */
diff --git a/target/arm/mmuidx-internal.h b/target/arm/mmuidx-internal.h
index 1d948aa6f4..f494ec348d 100644
--- a/target/arm/mmuidx-internal.h
+++ b/target/arm/mmuidx-internal.h
@@ -20,6 +20,7 @@ FIELD(MMUIDXINFO, PAN, 7, 1)
 FIELD(MMUIDXINFO, USER, 8, 1)
 FIELD(MMUIDXINFO, STAGE1, 9, 1)
 FIELD(MMUIDXINFO, STAGE2, 10, 1)
+FIELD(MMUIDXINFO, GCS, 11, 1)
 
 extern const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8];
 
@@ -92,4 +93,11 @@ static inline bool regime_is_stage2(ARMMMUIdx idx)
     return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, STAGE2);
 }
 
+/* Return true if this mmu index implies AccessType_GCS. */
+static inline bool regime_is_gcs(ARMMMUIdx idx)
+{
+    tcg_debug_assert(arm_mmuidx_is_valid(idx));
+    return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, GCS);
+}
+
 #endif /* TARGET_ARM_MMUIDX_INTERNAL_H */
diff --git a/target/arm/mmuidx.h b/target/arm/mmuidx.h
index 5b9b4bc84f..8d8d27337e 100644
--- a/target/arm/mmuidx.h
+++ b/target/arm/mmuidx.h
@@ -58,24 +58,31 @@
  *     already heavyweight.
  *  8. we cannot fold together Stage 2 Secure and Stage 2 NonSecure,
  *     because both are in use simultaneously for Secure EL2.
+ *  9. we need separate indexes for handling AccessType_GCS.
  *
  * This gives us the following list of cases:
  *
  * EL0 EL1&0 stage 1+2 (aka NS PL0 PL1&0 stage 1+2)
+ * EL0 EL1&0 stage 1+2 +GCS
  * EL1 EL1&0 stage 1+2 (aka NS PL1 PL1&0 stage 1+2)
  * EL1 EL1&0 stage 1+2 +PAN (aka NS PL1 P1&0 stage 1+2 +PAN)
+ * EL1 EL1&0 stage 1+2 +GCS
  * EL0 EL2&0
+ * EL0 EL2&0 +GCS
  * EL2 EL2&0
  * EL2 EL2&0 +PAN
+ * EL2 EL2&0 +GCS
  * EL2 (aka NS PL2)
+ * EL2 +GCS
  * EL3 (aka AArch32 S PL1 PL1&0)
+ * EL3 +GCS
  * AArch32 S PL0 PL1&0 (we call this EL30_0)
  * AArch32 S PL1 PL1&0 +PAN (we call this EL30_3_PAN)
  * Stage2 Secure
  * Stage2 NonSecure
  * plus one TLB per Physical address space: S, NS, Realm, Root
  *
- * for a total of 16 different mmu_idx.
+ * for a total of 22 different mmu_idx.
  *
  * R profile CPUs have an MPU, but can use the same set of MMU indexes
  * as A profile. They only need to distinguish EL0 and EL1 (and
@@ -114,9 +121,9 @@
  * For M profile we arrange them to have a bit for priv, a bit for negpri
  * and a bit for secure.
  */
-#define ARM_MMU_IDX_A     0x10  /* A profile */
-#define ARM_MMU_IDX_NOTLB 0x20  /* does not have a TLB */
-#define ARM_MMU_IDX_M     0x40  /* M profile */
+#define ARM_MMU_IDX_A     0x20  /* A profile */
+#define ARM_MMU_IDX_NOTLB 0x40  /* does not have a TLB */
+#define ARM_MMU_IDX_M     0x80  /* M profile */
 
 /* Meanings of the bits for M profile mmu idx values */
 #define ARM_MMU_IDX_M_PRIV   0x1
@@ -125,22 +132,32 @@
 
 #define ARM_MMU_IDX_TYPE_MASK \
     (ARM_MMU_IDX_A | ARM_MMU_IDX_M | ARM_MMU_IDX_NOTLB)
-#define ARM_MMU_IDX_COREIDX_MASK 0xf
+#define ARM_MMU_IDX_COREIDX_MASK 0x1f
 
 typedef enum ARMMMUIdx {
     /*
      * A-profile.
      */
-    ARMMMUIdx_E10_0     = 0 | ARM_MMU_IDX_A,
-    ARMMMUIdx_E20_0     = 1 | ARM_MMU_IDX_A,
-    ARMMMUIdx_E10_1     = 2 | ARM_MMU_IDX_A,
-    ARMMMUIdx_E20_2     = 3 | ARM_MMU_IDX_A,
-    ARMMMUIdx_E10_1_PAN = 4 | ARM_MMU_IDX_A,
-    ARMMMUIdx_E20_2_PAN = 5 | ARM_MMU_IDX_A,
-    ARMMMUIdx_E2        = 6 | ARM_MMU_IDX_A,
-    ARMMMUIdx_E3        = 7 | ARM_MMU_IDX_A,
-    ARMMMUIdx_E30_0     = 8 | ARM_MMU_IDX_A,
-    ARMMMUIdx_E30_3_PAN = 9 | ARM_MMU_IDX_A,
+
+    ARMMMUIdx_E10_0      = 0 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E10_0_GCS  = 1 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E10_1      = 2 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E10_1_PAN  = 3 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E10_1_GCS  = 4 | ARM_MMU_IDX_A,
+
+    ARMMMUIdx_E20_0      = 5 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E20_0_GCS  = 6 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E20_2      = 7 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E20_2_PAN  = 8 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E20_2_GCS  = 9 | ARM_MMU_IDX_A,
+
+    ARMMMUIdx_E2         = 10 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E2_GCS     = 11 | ARM_MMU_IDX_A,
+
+    ARMMMUIdx_E3         = 12 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E3_GCS     = 13 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E30_0      = 14 | ARM_MMU_IDX_A,
+    ARMMMUIdx_E30_3_PAN  = 15 | ARM_MMU_IDX_A,
 
     /*
      * Used for second stage of an S12 page table walk, or for descriptor
@@ -148,14 +165,14 @@ typedef enum ARMMMUIdx {
      * are in use simultaneously for SecureEL2: the security state for
      * the S2 ptw is selected by the NS bit from the S1 ptw.
      */
-    ARMMMUIdx_Stage2_S  = 10 | ARM_MMU_IDX_A,
-    ARMMMUIdx_Stage2    = 11 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Stage2_S   = 16 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Stage2     = 17 | ARM_MMU_IDX_A,
 
     /* TLBs with 1-1 mapping to the physical address spaces. */
-    ARMMMUIdx_Phys_S     = 12 | ARM_MMU_IDX_A,
-    ARMMMUIdx_Phys_NS    = 13 | ARM_MMU_IDX_A,
-    ARMMMUIdx_Phys_Root  = 14 | ARM_MMU_IDX_A,
-    ARMMMUIdx_Phys_Realm = 15 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Phys_S     = 18 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Phys_NS    = 19 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Phys_Root  = 20 | ARM_MMU_IDX_A,
+    ARMMMUIdx_Phys_Realm = 21 | ARM_MMU_IDX_A,
 
     /*
      * These are not allocated TLBs and are used only for AT system
@@ -164,6 +181,8 @@ typedef enum ARMMMUIdx {
     ARMMMUIdx_Stage1_E0 = 0 | ARM_MMU_IDX_NOTLB,
     ARMMMUIdx_Stage1_E1 = 1 | ARM_MMU_IDX_NOTLB,
     ARMMMUIdx_Stage1_E1_PAN = 2 | ARM_MMU_IDX_NOTLB,
+    ARMMMUIdx_Stage1_E0_GCS = 3 | ARM_MMU_IDX_NOTLB,
+    ARMMMUIdx_Stage1_E1_GCS = 4 | ARM_MMU_IDX_NOTLB,
 
     /*
      * M-profile.
@@ -187,13 +206,19 @@ typedef enum ARMMMUIdx {
 
 typedef enum ARMMMUIdxBit {
     TO_CORE_BIT(E10_0),
-    TO_CORE_BIT(E20_0),
+    TO_CORE_BIT(E10_0_GCS),
     TO_CORE_BIT(E10_1),
     TO_CORE_BIT(E10_1_PAN),
-    TO_CORE_BIT(E2),
+    TO_CORE_BIT(E10_1_GCS),
+    TO_CORE_BIT(E20_0),
+    TO_CORE_BIT(E20_0_GCS),
     TO_CORE_BIT(E20_2),
     TO_CORE_BIT(E20_2_PAN),
+    TO_CORE_BIT(E20_2_GCS),
+    TO_CORE_BIT(E2),
+    TO_CORE_BIT(E2_GCS),
     TO_CORE_BIT(E3),
+    TO_CORE_BIT(E3_GCS),
     TO_CORE_BIT(E30_0),
     TO_CORE_BIT(E30_3_PAN),
     TO_CORE_BIT(Stage2),
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4901fd5388..5e5d1499f1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -401,7 +401,9 @@ int alle1_tlbmask(CPUARMState *env)
      */
     return (ARMMMUIdxBit_E10_1 |
             ARMMMUIdxBit_E10_1_PAN |
+            ARMMMUIdxBit_E10_1_GCS |
             ARMMMUIdxBit_E10_0 |
+            ARMMMUIdxBit_E10_0_GCS |
             ARMMMUIdxBit_Stage2 |
             ARMMMUIdxBit_Stage2_S);
 }
@@ -785,12 +787,17 @@ static void scr_write(CPUARMState *env, const ARMCPRegInfo *ri, uint64_t value)
      */
     if (changed & (SCR_NS | SCR_NSE)) {
         tlb_flush_by_mmuidx(env_cpu(env), (ARMMMUIdxBit_E10_0 |
+                                           ARMMMUIdxBit_E10_0_GCS |
                                            ARMMMUIdxBit_E20_0 |
+                                           ARMMMUIdxBit_E20_0_GCS |
                                            ARMMMUIdxBit_E10_1 |
-                                           ARMMMUIdxBit_E20_2 |
                                            ARMMMUIdxBit_E10_1_PAN |
+                                           ARMMMUIdxBit_E10_1_GCS |
+                                           ARMMMUIdxBit_E20_2 |
                                            ARMMMUIdxBit_E20_2_PAN |
-                                           ARMMMUIdxBit_E2));
+                                           ARMMMUIdxBit_E20_2_GCS |
+                                           ARMMMUIdxBit_E2 |
+                                           ARMMMUIdxBit_E2_GCS));
     }
 }
 
@@ -2756,7 +2763,9 @@ static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
         (arm_hcr_el2_eff(env) & HCR_E2H)) {
         uint16_t mask = ARMMMUIdxBit_E20_2 |
                         ARMMMUIdxBit_E20_2_PAN |
-                        ARMMMUIdxBit_E20_0;
+                        ARMMMUIdxBit_E20_2_GCS |
+                        ARMMMUIdxBit_E20_0 |
+                        ARMMMUIdxBit_E20_0_GCS;
         tlb_flush_by_mmuidx(env_cpu(env), mask);
     }
     raw_write(env, ri, value);
diff --git a/target/arm/mmuidx.c b/target/arm/mmuidx.c
index 61a682e655..42b003db9c 100644
--- a/target/arm/mmuidx.c
+++ b/target/arm/mmuidx.c
@@ -15,22 +15,29 @@
 #define USER   R_MMUIDXINFO_USER_MASK
 #define S1     R_MMUIDXINFO_STAGE1_MASK
 #define S2     R_MMUIDXINFO_STAGE2_MASK
+#define GCS    R_MMUIDXINFO_GCS_MASK
 
 const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     /*
      * A-profile.
      */
     [ARMMMUIdx_E10_0]           = EL(0) | REL(1) | R2,
+    [ARMMMUIdx_E10_0_GCS]       = EL(0) | REL(1) | R2 | GCS,
     [ARMMMUIdx_E10_1]           = EL(1) | REL(1) | R2,
     [ARMMMUIdx_E10_1_PAN]       = EL(1) | REL(1) | R2 | PAN,
+    [ARMMMUIdx_E10_1_GCS]       = EL(1) | REL(1) | R2 | GCS,
 
     [ARMMMUIdx_E20_0]           = EL(0) | REL(2) | R2,
+    [ARMMMUIdx_E20_0_GCS]       = EL(0) | REL(2) | R2 | GCS,
     [ARMMMUIdx_E20_2]           = EL(2) | REL(2) | R2,
     [ARMMMUIdx_E20_2_PAN]       = EL(2) | REL(2) | R2 | PAN,
+    [ARMMMUIdx_E20_2_GCS]       = EL(2) | REL(2) | R2 | GCS,
 
     [ARMMMUIdx_E2]              = EL(2) | REL(2),
+    [ARMMMUIdx_E2_GCS]          = EL(2) | REL(2) | GCS,
 
     [ARMMMUIdx_E3]              = EL(3) | REL(3),
+    [ARMMMUIdx_E3_GCS]          = EL(3) | REL(3) | GCS,
     [ARMMMUIdx_E30_0]           = EL(0) | REL(3),
     [ARMMMUIdx_E30_3_PAN]       = EL(3) | REL(3) | PAN,
 
@@ -38,8 +45,10 @@ const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     [ARMMMUIdx_Stage2]          = REL(2) | S2,
 
     [ARMMMUIdx_Stage1_E0]       = REL(1) | R2 | S1 | USER,
+    [ARMMMUIdx_Stage1_E0_GCS]   = REL(1) | R2 | S1 | USER | GCS,
     [ARMMMUIdx_Stage1_E1]       = REL(1) | R2 | S1,
     [ARMMMUIdx_Stage1_E1_PAN]   = REL(1) | R2 | S1 | PAN,
+    [ARMMMUIdx_Stage1_E1_GCS]   = REL(1) | R2 | S1 | GCS,
 
     /*
      * M-profile.
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 23307b2760..ccdf9076c3 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -166,6 +166,10 @@ ARMMMUIdx stage_1_mmu_idx(ARMMMUIdx mmu_idx)
         return ARMMMUIdx_Stage1_E1;
     case ARMMMUIdx_E10_1_PAN:
         return ARMMMUIdx_Stage1_E1_PAN;
+    case ARMMMUIdx_E10_0_GCS:
+        return ARMMMUIdx_Stage1_E0_GCS;
+    case ARMMMUIdx_E10_1_GCS:
+        return ARMMMUIdx_Stage1_E1_GCS;
     default:
         return mmu_idx;
     }
@@ -273,8 +277,10 @@ static bool regime_translation_disabled(CPUARMState *env, ARMMMUIdx mmu_idx,
         return (hcr_el2 & (HCR_DC | HCR_VM)) == 0;
 
     case ARMMMUIdx_E10_0:
+    case ARMMMUIdx_E10_0_GCS:
     case ARMMMUIdx_E10_1:
     case ARMMMUIdx_E10_1_PAN:
+    case ARMMMUIdx_E10_1_GCS:
         /* TGE means that EL0/1 act as if SCTLR_EL1.M is zero */
         hcr_el2 = arm_hcr_el2_eff_secstate(env, space);
         if (hcr_el2 & HCR_TGE) {
@@ -283,8 +289,10 @@ static bool regime_translation_disabled(CPUARMState *env, ARMMMUIdx mmu_idx,
         break;
 
     case ARMMMUIdx_Stage1_E0:
+    case ARMMMUIdx_Stage1_E0_GCS:
     case ARMMMUIdx_Stage1_E1:
     case ARMMMUIdx_Stage1_E1_PAN:
+    case ARMMMUIdx_Stage1_E1_GCS:
         /* HCR.DC means SCTLR_EL1.M behaves as 0 */
         hcr_el2 = arm_hcr_el2_eff_secstate(env, space);
         if (hcr_el2 & HCR_DC) {
@@ -293,10 +301,14 @@ static bool regime_translation_disabled(CPUARMState *env, ARMMMUIdx mmu_idx,
         break;
 
     case ARMMMUIdx_E20_0:
+    case ARMMMUIdx_E20_0_GCS:
     case ARMMMUIdx_E20_2:
     case ARMMMUIdx_E20_2_PAN:
+    case ARMMMUIdx_E20_2_GCS:
     case ARMMMUIdx_E2:
+    case ARMMMUIdx_E2_GCS:
     case ARMMMUIdx_E3:
+    case ARMMMUIdx_E3_GCS:
     case ARMMMUIdx_E30_0:
     case ARMMMUIdx_E30_3_PAN:
         break;
@@ -3761,15 +3773,22 @@ arm_mmu_idx_to_security_space(CPUARMState *env, ARMMMUIdx mmu_idx)
 
     switch (mmu_idx) {
     case ARMMMUIdx_E10_0:
+    case ARMMMUIdx_E10_0_GCS:
     case ARMMMUIdx_E10_1:
     case ARMMMUIdx_E10_1_PAN:
+    case ARMMMUIdx_E10_1_GCS:
     case ARMMMUIdx_E20_0:
+    case ARMMMUIdx_E20_0_GCS:
     case ARMMMUIdx_E20_2:
     case ARMMMUIdx_E20_2_PAN:
+    case ARMMMUIdx_E20_2_GCS:
     case ARMMMUIdx_Stage1_E0:
+    case ARMMMUIdx_Stage1_E0_GCS:
     case ARMMMUIdx_Stage1_E1:
     case ARMMMUIdx_Stage1_E1_PAN:
+    case ARMMMUIdx_Stage1_E1_GCS:
     case ARMMMUIdx_E2:
+    case ARMMMUIdx_E2_GCS:
         ss = arm_security_space_below_el3(env);
         break;
     case ARMMMUIdx_Stage2:
@@ -3798,6 +3817,7 @@ arm_mmu_idx_to_security_space(CPUARMState *env, ARMMMUIdx mmu_idx)
         ss = ARMSS_Secure;
         break;
     case ARMMMUIdx_E3:
+    case ARMMMUIdx_E3_GCS:
     case ARMMMUIdx_E30_0:
     case ARMMMUIdx_E30_3_PAN:
         if (arm_feature(env, ARM_FEATURE_AARCH64) &&
diff --git a/target/arm/tcg/tlb-insns.c b/target/arm/tcg/tlb-insns.c
index 95c26c6d46..1a0a332583 100644
--- a/target/arm/tcg/tlb-insns.c
+++ b/target/arm/tcg/tlb-insns.c
@@ -149,7 +149,8 @@ static void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = env_cpu(env);
     uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_E2);
+    tlb_flush_page_by_mmuidx(cs, pageaddr,
+                             ARMMMUIdxBit_E2 | ARMMMUIdxBit_E2_GCS);
 }
 
 static void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -159,7 +160,8 @@ static void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
 
     tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                             ARMMMUIdxBit_E2);
+                                             ARMMMUIdxBit_E2 |
+                                             ARMMMUIdxBit_E2_GCS);
 }
 
 static void tlbiipas2_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -202,7 +204,7 @@ static void tlbiall_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     CPUState *cs = env_cpu(env);
 
-    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_E2);
+    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_E2 | ARMMMUIdxBit_E2_GCS);
 }
 
 static void tlbiall_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -210,7 +212,8 @@ static void tlbiall_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     CPUState *cs = env_cpu(env);
 
-    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E2);
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E2 |
+                                            ARMMMUIdxBit_E2_GCS);
 }
 
 /*
@@ -228,12 +231,16 @@ static int vae1_tlbmask(CPUARMState *env)
     if ((hcr & (HCR_E2H | HCR_TGE)) == (HCR_E2H | HCR_TGE)) {
         mask = ARMMMUIdxBit_E20_2 |
                ARMMMUIdxBit_E20_2_PAN |
-               ARMMMUIdxBit_E20_0;
+               ARMMMUIdxBit_E20_2_GCS |
+               ARMMMUIdxBit_E20_0 |
+               ARMMMUIdxBit_E20_0_GCS;
     } else {
         /* This is AArch64 only, so we don't need to touch the EL30_x TLBs */
         mask = ARMMMUIdxBit_E10_1 |
                ARMMMUIdxBit_E10_1_PAN |
-               ARMMMUIdxBit_E10_0;
+               ARMMMUIdxBit_E10_1_GCS |
+               ARMMMUIdxBit_E10_0 |
+               ARMMMUIdxBit_E10_0_GCS;
     }
     return mask;
 }
@@ -246,13 +253,20 @@ static int vae2_tlbmask(CPUARMState *env)
     if (hcr & HCR_E2H) {
         mask = ARMMMUIdxBit_E20_2 |
                ARMMMUIdxBit_E20_2_PAN |
-               ARMMMUIdxBit_E20_0;
+               ARMMMUIdxBit_E20_2_GCS |
+               ARMMMUIdxBit_E20_0 |
+               ARMMMUIdxBit_E20_0_GCS;
     } else {
-        mask = ARMMMUIdxBit_E2;
+        mask = ARMMMUIdxBit_E2 | ARMMMUIdxBit_E2_GCS;
     }
     return mask;
 }
 
+static int vae3_tlbmask(void)
+{
+    return ARMMMUIdxBit_E3 | ARMMMUIdxBit_E3_GCS;
+}
+
 /* Return 56 if TBI is enabled, 64 otherwise. */
 static int tlbbits_for_regime(CPUARMState *env, ARMMMUIdx mmu_idx,
                        uint64_t addr)
@@ -325,9 +339,12 @@ static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static int e2_tlbmask(CPUARMState *env)
 {
     return (ARMMMUIdxBit_E20_0 |
+            ARMMMUIdxBit_E20_0_GCS |
             ARMMMUIdxBit_E20_2 |
             ARMMMUIdxBit_E20_2_PAN |
-            ARMMMUIdxBit_E2);
+            ARMMMUIdxBit_E20_2_GCS |
+            ARMMMUIdxBit_E2 |
+            ARMMMUIdxBit_E2_GCS);
 }
 
 static void tlbi_aa64_alle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -354,7 +371,7 @@ static void tlbi_aa64_alle3_write(CPUARMState *env, const ARMCPRegInfo *ri,
     ARMCPU *cpu = env_archcpu(env);
     CPUState *cs = CPU(cpu);
 
-    tlb_flush_by_mmuidx(cs, ARMMMUIdxBit_E3);
+    tlb_flush_by_mmuidx(cs, vae3_tlbmask());
 }
 
 static void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -380,7 +397,7 @@ static void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     CPUState *cs = env_cpu(env);
 
-    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUIdxBit_E3);
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, vae3_tlbmask());
 }
 
 static void tlbi_aa64_vae2_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -411,7 +428,7 @@ static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
     CPUState *cs = CPU(cpu);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
-    tlb_flush_page_by_mmuidx(cs, pageaddr, ARMMMUIdxBit_E3);
+    tlb_flush_page_by_mmuidx(cs, pageaddr, vae3_tlbmask());
 }
 
 static void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -465,7 +482,7 @@ static void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
     int bits = tlbbits_for_regime(env, ARMMMUIdx_E3, pageaddr);
 
     tlb_flush_page_bits_by_mmuidx_all_cpus_synced(cs, pageaddr,
-                                                  ARMMMUIdxBit_E3, bits);
+                                                  vae3_tlbmask(), bits);
 }
 
 static int ipas2e1_tlbmask(CPUARMState *env, int64_t value)
@@ -963,7 +980,7 @@ static void tlbi_aa64_rvae3_write(CPUARMState *env,
      * flush-last-level-only.
      */
 
-    do_rvae_write(env, value, ARMMMUIdxBit_E3, tlb_force_broadcast(env));
+    do_rvae_write(env, value, vae3_tlbmask(), tlb_force_broadcast(env));
 }
 
 static void tlbi_aa64_rvae3is_write(CPUARMState *env,
@@ -977,7 +994,7 @@ static void tlbi_aa64_rvae3is_write(CPUARMState *env,
      * flush-last-level-only or inner/outer specific flushes.
      */
 
-    do_rvae_write(env, value, ARMMMUIdxBit_E3, true);
+    do_rvae_write(env, value, vae3_tlbmask(), true);
 }
 
 static void tlbi_aa64_ripas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
-- 
2.43.0


