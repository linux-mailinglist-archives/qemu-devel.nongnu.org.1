Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD127D272C
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:36:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhwf-0004Du-SM; Sun, 22 Oct 2023 19:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwb-0003u7-QV
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:18 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwZ-0007Ub-Dc
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:17 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso1911412b3a.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017593; x=1698622393; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=twbVd2hLrkB1GiMlGqm5gLVQu8V+Tvv3QKDrKrzmEGs=;
 b=WS6caRzi+B7RGFjf6x+d7oofYxTC8OEurgaOgq46xJkRq7qOzNP/ZsuwGHnmqVShid
 utxdXP9Qf9kdvFxFws2sk3/r6xnUTlVL4oa8awVS0WeZcI7OEmgIRygA+mhsVDh8RLme
 toz5eNawsgrW5IxESmuLAStBIbsp2d/xm3PCW+eYdtS5HRnFvuL+H6ycIyLoy1QlOgE9
 aXLXGyxihDluUR5bquzPumMNE5apJt5XOIG//UvYL1/6TVRVKlj8HgPHtF2wndASMUcS
 jexhTOVpSTmYUY7AiB9rN+nS2K/iwBB5B2uiJVfXsohVdkJoT9kLqohu5nIdQGmHHHrO
 c0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017593; x=1698622393;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=twbVd2hLrkB1GiMlGqm5gLVQu8V+Tvv3QKDrKrzmEGs=;
 b=SqZ4HT8ct22ejhmnmOoOS271x4nsQY/gUbhRRzBxmmRz1+AwbEnveyQy8+jZnz5MY6
 r9OGTxRYNAISG4whdgOQ8V5PR0cGCVULj8DLgCs+kMGVcWBnGIAVcqYmB4EhhFfiOUjS
 YXyYOAEt/JZ+AnWX1y2C542PJPfgAiOiBhgtGedFJ4xOVlRxffkwoYfRHRRVkZlClIz8
 t0KClj+QjB4aHM6zUXkVbAG+N89JixhWTq0dw7+anGyxaSQh19gkpI7gD4G2S0/LzjBd
 /2SuG9hcLRInDpXrPNlOLWCUs7etbcfRx4iJzNx/NWHRqm7Y3hMqrh0XNTYAcJUu3re5
 653g==
X-Gm-Message-State: AOJu0YwgqcGBzElJHeiepFtivvHSIxIeeWYcdr7ZeaJaOHPiMX0/DMea
 ERDzAxeh6T5shCWYmPeJBIuh7K/POMb6pDIo8JY=
X-Google-Smtp-Source: AGHT+IGN4PtpeGME+VcJgM2fWwJMiO1f858EybszS0aEHSwr8DE9l5rUPrknDA0j2osRfEPUv7uKnw==
X-Received: by 2002:a05:6a21:7895:b0:153:4ea6:d12e with SMTP id
 bf21-20020a056a21789500b001534ea6d12emr10366275pzc.17.1698017592894; 
 Sun, 22 Oct 2023 16:33:12 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 45/94] target/sparc: Move JMPL, RETT, RETURN to decodetree
Date: Sun, 22 Oct 2023 16:28:43 -0700
Message-Id: <20231022232932.80507-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
index 84d5b2a64e..f3cb5e5146 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -38,6 +38,7 @@
 
 #ifdef TARGET_SPARC64
 # define gen_helper_rdpsr(D, E)                 qemu_build_not_reached()
+# define gen_helper_rett(E)                     qemu_build_not_reached()
 # define gen_helper_power_down(E)               qemu_build_not_reached()
 # define gen_helper_wrpsr(E, S)                 qemu_build_not_reached()
 #else
@@ -4374,6 +4375,85 @@ static bool trans_MOVR(DisasContext *dc, arg_MOVR *a)
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
@@ -5171,30 +5251,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5212,28 +5268,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


