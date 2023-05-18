Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 928127081E3
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:54:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd6Z-0004IL-Hs; Thu, 18 May 2023 08:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6T-0004DD-9t
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:33 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6N-000828-Gi
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:30 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f41d087bd3so12562805e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414280; x=1687006280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+uKAV67tegBPCi4W/Vkq6NRUE8/9elykbxDxhdc51ns=;
 b=S6JYOhoLsyl4omWnSfY3eLPWGfy/+LEgdLfKhlHud+yuFJLbJ24OwLirW07cWpyoDW
 +ANDdOpd3uOc0ZRx9wHdcoj4rAPiDLkpMZ0ugv/FWjaGWtZHszmqdfNgb2k7LBIMBPtZ
 63ksYEwbVtfHT50hG9/0ehJri0LrJSUADFEcA4D44xo+xgajDQ/Yv26eJjKYCwFkD6K7
 bFkNi8f3FviVD30CaFzi33gBU/elfQi7uCFu7JG6Y0A4ZUMgF1GBz6QG8k0j5bvT7xfg
 wmcgZ6aAFXtma0EvH9EqXESOwWxxRNg6hGk4RPi+oXtLv/FLRL32pfg1J7UCyeSweF8L
 0Nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414280; x=1687006280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+uKAV67tegBPCi4W/Vkq6NRUE8/9elykbxDxhdc51ns=;
 b=KIqXsTNzhMb8vu5OwCvkRP9+mlRybujRiAZxMJkG5Np0Xrc+7kBDp8NtmMtnpCwoD+
 1FjrYMRiSFGJBjcol2ntQ7ZVpV9CHup7VmczDK6V+WMKCkSmcDUQ9LezAs8ppuDmiNVs
 c5hkeUHk53p8AgOe9HA82EsvRcBclbhYdRaRzgxUO387DZeU1XUkhjZeF8fbkwBylSZm
 mdb/RVp/2a8lzQNjpKWkW4znzr0RkV7AnpbxPNk4cyjdW9GDRqtJm7E/RhZ6xE85lEN0
 ckjF5JUOIiCIt38OZic7sqZEmq8ZVUOje2X7OMvJz6DOmcukZvtphArtVKUPxnPUZTYc
 hc5Q==
X-Gm-Message-State: AC+VfDxDRIPXoUoaR0z2xGUhx12QY0k1zMucaB6hpfp3eyGg2y+o/I64
 6zQnbBhrpShb8A8zJRbenK6ecVFZvgPb2mGEVYU=
X-Google-Smtp-Source: ACHHUZ7qJIgSrDgFft7DkESP7//sjLqTkDsTNH++i2HrFznoXcLmP7acap4FAOMGzDKMxHmmA8Z9DA==
X-Received: by 2002:a1c:7311:0:b0:3f4:237f:a171 with SMTP id
 d17-20020a1c7311000000b003f4237fa171mr1495346wmb.3.1684414280277; 
 Thu, 18 May 2023 05:51:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f42d2f4531sm5201321wmf.48.2023.05.18.05.51.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:51:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/29] target/arm: Convert BRAA, BRAB, BLRAA,
 BLRAB to decodetree
Date: Thu, 18 May 2023 13:51:03 +0100
Message-Id: <20230518125107.146421-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518125107.146421-1-peter.maydell@linaro.org>
References: <20230518125107.146421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Convert the last four BR-with-pointer-auth insns to decodetree.
The remaining cases in the outer switch in disas_uncond_b_reg()
all return early rather than leaving the case statement, so we
can delete the now-unused code at the end of that function.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230512144106.3608981-20-peter.maydell@linaro.org
---
 target/arm/tcg/a64.decode      |  4 ++
 target/arm/tcg/translate-a64.c | 97 ++++++++++++++--------------------
 2 files changed, 43 insertions(+), 58 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index f66202081ae..2fd435b6317 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -138,3 +138,7 @@ BLRAZ           1101011 0001 11111 00001 m:1 rn:5 11111 &braz   # BLRAAZ, BLRABZ
 
 &reta       m
 RETA            1101011 0010 11111 00001 m:1 11111 11111 &reta  # RETAA, RETAB
+
+&bra        rn rm m
+BRA             1101011 1000 11111 00001 m:1 rn:5 rm:5 &bra # BRAA, BRAB
+BLRA            1101011 1001 11111 00001 m:1 rn:5 rm:5 &bra # BLRAA, BLRAB
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index a278136cd10..40a6e59a609 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1504,6 +1504,41 @@ static bool trans_RETA(DisasContext *s, arg_reta *a)
     return true;
 }
 
