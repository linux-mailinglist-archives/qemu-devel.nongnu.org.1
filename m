Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C997C8F42
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:35:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPm9-0001XV-Ki; Fri, 13 Oct 2023 17:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPm0-0000Sx-UO
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:45 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPly-0001SU-RQ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:44 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3b2b1b03074so647038b6e.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232761; x=1697837561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOfC2T24jzV3tSPb2hgECBjIPhZHVxlVr0RgMAjSd8k=;
 b=QP/1BAPt2zvWIPvAiOyHSxoJwM8FS5+a7y+s895IhfGUJrDjgCqJvSSlXS2ERCUqWm
 iIMeaDLVsrf9ASve4yF/bozaTGj3nbpib6zp9zux2HcGkXyLGONNK9ayasKTVJiZj1dv
 x6WDWxBV2sf5OIIp/po6KSRbb37ulkd0XXllBX0CFzgNRb5V9DMOsgAO204tk8rp2Rue
 LJsjHIE6IbWuajtWYtofwunFwzpzSH4hRzMxz+Wl3LBj8Q5flh0ROvIljwns06tm4rjA
 PTAz+ZcRUu/iR6h4Y+DR9Bvw5ItL/S9H/+DogCTcb/RZAyoVwigKwEhQQLVRXT3Y/aYj
 8mGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232761; x=1697837561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OOfC2T24jzV3tSPb2hgECBjIPhZHVxlVr0RgMAjSd8k=;
 b=iAZHXrBR3pphLSgZ+BDxDq55vkeb+XwXQ2M6n+gCLlyVZOwZbrsZd0GIVnFdew1DDW
 RERIVgQCRQiz3TkhxwCRVu2vzFkH3NXt3QJUBgC7yU+fBcbqw/vgvg2F1h7R3HkudSuV
 zenTGUbosfhvh7Ptdv25yGjXqbBAhhDHARLb+tUjnhWwDhAgV1i0ZbiXGZjuk+qOuk+7
 PkRUM/xUNv4CQs5llrTA62r4UJiQtJQ6bJxe8fqaNHeauKTwIASXfVNVvC/T8tOM7rTu
 zJmezkqgP7XtsuqqDL9E1hSuiffW3s6TmYmXBxys57hP8NUn6yElG5+y6pICSHkhSuLO
 5mHw==
X-Gm-Message-State: AOJu0YzAiQhZkcRriAEPWKqB8N6FSKQCsn4b8KyqFG4+k4dNShsfcUlz
 q8AejbuGQtikSfFlG3Mb0vbBLT5Ce52bMXdz3bc=
X-Google-Smtp-Source: AGHT+IFIGjoDkpyhFzvUa6Gf4c7jT/xCV+YNUUyOwEMOLmU+Uv8DDk3/WYWj/ZFmSGQTb5dCmrOQeA==
X-Received: by 2002:a05:6358:7246:b0:14a:e8af:1279 with SMTP id
 i6-20020a056358724600b0014ae8af1279mr29287069rwa.10.1697232761583; 
 Fri, 13 Oct 2023 14:32:41 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 58/85] target/sparc: Move FMOVS, FNEGS, FABSS, FSRC*S,
 FNOT*S to decodetree
Date: Fri, 13 Oct 2023 14:28:19 -0700
Message-Id: <20231013212846.165724-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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
 target/sparc/insns.decode | 13 ++++++++
 target/sparc/translate.c  | 64 ++++++++++++++++-----------------------
 2 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 1418e45172..2072930bd7 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -33,6 +33,10 @@ CALL    01 i:s30
 &r_r_r      rd rs1 rs2
 @r_r_r      .. rd:5  ...... rs1:5 . ........ rs2:5         &r_r_r
 
+&r_r        rd rs
+@r_r1       .. rd:5  ...... rs:5  . ........ .....         &r_r
+@r_r2       .. rd:5  ...... ..... . ........ rs:5          &r_r
+
 Tcc_r   10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
 Tcc_i   10 0 cond:4 111010 rs1:5 1 cc:1 0000 i:8
 
@@ -228,6 +232,10 @@ RESTORE     10 ..... 111101 ..... . .............          @r_r_ri
 DONE        10 00000 111110 00000 0 0000000000000
 RETRY       10 00001 111110 00000 0 0000000000000
 
+FMOVs       10 ..... 110100 00000 0 0000 0001 .....        @r_r2
+FNEGs       10 ..... 110100 00000 0 0000 0101 .....        @r_r2
+FABSs       10 ..... 110100 00000 0 0000 1001 .....        @r_r2
+
 {
   [
     EDGE8cc     10 ..... 110110 ..... 0 0000 0000 .....    @r_r_r
@@ -251,6 +259,11 @@ RETRY       10 00001 111110 00000 0 0000000000000
     ALIGNADDRL  10 ..... 110110 ..... 0 0001 1010 .....    @r_r_r
 
     BMASK       10 ..... 110110 ..... 0 0001 1001 .....    @r_r_r
+
+    FSRCs       10 ..... 110110 ..... 0 0111 0101 00000    @r_r1  # FSRC1s
+    FSRCs       10 ..... 110110 00000 0 0111 1001 .....    @r_r2  # FSRC2s
+    FNOTs       10 ..... 110110 ..... 0 0110 1011 00000    @r_r1  # FNOT1s
+    FNOTs       10 ..... 110110 00000 0 0110 0111 .....    @r_r2  # FNOT2s
   ]
   NCP           10 ----- 110110 ----- --------- -----      # v8 CPop1
 }
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index d0efe9f72b..c2fe193b6d 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1481,19 +1481,6 @@ static void gen_fop_FF(DisasContext *dc, int rd, int rs,
     gen_store_fpr_F(dc, rd, dst);
 }
 
