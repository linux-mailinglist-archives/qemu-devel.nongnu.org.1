Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E40720699
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 17:54:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q574w-0003Cu-FH; Fri, 02 Jun 2023 11:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574t-0003BC-SJ
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:35 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q574p-0003SQ-EY
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 11:52:35 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f68fc6b479so21648775e9.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 08:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685721150; x=1688313150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WkGtrZrBF/XjQ2tvFCNg0zZgeoFtvEXOEGm+spnCLHk=;
 b=lvf+mFUr6f05s9zZSt4V4A9fnyvGr2ddqurMH2od39kljSjg7tZnlR+zG8R4wICQhD
 J5W6LFd49wlkaWGtmubMemgV0jFO2PZjBD8GDYJ5HviA4Z74CY6NC4izIMbH4Bbb4Whh
 9Ef5IewoD6VWMkYOH1eVI0IpSVJoUOl5fSq+RIIDgxGeD0J7Jag+VIizAgzsPpLboG+j
 PgcVoWGKEYwGc5S2u68FtA8GaPaEYHRfZt85Oa0k8Jiuq6X7RD6edRSnG546dUWbDM1P
 aZtlb+Aq64IFBp2a2VGTHbbDFjp8PNYC/Z4RXv31HMr+IvLWjo04px1M2NkEVawRtp4W
 OijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685721150; x=1688313150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WkGtrZrBF/XjQ2tvFCNg0zZgeoFtvEXOEGm+spnCLHk=;
 b=O9pPzATSc5RcjA/LNsgQ5sgH0m3o73maNczvMHljV5cVyPiqpkjZerRHVm/nQt0uCr
 7CUuMGXBZm7ByBkFUYYax8v1R63K9GbDAidQcj+dqu8/0sQRpMOOz1ggfXuoscgw7zuG
 ue09kUMgAI/UTBhrOvavs2QOkcXQGqW1Hsnw6Nv5e3fm9017dU8nqQrm1V6w94oJHEci
 uvCP7f3kbBAHeKPpm3rNfDK0fEdtuiYrmlOpFSvbHf+1Ri1ZdOvXYWmoPZZsrZQwBwTk
 QlvHYEAq3nuql7zLxOCm4m3g6kfNQOOOAsdaVo0Xl9oqfrxtRZe0Y9QRH+WJChWfSKYY
 bw8g==
X-Gm-Message-State: AC+VfDxW208UupLoTIXUUgpsBMCF6Nj2AUz6URoBx+W4j5m1dduU2rxt
 7D599pAqN2tf3PbGc3wtFnooIw==
X-Google-Smtp-Source: ACHHUZ7zHDuZp2Qp9GyNiO/LJwYq6jwVn1LdtUyKLbjvmLG5zkDRZAINwGow4QUvJXgy3Gl365xfnQ==
X-Received: by 2002:a05:600c:22c7:b0:3f6:e13:b266 with SMTP id
 7-20020a05600c22c700b003f60e13b266mr2390564wmg.13.1685721149998; 
 Fri, 02 Jun 2023 08:52:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v7-20020a05600c214700b003f72a15301csm594952wml.2.2023.06.02.08.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 08:52:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 08/20] target/arm: Convert load/store exclusive and ordered to
 decodetree
