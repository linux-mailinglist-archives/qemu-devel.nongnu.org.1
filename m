Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEF37D2176
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:14:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRdY-000737-R4; Sun, 22 Oct 2023 02:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRdT-0006Wm-94
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:08:27 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRdN-00038C-82
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:08:26 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-27cfb8bc7eeso1763987a91.0
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954897; x=1698559697; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SBrTE3szdTliNMriMX1nfsISvxX2VppII5zGbDLPDys=;
 b=fiM7bJN2QShjEh69Vgb0iV1aHi9y8AX5B5etNfnd82Kl/J+v0mckeEDrUj/FzBRVpa
 Ftlhudxa3H3j5DKErNfgyX0I/XmzQaVgCtrcqeDe46RxK25xsO7oJztkhtwvmQcvAJ3v
 5nzJa6/kppnBpTzcW/GZEzmJTOda1xFVOoVYE0VDSaJiRuFEbNokakX+ceVGvh3wAFEb
 ECwnp/+W0qBqPO3/DgNyFZoi+P6da0scyznAmN5EcdD1UiGdSve0R2yBDsysCRgEqwRo
 8xZ2Q8U4Ei6bM/h5IL/ApUlUIuuW449g6+FshmnqFxk2gHxhdqLWVQciG2D3zXxG+D62
 G0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954897; x=1698559697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SBrTE3szdTliNMriMX1nfsISvxX2VppII5zGbDLPDys=;
 b=FIy5UaMgjz0st36J3avZNTcGvF5OkKXVED6VM5ADiMh5vJYXTnfafLHgJOqmp/D3aj
 j2CFm3ysWHw4zYyYNzV+NlfX7RcUbAhVh1K5ld/MtizgPzy5q9EPdmrckq/lLHqr46jg
 CA1Unwmltiw2Cy2eMxcEvIwNDm48BHe87LN7QZ2lA85eGW7txm6NvjUW4R+wkPsyfWLD
 GglKkb61uIFqhksC2oVYohqotVXzz5pTukGUh2L8BN4bYvSMm0RukseLZs4HwOZEcRQt
 FrCdBM51puSbkLL3sU6/mqdgcy2FmBnVWiY8PdalfTq1bD3QCEWN3E8t4b0UH8O1FXZR
 8NUA==
X-Gm-Message-State: AOJu0YxDv8uLR3lkSMvcJS/t4sTnPiXxrRk/sPWqR1ows6krnh2pOamX
 n7Hb+Jvd1WNdXdGmhH0R3e+b9FFd2JNQpncmxwg=
X-Google-Smtp-Source: AGHT+IHm+/EimBFfypK2r3Hkaw27ld0XWDe3CZoBpIaWIoSLKUmH4quQCam5kTsdgKW32VHCAJ5zhA==
X-Received: by 2002:a17:90b:1d09:b0:27d:48e1:d1e8 with SMTP id
 on9-20020a17090b1d0900b0027d48e1d1e8mr5575647pjb.13.1697954896802; 
 Sat, 21 Oct 2023 23:08:16 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 li11-20020a170903294b00b001c444106bcasm3962919plb.46.2023.10.21.23.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:08:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 89/90] target/sparc: Convert FZERO, FONE to decodetree
Date: Sat, 21 Oct 2023 23:00:30 -0700
Message-Id: <20231022060031.490251-90-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
 target/sparc/insns.decode |  5 +++
 target/sparc/translate.c  | 69 +++++++++++++++++++++++----------------
 2 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 18a840709f..0552f1447d 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -391,6 +391,11 @@ FCMPEq      10 000 cc:2 110101 rs1:5  0 0101 0111 rs2:5
     FORNOTs     10 ..... 110110 ..... 0 0111 1011 .....    @r_r_r_swap # ... 1s
     FORd        10 ..... 110110 ..... 0 0111 1100 .....    @r_r_r
     FORs        10 ..... 110110 ..... 0 0111 1101 .....    @r_r_r