-static void gen_ne_fop_FF(DisasContext *dc, int rd, int rs,
-                          void (*gen)(TCGv_i32, TCGv_i32))
-{
-    TCGv_i32 dst, src;
-
-    src = gen_load_fpr_F(dc, rs);
-    dst = gen_dest_fpr_F(dc);
-
-    gen(dst, src);
-
-    gen_store_fpr_F(dc, rd, dst);
-}
-
 static void gen_fop_FFF(DisasContext *dc, int rd, int rs1, int rs2,
                         void (*gen)(TCGv_i32, TCGv_ptr, TCGv_i32, TCGv_i32))
 {
@@ -4823,6 +4810,27 @@ static bool do_stfsr(DisasContext *dc, arg_r_r_ri *a, MemOp mop)
 TRANS(STFSR, ALL, do_stfsr, a, MO_TEUL)
 TRANS(STXFSR, 64, do_stfsr, a, MO_TEUQ)
 
+static bool do_ff(DisasContext *dc, arg_r_r *a,
+                  void (*func)(TCGv_i32, TCGv_i32))
+{
+    TCGv_i32 tmp;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    tmp = gen_load_fpr_F(dc, a->rs);
+    func(tmp, tmp);
+    gen_store_fpr_F(dc, a->rd, tmp);
+    return advance_pc(dc);
+}
+
+TRANS(FMOVs, ALL, do_ff, a, tcg_gen_mov_i32)
+TRANS(FNEGs, ALL, do_ff, a, gen_helper_fnegs)
+TRANS(FABSs, ALL, do_ff, a, gen_helper_fabss)
+TRANS(FSRCs, VIS1, do_ff, a, tcg_gen_mov_i32)
+TRANS(FNOTs, VIS1, do_ff, a, tcg_gen_not_i32)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -4864,15 +4872,9 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
 
                 switch (xop) {
                 case 0x1: /* fmovs */
-                    cpu_src1_32 = gen_load_fpr_F(dc, rs2);
-                    gen_store_fpr_F(dc, rd, cpu_src1_32);
-                    break;
                 case 0x5: /* fnegs */
-                    gen_ne_fop_FF(dc, rd, rs2, gen_helper_fnegs);
-                    break;
                 case 0x9: /* fabss */
-                    gen_ne_fop_FF(dc, rd, rs2, gen_helper_fabss);
-                    break;
+                    g_assert_not_reached(); /* in decodetree */
                 case 0x29: /* fsqrts */
                     gen_fop_FF(dc, rd, rs2, gen_helper_fsqrts);
                     break;
@@ -5200,6 +5202,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x018: /* VIS I alignaddr */
                 case 0x01a: /* VIS I alignaddrl */
                 case 0x019: /* VIS II bmask */
+                case 0x067: /* VIS I fnot2s */
+                case 0x06b: /* VIS I fnot1s */
+                case 0x075: /* VIS I fsrc1s */
+                case 0x079: /* VIS I fsrc2s */
                     g_assert_not_reached();  /* in decodetree */
                 case 0x020: /* VIS I fcmple16 */
                     CHECK_FPU_FEATURE(dc, VIS1);
@@ -5387,10 +5393,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DD(dc, rd, rs2, tcg_gen_not_i64);
                     break;
-                case 0x067: /* VIS I fnot2s */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_FF(dc, rd, rs2, tcg_gen_not_i32);
-                    break;
                 case 0x068: /* VIS I fandnot1 */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs2, rs1, tcg_gen_andc_i64);
@@ -5403,10 +5405,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DD(dc, rd, rs1, tcg_gen_not_i64);
                     break;
-                case 0x06b: /* VIS I fnot1s */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    gen_ne_fop_FF(dc, rd, rs1, tcg_gen_not_i32);
-                    break;
                 case 0x06c: /* VIS I fxor */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_xor_i64);
@@ -5444,11 +5442,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src1_64 = gen_load_fpr_D(dc, rs1);
                     gen_store_fpr_D(dc, rd, cpu_src1_64);
                     break;
-                case 0x075: /* VIS I fsrc1s */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_32 = gen_load_fpr_F(dc, rs1);
-                    gen_store_fpr_F(dc, rd, cpu_src1_32);
-                    break;
                 case 0x076: /* VIS I fornot2 */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs1, rs2, tcg_gen_orc_i64);
@@ -5462,11 +5455,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     cpu_src1_64 = gen_load_fpr_D(dc, rs2);
                     gen_store_fpr_D(dc, rd, cpu_src1_64);
                     break;
-                case 0x079: /* VIS I fsrc2s */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_src1_32 = gen_load_fpr_F(dc, rs2);
-                    gen_store_fpr_F(dc, rd, cpu_src1_32);
-                    break;
                 case 0x07a: /* VIS I fornot1 */
                     CHECK_FPU_FEATURE(dc, VIS1);
                     gen_ne_fop_DDD(dc, rd, rs2, rs1, tcg_gen_orc_i64);
-- 
2.34.1


