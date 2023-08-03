Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6B976DCF1
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 02:56:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRMd3-0007dg-8N; Wed, 02 Aug 2023 20:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qRMcy-0007br-AV
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 20:55:44 -0400
Received: from home.keithp.com ([63.227.221.253] helo=elaine.keithp.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keithp@keithp.com>) id 1qRMcv-0006Ea-Hu
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 20:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1691024138; bh=WQOl/xUqfSD2CVl8eC68SX5e0PN9dBWuPXryUracn6Y=;
 h=From:To:Cc:Subject:Date:From;
 b=uNm4xwy1FdW20lKNYn0/asQUuzadvrjxsLj95fxuwDYY6aP3PRDTEsiYYD6zmAQZK
 XeJGwk6Y2qSR8q9yzv7RYTfzlptQAFL1lxgENzeA5t2uvuY687f1MKInetrAeK+7qM
 huPSyFg6T6IBUo0AammBWx0F8t1XbTClDCPNtaXdd0Y+/LwKL3n7KODGjuKwSWdx8s
 QvMiMO7zz0b4gQpXrU6dGUejQt6+FCX1wX5yJOK9HPLJVKOtKNQIyq6WRj1JgM3R04
 Fpnckjvv/0qBMSxaNzEf9DhajtkpgfOhNV/14vHS3uYvojSujclNpUe5SttW3D/Uis
 GFqVYJVotJVQA==
Received: from localhost (localhost [127.0.0.1])
 by elaine.keithp.com (Postfix) with ESMTP id C44113F21C9C;
 Wed,  2 Aug 2023 17:55:38 -0700 (PDT)
X-Virus-Scanned: Debian amavis at keithp.com
Received: from elaine.keithp.com ([127.0.0.1])
 by localhost (elaine.keithp.com [127.0.0.1]) (amavis, port 10024) with LMTP
 id hAbiWO3nGh5a; Wed,  2 Aug 2023 17:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=keithp.com; s=mail;
 t=1691024136; bh=WQOl/xUqfSD2CVl8eC68SX5e0PN9dBWuPXryUracn6Y=;
 h=From:To:Cc:Subject:Date:From;
 b=EWavuTOv2S82FZePZTsUr8k1WNuZcOwu0qd8A91JMN+/Hub0C6+MBwH22+HEYX7nI
 BfP2HuExVj3/InymHViNmAq2AuDKdzpAAERaMK8EtoTsGD0wFYdj4OoaYufIispdiw
 rYldBurw3slb+vcIGYHnI5IGfQiIWbwsFafcD7aXT9Goqf8LCmeb/6450yxrdhDkYi
 VRF2coEJDNzoLbXldnlDTHOXszo3LCFyMdeqzVdsenFcoljQ1cvVkdkjYttD/yo+Dt
 XBZXYWqE4ZFoxJU369d2CkyEyfJdVf7p0tAdXH9DaLscsA5TNti2OmzflCwj5X7u82
 kKAKHW0itsOkQ==
Received: from keithp.com (koto.keithp.com [192.168.11.2])
 by elaine.keithp.com (Postfix) with ESMTPSA id D83233F20951;
 Wed,  2 Aug 2023 17:55:36 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1000)
 id 8AD2A1E601E7; Wed,  2 Aug 2023 17:55:36 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
	Keith Packard <keithp@keithp.com>
Subject: [PATCH] target/m68k: Map FPU exceptions to FPSR register
Date: Wed,  2 Aug 2023 17:55:34 -0700
Message-Id: <20230803005534.421387-1-keithp@keithp.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.227.221.253; envelope-from=keithp@keithp.com;
 helo=elaine.keithp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Keith Packard <keithp@keithp.com>
From:  Keith Packard via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Add helpers for reading/writing the 68881 FPSR register so that
changes in floating point exception state can be seen by the
application.

Signed-off-by: Keith Packard <keithp@keithp.com>
---
 target/m68k/cpu.h        |  2 ++
 target/m68k/fpu_helper.c | 72 ++++++++++++++++++++++++++++++++++++++++
 target/m68k/helper.c     |  4 +--
 target/m68k/helper.h     |  2 ++
 target/m68k/translate.c  |  4 +--
 5 files changed, 80 insertions(+), 4 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index b741c50a8f..1e491fda77 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -173,6 +173,8 @@ struct ArchCPU {
     CPUM68KState env;
 };
 
+uint32_t cpu_m68k_get_fpsr(CPUM68KState *env);
+void cpu_m68k_set_fpsr(CPUM68KState *env, uint32_t val);
 
 #ifndef CONFIG_USER_ONLY
 void m68k_cpu_do_interrupt(CPUState *cpu);
diff --git a/target/m68k/fpu_helper.c b/target/m68k/fpu_helper.c
index ab120b5f59..542ce1790a 100644
--- a/target/m68k/fpu_helper.c
+++ b/target/m68k/fpu_helper.c
@@ -164,6 +164,78 @@ void HELPER(set_fpcr)(CPUM68KState *env, uint32_t val)
     cpu_m68k_set_fpcr(env, val);
 }
 
