Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD577206A9
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 17:55:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5754-0003Lc-5V; Fri, 02 Jun 2023 11:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574z-0003Gq-A6
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:41 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574t-0003Xq-7S
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:41 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f6ef9a928fso20905395e9.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 08:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685721154; x=1688313154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u4r1oCLiGdCB4dNpcQXNpSWSHb5cjgZ/DorGnYp8sLE=;
 b=ny/9EIG5SPmoMa7BNV1fe1qCYpy7AniYzJTVpkeMod4CbndKAygvfEJ5jbMD2a7QRn
 x5mgnKszQc1G3DievK/v0Q66zm+sSo0SwlM2vSFOCEY4Cf2EajawPSYVDVwKvhEsQbqS
 S9UgNF6Zy4KEDN9NVTohrnvN+LnBuc4RrLaxGyMwIP+uc/0a3n4fmLnMEAmwIRsTr5cu
 WVOsQp/E+fH7fvAea7i9m63vO9T/HLpcMHD6NQsKbFOtJUYyp1XPmd3wz1UGdgmlRIb6
 QK6f6R0q+WhYBP/gVOJ/HUWutLtpYutUFdXn27C/87PJOvWpf4rbTHoyMKWpJIgUgI93
 pxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685721154; x=1688313154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u4r1oCLiGdCB4dNpcQXNpSWSHb5cjgZ/DorGnYp8sLE=;
 b=lgaUU3/ePC86rCizH2hwCHcxwiwXP4MzjHuQygq12j2tQP5LtIAWpIC1MaAjd/c16M
 Gh0MXXCy4AXGpnZP0tiG4ky8tWb/VrJYazV43vL4LfnnS8eCImxlxZwYycXJ4Lf1ZGBX
 6v9rK1YOzc8zISxn0qvEGvqahjd7ZvflKLLcGewDzH6TtobNPmJbSh4SX01cJfXPPxj8
 /1YJlHJT+vDFUcWtYWC+d9nElfGQPiJqrntXaepkZH+HygpaorRd/ppYF3UoNHAakveB
 Yzze05P375DzEShGUNNTkmtKsAPlurTPXZRlYPtwlQf2r7WTSFN8qWuQXxMkV3XvoShO
 d40w==
X-Gm-Message-State: AC+VfDxDDNiXGFtRYAQs/fNH4dxGguThilkXDBT6Utdr+sfSTQL9z04i
 C04R4ltBr/4z94ZWrKz4VNMh5ANzfsszoHwiAiQ=
X-Google-Smtp-Source: ACHHUZ4GdDg1ZU5D2ZHnKPejK9r4Brus4/G3p88ep7lrISoghcWpHi0jOjwfLso29Q1pFFeJwbEF/A==
X-Received: by 2002:a05:600c:217:b0:3f7:5d:4a17 with SMTP id
 23-20020a05600c021700b003f7005d4a17mr2131457wmi.4.1685721153845; 
 Fri, 02 Jun 2023 08:52:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a05600c214700b003f72a15301csm594952wml.2.2023.06.02.08.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 08:52:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 16/20] target/arm: Convert load (pointer auth) insns to
 decodetree
Date: Fri,  2 Jun 2023 16:52:19 +0100
Message-Id: <20230602155223.2040685-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602155223.2040685-1-peter.maydell@linaro.org>
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
---
 target/arm/tcg/a64.decode      |  7 +++
 target/arm/tcg/translate-a64.c | 83 +++++++---------------------------
 2 files changed, 23 insertions(+), 67 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 69635586718..2ea85312bba 100644
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
index 4e3bebab8e0..10a6fc4efb7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3150,42 +3150,22 @@ static bool trans_LDAPR(DisasContext *s, arg_LDAPR *a)
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
@@ -3194,23 +3174,21 @@ static void disas_ldst_pac(DisasContext *s, uint32_t insn,
         }
     }
 
-    /* Form the 10-bit signed, scaled offset.  */
-    offset = (extract32(insn, 22, 1) << 9) | extract32(insn, 12, 9);
-    offset = sextract32(offset << size, 0, 10 + size);
-    tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
+    tcg_gen_addi_i64(dirty_addr, dirty_addr, a->imm);
 
     /* Note that "clean" and "dirty" here refer to TBI not PAC.  */
     clean_addr = gen_mte_check1(s, dirty_addr, false,
-                                is_wback || rn != 31, size);
+                                a->w || a->rn != 31, 3);
 
-    tcg_rt = cpu_reg(s, rt);
-    do_gpr_ld(s, tcg_rt, clean_addr, size,
-              /* extend */ false, /* iss_valid */ !is_wback,
-              /* iss_srt */ rt, /* iss_sf */ true, /* iss_ar */ false);
+    tcg_rt = cpu_reg(s, a->rt);
+    do_gpr_ld(s, tcg_rt, clean_addr, 3,
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
@@ -3298,31 +3276,6 @@ static void disas_ldst_ldapr_stlr(DisasContext *s, uint32_t insn)
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
@@ -3832,10 +3785,6 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
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