+
+    FZEROd      10 rd:5  110110 00000 0 0110 0000 00000
+    FZEROs      10 rd:5  110110 00000 0 0110 0001 00000
+    FONEd       10 rd:5  110110 00000 0 0111 1110 00000
+    FONEs       10 rd:5  110110 00000 0 0111 1111 00000
   ]
   NCP           10 ----- 110110 ----- --------- -----      # v8 CPop1
 }
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 286ae7fd42..a3815619fe 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4746,6 +4746,45 @@ static bool do_stfsr(DisasContext *dc, arg_r_r_ri *a, MemOp mop)
 TRANS(STFSR, ALL, do_stfsr, a, MO_TEUL)
 TRANS(STXFSR, 64, do_stfsr, a, MO_TEUQ)
 
+static bool do_fc(DisasContext *dc, int rd, bool c)
+{
+    uint64_t mask;
+
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    if (rd & 1) {
+        mask = MAKE_64BIT_MASK(0, 32);
+    } else {
+        mask = MAKE_64BIT_MASK(32, 32);
+    }
+    if (c) {
+        tcg_gen_ori_i64(cpu_fpr[rd / 2], cpu_fpr[rd / 2], mask);
+    } else {
+        tcg_gen_andi_i64(cpu_fpr[rd / 2], cpu_fpr[rd / 2], ~mask);
+    }
+    gen_update_fprs_dirty(dc, rd);
+    return advance_pc(dc);
+}
+
+TRANS(FZEROs, VIS1, do_fc, a->rd, 0)
+TRANS(FONEs, VIS1, do_fc, a->rd, 1)
+
+static bool do_dc(DisasContext *dc, int rd, int64_t c)
+{
+    if (gen_trap_ifnofpu(dc)) {
+        return true;
+    }
+
+    tcg_gen_movi_i64(cpu_fpr[rd / 2], c);
+    gen_update_fprs_dirty(dc, rd);
+    return advance_pc(dc);
+}
+
+TRANS(FZEROd, VIS1, do_dc, a->rd, 0)
+TRANS(FONEd, VIS1, do_dc, a->rd, -1)
+
 static bool do_ff(DisasContext *dc, arg_r_r *a,
                   void (*func)(TCGv_i32, TCGv_i32))
 {
@@ -5466,10 +5505,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             } else if (xop == 0x36) {
 #ifdef TARGET_SPARC64
                 /* VIS */
-                TCGv_i64 cpu_dst_64;
-                TCGv_i32 cpu_dst_32;
                 int opf = GET_FIELD_SP(insn, 5, 13);
-                int rd = GET_FIELD(insn, 2, 6);
 
                 if (gen_trap_ifnofpu(dc)) {
                     goto jmp_insn;
@@ -5553,31 +5589,11 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x02e: /* VIS I fcmpeq32 */
                 case 0x03b: /* VIS I fpack16 */
                 case 0x03d: /* VIS I fpackfix */
-                    g_assert_not_reached();  /* in decodetree */
                 case 0x060: /* VIS I fzero */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_dst_64 = gen_dest_fpr_D(dc, rd);
-                    tcg_gen_movi_i64(cpu_dst_64, 0);
-                    gen_store_fpr_D(dc, rd, cpu_dst_64);
-                    break;
                 case 0x061: /* VIS I fzeros */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_dst_32 = gen_dest_fpr_F(dc);
-                    tcg_gen_movi_i32(cpu_dst_32, 0);
-                    gen_store_fpr_F(dc, rd, cpu_dst_32);
-                    break;
                 case 0x07e: /* VIS I fone */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_dst_64 = gen_dest_fpr_D(dc, rd);
-                    tcg_gen_movi_i64(cpu_dst_64, -1);
-                    gen_store_fpr_D(dc, rd, cpu_dst_64);
-                    break;
                 case 0x07f: /* VIS I fones */
-                    CHECK_FPU_FEATURE(dc, VIS1);
-                    cpu_dst_32 = gen_dest_fpr_F(dc);
-                    tcg_gen_movi_i32(cpu_dst_32, -1);
-                    gen_store_fpr_F(dc, rd, cpu_dst_32);
-                    break;
+                    g_assert_not_reached();  /* in decodetree */
                 case 0x080: /* VIS I shutdown */
                 case 0x081: /* VIS II siam */
                     // XXX
@@ -5602,11 +5618,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
  illegal_insn:
     gen_exception(dc, TT_ILL_INSN);
     return;
-#ifdef TARGET_SPARC64
- nfpu_insn:
-    gen_op_fpexception_im(dc, FSR_FTT_UNIMPFPOP);
-    return;
-#endif
 }
 
 static void sparc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
-- 
2.34.1


