Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 090AE7D215D
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:11:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRaN-0002Js-Gq; Sun, 22 Oct 2023 02:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRa0-0000UV-85
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:04:52 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRZt-0002Et-Ea
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:04:51 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5844bc378feso381397eaf.0
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954684; x=1698559484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mP6+VlPNB//yP5a6QZd7OLrJPFY+aQa3GFEyeJdT0uQ=;
 b=sEx/7C9hZ2Cv2+03hCSp3rPY8HZfUHwAVeHSE4PJK6BHwXoJSulhre6H1fabfILTWG
 ROoDieoyoJG0MUTMQPfH8TVUKha0EpIYEw2lf3tp1Z39D/pr4gDpCEpyuXcoCwccPQhf
 IoTpqQzeRy9VBk7vIBTFOHkBt9ynEMHCMhghl/mVSNFY9+JDR4b8kZLt2MYQkYgEAB6L
 fAmO1py41UBr9mltcVV3d/e9/cejIu9j6Qp1dLpXc63D8jpvTNAGHdDL4LrRrIz8COj7
 bmx81F9V1QtLLlMu+Mxz2wpnR41Y9OQ7GM2WBHpLrD5SGYsmzs96Dd36f3uU0FbiwKvI
 Gk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954684; x=1698559484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mP6+VlPNB//yP5a6QZd7OLrJPFY+aQa3GFEyeJdT0uQ=;
 b=SVbz5DPYm/F554Qld3OS+Vi48vGQJ2ieDnz1CFyD8pcnfWY4ELBHjPdYBV6A8PA0tP
 cAcM+6y6/735uC/2HJtd9fhgF3GW9ppJf/OdcfbxoBLF1dbrAOf3jb4ZujvPkP2MbIcB
 lbAXd1lx4sjXncDHwaxP9qZnRwyGYheVyoDmcXhv7Kg3j7pLLi7wRXSJVIxws2Rq1v+w
 r+kU7KR761gmZOLTyCBZEU5One0MpdSG6zYbMMuxMwH7VrECyGw8+L17BUHT6GNYJsdM
 Lik/1LgF5e3WEfWCKXkbClIXGSUHrIKhIBzFPwb/xln9sCO4SNyIg5FUWldJ6CZ0LPPi
 4zsA==
X-Gm-Message-State: AOJu0Yw35TwkVc0gLpK4ZzL1QokPhLTBG/MyyKQyB3pzrC8UN6UUP5PA
 nDv73g2IM402laXOz8DRScitoMEc5TuPG8yia/U=
X-Google-Smtp-Source: AGHT+IEGChhWIBmmMwFeL1VTk0IGBnZy1NT2KAK1DgvudzdvM1amXZQwgkLpYP5e4FsC/00jsQXNQg==
X-Received: by 2002:a05:6358:418d:b0:14f:736b:7745 with SMTP id
 w13-20020a056358418d00b0014f736b7745mr7227055rwc.31.1697954683837; 
 Sat, 21 Oct 2023 23:04:43 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fb13-20020a056a002d8d00b0068a46cd4120sm4007373pfb.199.2023.10.21.23.04.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:04:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 50/90] target/sparc: Move LDSTUB, LDSTUBA to decodetree
Date: Sat, 21 Oct 2023 22:59:51 -0700
Message-Id: <20231022060031.490251-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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
index 280b19f033..2f950000b5 100644
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
index 7af95df66f..cba453e5ff 100644
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
@@ -4764,6 +4749,23 @@ static bool trans_STD(DisasContext *dc, arg_r_r_ri_asi *a)
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
@@ -5592,21 +5594,20 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5614,9 +5615,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


