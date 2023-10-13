Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEA47C8F0B
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:30:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPiY-0006G4-Q2; Fri, 13 Oct 2023 17:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiX-0006Fo-ID
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:09 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiR-0000TA-2Q
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:29:05 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6b6f4c118b7so504687b3a.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232542; x=1697837342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8zAAA+YrtfJjFLSLA52WB/2jZeaMVT3rkf+1JjFRtro=;
 b=uRlca8UpukKXL+uhsqTkr4AhyI8aYK86Klsxgj5RItZvSXbAuJiTnmdfcdH9SaEn0i
 TrChw9na9WQqIgS7aAkjWP9pxn/o5D5WmsXoiiMUeV1UWcNbmnIYRGSraN58kHswvKLv
 WGfGrquVg5ZUZuP2V0GaJQnXOa2S3FhDkpA6TBvsnUCLRBczIJf4wsYi4G+FoR21Hg5A
 EJB8a3Rs4gj9yaPMrMjTlFI/dbaqM7r47MD+d8hkfcj3GnIPh22V+NJG/aTEGsp7kKOP
 xJyK069nWhy/jFHij3Vb9m+Fj70oLgisGMgDD87ea/iTHrNMHYD+hoT8JQVsQAz31RBA
 1WmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232542; x=1697837342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8zAAA+YrtfJjFLSLA52WB/2jZeaMVT3rkf+1JjFRtro=;
 b=kQSkt8adtBP5WRhFTFOLJee4HDSCn+mnTwO9e0G8izSo3Q/T9RPe0bSlNZn3/YTrc4
 FzGIb91PS9M9Fewzv01iJKKJyHjF6urkJ9EpdRe7qwkOyjoJEaO8bVn5GKuYHd5IBc+2
 xhJjNriMOv5DV4u77Icy4uQ7BbVyGebklDcDxFKD9b+70vIMLEEl6cz578fOZICjAuhy
 kjYPtnbMb6bg21cbaZerPPTkH539q7Yjw+ezwrDFFqY5ADmum/pCNE/ktZQZzQ+2cM7B
 8AouiYE/Tj/b8m67a+rtWnmkFOM3r90dMsI/mMnRa7U0V4PKnq3JsREqz2Zvlo4ERtth
 eh0w==
X-Gm-Message-State: AOJu0YyMuKATgm7Gp/6I5eFQwnFd0z8d++pkGjeS7afN/pixFuD6d5hR
 s1uy8I+NU03iLlpU0ZCCoxwCcUDCSifFpZPz6jQ=
X-Google-Smtp-Source: AGHT+IGAr7hqEVII62TCJGWNfNR15RkklbCx1bekX63cqJ4UL5GZ7aaxMfc5HSKLAFBQeWe0LoLEmQ==
X-Received: by 2002:a05:6a21:6d99:b0:173:f8c9:a776 with SMTP id
 wl25-20020a056a216d9900b00173f8c9a776mr9050688pzb.26.1697232541770; 
 Fri, 13 Oct 2023 14:29:01 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:29:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 15/85] target/sparc: Move Tcc to decodetree
Date: Fri, 13 Oct 2023 14:27:36 -0700
Message-Id: <20231013212846.165724-16-richard.henderson@linaro.org>
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
 target/sparc/insns.decode |   3 +
 target/sparc/translate.c  | 148 ++++++++++++++++++--------------------
 2 files changed, 72 insertions(+), 79 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index f6f5401b10..2945575268 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -21,3 +21,6 @@ NCP     00 -   ----     111 ----------------------         # CBcc
 SETHI   00 rd:5         100 i:22
 
 CALL    01 i:s30
+
+Tcc_r   10 0 cond:4 111010 rs1:5 0 cc:1 0000000 rs2:5
+Tcc_i   10 0 cond:4 111010 rs1:5 1 cc:1 0000 i:8
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index cc39a25275..a1c2796782 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3014,6 +3014,74 @@ static bool trans_SETHI(DisasContext *dc, arg_SETHI *a)
     return advance_pc(dc);
 }
 
