Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E21A672B2B7
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 18:03:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8NVd-0006Tt-PU; Sun, 11 Jun 2023 12:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUj-0005r4-Jn
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:00:50 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q8NUf-0000T7-IP
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 12:00:45 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-30c55d2b9f3so2247158f8f.2
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 09:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686499240; x=1689091240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SdGx08aoksaLp21YxsKPPHNcMRVUjRR75hXQYQOrgY4=;
 b=YOour/a+FPdkh8tOB4eNA5N8M21lsK3pynHJQlbYnyyUNF8VukyYld1chuEbl4XgcD
 o3lV4x+CvIkNXGNf/oX2XobxmXDcQLrkrK7TW/94uoEkUrc57+Jw0y/LzsIrIkUgfO+e
 BzdL4zEn0FJgav3tsELGatLDBIGlLz+HfMG0LmMc5Gz1tMxR8g0Nyxoidk3x4xDBL+P/
 iH+8Jyv3sxet1WPY3UXGsO9tsGLNtxjRQFqwMqZwrW26DotcVbM41V0eXPnBbZkXhIYu
 rcF5elCprmkF7zDadHW6I4M1pKPumC2i0O+3NzV0G+Ren9LDcnkyTphkz4vYBEgVXd1M
 U5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686499240; x=1689091240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SdGx08aoksaLp21YxsKPPHNcMRVUjRR75hXQYQOrgY4=;
 b=Hv9nZL1d4FqRxYn0tUd6f5b1ceVKMVsf+tOKYzrwtGluZ0ehXV/jMtkKFN1zOLrFsA
 oYcjcI3rTT0XuaicslIFQ08cRwpZQjVHeMUX5lJ/ZriGNuFPBAIi7VLPESrlJaa3kMtb
 7EmnEgIOP/Yh6YeR9drXjSPgx8UXh1dzQzJAYoWDE0lA7mQGcVpDRJ3KP3ieS8Ic63dR
 bm2Csd9IOHOA88UU3DCZHGrlhfH3VkiNth5QzfTpXhoUIx1SHFnqVeUBRez1YMT67QpC
 N6GjZUp0f4qulJ7+BVZYoUMxpFErNi1/P2xfL+B3D7PdTztZRjoiHcCr++7YLP9nXltn
 /vFg==
X-Gm-Message-State: AC+VfDyecsI9/ayonwUs32ijceRnw4tR5rVyI+z7Z6T+ftnP6F0CKFTk
 2zEkkqmk9sYUOHBAFRAtMw0lEQ==
X-Google-Smtp-Source: ACHHUZ78A1hrsPWPkWScIJ2j+eJWJwSBxb3D6tfEDclu/rE1gav1IGr4DUC6dFf/bsjgFYr4I92/1A==
X-Received: by 2002:adf:e8d0:0:b0:309:31ac:6663 with SMTP id
 k16-20020adfe8d0000000b0030931ac6663mr2852103wrn.16.1686499239782; 
 Sun, 11 Jun 2023 09:00:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a056000008900b0030ae499da59sm9923022wrx.111.2023.06.11.09.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Jun 2023 09:00:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 11/23] target/arm: Convert load/store exclusive and ordered
 to decodetree
Date: Sun, 11 Jun 2023 17:00:20 +0100
Message-Id: <20230611160032.274823-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230611160032.274823-1-peter.maydell@linaro.org>
References: <20230611160032.274823-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Convert the instructions in the load/store exclusive (STXR,
STLXR, LDXR, LDAXR) and load/store ordered (STLR, STLLR,
LDAR, LDLAR) to decodetree.

Note that for STLR, STLLR, LDAR, LDLAR this fixes an under-decoding
in the legacy decoder where we were not checking that the RES1 bits
in the Rs and Rt2 fields were set.

The new function ldst_iss_sf() is equivalent to the existing
disas_ldst_compute_iss_sf(), but it takes the pre-decoded 'ext' field
rather than taking an undecoded two-bit opc field and extracting
'ext' from it. Once all the loads and stores have been converted
to decodetree disas_ldst_compute_iss_sf() will be unused and
can be deleted.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230602155223.2040685-9-peter.maydell@linaro.org
---
 target/arm/tcg/a64.decode      |  11 +++
 target/arm/tcg/translate-a64.c | 154 ++++++++++++++++++++-------------
 2 files changed, 103 insertions(+), 62 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index eeaca08ae83..c5894fc06d2 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -230,3 +230,14 @@ HLT             1101 0100 010 ................ 000 00 @i16
 # DCPS1         1101 0100 101 ................ 000 01 @i16
 # DCPS2         1101 0100 101 ................ 000 10 @i16
 # DCPS3         1101 0100 101 ................ 000 11 @i16
+
+# Loads and stores
+
+&stxr           rn rt rt2 rs sz lasr
+&stlr           rn rt sz lasr
+@stxr           sz:2 ...... ... rs:5 lasr:1 rt2:5 rn:5 rt:5 &stxr
+@stlr           sz:2 ...... ... ..... lasr:1 ..... rn:5 rt:5 &stlr
+STXR            .. 001000 000 ..... . ..... ..... ..... @stxr  # inc STLXR
+LDXR            .. 001000 010 ..... . ..... ..... ..... @stxr  # inc LDAXR
+STLR            .. 001000 100 11111 . 11111 ..... ..... @stlr  # inc STLLR
+LDAR            .. 001000 110 11111 . 11111 ..... ..... @stlr  # inc LDLAR
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index a2a71b4062f..1ba2d6a75e4 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2652,6 +2652,95 @@ static bool disas_ldst_compute_iss_sf(int size, bool is_signed, int opc)
     return regsize == 64;
 }
 
