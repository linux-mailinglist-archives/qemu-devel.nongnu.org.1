Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC8A7D271A
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:34:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhtR-0007AI-3Z; Sun, 22 Oct 2023 19:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtO-00079Q-Le
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:59 -0400
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhtK-0006mc-5w
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:58 -0400
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-352a22e1471so10981215ab.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017393; x=1698622193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ZFkVjJElMHbZrG486UGB9YDXc8kwMsHMbCp6rWCfS4=;
 b=Kl9H4usLhhzyKyR5lSrnNg0dpG5sKy9u85NL+b6xsT0CQBKNuCHZwlAHvaF9M0bm46
 9eBJio9ieUKC8f225bLvZk51aPcynLjW81LzLXll4+jhbE0i7OkhtR1hMkITK6iV2qd6
 dbR3ibKXTwoW24SGeEJSkCvfItdgyH5zc3korfolj5kZPAbih/RMsAIZK2NAEdrqdd5a
 gpswogj9bkSJ844i9dQ0efSRRiK0YWpIljSWAUFIT8yFEeJx2nI5pW5JU3WrjjRB0zVp
 ngEI5bIPpQ2s51EunNC2sMrd5N7OZe15V/bWIBAi0NIkBi5Fclb3BC/Udt54+kfj9rtA
 y+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017393; x=1698622193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ZFkVjJElMHbZrG486UGB9YDXc8kwMsHMbCp6rWCfS4=;
 b=JJtaGmS8Dsu70T2WJJhqCa6ertOXBncxqSIeMWs/ThtADNQM5oV2m1v5Og13GID1IO
 lam9uLsLCrPw4lRi3SwRFHAieFfyoey6xOPIADlEPUrATEKKNODXkIUICM47tZ36I8K8
 0MZ18q2GECNt5rte2+e8nrOvBWv/EaVsBdsOXLmhdwPtA2um6MyVpKU4clfxJZEvUvlg
 2TQ+O2oTqx0tbZY6/nDPQg9ixbtxhxJ/ysodpqJzkpiuElApygp8vBuhN9jBdte7o6ve
 BuvoqDSukBTtCckunCXNVpyXrfqCP1mZ12Rp2WAgea2CkFDb4BRLNZS9QZLT5l5E38yC
 Ic2g==
X-Gm-Message-State: AOJu0Yy70Uo/Q3570G/lVZFp9JzyHqXu/L0vp0OyrSdbtSYegg96pN0l
 3QodN13pxbu2ZQz8hBbN+F+bhHoZeKpOsduBf2I=
X-Google-Smtp-Source: AGHT+IEDitkQ3Vm2+9MaVcrprJChSvC1NfhXlTPLmJ3KQxlocbRRFXjm1MWxfRElMT7jdiRe25mCRw==
X-Received: by 2002:a05:6602:3fd3:b0:79f:dbec:ac4d with SMTP id
 fc19-20020a0566023fd300b0079fdbecac4dmr10392633iob.19.1698017392844; 
 Sun, 22 Oct 2023 16:29:52 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4023772pgf.12.2023.10.22.16.29.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:29:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 22/94] target/sparc: Move RDASR, STBAR, MEMBAR to decodetree
Date: Sun, 22 Oct 2023 16:28:20 -0700
Message-Id: <20231022232932.80507-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x132.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  22 +++
 target/sparc/translate.c  | 342 ++++++++++++++++++++++++--------------
 2 files changed, 235 insertions(+), 129 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 0517f5591b..1b084c5b97 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -22,6 +22,28 @@ SETHI   00 rd:5         100 i:22
 
 CALL    01 i:s30
 
