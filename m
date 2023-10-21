Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BF17D1AE5
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:33:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4bJ-0007Jz-5j; Sat, 21 Oct 2023 01:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4b2-0007Cy-Ce
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:25 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4az-0008R8-Ug
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:32:24 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6b7f0170d7bso1416387b3a.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866341; x=1698471141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MS6cxWaSJ2KoteTVsixgiHalh9261DsIaACUEbMqoVs=;
 b=MBAKv32wHzitjaT62/KRqyxvkFg1VG643OJ63Dli55FJXj7UEJX+C2ke7NJcoCHMCW
 GevNbv/e5f5WnGGkbAgKrwZVAp1MR7LF0UhuKUUlp1M0BEFGtD/3dyvTuR10jGBAoYNC
 6UNmAEup6OVcOcxK49Mn7A/hzpl7RiE463eGUSJEVJQMxFO1Rsa95YeRwiyohObE838s
 C5uY0C9+WeWg7jDko3NoWgCM7qootlIDwnFs5tZ0ydxNyxJMqlNpVFgRTo2Eilsfw0ZJ
 fFKbv7VJLhz6RSSoP+KKhdG32KJGiqmGkschHHIhJU3ZeOwQ50amAAgqbVhKgRkx4ZYC
 LNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866341; x=1698471141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MS6cxWaSJ2KoteTVsixgiHalh9261DsIaACUEbMqoVs=;
 b=rAvbhhYZciEdigB7EVqp11OqzdtY5QTfwfYH096PxKZdawnUEoWPJ1V8MHp2H0pH/H
 tmIqBUaV+S6QjqJVLWDctJMLR1w1mEZY3QChrKAYoloe0w1bgv9mz9t0dU69QuY7agAk
 YYgscRudQbH/mgUoYHXbuRsSnlA0KA5Fj9ogD98g+r8hOfvLCEsUSWDjT8fGWW7jj2fk
 7jViZLAPWpcb9L8klZCqEQqsEpDH7yyZBDkxqsdmsQPi1nXq/EsUiFfkIG+Jlxtal73/
 Lo7aZMIEjTylkOzx3QFP+m8YqKsKxwAjYe8MBHRw9eME7C4YNDXLHH8t6zyDEtZYqxTi
 xT5A==
X-Gm-Message-State: AOJu0Yypuu9/zjJdZHlnTxg+I36mEdUPdsHS7WUYIbk3y7tO2kBSF72C
 yPc0zf+GZTKyfKl7C6APxS033TFW4Kb/++aAWX4=
X-Google-Smtp-Source: AGHT+IGhe/os1vtV16CHrcmNpOqExtYehn1oCW1lT4D/1Nc7IKsmPQNV1YP8nrTVQ0DVK3nQSrTwVw==
X-Received: by 2002:a05:6a20:2451:b0:14d:f41c:435a with SMTP id
 t17-20020a056a20245100b0014df41c435amr4426503pzc.39.1697866340674; 
 Fri, 20 Oct 2023 22:32:20 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056a001ad400b006b2677d3684sm2434831pfv.206.2023.10.20.22.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:32:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 25/90] target/sparc: Move WRASR to decodetree
Date: Fri, 20 Oct 2023 22:30:53 -0700
Message-Id: <20231021053158.278135-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  31 ++++
 target/sparc/translate.c  | 353 +++++++++++++++++++++-----------------
 2 files changed, 225 insertions(+), 159 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 7fb5fa3b3a..d7e7f0c577 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -22,6 +22,13 @@ SETHI   00 rd:5         100 i:22
 
 CALL    01 i:s30
 
