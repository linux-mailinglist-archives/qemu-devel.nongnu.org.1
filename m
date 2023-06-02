Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FA0720C24
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 00:59:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5Diz-0002pp-Pg; Fri, 02 Jun 2023 18:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5Dix-0002pR-PR
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 18:58:23 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5Div-00009l-F0
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 18:58:23 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f6da07feb2so25890545e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 15:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685746700; x=1688338700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cKBN9AwMdwMiOqgeVlfxVELcyFeZ63ZFm1bX/J3jfrw=;
 b=wBqN6XC0ba77MX3hOMDZZ9yB+ScNiZZX0g3F9GvvxK+GHBIhIxIT93SKHxMx6FEJwq
 m+w+Zzr3tR4PsS98g57zSgaHWmyGtgMt2lVOt+z93tbuY/qi8GeYRMRSryKF0srHAPza
 /R1LJfNXP1LEZgqVvnLW8snwim7NT94qeP0OLFMXWn6y1P1dFyIl+mEllILf0rnC1ZFi
 wkXb3JVOktPImYNj+PCgcQA9GWtzaTRsl3zBG1lTbzfuo1Hd3vDmIIirWgb1NKcSHYI1
 MD3LsyjUA+1f3bq0dlCyeyxp8v/OuNjWWcT5tppF/2Ol26N1SJRz1+DZaq5DfAv6UTAY
 zgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685746700; x=1688338700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cKBN9AwMdwMiOqgeVlfxVELcyFeZ63ZFm1bX/J3jfrw=;
 b=OpToxy1tX8AOX90gWGQm20oiJhTbfHpDlALoWYEyR3Qsv+/NRe7FoL5f9z2drIAhfV
 B9hQz6ovvv4TKqlQ2cjnC1in71cIfq3gRZrjrOYt8EFEQ7TlAWTacJP8JvMyPj/pyflG
 ZBwR+dwjnV3x1LyYY3xN96KJedXwNjrFBwb0rh2+bxXQ96G79z15pNderQzeAZvzotaf
 1pCeRQV0KizYXBZzYEs0nJ+abKxh1WcF/R6ntGGExXF+MoDsUqQZEGMhbbrU9dm8SjfA
 vrvssnTg85Cb+b8S3znSNi6bBlXrZyUTkBreXDYCMDCFtllJ3gHa9xjUqvmEJ7Xyx3t+
 Yxgw==
X-Gm-Message-State: AC+VfDzBBn4E1NWyZYi3+F4vjmsY6sHCicTGBNRkKFRkD4ldZIoZzwPA
 5N4XOAg/H/QuaYCvl9za2uyQjZpm5LRTDl8s7Tc=
X-Google-Smtp-Source: ACHHUZ7Gtq8pBSWEUNu/aEh0FIdRvB1HXYMbx1AfN4U1/L+Sl0aLduYMPcQGSfuv4Q7D7NIXeosJug==
X-Received: by 2002:a05:600c:2b8d:b0:3f6:1508:950d with SMTP id
 j13-20020a05600c2b8d00b003f61508950dmr2926390wmc.8.1685746699709; 
 Fri, 02 Jun 2023 15:58:19 -0700 (PDT)
Received: from localhost.localdomain ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 f15-20020a7bcd0f000000b003f611b2aedesm3163443wmj.38.2023.06.02.15.58.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 Jun 2023 15:58:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 1/2] bulk: Replace !CONFIG_SOFTMMU -> CONFIG_USER_ONLY
Date: Sat,  3 Jun 2023 00:58:10 +0200
Message-Id: <20230602225811.60152-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230602225811.60152-1-philmd@linaro.org>
References: <20230602225811.60152-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

CONFIG_USER_ONLY is the opposite of CONFIG_SOFTMMU.
Replace !CONFIG_SOFTMMU negation by the positive form
which is clearer when reviewing code.

Change mostly done mechanically using:

  $ sed -i -e 's/!defined(CONFIG_SOFTMMU)/defined(CONFIG_USER_ONLY)/' \
           -e 's/ifndef CONFIG_SOFTMMU/ifdef CONFIG_USER_ONLY/' \
               $(git grep -l CONFIG_SOFTMMU)

