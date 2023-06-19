Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A7C735989
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:30:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFtH-0000gr-O9; Mon, 19 Jun 2023 10:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsj-0000aS-7w
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:25 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsh-0002CR-2e
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:24 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f90a7325f6so21930995e9.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184962; x=1689776962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6KI6vCKi2hK4kMqI/ACVjSnqVa1PBuwOd1A7QPwu8LI=;
 b=LZqizN8MxVRIs/7oLKNo6z9x/tnIHBaf1x4J1oLjNLHIb5hYH4l8OKZQZttgxbH+O+
 ucEkJ8b1bxEByWxLj3YuIAjvI1hcycl5NmSwrNw9d3zYxl2/RyhK8r/RMBkownA0S1jc
 jW159SHKsv6T4uL3C1UcuvjolITsh5eaFTOS0GdPuv6JekO+atLT+7fqaZOGOj2QdY9d
 DGsMrnKLs4wWL2C8mVgbHLf8T5xkh1qFMkgN/3ms7h+/+O0vxi6zL4XIiJsOxHVNloRc
 /Vx959zAbA56H+qeSCcZsrwuIcs9MNbIgi3KmDMtaJh6rjZJKiZ4BGHrXU5Lhdr6ovQ/
 DMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184962; x=1689776962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6KI6vCKi2hK4kMqI/ACVjSnqVa1PBuwOd1A7QPwu8LI=;
 b=dksOEQfll7u611MexoF9jbVgL2QInm/6XUwi/mS8p2KPom0tUDttku5bwRkWZwCjYr
 87g+7zzqQUI926jrb5ZQGnN869u6M9qY9fm3Y+pk8ccNIQ9QvANtRrng9Shab06p0wnn
 IXc/g3YWK5EJpzhb1fUEVkA6WT1gy5BF2OMkkzy44DjfzPlsgN9EgfnpgJz73zDpZnvc
 IeriUEzXiez+Gs7uPFux5YLRaf6CZbUmEXEUu0xkgcM0+UIzONclR3yo7FNwSBm6eMUr
 Azm2fKzQtrwN04rRLXP3hWuT/f2B40UWcThydgM4DJEkSrK5wWqZj+B38Ke56uhSHxbK
 eFZg==
X-Gm-Message-State: AC+VfDzC1iLMeQqdaipxhXL5uwBqenLbFKp0M+29VVLAkOcE+Z6LB+3l
 C2VWlTY4KHpQYjd7/Jtfj+6TNg9/TEKuNwTUQLc=
X-Google-Smtp-Source: ACHHUZ43bHP+gzBvWjJjbWzq8A34vhVEN33CMlPTiFPQpUpwlychPcOUAVwvEv8cwQDL14+dhrRz8Q==
X-Received: by 2002:a7b:ce14:0:b0:3f9:7a15:1716 with SMTP id
 m20-20020a7bce14000000b003f97a151716mr3627068wmc.5.1687184961821; 
 Mon, 19 Jun 2023 07:29:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a05600c224200b003f9b53959a4sm429012wmm.43.2023.06.19.07.29.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:29:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/33] target/arm: Convert LDXP, STXP, CASP, CAS to decodetree
Date: Mon, 19 Jun 2023 15:28:53 +0100
Message-Id: <20230619142914.963184-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142914.963184-1-peter.maydell@linaro.org>
References: <20230619142914.963184-1-peter.maydell@linaro.org>
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

Convert the load/store exclusive pair (LDXP, STXP, LDAXP, STLXP),
compare-and-swap pair (CASP, CASPA, CASPAL, CASPL), and compare-and
swap (CAS, CASA, CASAL, CASL) instructions to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230602155223.2040685-10-peter.maydell@linaro.org
---
 target/arm/tcg/a64.decode      |  11 +++
 target/arm/tcg/translate-a64.c | 121 ++++++++++++---------------------
 2 files changed, 53 insertions(+), 79 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index c5894fc06d2..6b1079b8bdf 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -237,7 +237,18 @@ HLT             1101 0100 010 ................ 000 00 @i16
 &stlr           rn rt sz lasr
 @stxr           sz:2 ...... ... rs:5 lasr:1 rt2:5 rn:5 rt:5 &stxr
 @stlr           sz:2 ...... ... ..... lasr:1 ..... rn:5 rt:5 &stlr
+%imm1_30_p2 30:1 !function=plus_2
+@stxp           .. ...... ... rs:5 lasr:1 rt2:5 rn:5 rt:5 &stxr sz=%imm1_30_p2
 STXR            .. 001000 000 ..... . ..... ..... ..... @stxr  # inc STLXR
 LDXR            .. 001000 010 ..... . ..... ..... ..... @stxr  # inc LDAXR
 STLR            .. 001000 100 11111 . 11111 ..... ..... @stlr  # inc STLLR
 LDAR            .. 001000 110 11111 . 11111 ..... ..... @stlr  # inc LDLAR