+/* Convert host exception flags to cpu_m68k form.  */
+static inline int cpu_m68k_exceptbits_from_host(int host_bits)
+{
+    int target_bits = 0;
+
+    if (host_bits & float_flag_invalid) {
+        target_bits |= 0x80;
+    }
+    if (host_bits & float_flag_overflow) {
+        target_bits |= 0x40;
+    }
+    if (host_bits & (float_flag_underflow | float_flag_output_denormal)) {
+        target_bits |= 0x20;
+    }
+    if (host_bits & float_flag_divbyzero) {
+        target_bits |= 0x10;
+    }
+    if (host_bits & float_flag_inexact) {
+        target_bits |= 0x08;
+    }
+    return target_bits;
+}
+
+/* Convert cpu_m68k exception flags to target form.  */
+static inline int cpu_m68k_exceptbits_to_host(int target_bits)
+{
+    int host_bits = 0;
+
+    if (target_bits & 0x80) {
+        host_bits |= float_flag_invalid;
+    }
+    if (target_bits & 0x40) {
+        host_bits |= float_flag_overflow;
+    }
+    if (target_bits & 0x20) {
+        host_bits |= float_flag_underflow;
+    }
+    if (target_bits & 0x10) {
+        host_bits |= float_flag_divbyzero;
+    }
+    if (target_bits & 0x08) {
+        host_bits |= float_flag_inexact;
+    }
+    return host_bits;
+}
+
+uint32_t HELPER(get_fpsr)(CPUM68KState *env)
+{
+    int host_flags = get_float_exception_flags(&env->fp_status);
+    int target_flags = cpu_m68k_exceptbits_from_host(host_flags);
+    int except = (env->fpsr & ~(0xf8)) | target_flags;
+    return except;
+}
+
+uint32_t cpu_m68k_get_fpsr(CPUM68KState *env)
+{
+    return HELPER(get_fpsr)(env);
+}
+
+void HELPER(set_fpsr)(CPUM68KState *env, uint32_t val)
+{
+    env->fpsr = val;
+
+    int host_flags = cpu_m68k_exceptbits_to_host((int) env->fpsr);
+    set_float_exception_flags(host_flags, &env->fp_status);
+}
+
+void cpu_m68k_set_fpsr(CPUM68KState *env, uint32_t val)
+{
+    return HELPER(set_fpsr)(env, val);
+}
+
 #define PREC_BEGIN(prec)                                        \
     do {                                                        \
         FloatX80RoundPrec old =                                 \
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 0a1544cd68..beab4b96bc 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -118,7 +118,7 @@ static int m68k_fpu_gdb_get_reg(CPUM68KState *env, GByteArray *mem_buf, int n)
     case 8: /* fpcontrol */
         return gdb_get_reg32(mem_buf, env->fpcr);
     case 9: /* fpstatus */
-        return gdb_get_reg32(mem_buf, env->fpsr);
+        return gdb_get_reg32(mem_buf, cpu_m68k_get_fpsr(env));
     case 10: /* fpiar, not implemented */
         return gdb_get_reg32(mem_buf, 0);
     }
@@ -137,7 +137,7 @@ static int m68k_fpu_gdb_set_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
         cpu_m68k_set_fpcr(env, ldl_p(mem_buf));
         return 4;
     case 9: /* fpstatus */
-        env->fpsr = ldl_p(mem_buf);
+        cpu_m68k_set_fpsr(env, ldl_p(mem_buf));
         return 4;
     case 10: /* fpiar, not implemented */
         return 4;
diff --git a/target/m68k/helper.h b/target/m68k/helper.h
index 2bbe0dc032..95aa5e53bb 100644
--- a/target/m68k/helper.h
+++ b/target/m68k/helper.h
@@ -54,6 +54,8 @@ DEF_HELPER_4(fsdiv, void, env, fp, fp, fp)
 DEF_HELPER_4(fddiv, void, env, fp, fp, fp)
 DEF_HELPER_4(fsgldiv, void, env, fp, fp, fp)
 DEF_HELPER_FLAGS_3(fcmp, TCG_CALL_NO_RWG, void, env, fp, fp)
+DEF_HELPER_2(set_fpsr, void, env, i32)
+DEF_HELPER_1(get_fpsr, i32, env)
 DEF_HELPER_FLAGS_2(set_fpcr, TCG_CALL_NO_RWG, void, env, i32)
 DEF_HELPER_FLAGS_2(ftst, TCG_CALL_NO_RWG, void, env, fp)
 DEF_HELPER_3(fconst, void, env, fp, i32)
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index d037c57453..360d054162 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -4718,7 +4718,7 @@ static void gen_load_fcr(DisasContext *s, TCGv res, int reg)
         tcg_gen_movi_i32(res, 0);
         break;
     case M68K_FPSR:
-        tcg_gen_ld_i32(res, cpu_env, offsetof(CPUM68KState, fpsr));
+        gen_helper_get_fpsr(res, cpu_env);
         break;
     case M68K_FPCR:
         tcg_gen_ld_i32(res, cpu_env, offsetof(CPUM68KState, fpcr));
@@ -4732,7 +4732,7 @@ static void gen_store_fcr(DisasContext *s, TCGv val, int reg)
     case M68K_FPIAR:
         break;
     case M68K_FPSR:
-        tcg_gen_st_i32(val, cpu_env, offsetof(CPUM68KState, fpsr));
+        gen_helper_set_fpsr(cpu_env, val);
         break;
     case M68K_FPCR:
         gen_helper_set_fpcr(cpu_env, val);
-- 
2.40.1


