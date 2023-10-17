Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9577CBB1F
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:26:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdRt-0005t2-P9; Tue, 17 Oct 2023 02:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdR3-0003ks-9G
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:20:13 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdQw-0005Dh-Ve
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:20:04 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6bd73395bceso1642700b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523600; x=1698128400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E1pdZHpeeWMsiJd0OhonUMx7zfAPncr8d+ROFD2wdCE=;
 b=jzkCAOrovihXX/UPgigkPlSmxKVtYDFlE6DrtH9bceH+E1g8rObZ4x3Nea+pgYBZ7s
 ze9cWUBb02THP+nfqO1AvNgGANZLTgFYB2JMEeJXKkFI5o+1p28jjhu7ZWAp2Q3pEkG7
 X06HSZcsve9xGcvS+4cddtiHniX/bhBOfdKh5CAEcLnDK8GyFZP6S1IKoUHGCBWUs5mH
 rAhGR3TTE4Ybgd2kTBDu5fVIqMFvxdRECNIDvjhQIAEBicLGQiIMuPsXOEXydUNVStLk
 Hw7iGuEQVmMHg7M15FNnlVP1mxQtnDEMxmYS8BAwuu17yT42hFmW0LLH1qAwRiNH7e61
 B1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523600; x=1698128400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E1pdZHpeeWMsiJd0OhonUMx7zfAPncr8d+ROFD2wdCE=;
 b=xUxEvgrB0bc30yC35dsJitBO9Ru48YXyez8kMZ3b2DLKCFB+0ghd0Tg9sia+dhp1fP
 YQDGoFzjkzc/yr0dRBjAn7dseD60+WIM106OHp9aba5weTf+0DEUP30iFBO5ATU1sTod
 qcG1We/aYU7vZsS98zKuJRDvElmqwjbR/EW99J19JYM0/u71XdimZgSEDAxPdRxPNnRE
 VbOKo4/QqZP0rJYY6FdAsI394x4R8Ba5gT9CvhByIGChbaJF8kVbDfzrp35szeoeFiN7
 +7Y8KT3S7vPVRm7OMWSMF1Weyhyzw0YOr9HqOGrg5Ra5hBeDBgL7eNXWBkHPRFaMDYh1
 GaJQ==
X-Gm-Message-State: AOJu0YzOZvkUJAMJ7WVLRELOeTgnTmK4SiWGFZg+tlX07BQQkk99gPT9
 p9nLTirrQZMRu9mwaubnLIHuIVHO7RczkYp3APU=
X-Google-Smtp-Source: AGHT+IENjvBDMwtKZaSukeqblTkqXCsx16dT+fxNEbSPZhsRs7IPl5hdbqdgxjoSJQr6iiz+6/fhJw==
X-Received: by 2002:a05:6a00:2d19:b0:6b2:5d32:57d with SMTP id
 fa25-20020a056a002d1900b006b25d32057dmr1485157pfb.5.1697523600666; 
 Mon, 16 Oct 2023 23:20:00 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 by2-20020a056a02058200b00588e8421fa8sm550331pgb.84.2023.10.16.23.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:20:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 89/90] target/sparc: Convert FZERO, FONE to decodetree
Date: Mon, 16 Oct 2023 23:12:43 -0700
Message-Id: <20231017061244.681584-90-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
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
index c9fe45adff..22d7e7fc09 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -384,6 +384,11 @@ FCMPEq      10 000 cc:2 110101 rs1:5  0 0101 0111 rs2:5
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
index bee9212ba2..ba41cfda3d 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4672,6 +4672,45 @@ static bool do_stfsr(DisasContext *dc, arg_r_r_ri *a, MemOp mop)
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
@@ -5392,10 +5431,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             } else if (xop == 0x36) {
 #ifdef TARGET_SPARC64
                 /* VIS */
-                TCGv_i64 cpu_dst_64;
-                TCGv_i32 cpu_dst_32;
                 int opf = GET_FIELD_SP(insn, 5, 13);
-                int rd = GET_FIELD(insn, 2, 6);
 
                 if (gen_trap_ifnofpu(dc)) {
                     goto jmp_insn;
@@ -5479,31 +5515,11 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5528,11 +5544,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


