Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 572B88B64A2
	for <lists+qemu-devel@lfdr.de>; Mon, 29 Apr 2024 23:32:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1YbE-0007Yv-L2; Mon, 29 Apr 2024 17:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1YbA-0007Vo-My
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:31:44 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Yb8-0003Lv-IH
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:31:44 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2dd615b6c44so53508281fa.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 14:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714426300; x=1715031100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5OmsnBs/+tQZTXi4xeG0bzNVQxfgpAgsB1myUNRNM74=;
 b=pD42bxWt58Uf3M9kpmBpLWqOr0/2rQqlVafYY9l7yVHFKMH8ar9ysx1bK2wiR45j6d
 UEm4KgxMFPkSssKbcjV6jL4XTd5y7VAuB1YAjwGpO3PDbdtTsqVwiRoNemNm7Ahm2fxA
 /zfvYcgSQb0xn6vyjyprjV74aECmIA9dZ+0zdrN9iKENxDa7C199K2+5D8Y7jzCrrgRP
 7ee9HPeikEt5jvOmesuipDVTQP5OcTkVAxv+9z96pdhkkFC2I+IyLbuM0XkGSj3ekCOG
 k+FFPF5E+iuycUP4TqHhWJ0FU6fVXxv0fLVAJrlfJ5UXGviqkOhyO4sHVPoSdqlYTT3N
 gjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714426300; x=1715031100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5OmsnBs/+tQZTXi4xeG0bzNVQxfgpAgsB1myUNRNM74=;
 b=UX0Rd5jQR4Zj0GAo6FXd6+nF1DPgMb/CKUwI2qJWt2IS3CKWaS7FP45GTawO2L/aRi
 Byd3PV5+VOGxGZvz4pvMB9gS1IkHsVBWv8t3ea09FhVdq2bgQixONL8n50eOONMH36cs
 FX0mQREg+S9RJw+o4Y75Fby7u4weGmTBB+Nmv53vegn7KKzEgF5dhSiTs4LtnC6XXSUz
 fA/oEBoi1Y9Io2oLzwizoyg8Vw2gl+FxqNnA93Wh6t5G6rx0e60PKb1Go0ILNx0Rk/i2
 FBfe/q6vncSwgtNkTeIgihw9uzhzcazeMxWEGFukl6FEAmdDLn1XH10LTMS2jDMBIbEY
 c+5A==
X-Gm-Message-State: AOJu0YwQgUIyN03AMCXI2+qAstEYVWPdlrIwAc+eqX/6RAYdslPODCz8
 +/aebZXTa/KMP/B01FfkuW7Yoc0Bs4FKpI6AILqMLzHYzuhi6ER4c1NHpfzi+kTrCjuy6PwFgyP
 dIr0=
X-Google-Smtp-Source: AGHT+IHz3e3g5eBBT5Om/j8XNn8tda7xBLvGcWxXvL0d1xnCd8Rw+vAtZM8JOGTeSthzWqUHbEWRjw==
X-Received: by 2002:a2e:9350:0:b0:2da:a3ff:524e with SMTP id
 m16-20020a2e9350000000b002daa3ff524emr5676951ljh.9.1714426300556; 
 Mon, 29 Apr 2024 14:31:40 -0700 (PDT)
Received: from m1x-phil.lan (bny92-h02-176-184-44-142.dsl.sta.abo.bbox.fr.
 [176.184.44.142]) by smtp.gmail.com with ESMTPSA id
 u5-20020a05600c138500b0041c5151dc1csm4286616wmf.29.2024.04.29.14.31.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Apr 2024 14:31:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 09/13] accel/tcg: Move @tb_jmp_cache from CPUState to TCG
 AccelCPUState
Date: Mon, 29 Apr 2024 23:30:46 +0200
Message-ID: <20240429213050.55177-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240429213050.55177-1-philmd@linaro.org>
References: <20240429213050.55177-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

@tb_jmp_cache is specific to TCG accelerator, move it to
its AccelCPUState.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240428221450.26460-21-philmd@linaro.org>
---
 accel/tcg/tb-jmp-cache.h  | 4 ++--
 accel/tcg/vcpu-state.h    | 2 ++
 include/hw/core/cpu.h     | 2 --
 include/qemu/typedefs.h   | 1 -
 accel/tcg/cpu-exec.c      | 7 +++----
 accel/tcg/cputlb.c        | 2 +-
 accel/tcg/tb-maint.c      | 2 +-
 accel/tcg/translate-all.c | 5 +++--
 8 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/accel/tcg/tb-jmp-cache.h b/accel/tcg/tb-jmp-cache.h
index 184bb3e3e2..c3a505e394 100644
--- a/accel/tcg/tb-jmp-cache.h
+++ b/accel/tcg/tb-jmp-cache.h
@@ -22,12 +22,12 @@
  * non-NULL value of 'tb'.  Strictly speaking pc is only needed for
  * CF_PCREL, but it's used always for simplicity.
  */
