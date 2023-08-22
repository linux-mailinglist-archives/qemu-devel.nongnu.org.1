Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06ABA783A7C
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:11:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLY4-0003iE-7j; Tue, 22 Aug 2023 03:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLXk-0003CJ-GZ
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:11:14 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLXi-0002QJ-4Q
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:11:12 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fe4a89e8c4so40197155e9.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692688268; x=1693293068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33DmERFUsYdjL3Dz9aMKxeBhsxHS9Ddy+t/2WnyHXOg=;
 b=slui7MBGB6PaWkSPtX5JXzjaw0snYpLl9iiboCFvBrZNiDmH1bt7rMRaw1edsVwN21
 M5uTTzvpcoCLSj7UsL/46Lo753HqfCcbbBYM0n9ARGE+qWd7nyfVR7LW/UfgmflWePtg
 QGnZxfpcXtSYn/4vrZVNiy3F91Pesx8RYAwfqXycs8etG/BsgXmL+8lTzK9U8EHYyetg
 6HnSQ4mOVwjx7/8odUMf17fuLG+V7+ft+edgw6f7r2ESMEX54LRZarbuHuh5aEEhmreH
 j00E/Pazue90+gVgNb7NzLREBTEsDBDiASqmQTecDcknLm6CygSO27kr4W7hBiGSCrkL
 UPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692688268; x=1693293068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=33DmERFUsYdjL3Dz9aMKxeBhsxHS9Ddy+t/2WnyHXOg=;
 b=VT/dn0T2ArvBCDd6FdgWZpDXGKFLNyWKuaNc0YTvWm1Uc9TOjGaV/7EjmDQCqMDn4y
 jBKXR8VNjPD2t8EwfzI6t7VoFSkxVx+A35AjmINKfZ/yE/fMuG8RZPxFx1YUfuTe2KHE
 5mpu73Mlg/arn7BSFieEkghDgnhuwHxWYJWs2S8ZpI5jJcrD/cOy8KfP3PwhK2a4KIyC
 mA9U/pJL4B05HC2k8Xf6MGH6uIqD5QO+ZNp0AlNz2SfDbEwjOJUD7wp1NgCX39gaPNZ2
 j64yR5cDNX+X9V8JHVGeKBJF1vz0hJ9L3V3lqpnicI7tfrrf2akLjTZWc1VTHW6m8yc+
 0yaA==
X-Gm-Message-State: AOJu0YwgoApXkmdPXm0QXPtVR8JvJj5XY8Rwb2WIDrYHmBOJAS7cwsc9
 ltCWtma7eWdpFt4/E+efXE1FEScVbTkVwKy0w92U0w==
X-Google-Smtp-Source: AGHT+IFAitbRLAw0lkxbChM/j2rVJXFd9o1IEr7Trp5tgvOBOelSYM96sTWyg7lsaCyjr1adVELM/A==
X-Received: by 2002:adf:ed87:0:b0:314:2fdd:28ef with SMTP id
 c7-20020adfed87000000b003142fdd28efmr6746685wro.18.1692688268374; 
 Tue, 22 Aug 2023 00:11:08 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a5d65cb000000b003179d7ed4f3sm14930954wrw.12.2023.08.22.00.11.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 00:11:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Jiajie Chen <c@jia.je>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 08/19] target/loongarch: Extract set_pc() helper
Date: Tue, 22 Aug 2023 09:10:01 +0200
Message-ID: <20230822071013.34884-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822071013.34884-1-philmd@linaro.org>
References: <20230822071013.34884-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: Jiajie Chen <c@jia.je>

Signed-off-by: Jiajie Chen <c@jia.je>
Co-authored-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230822032724.1353391-6-gaosong@loongson.cn>
[PMD: Extract helper from bigger patch]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/cpu.h       |  5 +++++
 target/loongarch/cpu.c       | 16 ++++++++--------
 target/loongarch/gdbstub.c   |  2 +-
 target/loongarch/op_helper.c |  4 ++--
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 72109095e4..e1562695e8 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -443,6 +443,11 @@ static inline bool is_va32(CPULoongArchState *env)
     return va32;
 }
 
+static inline void set_pc(CPULoongArchState *env, uint64_t value)
+{
+    env->pc = value;
+}
+
 /*
  * LoongArch CPUs hardware flags.
  */
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 822f2a72e5..67eb6c3135 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -81,7 +81,7 @@ static void loongarch_cpu_set_pc(CPUState *cs, vaddr value)
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
     CPULoongArchState *env = &cpu->env;
 
