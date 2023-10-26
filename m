Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2E97D79A9
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:39:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo9P-0000bG-UC; Wed, 25 Oct 2023 20:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9L-0000Db-4B
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:22:59 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9I-0008BF-2I
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:22:58 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-27d1a03f540so242336a91.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279774; x=1698884574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BibC+DRs59nbFE1Ls41U4uh2VUfxNEDa0ycsD8PCaHk=;
 b=kVlnxQXrX/1PUJZ1ScHRxpW5gu1qlG3lxCNp6v1lFMp2Zfm54FvcpSErCRnrFAwQuD
 gtZnB6xLJsxA2PNHAwBucPp77sm+h+cvoHF8I5BbBO352Tpgca7lLPaoTPqxqfc+FRTh
 ep5aISm00WEaptsSWKD0W1C3jVlPC5nFCMRX1UPfsEP27l8m8fa5pC+4+PTMhSmirIzA
 d/hqo/xmXbGW5Obw4+iB2fpJp7Xlv2sWdBJB+mxrs6SqLgunNBkqX3B2mWg+TkKS/FEX
 fVLYKOH4fvo+0DNE+08bQ1ZUvN1MYxqSF3lHewdSGOa0vKwWqwIo0f5m1o2bB041zRos
 13iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279774; x=1698884574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BibC+DRs59nbFE1Ls41U4uh2VUfxNEDa0ycsD8PCaHk=;
 b=RBd2+YXTAwczY1D+tgsoxFEwMUcGZa2jRRM9fKItWQiDu5SoxksOu7OUL1zJLEhihz
 9mpX5y51kNKl6H60a8uWK9Won+Vck/4XRmsnzG4zfsIecLS6zWAiV243RLkDmdCk2nyN
 Sjno05BLqxo8+oxlHmhZRnUA+DIdNr2PK5WWXHgtD6+jab9ebH4L/xv+rWAfK1fhvJM4
 rOW06rmVuvbtJDaBA+Rj2z7waUgRCdWRoQ7ACh3R7ufGQfgvnGUGiOghXaKj7/TIOnh3
 u3qn9Yyl5/2yz0iTQ7IeFHTqygjYoKb4SgWrvR6r8WLilvuJ5VtbeO6OAmBDdSGSSr82
 dcTg==
X-Gm-Message-State: AOJu0YxjAuhT/hQZqLZ5lTda+yiXJ1L7+WrVJSRuBXRsQhOMW2hC8J7n
 irInrgXczwww+0PJ0lO/Z1/bYJ/a4NSipOvlxOE=
X-Google-Smtp-Source: AGHT+IEDdYqqF/FHIb87lEISdqFdjL9FeXa4EFeruW0kpzrWlzTyETEpRwH6Yld34mDvILwXTS3Zdg==
X-Received: by 2002:a17:90b:1016:b0:27d:23f1:ddf5 with SMTP id
 gm22-20020a17090b101600b0027d23f1ddf5mr13425605pjb.30.1698279774430; 
 Wed, 25 Oct 2023 17:22:54 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b0027463889e72sm499870pjt.55.2023.10.25.17.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:22:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 56/94] target/sparc: Move CASA, CASXA to decodetree
Date: Wed, 25 Oct 2023 17:15:04 -0700
Message-Id: <20231026001542.1141412-86-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Remove gen_cas_asi, gen_casx_asi.
Rename gen_cas_asi0 to gen_cas_asi.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  7 ++++
 target/sparc/translate.c  | 72 ++++++++++++++++-----------------------
 2 files changed, 36 insertions(+), 43 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 9c4597317c..82c484fbc7 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -240,6 +240,8 @@ RETRY       10 00001 111110 00000 0 0000000000000
 @r_r_r_asi  .. rd:5  ...... rs1:5 0     asi:8 rs2_or_imm:5 &r_r_ri_asi imm=0
 @r_r_i_asi  .. rd:5  ...... rs1:5 1     rs2_or_imm:s13     \
             &r_r_ri_asi imm=1 asi=-2
+@casa_imm   .. rd:5  ...... rs1:5 1 00000000 rs2_or_imm:5  \
+            &r_r_ri_asi imm=1 asi=-2
 
 LDUW        11 ..... 000000 ..... . .............          @r_r_ri_na
 LDUB        11 ..... 000001 ..... . .............          @r_r_ri_na
@@ -292,6 +294,11 @@ SWAP        11 ..... 001111 ..... . .............          @r_r_ri_na
 SWAP        11 ..... 011111 ..... . .............          @r_r_r_asi # SWAPA
 SWAP        11 ..... 011111 ..... . .............          @r_r_i_asi # SWAPA
 
+CASA        11 ..... 111100 ..... . .............          @r_r_r_asi
+CASA        11 ..... 111100 ..... . .............          @casa_imm
+CASXA       11 ..... 111110 ..... . .............          @r_r_r_asi
+CASXA       11 ..... 111110 ..... . .............          @casa_imm
+
 NCP         10 ----- 110110 ----- --------- -----          # v8 CPop1
 NCP         10 ----- 110111 ----- --------- -----          # v8 CPop2
 
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 29bfc98522..2175c00ded 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2268,8 +2268,8 @@ static void gen_swap_asi(DisasContext *dc, DisasASI *da,
     }
 }
 