-struct CPUJumpCache {
+typedef struct CPUJumpCache {
     struct rcu_head rcu;
     struct {
         TranslationBlock *tb;
         vaddr pc;
     } array[TB_JMP_CACHE_SIZE];
-};
+} CPUJumpCache;
 
 #endif /* ACCEL_TCG_TB_JMP_CACHE_H */
diff --git a/accel/tcg/vcpu-state.h b/accel/tcg/vcpu-state.h
index 51e54ca535..0cb58ba734 100644
--- a/accel/tcg/vcpu-state.h
+++ b/accel/tcg/vcpu-state.h
@@ -7,6 +7,7 @@
 #define ACCEL_TCG_VCPU_STATE_H
 
 #include "hw/core/cpu.h"
+#include "tb-jmp-cache.h"
 
 /**
  * AccelCPUState: vCPU fields specific to TCG accelerator
@@ -16,6 +17,7 @@ struct AccelCPUState {
     uint32_t cflags_next_tb;
 
     sigjmp_buf jmp_env;
+    CPUJumpCache tb_jmp_cache;
 
 #ifdef CONFIG_USER_ONLY
     TaskState *ts;
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index f3cbb944eb..6e6e946b66 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -483,8 +483,6 @@ struct CPUState {
     AddressSpace *as;
     MemoryRegion *memory;
 
-    CPUJumpCache *tb_jmp_cache;
-
     GArray *gdb_regs;
     int gdb_num_regs;
     int gdb_num_g_regs;
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 36f2825725..daf9009332 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -44,7 +44,6 @@ typedef struct CPUAddressSpace CPUAddressSpace;
 typedef struct CPUArchState CPUArchState;
 typedef struct CPUPluginState CPUPluginState;
 typedef struct CpuInfoFast CpuInfoFast;
-typedef struct CPUJumpCache CPUJumpCache;
 typedef struct CPUState CPUState;
 typedef struct CPUTLBEntryFull CPUTLBEntryFull;
 typedef struct DeviceListener DeviceListener;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 55235d3e5e..8f8e1fa948 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -261,7 +261,7 @@ static inline TranslationBlock *tb_lookup(CPUState *cpu, vaddr pc,
     tcg_debug_assert(!(cflags & CF_INVALID));
 
     hash = tb_jmp_cache_hash_func(pc);
-    jc = cpu->tb_jmp_cache;
+    jc = &cpu->accel->tb_jmp_cache;
 
     tb = qatomic_read(&jc->array[hash].tb);
     if (likely(tb &&
@@ -1004,7 +1004,7 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
                  * for the fast lookup
                  */
                 h = tb_jmp_cache_hash_func(pc);
-                jc = cpu->tb_jmp_cache;
+                jc = &cpu->accel->tb_jmp_cache;
                 jc->array[h].pc = pc;
                 qatomic_set(&jc->array[h].tb, tb);
             }
@@ -1083,7 +1083,6 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
         tcg_target_initialized = true;
     }
 
-    cpu->tb_jmp_cache = g_new0(CPUJumpCache, 1);
     tlb_init(cpu);
 #ifndef CONFIG_USER_ONLY
     tcg_iommu_init_notifier_list(cpu);
@@ -1101,5 +1100,5 @@ void tcg_exec_unrealizefn(CPUState *cpu)
 #endif /* !CONFIG_USER_ONLY */
 
     tlb_destroy(cpu);
-    g_free_rcu(cpu->tb_jmp_cache, rcu);
+    g_free_rcu(&cpu->accel->tb_jmp_cache, rcu);
 }
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index cdb3e12dfb..eaa60d1da2 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -156,7 +156,7 @@ static void tlb_window_reset(CPUTLBDesc *desc, int64_t ns,
 
 static void tb_jmp_cache_clear_page(CPUState *cpu, vaddr page_addr)
 {
-    CPUJumpCache *jc = cpu->tb_jmp_cache;
+    CPUJumpCache *jc = &cpu->accel->tb_jmp_cache;
     int i, i0;
 
     if (unlikely(!jc)) {
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 2d5faca9fd..83758648f2 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -888,7 +888,7 @@ static void tb_jmp_cache_inval_tb(TranslationBlock *tb)
         uint32_t h = tb_jmp_cache_hash_func(tb->pc);
 
         CPU_FOREACH(cpu) {
-            CPUJumpCache *jc = cpu->tb_jmp_cache;
+            CPUJumpCache *jc = &cpu->accel->tb_jmp_cache;
 
             if (qatomic_read(&jc->array[h].tb) == tb) {
                 qatomic_set(&jc->array[h].tb, NULL);
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 3a8199a761..ca1e193633 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -652,13 +652,14 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
  */
 void tcg_flush_jmp_cache(CPUState *cpu)
 {
-    CPUJumpCache *jc = cpu->tb_jmp_cache;
+    CPUJumpCache *jc;
 
     /* During early initialization, the cache may not yet be allocated. */
-    if (unlikely(jc == NULL)) {
+    if (unlikely(cpu->accel == NULL)) {
         return;
     }
 
+    jc = &cpu->accel->tb_jmp_cache;
     for (int i = 0; i < TB_JMP_CACHE_SIZE; i++) {
         qatomic_set(&jc->array[i].tb, NULL);
     }
-- 
2.41.0


