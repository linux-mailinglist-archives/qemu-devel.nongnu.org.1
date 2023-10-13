Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB35D7C8F52
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:36:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPpU-00013f-Sa; Fri, 13 Oct 2023 17:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPpS-0000sZ-U0
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:36:18 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPpH-0002UG-Av
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:36:18 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-694ed84c981so2096068b3a.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232965; x=1697837765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnbEgXFESw4jqrUMj4NcCB4PuWhIqf5K/vfEV8XV5Ms=;
 b=CKjd1VYoMyta9MINdQxGHQLjOEXH06CDQAYPGkKpsuJ/3B7L74LGn0aMhSbxaZ5DKO
 yEKFd1qHHfiPSEjvqkUTrm4B7hJI6FqYk76+GysWEQrJiBX1Iaz9XdaeLEnI5nlE9gOe
 3ZhpU5QNvzG/kcCzJi+rwnGVnkGPxw9beMeJ2XKQmcf9lqUULYLLWd0wH3vVw5zEjvmD
 M7/EZzPkt99jO/ui/m+kiL0O5BFjoFGIPtnihVszZQaXGdaWbwa6Txbej59LXf5pqP/Q
 3th9Yw1W8YnbittsGoSsGUy4vwan1NSaEl1STn4R9dsfceW6ulVrXTZiCgsHEbTAvbYY
 1mOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232965; x=1697837765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZnbEgXFESw4jqrUMj4NcCB4PuWhIqf5K/vfEV8XV5Ms=;
 b=B6jvbTBn21xIo4gvJaMtyfxcXrqtcj5RF6ZglB0gaZXqQjPNoSIU8AaGWEFf311UhS
 N7HrG/U2YR4nCifRuBPpXB+VVh9OF/waz2KwQyUGR67PTU9KcxQyh5ajqFPZle+9ll2v
 qJAXhNYNVE/G0phq+2ZzkXrPbV3/SQjCDB0HOjOSRIeYrvGYClSBjNha8eT9bjGlvfO0
 DW2PTJTw713q5H7CNGFsmSJHGMfe1oP/ApB+t+o3FyTSggR1ihIGFL8Cf8fLTvHI29AF
 7GA/jpLBcg/iC1SF6XPsiG24EFWKSnp/s1+irv0Z8K2njFc15smQGJ3k8d1TtNCDrLlZ
 aNHw==
X-Gm-Message-State: AOJu0Yzm6+aArA4R2Q2zbllsQacKMPtdatCo/hjLiVMOIQiOP80p3vyX
 uOpdhF3okO3Ok8MzSX+4SOjmn4DUwKFITKBGkqg=
X-Google-Smtp-Source: AGHT+IGrt3XFAaqSCRO7WfElUlwrw0Dj3/v3tpvkXPJsQgmg8Y1BeBB+EkTigOGTFuFYqO7SktPZSg==
X-Received: by 2002:a05:6a00:1252:b0:690:2ecd:a599 with SMTP id
 u18-20020a056a00125200b006902ecda599mr27041179pfi.21.1697232964829; 
 Fri, 13 Oct 2023 14:36:04 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v127-20020a626185000000b0068790c41ca2sm1123984pfb.27.2023.10.13.14.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:36:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 84/85] target/sparc: Convert FZERO, FONE to decodetree
Date: Fri, 13 Oct 2023 14:28:45 -0700
Message-Id: <20231013212846.165724-85-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
index 14daaa4a92..0c3d6071ff 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -385,6 +385,11 @@ FCMPEq      10 000 cc:2 110101 rs1:5  0 0101 0111 rs2:5
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
index a7e2bcfb53..ffdd600353 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4570,6 +4570,45 @@ static bool do_stfsr(DisasContext *dc, arg_r_r_ri *a, MemOp mop)
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
@@ -5285,10 +5324,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             } else if (xop == 0x36) {
 #ifdef TARGET_SPARC64
                 /* VIS */
-                TCGv_i64 cpu_dst_64;
-                TCGv_i32 cpu_dst_32;
                 int opf = GET_FIELD_SP(insn, 5, 13);
-                int rd = GET_FIELD(insn, 2, 6);
 
                 if (gen_trap_ifnofpu(dc)) {
                     goto jmp_insn;
@@ -5372,31 +5408,11 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5421,11 +5437,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


