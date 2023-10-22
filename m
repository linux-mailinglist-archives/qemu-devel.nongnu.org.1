Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 706F27D2147
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:05:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRZw-000091-AQ; Sun, 22 Oct 2023 02:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRZp-0008MB-Gg
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:04:41 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRZm-0002Cx-6k
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:04:41 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6b89ab5ddb7so2209132b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954677; x=1698559477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cnwEciCqRLHW6xqGiSbpmNMI0J3+4NepgqBlmJVzz/k=;
 b=wZGU+IsXDOVaU5veuzBWeoV9nCLr05CPKDupwK3A1tVExoZHExIJrXOusK3ZNwSCAk
 oohDQxqp6zZQKUhaJscTIsDq6tOI8U2hmnCuIhqDs6ZSUoTYe1mB1AuxTXLRmnboAhJQ
 gwotKBOt7/BlE0d/ugMfbP3hG7/13SEdougmWD+gltub7slVk6Sj1qPuRh6yxWo9NP6R
 504LN2FYZ4jKSHiEFLbsoL9i5FgmJsGiB+NK58O4/SKoCd3Cc584hm49IGprJJfYNG5c
 OMhpU2lAKRlm3WxfN5KQIaaeKKC79NtPkctYOzABIYF1c+6yD2TiRF2hE6qOAXBXIlBc
 g4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954677; x=1698559477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cnwEciCqRLHW6xqGiSbpmNMI0J3+4NepgqBlmJVzz/k=;
 b=Rqq65MBb1PsSO9GByQNsQTcOuqVrbw4qdnckVZNXsF7n++5hgdW05yOjkQtM53BG86
 qvOKUy2ptERL8KTZpPxxgxO418ArnbzC7frgyxGNAj9sd/VDIhc1F6Dkzer1v2ytADJa
 6JUfZ6E1ptsYoCfYywyYu94h2LbylVRWOf6kgdBKGL+myar0owml5X/sfiBiKbMJdxjR
 uBGyEgJGKRh61/5wvDsT6HkMxZQIHhjPu3dk1bWtSkx7Pn2JVeJNtktRVX/VPb6d3bZs
 OPo0qpoSzZoll3JiCYZu0eE3a7QhjsEIQvtmIpQOCifle/W+kiPrJFlkTLwmiXV5FSLv
 TMZA==
X-Gm-Message-State: AOJu0Yy4OzoKuYJP62KPQ/8pdXEhxFnd+/0LjQowsJ/4+d2qKtjD0U6x
 pYbtZXOFEuEypJTBqDJiAFFVn26IGgVJHjM6Wwc=
X-Google-Smtp-Source: AGHT+IFHfJjP8pNWusgroZB0i2+SpeL/O8rmvuGdBu84KWlu4zgsQASUOdrpxkEN/110ZJDSGKUdUg==
X-Received: by 2002:a62:8412:0:b0:6b1:e876:168b with SMTP id
 k18-20020a628412000000b006b1e876168bmr7004316pfd.11.1697954676825; 
 Sat, 21 Oct 2023 23:04:36 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fb13-20020a056a002d8d00b0068a46cd4120sm4007373pfb.199.2023.10.21.23.04.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:04:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 41/90] target/sparc: Move JMPL, RETT, RETURN to decodetree
Date: Sat, 21 Oct 2023 22:59:42 -0700
Message-Id: <20231022060031.490251-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
 target/sparc/insns.decode |   7 +++
 target/sparc/translate.c  | 126 ++++++++++++++++++++++++--------------
 2 files changed, 88 insertions(+), 45 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 8de986f0bb..271789ac13 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -28,6 +28,7 @@ CALL    01 i:s30
 
 &r_r_ri     rd rs1 rs2_or_imm imm:bool
 @n_r_ri     .. ..... ...... rs1:5 imm:1 rs2_or_imm:s13     &r_r_ri rd=0
+@r_r_ri     .. rd:5  ...... rs1:5 imm:1 rs2_or_imm:s13     &r_r_ri
 
 &r_r_ri_cc  rd rs1 rs2_or_imm imm:bool cc:bool
 @r_r_ri_cc  .. rd:5  . cc:1 .... rs1:5 imm:1 rs2_or_imm:s13    &r_r_ri_cc
@@ -217,6 +218,12 @@ MOVcc       10 rd:5  101100 1 cond:4 imm:1 cc:1 0 rs2_or_imm:s11
 MOVfcc      10 rd:5  101100 0 cond:4 imm:1 cc:2   rs2_or_imm:s11
 MOVR        10 rd:5  101111 rs1:5    imm:1 cond:3 rs2_or_imm:s10
 
+JMPL        10 ..... 111000 ..... . .............          @r_r_ri
+{
+  RETT      10 00000 111001 ..... . .............          @n_r_ri
+  RETURN    10 00000 111001 ..... . .............          @n_r_ri
+}
+
 NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
 NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 7f6adf35ae..861aeaaa34 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -40,6 +40,7 @@
 #define gen_helper_rdpsr(D, E)          qemu_build_not_reached()
 #define gen_helper_wrpsr(E, S)          qemu_build_not_reached()
 #define gen_helper_power_down(E)        g_assert_not_reached()
+#define gen_helper_rett(E)              qemu_build_not_reached()
 #else
 #define gen_helper_rdccr(D, E)          qemu_build_not_reached()
 #define gen_helper_rdcwp(D, E)          qemu_build_not_reached()
@@ -4521,6 +4522,85 @@ static bool trans_MOVR(DisasContext *dc, arg_MOVR *a)
     return do_mov_cond(dc, &cmp, a->rd, src2);
 }
 
