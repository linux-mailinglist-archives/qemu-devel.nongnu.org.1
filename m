Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FC47359AB
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:34:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFtO-0000x3-1W; Mon, 19 Jun 2023 10:30:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsm-0000dN-Fp
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:28 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsj-0002EE-V7
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:28 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f9b23dc270so9119485e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184964; x=1689776964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wZtVgFV8GkDyXO4vsdUA6xljaLuLuyspVB+wnGanNt0=;
 b=n/L6FsN+ZHSU9rnRM8ff7hdiQkWfAKj88SEo3GaadMf+ckOHTAmc83lrZIgVb7Rml9
 6EiEm7IqPYGrSHGv1+QJh3WyBwn3hu1JGadrTXkyDodo3N4/wSIPnxLkNK3ehufEtVYD
 keeKPjcFyEcWRogKpRtAi/WPA8NfGgSwYjcVuWG2GLcFtQWwLwAwZY4zFN2PWNEsx7ws
 F6Cx63m7FHFM2se3Gba9i5gV8SiJxXElZs99iZwxOjciao/REUn5awOdTyMzHgo8joTw
 sS/mB6PmAIwYS7rk9dR6sCaUdtPJOUbZ69XDA/dzFJ2KT+sOmsU4cEurN6iU4PrH4QWr
 cTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184964; x=1689776964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wZtVgFV8GkDyXO4vsdUA6xljaLuLuyspVB+wnGanNt0=;
 b=AySdWtwxWqwdBWmfeQsjw4XPsA4KBj8Sdwa6aYYvKjq4pZApIHxqwNLtWaMYx91DGz
 yX/Q42qW432vtbIzKM9AHCNg47r95BSjGrS9a4+n4GQQxkJpliizELGJ+puRiJDxvwUH
 D5KlN5+fAQQ75sVEcUwCYE56iBAdpH2AAji3JEYqc1EfXFvEayQFP1XD+GpH4XO8sV0R
 rFLARoxz8XP5z3Zjl7mOqZgHT3SS09m8z01t5XYNu4SYg5LNQ81zXimgTX3xKUs5+/4u
 Or1vGx1cdv/VeMUeRk0yUWjE4UxCp5P6ac1fy1EbxDz2U/xi0dNJkxOnEkYnuq68/quh
 c7qA==
X-Gm-Message-State: AC+VfDwywyX+2O97S9FIstiAB/vaS9+Ln2ufAwCFtp5osxXgCYPxfmuy
 LHpB8F6igi2IQE0+GCghyWNehOnt9yPRDkzybyE=
X-Google-Smtp-Source: ACHHUZ6b1AMWFFT4LEt9OB6TlYnb48odo2nCazGXr7H2+f7ioRcq22V6FRU+IIKmc0+VhbeikZb99g==
X-Received: by 2002:a7b:c38f:0:b0:3f8:ff4e:8ba3 with SMTP id
 s15-20020a7bc38f000000b003f8ff4e8ba3mr6719190wmj.38.1687184964723; 
 Mon, 19 Jun 2023 07:29:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a05600c224200b003f9b53959a4sm429012wmm.43.2023.06.19.07.29.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:29:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/33] target/arm: Convert load (pointer auth) insns to
 decodetree
Date: Mon, 19 Jun 2023 15:29:00 +0100
Message-Id: <20230619142914.963184-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142914.963184-1-peter.maydell@linaro.org>
References: <20230619142914.963184-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Convert the instructions in the load/store register (pointer
authentication) group ot decodetree: LDRAA, LDRAB.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230602155223.2040685-17-peter.maydell@linaro.org
---
 target/arm/tcg/a64.decode      |  7 +++
 target/arm/tcg/translate-a64.c | 83 +++++++---------------------------
 2 files changed, 23 insertions(+), 67 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 799c5ecb77a..b80a17111e7 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -457,3 +457,10 @@ LDUMIN          .. 111 0 00 . . 1 ..... 0111 00 ..... ..... @atomic
 SWP             .. 111 0 00 . . 1 ..... 1000 00 ..... ..... @atomic
 
 LDAPR           sz:2 111 0 00 1 0 1 11111 1100 00 rn:5 rt:5
+
+# Load/store register (pointer authentication)
+
+# LDRA immediate is 10 bits signed and scaled, but the bits aren't all contiguous
+%ldra_imm       22:s1 12:9 !function=times_2
+
+LDRA            11 111 0 00 m:1 . 1 ......... w:1 1 rn:5 rt:5 imm=%ldra_imm
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 6dc8151c407..2bffb14e84e 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3324,43 +3324,23 @@ static bool trans_LDAPR(DisasContext *s, arg_LDAPR *a)
     return true;
 }
 
