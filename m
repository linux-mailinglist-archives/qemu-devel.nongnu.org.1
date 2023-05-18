Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 689D37081D7
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:53:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd6X-0004HW-TN; Thu, 18 May 2023 08:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6O-0004BP-5m
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:28 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6K-00081L-5l
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:27 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3078cc99232so1900597f8f.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414276; x=1687006276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=316WPcTaX/dkZyaOwPkqhzyQ3qnA+Bqof7S5NJnRzk4=;
 b=S+3I4xXRHgJ42h3DloY6yhHVKW1NOpiYXjmo1lmdEOhkvGfh67PmqweQ9LpmWNaEi5
 EjlrbaNcDGjYn8ydkOXD+WO0GASawhjJsdA9xO1RlZVw9RtuNrSu7m2CD6RAJpefR2VC
 5pZHcZw5NWjSkhw3OCBxsf6uuxvvRuwQ6DduWlsrQhlQ50XnNmqKg68l1/C3jvbUPAok
 vZ44IumqECB6EaoYIXTCZU2G40EQ+3Iz2P32RUdv2LJTGFZq6DZL6iDh+i03fPRz9qBt
 IHMdEtuJ5aOfYwmBvmwD2U7EryT2BbtDSxAQl1booacO8Z6g6MxaRHz6MZ57uuK2QsTa
 XdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414276; x=1687006276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=316WPcTaX/dkZyaOwPkqhzyQ3qnA+Bqof7S5NJnRzk4=;
 b=ekonLL/Wp0TV3bgqVTVpxkYA5VVJZATZZT6QM+X+hKPSkTBeC+1pLhsJwR7gdFPAOl
 0wOWqWHPMytKIVAz7OuqnTkCNu1H/sPW5yH36XCxv/bdyleOefhiMeC85U3atLCI6nhc
 QcKZ1+ua0w8dr96prfRrb03w/k9Z0HkY+vmwQ21kGmnsmnAOKpeqTOzc8W2KfPOGZbHU
 WuF39BHzWIdvlD4vNf4i+2d8ZiCw0GSeoJkTy5Tng5DRn1QharWFHZLcBP7B+NQkGNTr
 6CFdmNQpnPByncgeDv5xm/hjTmk+7ebFByl2AHg3RIUfPcqPYjQ3729xSR01goskVcEv
 YYmQ==
X-Gm-Message-State: AC+VfDyXWHbg7LWKUu2mTATyMll0VRhTRJItYRZhC5RBIhXQutXgyr9Q
 mysa3MqfluC1nARbMAo2i6yuDIdJZQjPf24xUUQ=
X-Google-Smtp-Source: ACHHUZ5CDISbTg8X/ZqdwXnfULItg/EIfe3ftiRnhJkz0XWH7PjU8Wufok3hwMz9+qDYYZzKtEpcng==
X-Received: by 2002:adf:fe50:0:b0:307:a36b:e7b1 with SMTP id
 m16-20020adffe50000000b00307a36be7b1mr1771112wrs.5.1684414276546; 
 Thu, 18 May 2023 05:51:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f42d2f4531sm5201321wmf.48.2023.05.18.05.51.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:51:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/29] target/arm: Convert Bitfield to decodetree
Date: Thu, 18 May 2023 13:50:55 +0100
Message-Id: <20230518125107.146421-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518125107.146421-1-peter.maydell@linaro.org>
References: <20230518125107.146421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Convert the BFM, SBFM, UBFM instructions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230512144106.3608981-12-peter.maydell@linaro.org
[PMM: Rebased]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  13 +++
 target/arm/tcg/translate-a64.c | 144 ++++++++++++++++++---------------
 2 files changed, 94 insertions(+), 63 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 350b37c8f37..4d5709f9857 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -84,3 +84,16 @@ MOVZ            . 10 100101 .. ................ .....   @movw_64
 MOVZ            . 10 100101 .. ................ .....   @movw_32
 MOVK            . 11 100101 .. ................ .....   @movw_64
 MOVK            . 11 100101 .. ................ .....   @movw_32