+static bool do_add_special(DisasContext *dc, arg_r_r_ri *a,
+                           bool (*func)(DisasContext *dc, int rd, TCGv src))
+{
+    TCGv src1, sum;
+
+    /* For simplicity, we under-decoded the rs2 form. */
+    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+        return false;
+    }
+
+    /*
+     * Always load the sum into a new temporary.
+     * This is required to capture the value across a window change,
+     * e.g. SAVE and RESTORE, and may be optimized away otherwise.
+     */
+    sum = tcg_temp_new();
+    src1 = gen_load_gpr(dc, a->rs1);
+    if (a->imm || a->rs2_or_imm == 0) {
+        tcg_gen_addi_tl(sum, src1, a->rs2_or_imm);
+    } else {
+        tcg_gen_add_tl(sum, src1, cpu_regs[a->rs2_or_imm]);
+    }
+    return func(dc, a->rd, sum);
+}
+
+static bool do_jmpl(DisasContext *dc, int rd, TCGv src)
+{
+    /*
+     * Preserve pc across advance, so that we can delay
+     * the writeback to rd until after src is consumed.
+     */
+    target_ulong cur_pc = dc->pc;
+
+    gen_check_align(dc, src, 3);
+
+    gen_mov_pc_npc(dc);
+    tcg_gen_mov_tl(cpu_npc, src);
+    gen_address_mask(dc, cpu_npc);
+    gen_store_gpr(dc, rd, tcg_constant_tl(cur_pc));
+
+    dc->npc = DYNAMIC_PC_LOOKUP;
+    return true;
+}
+
+TRANS(JMPL, ALL, do_add_special, a, do_jmpl)
+
+static bool do_rett(DisasContext *dc, int rd, TCGv src)
+{
+    if (!supervisor(dc)) {
+        return raise_priv(dc);
+    }
+
+    gen_check_align(dc, src, 3);
+
+    gen_mov_pc_npc(dc);
+    tcg_gen_mov_tl(cpu_npc, src);
+    gen_helper_rett(tcg_env);
+
+    dc->npc = DYNAMIC_PC;
+    return true;
+}
+
+TRANS(RETT, 32, do_add_special, a, do_rett)
+
+static bool do_return(DisasContext *dc, int rd, TCGv src)
+{
+    gen_check_align(dc, src, 3);
+
+    gen_mov_pc_npc(dc);
+    tcg_gen_mov_tl(cpu_npc, src);
+    gen_address_mask(dc, cpu_npc);
+
+    gen_helper_restore(tcg_env);
+    dc->npc = DYNAMIC_PC_LOOKUP;
+    return true;
+}
+
+TRANS(RETURN, 64, do_add_special, a, do_return)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -5318,30 +5398,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             } else if (xop == 0x37) {
                 /* V8 CPop2, V9 impdep2 */
                 goto illegal_insn; /* in decodetree */
-#ifdef TARGET_SPARC64
-            } else if (xop == 0x39) { /* V9 return */
-                save_state(dc);
-                cpu_src1 = get_src1(dc, insn);
-                cpu_tmp0 = tcg_temp_new();
-                if (IS_IMM) {   /* immediate */
-                    simm = GET_FIELDs(insn, 19, 31);
-                    tcg_gen_addi_tl(cpu_tmp0, cpu_src1, simm);
-                } else {                /* register */
-                    rs2 = GET_FIELD(insn, 27, 31);
-                    if (rs2) {
-                        cpu_src2 = gen_load_gpr(dc, rs2);
-                        tcg_gen_add_tl(cpu_tmp0, cpu_src1, cpu_src2);
-                    } else {
-                        tcg_gen_mov_tl(cpu_tmp0, cpu_src1);
-                    }
-                }
-                gen_check_align(dc, cpu_tmp0, 3);
-                gen_helper_restore(tcg_env);
-                gen_mov_pc_npc(dc);
-                tcg_gen_mov_tl(cpu_npc, cpu_tmp0);
-                dc->npc = DYNAMIC_PC_LOOKUP;
-                goto jmp_insn;
-#endif
             } else {
                 cpu_src1 = get_src1(dc, insn);
                 cpu_tmp0 = tcg_temp_new();
@@ -5359,28 +5415,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 }
                 switch (xop) {
                 case 0x38:      /* jmpl */
-                    {
-                        gen_check_align(dc, cpu_tmp0, 3);
-                        gen_store_gpr(dc, rd, tcg_constant_tl(dc->pc));
-                        gen_mov_pc_npc(dc);
-                        gen_address_mask(dc, cpu_tmp0);
-                        tcg_gen_mov_tl(cpu_npc, cpu_tmp0);
-                        dc->npc = DYNAMIC_PC_LOOKUP;
-                    }
-                    goto jmp_insn;
-#if !defined(CONFIG_USER_ONLY) && !defined(TARGET_SPARC64)
                 case 0x39:      /* rett, V9 return */
-                    {
-                        if (!supervisor(dc))
-                            goto priv_insn;
-                        gen_check_align(dc, cpu_tmp0, 3);
-                        gen_mov_pc_npc(dc);
-                        tcg_gen_mov_tl(cpu_npc, cpu_tmp0);
-                        dc->npc = DYNAMIC_PC;
-                        gen_helper_rett(tcg_env);
-                    }
-                    goto jmp_insn;
-#endif
+                    g_assert_not_reached();  /* in decode tree */
                 case 0x3b: /* flush */
                     /* nop */
                     break;
-- 
2.34.1


