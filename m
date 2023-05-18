Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D647081D8
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:53:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd6V-0004GT-Kh; Thu, 18 May 2023 08:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6L-0004Ak-PM
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:26 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6F-00081D-Di
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:23 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f41d087a84so8345155e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414275; x=1687006275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tOuL57rBampNeBJU0Jmsoiux96q2cJaOnFFC2DVYQQI=;
 b=N+5Xd4msNiabIWJ/z8lOfdGyKbCRvkMwYhxmnNCIXJLPFh92Tgss9/RC6qQslcFSxx
 JuCsqKDBtvY14BI8/BpbUn4c3yO+geFud1G0MQ/zULIiCZDjmn0G5oiBPxAJaSRd1eIx
 KewWq12HHQxww+zAV7MhAg9XMAM8DhIxaoyGMf4E6iXDOEBb0PKr1i68ZgYP6hAvFrB8
 NHlahzOkrYxOdEsg4FgodM5p4WGMwZcBg34UvT/K+2WP3Qnh9X7YFkueogf9XK56jJNR
 H7tpD/ZAPM38NelSEX7WQp0IuZXTwVeB8uwMi+ajwIZc40xArUErBVf9iZ/6cuhciXBy
 FzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414275; x=1687006275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tOuL57rBampNeBJU0Jmsoiux96q2cJaOnFFC2DVYQQI=;
 b=DF8TLo9qc72QvQMBytSU8m1lvLxJ3eIU1+650S6RDEuL+w5sbfSGZVVAVUoWaI4Oxl
 RoPB90DcYTQo9a/X967X7ej6LP38nQoTcgRSkuUnKVd0LT9+q12F6WDFrScqe069Lum0
 jPE7bSpHoMC8C4Jjrf3rwYJ30krBsmvo2ZKlcWpaG1XTEhOcfCyucm3rv8/6/2mw3ti9
 SfwsyIT2rGG/rFCewF0vdhaTcEz9j+WxBBq0MzHMXQLk6HMswfCKKjMvN/8JX3kF9SgY
 zFZK97tisUuvF1VJS2gWZcOPvKd/gSKhNdUnKQHRrdotpo1OSvnWdJjPABBJur3WMhJG
 JupA==
X-Gm-Message-State: AC+VfDwdAHEpy7B49XB8QbumeTdbke9N/GpN/v1fJsjMtWpHp3KT9o2N
 XfFX/zMxF7ux1pc0v+B0ukPg40rr+QbvpImIp00=
X-Google-Smtp-Source: ACHHUZ7II6I74sytrDZyW5c4ApztqUxQStsyW0GFGyWhuqXTqzO5PZuTECy3HT6Ha2onTHl9po/AWA==
X-Received: by 2002:a7b:cbc1:0:b0:3f1:731e:cdb1 with SMTP id
 n1-20020a7bcbc1000000b003f1731ecdb1mr1322645wmi.6.1684414275725; 
 Thu, 18 May 2023 05:51:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f42d2f4531sm5201321wmf.48.2023.05.18.05.51.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:51:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/29] target/arm: Convert Logical (immediate) to decodetree
Date: Thu, 18 May 2023 13:50:53 +0100
Message-Id: <20230518125107.146421-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518125107.146421-1-peter.maydell@linaro.org>
References: <20230518125107.146421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

Convert the ADD, ORR, EOR, ANDS (immediate) instructions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20230512144106.3608981-10-peter.maydell@linaro.org
[PMM: rebased]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      | 15 ++++++
 target/arm/tcg/translate-a64.c | 94 +++++++++++-----------------------
 2 files changed, 44 insertions(+), 65 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index ed03d9e1349..1933afa457b 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -56,3 +56,18 @@ SUBS_i          . 11 100010 1 ............ ..... .....  @addsub_imm12
 
 ADDG_i          1 00 100011 0 ...... 00 .... ..... ..... @addsub_imm_tag
 SUBG_i          1 10 100011 0 ...... 00 .... ..... ..... @addsub_imm_tag
+
+# Logical (immediate)
+
+&rri_log        rd rn sf dbm
+@logic_imm_64   1 .. ...... dbm:13 rn:5 rd:5            &rri_log sf=1
+@logic_imm_32   0 .. ...... 0 dbm:12 rn:5 rd:5          &rri_log sf=0
+
+AND_i           . 00 100100 . ...... ...... ..... ..... @logic_imm_64
+AND_i           . 00 100100 . ...... ...... ..... ..... @logic_imm_32
+ORR_i           . 01 100100 . ...... ...... ..... ..... @logic_imm_64
+ORR_i           . 01 100100 . ...... ...... ..... ..... @logic_imm_32
+EOR_i           . 10 100100 . ...... ...... ..... ..... @logic_imm_64
+EOR_i           . 10 100100 . ...... ...... ..... ..... @logic_imm_32
+ANDS_i          . 11 100100 . ...... ...... ..... ..... @logic_imm_64
+ANDS_i          . 11 100100 . ...... ...... ..... ..... @logic_imm_32
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index c744477d71a..4192f951d48 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -4288,7 +4288,12 @@ static uint64_t bitfield_replicate(uint64_t mask, unsigned int e)
     return mask;
 }
 