+
+# Bitfield
+
+&bitfield       rd rn sf immr imms
+@bitfield_64    1 .. ...... 1 immr:6 imms:6 rn:5 rd:5      &bitfield sf=1
+@bitfield_32    0 .. ...... 0 0 immr:5 0 imms:5 rn:5 rd:5  &bitfield sf=0
+
+SBFM            . 00 100110 . ...... ...... ..... ..... @bitfield_64
+SBFM            . 00 100110 . ...... ...... ..... ..... @bitfield_32
+BFM             . 01 100110 . ...... ...... ..... ..... @bitfield_64
+BFM             . 01 100110 . ...... ...... ..... ..... @bitfield_32
+UBFM            . 10 100110 . ...... ...... ..... ..... @bitfield_64
+UBFM            . 10 100110 . ...... ...... ..... ..... @bitfield_32
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c9117f0a405..3e7344e79c3 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4431,82 +4431,103 @@ static bool trans_MOVK(DisasContext *s, arg_movw *a)
     return true;
 }
 
-/* Bitfield
- *   31  30 29 28         23 22  21  16 15  10 9    5 4    0
- * +----+-----+-------------+---+------+------+------+------+
- * | sf | opc | 1 0 0 1 1 0 | N | immr | imms |  Rn  |  Rd  |
- * +----+-----+-------------+---+------+------+------+------+
+/*
+ * Bitfield
  */
