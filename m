Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B859A7E09E6
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 21:08:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qz0Mu-0002f0-Ff; Fri, 03 Nov 2023 16:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qz0LR-0008Su-Ua
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 16:00:45 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qz0L7-0005fJ-SG
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 16:00:41 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32fb190bf9bso1158753f8f.1
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 13:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699041615; x=1699646415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KytR1mFE1e0nUwetK/l0lWU6QvQjID1KZxqMLq7Q7JY=;
 b=Z5K+jfqYhqO48It7NDFl3uC59ytvWkhEE48WNefny67xfZhkV9uFbfC6tDN+vz/SUK
 3VmEllkZLasnXqB5QDvGYUFLTdvyLIn5EsWVcaXIzIfB3vHLKG1qaKiWzQUS7e6qjx+Z
 Ybe4FmYtE0F8JTxSZ65YDgzPCzJ/zoTia9fgctpLgpxpzBOBt9VcDWqY3Y68M3GdPfWy
 vekzHwchpUb/JrA2U6SquA1Z9hmYTqzF+em993FNk6MV7U8wXYXIAhc7zghDTsNEgERT
 b9NnCORhaZWe9HnoQD5cIECLJZkMloSrpKr9o8tCZdkdWTiO9+a5I8t43KeGkMrYJe40
 oxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699041615; x=1699646415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KytR1mFE1e0nUwetK/l0lWU6QvQjID1KZxqMLq7Q7JY=;
 b=LC2VQEXEwE3C8Ub2RUfrleuZSa608tU7vtWmXrXFBUKrT77BKLszJOFyEWc4cmSEIc
 CJ3nI4oKhkalwJdORXcOQTjuFaqJd56fQRAMb5vuv7LJJ8+oXAURk61zkVtzmdv7aYWx
 j7BuzpucXo87uW7hraoOeC1RuUJSlVqemYcnHKkaa0DygPDM2YxVMZNvjeXP1U5mThox
 gbOYU/58xJCLnZWw4XXYDoeQJdlm+JZfZbH+cyPU0AI8yH5wvtdxTJsrkWCuLTpRvKh3
 RvdWPwOBMki5CedqqbI6QxxI6Jb3FdSS7WinGCmp3ko8DpIzzspg9UDz9ISQVAw5KqvE
 ClEQ==
X-Gm-Message-State: AOJu0YwSMFc1vNrnfhdmEUHYhqfRmrx+OPQZExr0JLb7hl/f27GrYsf+
 z3OhY6fuDq0EmAuBwz1F8IYyDg==
X-Google-Smtp-Source: AGHT+IEefdIuH1XSWTS43JKqI/rv5XXrYUBIvS/xtb+2JJpjwtQd7wj4aWZ7OJmbphMOepYQQJRktg==
X-Received: by 2002:a05:6000:1868:b0:32f:a254:c8b2 with SMTP id
 d8-20020a056000186800b0032fa254c8b2mr5151575wri.20.1699041615331; 
 Fri, 03 Nov 2023 13:00:15 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bd13-20020a05600c1f0d00b004078d71be9csm3539996wmb.13.2023.11.03.13.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 13:00:12 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6A6826574C;
 Fri,  3 Nov 2023 19:59:58 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Song Gao <gaosong@loongson.cn>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Brian Cain <bcain@quicinc.com>, qemu-ppc@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-s390x@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bin.meng@windriver.com>, Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 16/29] gdbstub: Change gdb_get_reg_cb and gdb_set_reg_cb
Date: Fri,  3 Nov 2023 19:59:43 +0000
Message-Id: <20231103195956.1998255-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103195956.1998255-1-alex.bennee@linaro.org>
References: <20231103195956.1998255-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Align the parameters of gdb_get_reg_cb and gdb_set_reg_cb with the
gdb_read_register and gdb_write_register members of CPUClass to allow
to unify the logic to access registers of the core and coprocessors
in the future.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231025093128.33116-10-akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/gdbstub.h      |  4 +-
 target/arm/internals.h      | 12 +++---
 target/hexagon/internal.h   |  4 +-
 target/microblaze/cpu.h     |  4 +-
 gdbstub/gdbstub.c           |  6 +--
 target/arm/gdbstub.c        | 51 ++++++++++++++++--------
 target/arm/gdbstub64.c      | 27 +++++++++----
 target/hexagon/gdbstub.c    | 10 ++++-
 target/loongarch/gdbstub.c  | 11 ++++--
 target/m68k/helper.c        | 20 ++++++++--
 target/microblaze/gdbstub.c |  9 ++++-
 target/ppc/gdbstub.c        | 46 +++++++++++++++++-----
 target/riscv/gdbstub.c      | 46 ++++++++++++++++------
 target/s390x/gdbstub.c      | 77 ++++++++++++++++++++++++++++---------
 14 files changed, 236 insertions(+), 91 deletions(-)

diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
index ac6fce99a6..bcaab1bc75 100644
--- a/include/exec/gdbstub.h
+++ b/include/exec/gdbstub.h
@@ -24,8 +24,8 @@ typedef struct GDBFeatureBuilder {
 
 
 /* Get or set a register.  Returns the size of the register.  */
-typedef int (*gdb_get_reg_cb)(CPUArchState *env, GByteArray *buf, int reg);
-typedef int (*gdb_set_reg_cb)(CPUArchState *env, uint8_t *buf, int reg);
+typedef int (*gdb_get_reg_cb)(CPUState *cpu, GByteArray *buf, int reg);
+typedef int (*gdb_set_reg_cb)(CPUState *cpu, uint8_t *buf, int reg);
 
 /**
  * gdb_register_coprocessor() - register a supplemental set of registers
diff --git a/target/arm/internals.h b/target/arm/internals.h
index 989416e613..4ef5137967 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1441,12 +1441,12 @@ static inline uint64_t pmu_counter_mask(CPUARMState *env)
 
 #ifdef TARGET_AARCH64
 GDBFeature *arm_gen_dynamic_svereg_feature(CPUState *cpu, int base_reg);
-int aarch64_gdb_get_sve_reg(CPUARMState *env, GByteArray *buf, int reg);
-int aarch64_gdb_set_sve_reg(CPUARMState *env, uint8_t *buf, int reg);
-int aarch64_gdb_get_fpu_reg(CPUARMState *env, GByteArray *buf, int reg);
-int aarch64_gdb_set_fpu_reg(CPUARMState *env, uint8_t *buf, int reg);
-int aarch64_gdb_get_pauth_reg(CPUARMState *env, GByteArray *buf, int reg);
-int aarch64_gdb_set_pauth_reg(CPUARMState *env, uint8_t *buf, int reg);
+int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg);
+int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg);
+int aarch64_gdb_get_fpu_reg(CPUState *cs, GByteArray *buf, int reg);
+int aarch64_gdb_set_fpu_reg(CPUState *cs, uint8_t *buf, int reg);
+int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg);
+int aarch64_gdb_set_pauth_reg(CPUState *cs, uint8_t *buf, int reg);
 void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp);
 void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp);
 void arm_cpu_pauth_finalize(ARMCPU *cpu, Error **errp);
diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
index d732b6bb3c..beb08cb7e3 100644
--- a/target/hexagon/internal.h
+++ b/target/hexagon/internal.h
@@ -33,8 +33,8 @@
 
 int hexagon_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int hexagon_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
-int hexagon_hvx_gdb_read_register(CPUHexagonState *env, GByteArray *mem_buf, int n);
-int hexagon_hvx_gdb_write_register(CPUHexagonState *env, uint8_t *mem_buf, int n);
+int hexagon_hvx_gdb_read_register(CPUState *env, GByteArray *mem_buf, int n);
+int hexagon_hvx_gdb_write_register(CPUState *env, uint8_t *mem_buf, int n);
 
 void hexagon_debug_vreg(CPUHexagonState *env, int regnum);
 void hexagon_debug_qreg(CPUHexagonState *env, int regnum);
diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index e43c49d4af..c14b3357b7 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -370,8 +370,8 @@ G_NORETURN void mb_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
 void mb_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 int mb_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int mb_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
-int mb_cpu_gdb_read_stack_protect(CPUArchState *cpu, GByteArray *buf, int reg);
-int mb_cpu_gdb_write_stack_protect(CPUArchState *cpu, uint8_t *buf, int reg);
+int mb_cpu_gdb_read_stack_protect(CPUState *cs, GByteArray *buf, int reg);
+int mb_cpu_gdb_write_stack_protect(CPUState *cs, uint8_t *buf, int reg);
 
 static inline uint32_t mb_cpu_read_msr(const CPUMBState *env)
 {
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index ebabbc00f6..4809c90c4a 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -502,7 +502,6 @@ const GDBFeature *gdb_find_static_feature(const char *xmlname)
 static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
-    CPUArchState *env = cpu_env(cpu);
     GDBRegisterState *r;
 
     if (reg < cc->gdb_num_core_regs) {
@@ -513,7 +512,7 @@ static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
         for (guint i = 0; i < cpu->gdb_regs->len; i++) {
             r = &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
             if (r->base_reg <= reg && reg < r->base_reg + r->feature->num_regs) {
-                return r->get_reg(env, buf, reg - r->base_reg);
+                return r->get_reg(cpu, buf, reg - r->base_reg);
             }
         }
     }
@@ -523,7 +522,6 @@ static int gdb_read_register(CPUState *cpu, GByteArray *buf, int reg)
 static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
-    CPUArchState *env = cpu_env(cpu);
     GDBRegisterState *r;
 
     if (reg < cc->gdb_num_core_regs) {
@@ -534,7 +532,7 @@ static int gdb_write_register(CPUState *cpu, uint8_t *mem_buf, int reg)
         for (guint i = 0; i < cpu->gdb_regs->len; i++) {
             r =  &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
             if (r->base_reg <= reg && reg < r->base_reg + r->feature->num_regs) {
-                return r->set_reg(env, mem_buf, reg - r->base_reg);
+                return r->set_reg(cpu, mem_buf, reg - r->base_reg);
             }
         }
     }
diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index f2b201d312..059d84f98e 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -106,9 +106,10 @@ int arm_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     return 0;
 }
 
-static int vfp_gdb_get_reg(CPUARMState *env, GByteArray *buf, int reg)
+static int vfp_gdb_get_reg(CPUState *cs, GByteArray *buf, int reg)
 {
-    ARMCPU *cpu = env_archcpu(env);
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
     int nregs = cpu_isar_feature(aa32_simd_r32, cpu) ? 32 : 16;
 
     /* VFP data registers are always little-endian.  */
@@ -130,9 +131,10 @@ static int vfp_gdb_get_reg(CPUARMState *env, GByteArray *buf, int reg)
     return 0;
 }
 
