Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B19787D62B2
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:30:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYIe-0000IQ-1B; Wed, 25 Oct 2023 03:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIb-0000Gh-EP
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:29 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIZ-0004i3-NI
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:29 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c9e06f058bso4509215ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218846; x=1698823646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yWPKPMahOrl8l7/yORUc/X3LHhh1SjBoxvyFki6O+l8=;
 b=GQohXQoJsheUuqNxNDgOi9yA2WUth2djCkGI9c4BWpBqyuCAe0MRErE6wp7ZzA0Mgy
 jnz3cL/z/hnbUIe7v6w0sG1Xl9eyuwWC1AoKHTq9vYV9RMyPYIbXIL7L0/TcEsPqUhpB
 niV9/tdJU0mpd0ToW5cykQ1OiUqIn2XnRBjr+nI8hdQGMsZmvsHGhSFmfOoEFj7K1EPH
 PDLZ+grZurBOGPGf0aAkjk3GoboTC+6Y2NkQJiv5nH7jQZRiF/0Q7R9GEI/qltkwdJm6
 KP4lMBiS9Y+sfqwsyJjKZ6NvQafY0RsT5//gD2o2vyoeSAJq3p0uSnCvz2PTpTCY3mtS
 fKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218846; x=1698823646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yWPKPMahOrl8l7/yORUc/X3LHhh1SjBoxvyFki6O+l8=;
 b=uW/ZKnD+q3YDIkto9HeAlCmTj1+sevh3auKeG+VfvokYdDLSKQwxNaOqfymGQraKWc
 m0U1VOLazijRuq8UoYs6FU/yjogTYY2feDy28Qg/rGfogz1EDAj9kj1SCitCWDpxTVlV
 C1PXM02dHJ/fV3tO+z035c/dhWlSseBY8AIAwxKFyUi/zuDHl+Nr0di9LO2hOQCk3urW
 YFIJ1m7P5HBNtEH19TOAms5jOS+52AJFVLqyOlCHKK8xhyR2p4dTpFfYiufGcPBROy5d
 PPwwp1sGnfWsVZk3G+GzRWeVkUPdxY5cbLZ/jAPDtSkwmfu2g4+CPfGSWRq+VgZL9v0g
 Vj6g==
X-Gm-Message-State: AOJu0YwjR1d6kfhCvF2hu66sgUBLoKdmrgpLCrT4xj5YYxU/zhWHzCY+
 QtfsSvWOvWgGTMY96omV4TANcxV2p4HdRjxFKrs=
X-Google-Smtp-Source: AGHT+IGQeWXs3IKjTrZBoYWtjCOYd7Oo+Lr/PEtVzCbPCPL7nV27SglG9tFk79nVE8fL6klasmzo6g==
X-Received: by 2002:a17:902:da91:b0:1c6:de7:add9 with SMTP id
 j17-20020a170902da9100b001c60de7add9mr19073046plx.19.1698218846495; 
 Wed, 25 Oct 2023 00:27:26 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b06c106844sm8578661plb.151.2023.10.25.00.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:27:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 19/29] tcg/sparc64: Pass TCGCond to tcg_out_cmp
Date: Wed, 25 Oct 2023 00:26:57 -0700
Message-Id: <20231025072707.833943-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025072707.833943-1-richard.henderson@linaro.org>
References: <20231025072707.833943-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target.c.inc | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 13ad92b9b6..e958e3c242 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -645,7 +645,8 @@ static void tcg_out_bpcc(TCGContext *s, int scond, int flags, TCGLabel *l)
     tcg_out_bpcc0(s, scond, flags, off19);
 }
 
-static void tcg_out_cmp(TCGContext *s, TCGReg c1, int32_t c2, int c2const)
+static void tcg_out_cmp(TCGContext *s, TCGCond cond,
+                        TCGReg c1, int32_t c2, int c2const)
 {
     tcg_out_arithc(s, TCG_REG_G0, c1, c2, c2const, ARITH_SUBCC);
 }
