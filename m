Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 177A07B700D
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:40:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjF0-0008Qf-DE; Tue, 03 Oct 2023 13:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEt-0008Ij-Je
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:20 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjEm-0007Tp-7E
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:19 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-578b407045bso926652a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354269; x=1696959069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J0oYo+mTGvLAIF78XaHG/A3/A9gDdPpx5DtcotYoOQU=;
 b=kDT6D+xQ+v6WSgix8yOs3OfrAgIc60lXBvgqxZVC1ZS4I+QTLiNTAYICaReLle0bNP
 A0m62rtHsssBdjfY63d2mU3aUh0qfasQRhCbWmnsuImYcpEcyAxAb1QcmHdZKU8MaIKt
 /BWUfLEEinTtU/P7rqYaMLAE/lI2HVar2cNPtjUDddqNtRiozd+8wr0Usp+OvPjtjVxp
 QqSq11XmygEF4n5h27rmEqUAegRGIAzrjcv8oDnQDv2u50XF9AP2Mg+FuU36O53H5tBX
 5OJjpLXSOE6e/qlVdGqhqbhZfiDD4nTDRoEKFkf7eYf7qdNy0Eo2WW0CZiRuv0LJ4QJc
 N73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354269; x=1696959069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J0oYo+mTGvLAIF78XaHG/A3/A9gDdPpx5DtcotYoOQU=;
 b=lxqyH4i4iWSeue38/4EfawqLsFGARVoW+tCUnTL1ghuhhhtzAwqW0yEiPPOXzDBgrC
 yW8qb4PMvXiPixOkM7KsWfGBilAdMqJBuoD8+Wc8LRxfUieu1f/GvrzdnxHBy7Mr9eiC
 ibmCGwgo2j+P1qw8H3BAN7HnRi7RHHbGbJ//HB3CVvgiYmhFAyBxKjOQcrzYxYnb2PvR
 uCW5nIkisWXJVd2w7wSjvw3GPzqXAQq9P06VgL9DveEEG+Zs2L1ctPJRIxFtrSmGLXDc
 o3TiSWjQtMN+0kk453RqDX9nrc/j+vEJ1yg4xidhVsqzaYRtD3euFWcR5EWyYZmiJQ9C
 qslg==
X-Gm-Message-State: AOJu0YwarEWoUM26BigJhVo+rwjiw+a1VxZhliX/56W0u3xl30BfloA6
 ZOdKGd0kkjlKoh473HDcHIuPBlMn8nnRrGqW3M0=
X-Google-Smtp-Source: AGHT+IHT8HFNBTCRZT2QmfHIORpqP66jp6BenTQ2r/m2v/WKWMDYHf2Y/gLigzG0yGq3ONwi63K5wA==
X-Received: by 2002:a05:6a20:324d:b0:14d:7511:1c2 with SMTP id
 hm13-20020a056a20324d00b0014d751101c2mr92608pzc.55.1696354269586; 
 Tue, 03 Oct 2023 10:31:09 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 14/47] accel/tcg: Move CPUNegativeOffsetState into CPUState
Date: Tue,  3 Oct 2023 10:30:19 -0700
Message-Id: <20231003173052.1601813-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Retain the separate structure to emphasize its importance.
Enforce CPUArchState always follows CPUState without padding.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h    | 22 +++++++++-------------
 include/hw/core/cpu.h     | 17 +++++++++++++++--
 target/alpha/cpu.h        |  1 -
 target/arm/cpu.h          |  1 -
 target/avr/cpu.h          |  1 -
 target/cris/cpu.h         |  1 -
 target/hexagon/cpu.h      |  2 +-
 target/hppa/cpu.h         |  1 -
 target/i386/cpu.h         |  1 -
 target/loongarch/cpu.h    |  1 -
 target/m68k/cpu.h         |  1 -
 target/microblaze/cpu.h   |  6 +++---
 target/mips/cpu.h         |  4 ++--
 target/nios2/cpu.h        |  1 -
 target/openrisc/cpu.h     |  1 -
 target/ppc/cpu.h          |  1 -
 target/riscv/cpu.h        |  2 +-
 target/rx/cpu.h           |  1 -
 target/s390x/cpu.h        |  1 -
 target/sh4/cpu.h          |  1 -
 target/sparc/cpu.h        |  1 -
 target/tricore/cpu.h      |  1 -
 target/xtensa/cpu.h       |  3 +--
 accel/tcg/translate-all.c |  4 ++--
 accel/tcg/translator.c    |  8 ++++----
 25 files changed, 38 insertions(+), 46 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index ed7747a5f1..0dd32cb0e9 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -432,9 +432,13 @@ int cpu_exec(CPUState *cpu);
 static inline void cpu_set_cpustate_pointers(ArchCPU *cpu)
 {
     cpu->parent_obj.env_ptr = &cpu->env;
-    cpu->parent_obj.icount_decr_ptr = &cpu->neg.icount_decr;
+    cpu->parent_obj.icount_decr_ptr = &cpu->parent_obj.neg.icount_decr;
 }
 