+static bool trans_BRA(DisasContext *s, arg_bra *a)
+{
+    TCGv_i64 dst;
+
+    if (!dc_isar_feature(aa64_pauth, s)) {
+        return false;
+    }
+    dst = auth_branch_target(s, cpu_reg(s,a->rn), cpu_reg_sp(s, a->rm), !a->m);
+    gen_a64_set_pc(s, dst);
+    set_btype_for_br(s, a->rn);
+    s->base.is_jmp = DISAS_JUMP;
+    return true;
+}
+
+static bool trans_BLRA(DisasContext *s, arg_bra *a)
+{
+    TCGv_i64 dst, lr;
+
+    if (!dc_isar_feature(aa64_pauth, s)) {
+        return false;
+    }
+    dst = auth_branch_target(s, cpu_reg(s, a->rn), cpu_reg_sp(s, a->rm), !a->m);
+    lr = cpu_reg(s, 30);
+    if (dst == lr) {
+        TCGv_i64 tmp = tcg_temp_new_i64();
+        tcg_gen_mov_i64(tmp, dst);
+        dst = tmp;
+    }
+    gen_pc_plus_diff(s, lr, curr_insn_len(s));
+    gen_a64_set_pc(s, dst);
+    set_btype_for_blr(s);
+    s->base.is_jmp = DISAS_JUMP;
+    return true;
+}
+
 /* HINT instruction group, including various allocated HINTs */
 static void handle_hint(DisasContext *s, uint32_t insn,
                         unsigned int op1, unsigned int op2, unsigned int crm)
@@ -2281,7 +2316,6 @@ static void disas_exc(DisasContext *s, uint32_t insn)
 static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
 {
     unsigned int opc, op2, op3, rn, op4;
-    unsigned btype_mod = 2;   /* 0: BR, 1: BLR, 2: other */
     TCGv_i64 dst;
     TCGv_i64 modifier;
 
@@ -2299,45 +2333,14 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
     case 0:
     case 1:
     case 2:
+    case 8:
+    case 9:
         /*
-         * BR, BLR, RET, RETAA, RETAB, BRAAZ, BRABZ, BLRAAZ, BLRABZ:
-         * handled in decodetree
+         * BR, BLR, RET, RETAA, RETAB, BRAAZ, BRABZ, BLRAAZ, BLRABZ,
+         * BRAA, BLRAA: handled in decodetree
          */
         goto do_unallocated;
 
-    case 8: /* BRAA */
-    case 9: /* BLRAA */
-        if (!dc_isar_feature(aa64_pauth, s)) {
-            goto do_unallocated;
-        }
-        if ((op3 & ~1) != 2) {
-            goto do_unallocated;
-        }
-        btype_mod = opc & 1;
-        if (s->pauth_active) {
-            dst = tcg_temp_new_i64();
-            modifier = cpu_reg_sp(s, op4);
-            if (op3 == 2) {
-                gen_helper_autia(dst, cpu_env, cpu_reg(s, rn), modifier);
-            } else {
-                gen_helper_autib(dst, cpu_env, cpu_reg(s, rn), modifier);
-            }
-        } else {
-            dst = cpu_reg(s, rn);
-        }
-        /* BLRAA also needs to load return address */
-        if (opc == 9) {
-            TCGv_i64 lr = cpu_reg(s, 30);
-            if (dst == lr) {
-                TCGv_i64 tmp = tcg_temp_new_i64();
-                tcg_gen_mov_i64(tmp, dst);
-                dst = tmp;
-            }
-            gen_pc_plus_diff(s, lr, curr_insn_len(s));
-        }
-        gen_a64_set_pc(s, dst);
-        break;
-
     case 4: /* ERET */
         if (s->current_el == 0) {
             goto do_unallocated;
@@ -2407,28 +2410,6 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
         unallocated_encoding(s);
         return;
     }
-
-    switch (btype_mod) {
-    case 0: /* BR */
-        if (dc_isar_feature(aa64_bti, s)) {
-            /* BR to {x16,x17} or !guard -> 1, else 3.  */
-            set_btype(s, rn == 16 || rn == 17 || !s->guarded_page ? 1 : 3);
-        }
-        break;
-
-    case 1: /* BLR */
-        if (dc_isar_feature(aa64_bti, s)) {
-            /* BLR sets BTYPE to 2, regardless of source guarded page.  */
-            set_btype(s, 2);
-        }
-        break;
-
-    default: /* RET or none of the above.  */
-        /* BTYPE will be set to 0 by normal end-of-insn processing.  */
-        break;
-    }
-
-    s->base.is_jmp = DISAS_JUMP;
 }
 
 /* Branches, exception generating and system instructions */
-- 
2.34.1