@@ -653,7 +654,7 @@ static void tcg_out_cmp(TCGContext *s, TCGReg c1, int32_t c2, int c2const)
 static void tcg_out_brcond_i32(TCGContext *s, TCGCond cond, TCGReg arg1,
                                int32_t arg2, int const_arg2, TCGLabel *l)
 {
-    tcg_out_cmp(s, arg1, arg2, const_arg2);
+    tcg_out_cmp(s, cond, arg1, arg2, const_arg2);
     tcg_out_bpcc(s, tcg_cond_to_bcond[cond], BPCC_ICC | BPCC_PT, l);
     tcg_out_nop(s);
 }
@@ -670,7 +671,7 @@ static void tcg_out_movcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
                                 TCGReg c1, int32_t c2, int c2const,
                                 int32_t v1, int v1const)
 {
-    tcg_out_cmp(s, c1, c2, c2const);
+    tcg_out_cmp(s, cond, c1, c2, c2const);
     tcg_out_movcc(s, cond, MOVCC_ICC, ret, v1, v1const);
 }
 
@@ -690,7 +691,7 @@ static void tcg_out_brcond_i64(TCGContext *s, TCGCond cond, TCGReg arg1,
         tcg_out32(s, INSN_OP(0) | INSN_OP2(3) | BPR_PT | INSN_RS1(arg1)
                   | INSN_COND(rcond) | off16);
     } else {
-        tcg_out_cmp(s, arg1, arg2, const_arg2);
+        tcg_out_cmp(s, cond, arg1, arg2, const_arg2);
         tcg_out_bpcc(s, tcg_cond_to_bcond[cond], BPCC_XCC | BPCC_PT, l);
     }
     tcg_out_nop(s);
@@ -714,7 +715,7 @@ static void tcg_out_movcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
     if (c2 == 0 && rcond && (!v1const || check_fit_i32(v1, 10))) {
         tcg_out_movr(s, rcond, ret, c1, v1, v1const);
     } else {
-        tcg_out_cmp(s, c1, c2, c2const);
+        tcg_out_cmp(s, cond, c1, c2, c2const);
         tcg_out_movcc(s, cond, MOVCC_XCC, ret, v1, v1const);
     }
 }
@@ -758,13 +759,13 @@ static void tcg_out_setcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
         /* FALLTHRU */
 
     default:
-        tcg_out_cmp(s, c1, c2, c2const);
+        tcg_out_cmp(s, cond, c1, c2, c2const);
         tcg_out_movi_s13(s, ret, 0);
         tcg_out_movcc(s, cond, MOVCC_ICC, ret, neg ? -1 : 1, 1);
         return;
     }
 
-    tcg_out_cmp(s, c1, c2, c2const);
+    tcg_out_cmp(s, cond, c1, c2, c2const);
     if (cond == TCG_COND_LTU) {
         if (neg) {
             /* 0 - 0 - C = -C = (C ? -1 : 0) */
@@ -798,7 +799,7 @@ static void tcg_out_setcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
             c2 = c1, c2const = 0, c1 = TCG_REG_G0;
             /* FALLTHRU */
         case TCG_COND_LTU:
-            tcg_out_cmp(s, c1, c2, c2const);
+            tcg_out_cmp(s, cond, c1, c2, c2const);
             tcg_out_arith(s, ret, TCG_REG_G0, TCG_REG_G0, ARITH_ADDXC);
             return;
         default:
@@ -813,7 +814,7 @@ static void tcg_out_setcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
         tcg_out_movi_s13(s, ret, 0);
         tcg_out_movr(s, rcond, ret, c1, neg ? -1 : 1, 1);
     } else {
-        tcg_out_cmp(s, c1, c2, c2const);
+        tcg_out_cmp(s, cond, c1, c2, c2const);
         tcg_out_movi_s13(s, ret, 0);
         tcg_out_movcc(s, cond, MOVCC_XCC, ret, neg ? -1 : 1, 1);
     }
@@ -1101,7 +1102,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tcg_out_movi_s32(s, TCG_REG_T3, compare_mask);
         tcg_out_arith(s, TCG_REG_T3, addr_reg, TCG_REG_T3, ARITH_AND);
     }
-    tcg_out_cmp(s, TCG_REG_T2, TCG_REG_T3, 0);
+    tcg_out_cmp(s, TCG_COND_NE, TCG_REG_T2, TCG_REG_T3, 0);
 
     ldst = new_ldst_label(s);
     ldst->is_ld = is_ld;
-- 
2.34.1


