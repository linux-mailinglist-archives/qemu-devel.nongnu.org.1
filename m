Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C5E7C8F24
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:32:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPic-0006H2-So; Fri, 13 Oct 2023 17:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiZ-0006GM-FA
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:11 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiR-0000TQ-RF
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:09 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6c49f781855so1630809a34.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232543; x=1697837343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gbR0keYcjz5jMnEd2GZBRdS0VP6EA5r4Z+3eb9rgrA0=;
 b=O92yMy/A0THK30YHADZ1sZ5W7KWYzVm2waz6O+oRV7VsP6TnuxlTIGfp//i+VF26lW
 dLGACwQ9zAAWs971Zdy0E0Wg4LFM3NQO2IpCaeoMCgKnIezz1sC45JBLvRiVskcGn2ll
 DpFEEJNshO14hzs4zO74Z56j+XKIyIRDoj5vs4VmDp79n04Pk24FjHw5oLrKaRFNP4Cj
 Ox2XOd1BdsagX3gng9kXC28XDr39NQcyeLZu48Wc3QMCkfXhpYn0m5DpeR8FHVFQRxmJ
 AlWc5hG6YlmobDNEoO3BOEIYgDBwfV+PuvwUS+Bt1r3abExadtea2u9DCzU4y17BC3Ai
 Z7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232543; x=1697837343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gbR0keYcjz5jMnEd2GZBRdS0VP6EA5r4Z+3eb9rgrA0=;
 b=wwsobSJwXmSQQygF8njbY4Y5ym+gJXM6e9XmoMH0HcpRW2LNoMzUk9pY3ghYExKAts
 5VYVB572hkY11WD9Y6hmJg8Of8xkvfUMKlsSyQf9pWrzhpIh++W1VnUjFtNhZSxYET5S
 7lyb5d9C/ywWl3WghUCIJQ2R59Oz2nbdtPC16qQOzHeVTOyuLKF1sT4Pu7LEjtvricU6
 fzI/0QtSi371e/JGK73DS3psUEskxkKbDa+EnLwodyJSAJQIRsrQWUOlaOiFWW84GVx2
 DVVAZUp1GLxNBIS4qWRDyIvZ2rJgELhFRR41nNpHi5RVCLseK/TN3oIZ1EC/wtes4sXi
 EAPw==
X-Gm-Message-State: AOJu0YwgWtI5AtcrfcCPfuhIMrsSgp3yUEGDwjXP+69Ugs6dRNpVSXIn
 zpqC41HOzcNBgiZdlR7N58beAbnGVRDQJqiLRoE=
X-Google-Smtp-Source: AGHT+IEIdM+W+Ve06YWOVsLiiSllwuJKAb3TRFg8xP7n95J+gbchG1YqAO3GXYUeAVheMwyWwonUAg==
X-Received: by 2002:a9d:798f:0:b0:6bd:cf64:d105 with SMTP id
 h15-20020a9d798f000000b006bdcf64d105mr27921706otm.12.1697232542794; 
 Fri, 13 Oct 2023 14:29:02 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:29:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 16/85] target/sparc: Move RDASR, STBAR, MEMBAR to decodetree
Date: Fri, 13 Oct 2023 14:27:37 -0700
Message-Id: <20231013212846.165724-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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
 target/sparc/insns.decode |  22 +++
 target/sparc/translate.c  | 360 ++++++++++++++++++++++++--------------
 2 files changed, 253 insertions(+), 129 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 2945575268..8dc45f5abc 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -24,3 +24,25 @@ CALL    01 i:s30
 
 Tcc_r   10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 Tcc_i   10 0 cond:4 111010 rs1:5 1 cc:1 0000 i:8
+
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
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index a1c2796782..55ddd7b051 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -36,6 +36,10 @@
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
 
+#ifndef TARGET_SPARC64
+#define gen_helper_rdccr(D, E)     qemu_build_not_reached()
+#endif
+
 /* Dynamic PC, must exit to main loop. */
 #define DYNAMIC_PC         1
 /* Dynamic PC, one of two values according to jump_pc[T2]. */
@@ -2803,6 +2807,8 @@ static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
 # define avail_32(C)      true
 # define avail_64(C)      false
 #endif
