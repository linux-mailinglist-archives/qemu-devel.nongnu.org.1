Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C417A3193
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 19:14:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhYqU-0006xf-Lc; Sat, 16 Sep 2023 13:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhYqM-0006ww-Bu
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 13:12:30 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhYqJ-0000Q9-3Q
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 13:12:28 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-68fc292de9dso2299272b3a.0
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 10:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694884346; x=1695489146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BAF//SWs/GLPIw5LBlcWf1jMcdaNmd2+u/L+v9zWp7w=;
 b=lFteddp0h7aXjnNrzMAuOAckS3+pB1HzQJhSOi6StZ9m5FIXpyP1V7jnmo53qvWr7W
 bcfoMa1i85lsr0mw5ph0GDcRTneVUFFRIc04lgKfmEDRyXBYiGf2SbCoTmc30xqsK2/o
 ax0GgGABgRKhFHlo9PrYl9DPh3NT5drn3EjSVX7N+XBJWKG5TXPZzkN5dfK5dIJLFcoA
 SRddFDyr7Zf3pdAQceZxgPLjAPxWSwn4nTaZqKTRKQnDZCQir/ZDGhEP0PidadpUGz/Q
 nh0wvpphE/9W29T/8b9Gx44K7zeuieF925g8wovDlvNDdVmk4oXJLDTGV0iIT80ZjX/w
 wNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694884346; x=1695489146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BAF//SWs/GLPIw5LBlcWf1jMcdaNmd2+u/L+v9zWp7w=;
 b=oddJzMGrK66sY9XMHb63uORFSAv9Yvas76aZ3G+yeSX/o6F+3BaK9bI/0u0FthM608
 NeRLLnOkSMoukQxuHZaGa4YVl4Bf3Q1r9m/sPGm9T6i9pQo1c+G2Hz1nBBYNT2GtrZWU
 LtwhSK+5IdEwDxmHElCemJCdlt8eE9IJSUJR1O+cE94Icxq1Ad5bBo49vedK+OfRvuuV
 EdK/cMZeRIc/ahm/6FDsVcIqtWYM4Tg7aAVpO43Oeq8cms97ZourgFKYUCo2QUPr/6ex
 I++LnCcAsFfwtj1Xz8FwxR/9pjSz5ZnFNKw9BISzzHaU5YAx0qgBNvTvhGtthCFZs3Jb
 Ay9g==
X-Gm-Message-State: AOJu0Yx+WTF2FJxeZAejcbgPBaawFf///qYpFCw/3bYei2iE87PvOLQt
 DeOswHfnSGdmEW0MddftLJ6u9KaUV+UF9vt8Oys=
X-Google-Smtp-Source: AGHT+IHDrjbHt0Jo7S4B20z26lowzkEp4kwh7n6icM3+Ci7yTPsbinQZahTemwe3YYSnn523I57IgQ==
X-Received: by 2002:a05:6a00:1f97:b0:68f:cbd3:5b01 with SMTP id
 bg23-20020a056a001f9700b0068fcbd35b01mr8882526pfb.13.1694884345659; 
 Sat, 16 Sep 2023 10:12:25 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 i14-20020aa78d8e000000b00689f8dc26c2sm4706705pfr.133.2023.09.16.10.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 10:12:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiajie Chen <c@jia.je>
Subject: [PULL v2 21/39] tcg/loongarch64: Implement 128-bit load & store
Date: Sat, 16 Sep 2023 10:12:23 -0700
Message-Id: <20230916171223.521545-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916171223.521545-1-richard.henderson@linaro.org>
References: <20230916171223.521545-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

From: Jiajie Chen <c@jia.je>

If LSX is available, use LSX instructions to implement 128-bit load &
store when MO_128 is required, otherwise use two 64-bit loads & stores.

Signed-off-by: Jiajie Chen <c@jia.je>
Message-Id: <20230908022302.180442-17-c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target-con-set.h |  2 +
 tcg/loongarch64/tcg-target.h         |  2 +-
 tcg/loongarch64/tcg-target.c.inc     | 59 ++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
index 914572d21b..77d62e38e7 100644
--- a/tcg/loongarch64/tcg-target-con-set.h
+++ b/tcg/loongarch64/tcg-target-con-set.h
@@ -18,6 +18,7 @@ C_O0_I1(r)
 C_O0_I2(rZ, r)
 C_O0_I2(rZ, rZ)
 C_O0_I2(w, r)
+C_O0_I3(r, r, r)
 C_O1_I1(r, r)
 C_O1_I1(w, r)
 C_O1_I1(w, w)
@@ -37,3 +38,4 @@ C_O1_I2(w, w, wM)
 C_O1_I2(w, w, wA)
 C_O1_I3(w, w, w, w)
 C_O1_I4(r, rZ, rJ, rZ, rZ)
