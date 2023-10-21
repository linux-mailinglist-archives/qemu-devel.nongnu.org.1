Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B08767D1B2A
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:47:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4eR-0002vE-TC; Sat, 21 Oct 2023 01:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eG-0002Vw-Q1
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:48 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eE-00016M-LW
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:44 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6934202b8bdso1457429b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866541; x=1698471341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DfUVH6Lh/sNQC/NJIdQQI2T73mQYEQ3627njcWIRFV4=;
 b=jWEdv6NTnjAIsNcplO0XmidDUkg069vJ1IXVO089mooRQrIJphdsoCsXfbMItievhj
 5RixEwLkr3pCgsmIiAe7FOfN/HIkcDlDgUrDiArrK3EtGGy/yxIqCdHVEzPQjmPB/wBv
 MHQh7P+hubd7g0XB9jkqqgLHG9g0ey1t2eGT6G+Xe6y/wYibwmOPhptS/MbH5r80VC42
 p8l+eEckdQVXXHpgKKdq+bV5NFI7rrFYrcI0QeyM2v/nZbuAgladosVrNA7480d9l8kV
 TfIz4ic6MSj3O8DwuCEAxAxe7ZFXRAxWTNFITjZAVIAtULEwlUZo4HNETqqkX2WmSeAe
 9ZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866541; x=1698471341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DfUVH6Lh/sNQC/NJIdQQI2T73mQYEQ3627njcWIRFV4=;
 b=RN6OtYtu+UxSUz+5tdVzM9kaoxcmS/BQB+oKIj83ZU1Zx6+vWCYjHme9zKSC86dOLh
 v5ieOXXQedGXQh8yGXesjn4N+vTRx9vL/qXHszvIuinX+nGp3eSnwwyS8heDLrmAYJBX
 i4i/Jgki7WjDEzqUdtKMv0l17h5CKpAgnMqRwzU7vPeK887JjW/fS/TpdeCXGWc+eKJe
 h7p+ov51as9d53K4z2fkBaQrz1Sl4vEm4He07+U5/oBuaHnbhNiI0G29yVUy3FudPDlg
 5oOTiK4VkUq9q78k/7QbKe9qwX9edjo4q8MQk0gBHB+YrEEIrZlo3bogQrOpJlCqw7pL
 6Wug==
X-Gm-Message-State: AOJu0YzzhMsGC/62ZhlgeRw11CAmOg6GVkSrSUfMeSsXFbSj/WE7wrOf
 gyGkDtCjf3j7yLhiZneag3YH+FvcQ2vWY3/I6p8=
X-Google-Smtp-Source: AGHT+IG2+H/HIke6IRioZx58NUJ4MtcMVjK3Euhk2W8b5gBJsoMPNLp3qFj1I406wXwi3sbYGX+h4g==
X-Received: by 2002:a05:6300:8088:b0:161:3013:b499 with SMTP id
 ap8-20020a056300808800b001613013b499mr3825600pzc.60.1697866541351; 
 Fri, 20 Oct 2023 22:35:41 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b00690d255b5a1sm2427978pfn.217.2023.10.20.22.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:35:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 50/90] target/sparc: Move LDSTUB, LDSTUBA to decodetree
Date: Fri, 20 Oct 2023 22:31:18 -0700
Message-Id: <20231021053158.278135-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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
index 76e812cc74..818ac33f2f 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -284,6 +284,10 @@ STD         11 ..... 010111 ..... . .............          @r_r_i_asi # STDA
 STX         11 ..... 011110 ..... . .............          @r_r_r_asi # STXA
 STX         11 ..... 011110 ..... . .............          @r_r_i_asi # STXA
 
+LDSTUB      11 ..... 001101 ..... . .............          @r_r_ri_na
+LDSTUB      11 ..... 011101 ..... . .............          @r_r_r_asi # LDSTUBA
+LDSTUB      11 ..... 011101 ..... . .............          @r_r_i_asi # LDSTUBA
+
 NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
 NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index dc3586853b..70d0ed3db3 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1891,13 +1891,6 @@ static void gen_swap(DisasContext *dc, TCGv dst, TCGv src,
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
@@ -2316,13 +2309,14 @@ gen_casx_asi(DisasContext *dc, TCGv addr, TCGv cmpv, int insn, int rd)
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
@@ -2350,15 +2344,6 @@ static void gen_ldstub_asi0(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
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
@@ -4723,6 +4708,23 @@ static bool trans_STD(DisasContext *dc, arg_r_r_ri_asi *a)
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
@@ -5551,21 +5553,20 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5573,9 +5574,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


