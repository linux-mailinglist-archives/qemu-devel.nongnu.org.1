Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED9B7A32B4
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:44:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd2s-00057X-SP; Sat, 16 Sep 2023 17:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2l-00055W-Kt
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:35 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd2j-0000Qo-04
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:41:35 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68fc9e0e22eso2656626b3a.1
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900491; x=1695505291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Z+/Cc8PVRj+uMG7DhPL8FK/YG6daD+6YPyxU9cEkIs=;
 b=Lyd+40AvQHQ2ha06YuLWvGc3qOIcYbF8RPkZu3hWLCleUgulEBZMob+Lu0LNeC8Zfe
 L2OJsNT1xhCkQwVnxBCc5xjA0AFJDQx10U1h1zCo5C/SPm/hwJ+BgGVPUqvcvB24fCBm
 dMqKJZcYZt9gbvWlbnHLtH9WT7+heOFLafpDNzfJkqB4P2Gu98DCZZHM3SPVlqvfXTbk
 KUwFvaVVfdinyhehH+Q9oZ4gZPR5/Ycu0GqhECckaQxIwvkGiSB66tBqShDnojVWi97p
 RQuZLi43ZDKoZ+Qz4OfFp1zMhnLsSkdO/5K68ygWBi0E/6IoHOyK7fUVSxjKo4HE1X48
 XOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900491; x=1695505291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Z+/Cc8PVRj+uMG7DhPL8FK/YG6daD+6YPyxU9cEkIs=;
 b=CzTiYXsw2aLnr1lykolJiKU2x3qS5o8MGn5vJ6Ufij+H6xvR6OKHefeSFjoamdL7gC
 44aXsKfLVC3VeJ/Zo/7LaXWzpsOoP67EsnfFhLFdIvRUh4Ud9zZLWt6KTPVy2EgUg8Fj
 kYA6bze88NzR6e8WH2agimAs5JmHqGov0GdBgDpia64IA1QFxeLr8hG5mNad0HzpEZ44
 5YNAvRtK9OfxnyeSe30JWoNmBR1pMIVoquqd9UlUt2yxW4sxBRibva4ubb9Ep8zoCH+C
 sX9zFkID96G69a5j10IUUNnUewpHQS74r3DpgGbgAHf4IiZVJJSqafCVA6qfUMUcAoUS
 EtEw==
X-Gm-Message-State: AOJu0YwY/2Xq6dduGlJzG+QCDnEZJFci86UIC/KulGL/n/RnDK0Be+l/
 J0H2DWcM+Hkc+6n47lUTWlIscyce3ch+L4KMgx0=
X-Google-Smtp-Source: AGHT+IEJpYFqRfIR2Jx6fzMQPnHd+N7jjLgdRFUVCrt9hfAx3Mb6dqhHrg45CECJ2ymiQ3R8Z3GHzg==
X-Received: by 2002:a05:6a00:15cc:b0:68e:2af1:b193 with SMTP id
 o12-20020a056a0015cc00b0068e2af1b193mr5678374pfu.28.1694900491520; 
 Sat, 16 Sep 2023 14:41:31 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.41.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:41:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 07/39] accel/tcg: Move CPUNegativeOffsetState into CPUState
Date: Sat, 16 Sep 2023 14:40:51 -0700
Message-Id: <20230916214123.525796-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
index 86a7452b0d..165a271642 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -434,9 +434,13 @@ void tcg_exec_unrealizefn(CPUState *cpu);
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
@@ -445,7 +449,7 @@ static inline void cpu_set_cpustate_pointers(ArchCPU *cpu)
  */
 static inline ArchCPU *env_archcpu(CPUArchState *env)
 {
-    return container_of(env, ArchCPU, env);
+    return (void *)env - sizeof(CPUState);
 }
 
 /**
@@ -456,15 +460,9 @@ static inline ArchCPU *env_archcpu(CPUArchState *env)
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
@@ -473,8 +471,7 @@ QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) - offsetof(ArchCPU, neg) >=
  */
 static inline CPUNegativeOffsetState *env_neg(CPUArchState *env)
 {
-    ArchCPU *arch_cpu = container_of(env, ArchCPU, env);
-    return &arch_cpu->neg;
+    return &env_cpu(env)->neg;
 }
 
 /**
@@ -485,8 +482,7 @@ static inline CPUNegativeOffsetState *env_neg(CPUArchState *env)
  */
 static inline CPUNegativeOffsetState *cpu_neg(CPUState *cpu)
 {
-    ArchCPU *arch_cpu = container_of(cpu, ArchCPU, parent_obj);
-    return &arch_cpu->neg;
+    return &cpu->neg;
 }
 
 /**
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 04baa5063c..ed1bf8dbf1 100644
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
+QEMU_BUILD_BUG_ON(sizeof(CPUState) != 
+                  offsetof(CPUState, neg) + sizeof(CPUNegativeOffsetState));
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
index f2e3dc49a6..51963b6545 100644
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
index fa13694dab..7557f884b5 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -231,7 +231,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUHPPAState env;
     QEMUTimer *alarm_timer;
 };
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index fbb05eace5..e1b41c29f0 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1900,7 +1900,6 @@ struct ArchCPU {
     CPUState parent_obj;
     /*< public >*/
 
-    CPUNegativeOffsetState neg;
     CPUX86State env;
     VMChangeStateEntry *vmsentry;
 
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 4d7201995a..3b5ec51928 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -373,7 +373,6 @@ struct ArchCPU {
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
index 173e4c351a..f5027616fa 100644
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
index 3708405be8..217937bbf6 100644
--- a/target/tricore/cpu.h
+++ b/target/tricore/cpu.h
@@ -192,7 +192,6 @@ struct ArchCPU {
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
index 1a6a5448c8..54190c785b 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -53,8 +53,8 @@ static TCGOp *gen_tb_start(uint32_t cflags)
     TCGOp *icount_start_insn = NULL;
 
     tcg_gen_ld_i32(count, cpu_env,
-                   offsetof(ArchCPU, neg.icount_decr.u32) -
-                   offsetof(ArchCPU, env));
+                   offsetof(ArchCPU, parent_obj.neg.icount_decr.u32)
+                   - offsetof(ArchCPU, env));
 
     if (cflags & CF_USE_ICOUNT) {
         /*
@@ -82,8 +82,8 @@ static TCGOp *gen_tb_start(uint32_t cflags)
 
     if (cflags & CF_USE_ICOUNT) {
         tcg_gen_st16_i32(count, cpu_env,
-                         offsetof(ArchCPU, neg.icount_decr.u16.low) -
-                         offsetof(ArchCPU, env));
+                         offsetof(ArchCPU, parent_obj.neg.icount_decr.u16.low)
+                         - offsetof(ArchCPU, env));
         /*
          * cpu->can_do_io is cleared automatically here at the beginning of
          * each translation block.  The cost is minimal and only paid for
-- 
2.34.1


