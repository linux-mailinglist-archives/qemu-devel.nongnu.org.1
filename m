Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3CF7D79A4
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:39:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo9O-0000PX-8z; Wed, 25 Oct 2023 20:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9I-0008UA-Fr
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:22:58 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9G-0008Ab-9q
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:22:56 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-27cfb8bc7eeso237254a91.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279773; x=1698884573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nqsLsbZVjs5bsqoicc0u3zyho9ONy37FphIeA4eEfCQ=;
 b=tfxCLzm1fIWtzRf4/Acfgx+RKwWjjBDj5tET08Xas5ou/UfNIGoFks2T2RT5sLfltK
 7KBH3BexSIeXIfoIEjTymaKnwh3h9lHn5Q2BnBc39VVHABL+Y7TKEiBiVmLboVfzUt/i
 uqLxfidZf3QliXWVi8LdhgdC8by280e679S3HLtEG+iRG9OzUirwrU6Ly9qr/3I+3WSP
 VW7cvcwO7Sh3I2Q/3+MfMFy0oJjkIJ1LrOJUcvbqiBfYo4AWPJXobtV4Y088D9xpoccM
 imamLYlzOo0r9mFQzHNdTPmecDw5xTXIVoeYx/cMfh41AQn8vo/i4C1caNsvxrF/uu4d
 wrdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279773; x=1698884573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nqsLsbZVjs5bsqoicc0u3zyho9ONy37FphIeA4eEfCQ=;
 b=WnGeDXBZKD3g2ifeYus0s34VeIVThq25VBl4hEOma9luP2nZDzcBhHKHZ2AEigp3Vr
 13/vhjiVmlnUysmyEvmE1+Xy1JRyZoWFBpqRgzs/TDnJRiBl6jNWCuOu7AZ00MhbuYOq
 2JEnJNKJtlNQAtUHlwszSPEr5Lpu+PRyfZ8A+YJ4NKm9VMk2Lx+8tXgtntvwgTi6sbml
 crHtyb5Hxbfyc1GjC85ogshQBVAcBQJ8foL9sL2phgqOpm1S1SlS6TlrrM9O7Z55M0z1
 oSiJ9iLaFU9aoPP0CvjGpMdlmTestJtWW9DOGw5hPSYpMr+r0koNAupMNvNfpgtv8clU
 5sRQ==
X-Gm-Message-State: AOJu0YwISHPVpXiNRvnvHFYB/dETsO/9uBHrSKut3zF/hW4KtkUC8EcS
 OWDLjS7lseF5j1kKmi1/e5sFCy0N/vF4uMrNPpg=
X-Google-Smtp-Source: AGHT+IGu7BKgUgPJ36kjma5DB762KjSXaM6IU+mgidUwr0XNVn4dc+MOYaMnzCL3ks3mrDIyODDjzg==
X-Received: by 2002:a17:90a:1c8:b0:27d:6dd:fb7d with SMTP id
 8-20020a17090a01c800b0027d06ddfb7dmr17544975pjd.17.1698279772817; 
 Wed, 25 Oct 2023 17:22:52 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b0027463889e72sm499870pjt.55.2023.10.25.17.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:22:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 54/94] target/sparc: Move LDSTUB, LDSTUBA to decodetree
Date: Wed, 25 Oct 2023 17:15:02 -0700
Message-Id: <20231026001542.1141412-84-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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
index 74cf3105f0..ddfb76af68 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1892,13 +1892,6 @@ static void gen_swap(DisasContext *dc, TCGv dst, TCGv src,
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
@@ -2331,13 +2324,14 @@ gen_casx_asi(DisasContext *dc, TCGv addr, TCGv cmpv, int insn, int rd)
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
@@ -2365,15 +2359,6 @@ static void gen_ldstub_asi0(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
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
@@ -4611,6 +4596,23 @@ static bool trans_STD(DisasContext *dc, arg_r_r_ri_asi *a)
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
@@ -5439,21 +5441,20 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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
@@ -5461,9 +5462,6 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


