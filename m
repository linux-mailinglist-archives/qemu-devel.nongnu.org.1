Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F97786BCD
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:29:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6am-0005FM-Uk; Thu, 24 Aug 2023 05:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qZ6a8-00042T-4g
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:24:53 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qZ6a3-0003az-Fh
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:24:47 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxRvHDIedkaHkbAA--.56130S3;
 Thu, 24 Aug 2023 17:24:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxJ826IedkJjhiAA--.40637S18; 
 Thu, 24 Aug 2023 17:24:19 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, richard.henderson@linaro.org, Jiajie Chen <c@jia.je>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/31] target/loongarch: Extract set_pc() helper
Date: Thu, 24 Aug 2023 17:23:54 +0800
Message-Id: <20230824092409.1492470-17-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230824092409.1492470-1-gaosong@loongson.cn>
References: <20230824092409.1492470-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxJ826IedkJjhiAA--.40637S18
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Message-Id: <20230822071405.35386-9-philmd@linaro.org>
---
 target/loongarch/cpu.c       | 16 ++++++++--------
 target/loongarch/cpu.h       |  5 +++++
 target/loongarch/gdbstub.c   |  2 +-
 target/loongarch/op_helper.c |  4 ++--
 4 files changed, 16 insertions(+), 11 deletions(-)

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
2.39.1