+##
+## Major Opcode 10 -- integer, floating-point, vis, and system insns.
+##
+
+&r_r_ri     rd rs1 rs2_or_imm imm:bool
+@n_r_ri     .. ..... ...... rs1:5 imm:1 rs2_or_imm:s13     &r_r_ri rd=0
+
 {
   [
     STBAR           10 00000 101000 01111 0 0000000000000
@@ -44,6 +51,30 @@ CALL    01 i:s30
   RDY               10 rd:5  101000 rs1:5 0 0000000000000
 }
 
+{
+  [
+    WRY             10 00000 110000 ..... . .............  @n_r_ri
+    WRCCR           10 00010 110000 ..... . .............  @n_r_ri
+    WRASI           10 00011 110000 ..... . .............  @n_r_ri
+    WRFPRS          10 00110 110000 ..... . .............  @n_r_ri
+    {
+      WRGSR         10 10011 110000 ..... . .............  @n_r_ri
+      WRPOWERDOWN   10 10011 110000 ..... . .............  @n_r_ri
+    }
+    WRSOFTINT_SET   10 10100 110000 ..... . .............  @n_r_ri
+    WRSOFTINT_CLR   10 10101 110000 ..... . .............  @n_r_ri
+    WRSOFTINT       10 10110 110000 ..... . .............  @n_r_ri
+    WRTICK_CMPR     10 10111 110000 ..... . .............  @n_r_ri
+    WRSTICK         10 11000 110000 ..... . .............  @n_r_ri
+    WRSTICK_CMPR    10 11001 110000 ..... . .............  @n_r_ri
+  ]
+  # Before v8, rs1==0 was WRY, and the rest executed as nop.
+  [
+    NOP_v7          10 ----- 110000 ----- 0 00000000 -----
+    NOP_v7          10 ----- 110000 ----- 1 -------- -----
+  ]
+}
+
 {
   RDPSR             10 rd:5  101001 00000 0 0000000000000
   RDHPR_hpstate     10 rd:5  101001 00000 0 0000000000000
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 4c9079d598..c34602df80 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -37,10 +37,15 @@
 #undef  HELPER_H
 
 #ifdef TARGET_SPARC64
-#define gen_helper_rdpsr(D, E)     qemu_build_not_reached()
+#define gen_helper_rdpsr(D, E)          qemu_build_not_reached()
+#define gen_helper_power_down(E)        g_assert_not_reached()
 #else
-#define gen_helper_rdccr(D, E)     qemu_build_not_reached()
-#define gen_helper_rdcwp(D, E)     qemu_build_not_reached()
+#define gen_helper_rdccr(D, E)          qemu_build_not_reached()
+#define gen_helper_rdcwp(D, E)          qemu_build_not_reached()
+#define gen_helper_wrccr(E, S)          qemu_build_not_reached()
+#define gen_helper_set_softint(E, S)    qemu_build_not_reached()
+#define gen_helper_clear_softint(E, S)  qemu_build_not_reached()
+#define gen_helper_write_softint(E, S)  qemu_build_not_reached()
 #endif
 
 /* Dynamic PC, must exit to main loop. */
@@ -2852,6 +2857,7 @@ static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
 #define avail_ASR17(C)    ((C)->def->features & CPU_FEATURE_ASR17)
 #define avail_GL(C)       ((C)->def->features & CPU_FEATURE_GL)
 #define avail_HYPV(C)     ((C)->def->features & CPU_FEATURE_HYPV)
+#define avail_POWERDOWN(C) ((C)->def->features & CPU_FEATURE_POWERDOWN)
 
 /* Default case for non jump instructions. */
 static bool advance_pc(DisasContext *dc)
@@ -3053,6 +3059,10 @@ static bool trans_SETHI(DisasContext *dc, arg_SETHI *a)
     return advance_pc(dc);
 }
 
+/*
+ * Major Opcode 10 -- integer, floating-point, vis, and system insns.
+ */
+
 static bool do_tcc(DisasContext *dc, int cond, int cc,
                    int rs1, bool imm, int rs2_or_imm)
 {
@@ -3625,6 +3635,186 @@ static bool trans_FLUSHW(DisasContext *dc, arg_FLUSHW *a)
 #endif
 }
 
+static bool do_wr_special(DisasContext *dc, arg_r_r_ri *a, bool priv,
+                          void (*func)(DisasContext *, TCGv))
+{
+    TCGv src;
+
+    /* For simplicity, we under-decoded the rs2 form. */
+    if (!a->imm && (a->rs2_or_imm & ~0x1f)) {
+        return false;
+    }
+    if (!priv) {
+        return raise_priv(dc);
+    }
+
+    if (a->rs1 == 0 && (a->imm || a->rs2_or_imm == 0)) {
+        src = tcg_constant_tl(a->rs2_or_imm);
+    } else {
+        TCGv src1 = gen_load_gpr(dc, a->rs1);
+        if (a->rs2_or_imm == 0) {
+            src = src1;
+        } else {
+            src = tcg_temp_new();
+            if (a->imm) {
+                tcg_gen_xori_tl(src, src1, a->rs2_or_imm);
+            } else {
+                tcg_gen_xor_tl(src, src1, gen_load_gpr(dc, a->rs2_or_imm));
+            }
+        }
+    }
+    func(dc, src);
+    return advance_pc(dc);
+}
+
+static void do_wry(DisasContext *dc, TCGv src)
+{
+    tcg_gen_ext32u_tl(cpu_y, src);
+}
+
+TRANS(WRY, ALL, do_wr_special, a, true, do_wry)
+
+static void do_wrccr(DisasContext *dc, TCGv src)
+{
+    gen_helper_wrccr(tcg_env, src);
+}
+
+TRANS(WRCCR, 64, do_wr_special, a, true, do_wrccr)
+
+static void do_wrasi(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    TCGv tmp = tcg_temp_new();
+    tcg_gen_andi_tl(tmp, src, 0xff);
+    tcg_gen_st32_tl(tmp, tcg_env, offsetof(CPUSPARCState, asi));
+    /* End TB to notice changed ASI. */
+    dc->base.is_jmp = DISAS_EXIT;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(WRASI, 64, do_wr_special, a, true, do_wrasi)
+
+static void do_wrfprs(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    tcg_gen_trunc_tl_i32(cpu_fprs, src);
+    dc->fprs_dirty = 0;
+    dc->base.is_jmp = DISAS_EXIT;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(WRFPRS, 64, do_wr_special, a, true, do_wrfprs)
+
+static void do_wrgsr(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    gen_trap_ifnofpu(dc);
+    tcg_gen_mov_tl(cpu_gsr, src);
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(WRGSR, 64, do_wr_special, a, true, do_wrgsr)
+
+static void do_wrsoftint_set(DisasContext *dc, TCGv src)
+{
+    gen_helper_set_softint(tcg_env, src);
+}
+
+TRANS(WRSOFTINT_SET, 64, do_wr_special, a, supervisor(dc), do_wrsoftint_set)
+
+static void do_wrsoftint_clr(DisasContext *dc, TCGv src)
+{
+    gen_helper_clear_softint(tcg_env, src);
+}
+
+TRANS(WRSOFTINT_CLR, 64, do_wr_special, a, supervisor(dc), do_wrsoftint_clr)
+
+static void do_wrsoftint(DisasContext *dc, TCGv src)
+{
+    gen_helper_write_softint(tcg_env, src);
+}
+
+TRANS(WRSOFTINT, 64, do_wr_special, a, supervisor(dc), do_wrsoftint)
+
+static void do_wrtick_cmpr(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    TCGv_ptr r_tickptr = tcg_temp_new_ptr();
+
+    tcg_gen_mov_tl(cpu_tick_cmpr, src);
+    tcg_gen_ld_ptr(r_tickptr, tcg_env, offsetof(CPUSPARCState, tick));
+    translator_io_start(&dc->base);
+    gen_helper_tick_set_limit(r_tickptr, cpu_tick_cmpr);
+    /* End TB to handle timer interrupt */
+    dc->base.is_jmp = DISAS_EXIT;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(WRTICK_CMPR, 64, do_wr_special, a, supervisor(dc), do_wrtick_cmpr)
+
+static void do_wrstick(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    TCGv_ptr r_tickptr = tcg_temp_new_ptr();
+
+    tcg_gen_ld_ptr(r_tickptr, tcg_env, offsetof(CPUSPARCState, stick));
+    translator_io_start(&dc->base);
+    gen_helper_tick_set_count(r_tickptr, src);
+    /* End TB to handle timer interrupt */
+    dc->base.is_jmp = DISAS_EXIT;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(WRSTICK, 64, do_wr_special, a, supervisor(dc), do_wrstick)
+
+static void do_wrstick_cmpr(DisasContext *dc, TCGv src)
+{
+#ifdef TARGET_SPARC64
+    TCGv_ptr r_tickptr = tcg_temp_new_ptr();
+
+    tcg_gen_mov_tl(cpu_stick_cmpr, src);
+    tcg_gen_ld_ptr(r_tickptr, tcg_env, offsetof(CPUSPARCState, stick));
+    translator_io_start(&dc->base);
+    gen_helper_tick_set_limit(r_tickptr, cpu_stick_cmpr);
+    /* End TB to handle timer interrupt */
+    dc->base.is_jmp = DISAS_EXIT;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(WRSTICK_CMPR, 64, do_wr_special, a, supervisor(dc), do_wrstick_cmpr)
+
+static void do_wrpowerdown(DisasContext *dc, TCGv src)
+{
+    save_state(dc);
+    gen_helper_power_down(tcg_env);
+}
+
+TRANS(WRPOWERDOWN, POWERDOWN, do_wr_special, a, supervisor(dc), do_wrpowerdown)
+
+static bool trans_NOP_v7(DisasContext *dc, arg_NOP_v7 *a)
+{
+    /*
+     * TODO: Need a feature bit for sparcv8.
+     * In the meantime, treat all 32-bit cpus like sparcv7.
+     */
+    if (avail_32(dc)) {
+        return advance_pc(dc);
+    }
+    return false;
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4285,162 +4475,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                         break;
 #endif
                     case 0x30:
-                        {
-                            cpu_tmp0 = tcg_temp_new();
-                            switch(rd) {
-                            case 0: /* wry */
-                                tcg_gen_xor_tl(cpu_tmp0, cpu_src1, cpu_src2);
-                                tcg_gen_andi_tl(cpu_y, cpu_tmp0, 0xffffffff);
-                                break;
-#ifndef TARGET_SPARC64
-                            case 0x01 ... 0x0f: /* undefined in the
-                                                   SPARCv8 manual, nop
-                                                   on the microSPARC
-                                                   II */
-                            case 0x10 ... 0x1f: /* implementation-dependent
-                                                   in the SPARCv8
-                                                   manual, nop on the
-                                                   microSPARC II */
-                                if ((rd == 0x13) && (dc->def->features &
-                                                     CPU_FEATURE_POWERDOWN)) {
-                                    /* LEON3 power-down */
-                                    save_state(dc);
-                                    gen_helper_power_down(tcg_env);
-                                }
-                                break;
-#else
-                            case 0x2: /* V9 wrccr */
-                                tcg_gen_xor_tl(cpu_tmp0, cpu_src1, cpu_src2);
-                                gen_helper_wrccr(tcg_env, cpu_tmp0);
-                                tcg_gen_movi_i32(cpu_cc_op, CC_OP_FLAGS);
-                                dc->cc_op = CC_OP_FLAGS;
-                                break;
-                            case 0x3: /* V9 wrasi */
-                                tcg_gen_xor_tl(cpu_tmp0, cpu_src1, cpu_src2);
-                                tcg_gen_andi_tl(cpu_tmp0, cpu_tmp0, 0xff);
-                                tcg_gen_st32_tl(cpu_tmp0, tcg_env,
-                                                offsetof(CPUSPARCState, asi));
-                                /*
-                                 * End TB to notice changed ASI.
-                                 * TODO: Could notice src1 = %g0 and IS_IMM,
-                                 * update DisasContext and not exit the TB.
-                                 */
-                                save_state(dc);
-                                gen_op_next_insn();
-                                tcg_gen_lookup_and_goto_ptr();
-                                dc->base.is_jmp = DISAS_NORETURN;
-                                break;
-                            case 0x6: /* V9 wrfprs */
-                                tcg_gen_xor_tl(cpu_tmp0, cpu_src1, cpu_src2);
-                                tcg_gen_trunc_tl_i32(cpu_fprs, cpu_tmp0);
-                                dc->fprs_dirty = 0;
-                                save_state(dc);
-                                gen_op_next_insn();
-                                tcg_gen_exit_tb(NULL, 0);
-                                dc->base.is_jmp = DISAS_NORETURN;
-                                break;
-                            case 0xf: /* V9 sir, nop if user */
-#if !defined(CONFIG_USER_ONLY)
-                                if (supervisor(dc)) {
-                                    ; // XXX
-                                }
-#endif
-                                break;
-                            case 0x13: /* Graphics Status */
-                                if (gen_trap_ifnofpu(dc)) {
-                                    goto jmp_insn;
-                                }
-                                tcg_gen_xor_tl(cpu_gsr, cpu_src1, cpu_src2);
-                                break;
-                            case 0x14: /* Softint set */
-                                if (!supervisor(dc))
-                                    goto illegal_insn;
-                                tcg_gen_xor_tl(cpu_tmp0, cpu_src1, cpu_src2);
-                                gen_helper_set_softint(tcg_env, cpu_tmp0);
-                                break;
-                            case 0x15: /* Softint clear */
-                                if (!supervisor(dc))
-                                    goto illegal_insn;
-                                tcg_gen_xor_tl(cpu_tmp0, cpu_src1, cpu_src2);
-                                gen_helper_clear_softint(tcg_env, cpu_tmp0);
-                                break;
-                            case 0x16: /* Softint write */
-                                if (!supervisor(dc))
-                                    goto illegal_insn;
-                                tcg_gen_xor_tl(cpu_tmp0, cpu_src1, cpu_src2);
-                                gen_helper_write_softint(tcg_env, cpu_tmp0);
-                                break;
-                            case 0x17: /* Tick compare */
-#if !defined(CONFIG_USER_ONLY)
-                                if (!supervisor(dc))
-                                    goto illegal_insn;
-#endif
-                                {
-                                    TCGv_ptr r_tickptr;
-
-                                    tcg_gen_xor_tl(cpu_tick_cmpr, cpu_src1,
-                                                   cpu_src2);
-                                    r_tickptr = tcg_temp_new_ptr();
-                                    tcg_gen_ld_ptr(r_tickptr, tcg_env,
-                                                   offsetof(CPUSPARCState, tick));
-                                    translator_io_start(&dc->base);
-                                    gen_helper_tick_set_limit(r_tickptr,
-                                                              cpu_tick_cmpr);
-                                    /* End TB to handle timer interrupt */
-                                    dc->base.is_jmp = DISAS_EXIT;
-                                }
-                                break;
-                            case 0x18: /* System tick */
-#if !defined(CONFIG_USER_ONLY)
-                                if (!supervisor(dc))
-                                    goto illegal_insn;
-#endif
-                                {
-                                    TCGv_ptr r_tickptr;
-
-                                    tcg_gen_xor_tl(cpu_tmp0, cpu_src1,
-                                                   cpu_src2);
-                                    r_tickptr = tcg_temp_new_ptr();
-                                    tcg_gen_ld_ptr(r_tickptr, tcg_env,
-                                                   offsetof(CPUSPARCState, stick));
-                                    translator_io_start(&dc->base);
-                                    gen_helper_tick_set_count(r_tickptr,
-                                                              cpu_tmp0);
-                                    /* End TB to handle timer interrupt */
-                                    dc->base.is_jmp = DISAS_EXIT;
-                                }
-                                break;
-                            case 0x19: /* System tick compare */
-#if !defined(CONFIG_USER_ONLY)
-                                if (!supervisor(dc))
-                                    goto illegal_insn;
-#endif
-                                {
-                                    TCGv_ptr r_tickptr;
-
-                                    tcg_gen_xor_tl(cpu_stick_cmpr, cpu_src1,
-                                                   cpu_src2);
-                                    r_tickptr = tcg_temp_new_ptr();
-                                    tcg_gen_ld_ptr(r_tickptr, tcg_env,
-                                                   offsetof(CPUSPARCState, stick));
-                                    translator_io_start(&dc->base);
-                                    gen_helper_tick_set_limit(r_tickptr,
-                                                              cpu_stick_cmpr);
-                                    /* End TB to handle timer interrupt */
-                                    dc->base.is_jmp = DISAS_EXIT;
-                                }
-                                break;
-
-                            case 0x10: /* Performance Control */
-                            case 0x11: /* Performance Instrumentation
-                                          Counter */
-                            case 0x12: /* Dispatch Control */
-#endif
-                            default:
-                                goto illegal_insn;
-                            }
-                        }
-                        break;
+                        goto illegal_insn;  /* WRASR in decodetree */
 #if !defined(CONFIG_USER_ONLY)
                     case 0x31: /* wrpsr, V9 saved, restored */
                         {
-- 
2.34.1