+#define avail_ASR17(C)    ((C)->def->features & CPU_FEATURE_ASR17)
+#define avail_HYPV(C)     ((C)->def->features & CPU_FEATURE_HYPV)
 
 /* Default case for non jump instructions. */
 static bool advance_pc(DisasContext *dc)
@@ -2903,6 +2909,12 @@ static bool advance_jump_cond(DisasContext *dc, DisasCompare *cmp,
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
     target_long target = dc->pc + a->i * 4;
@@ -3082,6 +3094,215 @@ static bool do_tcc(DisasContext *dc, int cc, int cond,
 TRANS(Tcc_r, ALL, do_tcc, a->cc, a->cond, false, a->rs1, a->rs2)
 TRANS(Tcc_i, ALL, do_tcc, a->cc, a->cond, true, a->rs1, a->i)
 
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
+#ifdef TARGET_SPARC64
+    TCGv_ptr r_tickptr = tcg_temp_new_ptr();
+    TCGv_i32 r_const = tcg_constant_i32(dc->mem_idx);
+
+    tcg_gen_ld_ptr(r_tickptr, tcg_env, offsetof(CPUSPARCState, tick));
+    if (translator_io_start(&dc->base)) {
+        dc->base.is_jmp = DISAS_EXIT;
+    }
+    gen_helper_tick_get_count(dst, tcg_env, r_tickptr, r_const);
+    return dst;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+/* TODO: non-priv access only allowed when enabled. */
+TRANS(RDTICK, 64, do_rd_special, true, a->rd, do_rdtick)
+
+static TCGv do_rdpc(DisasContext *dc, TCGv dst)
+{
+    target_ulong val = dc->pc;
+    if (AM_CHECK(dc)) {
+        val &= 0xffffffffULL;
+    }
+    return tcg_constant_tl(val);
+}
+
+TRANS(RDPC, 64, do_rd_special, true, a->rd, do_rdpc)
+
+static TCGv do_rdfprs(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    tcg_gen_ext_i32_tl(dst, cpu_fprs);
+    return dst;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDFPRS, 64, do_rd_special, true, a->rd, do_rdfprs)
+
+static TCGv do_rdgsr(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    gen_trap_ifnofpu(dc);
+    return cpu_gsr;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDGSR, 64, do_rd_special, true, a->rd, do_rdgsr)
+
+static TCGv do_rdsoftint(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    tcg_gen_ld32s_tl(dst, tcg_env, offsetof(CPUSPARCState, softint));
+    return dst;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+TRANS(RDSOFTINT, 64, do_rd_special, supervisor(dc), a->rd, do_rdsoftint)
+
+static TCGv do_rdtick_cmpr(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    return cpu_tick_cmpr;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+/* TODO: non-priv access only allowed when enabled. */
+TRANS(RDTICK_CMPR, 64, do_rd_special, true, a->rd, do_rdtick_cmpr)
+
+static TCGv do_rdstick(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    TCGv_ptr r_tickptr = tcg_temp_new_ptr();
+    TCGv_i32 r_const = tcg_constant_i32(dc->mem_idx);
+
+    tcg_gen_ld_ptr(r_tickptr, tcg_env, offsetof(CPUSPARCState, stick));
+    if (translator_io_start(&dc->base)) {
+        dc->base.is_jmp = DISAS_EXIT;
+    }
+    gen_helper_tick_get_count(dst, tcg_env, r_tickptr, r_const);
+    return dst;
+#else
+    qemu_build_not_reached();
+#endif
+}
+
+/* TODO: non-priv access only allowed when enabled. */
+TRANS(RDSTICK, 64, do_rd_special, true, a->rd, do_rdstick)
+
+static TCGv do_rdstick_cmpr(DisasContext *dc, TCGv dst)
+{
+#ifdef TARGET_SPARC64
+    return cpu_stick_cmpr;
+#else
+    qemu_build_not_reached();
+#endif
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
@@ -3108,134 +3329,12 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -3273,7 +3372,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 #endif
                 gen_store_gpr(dc, rd, cpu_dst);
                 break;
-            } else if (xop == 0x2a) { /* rdwim / V9 rdpr */
+            }
+            if (xop == 0x2a) { /* rdwim / V9 rdpr */
                 if (!supervisor(dc)) {
                     goto priv_insn;
                 }
@@ -3397,9 +3497,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -3408,8 +3509,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


