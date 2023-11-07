Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 853937E3422
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:17:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRm-0005CP-3L; Mon, 06 Nov 2023 22:08:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRc-0004my-JV
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:00 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRX-0001PH-2T
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:00 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6ce291b5df9so3299036a34.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326474; x=1699931274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BqrOmKkqtl30h2e5BtDuTy2y2if3xfRJMmzNVZxSj5Y=;
 b=AaAL6KKqNyZ06QTByz4l4OzEWwG6wj0+NPFqf6ruC63RG/gqoMY+LtS81/Bzc2hQ0u
 78KoJdIj94BWm07siSCSYEG9cMjb3wI5yQ92JoNVruC2DALU2OrpNoKLBnakkHyhdOWF
 cfrqvUa6b8ZraI3MkyZcWEzp60t2yvbYRvnabOmRym1AsUXn/94PBqVLy+Y3HCubQ/7C
 X4cfs+1Q/pHHbaq2uPuBuOzWcF2t7VsRd9aVgq8DN5JiFIeu5iMjQAACIV5ThyZKeT/t
 QSVHPZWXOzc5IdljaDG8IRtImKweWvIHRGDr/GGz8vti3YByo/sRcui3Db1tPdsJfRHv
 WEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326474; x=1699931274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BqrOmKkqtl30h2e5BtDuTy2y2if3xfRJMmzNVZxSj5Y=;
 b=OiEqX1zhx76XmHvU23YIW4hQX4HtH7gcIFWCEcLCst1xSlabwJe68pkh5U/gtQ4SQE
 /li4NDA5WZ9LglMIT5jU1DKbVcs5XH7YxnG1ohshhmO8CBFpaan7m9iCP1n1gxMd7LLP
 sX9g5Wg2Ia1S7S/+3BBwHcXWXJTpCP2JT5F3/6xKh6mrIPQ0ZD7Crhp9y5uwktmgfnTw
 qKJVLDLjzDEevRxL67/SK0+lYZg5NvCRz4dOkepGVJErXBMDbhZM9AiY/04IlOMRAt6t
 KL4vHiZ5UwXLLPZ9NNdO873CMx0lx3k4Jkg1ptqYEj0FMD5tHOXWkCzEJkBK2CJkLw+H
 LLaw==
X-Gm-Message-State: AOJu0Yy16b5nXQlLHjbMUUKCg6YY4d1H+TTIKLAOXXbtxeNpCQNH+4Gi
 vm29m5vzl0Iii+J/vxlC9vTYV4kyWWceLSzh61Q=
X-Google-Smtp-Source: AGHT+IE2ylLUn3uGDQ/ARkYHi1vi35mqkLLzNjRPHFNrpZWacQighGmHv+OxeHQ2LVI/bJM8mFJTzg==
X-Received: by 2002:a05:6358:903:b0:168:e737:6b25 with SMTP id
 r3-20020a056358090300b00168e7376b25mr26606385rwi.20.1699326473747; 
 Mon, 06 Nov 2023 19:07:53 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.07.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:07:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 60/85] target/hppa: Replace tcg_gen_*_tl with tcg_gen_*_i64
Date: Mon,  6 Nov 2023 19:03:42 -0800
Message-Id: <20231107030407.8979-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index c8c702ac03..1d749e2a78 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1338,10 +1338,10 @@ static void form_gva(DisasContext *ctx, TCGv_i64 *pgva, TCGv_i64 *pofs,
 
     *pofs = ofs;
     *pgva = addr = tcg_temp_new_i64();
-    tcg_gen_andi_tl(addr, modify <= 0 ? ofs : base, gva_offset_mask(ctx));
+    tcg_gen_andi_i64(addr, modify <= 0 ? ofs : base, gva_offset_mask(ctx));
 #ifndef CONFIG_USER_ONLY
     if (!is_phys) {
-        tcg_gen_or_tl(addr, addr, space_select(ctx, sp, base));
+        tcg_gen_or_i64(addr, addr, space_select(ctx, sp, base));
     }
 #endif
 }
@@ -2382,7 +2382,7 @@ static bool trans_ixtlbxf(DisasContext *ctx, arg_ixtlbxf *a)
                       a->data ? offsetof(CPUHPPAState, cr[CR_IOR])
                       : offsetof(CPUHPPAState, cr[CR_IIAOQ]));
     tcg_gen_shli_i64(stl, stl, 32);
-    tcg_gen_or_tl(addr, atl, stl);
+    tcg_gen_or_i64(addr, atl, stl);
 
     reg = load_gpr(ctx, a->r);
     if (a->addr) {
@@ -2942,7 +2942,7 @@ static bool trans_ldo(DisasContext *ctx, arg_ldo *a)
     TCGv_i64 tcg_rt = dest_gpr(ctx, a->t);
 
     /* Special case rb == 0, for the LDI pseudo-op.
-       The COPY pseudo-op is handled for free within tcg_gen_addi_tl.  */
+       The COPY pseudo-op is handled for free within tcg_gen_addi_i64.  */
     if (a->b == 0) {
         tcg_gen_movi_i64(tcg_rt, a->i);
     } else {
-- 
2.34.1