-static void disas_bitfield(DisasContext *s, uint32_t insn)
+
+static bool trans_SBFM(DisasContext *s, arg_SBFM *a)
 {
-    unsigned int sf, n, opc, ri, si, rn, rd, bitsize, pos, len;
-    TCGv_i64 tcg_rd, tcg_tmp;
+    TCGv_i64 tcg_rd = cpu_reg(s, a->rd);
+    TCGv_i64 tcg_tmp = read_cpu_reg(s, a->rn, 1);
+    unsigned int bitsize = a->sf ? 64 : 32;
+    unsigned int ri = a->immr;
+    unsigned int si = a->imms;
+    unsigned int pos, len;
 
-    sf = extract32(insn, 31, 1);
-    opc = extract32(insn, 29, 2);
-    n = extract32(insn, 22, 1);
-    ri = extract32(insn, 16, 6);
-    si = extract32(insn, 10, 6);
-    rn = extract32(insn, 5, 5);
-    rd = extract32(insn, 0, 5);
-    bitsize = sf ? 64 : 32;
-
-    if (sf != n || ri >= bitsize || si >= bitsize || opc > 2) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    tcg_rd = cpu_reg(s, rd);
-
-    /* Suppress the zero-extend for !sf.  Since RI and SI are constrained
-       to be smaller than bitsize, we'll never reference data outside the
-       low 32-bits anyway.  */
-    tcg_tmp = read_cpu_reg(s, rn, 1);
-
-    /* Recognize simple(r) extractions.  */
     if (si >= ri) {
         /* Wd<s-r:0> = Wn<s:r> */
         len = (si - ri) + 1;
-        if (opc == 0) { /* SBFM: ASR, SBFX, SXTB, SXTH, SXTW */
-            tcg_gen_sextract_i64(tcg_rd, tcg_tmp, ri, len);
-            goto done;
-        } else if (opc == 2) { /* UBFM: UBFX, LSR, UXTB, UXTH */
-            tcg_gen_extract_i64(tcg_rd, tcg_tmp, ri, len);
-            return;
+        tcg_gen_sextract_i64(tcg_rd, tcg_tmp, ri, len);
+        if (!a->sf) {
+            tcg_gen_ext32u_i64(tcg_rd, tcg_rd);
         }
-        /* opc == 1, BFXIL fall through to deposit */
+    } else {
+        /* Wd<32+s-r,32-r> = Wn<s:0> */
+        len = si + 1;
+        pos = (bitsize - ri) & (bitsize - 1);
+
+        if (len < ri) {
+            /*
+             * Sign extend the destination field from len to fill the
+             * balance of the word.  Let the deposit below insert all
+             * of those sign bits.
+             */
+            tcg_gen_sextract_i64(tcg_tmp, tcg_tmp, 0, len);
+            len = ri;
+        }
+
+        /*
+         * We start with zero, and we haven't modified any bits outside
+         * bitsize, therefore no final zero-extension is unneeded for !sf.
+         */
+        tcg_gen_deposit_z_i64(tcg_rd, tcg_tmp, pos, len);
+    }
+    return true;
+}
+
+static bool trans_UBFM(DisasContext *s, arg_UBFM *a)
+{
+    TCGv_i64 tcg_rd = cpu_reg(s, a->rd);
+    TCGv_i64 tcg_tmp = read_cpu_reg(s, a->rn, 1);
+    unsigned int bitsize = a->sf ? 64 : 32;
+    unsigned int ri = a->immr;
+    unsigned int si = a->imms;
+    unsigned int pos, len;
+
+    tcg_rd = cpu_reg(s, a->rd);
+    tcg_tmp = read_cpu_reg(s, a->rn, 1);
+
+    if (si >= ri) {
+        /* Wd<s-r:0> = Wn<s:r> */
+        len = (si - ri) + 1;
+        tcg_gen_extract_i64(tcg_rd, tcg_tmp, ri, len);
+    } else {
+        /* Wd<32+s-r,32-r> = Wn<s:0> */
+        len = si + 1;
+        pos = (bitsize - ri) & (bitsize - 1);
+        tcg_gen_deposit_z_i64(tcg_rd, tcg_tmp, pos, len);
+    }
+    return true;
+}
+
+static bool trans_BFM(DisasContext *s, arg_BFM *a)
+{
+    TCGv_i64 tcg_rd = cpu_reg(s, a->rd);
+    TCGv_i64 tcg_tmp = read_cpu_reg(s, a->rn, 1);
+    unsigned int bitsize = a->sf ? 64 : 32;
+    unsigned int ri = a->immr;
+    unsigned int si = a->imms;
+    unsigned int pos, len;
+
+    tcg_rd = cpu_reg(s, a->rd);
+    tcg_tmp = read_cpu_reg(s, a->rn, 1);
+
+    if (si >= ri) {
+        /* Wd<s-r:0> = Wn<s:r> */
         tcg_gen_shri_i64(tcg_tmp, tcg_tmp, ri);
+        len = (si - ri) + 1;
         pos = 0;
     } else {
-        /* Handle the ri > si case with a deposit
-         * Wd<32+s-r,32-r> = Wn<s:0>
-         */
+        /* Wd<32+s-r,32-r> = Wn<s:0> */
         len = si + 1;
         pos = (bitsize - ri) & (bitsize - 1);
     }
 
-    if (opc == 0 && len < ri) {
-        /* SBFM: sign extend the destination field from len to fill
-           the balance of the word.  Let the deposit below insert all
-           of those sign bits.  */
-        tcg_gen_sextract_i64(tcg_tmp, tcg_tmp, 0, len);
-        len = ri;
-    }
-
-    if (opc == 1) { /* BFM, BFXIL */
-        tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_tmp, pos, len);
-    } else {
-        /* SBFM or UBFM: We start with zero, and we haven't modified
-           any bits outside bitsize, therefore the zero-extension
-           below is unneeded.  */
-        tcg_gen_deposit_z_i64(tcg_rd, tcg_tmp, pos, len);
-        return;
-    }
-
- done:
-    if (!sf) { /* zero extend final result */
+    tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_tmp, pos, len);
+    if (!a->sf) {
         tcg_gen_ext32u_i64(tcg_rd, tcg_rd);
     }
+    return true;
 }
 
 /* Extract
@@ -4573,9 +4594,6 @@ static void disas_extract(DisasContext *s, uint32_t insn)
 static void disas_data_proc_imm(DisasContext *s, uint32_t insn)
 {
     switch (extract32(insn, 23, 6)) {
-    case 0x26: /* Bitfield */
-        disas_bitfield(s, insn);
-        break;
     case 0x27: /* Extract */
         disas_extract(s, insn);
         break;
-- 
2.34.1