+static bool ldst_iss_sf(int size, bool sign, bool ext)
+{
+
+    if (sign) {
+        /*
+         * Signed loads are 64 bit results if we are not going to
+         * do a zero-extend from 32 to 64 after the load.
+         * (For a store, sign and ext are always false.)
+         */
+        return !ext;
+    } else {
+        /* Unsigned loads/stores work at the specified size */
+        return size == MO_64;
+    }
+}
+
+static bool trans_STXR(DisasContext *s, arg_stxr *a)
+{
+    if (a->rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+    if (a->lasr) {
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+    }
+    gen_store_exclusive(s, a->rs, a->rt, a->rt2, a->rn, a->sz, false);
+    return true;
+}
+
+static bool trans_LDXR(DisasContext *s, arg_stxr *a)
+{
+    if (a->rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+    gen_load_exclusive(s, a->rt, a->rt2, a->rn, a->sz, false);
+    if (a->lasr) {
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+    }
+    return true;
+}
+
+static bool trans_STLR(DisasContext *s, arg_stlr *a)
+{
+    TCGv_i64 clean_addr;
+    MemOp memop;
+    bool iss_sf = ldst_iss_sf(a->sz, false, false);
+
+    /*
+     * StoreLORelease is the same as Store-Release for QEMU, but
+     * needs the feature-test.
+     */
+    if (!a->lasr && !dc_isar_feature(aa64_lor, s)) {
+        return false;
+    }
+    /* Generate ISS for non-exclusive accesses including LASR.  */
+    if (a->rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+    memop = check_ordered_align(s, a->rn, 0, true, a->sz);
+    clean_addr = gen_mte_check1(s, cpu_reg_sp(s, a->rn),
+                                true, a->rn != 31, memop);
+    do_gpr_st(s, cpu_reg(s, a->rt), clean_addr, memop, true, a->rt,
+              iss_sf, a->lasr);
+    return true;
+}
+
+static bool trans_LDAR(DisasContext *s, arg_stlr *a)
+{
+    TCGv_i64 clean_addr;
+    MemOp memop;
+    bool iss_sf = ldst_iss_sf(a->sz, false, false);
+
+    /* LoadLOAcquire is the same as Load-Acquire for QEMU.  */
+    if (!a->lasr && !dc_isar_feature(aa64_lor, s)) {
+        return false;
+    }
+    /* Generate ISS for non-exclusive accesses including LASR.  */
+    if (a->rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+    memop = check_ordered_align(s, a->rn, 0, false, a->sz);
+    clean_addr = gen_mte_check1(s, cpu_reg_sp(s, a->rn),
+                                false, a->rn != 31, memop);
+    do_gpr_ld(s, cpu_reg(s, a->rt), clean_addr, memop, false, true,
+              a->rt, iss_sf, a->lasr);
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+    return true;
+}
+
 /* Load/store exclusive
  *
  *  31 30 29         24  23  22   21  20  16  15  14   10 9    5 4    0
@@ -2674,70 +2763,8 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
     int is_lasr = extract32(insn, 15, 1);
     int o2_L_o1_o0 = extract32(insn, 21, 3) * 2 | is_lasr;
     int size = extract32(insn, 30, 2);
-    TCGv_i64 clean_addr;
-    MemOp memop;
 
     switch (o2_L_o1_o0) {
-    case 0x0: /* STXR */
-    case 0x1: /* STLXR */
-        if (rn == 31) {
-            gen_check_sp_alignment(s);
-        }
-        if (is_lasr) {
-            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
-        }
-        gen_store_exclusive(s, rs, rt, rt2, rn, size, false);
-        return;
-
-    case 0x4: /* LDXR */
-    case 0x5: /* LDAXR */
-        if (rn == 31) {
-            gen_check_sp_alignment(s);
-        }
-        gen_load_exclusive(s, rt, rt2, rn, size, false);
-        if (is_lasr) {
-            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
-        }
-        return;
-
-    case 0x8: /* STLLR */
-        if (!dc_isar_feature(aa64_lor, s)) {
-            break;
-        }
-        /* StoreLORelease is the same as Store-Release for QEMU.  */
-        /* fall through */
-    case 0x9: /* STLR */
-        /* Generate ISS for non-exclusive accesses including LASR.  */
-        if (rn == 31) {
-            gen_check_sp_alignment(s);
-        }
-        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
-        memop = check_ordered_align(s, rn, 0, true, size);
-        clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
-                                    true, rn != 31, memop);
-        do_gpr_st(s, cpu_reg(s, rt), clean_addr, memop, true, rt,
-                  disas_ldst_compute_iss_sf(size, false, 0), is_lasr);
-        return;
-
-    case 0xc: /* LDLAR */
-        if (!dc_isar_feature(aa64_lor, s)) {
-            break;
-        }
-        /* LoadLOAcquire is the same as Load-Acquire for QEMU.  */
-        /* fall through */
-    case 0xd: /* LDAR */
-        /* Generate ISS for non-exclusive accesses including LASR.  */
-        if (rn == 31) {
-            gen_check_sp_alignment(s);
-        }
-        memop = check_ordered_align(s, rn, 0, false, size);
-        clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
-                                    false, rn != 31, memop);
-        do_gpr_ld(s, cpu_reg(s, rt), clean_addr, memop, false, true,
-                  rt, disas_ldst_compute_iss_sf(size, false, 0), is_lasr);
-        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
-        return;
-
     case 0x2: case 0x3: /* CASP / STXP */
         if (size & 2) { /* STXP / STLXP */
             if (rn == 31) {
@@ -2787,6 +2814,9 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
             return;
         }
         break;
+    default:
+        /* Handled in decodetree */
+        break;
     }
     unallocated_encoding(s);
 }
-- 
2.34.1


