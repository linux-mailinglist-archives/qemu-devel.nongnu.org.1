Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C91CB7C8F56
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:36:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPly-00006L-E0; Fri, 13 Oct 2023 17:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPlt-00083l-MI
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:37 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPlp-0001MV-Bz
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:36 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-57b64731334so1391304eaf.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232752; x=1697837552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PV4t/VRrhLEceDN9THQ4ugjHJbP6z3ZqwmY3rLJYAvM=;
 b=i4j7AepHRMLAmPVJsPh3Jwsg9bRuzu2MW6iDXcOM1/gUr+LFL8gfDSe6EO0WcwGH75
 VmgxzWXl4vKQIh6daHL/uGnUCn04nMUreHEvSjXT3hzB33vm+cdlwyaA9vIFhkTaglRW
 MYe3QstfJ64e7hBctkUVbkQgK6qVIC3gSGr80ZZwrWb0AXIxnl/K9vQy139nO0J7P58k
 91aSzxjFu9A0h4o4+KvyG/kxZfMoC8Oz/dGT+Qm3+PVVRtI10o7BxGuBMUP5c+3rLrhc
 L6mZjqWO40HA029FKw7GcfT5lgB9SCG4TcrqsQ4rg7fO5sjtPX8DPuoy9gcpTebxOXS9
 h4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232752; x=1697837552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PV4t/VRrhLEceDN9THQ4ugjHJbP6z3ZqwmY3rLJYAvM=;
 b=xC7QgdtB41A/IoJVL+lvSOgDTTIIjjJ+OuZ+pvRy+cEQOtTGZaRK+d9wvVoBGmU6/g
 3TPuRgH2hwu33g3Wctmv7hzMivcjuIrNfWS/UZ5eS3cZuKGIwYoThnz8dTMXaWzz7j+5
 6/EsOrrB2AiBZxemz6qA2UgJnHe5ikRC/Z7BYR9TG6c7xmmqMpjDvPWdfQehA3Hjz/Yp
 Ne2hMyaNIR/+fyE7ocba52wd097ffQysK51p+AvB2YTgP1ZiYwzekAuvhX0BcSQjMk4p
 8Y3qxNJI5YsKpL5B7Zl2gMD8WqDzGQCnk+80/UncYokfP7zvkmUOufWmeagxR8wQLNMQ
 b7zQ==
X-Gm-Message-State: AOJu0Yx7w+fQNkSBdv4XLK8kx+Equ8q4rGVeQOae7LQKMZ6zsPo0T90d
 0AlNeTeKsSay1tWT0ZFgl0xHXD7nPqwxUdIWfL4=
X-Google-Smtp-Source: AGHT+IH4u/Fretk0YqfLu8tlx/pqAZcz6uKPTz8BX0d0ZB8Nb4cEElEUscXhAUg/acdwmWcq/oHxrQ==
X-Received: by 2002:a05:6358:5289:b0:13a:4f34:8063 with SMTP id
 g9-20020a056358528900b0013a4f348063mr29364638rwa.32.1697232752034; 
 Fri, 13 Oct 2023 14:32:32 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 47/85] target/sparc: Move CASA, CASXA to decodetree
Date: Fri, 13 Oct 2023 14:28:08 -0700
Message-Id: <20231013212846.165724-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
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

Remove gen_cas_asi, gen_casx_asi.
Rename gen_cas_asi0 to gen_cas_asi.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  7 ++++
 target/sparc/translate.c  | 71 +++++++++++++++------------------------
 2 files changed, 35 insertions(+), 43 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 4f678b4895..1a641248ce 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -234,6 +234,8 @@ RETRY       10 00001 111110 00000 0 0000000000000
 @r_r_r_asi  .. rd:5  ...... rs1:5 0     asi:8 rs2_or_imm:5 &r_r_ri_asi imm=0
 @r_r_i_asi  .. rd:5  ...... rs1:5 1     rs2_or_imm:s13     \
             &r_r_ri_asi imm=1 asi=-2
+@casa_imm   .. rd:5  ...... rs1:5 1 00000000 rs2_or_imm:5  \
+            &r_r_ri_asi imm=1 asi=-2
 
 LDUW        11 ..... 000000 ..... . .............          @r_r_ri_na
 LDUB        11 ..... 000001 ..... . .............          @r_r_ri_na
@@ -286,6 +288,11 @@ SWAP        11 ..... 001111 ..... . .............          @r_r_ri_na
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
index d640883985..beb42b9fb7 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2162,8 +2162,8 @@ static void gen_swap_asi(DisasContext *dc, DisasASI *da,
     }
 }
 
-static void gen_cas_asi0(DisasContext *dc, DisasASI *da,
-                         TCGv oldv, TCGv newv, TCGv cmpv, TCGv addr)
+static void gen_cas_asi(DisasContext *dc, DisasASI *da,
+                        TCGv oldv, TCGv newv, TCGv cmpv, TCGv addr)
 {
     switch (da->type) {
     case GET_ASI_EXCP:
@@ -2179,30 +2179,6 @@ static void gen_cas_asi0(DisasContext *dc, DisasASI *da,
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
@@ -2812,6 +2788,7 @@ static void gen_faligndata(TCGv dst, TCGv gsr, TCGv s1, TCGv s2)
 # define avail_64(C)      false
 #endif
 #define avail_ASR17(C)    ((C)->def->features & CPU_FEATURE_ASR17)
+#define avail_CASA(C)     ((C)->def->features & CPU_FEATURE_CASA)
 #define avail_GL(C)       ((C)->def->features & CPU_FEATURE_GL)
 #define avail_HYPV(C)     ((C)->def->features & CPU_FEATURE_HYPV)
 #define avail_POWERDOWN(C) ((C)->def->features & CPU_FEATURE_POWERDOWN)
@@ -4628,6 +4605,28 @@ static bool trans_SWAP(DisasContext *dc, arg_r_r_ri_asi *a)
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
@@ -5431,9 +5430,7 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             TCGv cpu_addr = tcg_temp_new();
 
             tcg_gen_mov_tl(cpu_addr, get_src1(dc, insn));
-            if (xop == 0x3c || xop == 0x3e) {
-                /* V9 casa/casxa : no offset */
-            } else if (IS_IMM) {     /* immediate */
+            if (IS_IMM) {     /* immediate */
                 simm = GET_FIELDs(insn, 19, 31);
                 if (simm != 0) {
                     tcg_gen_addi_tl(cpu_addr, cpu_addr, simm);
@@ -5646,22 +5643,10 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