-static void gen_cas_asi0(DisasContext *dc, DisasASI *da,
-                         TCGv oldv, TCGv newv, TCGv cmpv, TCGv addr)
+static void gen_cas_asi(DisasContext *dc, DisasASI *da,
+                        TCGv oldv, TCGv newv, TCGv cmpv, TCGv addr)
 {
     switch (da->type) {
     case GET_ASI_EXCP:
@@ -2285,30 +2285,6 @@ static void gen_cas_asi0(DisasContext *dc, DisasASI *da,
     }
 }
 
-static void __attribute__((unused))
-gen_cas_asi(DisasContext *dc, TCGv addr, TCGv cmpv, int insn, int rd)
-{
-    DisasASI da = get_asi(dc, insn, MO_TEUL);
-    TCGv oldv = gen_dest_gpr(dc, rd);
-    TCGv newv = gen_load_gpr(dc, rd);
-
-    gen_address_mask(dc, addr);
-    gen_cas_asi0(dc, &da, oldv, newv, cmpv, addr);
-    gen_store_gpr(dc, rd, oldv);
-}
-
-static void __attribute__((unused))
-gen_casx_asi(DisasContext *dc, TCGv addr, TCGv cmpv, int insn, int rd)
-{
-    DisasASI da = get_asi(dc, insn, MO_TEUQ);
-    TCGv oldv = gen_dest_gpr(dc, rd);
-    TCGv newv = gen_load_gpr(dc, rd);
-
-    gen_address_mask(dc, addr);
-    gen_cas_asi0(dc, &da, oldv, newv, cmpv, addr);
-    gen_store_gpr(dc, rd, oldv);
-}
-
 static void gen_ldstub_asi(DisasContext *dc, DisasASI *da, TCGv dst, TCGv addr)
 {
     switch (da->type) {
@@ -2913,6 +2889,7 @@ static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
 #ifdef TARGET_SPARC64
 # define avail_32(C)      false
 # define avail_ASR17(C)   false
+# define avail_CASA(C)    true
 # define avail_DIV(C)     true
 # define avail_MUL(C)     true
 # define avail_POWERDOWN(C) false
@@ -2922,6 +2899,7 @@ static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
 #else
 # define avail_32(C)      true
 # define avail_ASR17(C)   ((C)->def->features & CPU_FEATURE_ASR17)
+# define avail_CASA(C)    ((C)->def->features & CPU_FEATURE_CASA)
 # define avail_DIV(C)     ((C)->def->features & CPU_FEATURE_DIV)
 # define avail_MUL(C)     ((C)->def->features & CPU_FEATURE_MUL)
 # define avail_POWERDOWN(C) ((C)->def->features & CPU_FEATURE_POWERDOWN)
@@ -4616,6 +4594,28 @@ static bool trans_SWAP(DisasContext *dc, arg_r_r_ri_asi *a)
     return advance_pc(dc);
 }
 
+static bool do_casa(DisasContext *dc, arg_r_r_ri_asi *a, MemOp mop)
+{
+    TCGv addr, o, n, c;
+    DisasASI da;
+
+    addr = gen_ldst_addr(dc, a->rs1, true, 0);
+    if (addr == NULL) {
+        return false;
+    }
+    da = resolve_asi(dc, a->asi, mop);
+
+    o = gen_dest_gpr(dc, a->rd);
+    n = gen_load_gpr(dc, a->rd);
+    c = gen_load_gpr(dc, a->rs2_or_imm);
+    gen_cas_asi(dc, &da, o, n, c, addr);
+    gen_store_gpr(dc, a->rd, o);
+    return advance_pc(dc);
+}
+
+TRANS(CASA, CASA, do_casa, a, MO_TEUL)
+TRANS(CASXA, 64, do_casa, a, MO_TEUQ)
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -5419,9 +5419,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             TCGv cpu_addr = tcg_temp_new();
 
             tcg_gen_mov_tl(cpu_addr, get_src1(dc, insn));
-            if (xop == 0x3c || xop == 0x3e) {
-                /* V9 casa/casxa : no offset */
-            } else if (IS_IMM) {     /* immediate */
+            if (IS_IMM) {     /* immediate */
                 simm = GET_FIELDs(insn, 19, 31);
                 if (simm != 0) {
                     tcg_gen_addi_tl(cpu_addr, cpu_addr, simm);
@@ -5634,22 +5632,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
                     }
                     gen_stf_asi(dc, cpu_addr, insn, 8, DFPREG(rd));
                     break;
+#endif
                 case 0x3e: /* V9 casxa */
-                    rs2 = GET_FIELD(insn, 27, 31);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_casx_asi(dc, cpu_addr, cpu_src2, insn, rd);
-                    break;
-#endif
-#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
                 case 0x3c: /* V9 or LEON3 casa */
-#ifndef TARGET_SPARC64
-                    CHECK_IU_FEATURE(dc, CASA);
-#endif
-                    rs2 = GET_FIELD(insn, 27, 31);
-                    cpu_src2 = gen_load_gpr(dc, rs2);
-                    gen_cas_asi(dc, cpu_addr, cpu_src2, insn, rd);
-                    break;
-#endif
+                    goto illegal_insn; /* in decodetree */
                 default:
                     goto illegal_insn;
                 }
-- 
2.34.1


