Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6B577E47C
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 17:01:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWHwF-0006P1-5J; Wed, 16 Aug 2023 10:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWHwB-0006Hq-1D
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:55:55 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWHw8-0002Pr-K6
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:55:54 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-688779ffc0aso1062368b3a.3
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 07:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692197751; x=1692802551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eLqc+muX+VxtGt3ZBxBFdZ8gS0mNGlK6AnuAMXtjhV4=;
 b=I7tGdf4weuFFw93UmIFEABJA/nrvxFFvlTHmB8Equk8ZvGdJtjbSgQIjodMnBGvWSH
 72HrnSofyrrwbtCf0y0RvRmT3J5oeh7fR/k2zPQ39rZ5x1KasAwk4SXIfairj4gkY2H7
 FTOt68q643xijyJ8JHSB4m3ZMaAe5B0HPw98MHBexp9W3K88IXf0whOiIuAQaS7PorjL
 K5aAcegM6rMGzHcptqghK7J2EHjOtNx6BYZpZ707pIlBdh0SfK9pUJA8geuCEJLI+zBf
 EdqClqyVh6U7SD4dKJOAtUpE53+fMo0lW8aqBoE8v2Awh/3uvx/8bjljOKdV6jKpZcRS
 8E5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692197751; x=1692802551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eLqc+muX+VxtGt3ZBxBFdZ8gS0mNGlK6AnuAMXtjhV4=;
 b=ZsZtFBcXBeQG2+L+AUxvH0RpNou/4iqqqvv4/Dy4qJf6TkUoc8nseYMpTyqkfv/irL
 MKmRwXbuxqHyfMZlm8VLiBsAS9LHubjYNDj+AsXg4kXMZ4bEn2ZoAbLIxRTbup+9S/ay
 96qj9ANHv/mBWtBkJwC8hHppVJR15bBF1NPp9wcrbciRK0zlwNhyYdvYHqXFwGKdYSAl
 h0BNuETDom5H47blV9510jvgAjmzvYJF/RNMGXGKReLKlWWvjUwZXZVM+cQ8JlbUsZcJ
 9yJIVp6JEpIb2ceI5Sj1l/KOzbOYBXvdgb36r8WDRmYTHK/2HsK+DBdLK6vlLFIM3gHv
 JJcA==
X-Gm-Message-State: AOJu0YxqDqYIQH9hX2tfLknZZVDem0Yd8a7jmMYNVDLehtmVJ1x3q3qe
 BhSzfXki0x3y72UyOQhh3wuC6FX+5pPVB7GbFmU=
X-Google-Smtp-Source: AGHT+IGYEAmlNzYXb1QRKpXDS4bKt/C42HXNu+h2FDooam1Rl5Kc4mfCT97Ril1Ljx1mlYIvNJsC9A==
X-Received: by 2002:a05:6a00:16c2:b0:688:94da:8aa1 with SMTP id
 l2-20020a056a0016c200b0068894da8aa1mr1361301pfc.29.1692197751306; 
 Wed, 16 Aug 2023 07:55:51 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 fe22-20020a056a002f1600b00682a0184742sm11619069pfb.148.2023.08.16.07.55.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 07:55:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] tcg: Fold deposit with zero to and
Date: Wed, 16 Aug 2023 07:55:46 -0700
Message-Id: <20230816145547.477974-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816145547.477974-1-richard.henderson@linaro.org>
References: <20230816145547.477974-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Inserting a zero into a value, or inserting a value
into zero at offset 0 my be implemented with AND.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index d2156367a3..956114b631 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1279,6 +1279,8 @@ static bool fold_ctpop(OptContext *ctx, TCGOp *op)
 
 static bool fold_deposit(OptContext *ctx, TCGOp *op)
 {
+    TCGOpcode and_opc;
+
     if (arg_is_const(op->args[1]) && arg_is_const(op->args[2])) {
         uint64_t t1 = arg_info(op->args[1])->val;
         uint64_t t2 = arg_info(op->args[2])->val;
@@ -1287,6 +1289,39 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
         return tcg_opt_gen_movi(ctx, op, op->args[0], t1);
     }
 
+    switch (ctx->type) {
+    case TCG_TYPE_I32:
+        and_opc = INDEX_op_and_i32;
+        break;
+    case TCG_TYPE_I64:
+        and_opc = INDEX_op_and_i64;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (arg_is_const(op->args[1])
+        && arg_info(op->args[1])->val == 0
+        && op->args[3] == 0) {
+        uint64_t mask = MAKE_64BIT_MASK(0, op->args[4]);
+
+        op->opc = and_opc;
+        op->args[1] = op->args[2];
+        op->args[2] = temp_arg(tcg_constant_internal(ctx->type, mask));
+        ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
+        return false;
+    }
+
+    if (arg_is_const(op->args[2])
+        && arg_info(op->args[2])->val == 0) {
+        uint64_t mask = deposit64(-1, op->args[3], op->args[4], 0);
+
+        op->opc = and_opc;
+        op->args[2] = temp_arg(tcg_constant_internal(ctx->type, mask));
+        ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
+        return false;
+    }
+
     ctx->z_mask = deposit64(arg_info(op->args[1])->z_mask,
                             op->args[3], op->args[4],
                             arg_info(op->args[2])->z_mask);
-- 
2.34.1


