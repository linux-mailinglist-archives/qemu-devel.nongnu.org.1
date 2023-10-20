Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7FC7D1787
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:51:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwLt-0007pO-NI; Fri, 20 Oct 2023 16:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLU-0007jP-Du
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:51 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLS-0008AD-Lt
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:48 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6b709048f32so1136118b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834623; x=1698439423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+3Cca9a0dUfxOMmsrbDZSCnt4BuRnsfCclCPiSMy9B8=;
 b=ikUtBKj+/5QIBQ8z8gMQcGNZow41MD5jPJqIkK00UwMACNaeEoPlkWGsbP1qvW0R1+
 eKDze6xwHSKC0cnUq+OA1KWzV9VdcKBgdzolDMYyBUDFnz/kGbIU1FP1pIyEJQ4BUH31
 qiFT079IDJQAYAQEVdgpIvxPxB4Yl9SUnwP/W0+zZQki+wBS8p/xI6netdKDC3Z95USg
 zfnepvNpI++tdsVja3MpY8o1HFOc/Zt2uKw0OABYLRiszFpJVwFKCDu0SKNupnnj9kCD
 CCRRjrugcl7qsQXDUK+Q8XIu05Hf7Ya5yykQaLCprwPoLhqnc8URvWIPDT8mHYGI8ulj
 8YFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834623; x=1698439423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+3Cca9a0dUfxOMmsrbDZSCnt4BuRnsfCclCPiSMy9B8=;
 b=OSQrE1FEt3RLkI0KpiahwcDy1hxv3ULcI2ObInVug3gkFmIk2zGD1hkg5em3IwXpuW
 juKGF+HQrnVZXb1IeUk7rmusca5z3Y0Kqhc7XbJJ1GC8pzEXFb1IOWyvdVta9HO3xMHm
 b9vqoZqSBj/U+ldoQf7Qs2kc+8Fo0yjpx2lz1k/1qcN87Lw/j0QT9JEj6dvWIZWcz8VW
 MmdoHR7u0m+76F/cWry1xKYHuFCjaZZ0meM4DD15suKxcqRfKg/9Za5QgyIXyVhdmtE3
 SAevbDZNkiw2GHLmFI3iO5v7+eMO7FGKqpeMO8Lgk+UY092OhNupQ7+0UjRts8rOL6Qt
 iooQ==
X-Gm-Message-State: AOJu0YwAEzEqeOlKLec8fuV35z7yIPbU8iqXN2ov1F3sCUJ/f9EtDGCc
 NRFJS6DGVE1IQyBFMDkmtIJl9P7vwsx6Cv4IRBE=
X-Google-Smtp-Source: AGHT+IEgHVms0FprHai/z+q6cUO5mRdGHx2R5gxSBQlvfFv2K9sKW8seRJhEmG+9aqNPyUQKAn8tpw==
X-Received: by 2002:a05:6a20:4924:b0:14c:5dc3:f1c9 with SMTP id
 ft36-20020a056a20492400b0014c5dc3f1c9mr2380653pzb.49.1697834623353; 
 Fri, 20 Oct 2023 13:43:43 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 11/65] target/hppa: Fix bb_sar for hppa64
Date: Fri, 20 Oct 2023 13:42:37 -0700
Message-Id: <20231020204331.139847-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
 target/hppa/translate.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 8ebe7523a7..119422870c 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3073,14 +3073,21 @@ static bool trans_bb_sar(DisasContext *ctx, arg_bb_sar *a)
 {
     TCGv_reg tmp, tcg_r;
     DisasCond cond;
+    bool d = false;
 
     nullify_over(ctx);
 
     tmp = tcg_temp_new();
     tcg_r = load_gpr(ctx, a->r);
-    tcg_gen_shl_reg(tmp, tcg_r, cpu_sar);
+    if (cond_need_ext(ctx, d)) {
+        /* Force shift into [32,63] */
+        tcg_gen_ori_reg(tmp, cpu_sar, 32);
+        tcg_gen_shl_reg(tmp, tcg_r, tmp);
+    } else {
+        tcg_gen_shl_reg(tmp, tcg_r, cpu_sar);
+    }
 
-    cond = cond_make_0(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);
+    cond = cond_make_0_tmp(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);
     return do_cbranch(ctx, a->disp, a->n, &cond);
 }
 
@@ -3088,12 +3095,15 @@ static bool trans_bb_imm(DisasContext *ctx, arg_bb_imm *a)
 {
     TCGv_reg tmp, tcg_r;
     DisasCond cond;
+    bool d = false;
+    int p;
 
     nullify_over(ctx);
 
     tmp = tcg_temp_new();
     tcg_r = load_gpr(ctx, a->r);
-    tcg_gen_shli_reg(tmp, tcg_r, a->p);
+    p = a->p | (cond_need_ext(ctx, d) ? 32 : 0);
+    tcg_gen_shli_reg(tmp, tcg_r, p);
 
     cond = cond_make_0(a->c ? TCG_COND_GE : TCG_COND_LT, tmp);
     return do_cbranch(ctx, a->disp, a->n, &cond);
-- 
2.34.1