-/*
- * PAC memory operations
- *
- *  31  30      27  26    24    22  21       12  11  10    5     0
- * +------+-------+---+-----+-----+---+--------+---+---+----+-----+
- * | size | 1 1 1 | V | 0 0 | M S | 1 |  imm9  | W | 1 | Rn |  Rt |
- * +------+-------+---+-----+-----+---+--------+---+---+----+-----+
- *
- * Rt: the result register
- * Rn: base address or SP
- * V: vector flag (always 0 as of v8.3)
- * M: clear for key DA, set for key DB
- * W: pre-indexing flag
- * S: sign for imm9.
- */
-static void disas_ldst_pac(DisasContext *s, uint32_t insn,
-                           int size, int rt, bool is_vector)
+static bool trans_LDRA(DisasContext *s, arg_LDRA *a)
 {
-    int rn = extract32(insn, 5, 5);
-    bool is_wback = extract32(insn, 11, 1);
-    bool use_key_a = !extract32(insn, 23, 1);
-    int offset;
     TCGv_i64 clean_addr, dirty_addr, tcg_rt;
     MemOp memop;
 
-    if (size != 3 || is_vector || !dc_isar_feature(aa64_pauth, s)) {
-        unallocated_encoding(s);
-        return;
+    /* Load with pointer authentication */
+    if (!dc_isar_feature(aa64_pauth, s)) {
+        return false;
     }
 
-    if (rn == 31) {
+    if (a->rn == 31) {
         gen_check_sp_alignment(s);
     }
-    dirty_addr = read_cpu_reg_sp(s, rn, 1);
+    dirty_addr = read_cpu_reg_sp(s, a->rn, 1);
 
     if (s->pauth_active) {
-        if (use_key_a) {
+        if (!a->m) {
             gen_helper_autda(dirty_addr, cpu_env, dirty_addr,
                              tcg_constant_i64(0));
         } else {
@@ -3369,25 +3349,23 @@ static void disas_ldst_pac(DisasContext *s, uint32_t insn,
         }
     }
 
-    /* Form the 10-bit signed, scaled offset.  */
-    offset = (extract32(insn, 22, 1) << 9) | extract32(insn, 12, 9);
-    offset = sextract32(offset << size, 0, 10 + size);
-    tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
+    tcg_gen_addi_i64(dirty_addr, dirty_addr, a->imm);
 
-    memop = finalize_memop(s, size);
+    memop = finalize_memop(s, MO_64);
 
     /* Note that "clean" and "dirty" here refer to TBI not PAC.  */
     clean_addr = gen_mte_check1(s, dirty_addr, false,
-                                is_wback || rn != 31, memop);
+                                a->w || a->rn != 31, memop);
 
-    tcg_rt = cpu_reg(s, rt);
+    tcg_rt = cpu_reg(s, a->rt);
     do_gpr_ld(s, tcg_rt, clean_addr, memop,
-              /* extend */ false, /* iss_valid */ !is_wback,
-              /* iss_srt */ rt, /* iss_sf */ true, /* iss_ar */ false);
+              /* extend */ false, /* iss_valid */ !a->w,
+              /* iss_srt */ a->rt, /* iss_sf */ true, /* iss_ar */ false);
 
-    if (is_wback) {
-        tcg_gen_mov_i64(cpu_reg_sp(s, rn), dirty_addr);
+    if (a->w) {
+        tcg_gen_mov_i64(cpu_reg_sp(s, a->rn), dirty_addr);
     }
+    return true;
 }
 
 /*
@@ -3474,31 +3452,6 @@ static void disas_ldst_ldapr_stlr(DisasContext *s, uint32_t insn)
     }
 }
 
-/* Load/store register (all forms) */
-static void disas_ldst_reg(DisasContext *s, uint32_t insn)
-{
-    int rt = extract32(insn, 0, 5);
-    bool is_vector = extract32(insn, 26, 1);
-    int size = extract32(insn, 30, 2);
-
-    switch (extract32(insn, 24, 2)) {
-    case 0:
-        if (extract32(insn, 21, 1) == 0) {
-            break;
-        }
-        switch (extract32(insn, 10, 2)) {
-        case 0:
-        case 2:
-            break;
-        default:
-            disas_ldst_pac(s, insn, size, rt, is_vector);
-            return;
-        }
-        break;
-    }
-    unallocated_encoding(s);
-}
-
 /* AdvSIMD load/store multiple structures
  *
  *  31  30  29           23 22  21         16 15    12 11  10 9    5 4    0
@@ -4016,10 +3969,6 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
 static void disas_ldst(DisasContext *s, uint32_t insn)
 {
     switch (extract32(insn, 24, 6)) {
-    case 0x38: case 0x39:
-    case 0x3c: case 0x3d: /* Load/store register (all forms) */
-        disas_ldst_reg(s, insn);
-        break;
     case 0x0c: /* AdvSIMD load/store multiple structures */
         disas_ldst_multiple_struct(s, insn);
         break;
-- 
2.34.1


