Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F09A7D797D
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:30:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6n-0002DE-Dz; Wed, 25 Oct 2023 20:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6K-0001N0-AR
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:52 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6E-0006tK-Gf
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:52 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1caa371dcd8so2470715ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279585; x=1698884385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohRPCpHejAizc95/5iNRUGKyBYgA+JY/mkKKy87OBpc=;
 b=vGmSKpy9zh6ZrrOoUOI0GX1d4PnYcXjqLQBxykTwEFT1TEAvSJTtCCJzFYcPS66T0F
 yOAv0Daoh7ZDRUCdo5qmQNJI7pjFJwvyxCKEhmC3KGEG8miPiyASiMB+r8rvZiezxSkh
 vNQn2/fDCppsfKXaig+gK/IaKFAWsiqFSAUeMFTcKSPF8qPexcApwjAnsFGEEvU+C+H6
 uAvmd9c3Gm7AHTXIT74n5PGSYk5UdFYRmB2etnLGZTTq64rBgdwb6zdSIILWwct6w3/1
 4hmtJ5fzBqMavWv+6la8xcTuMfSlCZuVVR3pBocXtCD7Owdiw3owS71yUuSZFqRiQkcG
 58hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279585; x=1698884385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ohRPCpHejAizc95/5iNRUGKyBYgA+JY/mkKKy87OBpc=;
 b=XkRrlc0h0Iy9vzyahveRluFkmDRBINVXahJbc8VuyMfDKVXDG82qcsyl2mpa404c0D
 m8vwCKjXUpknkQMcbwEF7DOb53vD/0QFPW0ua7XTU4ynAz+/kK/TP4m3/8NWJ4IcZj/I
 P91BX47FwQzuzCp752MpANzhyZhZhMQwH6tg6KOzGUCCvcs6iCn5RCWCYJXQRrFIDrw3
 Cd0hcSzG0CN8cKMLrijEuNc+jzskw+One9i9sRzXpDnZMXFq+qpLAVyU8y7GVcwwX3nf
 jUXCygW0t8tNCMp/cL5OidlSdyYvycEMFhzD5JxXLpiv1OZmISvNbVh7AuJg4YTFpJfP
 rbHg==
X-Gm-Message-State: AOJu0YwwySD5o+BKaxFs0XbkGBF9BXBIH/L3YI9d0j2LBzf57N16Rf6X
 TS2KUCxGWpnWUtcPWUxFjYbOMFU7sbzCETKCzvw=
X-Google-Smtp-Source: AGHT+IFHDHYGUcv2O75vFQnaeQOS7Sh3WXPXcOKRfpiWccCyQApsFjs/JObnYWVBiBBOZl4+vmP7qw==
X-Received: by 2002:a17:902:e5c1:b0:1c9:d667:4e4e with SMTP id
 u1-20020a170902e5c100b001c9d6674e4emr14369808plf.65.1698279585197; 
 Wed, 25 Oct 2023 17:19:45 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 45/94] target/sparc: Move JMPL, RETT, RETURN to decodetree
Date: Wed, 25 Oct 2023 17:14:53 -0700
Message-Id: <20231026001542.1141412-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
index 7cd1af1014..91de0b1206 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -38,6 +38,7 @@
 
 #ifdef TARGET_SPARC64
 # define gen_helper_rdpsr(D, E)                 qemu_build_not_reached()
+# define gen_helper_rett(E)                     qemu_build_not_reached()
 # define gen_helper_power_down(E)               qemu_build_not_reached()
 # define gen_helper_wrpsr(E, S)                 qemu_build_not_reached()
 #else
@@ -4377,6 +4378,85 @@ static bool trans_MOVR(DisasContext *dc, arg_MOVR *a)
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
@@ -5174,30 +5254,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5215,28 +5271,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