+/* Validate correct placement of CPUArchState. */
+QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
+QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
+
 /**
  * env_archcpu(env)
  * @env: The architecture environment
@@ -443,7 +447,7 @@ static inline void cpu_set_cpustate_pointers(ArchCPU *cpu)
  */
 static inline ArchCPU *env_archcpu(CPUArchState *env)
 {
-    return container_of(env, ArchCPU, env);
+    return (void *)env - sizeof(CPUState);
 }
 
 /**
@@ -454,15 +458,9 @@ static inline ArchCPU *env_archcpu(CPUArchState *env)
  */
 static inline CPUState *env_cpu(CPUArchState *env)
 {
-    return &env_archcpu(env)->parent_obj;
+    return (void *)env - sizeof(CPUState);
 }
 
-/*
- * Validate placement of CPUNegativeOffsetState.
- */
-QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) - offsetof(ArchCPU, neg) >=
-                  sizeof(CPUNegativeOffsetState) + __alignof(CPUArchState));
-
 /**
  * env_neg(env)
  * @env: The architecture environment
@@ -471,8 +469,7 @@ QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) - offsetof(ArchCPU, neg) >=
  */
 static inline CPUNegativeOffsetState *env_neg(CPUArchState *env)
 {
-    ArchCPU *arch_cpu = container_of(env, ArchCPU, env);
-    return &arch_cpu->neg;
+    return &env_cpu(env)->neg;
 }
 
 /**
@@ -483,8 +480,7 @@ static inline CPUNegativeOffsetState *env_neg(CPUArchState *env)
  */
 static inline CPUNegativeOffsetState *cpu_neg(CPUState *cpu)
 {
-    ArchCPU *arch_cpu = container_of(cpu, ArchCPU, parent_obj);
-    return &arch_cpu->neg;
+    return &cpu->neg;
 }
 
 /**
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 04baa5063c..115ddf6d8a 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -345,8 +345,8 @@ typedef union IcountDecr {
 } IcountDecr;
 
 /*
- * This structure must be placed in ArchCPU immediately
- * before CPUArchState, as a field named "neg".
+ * Elements of CPUState most efficiently accessed from CPUArchState,
+ * via small negative offsets.
  */
 typedef struct CPUNegativeOffsetState {
     CPUTLB tlb;
@@ -453,6 +453,9 @@ struct qemu_work_item;
  *    dirty ring structure.
  *
  * State of one CPU core or thread.
+ *
+ * Align, in order to match possible alignment required by CPUArchState,
+ * and eliminate a hole between CPUState and CPUArchState within ArchCPU.
  */
 struct CPUState {
     /*< private >*/
@@ -571,8 +574,18 @@ struct CPUState {
 
     /* track IOMMUs whose translations we've cached in the TCG TLB */
     GArray *iommu_notifiers;
+
+    /*
+     * MUST BE LAST in order to minimize the displacement to CPUArchState.
+     */
+    char neg_align[-sizeof(CPUNegativeOffsetState) % 16] QEMU_ALIGNED(16);
+    CPUNegativeOffsetState neg;
 };
 
+/* Validate placement of CPUNegativeOffsetState. */
+QEMU_BUILD_BUG_ON(offsetof(CPUState, neg) !=
+                  sizeof(CPUState) - sizeof(CPUNegativeOffsetState));
+
 typedef QTAILQ_HEAD(CPUTailQ, CPUState) CPUTailQ;
 extern CPUTailQ cpus;
 
diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
index 13306665af..e2a467ec17 100644
--- a/target/alpha/cpu.h
+++ b/target/alpha/cpu.h
@@ -263,7 +263,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUAlphaState env;
 
     /* This alarm doesn't exist in real hardware; we wish it did.  */
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index bd55c5dabf..a9edfb8353 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -856,7 +856,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUARMState env;
 
     /* Coprocessor information */
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 7225174668..4ce22d8e4f 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -148,7 +148,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUAVRState env;
 };
 
diff --git a/target/cris/cpu.h b/target/cris/cpu.h
index 8e37c6e50d..676b8e93ca 100644
--- a/target/cris/cpu.h
+++ b/target/cris/cpu.h
@@ -178,7 +178,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUCRISState env;
 };
 
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index daef5c3f00..10cd1efd57 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -141,7 +141,7 @@ struct ArchCPU {
     /*< private >*/
     CPUState parent_obj;
     /*< public >*/
-    CPUNegativeOffsetState neg;
+
     CPUHexagonState env;
 
     bool lldb_compat;
diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 730f35231a..798d0c26d7 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -237,7 +237,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUHPPAState env;
     QEMUTimer *alarm_timer;
 };
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index d3f377d48a..e1875466b9 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1901,7 +1901,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUX86State env;
     VMChangeStateEntry *vmsentry;
 
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index f125a8e49b..40e70a8119 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -375,7 +375,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPULoongArchState env;
     QEMUTimer timer;
     uint32_t  phy_id;
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index cf70282717..20afb0c94d 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -168,7 +168,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUM68KState env;
 };
 
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index f6cab6ce19..e43c49d4af 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -345,15 +345,15 @@ typedef struct {
 struct ArchCPU {
     /*< private >*/
     CPUState parent_obj;
-
     /*< public >*/
+
+    CPUMBState env;
+
     bool ns_axi_dp;
     bool ns_axi_ip;
     bool ns_axi_dc;
     bool ns_axi_ic;
 
-    CPUNegativeOffsetState neg;
-    CPUMBState env;
     MicroBlazeCPUConfig cfg;
 };
 
diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 6d6af1f2a8..67f8e8b988 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -1213,10 +1213,10 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
+    CPUMIPSState env;
+
     Clock *clock;
     Clock *count_div; /* Divider for CP0_Count clock */
-    CPUNegativeOffsetState neg;
-    CPUMIPSState env;
 };
 
 