+C_O2_I1(r, r, r)
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 67b0a95532..03017672f6 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -171,7 +171,7 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_muluh_i64        1
 #define TCG_TARGET_HAS_mulsh_i64        1
 
-#define TCG_TARGET_HAS_qemu_ldst_i128   0
+#define TCG_TARGET_HAS_qemu_ldst_i128   use_lsx_instructions
 
 #define TCG_TARGET_HAS_v64              0
 #define TCG_TARGET_HAS_v128             use_lsx_instructions
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 82901d678a..fde744e766 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1081,6 +1081,48 @@ static void tcg_out_qemu_st(TCGContext *s, TCGReg data_reg, TCGReg addr_reg,
     }
 }
 
+static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg data_lo, TCGReg data_hi,
+                                   TCGReg addr_reg, MemOpIdx oi, bool is_ld)
+{
+    TCGLabelQemuLdst *ldst;
+    HostAddress h;
+
+    ldst = prepare_host_addr(s, &h, addr_reg, oi, is_ld);
+
+    if (h.aa.atom == MO_128) {
+        /*
+         * Use VLDX/VSTX when 128-bit atomicity is required.
+         * If address is aligned to 16-bytes, the 128-bit load/store is atomic.
+         */
+        if (is_ld) {
+            tcg_out_opc_vldx(s, TCG_VEC_TMP0, h.base, h.index);
+            tcg_out_opc_vpickve2gr_d(s, data_lo, TCG_VEC_TMP0, 0);
+            tcg_out_opc_vpickve2gr_d(s, data_hi, TCG_VEC_TMP0, 1);
+        } else {
+            tcg_out_opc_vinsgr2vr_d(s, TCG_VEC_TMP0, data_lo, 0);
+            tcg_out_opc_vinsgr2vr_d(s, TCG_VEC_TMP0, data_hi, 1);
+            tcg_out_opc_vstx(s, TCG_VEC_TMP0, h.base, h.index);
+        }
+    } else {
+        /* Otherwise use a pair of LD/ST. */
+        tcg_out_opc_add_d(s, TCG_REG_TMP0, h.base, h.index);
+        if (is_ld) {
+            tcg_out_opc_ld_d(s, data_lo, TCG_REG_TMP0, 0);
+            tcg_out_opc_ld_d(s, data_hi, TCG_REG_TMP0, 8);
+        } else {
+            tcg_out_opc_st_d(s, data_lo, TCG_REG_TMP0, 0);
+            tcg_out_opc_st_d(s, data_hi, TCG_REG_TMP0, 8);
+        }
+    }
+
+    if (ldst) {
+        ldst->type = TCG_TYPE_I128;
+        ldst->datalo_reg = data_lo;
+        ldst->datahi_reg = data_hi;
+        ldst->raddr = tcg_splitwx_to_rx(s->code_ptr);
+    }
+}
+
 /*
  * Entry-points
  */
@@ -1145,6 +1187,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     TCGArg a0 = args[0];
     TCGArg a1 = args[1];
     TCGArg a2 = args[2];
+    TCGArg a3 = args[3];
     int c2 = const_args[2];
 
     switch (opc) {
@@ -1507,6 +1550,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_qemu_ld_a64_i64:
         tcg_out_qemu_ld(s, a0, a1, a2, TCG_TYPE_I64);
         break;
+    case INDEX_op_qemu_ld_a32_i128:
+    case INDEX_op_qemu_ld_a64_i128:
+        tcg_out_qemu_ldst_i128(s, a0, a1, a2, a3, true);
+        break;
     case INDEX_op_qemu_st_a32_i32:
     case INDEX_op_qemu_st_a64_i32:
         tcg_out_qemu_st(s, a0, a1, a2, TCG_TYPE_I32);
@@ -1515,6 +1562,10 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_qemu_st_a64_i64:
         tcg_out_qemu_st(s, a0, a1, a2, TCG_TYPE_I64);
         break;
+    case INDEX_op_qemu_st_a32_i128:
+    case INDEX_op_qemu_st_a64_i128:
+        tcg_out_qemu_ldst_i128(s, a0, a1, a2, a3, false);
+        break;
 
     case INDEX_op_mov_i32:  /* Always emitted via tcg_out_mov.  */
     case INDEX_op_mov_i64:
@@ -1996,6 +2047,14 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_qemu_st_a64_i64:
         return C_O0_I2(rZ, r);
 
+    case INDEX_op_qemu_ld_a32_i128:
+    case INDEX_op_qemu_ld_a64_i128:
+        return C_O2_I1(r, r, r);
+
+    case INDEX_op_qemu_st_a32_i128:
+    case INDEX_op_qemu_st_a64_i128:
+        return C_O0_I3(r, r, r);
+
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
         return C_O0_I2(rZ, rZ);
-- 
2.34.1