and adapting comments manually.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/cpu-exec.c             | 4 ++--
 target/i386/helper.c             | 6 +++---
 tcg/aarch64/tcg-target.c.inc     | 4 ++--
 tcg/arm/tcg-target.c.inc         | 4 ++--
 tcg/i386/tcg-target.c.inc        | 8 ++++----
 tcg/loongarch64/tcg-target.c.inc | 4 ++--
 tcg/mips/tcg-target.c.inc        | 6 +++---
 tcg/ppc/tcg-target.c.inc         | 4 ++--
 tcg/riscv/tcg-target.c.inc       | 2 +-
 tcg/s390x/tcg-target.c.inc       | 4 ++--
 tcg/sparc64/tcg-target.c.inc     | 4 ++--
 11 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index f1eae7b8e5..d5695a7083 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -568,7 +568,7 @@ void cpu_exec_step_atomic(CPUState *cpu)
         cpu_tb_exec(cpu, tb, &tb_exit);
         cpu_exec_exit(cpu);
     } else {
-#ifndef CONFIG_SOFTMMU
+#ifdef CONFIG_USER_ONLY
         clear_helper_retaddr();
         if (have_mmap_lock()) {
             mmap_unlock();
@@ -1025,7 +1025,7 @@ static int cpu_exec_setjmp(CPUState *cpu, SyncClocks *sc)
         /* Non-buggy compilers preserve this; assert the correct value. */
         g_assert(cpu == current_cpu);
 
-#ifndef CONFIG_SOFTMMU
+#ifdef CONFIG_USER_ONLY
         clear_helper_retaddr();
         if (have_mmap_lock()) {
             mmap_unlock();
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 89aa696c6d..c9755b3aba 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -582,7 +582,7 @@ int cpu_x86_get_descr_debug(CPUX86State *env, unsigned int selector,
 
 void do_cpu_init(X86CPU *cpu)
 {
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_SOFTMMU)
     CPUState *cs = CPU(cpu);
     CPUX86State *env = &cpu->env;
     CPUX86State *save = g_new(CPUX86State, 1);
@@ -601,10 +601,10 @@ void do_cpu_init(X86CPU *cpu)
         kvm_arch_do_init_vcpu(cpu);
     }
     apic_init_reset(cpu->apic_state);
-#endif /* CONFIG_USER_ONLY */
+#endif /* CONFIG_SOFTMMU */
 }
 
-#ifndef CONFIG_USER_ONLY
+#ifdef CONFIG_SOFTMMU
 
 void do_cpu_sipi(X86CPU *cpu)
 {
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 35ca80cd56..d82654ac64 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -77,7 +77,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_REG_TMP2 TCG_REG_X30
 #define TCG_VEC_TMP0 TCG_REG_V31
 
-#ifndef CONFIG_SOFTMMU
+#ifdef CONFIG_USER_ONLY
 #define TCG_REG_GUEST_BASE TCG_REG_X28
 #endif
 
@@ -3083,7 +3083,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_set_frame(s, TCG_REG_SP, TCG_STATIC_CALL_ARGS_SIZE,
                   CPU_TEMP_BUF_NLONGS * sizeof(long));
 
-#if !defined(CONFIG_SOFTMMU)
+#if defined(CONFIG_USER_ONLY)
     /*
      * Note that XZR cannot be encoded in the address base register slot,
      * as that actaully encodes SP.  Depending on the guest, we may need
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 83e286088f..9248c1eb2a 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -89,7 +89,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 
 #define TCG_REG_TMP  TCG_REG_R12
 #define TCG_VEC_TMP  TCG_REG_Q15
-#ifndef CONFIG_SOFTMMU
+#ifdef CONFIG_USER_ONLY
 #define TCG_REG_GUEST_BASE  TCG_REG_R11
 #endif
 
@@ -2920,7 +2920,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
 
-#ifndef CONFIG_SOFTMMU
+#ifdef CONFIG_USER_ONLY
     if (guest_base) {
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_GUEST_BASE, guest_base);
         tcg_regset_set_reg(s->reserved_regs, TCG_REG_GUEST_BASE);
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index ab997b5fb3..fa3ef70417 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1866,7 +1866,7 @@ static bool tcg_out_qemu_st_slow_path(TCGContext *s, TCGLabelQemuLdst *l)
     return true;
 }
 
-#ifndef CONFIG_SOFTMMU
+#ifdef CONFIG_USER_ONLY
 static HostAddress x86_guest_base = {
     .index = -1
 };
@@ -1898,7 +1898,7 @@ static inline int setup_guest_base_seg(void)
     return 0;
 }
 #endif /* setup_guest_base_seg */
-#endif /* !SOFTMMU */
+#endif /* CONFIG_USER_ONLY */
 
 #define MIN_TLB_MASK_TABLE_OFS  INT_MIN
 
@@ -4069,7 +4069,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
                          (ARRAY_SIZE(tcg_target_callee_save_regs) + 2) * 4
                          + stack_addend);
 #else
-# if !defined(CONFIG_SOFTMMU)
+# if defined(CONFIG_USER_ONLY)
     if (guest_base) {
         int seg = setup_guest_base_seg();
         if (seg != 0) {
@@ -4083,7 +4083,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
             tcg_regset_set_reg(s->reserved_regs, x86_guest_base.index);
         }
     }
-# endif
+# endif /* CONFIG_USER_ONLY */
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
     tcg_out_addi(s, TCG_REG_ESP, -stack_addend);
     /* jmp *tb.  */
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index baf5fc3819..e145975aaf 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -122,7 +122,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
     return TCG_REG_A0 + slot;
 }
 
-#ifndef CONFIG_SOFTMMU
+#ifdef CONFIG_USER_ONLY
 #define USE_GUEST_BASE     (guest_base != 0)
 #define TCG_GUEST_BASE_REG TCG_REG_S1
 #endif
@@ -1672,7 +1672,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
                    TCG_REG_SP, SAVE_OFS + i * REG_SIZE);
     }
 
