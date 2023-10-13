Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E347C8F63
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:37:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPir-0006R7-AD; Fri, 13 Oct 2023 17:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPin-0006OO-2K
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:25 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPil-0000Xg-9p
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:24 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1e59894d105so1387315fac.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232562; x=1697837362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p3HGBTD0UBIZduEMW4qrZ7d2Q1jxYzUBU/JRcsvOL2g=;
 b=weMWRsJAmDAZNnfaMe3w5dDYugzzXkSDgy6deeizxEQri0rQdL9/bJf0S8k6j1osDu
 tIW/WzSoWMhv5HjrMMdWutZIvmv659c+1y99I0PRhfut/koWBs9QeVqQvsNgsYzHWjFK
 6MrnFhieBGqnDZB9s9XsmE8WHwO901a6JKPVRaeBpPavDhpGj9k2FqrcNTKN57uoxD9R
 PsZC56AJmN9a3x07LGKiJL2LDz8DCEFVTGGYfIz4KtKSLa6DeZ6/R5i6GmyO0TEqVnNq
 3SsNSpXsvnJ16UpIHRGrlXSC4uUpkmC9P/z6EAcDPmDUKfvLsLeDPtTrx1+PB0YXPhIz
 cWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232562; x=1697837362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p3HGBTD0UBIZduEMW4qrZ7d2Q1jxYzUBU/JRcsvOL2g=;
 b=UR2GQMHXyqoFwlQv6bWYyPX2tROgzCBcTCnPK1vTiHfpqftr199QQpbJDu3B0Lx4FD
 txDYDD06i0Vmu2c2GyfIVvF/+YOK5SWLKGhcqytYximY+kIppPJjxxCoJnP14jb4trbn
 FIt45DS/mTeoHdfg/w+fvyxgVYLbcyms90y/bHi0C8abg9MtDkielY+0H1wDw4EumVbn
 3rVMsF8JS8ZG0f1dVqX6ktpgbzdGiwjjZrtAFWB+9rFtSGBimATlcYzu39mGPPAw8j/H
 ikG0lI0ZYrRoIEO/GOQUTNATdQXri2Vh5JgQ7quGjr/khO5pAHx4PKkWbtmX+f0M+sHO
 xiNg==
X-Gm-Message-State: AOJu0Yy2RLlTY6Guq4RK9cfGsK3yQjXCaJWAAC05yTP+bYSv/Bb4MnbC
 VHs2v2YScuQwol0h4c//jamqsKxxMeJbQd4bJpg=
X-Google-Smtp-Source: AGHT+IF3XYnhl2hJHvrBV9IE1ZrWSUtOaac8W+Ob2c9vpEtEioHBDrclWY4J92VpSKERMI8e7RGQ/g==
X-Received: by 2002:a05:6870:1315:b0:1e9:ab99:6b7 with SMTP id
 21-20020a056870131500b001e9ab9906b7mr7542922oab.3.1697232562245; 
 Fri, 13 Oct 2023 14:29:22 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:29:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 36/85] target/sparc: Move JMPL, RETT, RETURN to decodetree
Date: Fri, 13 Oct 2023 14:27:57 -0700
Message-Id: <20231013212846.165724-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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
 target/sparc/insns.decode |   6 ++
 target/sparc/translate.c  | 121 +++++++++++++++++++++++---------------
 2 files changed, 79 insertions(+), 48 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index a124fdeaac..d8ebebce53 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -212,6 +212,12 @@ MOVcc       10 rd:5  101100 1 cond:4 imm:1 cc:1 0 rs2_or_imm:s11
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
index 72f3cbab47..47a281dc38 100644
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
@@ -4388,6 +4389,77 @@ static bool trans_MOVR(DisasContext *dc, arg_MOVR *a)
     return do_mov_cond(dc, &cmp, a->rd, src2);
 }
 
+static bool do_add_special(DisasContext *dc, arg_r_r_ri *a,
+                           bool (*func)(DisasContext *dc, int rd, TCGv src))
+{
+    TCGv src1, src;
+
+    /* For simplicity, we under-decoded the rs2 form. */
+    if (!a->imm && a->rs2_or_imm & ~0x1f) {
+        return false;
+    }
+
+    src1 = gen_load_gpr(dc, a->rs1);
+    if (a->rs2_or_imm == 0) {
+        src = src1;
+    } else {
+        src = tcg_temp_new();
+        if (a->imm) {
+            tcg_gen_addi_tl(src, src1, a->rs2_or_imm);
+        } else {
+            tcg_gen_add_tl(src, src1, cpu_regs[a->rs2_or_imm]);
+        }
+    }
+    return func(dc, a->rd, src);
+}
+
+static bool do_jmpl(DisasContext *dc, int rd, TCGv src)
+{
+    gen_check_align(src, 3);
+
+    gen_store_gpr(dc, rd, tcg_constant_tl(dc->pc));
+    gen_mov_pc_npc(dc);
+    tcg_gen_mov_tl(cpu_npc, src);
+    gen_address_mask(dc, cpu_npc);
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
+    gen_check_align(src, 3);
+
+    gen_mov_pc_npc(dc);
+    tcg_gen_mov_tl(cpu_npc, src);
+    dc->npc = DYNAMIC_PC;
+    gen_helper_rett(tcg_env);
+    return true;
+}
+
+TRANS(RETT, 32, do_add_special, a, do_rett)
+
+static bool do_return(DisasContext *dc, int rd, TCGv src)
+{
+    gen_check_align(src, 3);
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
@@ -5185,30 +5257,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
-                gen_helper_restore(tcg_env);
-                gen_mov_pc_npc(dc);
-                gen_check_align(cpu_tmp0, 3);
-                tcg_gen_mov_tl(cpu_npc, cpu_tmp0);
-                dc->npc = DYNAMIC_PC_LOOKUP;
-                goto jmp_insn;
-#endif
             } else {
                 cpu_src1 = get_src1(dc, insn);
                 cpu_tmp0 = tcg_temp_new();
@@ -5226,31 +5274,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 }
                 switch (xop) {
                 case 0x38:      /* jmpl */
-                    {
-                        TCGv t = gen_dest_gpr(dc, rd);
-                        tcg_gen_movi_tl(t, dc->pc);
-                        gen_store_gpr(dc, rd, t);
-
-                        gen_mov_pc_npc(dc);
-                        gen_check_align(cpu_tmp0, 3);
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
-                        gen_mov_pc_npc(dc);
-                        gen_check_align(cpu_tmp0, 3);
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