diff --git a/target/nios2/cpu.h b/target/nios2/cpu.h
index 477a3161fd..70b6377a4f 100644
--- a/target/nios2/cpu.h
+++ b/target/nios2/cpu.h
@@ -218,7 +218,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUNios2State env;
 
     bool diverr_present;
diff --git a/target/openrisc/cpu.h b/target/openrisc/cpu.h
index ce4d605eb7..334997e9a1 100644
--- a/target/openrisc/cpu.h
+++ b/target/openrisc/cpu.h
@@ -305,7 +305,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUOpenRISCState env;
 };
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index d703a5f3c6..30392ebeee 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1317,7 +1317,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUPPCState env;
 
     int vcpu_id;
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 6316cbcc23..ef9cf21c0c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -388,7 +388,7 @@ struct ArchCPU {
     /* < private > */
     CPUState parent_obj;
     /* < public > */
-    CPUNegativeOffsetState neg;
+
     CPURISCVState env;
 
     char *dyn_csr_xml;
diff --git a/target/rx/cpu.h b/target/rx/cpu.h
index 7f03ffcfed..f66754eb8a 100644
--- a/target/rx/cpu.h
+++ b/target/rx/cpu.h
@@ -111,7 +111,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPURXState env;
 };
 
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 304029e57c..7bea7075e1 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -170,7 +170,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUS390XState env;
     S390CPUModel *model;
     /* needed for live migration */
diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 1399d3840f..f75a235973 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -208,7 +208,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUSH4State env;
 };
 
diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 98044572f2..b3a98f1d74 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -561,7 +561,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUSPARCState env;
 };
 
diff --git a/target/tricore/cpu.h b/target/tricore/cpu.h
index 1cace96b01..a357b573f2 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -67,7 +67,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUTriCoreState env;
 };
 
diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
index 87fe992ba6..c6bbef1e5d 100644
--- a/target/xtensa/cpu.h
+++ b/target/xtensa/cpu.h
@@ -560,9 +560,8 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    Clock *clock;
-    CPUNegativeOffsetState neg;
     CPUXtensaState env;
+    Clock *clock;
 };
 
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index b2d4e22c17..098d99b5d4 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -344,8 +344,8 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tcg_ctx->page_bits = TARGET_PAGE_BITS;
     tcg_ctx->page_mask = TARGET_PAGE_MASK;
     tcg_ctx->tlb_dyn_max_bits = CPU_TLB_DYN_MAX_BITS;
-    tcg_ctx->tlb_fast_offset =
-        (int)offsetof(ArchCPU, neg.tlb.f) - (int)offsetof(ArchCPU, env);
+    tcg_ctx->tlb_fast_offset = (int)offsetof(ArchCPU, parent_obj.neg.tlb.f)
+                             - (int)offsetof(ArchCPU, env);
 #endif
     tcg_ctx->insn_start_words = TARGET_INSN_START_WORDS;
 #ifdef TCG_GUEST_DEFAULT_MO
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 358214d526..b3e12d61e9 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -48,8 +48,8 @@ static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
     if ((cflags & CF_USE_ICOUNT) || !(cflags & CF_NOIRQ)) {
         count = tcg_temp_new_i32();
         tcg_gen_ld_i32(count, cpu_env,
-                       offsetof(ArchCPU, neg.icount_decr.u32) -
-                       offsetof(ArchCPU, env));
+                       offsetof(ArchCPU, parent_obj.neg.icount_decr.u32)
+                       - offsetof(ArchCPU, env));
     }
 
     if (cflags & CF_USE_ICOUNT) {
@@ -78,8 +78,8 @@ static TCGOp *gen_tb_start(DisasContextBase *db, uint32_t cflags)
 
     if (cflags & CF_USE_ICOUNT) {
         tcg_gen_st16_i32(count, cpu_env,
-                         offsetof(ArchCPU, neg.icount_decr.u16.low) -
-                         offsetof(ArchCPU, env));
+                         offsetof(ArchCPU, parent_obj.neg.icount_decr.u16.low)
+                         - offsetof(ArchCPU, env));
     }
 
     /*
-- 
2.34.1