-#if !defined(CONFIG_SOFTMMU)
+#if defined(CONFIG_USER_ONLY)
     if (USE_GUEST_BASE) {
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base);
         tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 9faa8bdf0b..1380b905dd 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -78,7 +78,7 @@ static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 #define TCG_TMP2  TCG_REG_T8
 #define TCG_TMP3  TCG_REG_T7
 
-#ifndef CONFIG_SOFTMMU
+#ifdef CONFIG_USER_ONLY
 #define TCG_GUEST_BASE_REG TCG_REG_S7
 #endif
 #if TCG_TARGET_REG_BITS == 64
@@ -2465,7 +2465,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
                    TCG_REG_SP, SAVE_OFS + i * REG_SIZE);
     }
 
-#ifndef CONFIG_SOFTMMU
+#ifdef CONFIG_USER_ONLY
     if (guest_base != (int16_t)guest_base) {
         /*
          * The function call abi for n32 and n64 will have loaded $25 (t9)
@@ -2479,7 +2479,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
                          TCG_TARGET_REG_BITS == 64 ? TCG_REG_T9 : 0);
         tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
     }
-#endif
+#endif /* CONFIG_USER_ONLY */
 
     if (TCG_TARGET_REG_BITS == 64) {
         tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_TB, tcg_target_call_iarg_regs[1]);
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 507fe6cda8..41420f7e6f 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -97,7 +97,7 @@ static bool have_isel;
 bool have_altivec;
 bool have_vsx;
 
-#ifndef CONFIG_SOFTMMU
+#ifdef CONFIG_USER_ONLY
 #define TCG_GUEST_BASE_REG 30
 #endif
 
@@ -2449,7 +2449,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     }
     tcg_out_st(s, TCG_TYPE_PTR, TCG_REG_R0, TCG_REG_R1, FRAME_SIZE+LR_OFFSET);
 
-#ifndef CONFIG_SOFTMMU
+#ifdef CONFIG_USER_ONLY
     if (guest_base) {
         tcg_out_movi_int(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base, true);
         tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index eeaeb6b6e3..60642f3e9a 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2030,7 +2030,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
                    TCG_REG_SP, SAVE_OFS + i * REG_SIZE);
     }
 
-#if !defined(CONFIG_SOFTMMU)
+#if defined(CONFIG_USER_ONLY)
     tcg_out_movi(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base);
     tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
 #endif
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index a878acd8ca..2a948e5317 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -46,7 +46,7 @@
 /* A scratch register that may be be used throughout the backend.  */
 #define TCG_TMP0        TCG_REG_R1
 
-#ifndef CONFIG_SOFTMMU
+#ifdef CONFIG_USER_ONLY
 #define TCG_GUEST_BASE_REG TCG_REG_R13
 #endif
 
@@ -3427,7 +3427,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
                   TCG_STATIC_CALL_ARGS_SIZE + TCG_TARGET_CALL_STACK_OFFSET,
                   CPU_TEMP_BUF_NLONGS * sizeof(long));
 
-#ifndef CONFIG_SOFTMMU
+#ifdef CONFIG_USER_ONLY
     if (guest_base >= 0x80000) {
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base);
         tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index ffcb879211..29e67758ef 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -78,7 +78,7 @@ static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 #define TCG_REG_T2  TCG_REG_G2
 #define TCG_REG_T3  TCG_REG_O7
 
-#ifndef CONFIG_SOFTMMU
+#ifdef CONFIG_USER_ONLY
 # define TCG_GUEST_BASE_REG TCG_REG_I5
 #endif
 
@@ -932,7 +932,7 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_out32(s, SAVE | INSN_RD(TCG_REG_O6) | INSN_RS1(TCG_REG_O6) |
               INSN_IMM13(-frame_size));
 
-#ifndef CONFIG_SOFTMMU
+#ifdef CONFIG_USER_ONLY
     if (guest_base != 0) {
         tcg_out_movi_int(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG,
                          guest_base, true, TCG_REG_T1);
-- 
2.38.1


