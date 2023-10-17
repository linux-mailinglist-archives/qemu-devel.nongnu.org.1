Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0A67CBADA
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:18:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdNq-0003Sx-Os; Tue, 17 Oct 2023 02:16:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNX-0002qj-Ce
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:31 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdNU-0004hH-Tu
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:16:31 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-692c02adeefso3800026b3a.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523387; x=1698128187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zRvcPjw6iOnW8M+jEQRp0Rzi/QWsBGj/pVxcQGWxd8w=;
 b=L/VQkj94e22Y7+PSswjDpf6pA12TO5+URrfX+Y5/6srBXmlPHhhKc2WjYuVHw4DcLr
 IsxgAi8DQtJb2nRaWnoqU7TSaHEm+VCsEGAwzz1mFJPozfKPE0ljwJaV980uW2Gz/KhV
 vbVYRWF5Gxc3vP6WCeuZCb01xp1Slw8+GAZqgoE9nSw2EfGazGSLMuESbwkeRPi6RtZ3
 uacjXNnzaoZPJDC/oa4jwAlu4q6XcAyXHKiR1GhdhgtXC3pQGMMfZIE+d8+bUrlSrl86
 GvgwEv0q50QRrWKfpAO4YoAwell4gko9klRr7eTs1yn1FDogLF4XYzsWGTk5ihis2JFp
 Vc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523387; x=1698128187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zRvcPjw6iOnW8M+jEQRp0Rzi/QWsBGj/pVxcQGWxd8w=;
 b=STqor/w24AFgYlmG6KFsvCzla+R8idi8MFeYY3tkFuva6OwJp/bBbMUFLEL8o9aVrE
 B6wefEStuDC5y0nRSJDnxc2aorrbsMFp+ZRSSgfVQwCmpLNSiMlgFztZKQ0I6lICKRoF
 UCRnYssj4H4IiunhdHTlc2XvmuNTrrAa0IkuKfjQ9kTGkvW+34IAnBmv3/kVm9JwihTb
 Rnn/GjwdGoBKd8gYEtILcz1mVYCkgafD+FBqaf1CBJyfakUSOTadPtxhsy3kd0QiSN3E
 PbFUCj1M4hj71yzW4h+vRQgCgqAfa//LG97EjOXQ1k0Gs+ZTSR2VD5KOow50bWReW3pE
 yWjA==
X-Gm-Message-State: AOJu0YynWK2ub2AHFjDXPY+KUY+88wEgYFmovq5GFn2oBQWK567PUSS/
 sFemdU/ALPmMzgcMFOVW5zDJR3l4JZyvBM0kjhA=
X-Google-Smtp-Source: AGHT+IGl372L5Ca+VGQi0N4Nv1kMRXr7c2nLTjtu7ZIqO6F9q+0EetorYa6oO+XrUqFW8puM0y6XdA==
X-Received: by 2002:a05:6a00:2d13:b0:6be:3c44:c18b with SMTP id
 fa19-20020a056a002d1300b006be3c44c18bmr1441715pfb.25.1697523387502; 
 Mon, 16 Oct 2023 23:16:27 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 m10-20020a056a00080a00b00690ca4356f1sm579280pfk.198.2023.10.16.23.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:16:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 50/90] target/sparc: Move LDSTUB, LDSTUBA to decodetree
Date: Mon, 16 Oct 2023 23:12:04 -0700
Message-Id: <20231017061244.681584-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Remove gen_ldstub_asi.
Rename gen_ldstub_asi0 to gen_ldstub_asi.
Merge gen_ldstub into gen_ldstub_asi.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  4 ++++
 target/sparc/translate.c  | 46 +++++++++++++++++++--------------------
 2 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 94f1f5b9c9..3233528b08 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -277,6 +277,10 @@ STD         11 ..... 010111 ..... . .............          @r_r_i_asi # STDA
 STX         11 ..... 011110 ..... . .............          @r_r_r_asi # STXA
 STX         11 ..... 011110 ..... . .............          @r_r_i_asi # STXA
 
+LDSTUB      11 ..... 001101 ..... . .............          @r_r_ri_na
+LDSTUB      11 ..... 011101 ..... . .............          @r_r_r_asi # LDSTUBA
+LDSTUB      11 ..... 011101 ..... . .............          @r_r_i_asi # LDSTUBA
+
 NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
 NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 587eb0ccd5..c2ea027fe1 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1849,13 +1849,6 @@ static void gen_swap(DisasContext *dc, TCGv dst, TCGv src,
     tcg_gen_atomic_xchg_tl(dst, addr, src, mmu_idx, memop | MO_ALIGN);
 }
 