-    env->pc = value;
+    set_pc(env, value);
 }
 
 static vaddr loongarch_cpu_get_pc(CPUState *cs)
@@ -168,7 +168,7 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
     set_DERA:
         env->CSR_DERA = env->pc;
         env->CSR_DBG = FIELD_DP64(env->CSR_DBG, CSR_DBG, DST, 1);
-        env->pc = env->CSR_EENTRY + 0x480;
+        set_pc(env, env->CSR_EENTRY + 0x480);
         break;
     case EXCCODE_INT:
         if (FIELD_EX64(env->CSR_DBG, CSR_DBG, DST)) {
@@ -249,7 +249,8 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
 
         /* Find the highest-priority interrupt. */
         vector = 31 - clz32(pending);
-        env->pc = env->CSR_EENTRY + (EXCCODE_EXTERNAL_INT + vector) * vec_size;
+        set_pc(env, env->CSR_EENTRY + \
+               (EXCCODE_EXTERNAL_INT + vector) * vec_size);
         qemu_log_mask(CPU_LOG_INT,
                       "%s: PC " TARGET_FMT_lx " ERA " TARGET_FMT_lx
                       " cause %d\n" "    A " TARGET_FMT_lx " D "
@@ -260,10 +261,9 @@ static void loongarch_cpu_do_interrupt(CPUState *cs)
                       env->CSR_ECFG, env->CSR_ESTAT);
     } else {
         if (tlbfill) {
-            env->pc = env->CSR_TLBRENTRY;
+            set_pc(env, env->CSR_TLBRENTRY);
         } else {
-            env->pc = env->CSR_EENTRY;
-            env->pc += EXCODE_MCODE(cause) * vec_size;
+            set_pc(env, env->CSR_EENTRY + EXCODE_MCODE(cause) * vec_size);
         }
         qemu_log_mask(CPU_LOG_INT,
                       "%s: PC " TARGET_FMT_lx " ERA " TARGET_FMT_lx
@@ -324,7 +324,7 @@ static void loongarch_cpu_synchronize_from_tb(CPUState *cs,
     CPULoongArchState *env = &cpu->env;
 
     tcg_debug_assert(!(cs->tcg_cflags & CF_PCREL));
-    env->pc = tb->pc;
+    set_pc(env, tb->pc);
 }
 
 static void loongarch_restore_state_to_opc(CPUState *cs,
@@ -334,7 +334,7 @@ static void loongarch_restore_state_to_opc(CPUState *cs,
     LoongArchCPU *cpu = LOONGARCH_CPU(cs);
     CPULoongArchState *env = &cpu->env;
 
-    env->pc = data[0];
+    set_pc(env, data[0]);
 }
 #endif /* CONFIG_TCG */
 
diff --git a/target/loongarch/gdbstub.c b/target/loongarch/gdbstub.c
index a462e25737..e20b20f99b 100644
--- a/target/loongarch/gdbstub.c
+++ b/target/loongarch/gdbstub.c
@@ -77,7 +77,7 @@ int loongarch_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         env->gpr[n] = tmp;
         length = read_length;
     } else if (n == 33) {
-        env->pc = tmp;
+        set_pc(env, tmp);
         length = read_length;
     }
     return length;
diff --git a/target/loongarch/op_helper.c b/target/loongarch/op_helper.c
index 60335a05e2..cf84f20aba 100644
--- a/target/loongarch/op_helper.c
+++ b/target/loongarch/op_helper.c
@@ -114,14 +114,14 @@ void helper_ertn(CPULoongArchState *env)
         env->CSR_TLBRERA = FIELD_DP64(env->CSR_TLBRERA, CSR_TLBRERA, ISTLBR, 0);
         env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, DA, 0);
         env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PG, 1);
-        env->pc = env->CSR_TLBRERA;
+        set_pc(env, env->CSR_TLBRERA);
         qemu_log_mask(CPU_LOG_INT, "%s: TLBRERA " TARGET_FMT_lx "\n",
                       __func__, env->CSR_TLBRERA);
     } else {
         csr_pplv = FIELD_EX64(env->CSR_PRMD, CSR_PRMD, PPLV);
         csr_pie = FIELD_EX64(env->CSR_PRMD, CSR_PRMD, PIE);
 
-        env->pc = env->CSR_ERA;
+        set_pc(env, env->CSR_ERA);
         qemu_log_mask(CPU_LOG_INT, "%s: ERA " TARGET_FMT_lx "\n",
                       __func__, env->CSR_ERA);
     }
-- 
2.41.0


