Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0290C97C9CE
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Sep 2024 15:13:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srGwj-00064N-58; Thu, 19 Sep 2024 09:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwV-0005NG-9B
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:32 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1srGwQ-00013f-NV
 for qemu-devel@nongnu.org; Thu, 19 Sep 2024 09:11:29 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42cbc38a997so5489415e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2024 06:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726751482; x=1727356282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=65GoK7jjLDjdYPKDwe9YM8X2eiP0HXrBJnIC4AyohQU=;
 b=h8eVY03X+hHR/l6mMWlx91CkmoKXYvemnvzwJW2jyDolp+t76EY72mbA6UGs+iUbXY
 1YX9RqACaAzIHCPdk3okXzXOmrzM0DX8dG9LltvkjOYrJAbRJgUBVt1PDDz3E7QyElz6
 lkMv20feMam5LAMP0X0qcpBb6LBkEe1tf+g9keCEB88U6AqZ70twqw3+0K2ti6KGf9RF
 id2apltSjpfFoH0qLOMgfQOM+PlXSODSH71bV6ZyELeQdOuBju3cIexaAqt+Ox6Cd1S6
 1OMtkwpOVc7Tq86LvPIWpPNUDQhqqbQddSR0ATvReI4PvVi8ERsDe1FLG7dEGjSTulWi
 HI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726751482; x=1727356282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=65GoK7jjLDjdYPKDwe9YM8X2eiP0HXrBJnIC4AyohQU=;
 b=oJnJVEkKuary0JotoVY/+ZJNL85d0wEJ4Qz+5FAP9yeHXKlhWC2kQFcyCF9bxxHUkP
 vPbwSB2JILntvwhMgPDZwO7iZV2jZ/YerEL7NTKNqOn9eU4bv7wPn3n8MmYILR8Mitn4
 8N8c8Mddvo1E9Et1GncGjO2izP6aLO+7Nyn0cZia653voBqkEvJ+/jHqu8na14e175Zz
 /df3d2O04ZThek6e18TOnNMYdeNTafJkzsrA+DnDoAT97cweWvH+LHzmAVWIYqH9OcWt
 VrOjHexGKH8cTxaD7DKUS08JeOOV/7C7OQzrkvw6h5o2OWoo7uKbaqp9Cy++95pysFB/
 m6dQ==
X-Gm-Message-State: AOJu0YxCqArduzw8RTdd1g/BYnx0pmV3VfpLZp5+9tc7m08PoLLqZYzj
 Q8pygnp32oQOIt+JT/brNzcEfRAq0t1uEz9FlImxircS2s9Cphzzz+0D+c6nY9QSnw9HTpsIRP0
 2
X-Google-Smtp-Source: AGHT+IFkTsTFJOZxVnfyMPi2Mm6Ib2nfy1aHzmV1lVtxBJgrftR8xhGjD7hW+CJYZRx/ks2jlFqHaA==
X-Received: by 2002:a05:600c:19ce:b0:424:8743:86b4 with SMTP id
 5b1f17b1804b1-42e74406533mr18458475e9.6.1726751482123; 
 Thu, 19 Sep 2024 06:11:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e754091d3sm21667845e9.10.2024.09.19.06.11.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 06:11:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/38] target/arm: Convert handle_scalar_simd_shli to decodetree
Date: Thu, 19 Sep 2024 14:10:52 +0100
Message-Id: <20240919131106.3362543-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919131106.3362543-1-peter.maydell@linaro.org>
References: <20240919131106.3362543-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This includes SHL and SLI.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240912024114.1097832-25-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  4 ++++
 target/arm/tcg/translate-a64.c | 44 +++++++---------------------------
 2 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 6c2362b3bbc..96803fe6e4c 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1291,6 +1291,7 @@ RSHRN_v         0.00 11110 .... ... 10001 1 ..... .....     @q_shri_s
 
 @shri_d         .... ..... 1 ...... ..... . rn:5 rd:5   \
                 &rri_e esz=3 imm=%neon_rshift_i6
