Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C66827D79BA
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:42:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvoCm-0003vb-Eh; Wed, 25 Oct 2023 20:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvoCh-0003dR-Np
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:26:27 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvoCf-0000dm-Vx
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:26:27 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-27ddc1b1652so225961a91.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279983; x=1698884783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M7Hy4FRhrtQMUQBOlTBEDnVOTqOwnk/keHHETr31iWo=;
 b=TIi51CWiyBmVuXHZXDOOxM+LnL8jdxoBr63GIri14DNQi6gJwz4NXWiZrPLOz6JmD9
 xKFtxIBHZKt4AqdQU7qiUsmuXoos4sucmgcuunxi+2GTUTuScoc0Q8x5cdbb2t51t0Xn
 fen1FBvZP8DtT1IvbclAuWNcqGNnQkPaJIK0vkVCOcFbedp3BjPr5qOf6z1O8n8Qa8To
 zGLU6rV0zmsnU0OwRbDyScIY9GwBsVYxfJkPijUIynH1vD8FCh9CS06jiCWYIlkUJlLi
 H+6NuJ8PHjHZ+Ve74hzCYPeFgcL0yTfef3wpjhNaBr2SOvQoGZLWjY3WslIAOIhz3cmA
 wCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279983; x=1698884783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M7Hy4FRhrtQMUQBOlTBEDnVOTqOwnk/keHHETr31iWo=;
 b=IQiBcSsUW+PrmNWgIj/oXnhNr7ox/0fKHMeSLl0EOzJ+J5CbbHtqgjo2qcUV2PNoP3
 N3DmOLvTBqKm7rCRKPcvoxzb+oHTMLjTBLOzmX9BcT3zjq7BiwYb2LWj6tM6PK1uN9cE
 P1EfU1JSdwN3w8gdpvL9iVDEHlDmhv3BWtsE4+QnLvAr6utv6U+nwDKmhQzdygll4OmE
 5evUoH+WCrpb/cOXys1A4WDCoLIDJQ9sO7UzjDNqrUpjHe+vNMoi7mbpaMIIOmObBoTb
 TUHIWMLKqZxb8Tobtkk9mCCgsWzT6oms7/pf0Cggwy0XMQb5Njffgyz+XWYqRQlfecDA
 ZvuQ==
X-Gm-Message-State: AOJu0Yy6s9mmcPZHNKQn92EIbl95BGGoJ2BN4UxTHoenEX5yRj9bnyy0
 Fd48OMAWj9AP71x0MxnqMSZH/1qrRCm07PyC55s=
X-Google-Smtp-Source: AGHT+IH6v13+FYQIiJMHwUQGBut449mkc6WHN6hivgOodF0NjaeeAa6ofxPtg8M0jSoiJkQDagygYQ==
X-Received: by 2002:a17:90b:1d09:b0:27d:48e1:d1e8 with SMTP id
 on9-20020a17090b1d0900b0027d48e1d1e8mr15767986pjb.13.1698279983439; 
 Wed, 25 Oct 2023 17:26:23 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 gv24-20020a17090b11d800b00262ca945cecsm438134pjb.54.2023.10.25.17.26.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:26:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 93/94] target/sparc: Convert FZERO, FONE to decodetree
Date: Wed, 25 Oct 2023 17:15:41 -0700
Message-Id: <20231026001542.1141412-123-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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
index 15c91c6caa..62c77ae5e1 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4586,6 +4586,45 @@ static bool do_stfsr(DisasContext *dc, arg_r_r_ri *a, MemOp mop)
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
@@ -5303,10 +5342,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             } else if (xop == 0x36) {
 #ifdef TARGET_SPARC64
                 /* VIS */
-                TCGv_i64 cpu_dst_64;
-                TCGv_i32 cpu_dst_32;
                 int opf = GET_FIELD_SP(insn, 5, 13);
-                int rd = GET_FIELD(insn, 2, 6);
 
                 if (gen_trap_ifnofpu(dc)) {
                     goto jmp_insn;
@@ -5390,31 +5426,11 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5439,11 +5455,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


