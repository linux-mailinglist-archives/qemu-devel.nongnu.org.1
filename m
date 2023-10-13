Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C197C8F78
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:40:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPlv-0008AX-6T; Fri, 13 Oct 2023 17:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPls-00083V-Iq
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:36 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPln-0001Ly-PW
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:36 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6b598eaf407so660746b3a.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232750; x=1697837550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vpxKXoLfs/L6yII5btLcvV1YAlt0qM2Omvd7z5JYVrY=;
 b=pA/vYu9Hklh8cfwQ6xyco5iQiZScG9DEVw/wAazY1ZxOtg2uKHmKUMM3tqR2YJ8EAJ
 6k3e1+e2rCj+qlI5+xoWGh1jWxg/PO1VLLQYQrnKAG4uFjhDMoMe8+VSmdJ7XGfvfGp1
 +gyMCEII6MCIb67mo+JsgacwjMMOkkAff2UVmCyraMI6YWGu+U7PJSbu6g5ky+dmrTLP
 lvSAAO1MeTapBfzHDGfdchZ1+7lOm45lhuYpKMB8rNqGwY6TmoUyotYpBV2gXhjEwzPo
 jmey/QwC4j8k3n59jRVcLsLRtcxW4FWcSfBGPJlbAgdxTSZ6sl1sbITlUVOEwuUiX/uW
 nXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232750; x=1697837550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vpxKXoLfs/L6yII5btLcvV1YAlt0qM2Omvd7z5JYVrY=;
 b=MfvWTSjkQN0jYQhifY2powThl98vTUcqnf+l2BsDTV7sb2Jq+z/VN2oe3yLPtVrhg/
 yxWcBmpzB5ugl8wbQ4eBZ8ZTqnVdg2MJyK1HGi1987n5T2LHbSRaFz9KqHHoLqgWulhs
 qPJVWAJCFjCTGA7AtporJqG/Iyd30yileBgcHS3j10KJDcZNIgsv1ll0eGaX6eILo6Zy
 1btmYr/Flmt73ltvVJJ0gRd1PiKMgwc4xVQzBRlEXefZqBIgPC99cGoNwZI6l3L4sQkE
 /713y3pWvT8x5qE1YUzzi96F3f5J2Mw4i9yL31T08gPZGZj9JE8TMMnI9Kr6Gn4+qNWm
 IhfQ==
X-Gm-Message-State: AOJu0Yz2ApdiZgjiEqMFZzs3jAgD8dRIJeMV2AJG6PL6P8xrrDxJ7wNB
 3H35s1tOZFkUFqotq+J2h+pZOdvItPIjUnvhH1Y=
X-Google-Smtp-Source: AGHT+IGgc6kYqi3J2jKlJ374KPNyQ9Wf3E183xIV/j8pbIex9GSnLiBqLZhApui8NjRpwbG7hrcI+A==
X-Received: by 2002:a05:6a00:3a16:b0:693:4143:5145 with SMTP id
 fj22-20020a056a003a1600b0069341435145mr29761337pfb.31.1697232750308; 
 Fri, 13 Oct 2023 14:32:30 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 45/85] target/sparc: Move LDSTUB, LDSTUBA to decodetree
Date: Fri, 13 Oct 2023 14:28:06 -0700
Message-Id: <20231013212846.165724-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
index fd9e268a0e..0d3bb3b588 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -278,6 +278,10 @@ STD         11 ..... 010111 ..... . .............          @r_r_i_asi # STDA
 STX         11 ..... 011110 ..... . .............          @r_r_r_asi # STXA
 STX         11 ..... 011110 ..... . .............          @r_r_i_asi # STXA
 
+LDSTUB      11 ..... 001101 ..... . .............          @r_r_ri_na
+LDSTUB      11 ..... 011101 ..... . .............          @r_r_r_asi # LDSTUBA
+LDSTUB      11 ..... 011101 ..... . .............          @r_r_i_asi # LDSTUBA
+
 NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
 NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 11f885822f..052000e4f7 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1800,13 +1800,6 @@ static void gen_swap(DisasContext *dc, TCGv dst, TCGv src,
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
@@ -2225,13 +2218,14 @@ gen_casx_asi(DisasContext *dc, TCGv addr, TCGv cmpv, int insn, int rd)
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
@@ -2259,15 +2253,6 @@ static void gen_ldstub_asi0(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
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
@@ -4623,6 +4608,23 @@ static bool trans_STD(DisasContext *dc, arg_r_r_ri_asi *a)
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
@@ -5451,21 +5453,20 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5473,9 +5474,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


