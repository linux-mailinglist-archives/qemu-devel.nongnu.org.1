Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C935A78E4E1
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 04:58:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbXsJ-0004te-IA; Wed, 30 Aug 2023 22:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbXsH-0004sZ-Fw
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 22:57:37 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbXsE-0007oX-Mx
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 22:57:37 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-26d49cf1811so248524a91.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 19:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693450653; x=1694055453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=35LeKOF1XNerGikRaTSmAIP+dLZWVrcFdHv/rNI8hAg=;
 b=dKj0+Cf8NExkGYwOr+RPHT9jfUYApNaLkFvQXXJS+GyPP/6bKe7CNrJ2soSfAOWeQk
 9K78uceyVeUnP264tqldXSNSv2Jpw3Y6V88rzex3J7JQPRLwQeDPFbJVdjLiI/DRxAxs
 51oV7+dbZIMkKVmh0eimzXfUL/ceGzh1AvfPajJmnsH8A8h7XjlICJAwvljmJN71tOV7
 Ok2lJkbonsXeuUsVI0mGDIVx6KKkupmh4f23tui1VnoPvAHwlUM5Sy5DuVt3JMOAtWcH
 yxnitxgz5LDkeAfD5+uGwXezWrc7K3GkpBBDU/N7ZmOuckb8QEmhuJ1OS4IXVK2V/ND1
 XATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693450653; x=1694055453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=35LeKOF1XNerGikRaTSmAIP+dLZWVrcFdHv/rNI8hAg=;
 b=iKK5rGAvJzDIVS5zOamXmRZ17Zzvt3xgiskNrV5m8xjD97kx1ur8wp/GRiCBGw39Z9
 ciGGTD1COFRcm3RaL50WFrvT59eXvY8K2n2sBOXvWYvx7UjZi4JC5fNLDxJArZr2G6cP
 9J3v4E8JoGBM3hFjyw5OKhqzjmKcdP+RczUuSqoZ0H6NnflHIVUW1UwFI+pW50U8KWRD
 oZa5/SgOpX9JQor0TTvB0fIkskqskZXIvXqqNC0HiEhJrDfc7oGMonco7RrkY296zUs3
 8NgGNyPXT5s2o1uxE6EkLbKblll0Y2dNEvTTphmhchqsGuUwrdrHdGfeivWTRZ8jr31F
 CaEQ==
X-Gm-Message-State: AOJu0YxNYtOh/DkWfITA/Xql6XXTqaIudK3xadmmvhiX5syHxlfo/k12
 kMMYjnpCTtYESVhOCwTPFe/+1ZreJ1FoNjLwRAA=
X-Google-Smtp-Source: AGHT+IH3m2yEISTzGm8ssH2uBpXOqtW7dnwRUjVBRnXBMiKGcuUcYAm3ESQLFu5mHjI8huDmcQedLA==
X-Received: by 2002:a17:90a:304a:b0:269:4645:80b9 with SMTP id
 q10-20020a17090a304a00b00269464580b9mr3920052pjl.2.1693450653223; 
 Wed, 30 Aug 2023 19:57:33 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 dw24-20020a17090b095800b00265c742a262sm288142pjb.4.2023.08.30.19.57.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 19:57:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/4] tcg/optimize: Pipe OptContext into reset_ts
Date: Wed, 30 Aug 2023 19:57:27 -0700
Message-Id: <20230831025729.1194388-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831025729.1194388-1-richard.henderson@linaro.org>
References: <20230831025729.1194388-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Will be needed in the next patch.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 3013eb04e6..f00db3aa38 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -123,7 +123,7 @@ static inline bool ts_is_copy(TCGTemp *ts)
 }
 
 /* Reset TEMP's state, possibly removing the temp for the list of copies.  */
-static void reset_ts(TCGTemp *ts)
+static void reset_ts(OptContext *ctx, TCGTemp *ts)
 {
     TempOptInfo *ti = ts_info(ts);
     TempOptInfo *pi = ts_info(ti->prev_copy);
@@ -138,9 +138,9 @@ static void reset_ts(TCGTemp *ts)
     ti->s_mask = 0;
 }
 
-static void reset_temp(TCGArg arg)
+static void reset_temp(OptContext *ctx, TCGArg arg)
 {
-    reset_ts(arg_temp(arg));
+    reset_ts(ctx, arg_temp(arg));
 }
 
 /* Initialize and activate a temporary.  */
@@ -239,7 +239,7 @@ static bool tcg_opt_gen_mov(OptContext *ctx, TCGOp *op, TCGArg dst, TCGArg src)
         return true;
     }
 
-    reset_ts(dst_ts);
+    reset_ts(ctx, dst_ts);
     di = ts_info(dst_ts);
     si = ts_info(src_ts);
 
@@ -700,7 +700,7 @@ static void finish_folding(OptContext *ctx, TCGOp *op)
     nb_oargs = def->nb_oargs;
     for (i = 0; i < nb_oargs; i++) {
         TCGTemp *ts = arg_temp(op->args[i]);
-        reset_ts(ts);
+        reset_ts(ctx, ts);
         /*
          * Save the corresponding known-zero/sign bits mask for the
          * first output argument (only one supported so far).
@@ -1213,14 +1213,14 @@ static bool fold_call(OptContext *ctx, TCGOp *op)
 
         for (i = 0; i < nb_globals; i++) {
             if (test_bit(i, ctx->temps_used.l)) {
-                reset_ts(&ctx->tcg->temps[i]);
+                reset_ts(ctx, &ctx->tcg->temps[i]);
             }
         }
     }
 
     /* Reset temp data for outputs. */
     for (i = 0; i < nb_oargs; i++) {
-        reset_temp(op->args[i]);
+        reset_temp(ctx, op->args[i]);
     }
 
     /* Stop optimizing MB across calls. */
-- 
2.34.1