+@shli_d         .... ..... 1 imm:6  ..... . rn:5 rd:5   &rri_e esz=3 
 
 SSHR_s          0101 11110 .... ... 00000 1 ..... .....     @shri_d
 USHR_s          0111 11110 .... ... 00000 1 ..... .....     @shri_d
@@ -1301,3 +1302,6 @@ URSHR_s         0111 11110 .... ... 00100 1 ..... .....     @shri_d
 SRSRA_s         0101 11110 .... ... 00110 1 ..... .....     @shri_d
 URSRA_s         0111 11110 .... ... 00110 1 ..... .....     @shri_d
 SRI_s           0111 11110 .... ... 01000 1 ..... .....     @shri_d
+
+SHL_s           0101 11110 .... ... 01010 1 ..... .....     @shli_d
+SLI_s           0111 11110 .... ... 01010 1 ..... .....     @shli_d
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index efd93a7f234..934746d2f2c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7124,6 +7124,11 @@ static void gen_sri_d(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
     }
 }
 
+static void gen_sli_d(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
+{
+    tcg_gen_deposit_i64(dst, dst, src, shift, 64 - shift);
+}
+
 static bool do_vec_shift_imm_narrow(DisasContext *s, arg_qrri_e *a,
                                     WideShiftImmFn * const fns[3], MemOp sign)
 {
@@ -7201,6 +7206,9 @@ TRANS(SRSRA_s, do_scalar_shift_imm, a, gen_srsra_d, true, 0)
 TRANS(URSRA_s, do_scalar_shift_imm, a, gen_ursra_d, true, 0)
 TRANS(SRI_s, do_scalar_shift_imm, a, gen_sri_d, true, 0)
 
+TRANS(SHL_s, do_scalar_shift_imm, a, tcg_gen_shli_i64, false, 0)
+TRANS(SLI_s, do_scalar_shift_imm, a, gen_sli_d, true, 0)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -9417,38 +9425,6 @@ static void handle_shri_with_rndacc(TCGv_i64 tcg_res, TCGv_i64 tcg_src,
     }
 }
 
-/* SHL/SLI - Scalar shift left */
-static void handle_scalar_simd_shli(DisasContext *s, bool insert,
-                                    int immh, int immb, int opcode,
-                                    int rn, int rd)
-{
-    int size = 32 - clz32(immh) - 1;
-    int immhb = immh << 3 | immb;
-    int shift = immhb - (8 << size);
-    TCGv_i64 tcg_rn;
-    TCGv_i64 tcg_rd;
-
-    if (!extract32(immh, 3, 1)) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    tcg_rn = read_fp_dreg(s, rn);
-    tcg_rd = insert ? read_fp_dreg(s, rd) : tcg_temp_new_i64();
-
-    if (insert) {
-        tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_rn, shift, 64 - shift);
-    } else {
-        tcg_gen_shli_i64(tcg_rd, tcg_rn, shift);
-    }
-
-    write_fp_dreg(s, rd, tcg_rd);
-}
-
 /* SQSHRN/SQSHRUN - Saturating (signed/unsigned) shift right with
  * (signed/unsigned) narrowing */
 static void handle_vec_simd_sqshrn(DisasContext *s, bool is_scalar, bool is_q,
@@ -9900,9 +9876,6 @@ static void disas_simd_scalar_shift_imm(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x0a: /* SHL / SLI */
-        handle_scalar_simd_shli(s, is_u, immh, immb, opcode, rn, rd);
-        break;
     case 0x1c: /* SCVTF, UCVTF */
         handle_simd_shift_intfp_conv(s, true, false, is_u, immh, immb,
                                      opcode, rn, rd);
@@ -9940,6 +9913,7 @@ static void disas_simd_scalar_shift_imm(DisasContext *s, uint32_t insn)
     case 0x04: /* SRSHR / URSHR */
     case 0x06: /* SRSRA / URSRA */
     case 0x08: /* SRI */
+    case 0x0a: /* SHL / SLI */
         unallocated_encoding(s);
         break;
     }
-- 
2.34.1