+{
+  [
+    STBAR           10 00000 101000 01111 0 0000000000000
+    MEMBAR          10 00000 101000 01111 1 000000 cmask:3 mmask:4
+
+    RDCCR           10 rd:5  101000 00010 0 0000000000000
+    RDASI           10 rd:5  101000 00011 0 0000000000000
+    RDTICK          10 rd:5  101000 00100 0 0000000000000
+    RDPC            10 rd:5  101000 00101 0 0000000000000
+    RDFPRS          10 rd:5  101000 00110 0 0000000000000
+    RDASR17         10 rd:5  101000 10001 0 0000000000000
+    RDGSR           10 rd:5  101000 10011 0 0000000000000
+    RDSOFTINT       10 rd:5  101000 10110 0 0000000000000
+    RDTICK_CMPR     10 rd:5  101000 10111 0 0000000000000
+    RDSTICK         10 rd:5  101000 11000 0 0000000000000
+    RDSTICK_CMPR    10 rd:5  101000 11001 0 0000000000000
+    RDSTRAND_STATUS 10 rd:5  101000 11010 0 0000000000000
+  ]
+  # Before v8, all rs1 accepted; otherwise rs1==0.
+  RDY               10 rd:5  101000 rs1:5 0 0000000000000
+}
+
 Tcc_r       10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 {
   # For v7, the entire simm13 field is present, but masked to 7 bits.
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index b927b212ca..9af4578525 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -36,6 +36,11 @@
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
 
+#ifndef TARGET_SPARC64
+# define gen_helper_rdccr(D, E)                 qemu_build_not_reached()
+# define gen_helper_tick_get_count(D, E, T, C)  qemu_build_not_reached()
+#endif
+
 /* Dynamic PC, must exit to main loop. */
 #define DYNAMIC_PC         1
 /* Dynamic PC, one of two values according to jump_pc[T2]. */
@@ -64,10 +69,21 @@ static TCGv cpu_tick_cmpr, cpu_stick_cmpr, cpu_hstick_cmpr;
 static TCGv cpu_hintp, cpu_htba, cpu_hver, cpu_ssr, cpu_ver;
 #else
 static TCGv cpu_wim;
+# define cpu_fprs               ({ qemu_build_not_reached(); (TCGv)NULL; })
+# define cpu_gsr                ({ qemu_build_not_reached(); (TCGv)NULL; })
+# define cpu_tick_cmpr          ({ qemu_build_not_reached(); (TCGv)NULL; })
+# define cpu_stick_cmpr         ({ qemu_build_not_reached(); (TCGv)NULL; })
 #endif
 /* Floating point registers */
 static TCGv_i64 cpu_fpr[TARGET_DPREGS];
 
+#define env_field_offsetof(X)     offsetof(CPUSPARCState, X)
+#ifdef TARGET_SPARC64
+# define env64_field_offsetof(X)  env_field_offsetof(X)
+#else
+# define env64_field_offsetof(X)  ({ qemu_build_not_reached(); 0; })
+#endif
+
 typedef struct DisasDelayException {
     struct DisasDelayException *next;
     TCGLabel *lab;
@@ -2842,10 +2858,14 @@ static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
 #define avail_ALL(C)      true
 #ifdef TARGET_SPARC64
 # define avail_32(C)      false
+# define avail_ASR17(C)   false
 # define avail_64(C)      true
+# define avail_HYPV(C)    ((C)->def->features & CPU_FEATURE_HYPV)
 #else
 # define avail_32(C)      true
+# define avail_ASR17(C)   ((C)->def->features & CPU_FEATURE_ASR17)
 # define avail_64(C)      false
+# define avail_HYPV(C)    false
 #endif
 
 /* Default case for non jump instructions. */
@@ -2947,6 +2967,12 @@ static bool advance_jump_cond(DisasContext *dc, DisasCompare *cmp,
     return true;
 }
 
+static bool raise_priv(DisasContext *dc)
+{
+    gen_exception(dc, TT_PRIV_INSN);
+    return true;
+}
+
 static bool do_bpcc(DisasContext *dc, arg_bcc *a)
 {
     target_long target = address_mask_i(dc, dc->pc + a->i * 4);
@@ -3117,6 +3143,183 @@ static bool trans_Tcc_i_v9(DisasContext *dc, arg_Tcc_i_v9 *a)
     return do_tcc(dc, a->cond, a->cc, a->rs1, true, a->i);
 }
 
+static bool trans_STBAR(DisasContext *dc, arg_STBAR *a)
+{
+    tcg_gen_mb(TCG_MO_ST_ST | TCG_BAR_SC);
+    return advance_pc(dc);
+}
+
+static bool trans_MEMBAR(DisasContext *dc, arg_MEMBAR *a)
+{
+    if (avail_32(dc)) {
+        return false;
+    }
+    if (a->mmask) {
+        /* Note TCG_MO_* was modeled on sparc64, so mmask matches. */
+        tcg_gen_mb(a->mmask | TCG_BAR_SC);
+    }
+    if (a->cmask) {
+        /* For #Sync, etc, end the TB to recognize interrupts. */
+        dc->base.is_jmp = DISAS_EXIT;
+    }
+    return advance_pc(dc);
+}
+
+static bool do_rd_special(DisasContext *dc, bool priv, int rd,
+                          TCGv (*func)(DisasContext *, TCGv))
+{
+    if (!priv) {
+        return raise_priv(dc);
+    }
+    gen_store_gpr(dc, rd, func(dc, gen_dest_gpr(dc, rd)));
+    return advance_pc(dc);
+}
+
+static TCGv do_rdy(DisasContext *dc, TCGv dst)
+{
+    return cpu_y;
+}
+
+static bool trans_RDY(DisasContext *dc, arg_RDY *a)
+{
+    /*
+     * TODO: Need a feature bit for sparcv8.  In the meantime, treat all
+     * 32-bit cpus like sparcv7, which ignores the rs1 field.
+     * This matches after all other ASR, so Leon3 Asr17 is handled first.
+     */
+    if (avail_64(dc) && a->rs1 != 0) {
+        return false;
+    }
+    return do_rd_special(dc, true, a->rd, do_rdy);
+}
+
+static TCGv do_rd_leon3_config(DisasContext *dc, TCGv dst)
+{
+    uint32_t val;
+
+    /*
+     * TODO: There are many more fields to be filled,
+     * some of which are writable.
+     */
+    val = dc->def->nwindows - 1;   /* [4:0] NWIN */
+    val |= 1 << 8;                 /* [8]   V8   */
+
+    return tcg_constant_tl(val);
+}
+
+TRANS(RDASR17, ASR17, do_rd_special, true, a->rd, do_rd_leon3_config)
+
+static TCGv do_rdccr(DisasContext *dc, TCGv dst)
+{
+    update_psr(dc);
+    gen_helper_rdccr(dst, tcg_env);
+    return dst;
+}
+
+TRANS(RDCCR, 64, do_rd_special, true, a->rd, do_rdccr)
+
+static TCGv do_rdasi(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    return tcg_constant_tl(dc->asi);
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDASI, 64, do_rd_special, true, a->rd, do_rdasi)
+
+static TCGv do_rdtick(DisasContext *dc, TCGv dst)
+{
+    TCGv_ptr r_tickptr = tcg_temp_new_ptr();
+
+    tcg_gen_ld_ptr(r_tickptr, tcg_env, env64_field_offsetof(tick));
+    if (translator_io_start(&dc->base)) {
+        dc->base.is_jmp = DISAS_EXIT;
+    }
+    gen_helper_tick_get_count(dst, tcg_env, r_tickptr,
+                              tcg_constant_i32(dc->mem_idx));
+    return dst;
+}
+
+/* TODO: non-priv access only allowed when enabled. */
+TRANS(RDTICK, 64, do_rd_special, true, a->rd, do_rdtick)
+
+static TCGv do_rdpc(DisasContext *dc, TCGv dst)
+{
+    return tcg_constant_tl(address_mask_i(dc, dc->pc));
+}
+
+TRANS(RDPC, 64, do_rd_special, true, a->rd, do_rdpc)
+
+static TCGv do_rdfprs(DisasContext *dc, TCGv dst)
+{
+    tcg_gen_ext_i32_tl(dst, cpu_fprs);
+    return dst;
+}
+
+TRANS(RDFPRS, 64, do_rd_special, true, a->rd, do_rdfprs)
+
+static TCGv do_rdgsr(DisasContext *dc, TCGv dst)
+{
+    gen_trap_ifnofpu(dc);
+    return cpu_gsr;
+}
+
+TRANS(RDGSR, 64, do_rd_special, true, a->rd, do_rdgsr)
+
+static TCGv do_rdsoftint(DisasContext *dc, TCGv dst)
+{
+    tcg_gen_ld32s_tl(dst, tcg_env, env64_field_offsetof(softint));
+    return dst;
+}
+
+TRANS(RDSOFTINT, 64, do_rd_special, supervisor(dc), a->rd, do_rdsoftint)
+
+static TCGv do_rdtick_cmpr(DisasContext *dc, TCGv dst)
+{
+    return cpu_tick_cmpr;
+}
+
+/* TODO: non-priv access only allowed when enabled. */
+TRANS(RDTICK_CMPR, 64, do_rd_special, true, a->rd, do_rdtick_cmpr)
+
+static TCGv do_rdstick(DisasContext *dc, TCGv dst)
+{
+    TCGv_ptr r_tickptr = tcg_temp_new_ptr();
+
+    tcg_gen_ld_ptr(r_tickptr, tcg_env, env64_field_offsetof(stick));
+    if (translator_io_start(&dc->base)) {
+        dc->base.is_jmp = DISAS_EXIT;
+    }
+    gen_helper_tick_get_count(dst, tcg_env, r_tickptr,
+                              tcg_constant_i32(dc->mem_idx));
+    return dst;
+}
+
+/* TODO: non-priv access only allowed when enabled. */
+TRANS(RDSTICK, 64, do_rd_special, true, a->rd, do_rdstick)
+
+static TCGv do_rdstick_cmpr(DisasContext *dc, TCGv dst)
+{
+    return cpu_stick_cmpr;
+}
+
+/* TODO: supervisor access only allowed when enabled by hypervisor. */
+TRANS(RDSTICK_CMPR, 64, do_rd_special, supervisor(dc), a->rd, do_rdstick_cmpr)
+
+/*
+ * UltraSPARC-T1 Strand status.
+ * HYPV check maybe not enough, UA2005 & UA2007 describe
+ * this ASR as impl. dep
+ */
+static TCGv do_rdstrand_status(DisasContext *dc, TCGv dst)
+{
+    return tcg_constant_tl(1);
+}
+
+TRANS(RDSTRAND_STATUS, HYPV, do_rd_special, true, a->rd, do_rdstrand_status)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -3143,134 +3346,12 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
         g_assert_not_reached(); /* in decodetree */
     case 2:                     /* FPU & Logical Operations */
         {
-            unsigned int xop = GET_FIELD(insn, 7, 12);
-            TCGv cpu_dst = tcg_temp_new();
-            TCGv cpu_tmp0;
+            unsigned int xop __attribute__((unused)) = GET_FIELD(insn, 7, 12);
+            TCGv cpu_dst __attribute__((unused)) = tcg_temp_new();
+            TCGv cpu_tmp0 __attribute__((unused));
 
-            if (xop == 0x28) {
-                rs1 = GET_FIELD(insn, 13, 17);
-                switch(rs1) {
-                case 0: /* rdy */
-#ifndef TARGET_SPARC64
-                case 0x01 ... 0x0e: /* undefined in the SPARCv8
-                                       manual, rdy on the microSPARC
-                                       II */
-                case 0x0f:          /* stbar in the SPARCv8 manual,
-                                       rdy on the microSPARC II */
-                case 0x10 ... 0x1f: /* implementation-dependent in the
-                                       SPARCv8 manual, rdy on the
-                                       microSPARC II */
-                    /* Read Asr17 */
-                    if (rs1 == 0x11 && dc->def->features & CPU_FEATURE_ASR17) {
-                        TCGv t = gen_dest_gpr(dc, rd);
-                        /* Read Asr17 for a Leon3 monoprocessor */
-                        tcg_gen_movi_tl(t, (1 << 8) | (dc->def->nwindows - 1));
-                        gen_store_gpr(dc, rd, t);
-                        break;
-                    }
-#endif
-                    gen_store_gpr(dc, rd, cpu_y);
-                    break;
-#ifdef TARGET_SPARC64
-                case 0x2: /* V9 rdccr */
-                    update_psr(dc);
-                    gen_helper_rdccr(cpu_dst, tcg_env);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
-                case 0x3: /* V9 rdasi */
-                    tcg_gen_movi_tl(cpu_dst, dc->asi);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
-                case 0x4: /* V9 rdtick */
-                    {
-                        TCGv_ptr r_tickptr;
-                        TCGv_i32 r_const;
-
-                        r_tickptr = tcg_temp_new_ptr();
-                        r_const = tcg_constant_i32(dc->mem_idx);
-                        tcg_gen_ld_ptr(r_tickptr, tcg_env,
-                                       offsetof(CPUSPARCState, tick));
-                        if (translator_io_start(&dc->base)) {
-                            dc->base.is_jmp = DISAS_EXIT;
-                        }
-                        gen_helper_tick_get_count(cpu_dst, tcg_env, r_tickptr,
-                                                  r_const);
-                        gen_store_gpr(dc, rd, cpu_dst);
-                    }
-                    break;
-                case 0x5: /* V9 rdpc */
-                    {
-                        TCGv t = gen_dest_gpr(dc, rd);
-                        if (unlikely(AM_CHECK(dc))) {
-                            tcg_gen_movi_tl(t, dc->pc & 0xffffffffULL);
-                        } else {
-                            tcg_gen_movi_tl(t, dc->pc);
-                        }
-                        gen_store_gpr(dc, rd, t);
-                    }
-                    break;
-                case 0x6: /* V9 rdfprs */
-                    tcg_gen_ext_i32_tl(cpu_dst, cpu_fprs);
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
-                case 0xf: /* V9 membar */
-                    break; /* no effect */
-                case 0x13: /* Graphics Status */
-                    if (gen_trap_ifnofpu(dc)) {
-                        goto jmp_insn;
-                    }
-                    gen_store_gpr(dc, rd, cpu_gsr);
-                    break;
-                case 0x16: /* Softint */
-                    tcg_gen_ld32s_tl(cpu_dst, tcg_env,
-                                     offsetof(CPUSPARCState, softint));
-                    gen_store_gpr(dc, rd, cpu_dst);
-                    break;
-                case 0x17: /* Tick compare */
-                    gen_store_gpr(dc, rd, cpu_tick_cmpr);
-                    break;
-                case 0x18: /* System tick */
-                    {
-                        TCGv_ptr r_tickptr;
-                        TCGv_i32 r_const;
-
-                        r_tickptr = tcg_temp_new_ptr();
-                        r_const = tcg_constant_i32(dc->mem_idx);
-                        tcg_gen_ld_ptr(r_tickptr, tcg_env,
-                                       offsetof(CPUSPARCState, stick));
-                        if (translator_io_start(&dc->base)) {
-                            dc->base.is_jmp = DISAS_EXIT;
-                        }
-                        gen_helper_tick_get_count(cpu_dst, tcg_env, r_tickptr,
-                                                  r_const);
-                        gen_store_gpr(dc, rd, cpu_dst);
-                    }
-                    break;
-                case 0x19: /* System tick compare */
-                    gen_store_gpr(dc, rd, cpu_stick_cmpr);
-                    break;
-                case 0x1a: /* UltraSPARC-T1 Strand status */
-                    /* XXX HYPV check maybe not enough, UA2005 & UA2007 describe
-                     * this ASR as impl. dep
-                     */
-                    CHECK_IU_FEATURE(dc, HYPV);
-                    {
-                        TCGv t = gen_dest_gpr(dc, rd);
-                        tcg_gen_movi_tl(t, 1UL);
-                        gen_store_gpr(dc, rd, t);
-                    }
-                    break;
-                case 0x10: /* Performance Control */
-                case 0x11: /* Performance Instrumentation Counter */
-                case 0x12: /* Dispatch Control */
-                case 0x14: /* Softint set, WO */
-                case 0x15: /* Softint clear, WO */
-#endif
-                default:
-                    goto illegal_insn;
-                }
 #if !defined(CONFIG_USER_ONLY)
-            } else if (xop == 0x29) { /* rdpsr / UA2005 rdhpr */
+            if (xop == 0x29) { /* rdpsr / UA2005 rdhpr */
 #ifndef TARGET_SPARC64
                 if (!supervisor(dc)) {
                     goto priv_insn;
@@ -3308,7 +3389,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 #endif
                 gen_store_gpr(dc, rd, cpu_dst);
                 break;
-            } else if (xop == 0x2a) { /* rdwim / V9 rdpr */
+            }
+            if (xop == 0x2a) { /* rdwim / V9 rdpr */
                 if (!supervisor(dc)) {
                     goto priv_insn;
                 }
@@ -3432,9 +3514,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 #endif
                 gen_store_gpr(dc, rd, cpu_tmp0);
                 break;
+            }
 #endif
 #if defined(TARGET_SPARC64) || !defined(CONFIG_USER_ONLY)
-            } else if (xop == 0x2b) { /* rdtbr / V9 flushw */
+            if (xop == 0x2b) { /* rdtbr / V9 flushw */
 #ifdef TARGET_SPARC64
                 gen_helper_flushw(tcg_env);
 #else
@@ -3443,8 +3526,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 gen_store_gpr(dc, rd, cpu_tbr);
 #endif
                 break;
+            }
 #endif
-            } else if (xop == 0x34) {   /* FPU Operations */
+            if (xop == 0x34) {   /* FPU Operations */
                 if (gen_trap_ifnofpu(dc)) {
                     goto jmp_insn;
                 }
-- 
2.34.1


