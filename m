Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A617C8F57
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:36:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPij-0006Lh-Bg; Fri, 13 Oct 2023 17:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPie-0006IF-CJ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:16 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiX-0000Tu-BB
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:15 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6c0b8f42409so1619733a34.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232547; x=1697837347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wj5j7mxt+nPuY2ZuA8bhPqOAP/9APuf3bf2Wtsy9Wno=;
 b=JfkFCK2CHYpU6P24OfwM858xtS62ViLeiRNzV+EFeGVKXFf/baAft7uW6t8vD9ZGu1
 WPbOyHIgvxY+qtaW1qi3MM+kLX1Y3mQZCfCOfrojA8nJfAnlwrEMqP2q6BBaGNlSsEmR
 N/YsIDXUTocgrgANXlELsgzEywJS/8yateBPutMUTEfPq077FMSiIV0dkfz1DEaFMwD3
 IbAzrF2tBe9r4H7JVeuZIb4sEuBejIHgxHqcqH7COxxx+6xy5OxvYkkKVHr/188c4O+T
 UCKRhHU6JsMcSaYDJyQd35N5iMy0a+PXzU1l2ETIfAiO+8vaQ66CpH0ZUsz1fHqodDwf
 MVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232547; x=1697837347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wj5j7mxt+nPuY2ZuA8bhPqOAP/9APuf3bf2Wtsy9Wno=;
 b=h7fTcH0+cZrCJNCK2iE384x4/vPTfwThT6LdXhcyNGZGv/lXo8Ev+sPaG7wGIzGeww
 r6va/xB1AoLPUbes14T+9QPMV5PgS1aIsFvMLVSNUuCCS5B3HDh44X8yFKkKYf56dum7
 2ETm2ULdRYiQsLWU/upO9C6zdEwSuyenXkNmFHuyiZqXeSSBBVCpbxROlqyDm2jBEtd2
 bc5tjife9UmdmZCHwnd88qRKUqkSJJMccXyt1BceCbgY4peYrYRo5glset7NL0lGQ3Ox
 uwaoorvq7IyvdYrPChOgrXny/MOR3+ytb2SUUM1aSTrCCtAU0W0TYTaYiddIExNt+hxj
 8KIQ==
X-Gm-Message-State: AOJu0YyFEpi+bpN09RCHr/h82WlBJq4pKry+Px7ohXZeqEVhDS+PZ0vS
 sclXqeIiD7vQwy3FjrAmF6HC82CUc42eJjaM/uM=
X-Google-Smtp-Source: AGHT+IGkSNamCZwp7KemcEcr3mbRvkMh2S54FtY21CoPfTJimzdg8YyPAdMp+lDPJ7GUWfKNcwv2Zg==
X-Received: by 2002:a05:6870:9593:b0:1dd:7f3a:b703 with SMTP id
 k19-20020a056870959300b001dd7f3ab703mr33221892oao.0.1697232546985; 
 Fri, 13 Oct 2023 14:29:06 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:29:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 20/85] target/sparc: Move WRASR to decodetree
Date: Fri, 13 Oct 2023 14:27:41 -0700
Message-Id: <20231013212846.165724-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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
index 9142e0e2f0..c253c6b1c1 100644
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
 Tcc_r   10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 Tcc_i   10 0 cond:4 111010 rs1:5 1 cc:1 0000 i:8
 
@@ -47,6 +54,30 @@ Tcc_i   10 0 cond:4 111010 rs1:5 1 cc:1 0000 i:8
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
index 26601e508f..917a4299ff 100644
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
@@ -2808,6 +2813,7 @@ static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
 #define avail_ASR17(C)    ((C)->def->features & CPU_FEATURE_ASR17)
 #define avail_GL(C)       ((C)->def->features & CPU_FEATURE_GL)
 #define avail_HYPV(C)     ((C)->def->features & CPU_FEATURE_HYPV)
+#define avail_POWERDOWN(C) ((C)->def->features & CPU_FEATURE_POWERDOWN)
 
 /* Default case for non jump instructions. */
 static bool advance_pc(DisasContext *dc)
@@ -3025,6 +3031,10 @@ static bool trans_SETHI(DisasContext *dc, arg_SETHI *a)
     return advance_pc(dc);
 }
 
+/*
+ * Major Opcode 10 -- integer, floating-point, vis, and system insns.
+ */
+
 static bool do_tcc(DisasContext *dc, int cc, int cond,
                    bool imm, int rs1, int rs2_or_imm)
 {
@@ -3594,6 +3604,186 @@ static bool trans_FLUSHW(DisasContext *dc, arg_FLUSHW *a)
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
@@ -4250,162 +4440,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