-/* Simplified variant of pseudocode DecodeBitMasks() for the case where we
+/*
+ * Logical (immediate)
+ */
+
+/*
+ * Simplified variant of pseudocode DecodeBitMasks() for the case where we
  * only require the wmask. Returns false if the imms/immr/immn are a reserved
  * value (ie should cause a guest UNDEF exception), and true if they are
  * valid, in which case the decoded bit pattern is written to result.
@@ -4354,78 +4359,40 @@ bool logic_imm_decode_wmask(uint64_t *result, unsigned int immn,
     return true;
 }
 
-/* Logical (immediate)
- *   31  30 29 28         23 22  21  16 15  10 9    5 4    0
- * +----+-----+-------------+---+------+------+------+------+
- * | sf | opc | 1 0 0 1 0 0 | N | immr | imms |  Rn  |  Rd  |
- * +----+-----+-------------+---+------+------+------+------+
- */
-static void disas_logic_imm(DisasContext *s, uint32_t insn)
+static bool gen_rri_log(DisasContext *s, arg_rri_log *a, bool set_cc,
+                        void (*fn)(TCGv_i64, TCGv_i64, int64_t))
 {
-    unsigned int sf, opc, is_n, immr, imms, rn, rd;
     TCGv_i64 tcg_rd, tcg_rn;
-    uint64_t wmask;
-    bool is_and = false;
+    uint64_t imm;
 
-    sf = extract32(insn, 31, 1);
-    opc = extract32(insn, 29, 2);
-    is_n = extract32(insn, 22, 1);
-    immr = extract32(insn, 16, 6);
-    imms = extract32(insn, 10, 6);
-    rn = extract32(insn, 5, 5);
-    rd = extract32(insn, 0, 5);
-
-    if (!sf && is_n) {
-        unallocated_encoding(s);
-        return;
+    /* Some immediate field values are reserved. */
+    if (!logic_imm_decode_wmask(&imm, extract32(a->dbm, 12, 1),
+                                extract32(a->dbm, 0, 6),
+                                extract32(a->dbm, 6, 6))) {
+        return false;
+    }
+    if (!a->sf) {
+        imm &= 0xffffffffull;
     }
 
-    if (opc == 0x3) { /* ANDS */
-        tcg_rd = cpu_reg(s, rd);
-    } else {
-        tcg_rd = cpu_reg_sp(s, rd);
-    }
-    tcg_rn = cpu_reg(s, rn);
+    tcg_rd = set_cc ? cpu_reg(s, a->rd) : cpu_reg_sp(s, a->rd);
+    tcg_rn = cpu_reg(s, a->rn);
 
-    if (!logic_imm_decode_wmask(&wmask, is_n, imms, immr)) {
-        /* some immediate field values are reserved */
-        unallocated_encoding(s);
-        return;
+    fn(tcg_rd, tcg_rn, imm);
+    if (set_cc) {
+        gen_logic_CC(a->sf, tcg_rd);
     }
-
-    if (!sf) {
-        wmask &= 0xffffffff;
-    }
-
-    switch (opc) {
-    case 0x3: /* ANDS */
-    case 0x0: /* AND */
-        tcg_gen_andi_i64(tcg_rd, tcg_rn, wmask);
-        is_and = true;
-        break;
-    case 0x1: /* ORR */
-        tcg_gen_ori_i64(tcg_rd, tcg_rn, wmask);
-        break;
-    case 0x2: /* EOR */
-        tcg_gen_xori_i64(tcg_rd, tcg_rn, wmask);
-        break;
-    default:
-        assert(FALSE); /* must handle all above */
-        break;
-    }
-
-    if (!sf && !is_and) {
-        /* zero extend final result; we know we can skip this for AND
-         * since the immediate had the high 32 bits clear.
-         */
+    if (!a->sf) {
         tcg_gen_ext32u_i64(tcg_rd, tcg_rd);
     }
-
-    if (opc == 3) { /* ANDS */
-        gen_logic_CC(sf, tcg_rd);
-    }
+    return true;
 }
 
+TRANS(AND_i, gen_rri_log, a, false, tcg_gen_andi_i64)
+TRANS(ORR_i, gen_rri_log, a, false, tcg_gen_ori_i64)
+TRANS(EOR_i, gen_rri_log, a, false, tcg_gen_xori_i64)
+TRANS(ANDS_i, gen_rri_log, a, true, tcg_gen_andi_i64)
+
 /*
  * Move wide (immediate)
  *
@@ -4618,9 +4585,6 @@ static void disas_extract(DisasContext *s, uint32_t insn)
 static void disas_data_proc_imm(DisasContext *s, uint32_t insn)
 {
     switch (extract32(insn, 23, 6)) {
-    case 0x24: /* Logical (immediate) */
-        disas_logic_imm(s, insn);
-        break;
     case 0x25: /* Move wide (immediate) */
         disas_movw_imm(s, insn);
         break;
-- 
2.34.1


