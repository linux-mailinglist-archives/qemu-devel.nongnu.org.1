Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 726267D7977
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:29:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2t-0007A5-Mz; Wed, 25 Oct 2023 20:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2o-000737-9F
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:14 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2h-0004rh-Ln
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:13 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ca052ec63bso2381745ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279363; x=1698884163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pWAF8Yy1Ybd5ENfcMHYAo9tgOERLXXMk37OKNqP6zdk=;
 b=G4K8gPGSkpMJ3HklLnruYNFKAXek6Aa4XwFjngdG1ctEkRum3UD+ozZl6w03TM+mHx
 ec7jM2lZIJRwzuUzGfLchOX1hwZ4dCslOcG5bZxJq9QcfMso+u75udlQmCVXBVqwshaw
 gIv2mD5vHyd8z9f/U3j+6KMm3l7v99e5pJTxRUGa3UO8uL6aFDcHTmVgtzWP2XpFApkp
 k9yeZnAkZPdlthsXGbzxQMTxvffieZQejqIs8AF9eCxRcLT4jILAiEcdRwq8U4+WwDKD
 fiSQJsIY4XQ1Aq5BvZEePIgoDJeJBy009v6RmVJ1qvm2zMuQswrqPJramLIcUQdAbPTt
 H/QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279363; x=1698884163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pWAF8Yy1Ybd5ENfcMHYAo9tgOERLXXMk37OKNqP6zdk=;
 b=IajFDYR8gaL1bcdeZ33p4fCt71WuEPsa0Bm5njF56EbE5jXOb5xyCfZJjn2UoA1xca
 X52BtVKpNFzpTX6hvtTQzd23apd4nAZR75760b1I2D5TU3HMxU2SeJF5i8UlEG7o4EfV
 ln1oxMwk93PbowmFJGBmLTJTFinc7iYet4fxaHaEA1xvAYmBichxHaspLFIJyEVvdu5g
 p9etr9os/66S/CR3bNXEhglUyDVpB/0khdXQfxNYeh6VapTv4ipaEtUiVuTmZAICxPDH
 gM54wFfGk0M1fbCNWzC/SkVDqybX/Ne+oWvhLqqtpCYolCKsxHQvRAYyu0ww63QdXsZw
 I9jA==
X-Gm-Message-State: AOJu0YwMxuKamU3O6UfwunE+BPXT9IpS0JUCXqknsNPYApY9GrLwjXok
 1fJsVJzAPUAoy37ptrV0Q5aYbRBnRvPPEpnOO+Q=
X-Google-Smtp-Source: AGHT+IFExYaWAzs3od3OHmCL4k0SEQEP7/m/48QqlzKgMOPraL66hzRcaUjc7QQWSYvs2FnWdrFRqg==
X-Received: by 2002:a17:903:1252:b0:1c9:e774:58d9 with SMTP id
 u18-20020a170903125200b001c9e77458d9mr19621895plh.34.1698279363686; 
 Wed, 25 Oct 2023 17:16:03 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.16.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:16:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/29] tcg/i386: Add rexw argument to tcg_out_testi
Date: Wed, 25 Oct 2023 17:14:03 -0700
Message-Id: <20231026001542.1141412-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Move up above tcg_out_cmp, where it will be used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 6e8af1fcf6..f4f456a2c0 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1418,6 +1418,19 @@ static void tcg_out_jxx(TCGContext *s, int opc, TCGLabel *l, bool small)
     }
 }
 
+/* Test register R vs immediate bits I, setting Z flag for EQ/NE. */
+static void __attribute__((unused))
+tcg_out_testi(TCGContext *s, TCGReg r, uint32_t i, int rexw)
+{
+    if (i <= 0xff && (TCG_TARGET_REG_BITS == 64 || r < 4)) {
+        tcg_out_modrm(s, OPC_GRP3_Eb | P_REXB_RM, EXT3_TESTi, r);
+        tcg_out8(s, i);
+    } else {
+        tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_TESTi, r);
+        tcg_out32(s, i);
+    }
+}
+
 static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
                        TCGArg arg2, int const_arg2, int rexw)
 {
@@ -1796,23 +1809,6 @@ static void tcg_out_nopn(TCGContext *s, int n)
     tcg_out8(s, 0x90);
 }
 
-/* Test register R vs immediate bits I, setting Z flag for EQ/NE. */
-static void __attribute__((unused))
-tcg_out_testi(TCGContext *s, TCGReg r, uint32_t i)
-{
-    /*
-     * This is used for testing alignment, so we can usually use testb.
-     * For i686, we have to use testl for %esi/%edi.
-     */
-    if (i <= 0xff && (TCG_TARGET_REG_BITS == 64 || r < 4)) {
-        tcg_out_modrm(s, OPC_GRP3_Eb | P_REXB_RM, EXT3_TESTi, r);
-        tcg_out8(s, i);
-    } else {
-        tcg_out_modrm(s, OPC_GRP3_Ev, EXT3_TESTi, r);
-        tcg_out32(s, i);
-    }
-}
-
 typedef struct {
     TCGReg base;
     int index;
@@ -2080,7 +2076,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         ldst->addrlo_reg = addrlo;
         ldst->addrhi_reg = addrhi;
 
-        tcg_out_testi(s, addrlo, a_mask);
+        tcg_out_testi(s, addrlo, a_mask, false);
         /* jne slow_path */
         tcg_out_opc(s, OPC_JCC_long + JCC_JNE, 0, 0, 0);
         ldst->label_ptr[0] = s->code_ptr;
@@ -2229,7 +2225,7 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
             TCGLabel *l1 = gen_new_label();
             TCGLabel *l2 = gen_new_label();
 
-            tcg_out_testi(s, h.base, 15);
+            tcg_out_testi(s, h.base, 15, false);
             tcg_out_jxx(s, JCC_JNE, l1, true);
 
             tcg_out_vex_modrm_sib_offset(s, OPC_MOVDQA_VxWx + h.seg,
@@ -2357,7 +2353,7 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
             TCGLabel *l1 = gen_new_label();
             TCGLabel *l2 = gen_new_label();
 
-            tcg_out_testi(s, h.base, 15);
+            tcg_out_testi(s, h.base, 15, false);
             tcg_out_jxx(s, JCC_JNE, l1, true);
 
             tcg_out_vex_modrm_sib_offset(s, OPC_MOVDQA_WxVx + h.seg,
-- 
2.34.1


