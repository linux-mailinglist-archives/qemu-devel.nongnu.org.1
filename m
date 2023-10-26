Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09DC07D7991
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:35:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo9T-0000zN-H5; Wed, 25 Oct 2023 20:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9I-0008Se-CN
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:22:58 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo9E-0008AN-IS
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:22:55 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-565e54cb93aso302053a12.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279770; x=1698884570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tug4Ye+ri5yZyV+52Sfq/q/Jg8MaYnVtboKHbVUVRBc=;
 b=yfpkQYwD5jONLqy3Kn/qYAi4ubnQIHrSiPYdIyMWF8SnER6xi34QAFIpYT+tj8kasf
 2Y+hG3JnOAJXeytET9cTdXEt7ZcTiEvadDIxVn/6S4/RY5RxKUw2bJ++4i4316FmMze9
 5UWoNhElTz1Z8pJDhJZbu1elAT3pTT0+8rEmU3JZvIizgHgUG13Ifym8WA+XSPiaxGFM
 WOT+8VYAaijdZy5dezeCllVOkTRzNIMBeOcfx1jmMByGsIngAw7wWf/wUC049ttadGQq
 IMbK27JvwQYal7MIeESd80PCyx6J9Cy2e3LE+Ed2JlI8G9qbLq25wrUiokOHuheU195i
 q0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279770; x=1698884570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tug4Ye+ri5yZyV+52Sfq/q/Jg8MaYnVtboKHbVUVRBc=;
 b=jfnj+aZKH+54n17n+lO2k1uLR0qaxfvqBOHinMfYDxiVa9p40CJfn9gC8E6/UB0OvJ
 LdQ6j1E9L/h+R5VTJBUxQ/Ls+Vr9ejUEAO5KCdKWJmQSwoa3+qFBLSItdcOqG9BCY0Wp
 C8qoRmQ2lwQqR5kK9kHLFVobFzPHpKhkvW/cpXoBPZfQ7ZtonH0/7j5remw4+Ek2F4q7
 3vgUqe0eIyT4UZTpPW9QJ445u3fWOtZa85mtSEufhBEQKeWc03YyN8O53qgpqwvgApHT
 szHaAFQgNk3nEjtLIi/CK1Mus2HD3YCRY5OXhNHkraFsCc3NC5sdPRInPhw2ajQT7EV3
 p5Aw==
X-Gm-Message-State: AOJu0YyGd50kfb7YGf7/zfZIBPmTF8KL8dZa0iRSKosY2T4BN8fOtzIn
 pma8YRHc1lH7b7ze3z2t24Elviq1BX0LvCX9b+U=
X-Google-Smtp-Source: AGHT+IEyI1ZAC5xTUehm1hdRWSoeXC2ufT8fXYTsUPlOmHQ4DYn11bSGyVWV+jigm/qia6z6jTD4nA==
X-Received: by 2002:a17:90b:4a8f:b0:27d:b885:17f2 with SMTP id
 lp15-20020a17090b4a8f00b0027db88517f2mr13526115pjb.30.1698279770446; 
 Wed, 25 Oct 2023 17:22:50 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 9-20020a17090a0cc900b0027463889e72sm499870pjt.55.2023.10.25.17.22.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:22:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 51/94] target/sparc: Use tcg_gen_qemu_{ld,
 st}_i128 for GET_ASI_DTWINX
Date: Wed, 25 Oct 2023 17:14:59 -0700
Message-Id: <20231026001542.1141412-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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
index e24945e50e..7ce9ab66c6 100644
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


