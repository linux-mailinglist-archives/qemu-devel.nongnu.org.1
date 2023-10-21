Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2697D1B00
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:38:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4eM-0002UM-SN; Sat, 21 Oct 2023 01:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eA-0002Ac-O4
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:39 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4e7-00014j-II
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:37 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3b3e13fc1f7so1103950b6e.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866534; x=1698471334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5oloSKqPa4uKUpAROBAkURcXE2SWvCw2Bc9j/aFyVWY=;
 b=ONec+FU2SST0ob7+s0Ow4WH9xAXTpqZAggIzhCS1FfjrSxd9r4t4ioNcZCKHXPaNMP
 Vy5uhdFyhNBPgVUxjyTQ/kB8btRBeizNgkw/dKohDVqavnJjPWbJNaFbCA3zMVAv4QY6
 TsJxFlEJiI7/cdRyF/EMi2cF+NN3ucr6wF+eCJku/OCKgx4gj8VWuM9aqZhGG1INwxFz
 SHrFMS+NjwGr+yUp3UcIoj2t4JhsLua9U3SZcANCiamaACYXW1XlS4p1v8bWY8XEmyax
 rUP0kPHU99vLh9vlV5GRw6QZjAIr+yjFHrCEncY//x+ulD4dr1UpLM9Oajhn++AHUZmL
 M7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866534; x=1698471334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5oloSKqPa4uKUpAROBAkURcXE2SWvCw2Bc9j/aFyVWY=;
 b=oTFpblgjd3DG6uBKwT6jfqhRw4SrygbDb2GIsg7S5Ar12idi/KXsaHFdQfUQixKsYH
 kVyq2wW7ACjWYlcOkIOFuKO4VWJT486jsh765diigNRhpqFpHXEf8K/Jzyfr2IlPPO7P
 Xa65JPlIvEedEnx1a4eiMnHHQPTF4jbB+ES9Nh0K9p9MzxnojcMFiSx4AmBkhv14um8l
 XYosfVtNZxE9tePyrc/tKcmBByJgKGci6nTHuHjcVjrMHnNKS4Dyxpod08+ncK/l+C3R
 Y22V7lnzjNn4nPE61rbiQTA9YUY6HdhkXcvs0Am2EBhDuQMcV6QY5yEIKjZy3Pb6tqvl
 16ng==
X-Gm-Message-State: AOJu0YzdnCrAMwzkxM9O4A3bzwyF2XSW5ThM8Rm4I9s7R8cpn1UsHMPj
 VHHK+Jy5lamQvNnrJ3qROG7RUzZgrFdzPytQveU=
X-Google-Smtp-Source: AGHT+IHOBdSn4Z9vp8yuMT2KJM5vRxQrKwQGhBCR0QGwOPCttGmgoP4ZuzOHdzthv2e6lgoLFK+GKw==
X-Received: by 2002:aca:2410:0:b0:3ad:ffa4:e003 with SMTP id
 n16-20020aca2410000000b003adffa4e003mr3604087oic.33.1697866533730; 
 Fri, 20 Oct 2023 22:35:33 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b00690d255b5a1sm2427978pfn.217.2023.10.20.22.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:35:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 41/90] target/sparc: Move JMPL, RETT, RETURN to decodetree
Date: Fri, 20 Oct 2023 22:31:09 -0700
Message-Id: <20231021053158.278135-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x236.google.com
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
index 1303df92a7..c2bf5f78e3 100644
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
index edd9211572..51c267f019 100644
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
@@ -4480,6 +4481,85 @@ static bool trans_MOVR(DisasContext *dc, arg_MOVR *a)
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
@@ -5277,30 +5357,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5318,28 +5374,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


