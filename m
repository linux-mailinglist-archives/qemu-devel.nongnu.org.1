Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA6B7D1B3E
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:53:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4ht-0007Xq-Mi; Sat, 21 Oct 2023 01:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4hq-0007OX-F5
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:39:26 -0400
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4hh-0001Yq-EX
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:39:20 -0400
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7a66aa8ebb7so56505639f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866756; x=1698471556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4CsjaUORxr6wN4wOqP3umbaJeBnhGwyvSkeQxJvv0pc=;
 b=N2oTZ0YEeeZLFSMzx6lNuyk+8/pdHsOhD1NqIvRwH6qR3K5BBCGMA58Xoh8K9oGAyE
 Zmzqk0ULBkz5pDZqmA9ae+JC0JODk9fJvZ29ntzk7zRLwz8Iz/ZFD2WRFIqn/Mu+FOfJ
 vfHLg0qDD/6MkJ8xDlIBXyR7+z9GbAQ6XMNHu3vP3HHwp1jdBS7NeoRi7pPwYCJls3Vr
 GMFbodMyCmCAaIINDeZrDfV7hZEyFyOEsnyknUVJABM4TgrrZJMb5NWD7fj8ZmXUHbr/
 bjHaMMIx8E476JBh0DyRZjnrToCfD1vE6iKGunzSNJqzTrmKpgsq197X6h59463v3zkl
 3sHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866756; x=1698471556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4CsjaUORxr6wN4wOqP3umbaJeBnhGwyvSkeQxJvv0pc=;
 b=I5WAZ28CeRvXQzhFco59lRbEUJEJnseAxSZZn/WFePODXVCxS7d8FcdBQ9Ac0aaGs0
 k9elYW3Tf0MDf2JryU8VAk0guFbsjWeA4PSKbKnLLP3RA9sNdU6fxyKll8Al6nBO3uzK
 73X9C8nzGkt5fss/M07Hzy6DtGatiLiP3saMaxhzsyxuwP8znWU3pwbdfoNzn0WR5FAC
 P15DCT7gKXBZ46hD9xw6c6XZrU/LLUuwE7HOY36KsCmXYrH5v1Ah+4caKnKxe/hgXnaL
 T/RjtiLaLPwdLw+KnAExi+/0uqjJTenKGzfVO5I+H76guj7AQycbFK3pBpGuIjBn9TAH
 pIow==
X-Gm-Message-State: AOJu0YzzoIPFmqWtV0U2Sbx41eXGtXHoMabyhkhmKJjpQhGjD2GvFGjy
 3+Y9jufrOmmx7VLgE4g6yZa19heU4sigjSfBJwk=
X-Google-Smtp-Source: AGHT+IHV0AdaJpQv5ZKTryYtKlgcFA4J3QPlPo/pe4eiTry6fViQLyHVAE58d0dtTpb/zN2YwBw/Kw==
X-Received: by 2002:a92:2907:0:b0:357:a5cc:de86 with SMTP id
 l7-20020a922907000000b00357a5ccde86mr4075990ilg.23.1697866756134; 
 Fri, 20 Oct 2023 22:39:16 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 s15-20020a170902ea0f00b001c60a2b5c61sm2397298plg.134.2023.10.20.22.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:39:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 89/90] target/sparc: Convert FZERO, FONE to decodetree
Date: Fri, 20 Oct 2023 22:31:57 -0700
Message-Id: <20231021053158.278135-90-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d34;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd34.google.com
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
index d03bddc689..955647db71 100644
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
index 39cdcba56e..922d9e6021 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4703,6 +4703,45 @@ static bool do_stfsr(DisasContext *dc, arg_r_r_ri *a, MemOp mop)
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
@@ -5423,10 +5462,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             } else if (xop == 0x36) {
 #ifdef TARGET_SPARC64
                 /* VIS */
-                TCGv_i64 cpu_dst_64;
-                TCGv_i32 cpu_dst_32;
                 int opf = GET_FIELD_SP(insn, 5, 13);
-                int rd = GET_FIELD(insn, 2, 6);
 
                 if (gen_trap_ifnofpu(dc)) {
                     goto jmp_insn;
@@ -5510,31 +5546,11 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5559,11 +5575,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