+
+STXP            1 . 001000 001 ..... . ..... ..... ..... @stxp # inc STLXP
+LDXP            1 . 001000 011 ..... . ..... ..... ..... @stxp # inc LDAXP
+
+# CASP, CASPA, CASPAL, CASPL (we don't decode the bits that determine
+# acquire/release semantics because QEMU's cmpxchg always has those)
+CASP            0 . 001000 0 - 1 rs:5 - 11111 rn:5 rt:5 sz=%imm1_30_p2
+# CAS, CASA, CASAL, CASL
+CAS             sz:2 001000 1 - 1 rs:5 - 11111 rn:5 rt:5
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1ba2d6a75e4..ff4338ee4df 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2741,84 +2741,50 @@ static bool trans_LDAR(DisasContext *s, arg_stlr *a)
     return true;
 }
 
-/* Load/store exclusive
- *
- *  31 30 29         24  23  22   21  20  16  15  14   10 9    5 4    0
- * +-----+-------------+----+---+----+------+----+-------+------+------+
- * | sz  | 0 0 1 0 0 0 | o2 | L | o1 |  Rs  | o0 |  Rt2  |  Rn  | Rt   |
- * +-----+-------------+----+---+----+------+----+-------+------+------+
- *
- *  sz: 00 -> 8 bit, 01 -> 16 bit, 10 -> 32 bit, 11 -> 64 bit
- *   L: 0 -> store, 1 -> load
- *  o2: 0 -> exclusive, 1 -> not
- *  o1: 0 -> single register, 1 -> register pair
- *  o0: 1 -> load-acquire/store-release, 0 -> not
- */
-static void disas_ldst_excl(DisasContext *s, uint32_t insn)
+static bool trans_STXP(DisasContext *s, arg_stxr *a)
 {
-    int rt = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int rt2 = extract32(insn, 10, 5);
-    int rs = extract32(insn, 16, 5);
-    int is_lasr = extract32(insn, 15, 1);
-    int o2_L_o1_o0 = extract32(insn, 21, 3) * 2 | is_lasr;
-    int size = extract32(insn, 30, 2);
-
-    switch (o2_L_o1_o0) {
-    case 0x2: case 0x3: /* CASP / STXP */
-        if (size & 2) { /* STXP / STLXP */
-            if (rn == 31) {
-                gen_check_sp_alignment(s);
-            }
-            if (is_lasr) {
-                tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
-            }
-            gen_store_exclusive(s, rs, rt, rt2, rn, size, true);
-            return;
-        }
-        if (rt2 == 31
-            && ((rt | rs) & 1) == 0
-            && dc_isar_feature(aa64_atomics, s)) {
-            /* CASP / CASPL */
-            gen_compare_and_swap_pair(s, rs, rt, rn, size | 2);
-            return;
-        }
-        break;
-
-    case 0x6: case 0x7: /* CASPA / LDXP */
-        if (size & 2) { /* LDXP / LDAXP */
-            if (rn == 31) {
-                gen_check_sp_alignment(s);
-            }
-            gen_load_exclusive(s, rt, rt2, rn, size, true);
-            if (is_lasr) {
-                tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
-            }
-            return;
-        }
-        if (rt2 == 31
-            && ((rt | rs) & 1) == 0
-            && dc_isar_feature(aa64_atomics, s)) {
-            /* CASPA / CASPAL */
-            gen_compare_and_swap_pair(s, rs, rt, rn, size | 2);
-            return;
-        }
-        break;
-
-    case 0xa: /* CAS */
-    case 0xb: /* CASL */
-    case 0xe: /* CASA */
-    case 0xf: /* CASAL */
-        if (rt2 == 31 && dc_isar_feature(aa64_atomics, s)) {
-            gen_compare_and_swap(s, rs, rt, rn, size);
-            return;
-        }
-        break;
-    default:
-        /* Handled in decodetree */
-        break;
+    if (a->rn == 31) {
+        gen_check_sp_alignment(s);
     }
-    unallocated_encoding(s);
+    if (a->lasr) {
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+    }
+    gen_store_exclusive(s, a->rs, a->rt, a->rt2, a->rn, a->sz, true);
+    return true;
+}
+
+static bool trans_LDXP(DisasContext *s, arg_stxr *a)
+{
+    if (a->rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+    gen_load_exclusive(s, a->rt, a->rt2, a->rn, a->sz, true);
+    if (a->lasr) {
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+    }
+    return true;
+}
+
+static bool trans_CASP(DisasContext *s, arg_CASP *a)
+{
+    if (!dc_isar_feature(aa64_atomics, s)) {
+        return false;
+    }
+    if (((a->rt | a->rs) & 1) != 0) {
+        return false;
+    }
+
+    gen_compare_and_swap_pair(s, a->rs, a->rt, a->rn, a->sz);
+    return true;
+}
+
+static bool trans_CAS(DisasContext *s, arg_CAS *a)
+{
+    if (!dc_isar_feature(aa64_atomics, s)) {
+        return false;
+    }
+    gen_compare_and_swap(s, a->rs, a->rt, a->rn, a->sz);
+    return true;
 }
 
 /*
@@ -4247,9 +4213,6 @@ static void disas_ldst_tag(DisasContext *s, uint32_t insn)
 static void disas_ldst(DisasContext *s, uint32_t insn)
 {
     switch (extract32(insn, 24, 6)) {
-    case 0x08: /* Load/store exclusive */
-        disas_ldst_excl(s, insn);
-        break;
     case 0x18: case 0x1c: /* Load register (literal) */
         disas_ld_lit(s, insn);
         break;
-- 
2.34.1