Date: Fri,  2 Jun 2023 16:52:11 +0100
Message-Id: <20230602155223.2040685-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230602155223.2040685-1-peter.maydell@linaro.org>
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
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
---
 target/arm/tcg/a64.decode      |  11 +++
 target/arm/tcg/translate-a64.c | 164 ++++++++++++++++++++-------------
 2 files changed, 110 insertions(+), 65 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index aba27047b56..b9b32490cef 100644
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
index 94410f6ece5..2a5c4eea02f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2560,6 +2560,102 @@ static bool disas_ldst_compute_iss_sf(int size, bool is_signed, int opc)
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
+    TCGv_i64 clean_addr;
+
+    if (a->rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+    if (a->lasr) {
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
+    }
+    clean_addr = gen_mte_check1(s, cpu_reg_sp(s, a->rn),
+                                true, a->rn != 31, a->sz);
+    gen_store_exclusive(s, a->rs, a->rt, a->rt2, clean_addr, a->sz, false);
+    return true;
+}
+
+static bool trans_LDXR(DisasContext *s, arg_stxr *a)
+{
+    TCGv_i64 clean_addr;
+
+    if (a->rn == 31) {
+        gen_check_sp_alignment(s);
+    }
+    clean_addr = gen_mte_check1(s, cpu_reg_sp(s, a->rn),
+                                false, a->rn != 31, a->sz);
+    s->is_ldex = true;
+    gen_load_exclusive(s, a->rt, a->rt2, clean_addr, a->sz, false);
+    if (a->lasr) {
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+    }
+    return true;
+}
+
+static bool trans_STLR(DisasContext *s, arg_stlr *a)
+{
+    TCGv_i64 clean_addr;
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
+    clean_addr = gen_mte_check1(s, cpu_reg_sp(s, a->rn),
+                                true, a->rn != 31, a->sz);
+    /* TODO: ARMv8.4-LSE SCTLR.nAA */
+    do_gpr_st(s, cpu_reg(s, a->rt), clean_addr, a->sz | MO_ALIGN, true, a->rt,
+              iss_sf, a->lasr);
+    return true;
+}
+
+static bool trans_LDAR(DisasContext *s, arg_stlr *a)
+{
+    TCGv_i64 clean_addr;
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
+    clean_addr = gen_mte_check1(s, cpu_reg_sp(s, a->rn),
+                                false, a->rn != 31, a->sz);
+    /* TODO: ARMv8.4-LSE SCTLR.nAA */
+    do_gpr_ld(s, cpu_reg(s, a->rt), clean_addr, a->sz | MO_ALIGN, false, true,
+              a->rt, iss_sf, a->lasr);
+    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
+    return true;
+}
+
 /* Load/store exclusive
  *
  *  31 30 29         24  23  22   21  20  16  15  14   10 9    5 4    0
@@ -2585,71 +2681,6 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
     TCGv_i64 clean_addr;
 
     switch (o2_L_o1_o0) {
-    case 0x0: /* STXR */
-    case 0x1: /* STLXR */
-        if (rn == 31) {
-            gen_check_sp_alignment(s);
-        }
-        if (is_lasr) {
-            tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
-        }
-        clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
-                                    true, rn != 31, size);
-        gen_store_exclusive(s, rs, rt, rt2, clean_addr, size, false);
-        return;
-
-    case 0x4: /* LDXR */
-    case 0x5: /* LDAXR */
-        if (rn == 31) {
-            gen_check_sp_alignment(s);
-        }
-        clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
-                                    false, rn != 31, size);
-        s->is_ldex = true;
-        gen_load_exclusive(s, rt, rt2, clean_addr, size, false);
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
-        clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
-                                    true, rn != 31, size);
-        /* TODO: ARMv8.4-LSE SCTLR.nAA */
-        do_gpr_st(s, cpu_reg(s, rt), clean_addr, size | MO_ALIGN, true, rt,
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
-        clean_addr = gen_mte_check1(s, cpu_reg_sp(s, rn),
-                                    false, rn != 31, size);
-        /* TODO: ARMv8.4-LSE SCTLR.nAA */
-        do_gpr_ld(s, cpu_reg(s, rt), clean_addr, size | MO_ALIGN, false, true,
-                  rt, disas_ldst_compute_iss_sf(size, false, 0), is_lasr);
-        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
-        return;
-
     case 0x2: case 0x3: /* CASP / STXP */
         if (size & 2) { /* STXP / STLXP */
             if (rn == 31) {
@@ -2704,6 +2735,9 @@ static void disas_ldst_excl(DisasContext *s, uint32_t insn)
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