+static bool do_tcc(DisasContext *dc, int cc, int cond,
+                   bool imm, int rs1, int rs2_or_imm)
+{
+    TCGLabel *l1 = NULL;
+    TCGv_i32 trap;
+    int mask;
+
+    /* Reject %xcc for sparc32. */
+    if (avail_32(dc) && cc) {
+        return false;
+    }
+
+    /* Trap never.  */
+    if (cond == 0) {
+        return advance_pc(dc);
+    }
+
+    save_state(dc);
+
+    /* Conditional trap.  */
+    if (cond != 8) {
+        DisasCompare cmp;
+
+        gen_compare(&cmp, cc, cond, dc);
+        l1 = gen_new_label();
+        tcg_gen_brcond_tl(tcg_invert_cond(cmp.cond), cmp.c1, cmp.c2, l1);
+    }
+
+    mask = ((dc->def->features & CPU_FEATURE_HYPV) && supervisor(dc)
+            ? UA2005_HTRAP_MASK : V8_TRAP_MASK);
+
+    if (rs2_or_imm == 0) {
+        imm = true;
+    }
+    if (rs1 == 0 && imm) {
+        trap = tcg_constant_i32((rs2_or_imm & mask) + TT_TRAP);
+    } else {
+        TCGv tmp = tcg_temp_new();
+        TCGv src1 = gen_load_gpr(dc, rs1);
+
+        if (imm) {
+            tcg_gen_addi_tl(tmp, src1, rs2_or_imm);
+        } else {
+            tcg_gen_add_tl(tmp, src1, gen_load_gpr(dc, rs2_or_imm));
+        }
+
+        trap = tcg_temp_new_i32();
+        tcg_gen_trunc_tl_i32(trap, tmp);
+        tcg_gen_andi_i32(trap, trap, mask);
+        tcg_gen_addi_i32(trap, trap, TT_TRAP);
+    }
+
+    gen_helper_raise_exception(tcg_env, trap);
+
+    if (l1 == NULL) {
+        /* An unconditional trap ends the TB.  */
+        dc->base.is_jmp = DISAS_NORETURN;
+        return true;
+    }
+
+    /* A conditional trap falls through to the next insn.  */
+    gen_set_label(l1);
+    return advance_pc(dc);
+}
+
+TRANS(Tcc_r, ALL, do_tcc, a->cc, a->cond, false, a->rs1, a->rs2)
+TRANS(Tcc_i, ALL, do_tcc, a->cc, a->cond, true, a->rs1, a->i)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -3044,85 +3112,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             TCGv cpu_dst = tcg_temp_new();
             TCGv cpu_tmp0;
 
-            if (xop == 0x3a) {  /* generate trap */
-                int cond = GET_FIELD(insn, 3, 6);
-                TCGv_i32 trap;
-                TCGLabel *l1 = NULL;
-                int mask;
-
-                if (cond == 0) {
-                    /* Trap never.  */
-                    break;
-                }
-
-                save_state(dc);
-
-                if (cond != 8) {
-                    /* Conditional trap.  */
-                    DisasCompare cmp;
-#ifdef TARGET_SPARC64
-                    /* V9 icc/xcc */
-                    int cc = GET_FIELD_SP(insn, 11, 12);
-                    if (cc == 0) {
-                        gen_compare(&cmp, 0, cond, dc);
-                    } else if (cc == 2) {
-                        gen_compare(&cmp, 1, cond, dc);
-                    } else {
-                        goto illegal_insn;
-                    }
-#else
-                    gen_compare(&cmp, 0, cond, dc);
-#endif
-                    l1 = gen_new_label();
-                    tcg_gen_brcond_tl(tcg_invert_cond(cmp.cond),
-                                      cmp.c1, cmp.c2, l1);
-                }
-
-                mask = ((dc->def->features & CPU_FEATURE_HYPV) && supervisor(dc)
-                        ? UA2005_HTRAP_MASK : V8_TRAP_MASK);
-
-                /* Don't use the normal temporaries, as they may well have
-                   gone out of scope with the branch above.  While we're
-                   doing that we might as well pre-truncate to 32-bit.  */
-                trap = tcg_temp_new_i32();
-
-                rs1 = GET_FIELD_SP(insn, 14, 18);
-                if (IS_IMM) {
-                    rs2 = GET_FIELD_SP(insn, 0, 7);
-                    if (rs1 == 0) {
-                        tcg_gen_movi_i32(trap, (rs2 & mask) + TT_TRAP);
-                        /* Signal that the trap value is fully constant.  */
-                        mask = 0;
-                    } else {
-                        TCGv t1 = gen_load_gpr(dc, rs1);
-                        tcg_gen_trunc_tl_i32(trap, t1);
-                        tcg_gen_addi_i32(trap, trap, rs2);
-                    }
-                } else {
-                    TCGv t1, t2;
-                    rs2 = GET_FIELD_SP(insn, 0, 4);
-                    t1 = gen_load_gpr(dc, rs1);
-                    t2 = gen_load_gpr(dc, rs2);
-                    tcg_gen_add_tl(t1, t1, t2);
-                    tcg_gen_trunc_tl_i32(trap, t1);
-                }
-                if (mask != 0) {
-                    tcg_gen_andi_i32(trap, trap, mask);
-                    tcg_gen_addi_i32(trap, trap, TT_TRAP);
-                }
-
-                gen_helper_raise_exception(tcg_env, trap);
-
-                if (cond == 8) {
-                    /* An unconditional trap ends the TB.  */
-                    dc->base.is_jmp = DISAS_NORETURN;
-                    goto jmp_insn;
-                } else {
-                    /* A conditional trap falls through to the next insn.  */
-                    gen_set_label(l1);
-                    break;
-                }
-            } else if (xop == 0x28) {
+            if (xop == 0x28) {
                 rs1 = GET_FIELD(insn, 13, 17);
                 switch(rs1) {
                 case 0: /* rdy */
-- 
2.34.1


