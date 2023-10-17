Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A347CBB33
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:29:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdNn-0003Jx-Ez; Tue, 17 Oct 2023 02:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNY-0002s4-7B
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:33 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNW-0004hm-Af
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:31 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6b44befac59so2671039b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523389; x=1698128189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EUH/zCjHRWrJhuZO0lPAiKH0TunCvsKy8p9HhauQ8og=;
 b=cyg2eYlqkj4ayPWsx+eC9tjJAaUMp3xEpbmu4v4w2Gw/BTeyKBOKTLLgM4ryW0E2ns
 2ARVzywkgEn4Jn0q7MQuFyT8pG+j+0fSp/dAC23MDnTblLcDRHz3WiRVirQC2YwdmLF5
 R322ErcRKlKrBY+Gd7pUS3L3c9ZWu7X6eSaN3i/tR4knghTORtvv8LU8z56iY1TT2+ur
 o8aGTZEJus04XTpTQqfLAYeS2g1H+C7AsHdU/lYZWueuvUSBrvmDJlnwjDnMF8osNZ6P
 05dfkxS2CBgK+rNvioveNRR+28P84wXjKlRoG0dK3pAlj9YcOdLy4ILNKqXehPc7p/JB
 qgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523389; x=1698128189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EUH/zCjHRWrJhuZO0lPAiKH0TunCvsKy8p9HhauQ8og=;
 b=g5gVGy/V2MOk2gd3QhZIwQLd+Jgcb1kE0VlqevRj8Rn4j/eb0jHJO1BK7LgV1DSvMr
 buh4uLUgWaLKtszQBWRd4JAGvLNU+re+mmmCo2utqaIUWhku0/LGjyVIQpz5jYxTtlku
 q0/Er+019SiUsPDRjZm/z5E88WvjRGbf1UuvuU0P7QxFTxmQCAVG0f1S+5SM8opkRqyn
 NzuHj9mfWpwvzVblRKe56BhcPwdD8mP7y8D3qyybyGqs10rFdWqtzjjg0Uf18vGbwU/c
 RWvSMi9drS37taA8VOl4/8NhEkN7TCK4uqavArJcWLr9Gkg8JaNGczfFbpecxmR6Sp37
 VgGQ==
X-Gm-Message-State: AOJu0YxtuB7pGTeGjzEC/7Qg2PRtpHMj5Wl7pex1GUutll8ZzeQg/DvZ
 ISKTzFi/ScrVHOwlVnbRHBRsMW7WEmyFX3ny+N0=
X-Google-Smtp-Source: AGHT+IFhCCeKM4E9TZpEE38yd8HZNHlzGfr3HUOzxS0RIHte3NfB2YInGwzIjq4OThZeP7T9i0W7zw==
X-Received: by 2002:a05:6a20:748d:b0:133:1d62:dcbd with SMTP id
 p13-20020a056a20748d00b001331d62dcbdmr1427539pzd.28.1697523389003; 
 Mon, 16 Oct 2023 23:16:29 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 52/90] target/sparc: Move CASA, CASXA to decodetree
Date: Mon, 16 Oct 2023 23:12:06 -0700
Message-Id: <20231017061244.681584-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Remove gen_cas_asi, gen_casx_asi.
Rename gen_cas_asi0 to gen_cas_asi.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  7 ++++
 target/sparc/translate.c  | 71 +++++++++++++++------------------------
 2 files changed, 35 insertions(+), 43 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 32ac9cdbf7..8e6a24e094 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -233,6 +233,8 @@ RETRY       10 00001 111110 00000 0 0000000000000
 @r_r_r_asi  .. rd:5  ...... rs1:5 0     asi:8 rs2_or_imm:5 &r_r_ri_asi imm=0
 @r_r_i_asi  .. rd:5  ...... rs1:5 1     rs2_or_imm:s13     \
             &r_r_ri_asi imm=1 asi=-2
+@casa_imm   .. rd:5  ...... rs1:5 1 00000000 rs2_or_imm:5  \
+            &r_r_ri_asi imm=1 asi=-2
 
 LDUW        11 ..... 000000 ..... . .............          @r_r_ri_na
 LDUB        11 ..... 000001 ..... . .............          @r_r_ri_na
@@ -285,6 +287,11 @@ SWAP        11 ..... 001111 ..... . .............          @r_r_ri_na
 SWAP        11 ..... 011111 ..... . .............          @r_r_r_asi # SWAPA
 SWAP        11 ..... 011111 ..... . .............          @r_r_i_asi # SWAPA
 
+CASA        11 ..... 111100 ..... . .............          @r_r_r_asi
+CASA        11 ..... 111100 ..... . .............          @casa_imm
+CASXA       11 ..... 111110 ..... . .............          @r_r_r_asi
+CASXA       11 ..... 111110 ..... . .............          @casa_imm
+
 NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
 NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index e1b8cdd798..6b860dbd75 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2211,8 +2211,8 @@ static void gen_swap_asi(DisasContext *dc, DisasASI *da,
     }
 }
 