-static int vfp_gdb_set_reg(CPUARMState *env, uint8_t *buf, int reg)
+static int vfp_gdb_set_reg(CPUState *cs, uint8_t *buf, int reg)
 {
-    ARMCPU *cpu = env_archcpu(env);
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
     int nregs = cpu_isar_feature(aa32_simd_r32, cpu) ? 32 : 16;
 
     if (reg < nregs) {
@@ -156,8 +158,11 @@ static int vfp_gdb_set_reg(CPUARMState *env, uint8_t *buf, int reg)
     return 0;
 }
 
-static int vfp_gdb_get_sysreg(CPUARMState *env, GByteArray *buf, int reg)
+static int vfp_gdb_get_sysreg(CPUState *cs, GByteArray *buf, int reg)
 {
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
     switch (reg) {
     case 0:
         return gdb_get_reg32(buf, env->vfp.xregs[ARM_VFP_FPSID]);
@@ -167,8 +172,11 @@ static int vfp_gdb_get_sysreg(CPUARMState *env, GByteArray *buf, int reg)
     return 0;
 }
 
-static int vfp_gdb_set_sysreg(CPUARMState *env, uint8_t *buf, int reg)
+static int vfp_gdb_set_sysreg(CPUState *cs, uint8_t *buf, int reg)
 {
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
     switch (reg) {
     case 0:
         env->vfp.xregs[ARM_VFP_FPSID] = ldl_p(buf);
@@ -180,8 +188,11 @@ static int vfp_gdb_set_sysreg(CPUARMState *env, uint8_t *buf, int reg)
     return 0;
 }
 
-static int mve_gdb_get_reg(CPUARMState *env, GByteArray *buf, int reg)
+static int mve_gdb_get_reg(CPUState *cs, GByteArray *buf, int reg)
 {
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
     switch (reg) {
     case 0:
         return gdb_get_reg32(buf, env->v7m.vpr);
@@ -190,8 +201,11 @@ static int mve_gdb_get_reg(CPUARMState *env, GByteArray *buf, int reg)
     }
 }
 
-static int mve_gdb_set_reg(CPUARMState *env, uint8_t *buf, int reg)
+static int mve_gdb_set_reg(CPUState *cs, uint8_t *buf, int reg)
 {
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
     switch (reg) {
     case 0:
         env->v7m.vpr = ldl_p(buf);
@@ -210,9 +224,10 @@ static int mve_gdb_set_reg(CPUARMState *env, uint8_t *buf, int reg)
  * We return the number of bytes copied
  */
 
-static int arm_gdb_get_sysreg(CPUARMState *env, GByteArray *buf, int reg)
+static int arm_gdb_get_sysreg(CPUState *cs, GByteArray *buf, int reg)
 {
-    ARMCPU *cpu = env_archcpu(env);
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
     const ARMCPRegInfo *ri;
     uint32_t key;
 
@@ -228,7 +243,7 @@ static int arm_gdb_get_sysreg(CPUARMState *env, GByteArray *buf, int reg)
     return 0;
 }
 
-static int arm_gdb_set_sysreg(CPUARMState *env, uint8_t *buf, int reg)
+static int arm_gdb_set_sysreg(CPUState *cs, uint8_t *buf, int reg)
 {
     return 0;
 }
@@ -367,8 +382,11 @@ static int m_sysreg_get(CPUARMState *env, GByteArray *buf,
     return gdb_get_reg32(buf, *ptr);
 }
 
-static int arm_gdb_get_m_systemreg(CPUARMState *env, GByteArray *buf, int reg)
+static int arm_gdb_get_m_systemreg(CPUState *cs, GByteArray *buf, int reg)
 {
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
     /*
      * Here, we emulate MRS instruction, where CONTROL has a mix of
      * banked and non-banked bits.
@@ -379,7 +397,7 @@ static int arm_gdb_get_m_systemreg(CPUARMState *env, GByteArray *buf, int reg)
     return m_sysreg_get(env, buf, reg, env->v7m.secure);
 }
 
-static int arm_gdb_set_m_systemreg(CPUARMState *env, uint8_t *buf, int reg)
+static int arm_gdb_set_m_systemreg(CPUState *cs, uint8_t *buf, int reg)
 {
     return 0; /* TODO */
 }
@@ -414,12 +432,15 @@ static GDBFeature *arm_gen_dynamic_m_systemreg_feature(CPUState *cs,
  * For user-only, we see the non-secure registers via m_systemreg above.
  * For secext, encode the non-secure view as even and secure view as odd.
  */
-static int arm_gdb_get_m_secextreg(CPUARMState *env, GByteArray *buf, int reg)
+static int arm_gdb_get_m_secextreg(CPUState *cs, GByteArray *buf, int reg)
 {
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
     return m_sysreg_get(env, buf, reg >> 1, reg & 1);
 }
 
-static int arm_gdb_set_m_secextreg(CPUARMState *env, uint8_t *buf, int reg)
+static int arm_gdb_set_m_secextreg(CPUState *cs, uint8_t *buf, int reg)
 {
     return 0; /* TODO */
 }
diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 5286d5c604..caa31ff3fa 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -72,8 +72,11 @@ int aarch64_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     return 0;
 }
 
-int aarch64_gdb_get_fpu_reg(CPUARMState *env, GByteArray *buf, int reg)
+int aarch64_gdb_get_fpu_reg(CPUState *cs, GByteArray *buf, int reg)
 {
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
     switch (reg) {
     case 0 ... 31:
     {
@@ -92,8 +95,11 @@ int aarch64_gdb_get_fpu_reg(CPUARMState *env, GByteArray *buf, int reg)
     }
 }
 
-int aarch64_gdb_set_fpu_reg(CPUARMState *env, uint8_t *buf, int reg)
+int aarch64_gdb_set_fpu_reg(CPUState *cs, uint8_t *buf, int reg)
 {
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
     switch (reg) {
     case 0 ... 31:
         /* 128 bit FP register */
@@ -116,9 +122,10 @@ int aarch64_gdb_set_fpu_reg(CPUARMState *env, uint8_t *buf, int reg)
     }
 }
 
-int aarch64_gdb_get_sve_reg(CPUARMState *env, GByteArray *buf, int reg)
+int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg)
 {
-    ARMCPU *cpu = env_archcpu(env);
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
 
     switch (reg) {
     /* The first 32 registers are the zregs */
@@ -164,9 +171,10 @@ int aarch64_gdb_get_sve_reg(CPUARMState *env, GByteArray *buf, int reg)
     return 0;
 }
 
-int aarch64_gdb_set_sve_reg(CPUARMState *env, uint8_t *buf, int reg)
+int aarch64_gdb_set_sve_reg(CPUState *cs, uint8_t *buf, int reg)
 {
-    ARMCPU *cpu = env_archcpu(env);
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
 
     /* The first 32 registers are the zregs */
     switch (reg) {
@@ -210,8 +218,11 @@ int aarch64_gdb_set_sve_reg(CPUARMState *env, uint8_t *buf, int reg)
     return 0;
 }
 
-int aarch64_gdb_get_pauth_reg(CPUARMState *env, GByteArray *buf, int reg)
+int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg)
 {
+    ARMCPU *cpu = ARM_CPU(cs);
+    CPUARMState *env = &cpu->env;
+
     switch (reg) {
     case 0: /* pauth_dmask */
     case 1: /* pauth_cmask */
@@ -241,7 +252,7 @@ int aarch64_gdb_get_pauth_reg(CPUARMState *env, GByteArray *buf, int reg)
     }
 }
 
-int aarch64_gdb_set_pauth_reg(CPUARMState *env, uint8_t *buf, int reg)
+int aarch64_gdb_set_pauth_reg(CPUState *cs, uint8_t *buf, int reg)
 {
     /* All pseudo registers are read-only. */
     return 0;
diff --git a/target/hexagon/gdbstub.c b/target/hexagon/gdbstub.c
index 54d37e006e..6007e6462b 100644
--- a/target/hexagon/gdbstub.c
+++ b/target/hexagon/gdbstub.c
@@ -81,8 +81,11 @@ static int gdb_get_qreg(CPUHexagonState *env, GByteArray *mem_buf, int n)
     return total;
 }
 
-int hexagon_hvx_gdb_read_register(CPUHexagonState *env, GByteArray *mem_buf, int n)
+int hexagon_hvx_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
+    HexagonCPU *cpu = HEXAGON_CPU(cs);
+    CPUHexagonState *env = &cpu->env;
+
     if (n < NUM_VREGS) {
         return gdb_get_vreg(env, mem_buf, n);
     }
@@ -115,8 +118,11 @@ static int gdb_put_qreg(CPUHexagonState *env, uint8_t *mem_buf, int n)
     return MAX_VEC_SIZE_BYTES / 8;
 }
 
-int hexagon_hvx_gdb_write_register(CPUHexagonState *env, uint8_t *mem_buf, int n)
+int hexagon_hvx_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
+    HexagonCPU *cpu = HEXAGON_CPU(cs);
+    CPUHexagonState *env = &cpu->env;
+
    if (n < NUM_VREGS) {
         return gdb_put_vreg(env, mem_buf, n);
     }
diff --git a/target/loongarch/gdbstub.c b/target/loongarch/gdbstub.c
index 843a869450..22c6889011 100644
--- a/target/loongarch/gdbstub.c
+++ b/target/loongarch/gdbstub.c
@@ -84,9 +84,11 @@ int loongarch_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     return length;
 }
 
-static int loongarch_gdb_get_fpu(CPULoongArchState *env,
-                                 GByteArray *mem_buf, int n)
+static int loongarch_gdb_get_fpu(CPUState *cs, GByteArray *mem_buf, int n)
 {
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = &cpu->env;
+
     if (0 <= n && n < 32) {
         return gdb_get_reg64(mem_buf, env->fpr[n].vreg.D(0));
     } else if (32 <= n && n < 40) {
@@ -97,9 +99,10 @@ static int loongarch_gdb_get_fpu(CPULoongArchState *env,
     return 0;
 }
 
-static int loongarch_gdb_set_fpu(CPULoongArchState *env,
-                                 uint8_t *mem_buf, int n)
+static int loongarch_gdb_set_fpu(CPUState *cs, uint8_t *mem_buf, int n)
 {
+    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
+    CPULoongArchState *env = &cpu->env;
     int length = 0;
 
     if (0 <= n && n < 32) {
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 675f2dcd5a..a5ee4d87e3 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -69,8 +69,11 @@ void m68k_cpu_list(void)
     g_slist_free(list);
 }
 
-static int cf_fpu_gdb_get_reg(CPUM68KState *env, GByteArray *mem_buf, int n)
+static int cf_fpu_gdb_get_reg(CPUState *cs, GByteArray *mem_buf, int n)
 {
+    M68kCPU *cpu = M68K_CPU(cs);
+    CPUM68KState *env = &cpu->env;
+
     if (n < 8) {
         float_status s;
         return gdb_get_reg64(mem_buf, floatx80_to_float64(env->fregs[n].d, &s));
@@ -86,8 +89,11 @@ static int cf_fpu_gdb_get_reg(CPUM68KState *env, GByteArray *mem_buf, int n)
     return 0;
 }
 
-static int cf_fpu_gdb_set_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
+static int cf_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
 {
+    M68kCPU *cpu = M68K_CPU(cs);
+    CPUM68KState *env = &cpu->env;
+
     if (n < 8) {
         float_status s;
         env->fregs[n].d = float64_to_floatx80(ldq_p(mem_buf), &s);
@@ -106,8 +112,11 @@ static int cf_fpu_gdb_set_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
     return 0;
 }
 
-static int m68k_fpu_gdb_get_reg(CPUM68KState *env, GByteArray *mem_buf, int n)
+static int m68k_fpu_gdb_get_reg(CPUState *cs, GByteArray *mem_buf, int n)
 {
+    M68kCPU *cpu = M68K_CPU(cs);
+    CPUM68KState *env = &cpu->env;
+
     if (n < 8) {
         int len = gdb_get_reg16(mem_buf, env->fregs[n].l.upper);
         len += gdb_get_reg16(mem_buf, 0);
@@ -125,8 +134,11 @@ static int m68k_fpu_gdb_get_reg(CPUM68KState *env, GByteArray *mem_buf, int n)
     return 0;
 }
 
-static int m68k_fpu_gdb_set_reg(CPUM68KState *env, uint8_t *mem_buf, int n)
+static int m68k_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
 {
+    M68kCPU *cpu = M68K_CPU(cs);
+    CPUM68KState *env = &cpu->env;
+
     if (n < 8) {
         env->fregs[n].l.upper = lduw_be_p(mem_buf);
         env->fregs[n].l.lower = ldq_be_p(mem_buf + 4);
diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index 29ac6e9c0f..6ffc5ad075 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -94,8 +94,10 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
     return gdb_get_reg32(mem_buf, val);
 }
 
-int mb_cpu_gdb_read_stack_protect(CPUMBState *env, GByteArray *mem_buf, int n)
+int mb_cpu_gdb_read_stack_protect(CPUState *cs, GByteArray *mem_buf, int n)
 {
+    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
+    CPUMBState *env = &cpu->env;
     uint32_t val;
 
     switch (n) {
@@ -153,8 +155,11 @@ int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     return 4;
 }
 
-int mb_cpu_gdb_write_stack_protect(CPUMBState *env, uint8_t *mem_buf, int n)
+int mb_cpu_gdb_write_stack_protect(CPUState *cs, uint8_t *mem_buf, int n)
 {
+    MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
+    CPUMBState *env = &cpu->env;
+
     switch (n) {
     case GDB_SP_SHL:
         env->slr = ldl_p(mem_buf);
diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
index 09b852464f..8ca37b6bf9 100644
--- a/target/ppc/gdbstub.c
+++ b/target/ppc/gdbstub.c
@@ -369,8 +369,10 @@ static int gdb_find_spr_idx(CPUPPCState *env, int n)
     return -1;
 }
 
-static int gdb_get_spr_reg(CPUPPCState *env, GByteArray *buf, int n)
+static int gdb_get_spr_reg(CPUState *cs, GByteArray *buf, int n)
 {
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
     int reg;
     int len;
 
@@ -385,8 +387,10 @@ static int gdb_get_spr_reg(CPUPPCState *env, GByteArray *buf, int n)
     return len;
 }
 
-static int gdb_set_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
+static int gdb_set_spr_reg(CPUState *cs, uint8_t *mem_buf, int n)
 {
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
     int reg;
     int len;
 
@@ -403,8 +407,10 @@ static int gdb_set_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
 }
 #endif
 
-static int gdb_get_float_reg(CPUPPCState *env, GByteArray *buf, int n)
+static int gdb_get_float_reg(CPUState *cs, GByteArray *buf, int n)
 {
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
     uint8_t *mem_buf;
     if (n < 32) {
         gdb_get_reg64(buf, *cpu_fpr_ptr(env, n));
@@ -421,8 +427,11 @@ static int gdb_get_float_reg(CPUPPCState *env, GByteArray *buf, int n)
     return 0;
 }
 
-static int gdb_set_float_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
+static int gdb_set_float_reg(CPUState *cs, uint8_t *mem_buf, int n)
 {
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+
     if (n < 32) {
         ppc_maybe_bswap_register(env, mem_buf, 8);
         *cpu_fpr_ptr(env, n) = ldq_p(mem_buf);
@@ -436,8 +445,10 @@ static int gdb_set_float_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
     return 0;
 }
 
-static int gdb_get_avr_reg(CPUPPCState *env, GByteArray *buf, int n)
+static int gdb_get_avr_reg(CPUState *cs, GByteArray *buf, int n)
 {
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
     uint8_t *mem_buf;
 
     if (n < 32) {
@@ -462,8 +473,11 @@ static int gdb_get_avr_reg(CPUPPCState *env, GByteArray *buf, int n)
     return 0;
 }
 
-static int gdb_set_avr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
+static int gdb_set_avr_reg(CPUState *cs, uint8_t *mem_buf, int n)
 {
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+
     if (n < 32) {
         ppc_avr_t *avr = cpu_avr_ptr(env, n);
         ppc_maybe_bswap_register(env, mem_buf, 16);
@@ -484,8 +498,11 @@ static int gdb_set_avr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
     return 0;
 }
 
-static int gdb_get_spe_reg(CPUPPCState *env, GByteArray *buf, int n)
+static int gdb_get_spe_reg(CPUState *cs, GByteArray *buf, int n)
 {
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+
     if (n < 32) {
 #if defined(TARGET_PPC64)
         gdb_get_reg32(buf, env->gpr[n] >> 32);
@@ -508,8 +525,11 @@ static int gdb_get_spe_reg(CPUPPCState *env, GByteArray *buf, int n)
     return 0;
 }
 
-static int gdb_set_spe_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
+static int gdb_set_spe_reg(CPUState *cs, uint8_t *mem_buf, int n)
 {
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+
     if (n < 32) {
 #if defined(TARGET_PPC64)
         target_ulong lo = (uint32_t)env->gpr[n];
@@ -537,8 +557,11 @@ static int gdb_set_spe_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
     return 0;
 }
 
-static int gdb_get_vsx_reg(CPUPPCState *env, GByteArray *buf, int n)
+static int gdb_get_vsx_reg(CPUState *cs, GByteArray *buf, int n)
 {
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+
     if (n < 32) {
         gdb_get_reg64(buf, *cpu_vsrl_ptr(env, n));
         ppc_maybe_bswap_register(env, gdb_get_reg_ptr(buf, 8), 8);
@@ -547,8 +570,11 @@ static int gdb_get_vsx_reg(CPUPPCState *env, GByteArray *buf, int n)
     return 0;
 }
 
-static int gdb_set_vsx_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
+static int gdb_set_vsx_reg(CPUState *cs, uint8_t *mem_buf, int n)
 {
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+    CPUPPCState *env = &cpu->env;
+
     if (n < 32) {
         ppc_maybe_bswap_register(env, mem_buf, 8);
         *cpu_vsrl_ptr(env, n) = ldq_p(mem_buf);
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index df2e6335b5..9553ad62a3 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -106,8 +106,11 @@ int riscv_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
     return length;
 }
 
-static int riscv_gdb_get_fpu(CPURISCVState *env, GByteArray *buf, int n)
+static int riscv_gdb_get_fpu(CPUState *cs, GByteArray *buf, int n)
 {
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+
     if (n < 32) {
         if (env->misa_ext & RVD) {
             return gdb_get_reg64(buf, env->fpr[n]);
@@ -119,8 +122,11 @@ static int riscv_gdb_get_fpu(CPURISCVState *env, GByteArray *buf, int n)
     return 0;
 }
 
-static int riscv_gdb_set_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
+static int riscv_gdb_set_fpu(CPUState *cs, uint8_t *mem_buf, int n)
 {
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+
     if (n < 32) {
         env->fpr[n] = ldq_p(mem_buf); /* always 64-bit */
         return sizeof(uint64_t);
@@ -128,8 +134,10 @@ static int riscv_gdb_set_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
     return 0;
 }
 
-static int riscv_gdb_get_vector(CPURISCVState *env, GByteArray *buf, int n)
+static int riscv_gdb_get_vector(CPUState *cs, GByteArray *buf, int n)
 {
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
     uint16_t vlenb = riscv_cpu_cfg(env)->vlen >> 3;
     if (n < 32) {
         int i;
@@ -144,8 +152,10 @@ static int riscv_gdb_get_vector(CPURISCVState *env, GByteArray *buf, int n)
     return 0;
 }
 
-static int riscv_gdb_set_vector(CPURISCVState *env, uint8_t *mem_buf, int n)
+static int riscv_gdb_set_vector(CPUState *cs, uint8_t *mem_buf, int n)
 {
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
     uint16_t vlenb = riscv_cpu_cfg(env)->vlen >> 3;
     if (n < 32) {
         int i;
@@ -158,8 +168,11 @@ static int riscv_gdb_set_vector(CPURISCVState *env, uint8_t *mem_buf, int n)
     return 0;
 }
 
-static int riscv_gdb_get_csr(CPURISCVState *env, GByteArray *buf, int n)
+static int riscv_gdb_get_csr(CPUState *cs, GByteArray *buf, int n)
 {
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+
     if (n < CSR_TABLE_SIZE) {
         target_ulong val = 0;
         int result;
@@ -172,8 +185,11 @@ static int riscv_gdb_get_csr(CPURISCVState *env, GByteArray *buf, int n)
     return 0;
 }
 
-static int riscv_gdb_set_csr(CPURISCVState *env, uint8_t *mem_buf, int n)
+static int riscv_gdb_set_csr(CPUState *cs, uint8_t *mem_buf, int n)
 {
+    RISCVCPU *cpu = RISCV_CPU(cs);
+    CPURISCVState *env = &cpu->env;
+
     if (n < CSR_TABLE_SIZE) {
         target_ulong val = ldtul_p(mem_buf);
         int result;
@@ -186,25 +202,31 @@ static int riscv_gdb_set_csr(CPURISCVState *env, uint8_t *mem_buf, int n)
     return 0;
 }
 
-static int riscv_gdb_get_virtual(CPURISCVState *cs, GByteArray *buf, int n)
+static int riscv_gdb_get_virtual(CPUState *cs, GByteArray *buf, int n)
 {
     if (n == 0) {
 #ifdef CONFIG_USER_ONLY
         return gdb_get_regl(buf, 0);
 #else
-        return gdb_get_regl(buf, cs->priv);
+        RISCVCPU *cpu = RISCV_CPU(cs);
+        CPURISCVState *env = &cpu->env;
+
+        return gdb_get_regl(buf, env->priv);
 #endif
     }
     return 0;
 }
 
-static int riscv_gdb_set_virtual(CPURISCVState *cs, uint8_t *mem_buf, int n)
+static int riscv_gdb_set_virtual(CPUState *cs, uint8_t *mem_buf, int n)
 {
     if (n == 0) {
 #ifndef CONFIG_USER_ONLY
-        cs->priv = ldtul_p(mem_buf) & 0x3;
-        if (cs->priv == PRV_RESERVED) {
-            cs->priv = PRV_S;
+        RISCVCPU *cpu = RISCV_CPU(cs);
+        CPURISCVState *env = &cpu->env;
+
+        env->priv = ldtul_p(mem_buf) & 0x3;
+        if (env->priv == PRV_RESERVED) {
+            env->priv = PRV_S;
         }
 #endif
         return sizeof(target_ulong);
diff --git a/target/s390x/gdbstub.c b/target/s390x/gdbstub.c
index 02c388dc32..c1e7c59b82 100644
--- a/target/s390x/gdbstub.c
+++ b/target/s390x/gdbstub.c
@@ -70,8 +70,11 @@ int s390_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 #define S390_A0_REGNUM 0
 #define S390_A15_REGNUM 15
 
-static int cpu_read_ac_reg(CPUS390XState *env, GByteArray *buf, int n)
+static int cpu_read_ac_reg(CPUState *cs, GByteArray *buf, int n)
 {
+    S390CPU *cpu = S390_CPU(cs);
+    CPUS390XState *env = &cpu->env;
+
     switch (n) {
     case S390_A0_REGNUM ... S390_A15_REGNUM:
         return gdb_get_reg32(buf, env->aregs[n]);
@@ -80,8 +83,11 @@ static int cpu_read_ac_reg(CPUS390XState *env, GByteArray *buf, int n)
     }
 }
 
-static int cpu_write_ac_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
+static int cpu_write_ac_reg(CPUState *cs, uint8_t *mem_buf, int n)
 {
+    S390CPU *cpu = S390_CPU(cs);
+    CPUS390XState *env = &cpu->env;
+
     switch (n) {
     case S390_A0_REGNUM ... S390_A15_REGNUM:
         env->aregs[n] = ldl_p(mem_buf);
@@ -97,8 +103,11 @@ static int cpu_write_ac_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
 #define S390_F0_REGNUM 1
 #define S390_F15_REGNUM 16
 
-static int cpu_read_fp_reg(CPUS390XState *env, GByteArray *buf, int n)
+static int cpu_read_fp_reg(CPUState *cs, GByteArray *buf, int n)
 {
+    S390CPU *cpu = S390_CPU(cs);
+    CPUS390XState *env = &cpu->env;
+
     switch (n) {
     case S390_FPC_REGNUM:
         return gdb_get_reg32(buf, env->fpc);
@@ -109,8 +118,11 @@ static int cpu_read_fp_reg(CPUS390XState *env, GByteArray *buf, int n)
     }
 }
 
-static int cpu_write_fp_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
+static int cpu_write_fp_reg(CPUState *cs, uint8_t *mem_buf, int n)
 {
+    S390CPU *cpu = S390_CPU(cs);
+    CPUS390XState *env = &cpu->env;
+
     switch (n) {
     case S390_FPC_REGNUM:
         env->fpc = ldl_p(mem_buf);
@@ -129,8 +141,10 @@ static int cpu_write_fp_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
 #define S390_V16_REGNUM 16
 #define S390_V31_REGNUM 31
 
-static int cpu_read_vreg(CPUS390XState *env, GByteArray *buf, int n)
+static int cpu_read_vreg(CPUState *cs, GByteArray *buf, int n)
 {
+    S390CPU *cpu = S390_CPU(cs);
+    CPUS390XState *env = &cpu->env;
     int ret;
 
     switch (n) {
@@ -148,8 +162,11 @@ static int cpu_read_vreg(CPUS390XState *env, GByteArray *buf, int n)
     return ret;
 }
 
-static int cpu_write_vreg(CPUS390XState *env, uint8_t *mem_buf, int n)
+static int cpu_write_vreg(CPUState *cs, uint8_t *mem_buf, int n)
 {
+    S390CPU *cpu = S390_CPU(cs);
+    CPUS390XState *env = &cpu->env;
+
     switch (n) {
     case S390_V0L_REGNUM ... S390_V15L_REGNUM:
         env->vregs[n][1] = ldtul_p(mem_buf + 8);
@@ -168,8 +185,11 @@ static int cpu_write_vreg(CPUS390XState *env, uint8_t *mem_buf, int n)
 #define S390_C15_REGNUM 15
 
 #ifndef CONFIG_USER_ONLY
-static int cpu_read_c_reg(CPUS390XState *env, GByteArray *buf, int n)
+static int cpu_read_c_reg(CPUState *cs, GByteArray *buf, int n)
 {
+    S390CPU *cpu = S390_CPU(cs);
+    CPUS390XState *env = &cpu->env;
+
     switch (n) {
     case S390_C0_REGNUM ... S390_C15_REGNUM:
         return gdb_get_regl(buf, env->cregs[n]);
@@ -178,8 +198,11 @@ static int cpu_read_c_reg(CPUS390XState *env, GByteArray *buf, int n)
     }
 }
 
-static int cpu_write_c_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
+static int cpu_write_c_reg(CPUState *cs, uint8_t *mem_buf, int n)
 {
+    S390CPU *cpu = S390_CPU(cs);
+    CPUS390XState *env = &cpu->env;
+
     switch (n) {
     case S390_C0_REGNUM ... S390_C15_REGNUM:
         env->cregs[n] = ldtul_p(mem_buf);
@@ -199,8 +222,11 @@ static int cpu_write_c_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
 #define S390_VIRT_BEA_REGNUM    2
 #define S390_VIRT_PREFIX_REGNUM 3
 
-static int cpu_read_virt_reg(CPUS390XState *env, GByteArray *mem_buf, int n)
+static int cpu_read_virt_reg(CPUState *cs, GByteArray *mem_buf, int n)
 {
+    S390CPU *cpu = S390_CPU(cs);
+    CPUS390XState *env = &cpu->env;
+
     switch (n) {
     case S390_VIRT_CKC_REGNUM:
         return gdb_get_regl(mem_buf, env->ckc);
@@ -215,24 +241,27 @@ static int cpu_read_virt_reg(CPUS390XState *env, GByteArray *mem_buf, int n)
     }
 }
 
-static int cpu_write_virt_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
+static int cpu_write_virt_reg(CPUState *cs, uint8_t *mem_buf, int n)
 {
+    S390CPU *cpu = S390_CPU(cs);
+    CPUS390XState *env = &cpu->env;
+
     switch (n) {
     case S390_VIRT_CKC_REGNUM:
         env->ckc = ldtul_p(mem_buf);
-        cpu_synchronize_post_init(env_cpu(env));
+        cpu_synchronize_post_init(cs);
         return 8;
     case S390_VIRT_CPUTM_REGNUM:
         env->cputm = ldtul_p(mem_buf);
-        cpu_synchronize_post_init(env_cpu(env));
+        cpu_synchronize_post_init(cs);
         return 8;
     case S390_VIRT_BEA_REGNUM:
         env->gbea = ldtul_p(mem_buf);
-        cpu_synchronize_post_init(env_cpu(env));
+        cpu_synchronize_post_init(cs);
         return 8;
     case S390_VIRT_PREFIX_REGNUM:
         env->psa = ldtul_p(mem_buf);
-        cpu_synchronize_post_init(env_cpu(env));
+        cpu_synchronize_post_init(cs);
         return 8;
     default:
         return 0;
@@ -245,8 +274,11 @@ static int cpu_write_virt_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
 #define S390_VIRT_KVM_PFS_REGNUM    2
 #define S390_VIRT_KVM_PFC_REGNUM    3
 
-static int cpu_read_virt_kvm_reg(CPUS390XState *env, GByteArray *mem_buf, int n)
+static int cpu_read_virt_kvm_reg(CPUState *cs, GByteArray *mem_buf, int n)
 {
+    S390CPU *cpu = S390_CPU(cs);
+    CPUS390XState *env = &cpu->env;
+
     switch (n) {
     case S390_VIRT_KVM_PP_REGNUM:
         return gdb_get_regl(mem_buf, env->pp);
@@ -261,8 +293,11 @@ static int cpu_read_virt_kvm_reg(CPUS390XState *env, GByteArray *mem_buf, int n)
     }
 }
 
-static int cpu_write_virt_kvm_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
+static int cpu_write_virt_kvm_reg(CPUState *cs, uint8_t *mem_buf, int n)
 {
+    S390CPU *cpu = S390_CPU(cs);
+    CPUS390XState *env = &cpu->env;
+
     switch (n) {
     case S390_VIRT_KVM_PP_REGNUM:
         env->pp = ldtul_p(mem_buf);
@@ -292,13 +327,19 @@ static int cpu_write_virt_kvm_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
 #define S390_GS_GSSM_REGNUM     2
 #define S390_GS_GSEPLA_REGNUM   3
 
-static int cpu_read_gs_reg(CPUS390XState *env, GByteArray *buf, int n)
+static int cpu_read_gs_reg(CPUState *cs, GByteArray *buf, int n)
 {
+    S390CPU *cpu = S390_CPU(cs);
+    CPUS390XState *env = &cpu->env;
+
     return gdb_get_regl(buf, env->gscb[n]);
 }
 
-static int cpu_write_gs_reg(CPUS390XState *env, uint8_t *mem_buf, int n)
+static int cpu_write_gs_reg(CPUState *cs, uint8_t *mem_buf, int n)
 {
+    S390CPU *cpu = S390_CPU(cs);
+    CPUS390XState *env = &cpu->env;
+
     env->gscb[n] = ldtul_p(mem_buf);
     cpu_synchronize_post_init(env_cpu(env));
     return 8;
-- 
2.39.2


