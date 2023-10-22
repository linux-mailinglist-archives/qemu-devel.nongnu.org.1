Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 702F37D2714
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:34:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhwk-0004pK-3z; Sun, 22 Oct 2023 19:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwg-0004PK-B5
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:23 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quhwe-0007XG-JL
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:33:22 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6b1d1099a84so2605492b3a.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017597; x=1698622397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j1vqtRlkCqaDcb/kXrGcCaBvm9nhjd4rh5ZlSJ0/mC8=;
 b=MaOqAl9B9wXeeaYyaiMMK8o6YkJWgwee2DQ5wWgn6KmDoU1ncSb109nBYlyGcwNjjo
 aGB3MBJztWmZ8m/gvUWdKlLIF73p5visEAk3uUFFpaaSUkXR+TaN8sJ2fbnCq5OTGJ1t
 xjzHt9AyVSYu8MF3NhT1J0XXZFiuas3XUqDM/nyypAFVC848BniQQE6hE+wGVEnl/cPg
 xPuZ68uOtiuxvzs2NKTLxVhQP9zWLFg0pPGag7+RqSJN4DFDs+OAEhdethSm3qkb8zv3
 2tmNvmPMognZKn3bUoUMGUweMLIShQPxgH0eDZXaU0Sh0N5fUYjyugob0SpwznGqqbQV
 o4Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017597; x=1698622397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j1vqtRlkCqaDcb/kXrGcCaBvm9nhjd4rh5ZlSJ0/mC8=;
 b=En512B55747eeoZcm5GCIvSPlgjRFky6BNNTOOkOF3ZEINm8z5I/MvGTBSoEGW+1yY
 4Cf/2ndDji66M0D+31WyVuTYwndezZWlRQn+2jKWqT6sy0MZvzlXyEBS6KwXhbQicn/a
 hstFZ9jUIizhptcJG5Aj+5w3ZQEGhkMHa1O6rQSvxiQo0DbZwR8Ft96PqW+QjnWqhPR2
 9kaAFFzSVEWfuKFMiqjGsRkrWpW26qaBHs4CPZKBuykqH2U3yspxK2kiejsG2/XkSSxA
 hyGEw1dP+wDzxE+akItopiOpvTDg3bXN82neW/1hBs/n98cJgQaySonSnVTHmFenGMFs
 CpAA==
X-Gm-Message-State: AOJu0Yz9GPBDvMqapEYbtj42CxW9suxBG7taWku4knhKZ8jwIhXP+7Og
 dxz4MPbpPumJazK6klt+uQMTiVSEKj7hU7sKvVo=
X-Google-Smtp-Source: AGHT+IG/OhuoxvIq9PldaqHI7Z9abVBmtFxqZRqUUeMHwgCXnnKPn/HnHemAwCgD5wfVi+cdo70lYA==
X-Received: by 2002:aa7:8889:0:b0:6be:59f:5172 with SMTP id
 z9-20020aa78889000000b006be059f5172mr8611313pfe.19.1698017597701; 
 Sun, 22 Oct 2023 16:33:17 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fe12-20020a056a002f0c00b0066a4e561beesm5182855pfb.173.2023.10.22.16.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:33:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 51/94] target/sparc: Use tcg_gen_qemu_{ld,
 st}_i128 for GET_ASI_DTWINX
Date: Sun, 22 Oct 2023 16:28:49 -0700
Message-Id: <20231022232932.80507-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Perform one atomic 16-byte operation.
The atomicity is required for the LDTXA instructions.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 48 +++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f4dde20ff8..83c344365c 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2594,11 +2594,27 @@ static void gen_ldda_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
         return;
 
     case GET_ASI_DTWINX:
-        assert(TARGET_LONG_BITS == 64);
-        tcg_gen_qemu_ld_tl(hi, addr, da->mem_idx, da->memop | MO_ALIGN_16);
-        tcg_gen_addi_tl(addr, addr, 8);
-        tcg_gen_qemu_ld_tl(lo, addr, da->mem_idx, da->memop);
+#ifdef TARGET_SPARC64
+        {
+            MemOp mop = (da->memop & MO_BSWAP) | MO_128 | MO_ALIGN_16;
+            TCGv_i128 t = tcg_temp_new_i128();
+
+            tcg_gen_qemu_ld_i128(t, addr, da->mem_idx, mop);
+            /*
+             * Note that LE twinx acts as if each 64-bit register result is
+             * byte swapped.  We perform one 128-bit LE load, so must swap
+             * the order of the writebacks.
+             */
+            if ((mop & MO_BSWAP) == MO_TE) {
+                tcg_gen_extr_i128_i64(lo, hi, t);
+            } else {
+                tcg_gen_extr_i128_i64(hi, lo, t);
+            }
+        }
         break;
+#else
+        g_assert_not_reached();
+#endif
 
     case GET_ASI_DIRECT:
         {
@@ -2663,11 +2679,27 @@ static void gen_stda_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
         break;
 
     case GET_ASI_DTWINX:
-        assert(TARGET_LONG_BITS == 64);
-        tcg_gen_qemu_st_tl(hi, addr, da->mem_idx, da->memop | MO_ALIGN_16);
-        tcg_gen_addi_tl(addr, addr, 8);
-        tcg_gen_qemu_st_tl(lo, addr, da->mem_idx, da->memop);
+#ifdef TARGET_SPARC64
+        {
+            MemOp mop = (da->memop & MO_BSWAP) | MO_128 | MO_ALIGN_16;
+            TCGv_i128 t = tcg_temp_new_i128();
+
+            /*
+             * Note that LE twinx acts as if each 64-bit register result is
+             * byte swapped.  We perform one 128-bit LE store, so must swap
+             * the order of the construction.
+             */
+            if ((mop & MO_BSWAP) == MO_TE) {
+                tcg_gen_concat_i64_i128(t, lo, hi);
+            } else {
+                tcg_gen_concat_i64_i128(t, hi, lo);
+            }
+            tcg_gen_qemu_st_i128(t, addr, da->mem_idx, mop);
+        }
         break;
+#else
+        g_assert_not_reached();
+#endif
 
     case GET_ASI_DIRECT:
         {
-- 
2.34.1