-static void gen_cas_asi0(DisasContext *dc, DisasASI *da,
-                         TCGv oldv, TCGv newv, TCGv cmpv, TCGv addr)
+static void gen_cas_asi(DisasContext *dc, DisasASI *da,
+                        TCGv oldv, TCGv newv, TCGv cmpv, TCGv addr)
 {
     switch (da->type) {
     case GET_ASI_EXCP:
@@ -2228,30 +2228,6 @@ static void gen_cas_asi0(DisasContext *dc, DisasASI *da,
     }
 }
 
-static void __attribute__((unused))
-gen_cas_asi(DisasContext *dc, TCGv addr, TCGv cmpv, int insn, int rd)
-{
-    DisasASI da = get_asi(dc, insn, MO_TEUL);
-    TCGv oldv = gen_dest_gpr(dc, rd);
-    TCGv newv = gen_load_gpr(dc, rd);
-
-    gen_address_mask(dc, addr);
-    gen_cas_asi0(dc, &da, oldv, newv, cmpv, addr);
-    gen_store_gpr(dc, rd, oldv);
-}
-
-static void __attribute__((unused))
-gen_casx_asi(DisasContext *dc, TCGv addr, TCGv cmpv, int insn, int rd)
-{
-    DisasASI da = get_asi(dc, insn, MO_TEUQ);
-    TCGv oldv = gen_dest_gpr(dc, rd);
-    TCGv newv = gen_load_gpr(dc, rd);
-
-    gen_address_mask(dc, addr);
-    gen_cas_asi0(dc, &da, oldv, newv, cmpv, addr);
-    gen_store_gpr(dc, rd, oldv);
-}
-
 static void gen_ldstub_asi(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
 {
     switch (da->type) {
@@ -2861,6 +2837,7 @@ static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
 # define avail_64(C)      false
 #endif
 #define avail_ASR17(C)    ((C)->def->features & CPU_FEATURE_ASR17)
+#define avail_CASA(C)     ((C)->def->features & CPU_FEATURE_CASA)
 #define avail_DIV(C)      ((C)->def->features & CPU_FEATURE_DIV)
 #define avail_GL(C)       ((C)->def->features & CPU_FEATURE_GL)
 #define avail_HYPV(C)     ((C)->def->features & CPU_FEATURE_HYPV)
@@ -4694,6 +4671,28 @@ static bool trans_SWAP(DisasContext *dc, arg_r_r_ri_asi *a)
     return advance_pc(dc);
 }
 
+static bool do_casa(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
+{
+    TCGv addr, o, n, c;
+    DisasASI da;
+
+    addr = gen_ldst_addr(dc, a->rs1, true, 0);
+    if (addr == NULL) {
+        return false;
+    }
+    da = resolve_asi(dc, a->asi, mop);
+
+    o = gen_dest_gpr(dc, a->rd);
+    n = gen_load_gpr(dc, a->rd);
+    c = gen_load_gpr(dc, a->rs2_or_imm);
+    gen_cas_asi(dc, &da, o, n, c, addr);
+    gen_store_gpr(dc, a->rd, o);
+    return advance_pc(dc);
+}
+
+TRANS(CASA, CASA, do_casa, a, MO_TEUL)
+TRANS(CASXA, 64, do_casa, a, MO_TEUQ)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -5497,9 +5496,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             TCGv cpu_addr = tcg_temp_new();
 
             tcg_gen_mov_tl(cpu_addr, get_src1(dc, insn));
-            if (xop == 0x3c || xop == 0x3e) {
-                /* V9 casa/casxa : no offset */
-            } else if (IS_IMM) {     /* immediate */
+            if (IS_IMM) {     /* immediate */
                 simm = GET_FIELDs(insn, 19, 31);
                 if (simm != 0) {
                     tcg_gen_addi_tl(cpu_addr, cpu_addr, simm);
@@ -5712,22 +5709,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     }
                     gen_stf_asi(dc, cpu_addr, insn, 8, DFPREG(rd));
                     break;
+#endif
                 case 0x3e: /* V9 casxa */
-                    rs2 = GET_FIELD(insn, 27, 31);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_casx_asi(dc, cpu_addr, cpu_src2, insn, rd);
-                    break;
-#endif
-#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
                 case 0x3c: /* V9 or LEON3 casa */
-#ifndef TARGET_SPARC64
-                    CHECK_IU_FEATURE(dc, CASA);
-#endif
-                    rs2 = GET_FIELD(insn, 27, 31);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_cas_asi(dc, cpu_addr, cpu_src2, insn, rd);
-                    break;
-#endif
+                    goto illegal_insn; /* in decodetree */
                 default:
                     goto illegal_insn;
                 }
-- 
2.34.1