-static void gen_ldstub(DisasContext *dc, TCGv dst, TCGv addr, int mmu_idx)
-{
-    TCGv m1 = tcg_constant_tl(0xff);
-    gen_address_mask(dc, addr);
-    tcg_gen_atomic_xchg_tl(dst, addr, m1, mmu_idx, MO_UB);
-}
-
 /* asi moves */
 typedef enum {
     GET_ASI_HELPER,
@@ -2274,13 +2267,14 @@ gen_casx_asi(DisasContext *dc, TCGv addr, TCGv cmpv, int insn, int rd)
     gen_store_gpr(dc, rd, oldv);
 }
 
-static void gen_ldstub_asi0(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
+static void gen_ldstub_asi(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
 {
     switch (da->type) {
     case GET_ASI_EXCP:
         break;
     case GET_ASI_DIRECT:
-        gen_ldstub(dc, dst, addr, da->mem_idx);
+        tcg_gen_atomic_xchg_tl(dst, addr, tcg_constant_tl(0xff),
+                               da->mem_idx, MO_UB);
         break;
     default:
         /* ??? In theory, this should be raise DAE_invalid_asi.
@@ -2308,15 +2302,6 @@ static void gen_ldstub_asi0(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
     }
 }
 
-static void __attribute__((unused))
-gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int insn)
-{
-    DisasASI da = get_asi(dc, insn, MO_UB);
-
-    gen_address_mask(dc, addr);
-    gen_ldstub_asi0(dc, &da, dst, addr);
-}
-
 static void __attribute__((unused))
 gen_ldf_asi(DisasContext *dc, TCGv addr, int insn, int size, int rd)
 {
@@ -4689,6 +4674,23 @@ static bool trans_STD(DisasContext *dc, arg_r_r_ri_asi *a)
     return advance_pc(dc);
 }
 
+static bool trans_LDSTUB(DisasContext *dc, arg_r_r_ri_asi *a)
+{
+    TCGv addr, reg;
+    DisasASI da;
+
+    addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
+    if (addr == NULL) {
+        return false;
+    }
+    da = resolve_asi(dc, a->asi, MO_UB);
+
+    reg = gen_dest_gpr(dc, a->rd);
+    gen_ldstub_asi(dc, &da, reg, addr);
+    gen_store_gpr(dc, a->rd, reg);
+    return advance_pc(dc);
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -5517,21 +5519,20 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                 case 0x3:       /* ldd, load double word */
                 case 0x9:       /* ldsb, load signed byte */
                 case 0xa:       /* ldsh, load signed halfword */
+                case 0xd:       /* ldstub */
                 case 0x10:      /* lda, V9 lduwa, load word alternate */
                 case 0x11:      /* lduba, load unsigned byte alternate */
                 case 0x12:      /* lduha, load unsigned halfword alternate */
                 case 0x13:      /* ldda, load double word alternate */
                 case 0x19:      /* ldsba, load signed byte alternate */
                 case 0x1a:      /* ldsha, load signed halfword alternate */
+                case 0x1d:      /* ldstuba */
                     g_assert_not_reached();  /* in decodetree */
                 case 0x08:      /* V9 ldsw */
                 case 0x0b:      /* V9 ldx */
                 case 0x18:      /* V9 ldswa */
                 case 0x1b:      /* V9 ldxa */
                     goto illegal_insn;  /* in decodetree */
-                case 0xd:       /* ldstub */
-                    gen_ldstub(dc, cpu_val, cpu_addr, dc->mem_idx);
-                    break;
                 case 0x0f:
                     /* swap, swap register with memory. Also atomically */
                     cpu_src1 = gen_load_gpr(dc, rd);
@@ -5539,9 +5540,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                              dc->mem_idx, MO_TEUL);
                     break;
 #if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
-                case 0x1d:      /* ldstuba -- XXX: should be atomically */
-                    gen_ldstub_asi(dc, cpu_val, cpu_addr, insn);
-                    break;
                 case 0x1f:      /* swapa, swap reg with alt. memory. Also
                                    atomically */
                     cpu_src1 = gen_load_gpr(dc, rd);
-- 
2.34.1


