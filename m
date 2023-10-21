Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3D47D1B1A
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:43:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4eU-00037H-U4; Sat, 21 Oct 2023 01:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eI-0002WS-9U
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:48 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eG-00016n-G6
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:46 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1dcfb2a3282so1086472fac.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866543; x=1698471343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JxEpruIm3SICz789muQH2A5aymvQNo5GfdzE0R3VZP4=;
 b=KxY20i2N/PD6skOGwAdvlxXNaYIqPz3xqGJIu+dpElDtyUxV+PeOh8ajhdb9h2sbnE
 O7Z3ZLP8NZvjXKTCHgHgcsWnmfsqm0fONq7yWI+JnjVKo7NalsEyMMzr5nQXR3ZFVFpW
 PsFfJGMRMessSr4QBwnrnYqQ4T212cSehIZ4LsejnagRT2e8LhaQMZ+eI5Ng9rWXKFJn
 4OoRgfYofMixVARXJKWkIit/zl9qyHs65eHjzVAG06aqbfmveBzaPBpC0itbDfEeNhgb
 raBgrTkudNn/lexl9poG3JtSABgEtnK6Z/jgryFYXCkhG2LDjFd+X6OCo5STmnV3V26V
 LBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866543; x=1698471343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JxEpruIm3SICz789muQH2A5aymvQNo5GfdzE0R3VZP4=;
 b=VGUVRpO9aCpaSTdh1d2s/riWKxlTMFSQOxAB5huNFyPXRIvyi0VVNHbtTTCNzfOW7I
 JzJbl3fxbERk8/gQLrdFuMa9neoRnKg/ar6KC0IRe/esk/OLLkHWrRp0zwoO+kW7syCW
 hJ6CDKOFwQepfdecZLxB51kT9LKbmPRtK3hLGFMcJy12RhiFwrtOts3g7w8sXspdLhsk
 gakK0WQg5v/izJfELmjnRfGecOzuOoqMgSCY6TNcuyEHhwH98mZjMoEchYm+HviODalQ
 +dwVTWi/oGq0BXKePYD9KeFWOH5odF1OPyZXoiqhff+lRDEdHek86XMeJX8KbZzuJEU1
 wjQA==
X-Gm-Message-State: AOJu0Yw9GCkTmqMkmfl9L2OeR0MiV1DNMMxTKSJxTvMvZdTL2NOi19z/
 bgYv4VTum2P5gHdQSrVHPB4w9Oeq0c65OVrq3To=
X-Google-Smtp-Source: AGHT+IE9MmBlVdx0YfdNPgzjGjRvfZZkQfXEl+U7+O8NhUe1LE81IRjobRzdtEwN9JbR44phlCeRkw==
X-Received: by 2002:a05:6870:e0c7:b0:1e9:9715:3cc5 with SMTP id
 a7-20020a056870e0c700b001e997153cc5mr4714226oab.25.1697866543217; 
 Fri, 20 Oct 2023 22:35:43 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b00690d255b5a1sm2427978pfn.217.2023.10.20.22.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:35:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 52/90] target/sparc: Move CASA, CASXA to decodetree
Date: Fri, 20 Oct 2023 22:31:20 -0700
Message-Id: <20231021053158.278135-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  7 ++++
 target/sparc/translate.c  | 71 +++++++++++++++------------------------
 2 files changed, 35 insertions(+), 43 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index f3d02a3564..f4c55db313 100644
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
index 2dd50a38f2..e1749ec12c 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2253,8 +2253,8 @@ static void gen_swap_asi(DisasContext *dc, DisasASI *da,
     }
 }
 
-static void gen_cas_asi0(DisasContext *dc, DisasASI *da,
-                         TCGv oldv, TCGv newv, TCGv cmpv, TCGv addr)
+static void gen_cas_asi(DisasContext *dc, DisasASI *da,
+                        TCGv oldv, TCGv newv, TCGv cmpv, TCGv addr)
 {
     switch (da->type) {
     case GET_ASI_EXCP:
@@ -2270,30 +2270,6 @@ static void gen_cas_asi0(DisasContext *dc, DisasASI *da,
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
@@ -2903,6 +2879,7 @@ static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
 # define avail_64(C)      false
 #endif
 #define avail_ASR17(C)    ((C)->def->features & CPU_FEATURE_ASR17)
+#define avail_CASA(C)     ((C)->def->features & CPU_FEATURE_CASA)
 #define avail_DIV(C)      ((C)->def->features & CPU_FEATURE_DIV)
 #define avail_GL(C)       ((C)->def->features & CPU_FEATURE_GL)
 #define avail_HYPV(C)     ((C)->def->features & CPU_FEATURE_HYPV)
@@ -4728,6 +4705,28 @@ static bool trans_SWAP(DisasContext *dc, arg_r_r_ri_asi *a)
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
@@ -5531,9 +5530,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             TCGv cpu_addr = tcg_temp_new();
 
             tcg_gen_mov_tl(cpu_addr, get_src1(dc, insn));
-            if (xop == 0x3c || xop == 0x3e) {
-                /* V9 casa/casxa : no offset */
-            } else if (IS_IMM) {     /* immediate */
+            if (IS_IMM) {     /* immediate */
                 simm = GET_FIELDs(insn, 19, 31);
                 if (simm != 0) {
                     tcg_gen_addi_tl(cpu_addr, cpu_addr, simm);
@@ -5746,22 +5743,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


